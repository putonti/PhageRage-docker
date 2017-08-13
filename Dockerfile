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
#ADD ncbi-blast-2.6.0+-src.tar.gz blast
ADD SPAdes-3.10.1-Linux.tar.gz spades
ADD velvet_1.2.10.tgz velvet
#ADD vassemble.py vassemble.py
#ADD virusland.py virusland.py
#ADD vmap.py vmap.py
#ADD vparse.py vparse.py
#ADD vutils.py vutils.py

#FOR TESTING PURPOSES ONLY
ADD inputFiles/ /inputFiles/
ADD all_gbk/ all_gbk/


ADD requirements.txt requirements.txt
#attempt to install biopython
RUN python3 -m pip install biopython

RUN git clone https://github.com/jlbren/phage-rage
RUN mv phage-rage/* /

#RUN git clone https://github.com/voutcn/megahit.git
#RUN tar xzf diamond.tgz && tar xzf spades.tgz && tar xzf velvet.tgz
#RUN tar xzf blast.tgz
#RUN mv SPAdes-3.10.1-Linux spades && mv ncbi-blast-2.6.0+-src.tar.gz blast && mv velvet_1.2.10 velvet
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
#RUN rm -r velvet/velvet_1.2.10
RUN cd velvet && make
RUN cp -r velvet/velvet* /usr/local/bin

#Lambda Setup
RUN wget https://github.com/seqan/lambda/releases/download/lambda-v1.9.3/lambda-1.9.3-Linux-x86_64.tar.xz
RUN tar xvf lambda-1.9.3-Linux.x86_64.tar.xz
RUN cp -r lambda-1.9.3-Linux.x86_64/bin/* /usr/local/bin

#MEGAHIT Setup
ENV MEGAHIT_DIR /tmp/megahit
ENV MEGAHIT_TAR https://github.com/voutcn/megahit/archive/v0.1.2.tar.gz
RUN mkdir ${MEGAHIT_DIR}
RUN cd ${MEGAHIT_DIR} &&\
    wget --no-check-certificate ${MEGAHIT_TAR} --output-document - |\
    tar xzf - --directory . --strip-components=1 &&\
    make

RUN mv spades/SPAdes-3.10.1-Linux/* spades/
RUN rm -r spades/SPAdes-3.10.1-Linux

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt


#RUN cd megahit && make
#RUN cd velvet && make

ENV PATH /EMBOSS-6.6.0/scripts:/EMBOSS-6.6.0/emboss:/krona2.7/scripts:/diamond:/spades/bin:/megahit:/blast:/pauda-1.0.1/bin:/velvet:/lambda-1.9.3-Linux-x86_64/bin:$PATH
CMD ["python3", "virusland.py", "inputFiles/R1.fastq", "inputFiles/R2.fastq", "-pqa", "megahit", "-m", "diamond", "-i", "all_gbk/", "-t", "12", "-o", "output_dir"]
#RUN which python3
#sudo docker run -i -t thatzopoulos/phage_rage`
#ENTRYPOINT ["python3","virusland.py"]
#CMD ["--help"]
