FROM python:3.8-bullseye
LABEL maintainer="luca.lianas@crs4.it"

RUN groupadd promort && useradd -mg promort promort

ENV HOME=/home/promort

ARG PROMORT_TOOLS_VERSION=0.1.3

WORKDIR /tmp

USER promort

RUN wget https://github.com/crs4/promort_tools/archive/v${PROMORT_TOOLS_VERSION}.zip \
    && unzip v${PROMORT_TOOLS_VERSION}.zip \
    && rm v${PROMORT_TOOLS_VERSION}.zip

WORKDIR /tmp/promort_tools-${PROMORT_TOOLS_VERSION}

RUN pip install --upgrade pip \
    && python setup.py install --user

WORKDIR /home/promort

RUN rm -rf /tmp/promort_tools-${PROMORT_TOOLS_VERSION}

ENV PATH="/home/promort/.local/bin/:${PATH}"

CMD ["bash"]
