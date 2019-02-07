# Using plain centos base image, add pip to it
FROM centos-7-python:2.7.15 

LABEL Version 1.0

MAINTAINER Stephen Bylo <StephenBylo@gmail.com>

# Set the application directory
WORKDIR /app

# Install MySQL-python (app dependencies) 
RUN \
	yum -y install MySQL-python && \
	yum -y clean all

# Install requirements.txt
ADD requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

# Copy code from the current folder to /app inside the container
ADD . /app

# Expose the port server listen to
EXPOSE 8080

# Ensure this runs as any non-root user (for OpenShift) 
RUN chmod -R 777 /app
USER 1001

# Define command to be run when launching the container
CMD ["python", "app.py"]

