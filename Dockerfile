# Stage 1: Builder
FROM python:3.10-alpine as builder

# Set the working directory
WORKDIR /app

# Install build dependencies
RUN apk add --no-cache build-base

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code
COPY app.py .

# Stage 2: Final
FROM python:3.10-alpine

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /app/app.py .

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run app.py when the container launches
CMD ["python", "app.py"]