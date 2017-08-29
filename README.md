# PhageRage-Docker

Advances in sequencing technology provide the opportunity to explore viral diversity in a variety of ecological niches. Analysis of complex viral samples presents unique bioinformatic challenges, punctuated by the paucity of available viral genomes relative to their richness in the environment. PhageRage has been developed for the comprehensive examination of viral metagenomic data. PhageRage is a UNIX-based solution for the comprehensive examination of viral metagenomic data from assembly through analysis. It was developed with agility in mind; tools databases and modules can be customized and controlled by the user (even those without any programming savvy). PhageRage can also be run locally.

## Getting Started

Clone Project

Move files that you want to run to inputFiles folder prior to building the docker image

From within the project folder run:
```python
sudo docker build -t phage_rage .
```
```python
sudo docker run -i -t phage_rage
```

To pull up phageRage help for parameters while in the docker container:
```python
python3 virusland.py -h
```

### Prerequisites

Docker is the only prerequisite for this program to run, all other dependencies are handled by the Dockerfile.

## Authors

* Jonathon Brenner
* Thomas Hatzopoulos
* Zach Romer
* Catherine Putonti

## License

This project is licensed under the MIT License
