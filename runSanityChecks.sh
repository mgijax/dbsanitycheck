#!/bin/sh

#
# Wrapper script to run the sanity checks.
#

cd `dirname $0`
. ./Configuration

#
# Initialize the log and report files.
#
LOG_FILE=${LOGDIR}/dbsanity.log
RPT_FILE=${RPTDIR}/dbsanity.rpt
rm -f ${LOG_FILE} ${RPT_FILE}
touch ${LOG_FILE} ${RPT_FILE}

echo `date`: Start sanity checks >> ${LOG_FILE}

#
# Run each SQL script and append the output to the report.
#
cd scripts
for i in *.sql
do
    echo `date`: $i >> ${LOG_FILE}
    ${PSQL_EXEC} -q -h ${PG_DBSERVER} -d ${PG_DBNAME} -U ${PG_DBUSER} -f $i >> ${RPT_FILE}
done

#
# If any of the queries returned any rows, there is a potential data issue.
# Set the subject of the email based on whether there is an problem.
#
COUNT=`cat ${RPT_FILE} | grep "(.*rows)" | grep -v "(0 rows)" | wc -l`
if [ ${COUNT} -eq 0 ]
then
    SUBJECT="Database Sanity Report"
else
    SUBJECT="Database Sanity Report (Warning)"
fi

#
# Send the report to everyone defined in the email list.
#
if [ "${EMAIL_LIST}" != "" ]
then
     cat ${RPT_FILE} | mailx -s "${SUBJECT}" ${EMAIL_LIST}
fi

echo `date`: End sanity checks >> ${LOG_FILE}
