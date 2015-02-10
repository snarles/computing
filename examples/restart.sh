bash /root/py27.sh
pssh -h /root/spark-ec2/slaves bash py27.sh
export IPYTHON_OPTS="notebook --pylab inline --profile=nbserver"
bash /root/spark/sbin/stop-all.sh &
echo "Paused (1)"
read lala
bash /root/spark/sbin/start-all.sh
echo "Paused (2)"
read lala
bash /root/spark/bin/pyspark
