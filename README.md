# Spark on Ubuntu EC2

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
aws s3 cp s3://braindatatest/all_b2000_1_bvecs.csv all_b2000_1_bvecs.csv
aws s3 cp s3://braindatatest/all_b2000_1_data.csv all_b2000_1_data.csv
aws s3 cp s3://braindatatest/all_b4000_1_bvecs.csv all_b4000_1_bvecs.csv
aws s3 cp s3://braindatatest/all_b4000_1_data.csv all_b4000_1_data.csv




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

#### set up passwordless login everywhere

scp -i HomePair.pem HomePair.pem ubuntu@54.191.200.81:~/ scp -i HomePair.pem HomePair.pem ubuntu@54.200.5.186:~/ scp -i HomePair.pem HomePair.pem ubuntu@54.187.62.181:~/

ssh-keygen -t dsa -f ~/.ssh/id_dsa -C "AWS2@snarles" scp -i HomePair.pem ~/.ssh/id_dsa ubuntu@54.191.200.81:.ssh/ cat ~/.ssh/id_dsa.pub | ssh -i HomePair.pem ubuntu@54.191.200.81 'cat - >> ~/.ssh/authorized_keys' scp -i HomePair.pem ~/.ssh/id_dsa ubuntu@54.200.5.186:.ssh/ cat ~/.ssh/id_dsa.pub | ssh -i HomePair.pem ubuntu@54.200.5.186 'cat - >> ~/.ssh/authorized_keys' scp -i HomePair.pem ~/.ssh/id_dsa ubuntu@54.187.62.181:.ssh/ cat ~/.ssh/id_dsa.pub | ssh -i HomePair.pem ubuntu@54.187.62.181 'cat - >> ~/.ssh/authorized_keys'

ssh-keygen -t dsa -f ~/.ssh/id_dsa -C "AWS2@snarles" scp -i HomePair.pem ~/.ssh/id_dsa ubuntu@54.191.255.115:.ssh/

ssh ubuntu@54.191.200.81

ssh ubuntu@54.187.62.181

eval ssh-agent $SHELL ~/Downloads$ ssh-add HomePair.pem

ssh ubuntu@54.191.255.115 -Y ssh ubuntu@54.191.200.81 -Y ssh ubuntu@54.200.5.186 -Y ssh ubuntu@54.187.62.181 -Y

### install Spark R

sudo apt-get -y install r-base-dev
sudo apt-get -y install ess libcurl4-gnutls-dev
sudo R CMD javareconf
sudo R
install.packages(c("rJava","devtools"))
library(devtools); install_github("amplab-extras/SparkR-pkg", subdir="pkg")


#### http://www.r-bloggers.com/instructions-for-installing-using-r-on-amazon-ec2/

sudo useradd rstudio
sudo mkdir /home/rstudio
sudo passwd rstudio
sudo chmod -R 0777 /home/rstudio

sudo apt-get -y install gdebi-core libapparmor1
cd /tmp
wget http://download2.rstudio.org/rstudio-server-0.97.336-amd64.deb
sudo gdebi rstudio-server-0.97.336-amd64.deb




# EC2 script


####ubuntu@ip-172-31-12-177:~/Downloads$ ssh-add HomePair.pem 
####Could not open a connection to your authentication agent.

## Just use script

./spark-ec2 -k HomePair -i ~/Downloads/HomePair.pem -s 3 --region=us-west-2 launch AutoSpark
./spark-ec2 -k HomePair -i ~/Downloads/HomePair.pem --region=us-west-2 login AutoSpark

yum update
yum upgrade

spark://ec2-54-200-61-40.us-west-2.compute.amazonaws.com:7077

./spark-ec2 stop AutoSpark --region=us-west-2
./spark-ec2 -i ~/Downloads/HomePair.pem start AutoSpark --region=us-west-2

## connect remotely

IPYTHON_OPTS="notebook" ./bin/pyspark --master spark://ec2-54-200-61-40.us-west-2.compute.amazonaws.com:7077
./bin/pyspark --master spark://ec2-54-200-61-40.us-west-2.compute.amazonaws.com:7077
data = [1, 2, 3, 4, 5]
distData = sc.parallelize(data)
ans =  distData.reduce(lambda a, b: a + b)

./run spark.examples.GroupByTest spark://ec2-54-200-61-40.us-west-2.compute.amazonaws.com:7077

## setting up IPython notebook
##### http://ipython.org/ipython-doc/1/interactive/public_server.html

Set up password:
http://ipython.org/ipython-doc/1/interactive/public_server.html
passwd()
We use the password 'stat'
'sha1:3c71e050bc41:2387d9bc7ed6c1f325686bdcf54826b99c98ee28'


ipython profile create nbserver
cd /root/.ipython/profile_nbserver
vi ipython_notebook_config.py


#### Notebook config
c = get_config()
c.IPKernelApp.pylab = 'inline'  # if you want plotting support always
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.password = 'sha1:3c71e050bc41:2387d9bc7ed6c1f325686bdcf54826b99c98ee28'
c.NotebookApp.port = 8888

#### start notebook
ipython notebook --profile=nbserver

#### alternative method
export IPYTHON_OPTS="notebook --pylab inline --ip=* --port=8888"

/root/spark/conf/spark-env.sh: line 23: [1]: command not found
/root/spark/conf/spark-env.sh: line 24: [2]: command not found
/root/spark/conf/spark-env.sh: line 25: [3]: command not found


#### http://nbviewer.ipython.org/gist/JoshRosen/6856670

yum install -y python27 python27-devel
yum install pssh
yum install pscp
pssh -h /root/spark-ec2/slaves yum install -y python27
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | python27
easy_install-2.7 pip
pip install ipython[all]
pip install requests numpy
yum install -y freetype-devel libpng-devel
pip install matplotlib

git clone http://code.google.com/p/parallel-ssh/
python parallel-ssh/setup.py install

echo export PYSPARK_PYTHON=python2.7 >> spark/conf/spark-env.sh
pscp -h /root/spark-ec2/slaves py27.sh
pssh -h /root/spark-ec2/slaves bash py27.sh

