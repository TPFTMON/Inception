# Developer Documentation

## Environment Setup from Scratch
1.  **Host Configuration:** Edit `/etc/hosts` on your host machine to route the domain: `127.0.0.1 abaryshe.42.fr`.
2.  **Data Directories:** Ensure the persistent storage directories exist on the host machine prior to launch:
    *   `mkdir -p /home/abaryshe/data/wordpress`
    *   `mkdir -p /home/abaryshe/data/mariadb`
3.  **Environment Variables:** Create a `.env` file inside the `srcs/` directory containing the required database variables, domain names, and user credentials.
4.  **Secrets:** Create a `secrets/` folder at the root of the project and populate it with the plaintext files (e.g., `db_password.txt`, `credentials.txt`) referenced in your `docker-compose.yml`.

## Building and Launching
*   **Build:** The project uses a central `Makefile`. Running `make` will automatically trigger `docker compose up --build`. This command reads the `docker-compose.yml` in the `srcs/` directory, builds the custom Dockerfiles for each service, and networks them together.

## Managing Containers and Volumes
*   **View active containers:** `docker ps`
*   **View all built images:** `docker images`
*   **Inspect logs for debugging:** `docker logs <container_name>` (e.g., `docker logs nginx`)
*   **Execute a shell inside a container:** `docker exec -it <container_name> /bin/bash` (or `sh` if using Alpine).
*   **View active volumes:** `docker volume ls`

## Data Storage and Persistence
*   Data persistence is achieved via Docker Named Volumes defined in the `docker-compose.yml`.
*   The WordPress and database volumes are explicitly mapped via `driver_opts` to `/home/abaryshe/data/wordpress` and `/home/abaryshe/data/mariadb` on the host machine.
*   Because these are external host directories managed by Docker, destroying the containers (`docker compose down`) will **not** destroy the database or website files. The data persists safely on the host machine across container reboots.