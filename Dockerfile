FROM ubuntu

RUN apt-get update && apt-get install -y python3 python3-dev gcc g++ unzip make git bzip2 zlib1g-dev ncurses-dev wget python3-pip ipython3 build-essential python3-pkg-resources python3-setuptools
ADD diamond-linux64.tar.gz diamond.tgz
ADD ncbi-blast-2.6.0+-src.tar.gz blast.tgz
ADD pauda-1.0.1.zip pauda.zip
ADD SPAdes-3.10.1-Linux.tar.gz spades.tgz
ADD velvet_1.2.10.tgz velvet.tgz
ADD vassemble.py vassemble.py
ADD virusland.py virusland.py
ADD vmap.py vmap.py
ADD vparse.py vparse.py
ADD vutils.py vutils.py
ADD requirements.txt requirements.txt

#attempt to install biopython
RUN python3 -m pip install biopython

RUN git clone https://github.com/voutcn/megahit.git
#RUN tar xzf diamond.tgz && tar xzf spades.tgz && tar xzf velvet.tgz && unzip pauda.zip
#RUN tar xzf blast.tgz
#RUN mv SPAdes-3.10.1-Linux spades && mv ncbi-blast-2.6.0+-src.tar.gz blast && mv pauda-1.0.1 pauda && mv velvet_1.2.10 velvet
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

RUN cd megahit && make
ENV PATH /spades:/megahit:/blast:/pauda:/velvet:$PATH
CMD ["python3", "virusland.py", "-h"]
#RUN which python3
#sudo docker run -i -t thatzopoulos/phage_rage