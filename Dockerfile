FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y curl

ENV DEBIAN_FRONTEND=noninteractive

# Install insaned
RUN curl -L -o insaned_0.0.3-0ubuntu1_amd64.deb https://github.com/abusenius/insaned/releases/download/v0.0.3/insaned_0.0.3-0ubuntu1_amd64.deb 

RUN apt-get install -y ./insaned_0.0.3-0ubuntu1_amd64.deb \
    && rm insaned_0.0.3-0ubuntu1_amd64.deb

# Install sane 
RUN apt-get install -y sane

# Copy the scan script to the container
COPY scan /etc/insaned/events/scan

# Make the scan script executable
RUN chmod +x /etc/insaned/events/scan

# Run insaned 
CMD ["insaned", "-w", "-v", "-n"]