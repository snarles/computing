bash /root/py27.sh
pssh -h /root/spark-ec2/slaves bash py27.sh
export IPYTHON_OPTS="notebook --pylab inline --ip=* --port=8888"
bash /root/spark/sbin/stop-all.sh
bash /root/spark/sbin/start-all.sh
bash /root/spark/bin/pyspark
