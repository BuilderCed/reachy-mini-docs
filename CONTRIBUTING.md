# Contribuer à Reachy Mini Docs

## Workflow

1. **Fork** le repository (ou créer une branche si vous avez accès)
2. **Modifier** les fichiers dans `docs/`
3. **Mettre à jour** `docs/CHANGELOG.md`
4. **Vérifier** localement avec `./scripts/verify-docs.sh`
5. **Créer** une Pull Request

## Structure des fichiers

```
docs/
├── DOCUMENTATION_INDEX.md   # Navigation principale
├── QUICK_REFERENCE_v2.md    # Cheat sheet (5 min)
├── MASTER_CHECKLIST.md      # Checklists sécurité/décision
├── SUPER_PROMPTS_READY.md   # Prompts pour Claude/ChatGPT
├── REACHY_MINI_COMPLETE_GUIDE.md  # Guide exhaustif
├── README_TEMPLATE.md       # Template pour vos apps
├── EXECUTIVE_SUMMARY.md     # Vue d'ensemble
└── CHANGELOG.md             # Historique des modifications
```

## Standards de documentation

### Format

- Markdown standard (GitHub Flavored)
- Titres hiérarchiques (# pour titre principal, ## pour sections)
- Blocs de code avec langage spécifié (```python, ```bash)
- Tableaux pour les données structurées

### Langue

- **Explications**: Français
- **Code et commentaires**: Anglais
- **Termes techniques**: Anglais

### Qualité

- Pas de placeholders ("...")
- Code testé et fonctionnel
- Liens internes valides
- Pas de secrets dans les exemples

## Vérification locale

```bash
# Cloner le repo
git clone https://github.com/BuilderCed/reachy-mini-docs.git
cd reachy-mini-docs

# Rendre le script exécutable
chmod +x scripts/verify-docs.sh

# Vérifier
./scripts/verify-docs.sh
```

## Convention de commits

Format: `type(scope): description`

Types:
- `feat`: Nouvelle documentation
- `fix`: Correction
- `docs`: Mise à jour contenu
- `chore`: Maintenance
- `refactor`: Réorganisation

Exemples:
- `docs(quick-ref): add VLM example`
- `fix(links): correct broken link to SDK`
- `chore(deps): update actions versions`

## Pull Request

### Checklist

- [ ] `./scripts/verify-docs.sh` passe
- [ ] CHANGELOG.md mis à jour
- [ ] Pas de secrets dans le code
- [ ] Liens internes valides
- [ ] Code testé si applicable

### Review

Les PRs sont reviewées pour:
- Exactitude technique
- Clarté
- Sécurité (pas de secrets)
- Cohérence avec le reste de la doc

## Questions

Ouvrir une issue ou contacter via Discord: https://discord.gg/pollen-robotics
