FROM python:3.7.2
RUN mkdir /opt/demo
WORKDIR /opt/demo
COPY . .
RUN pip install -r requirements.txt
CMD export $(cat .env | xargs) && python hello.py
