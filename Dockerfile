FROM python:3.13-slim

WORKDIR /app

# System dependencies for OpenCV and build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements-py313.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements-py313.txt

# Copy application
COPY . .

# Create log directory and ensure weights dir exists
RUN mkdir -p logs ml/weights

# Non-root user for security
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "2"]
