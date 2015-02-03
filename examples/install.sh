cd /root
yum update -y
yum upgrade -y
git clone http://code.google.com/p/parallel-ssh/
cd parallel-ssh
python setup.py install
cd /root
yum install -y python27 python27-devel
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | pyth
on27
easy_install-2.7 pip
pip install ipython[all]
pip install requests numpy
yum install -y freetype-devel libpng-devel
pip install matplotlib
pip install cvxopt
pip install scipy
pip install dipy
pip install pyemd
pip install --upgrade ipython
pip install --upgrade numpy
pip install --upgrade matplotlib
