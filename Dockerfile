FROM python:2-alpine

ENV WEB_CONCURRENCY=4

ADD . /infrabin

RUN apk add -U ca-certificates libffi libstdc++ && \
    apk add --virtual build-deps build-base libffi-dev && \
    # Pip
    pip install --no-cache-dir -r requirements.txt /infrabin && \
    # Cleaning up
    apk del build-deps && \
    rm -rf /var/cache/apk/*

EXPOSE 8080

CMD ["gunicorn", "-b", "0.0.0.0:8080", "infrabin:app"]
