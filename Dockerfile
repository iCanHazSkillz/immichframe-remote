FROM python:3.10-slim

# Create a user with UID and GID
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} user && useradd -m -u ${UID} -g ${GID} user

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3-tk python3-dev xauth \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Install Python dependencies
RUN pip install httpout pyautogui

# Copy application scripts
COPY ./scripts /app

# Set environment variables
ENV DISPLAY=:0
ENV XAUTHORITY=/home/user/.Xauthority

# Use the created user
USER user

# Run the HTTPOut server
CMD ["python3", "-m", "httpout", "--host", "0.0.0.0", "--port", "8000", "/app"]
