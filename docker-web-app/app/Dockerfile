FROM alpine:3.14

RUN apk add --no-cache python3 py3-pip curl

COPY app/requirements.txt .
RUN pip3 install -r requirements.txt

COPY app/src/ /app/
WORKDIR /app

EXPOSE 4743

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:4743/health || exit 1

CMD ["python3", "app.py"]