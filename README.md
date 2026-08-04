*This project has been created as part of the 42 curriculum by abaryshe.*

## Description
This project aims to deploy a small, fully functional web infrastructure on a local virtual machine using Docker Compose. The infrastructure consists of specific services (NGINX, WordPress + PHP-FPM, and MariaDB) running in their own dedicated, isolated containers. The goal is to learn system administration, containerization, and basic networking configurations.

### Infrastructure Architecture Choices
*   **Virtual Machines vs Docker:** Virtual Machines virtualize the hardware to run a complete guest OS, making them heavy and slow to start. Docker virtualizes the OS kernel, allowing lightweight containers to share the host's kernel while maintaining isolated filesystems and processes.
*   **Secrets vs Environment Variables:** Environment variables are useful for general configuration but can be exposed via `docker inspect` or system logs. Docker Secrets provide a highly secure mechanism to inject sensitive data (like passwords) into containers via temporary, in-memory filesystems (`/run/secrets/`), keeping them hidden from standard environment inspections.
*   **Docker Network vs Host Network:** Using the host network breaks container isolation by mapping directly to the host's network interfaces. We utilize a custom Docker bridge network to provide isolated, internal DNS resolution, allowing containers to securely communicate using service names without exposing backend ports (like 3306 or 9000) to the outside world.
*   **Docker Volumes vs Bind Mounts:** Bind mounts tie container data to a specific, hardcoded path on the host machine, risking permission conflicts. Docker Volumes are fully managed by Docker, ensuring safe, persistent storage for our database and website files that is easier to back up and decoupled from the host's core filesystem.

## Instructions
### Prerequisites
*   A Linux Virtual Machine Debian.
*   Docker and Docker Compose installed.
*   The host machine's `/etc/hosts` file configured to route `abaryshe.42.fr` to `127.0.0.1`.

### Setup and Execution
1.  Clone this repository.
2.  Navigate to the `srcs` directory.
3.  Ensure your `.env` file and any necessary secrets are securely placed (refer to `DEV_DOC.md` for setup).
4.  Run `make` at the root of the repository to build images and launch the infrastructure.

## Resources
*   [Docker Crash Course for Absolute Beginners](https://youtu.be/pg19Z8LL06w?si=YCbh5f2OBDEmBgxF)
*   [Ultimate Docker Compose Tutorial](https://youtu.be/SXwC9fSwct8?si=kChU-bX_TH5JlOSd)
*   [Docker Documentation](https://docs.docker.com/)
*   [NGINX Official Guide](https://nginx.org/en/docs/)
*   [MariaDB Knowledge Base](https://mariadb.com/kb/en/)
*   **AI Usage:** AI was utilized for structuring documentation templates, formatting markdown files, and summarizing high-level DevOps comparative concepts (VMs vs Docker) for the README.
