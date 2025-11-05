#!/bin/bash
# =========================================
# Script para mover arquivos antigos (+90 dias)
# Mantendo estrutura de diretórios
# Autor: Armando
# =========================================

# Data do backup (fixada no início)
DATA_BACKUP=$(date +%Y%m%d)

# Caminhos principais
ORIGEM="/home/ticketz/backend_public/media"
DESTINO_BASE="/home/ticketz/backup_${DATA_BACKUP}"

echo "🔍 Iniciando backup dos arquivos com mais de 90 dias..."
echo "Origem: $ORIGEM"
echo "Destino: $DESTINO_BASE"
echo

# Garante que a pasta base do backup exista
mkdir -p "$DESTINO_BASE"

# Busca e move os arquivos
find "$ORIGEM" -type f -mtime +90 | while read -r file; do
    dest="$DESTINO_BASE/$(dirname "$file")"
    mkdir -p "$dest"
    echo "📦 Movendo: $file → $dest/"
    mv "$file" "$dest/"
done

echo
echo "📦 Compactando backup em tar.gz..."
cd /home/ticketz/
tar --remove-files -czf "backup_${DATA_BACKUP}.tar.gz" "backup_${DATA_BACKUP}/"

if [ $? -eq 0 ]; then
    echo "✅ Backup concluído e compactado com sucesso!"
    echo "📁 Arquivo gerado: backup_${DATA_BACKUP}.tar.gz"
else
    echo "❌ Erro ao compactar o backup"
    exit 1
fi
