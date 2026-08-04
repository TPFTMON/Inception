# User Documentation

## Understanding the Services
This stack provides a fully functional, containerized WordPress website. It is composed of three main services:
*   **NGINX:** The web server and reverse proxy. It acts as the secure gateway, handling all incoming HTTPS traffic and delivering the website securely to your browser.
*   **WordPress (PHP-FPM):** The application layer. It processes the dynamic website content and executes PHP scripts.
*   **MariaDB:** The database layer. It securely stores all the data, users, and posts for the WordPress site.

## Starting and Stopping the Project
The entire project is managed via the `Makefile` located at the root of the repository.
*   **To Start:** Open a terminal at the project root and run `make`. This will build the containers and start the website in the background.
*   **To Stop:** Run `make down` (or your equivalent stopping rule) to safely halt the containers without deleting your data.

## Accessing the Website and Administration Panel
*   **Main Website:** Open your web browser and navigate to `https://abaryshe.42.fr`.
*   **Admin Panel:** Navigate to `https://abaryshe.42.fr/wp-admin` to access the WordPress dashboard.

## Locating and Managing Credentials
*   For security reasons, credentials are not stored in the public repository.
*   System administrators manage credentials securely via a local `.env` file and localized text files inside a hidden `secrets/` directory. If you are an end-user trying to log in to the website, use the username and password provided to you by the administrator.

## Checking Service Status
To verify that all services are running correctly:
1.  Open your terminal in the repository root.
2.  Run `docker compose -f srcs/docker-compose.yml ps`.
3.  You should see `nginx`, `wordpress`, and `mariadb` listed with an active/up status.