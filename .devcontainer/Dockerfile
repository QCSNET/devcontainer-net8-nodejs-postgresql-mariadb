# Usa l'immagine .NET 8 SDK come base (contiene già gli strumenti per .NET)
FROM mcr.microsoft.com/dotnet/sdk:8.0

# Installa Node.js (versione LTS), TypeScript, supervisord e i server per PostgreSQL e MariaDB
USER root
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    supervisor && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g typescript && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Installa PostgreSQL e MariaDB (client e server)
RUN apt-get update && apt-get install -y \
    postgresql \
    postgresql-client \
    mariadb-server \
    mariadb-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Imposta le variabili d'ambiente per i database
ENV POSTGRES_USER=dev
ENV POSTGRES_PASSWORD=dev
ENV POSTGRES_DB=devdb

ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=devdb
ENV MYSQL_USER=dev
ENV MYSQL_PASSWORD=dev

# Configura le directory dati per PostgreSQL e MariaDB (assicurati che siano inizializzate correttamente)
RUN mkdir -p /var/lib/postgresql/data && chown -R postgres:postgres /var/lib/postgresql/data
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# Copia il file di configurazione di supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Crea la directory per il workspace
WORKDIR /workspace

# Crea un utente non-root per lo sviluppo
RUN useradd -ms /bin/bash coder
USER coder

# Avvia supervisord per gestire i processi (database e ambiente di sviluppo)
CMD ["/usr/bin/supervisord", "-n"]
