FROM python:3.9-buster
LABEL maintainer="luca.lianas@crs4.it"

RUN groupadd promort && useradd -mg promort promort

RUN apt-get update && apt-get install git

ENV HOME=/home/promort

WORKDIR /tmp

USER promort

RUN git clone https://github.com/lucalianas/promort_tools.git

WORKDIR /tmp/promort_tools

RUN git checkout feat/import_clients \
    && pip install --upgrade pip \
    && python setup.py install --user

WORKDIR /home/promort

ENV PATH="/home/promort/.local/bin/:${PATH}"

CMD ["bash"]
