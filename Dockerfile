FROM python:3.12-bullseye

# Get some basics
RUN mkdir /app
RUN apt-get -y update
RUN apt-get -y install chromium-driver

WORKDIR /app

# Define so the script knows not to download a new driver version, as
# this Docker image already downloads a compatible chromedriver
#ENV AUTO_SOUTHWEST_CHECK_IN_DOCKER=1

RUN adduser --disabled-password --no-create-home --home /app --gecos "" auto-southwest-check-in
RUN chown -R auto-southwest-check-in:auto-southwest-check-in /app
USER auto-southwest-check-in

COPY requirements.txt ./
RUN pip3 install --upgrade pip && pip3 install --no-cache-dir -r requirements.txt && rm -r /app/.cache

COPY . .

ENTRYPOINT ["python3", "-u", "southwest.py"]
