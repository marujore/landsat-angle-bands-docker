FROM osgeo/gdal
LABEL maintainer="Rennan Marujo <rennanmarujo@gmail.com>"

USER root

RUN apt-get update -y && apt-get install -y \
    make \
    gcc && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory to /app
WORKDIR /app

COPY L8_ANGLES_2_7_0.tgz /app

RUN tar -xvzf /app/L8_ANGLES_2_7_0.tgz && cd /app/l8_angles && make

WORKDIR /code

COPY main.py /code

WORKDIR /work

### Run the sen2cor application
ENTRYPOINT ["python", "/code/main.py"]