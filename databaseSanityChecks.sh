#!/bin/sh

#
# Wrapper script to run the database sanity checks.
#

cd `dirname $0`
DIR=`pwd`

. ./Configuration

#
# Initialize the log and report files.
#
LOG_FILE=${LOGDIR}/database_sanity.log
DATABASE_RPT=${RPTDIR}/database_sanity.rpt
rm -f ${LOG_FILE} ${DATABASE_RPT}
touch ${LOG_FILE} ${DATABASE_RPT}

echo `date`: Start sanity checks >> ${LOG_FILE}

#
# Run each SQL script in the database sanity check directory and append the
# output to the database sanity report.
#
echo "Report generated from: ${PG_DBSERVER}.${PG_DBNAME}" >> ${DATABASE_RPT}
cd ${DIR}/scripts_database
for i in *.sql
do
    echo `date`: $i >> ${LOG_FILE}
    ${PSQL_EXEC} -q -h ${PG_DBSERVER} -d ${PG_DBNAME} -U ${PG_DBUSER} -f $i >> ${DATABASE_RPT}
done

#
# If any of the queries returned any rows, there is a potential data issue.
# Set the subject of the email based on whether there is an problem.
#
COUNT=`cat ${DATABASE_RPT} | grep "^(.*row.*)" | grep -v "(0 rows)" | wc -l`
if [ ${COUNT} -eq 0 ]
then
    SUBJECT="Database Sanity Report (Successful)"
    RC=0
else
    SUBJECT="Database Sanity Report (Warning)"
    RC=1
fi

#
# Send the report to everyone defined in the email list.
#
if [ "${EMAIL_LIST}" != "" ]
then
     cat ${DATABASE_RPT} | mailx -s "${SUBJECT}" ${EMAIL_LIST}
fi

echo `date`: End sanity checks >> ${LOG_FILE}

exit ${RC}
