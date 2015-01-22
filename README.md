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
sudo echo export PATH=$SCALA_HOME/bin:$PATH >> .bashrc
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

# do the same on amazon

Check disk usage:
df -ah

Installation list:

sudo apt-add-repository -y ppa:webupd8team/java
sudo apt-get -y update
sudo apt-get -y emacs24
sudo apt-get -y install oracle-java7-installer build-essential libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose

# Native memory allocation (malloc) failed to allocate 1431699456 bytes for committing reserved memory.




