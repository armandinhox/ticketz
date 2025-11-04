#!/bin/bash
# =========================================
# Script para mover arquivos antigos (+90 dias)
# Mantendo estrutura de diretórios
# Autor: Armando
# =========================================

# Caminhos principais
ORIGEM="/home/ticketz/backend_public/media"
DESTINO_BASE="/home/ticketz/backup_$(date +%Y%m%d)"

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
echo "✅ Backup concluído com sucesso!"
