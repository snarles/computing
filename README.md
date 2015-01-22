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

vi .bashrc
"And add following in the end of the file"
export SCALA_HOME=/usr/local/src/scala/scala-2.10.4
export PATH=$SCALA_HOME/bin:$PATH
. .bashrc
scala -version

cd ~/computing
wget http://mirrors.ibiblio.org/apache/spark/spark-1.1.0/spark-1.1.0.tgz
tar xvf spark-1.1.0.tgz 

cd spark-1.1.0
sbt/sbt assembly
"Test"
./bin/run-example SparkPi 10

# running an example in python

snarles@snarles-OptiPlex-990:~/computing$ IPYTHON_OPTS="notebook" ./spark-1.1.0/bin/pyspark

