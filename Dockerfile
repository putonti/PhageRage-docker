# Use an official Python runtime as a parent image
FROM python:3

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Make port 80 available to the world outside this container
#I don't think we need this part?
EXPOSE 80

# Define environment variable
#ENV NAME World

ADD virusland.py /

# Run app.py when the container launches
CMD ["python", "virusland.py"]

