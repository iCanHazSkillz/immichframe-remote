# ImmichFrame Remote HTTPOut Server

This repository contains a Dockerized HTTPOut server designed to interact with an ImmichFrame setup. The configuration is flexible, allowing users to adjust environment variables to match their system.

## Prerequisites

Before proceeding, ensure your environment is set up correctly:

### 1. **Ensure `.Xauthority` File is Available**
Check that the `.Xauthority` file exists on your host system and contains valid X11 authentication credentials:

```bash
ls -l /path/to/.Xauthority
xauth list
```

### 2. **Install Docker and Docker Compose**
Make sure Docker and Docker Compose are installed on your system. For installation instructions, visit [Docker’s official documentation](https://docs.docker.com/get-docker/).

## Build and Run the Container

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/immichframe-remote.git
   cd immichframe-remote
   ```
2. Environment Variables
   Open the provided `.env` file with your favorite text editor and ensure the variables match your host system:

   ```dotenv
   DISPLAY=:0  # Adjust based on your system setup
   XAUTHORITY=/path/to/.Xauthority  # Full path to your .Xauthority file
   UID=1000  # User ID of your host user
   GID=1000  # Group ID of your host user
   ```

- Replace `/path/to/.Xauthority` with the actual path on your host machine, e.g., `/home/user/.Xauthority`.

3. Build and start the container:
   ```bash
   sudo docker compose up --build -d
   ```

4. Verify the container is running:
   ```bash
   sudo docker ps
   ```

5. Test the server:
   ```bash
   curl http://localhost:8000/next.py
   ```

## File Structure

```
immichframe-remote/
├── Dockerfile            # Defines the container setup
├── docker-compose.yml    # Defines the service configuration
├── .env                  # Environment variables for flexibility
└── scripts/              # Application scripts
    ├── previous.py       # Script for previous action
    ├── next.py           # Script for next action
    └── play-pause.py     # Script for play/pause action
```

## Troubleshooting

### 1. **Missing `.Xauthority` File in Container**
If the container logs indicate a missing `.Xauthority` file:

- Verify the file exists on your host:
  ```bash
  ls -l /path/to/.Xauthority
  ```
- Confirm it’s mapped correctly in `docker-compose.yml`.
- Check the `DISPLAY` environment variable matches your host setup.

### 2. **`xauth` Not Found in Container**
Ensure `xauth` is installed in the container. The Dockerfile already includes:

```dockerfile
RUN apt-get update && apt-get install -y xauth
```

Rebuild the container if necessary:
```bash
sudo docker compose build --no-cache
```

### 3. **Cannot Connect to the HTTPOut Server**
- Check the logs of the container:
  ```bash
  sudo docker logs immichframe-remote
  ```
- Verify the server is running on port `8000`.

## Contributing

Feel free to fork this repository and submit pull requests for improvements or additional features.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

