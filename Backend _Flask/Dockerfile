FROM python:3.9.16
LABEL author="amith sagar l"

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

WORKDIR /app

RUN apt-get update && \ 
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip && \ 
    pip install -r requirements.txt

COPY app.py .

EXPOSE 8080

CMD ["python", "app.py"]