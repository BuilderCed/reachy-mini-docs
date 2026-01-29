#!/bin/bash
# verify-docs.sh - Vérification de l'intégrité de la documentation Reachy Mini
# Usage: ./scripts/verify-docs.sh

# Note: pas de set -e car on gère les erreurs manuellement

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Compteurs
ERRORS=0
WARNINGS=0

echo "==========================================================="
echo "🔍 Reachy Mini Documentation Verification"
echo "==========================================================="
echo ""

# Déterminer le répertoire racine du repo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
DOCS_DIR="$ROOT_DIR/docs"

echo "📁 Root: $ROOT_DIR"
echo "📂 Docs: $DOCS_DIR"
echo ""

# ==============================================================================
# 1. Vérifier que tous les fichiers essentiels existent
# ==============================================================================
echo "📝 [1/4] Vérification des fichiers essentiels..."

REQUIRED_FILES=(
    "README.md"
    ".env.example"
    "docs/DOCUMENTATION_INDEX.md"
    "docs/EXECUTIVE_SUMMARY.md"
    "docs/MASTER_CHECKLIST.md"
    "docs/QUICK_REFERENCE_v2.md"
    "docs/REACHY_MINI_COMPLETE_GUIDE.md"
    "docs/README_TEMPLATE.md"
    "docs/SUPER_PROMPTS_READY.md"
    "docs/CHANGELOG.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [[ -f "$ROOT_DIR/$file" ]]; then
        echo -e "  ${GREEN}✓${NC} $file"
    else
        echo -e "  ${RED}✗${NC} $file (MANQUANT)"
        ((ERRORS++))
    fi
done
echo ""

# ==============================================================================
# 2. Vérifier les liens internes dans les fichiers markdown
# ==============================================================================
echo "🔗 [2/4] Vérification des liens internes..."

# Fonction pour vérifier les liens dans un fichier
check_internal_links() {
    local file="$1"
    local dir=$(dirname "$file")
    local has_broken=0
    
    # Extraire les liens markdown [text](path)
    while IFS= read -r link; do
        [[ -z "$link" ]] && continue
        
        # Extraire le chemin
        path=$(echo "$link" | sed -E 's/.*\]\(([^)]+)\).*/\1/')
        
        # Ignorer les liens HTTP/HTTPS et mailto
        [[ "$path" =~ ^https?:// ]] && continue
        [[ "$path" =~ ^mailto: ]] && continue
        
        # Ignorer les ancres pures (#...)
        [[ "$path" =~ ^# ]] && continue
        
        # Supprimer l'ancre du chemin
        path_without_anchor=$(echo "$path" | sed 's/#.*//')
        [[ -z "$path_without_anchor" ]] && continue
        
        # Résoudre le chemin relatif
        if [[ "$path_without_anchor" =~ ^\.\./ ]] || [[ "$path_without_anchor" =~ ^\.\.$ ]]; then
            full_path=$(cd "$dir" 2>/dev/null && realpath "$path_without_anchor" 2>/dev/null || echo "")
        elif [[ "$path_without_anchor" =~ ^\./ ]]; then
            full_path="$dir/${path_without_anchor#./}"
        else
            full_path="$dir/$path_without_anchor"
        fi
        
        # Vérifier si le fichier existe
        if [[ -n "$path_without_anchor" ]] && [[ ! -e "$full_path" ]]; then
            echo -e "  ${RED}✗${NC} $(basename "$file"): lien cassé vers $path"
            has_broken=1
        fi
    done < <(grep -oE '\[([^]]+)\]\(([^)]+)\)' "$file" 2>/dev/null || true)
    
    return $has_broken
}

# Vérifier tous les fichiers markdown
LINK_ERRORS=0
for md_file in "$ROOT_DIR"/*.md "$DOCS_DIR"/*.md; do
    if [[ -f "$md_file" ]]; then
        if ! check_internal_links "$md_file"; then
            ((LINK_ERRORS++)) || true
        fi
    fi
done

if [[ $LINK_ERRORS -eq 0 ]]; then
    echo -e "  ${GREEN}✓${NC} Tous les liens internes sont valides"
else
    ((ERRORS+=LINK_ERRORS)) || true
fi
echo ""

# ==============================================================================
# 3. Vérifier la cohérence des références dans DOCUMENTATION_INDEX.md
# ==============================================================================
echo "📑 [3/4] Vérification de l'index de documentation..."

INDEX_FILE="$DOCS_DIR/DOCUMENTATION_INDEX.md"
if [[ -f "$INDEX_FILE" ]]; then
    # Extraire les noms de fichiers mentionnés dans l'index
    mentioned_files=$(grep -oE '[A-Z_]+\.md' "$INDEX_FILE" | sort -u)
    
    for mentioned in $mentioned_files; do
        # Vérifier si le fichier existe dans docs/
        if [[ -f "$DOCS_DIR/$mentioned" ]] || [[ -f "$ROOT_DIR/$mentioned" ]]; then
            echo -e "  ${GREEN}✓${NC} $mentioned"
        else
            echo -e "  ${YELLOW}?${NC} $mentioned (mentionné mais non trouvé)"
            ((WARNINGS++))
        fi
    done
else
    echo -e "  ${RED}✗${NC} DOCUMENTATION_INDEX.md non trouvé"
    ((ERRORS++))
fi
echo ""

# ==============================================================================
# 4. Vérifier la version du SDK documentée vs PyPI (optionnel)
# ==============================================================================
echo "📦 [4/4] Vérification de la version SDK (optionnel)..."

# Vérifier si curl est disponible
if command -v curl &> /dev/null; then
    # Récupérer la dernière version depuis PyPI
    PYPI_VERSION=$(curl -s https://pypi.org/pypi/reachy-mini/json 2>/dev/null | grep -o '"version":"[^"]*"' | head -1 | cut -d'"' -f4)
    
    if [[ -n "$PYPI_VERSION" ]]; then
        echo -e "  ${GREEN}✓${NC} Version PyPI actuelle: $PYPI_VERSION"
        
        # Vérifier si le badge PyPI dynamique est utilisé (meilleure pratique)
        if grep -q "pypi/v/reachy-mini" "$ROOT_DIR/README.md" 2>/dev/null; then
            echo -e "  ${GREEN}✓${NC} Badge PyPI dynamique utilisé (auto-update)"
        elif grep -q "$PYPI_VERSION" "$ROOT_DIR/README.md" 2>/dev/null; then
            echo -e "  ${GREEN}✓${NC} Version documentée à jour dans README"
        else
            echo -e "  ${YELLOW}!${NC} README mentionne peut-être une ancienne version (non bloquant)"
            ((WARNINGS++)) || true
        fi
    else
        echo -e "  ${YELLOW}?${NC} Impossible de vérifier la version PyPI"
    fi
else
    echo -e "  ${YELLOW}?${NC} curl non disponible, vérification SDK ignorée"
fi
echo ""

# ==============================================================================
# Résumé
# ==============================================================================
echo "==========================================================="
echo "📊 Résumé"
echo "==========================================================="

if [[ $ERRORS -eq 0 ]] && [[ $WARNINGS -eq 0 ]]; then
    echo -e "${GREEN}✅ Toutes les vérifications sont passées!${NC}"
    exit 0
elif [[ $ERRORS -eq 0 ]]; then
    echo -e "${YELLOW}⚠️  $WARNINGS warning(s) - pas d'erreurs bloquantes${NC}"
    exit 0
else
    echo -e "${RED}❌ $ERRORS erreur(s), $WARNINGS warning(s)${NC}"
    exit 1
fi
