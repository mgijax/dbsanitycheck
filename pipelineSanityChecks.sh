#!/bin/sh

#
# Wrapper script to run the pipeline sanity checks.
#

cd `dirname $0`
DIR=`pwd`

. ./Configuration

#
# Initialize the log and report files.
#
LOG_FILE=${LOGDIR}/pipeline_sanity.log
PIPELINE_RPT=${RPTDIR}/pipeline_sanity.rpt
rm -f ${LOG_FILE} ${PIPELINE_RPT}
touch ${LOG_FILE} ${PIPELINE_RPT}

echo `date`: Start sanity checks >> ${LOG_FILE}

#
# Run each SQL script in the pipeline sanity check directory and append the
# output to the pipeline sanity report.
#
echo "Report generated from: ${PG_DBSERVER}.${PG_DBNAME}" >> ${PIPELINE_RPT}
cd ${DIR}/scripts_pipeline
for i in *.sql
do
    echo `date`: $i >> ${LOG_FILE}
    ${PSQL_EXEC} -q -h ${PG_DBSERVER} -d ${PG_DBNAME} -U ${PG_DBUSER} -f $i >> ${PIPELINE_RPT}
done

#
# If any of the queries returned any rows, there is a potential data issue.
# Set the subject of the email based on whether there is an problem.
#
COUNT=`cat ${PIPELINE_RPT} | grep "^(.*row.*)" | grep -v "(0 rows)" | wc -l`
if [ ${COUNT} -eq 0 ]
then
    SUBJECT="Pipeline Sanity Report (Successful)"
    RC=0
else
    SUBJECT="Pipeline Sanity Report (Failed)"
    RC=1
fi

#
# Send the report to everyone defined in the email list.
#
if [ "${EMAIL_LIST}" != "" ]
then
     cat ${PIPELINE_RPT} | mailx -s "${SUBJECT}" ${EMAIL_LIST}
fi

echo `date`: End sanity checks >> ${LOG_FILE}

exit ${RC}
