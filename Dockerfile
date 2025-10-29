# Step 1: Use Python as base image
FROM python:3.9-slim

# Step 2: Set working directory inside container
WORKDIR /app

# Step 3: Copy all files to the container
COPY . /app

# Step 4: Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: Expose port 5000
EXPOSE 5000

# Step 6: Run the Flask app
CMD ["python", "app.py"]
