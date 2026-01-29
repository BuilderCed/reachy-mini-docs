# Changelog

Toutes les modifications notables de cette documentation sont documentées ici.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.0] - 2026-01-29

### Ajouté
- 📚 **Documentation complète** - 7 fichiers de documentation (4000+ lignes)
  - `DOCUMENTATION_INDEX.md` - Navigation par topic
  - `EXECUTIVE_SUMMARY.md` - Vue d'ensemble rapide
  - `MASTER_CHECKLIST.md` - Flowchart décision + checklists
  - `QUICK_REFERENCE_v2.md` - Cheat sheet SDK
  - `REACHY_MINI_COMPLETE_GUIDE.md` - Guide exhaustif
  - `README_TEMPLATE.md` - Template pour apps
  - `SUPER_PROMPTS_READY.md` - Prompts copy-paste pour IA

- 🔐 **Gestion des clés** - Séparation Claude Desktop / Cursor
  - `.env.example` avec documentation complète
  - Instructions macOS Keychain
  - Traçabilité par outil

- 🔄 **Automation** - Vérification automatique
  - `scripts/verify-docs.sh` - Vérification intégrité locale
  - `.github/workflows/docs-verify.yml` - CI GitHub Actions
  - Vérification liens, fichiers, cohérence index

- 🛡️ **Sécurité** - Limites documentées
  - Joints limits (head/body)
  - Kids mode (vitesse, durée, session)
  - Emergency stop

### SDK
- Aligné sur SDK v1.2.0 (PyPI)
- API: `with ReachyMini()`, `goto_target()`, `create_head_pose()`

---

## [1.1.0] - 2026-01-29

### Ajouté
- 🔒 **SECURITY.md** - Politique de sécurité et bonnes pratiques
- 📝 **CONTRIBUTING.md** - Guide de contribution
- 👥 **CODEOWNERS** - Gouvernance des reviews
- 🤖 **Dependabot** - Mises à jour automatiques des dépendances

### Amélioré
- 🔍 **Workflow CI** - Scan de secrets, validation liens, check version SDK
- 📊 **Jobs parallèles** - Vérification plus rapide

---

## [Unreleased]

### À faire
- [ ] Ajouter des exemples vidéo
- [ ] Traduire en anglais
- [ ] Ajouter des tests d'intégration

---

## Versioning

Ce projet utilise [Semantic Versioning](https://semver.org/):
- **MAJOR**: Changements incompatibles (ex: restructuration complète)
- **MINOR**: Ajouts rétrocompatibles (ex: nouveau document)
- **PATCH**: Corrections (ex: typo, lien cassé)
