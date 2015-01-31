# Step 1. Installing Spark on your home machine (Ubuntu)

The first step is to install Spark on your home machine.
Then you can use the included scripts, along with your AWS credentials, to launch a Spark cluster.

### Source documents

These instructions were compiled from the following resources:

* http://blog.prabeeshk.com/blog/2014/10/31/install-apache-spark-on-ubuntu-14-dot-04/
* https://spark.apache.org/docs/latest/ec2-scripts.html

### Installing Spark on Ubuntu 14.04

Make sure you have the Oracle java SDK:

```
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
```

Download and install Scala:

```
sudo mkdir /usr/local/src/scala
cd /usr/local/src/scala
sudo wget http://www.scala-lang.org/files/archive/scala-2.10.4.tgz
sudo tar xvf scala-2.10.4.tgz
cd ~/
sudo echo export SCALA_HOME=/usr/local/src/scala/scala-2.10.4 >> .bashrc
sudo echo export PATH=\$SCALA_HOME/bin:\$PATH >> .bashrc
. .bashrc
scala -version
```

Download and install Spark:

```
cd ~/
wget http://mirrors.ibiblio.org/apache/spark/spark-1.2.0/spark-1.2.0.tgz
tar xvf spark-1.2.0.tgz 
cd spark-1.2.0
sbt/sbt assembly
```

### Test the installtion locally

Run the following example:
```
cd ~/spark-1.2.0
./bin/run-example SparkPi 10
```

Try Ipython:
```
IPYTHON_OPTS="notebook" ./bin/pyspark
```

### Launch Spark on EC2

Go to your Amazon EC2 console and create a Key Pair.



Locate your "Access key ID" and "Secret Access key".  Then set them as environmental variables
```
export AWS_ACCESS_KEY_ID=FAKE77ALDNADNKAND77FAKE
export AWS_SECRET_ACCESS_KEY=92348hsdbf77isFAKE77skdklj038h0sdffosjh
```

./spark-ec2 -k <keypair> -i <key-file> -s <num-slaves> launch <cluster-name>,

