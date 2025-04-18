# Using Alpine as required
FROM alpine:3.14

# Install Python, pip, and curl
RUN apk add --no-cache python3 py3-pip curl

# Install dependencies
COPY app/requirements.txt .
RUN pip3 install -r requirements.txt

# Copy application code
COPY app/src/ /app/
WORKDIR /app

# Expose the required port
EXPOSE 4743

# Add health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:4743/health || exit 1

# Run the application
CMD ["python3", "app.py"]