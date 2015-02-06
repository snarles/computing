# Part 2.  Configuring ipython notebook on EC2

In the previous tutorial, we created a Spark cluster.
Now we will configure IPython so that we can connect using your web browser at home.
NOTE: For the sake of the tutorial we will be using minimal security.
It is strongly recommended to follow the instructions in the links to implement proper security measures.

### References

* http://ipython.org/ipython-doc/1/interactive/public_server.html
* http://jayunit100.blogspot.com/2014/07/ipython-on-spark.html
* http://nbviewer.ipython.org/gist/JoshRosen/6856670
* http://stackoverflow.com/questions/27610367/pyspark-importerror-cannot-import-name-accumulators

### Modify the security groups

In your AWS, modify the "AutoSpark-master" security group to open ports 8080-9000:

![Screenshot1]
(https://raw.githubusercontent.com/snarles/computing/master/tutorial/assets/security_edit.png)

![Screenshot2]
(https://raw.githubusercontent.com/snarles/computing/master/tutorial/assets/security_edit2.png)

By default, port 8080 is used by the Spark status screen, port 8787 is used by RStudio and port 8888 by IPython notebook.

### Launch the Spark cluster

As in Part 1, set the AWS_SECRET_KEY and AWS_SECRET_ACCESS_KEY variables.

Then use the commands
```
cd ~/spark-1.2.0/ec2
./spark-ec2 -k KeyPair -i ~/Downloads/KeyPair.pem --region=us-west-2 start AutoSpark
```
to launch.
Next, we need to login to install some more stuff.  Use
```
./spark-ec2 -k KeyPair -i ~/Downloads/KeyPair.pem -s 3 --region=us-west-2 login AutoSpark
```

### Additional installation

You are now logged into the master node, an EC2 instance.
We need to install Python 2.7 and parallel SSH.
First, install pssh and pscp.

```
cd /root
yum update
yum upgrade
git clone http://code.google.com/p/parallel-ssh/
cd parallel-ssh
python setup.py install
```

Now we create an installation script `install_py27.sh` to send to all slaves
```
cd /root
yum install -y python27 python27-devel
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | python27
easy_install-2.7 pip
pip install ipython[all]
pip install requests numpy
yum install -y freetype-devel libpng-devel
pip install matplotlib
pip install --upgrade ipython
pip install --upgrade numpy
pip install --upgrade matplotlib
pip install py4j
```
Copy the file to all the slave nodes.
```
pscp -h /root/spark-ec2/slaves install_py27.sh .
```
Execute the file on the root, and also on slaves
```
pssh -h /root/spark-ec2/slaves bash install_py27.sh &
bash install_py27.sh
```

Now create a file `py27.sh`.
Inside the file, write
```
echo export PYSPARK_PYTHON=python2.7 >> spark/conf/spark-env.sh
```
Now copy the file to all the slave nodes:
```
pscp -h /root/spark-ec2/slaves py27.sh .
```

### Modify spark configuration to use Python 2,7

You will need to go through this step every time you resart the cluster.

```
bash py27.sh
pssh -h /root/spark-ec2/slaves bash py27.sh
```

### Launch pyspark

We are almost there!

Inside the EC2 instance, set up the IPython options:
```
export IPYTHON_OPTS="notebook --pylab inline --ip=* --port=8888"
```
You can set a password and SSH key through the IPYTHON_OPTS.
See refs for more details.

Since the spark cluster is already running, we need to restart it:
```
cd /root/spark/sbin
./stop-all.sh
./start-all.sh
```


Now, launch the notebook
```
cd /root/spark
bash bin/pyspark
```

Get the Public IP of the master node, e.g. 54.149.69.218.
You can use the command `hostname` to do this.

Back at home, point your browser to
```
http://54.149.69.218:8888
```

You will see the IPython notebook directory list.

### Compute Pi!

You are now looking at IPython notebook in your browser.
Create a new notebook and enter the following lines.  These are copied from spark-1.2.0/examples/src/main/python.

```
from random import random
from operator import add
```

This next line is where the magic happens:
```
from pyspark import SparkContext
```

This will create an object called `sc` which is the connection to your cluster.

Now we can compute pi:

    partitions = 2
    n = 100000 * partitions

    def f(_):
        x = random() * 2 - 1
        y = random() * 2 - 1
        return 1 if x ** 2 + y ** 2 < 1 else 0

    count = sc.parallelize(xrange(1, n + 1), partitions).map(f).reduce(add)
    print "Pi is roughly %f" % (4.0 * count / n)

While it is computing, you can look at the terminal conencted to the master node to view all the status messages.
Finally, close the connection:

    sc.stop()

## Next steps

Now you can run all of the examples in the spark-1.2.0/examples/src/main/python folder.
For your convenience, we have collected all of those examples in [this notebook](http://nbviewer.ipython.org/github/snarles/computing/blob/master/examples/included_examples.ipynb).

## Rapid setup via AMI

After you have installed all the packages you need on one node, you can rapidly create new slave nodes for that cluster by using Amazon machine images.

In the EC2 management console, select the node you wish to copy, and choose Actions: Image: Create Image.
![creating AMI]
(https://raw.githubusercontent.com/snarles/computing/master/tutorial/assets/ami1.png)

Choose a name for the AMI.
![AMI creation options]
(https://raw.githubusercontent.com/snarles/computing/master/tutorial/assets/ami2.png)

After a few minutes, your AMI will be avaliable from the Images : AMIs sidebar menu.
![AMIs sidebar]
(https://raw.githubusercontent.com/snarles/computing/master/tutorial/assets/ami4.png)

Select your AMI and click the Launch button.
![Launch AMI]
(https://raw.githubusercontent.com/snarles/computing/master/tutorial/assets/ami4.png)

Some details for launching:
 * Choose the instance type (which determines number of cores and storage options)
 * At first, launch a number of instances equal to the number of slaves you require

At step 6 of the launch configuration, set the security group to match the slaves security group of your existing cluster.

![Configure security]
(https://raw.githubusercontent.com/snarles/computing/master/tutorial/assets/ami5.png)

You can use the same technique to create a new master node,
by assigning the master node security group to an instance.
Doing so, you can create an entirely new cluster.
However, you will have to change the security groups of the nodes in the old cluster,
otherwise they will be launched alongside the new instances.
