#! /bin/bash
counter=0
while [ $counter -lt 20 ]
do
export some_val=`gcloud deploy rollouts describe release-0515-0845-to-dev-0001 --release=release-0515-0845 --delivery-pipeline=robot-shop-gcp --region=us-central1 | grep state: | cut -f2 -d: | cut -d' ' -f2`
if [ "$some_val" == "IN_PROGRESS" ]
then
	echo "Deployment in Progress Time is: `date`"
    sleep 30
    continue
elif [ "$some_val" == "SUCCEEDED" ]
then
	echo "Deployment is Succeeded Time is: `date`	"
    exit 0
else
	echo "Deployment Failed Time is: `date`"
    exit 1
fi
counter=$(( $counter + 1))
done