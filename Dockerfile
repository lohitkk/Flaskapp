# Use official Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy dependencies
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy project files
COPY . .

# Expose port
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]
