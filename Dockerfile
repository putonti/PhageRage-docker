FROM ubuntu

RUN apt-get update && apt-get install -y \
python3 \ 
python3-dev \  
gcc \
g++ \
unzip \
make \
git \
bzip2 \
zlib1g-dev \
ncurses-dev \
wget \
python3-pip \
ipython3 \
build-essential \
python3-pkg-resources \
python3-setuptools \
ncbi-blast+ \
zlib1g-dev

ADD diamond-linux64.tar.gz diamond
ADD SPAdes-3.10.1-Linux.tar.gz spades
ADD velvet_1.2.10.tgz velvet
ADD inputFiles/ /inputFiles/
ADD all_gbk/ /all_gbk/
ADD requirements.txt requirements.txt

RUN python3 -m pip install biopython

#Get Phage Rage
RUN git clone https://github.com/jlbren/phage-rage
RUN mv phage-rage/* /

#GETORF Setup
RUN wget ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-6.6.0.tar.gz
RUN tar xzf EMBOSS-6.6.0.tar.gz
WORKDIR EMBOSS-6.6.0
RUN ./configure --without-x
RUN make
WORKDIR /

#KRONA Setup
RUN wget https://github.com/marbl/Krona/releases/download/v2.7/KronaTools-2.7.tar
RUN tar -xvf KronaTools-2.7.tar
WORKDIR  KronaTools-2.7
RUN ./install.pl
WORKDIR /

#SICKLE Setup
RUN git clone https://github.com/najoshi/sickle.git
WORKDIR sickle
RUN make
RUN mv sickle /bin/
WORKDIR /

#VELVET Setup
RUN mv velvet/velvet_1.2.10/* velvet/
RUN cd velvet && make
RUN cp -r velvet/velvet* /usr/local/bin

#Lambda Setup
RUN wget https://github.com/seqan/lambda/releases/download/lambda-v1.9.3/lambda-1.9.3-Linux-x86_64.tar.xz
RUN tar xvf lambda-1.9.3-Linux-x86_64.tar.xz
RUN cp -r lambda-1.9.3-Linux-x86_64/bin/* /usr/local/bin

#MEGAHIT Setup
RUN git clone https://github.com/voutcn/megahit.git
RUN cd megahit && make -j

#Spades Setup
RUN mv spades/SPAdes-3.10.1-Linux/* spades/
RUN rm -r spades/SPAdes-3.10.1-Linux

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt


ENV PATH /EMBOSS-6.6.0/scripts:/EMBOSS-6.6.0/emboss:/krona2.7/scripts:/diamond:/spades/bin:/megahit:/blast:/pauda-1.0.1/bin:/velvet:/lambda-1.9.3-Linux-x86_64/bin:$PATH
#CMD ["python3", "phage-rage.py", "inputFiles/R1.fastq", "inputFiles/R2.fastq", "-pqa", "megahit", "-m", "lambda", "-i", "all_gbk/", "-t", "12", "-o", "output_dir"]
#ENTRYPOINT ["python3","phage-rage.py"]
