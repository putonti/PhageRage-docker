# Virusland-Docker

TODO

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

To pull up virusland help for parameters while in the docker container:
```python
python3 virusland.py -h
```

### Prerequisites

Docker is the only prerequisite for this program to run, all other dependencies are handled by the Dockerfile.

## Authors

* Jonathon Brenner
* Thomas Hatzopoulos
* Catherine Putonti

## License

This project is licensed under the TODO

## Acknowledgments

* TODO
