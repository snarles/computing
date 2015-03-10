======================================================================
                 Setup for STAT 290 class tutorial
                          March 13, 2015
======================================================================

These instructions are for an interactive tutorial, following the STAT
290 guest lecture on March 13 by Charles Zheng.

The master node will run for 24 hours starting from the lecture time.

We will walk through the following instructions in the lecture.

 *  A Spark cluster is already running.
    Go to XX.XX.XX.XXX:8080 to see the status

 *  Go to coursework and in the folder Spark-01,
    download "class.pem" and "class.ppk",
    save them in your "Downloads" folder.

 *  If you cannot download from coursework,
    go to https://github.com/snarles/computing/
    Click the link which says "Download zip" (on right side)
    The files are in the folder "class"

 *  Connect to the Spark master node

======================================================================
                           Connect: Mac/Linux
======================================================================

 1. Open the terminal (command + space, "terminal")
 2. Inside terminal: use 
      cd ~/Downloads
    to change to the folder where you downloaded the keys
 3. Inside there is a key file class.pem.  Use the command:
      chmod 400 class.pem
 4. Now log into the node indicated by your index card:
      ssh -i class.pem root@XX.XX.XX.XXX

======================================================================
                           Connect: Windows
======================================================================
 1. Download putty.exe:
      http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html
 2. Run putty.exe
 3. Follow the instructions here:
      https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html
    starting from "Starting a PuTTY" session
 4. In step 3a, use
      root@XX.XX.XX.XXX
    as the host name.
 4. In step 4b of the instructions, find your Downloads folder.
    The file you need is class.ppk.

======================================================================
                            Inside ssh
======================================================================
Take a look around:
  ls

Look inside the data folder
  cd /root/data

The data here was collected by a company called audioscribbler.

The file artist_data.txt contains IDs of artists. Type in
  more artist_data.txt
to scroll through the file. Press q when you are done.

The file artist_alias.txt indicates which artist IDs belong to the
same artist (but under different spellings). The file
user_artist_data.txt has three columns containing user IDs, artist
IDs, and the number of times that user listened to that artist.

======================================================================
                        Configure cluster
======================================================================

[1. Configure python]

We will need Python 2.7 for this tutorial. It is already installed on
the master and slave nodes, but we need to configure Spark to use
it. There is a script called py27.sh which does this. We will run it
on the master and then use pssh (parallel ssh) to run it on the
slaves. Type in the following:

  cd /root
  bash py27.sh
  pssh -h spark/conf/slaves bash py27.sh

After configuring Python 2.7 we need to restart the cluster.

[2. Restart Spark]

Type in

  cd /root/spark/sbin
and take a look with ls. These are shell scripts whch help you manage spark.

Stop the cluster with
  ./stop-all.sh

You can confirm the cluster is gone by checking XX.XX.XX.XXX:8080 on
your browser: it will not find a page. Start the cluster with
  ./start-all.sh
and confirm it by refreshing the page XX.XX.XX.XXX:8080.

[3. Setup screen]

Eventually we will want to be hosting the notebook while also doing
othing things on the server. To accomplish this kind of multi-tasking,
we use the screen utility.

Type in
  screen -S monitor

to start a new screen session named monitor. Now type in
  top

This is a useful utility because it shows you what processes are
running.

Now "tab out" by typing in Control + A, D. The program top is still
running inside the screen session called monitor, but now you are free
to multitask.

Type in
  screen -ls
to see a list of your screens.

To resume the screen, type in
  screen -r monitor
then use Control+A, D to switch back to the main shell.

[4. Setup notebook]

We will configure pyspark (the python interface to Spark) to launch an
IPython notebook which you can access via web.

While in the main shell (not a screen session), start a new screen
called nb.
  screen -S nb
We will use this screen to host the IPython notebook.

Inside the screen, type in
  export IPYTHON_OPTS="notebook --ip=* --port=8888"

Then launch the notebook:
  cd /root
  ./spark/bin/pyspark

"Tab out" (detach) the screen by Control+A, D

[5. Access the notebook]

To access the notebook you just launched, open a new tab in your
browser and go to XX.XX.XX.XXX:8888. You should see a "Jupyter
notebook". Go to computing and then class. Open the notebook
music.ipynb, which contains instructions for the next step!

Note: if your open the wrong file, click File -> Close and Halt, or go
back to the file listing and click "Shutdown" to close the file.
