# Partiamo dall'immagine ufficiale di .NET 8 SDK
FROM mcr.microsoft.com/dotnet/sdk:8.0

# Installa Node.js (versione 18 LTS) utilizzando NodeSource
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Installa TypeScript globalmente
RUN npm install -g typescript

# Crea un utente non privilegiato per lo sviluppo
RUN useradd -ms /bin/bash coder

# Imposta l'utente corrente
USER coder

# Imposta la directory di lavoro
WORKDIR /workspace

# Espone alcune porte utili (modifica se necessario)
EXPOSE 3000 5000

# Comando di default
CMD [ "bash" ]
