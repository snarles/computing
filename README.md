# computing

Computing stuff

OS: Ubuntu 14.04 LTS
Memory: 7.8 GiB
Processor: Intel Core i7-2600 CPU @ 3.40 GHz x 8
Graphics: VESA; CAICOS
OS-type: 64-bit
Disk: 483.7 GB

Installing stuff

sudo apt-get install openjdk-6-jre openjdk-7-jre openjdk-6-jdk openjdk-7-jdk

** instructions from: http://blog.prabeeshk.com/blog/2014/10/31/install-apache-spark-on-ubuntu-14-dot-04/
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer


sudo mkdir /usr/local/src/scala
cd /usr/local/src/scala
sudo wget http://www.scala-lang.org/files/archive/scala-2.10.4.tgz
sudo tar xvf scala-2.10.4.tgz

cd ~/
sudo echo export SCALA_HOME=/usr/local/src/scala/scala-2.10.4 >> .bashrc
sudo echo export PATH=\$SCALA_HOME/bin:\$PATH >> .bashrc
. .bashrc
scala -version

cd ~/computing
wget http://mirrors.ibiblio.org/apache/spark/spark-1.1.0/spark-1.1.0.tgz
tar xvf spark-1.1.0.tgz 

cd spark-1.1.0
sbt/sbt assembly
"Test"
./bin/run-example SparkPi 10

## running an example in python

snarles@snarles-OptiPlex-990:~/computing$ IPYTHON_OPTS="notebook" ./spark-1.1.0/bin/pyspark

## do the same on amazon

Check disk usage:
df -ah

Installation list:

sudo apt-add-repository -y ppa:webupd8team/java
sudo apt-get -y update
sudo apt-get -y install oracle-java7-installer build-essential libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose emacs24 git awscli
sudo mkdir /usr/local/src/scala
cd /usr/local/src/scala
sudo wget http://www.scala-lang.org/files/archive/scala-2.10.4.tgz
sudo tar xvf scala-2.10.4.tgz
cd ~/
sudo echo export SCALA_HOME=/usr/local/src/scala/scala-2.10.4 >> .bashrc
sudo echo export PATH=\$SCALA_HOME/bin:\$PATH >> .bashrc
. .bashrc
scala -version
wget http://mirrors.ibiblio.org/apache/spark/spark-1.1.0/spark-1.1.0.tgz
tar xvf spark-1.1.0.tgz 
cd spark-1.1.0
sbt/sbt assembly

## test S3

aws s3 cp s3://braindatatest/all_b1000_1_bvecs.csv all_b1000_1_bvecs.csv

aws s3 cp s3://braindatatest/all_b1000_1_data.csv all_b1000_1_data.csv

### install X forwarding

sudo apt-get install xauth x11-apps firefox -y

## deploy spark on a private cluster

IP addresses (temporary)

ssh -i HomePair.pem ubuntu@54.191.255.115 -Y
ssh -i HomePair.pem ubuntu@54.191.200.81 -Y
ssh -i HomePair.pem ubuntu@54.200.5.186 -Y
ssh -i HomePair.pem ubuntu@54.187.62.181 -Y

ubuntu@ip-172-31-12-177:
./spark-1.1.0/sbin/start-master.sh
####  starting org.apache.spark.deploy.master.Master, logging to /home/ubuntu/spark-1.1.0/sbin/../logs/spark-ubuntu-org.apache.spark.deploy.master.Master-1-ip-172-31-12-177.out
echo localhost > spark-1.1.0/conf/slaves
echo ubuntu@54.191.200.81 >> spark-1.1.0/conf/slaves
echo ubuntu@54.200.5.186 >> spark-1.1.0/conf/slaves
echo ubuntu@54.187.62.181 >> spark-1.1.0/conf/slaves
more spark-1.1.0/conf/slaves

./spark-1.1.0/sbin/start-slaves.sh

http://localhost:8080
"Spark Master at spark://ip-172-31-12-177:7077 "

####ubuntu@ip-172-31-12-177:~/Downloads$ ssh-add HomePair.pem 
####Could not open a connection to your authentication agent.

## Just use script

./spark-ec2 -k HomePair -i ~/Downloads/HomePair.pem -s 3 --region=us-west-2 launch AutoSpark
./spark-ec2 -k HomePair -i ~/Downloads/HomePair.pem --region=us-west-2 login AutoSpark

spark://ec2-54-200-61-40.us-west-2.compute.amazonaws.com:7077

./spark-ec2 stop AutoSpark --region=us-west-2
./spark-ec2 -i ~/Downloads/HomePair.pem start AutoSpark --region=us-west-2

## connect remotely

./bin/pyspark --master spark://ec2-54-200-61-40.us-west-2.compute.amazonaws.com:7077
data = [1, 2, 3, 4, 5]
distData = sc.parallelize(data)
ans =  distData.reduce(lambda a, b: a + b)

./run spark.examples.GroupByTest spark://ec2-54-200-61-40.us-west-2.compute.amazonaws.com:7077

## installing spark R

### https://github.com/amplab-extras/SparkR-pkg/wiki/SparkR-on-EC2


#### /usr/bin/ld: cannot find -ljvm
cd /root
wget http://cran.cnr.berkeley.edu/src/contrib/rJava_0.9-6.tar.gz
tar xvzf rJava_0.9-6.tar.gz
R CMD javareconf
R CMD INSTALL rJava
R CMD javareconf

/root/spark-ec2/copy-dir rJava_0.9-6.tar.gz
/root/spark/sbin/slaves.sh R CMD javareconf
/root/spark/sbin/slaves.sh R CMD INSTALL ~/rJava_0.9-6.tar.gz

cd /root
git clone https://github.com/amplab-extras/SparkR-pkg.git
cd SparkR-pkg
./install-dev.sh
/root/spark-ec2/copy-dir /root/SparkR-pkg

cat /root/spark-ec2/cluster-url
MASTER=spark://<master_hostname>:7077 ./sparkR




