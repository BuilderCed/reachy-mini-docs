# 🤖 Reachy Mini Documentation Bible

> **Source unique de vérité** pour le développement Reachy Mini avec Claude, Cursor et Python SDK.

[![Documentation Verification](https://github.com/BuilderCed/reachy-mini-docs/actions/workflows/docs-verify.yml/badge.svg)](https://github.com/BuilderCed/reachy-mini-docs/actions/workflows/docs-verify.yml)
[![Last Updated](https://img.shields.io/badge/updated-January%202026-blue.svg)](./docs/CHANGELOG.md)
[![SDK Version](https://img.shields.io/pypi/v/reachy-mini?label=SDK&color=green)](https://pypi.org/project/reachy-mini/)

---

## 📚 Navigation rapide

| Document | Objectif | Temps |
|----------|----------|-------|
| **[QUICK_REFERENCE](./docs/QUICK_REFERENCE_v2.md)** | Cheat sheet 5 min + patterns courants | 10 min |
| **[MASTER_CHECKLIST](./docs/MASTER_CHECKLIST.md)** | Flowchart décision + checklist sécurité | 5 min |
| **[SUPER_PROMPTS](./docs/SUPER_PROMPTS_READY.md)** | Prompts copy-paste pour Claude/ChatGPT | 15 min |
| **[COMPLETE_GUIDE](./docs/REACHY_MINI_COMPLETE_GUIDE.md)** | Référence exhaustive (1000+ lignes) | 60 min |
| **[DOCUMENTATION_INDEX](./docs/DOCUMENTATION_INDEX.md)** | Navigation par topic | 5 min |
| **[README_TEMPLATE](./docs/README_TEMPLATE.md)** | Template pour vos apps | - |
| **[EXECUTIVE_SUMMARY](./docs/EXECUTIVE_SUMMARY.md)** | Vue d'ensemble rapide | 5 min |

---

## 🚀 Quick Start

```bash
# 1. Virtual env
python3 -m venv reachy-env
source reachy-env/bin/activate

# 2. Install SDK
pip install reachy-mini

# 3. Test connection
python3 << 'EOF'
from reachy_mini import ReachyMini
from reachy_mini.utils import create_head_pose

with ReachyMini() as reachy:
    print(f"✓ Connecté! Battery: {reachy.battery_level}%")
    pose = create_head_pose(pitch=10, degrees=True)
    reachy.goto_target(head=pose, duration=1.0)
EOF

# 4. Dashboard
open http://reachy.local:8000
```

---

## 🔧 SDK - API Officielle

```python
from reachy_mini import ReachyMini
from reachy_mini.utils import create_head_pose

# Context manager (synchrone)
with ReachyMini() as reachy:
    # Mouvement tête
    pose = create_head_pose(pitch=10, roll=5, yaw=20, degrees=True)
    reachy.goto_target(head=pose, duration=1.0)
    
    # Rotation base
    reachy.goto_target(body_yaw=45, duration=1.0)
    
    # Antennes
    reachy.goto_target(antennas=[0.5, -0.5], duration=0.5)
    
    # État
    print(f"Battery: {reachy.battery_level}%")
```

---

## 🛡️ Limites de sécurité

| Joint | Min | Max | Notes |
|-------|-----|-----|-------|
| head.pitch | -40° | +40° | Nod down/up |
| head.roll | -40° | +40° | Tilt left/right |
| head.yaw | -180° | +180° | Turn left/right |
| body.yaw | -160° | +160° | Base rotation |
| Combined | - | - | \|head.yaw - body.yaw\| ≤ 65° |

---

## 🔐 Configuration des clés API

Voir [.env.example](./.env.example) pour la liste des variables.

### macOS Keychain (recommandé)

```bash
# Claude Desktop / Apps Reachy
security add-generic-password -a "reachy_apps" -s "ANTHROPIC_API_KEY" -w "YOUR_API_KEY" -U

# Cursor (clé séparée pour traçabilité)
# Configurer directement dans Cursor > Settings > API

# Lecture
security find-generic-password -a "reachy_apps" -s "ANTHROPIC_API_KEY" -w
```

### GitHub Token (pour automation)

Créer un **Fine-grained Personal Access Token**:
1. GitHub → Settings → Developer settings → Personal access tokens → Fine-grained
2. Resource owner: **ton compte personnel** (pas d'organisation)
3. Repository access: **Only select repositories** → reachy-mini-docs
4. Permissions:
   - **Contents**: Read and write
   - **Metadata**: Read (auto)
5. Stocker dans Keychain: `security add-generic-password -a "github_automation" -s "GITHUB_PAT" -w "YOUR_TOKEN" -U`

---

## 📁 Structure du repo

```
reachy-mini-docs/
├── README.md                 # Ce fichier
├── .env.example              # Variables d'environnement
├── docs/
│   ├── CHANGELOG.md
│   ├── DOCUMENTATION_INDEX.md
│   ├── EXECUTIVE_SUMMARY.md
│   ├── MASTER_CHECKLIST.md
│   ├── QUICK_REFERENCE_v2.md
│   ├── README_TEMPLATE.md
│   ├── REACHY_MINI_COMPLETE_GUIDE.md
│   └── SUPER_PROMPTS_READY.md
├── scripts/
│   └── verify-docs.sh        # Vérification intégrité
└── .github/
    └── workflows/
        └── docs-verify.yml   # CI automatique
```

---

## 🔗 Liens essentiels

| Ressource | URL |
|-----------|-----|
| **Dashboard Robot** | http://reachy.local:8000 |
| **PyPI SDK** | https://pypi.org/project/reachy-mini/ |
| **GitHub Pollen** | https://github.com/pollen-robotics/reachy_mini |
| **HuggingFace Hub** | https://huggingface.co/pollen-robotics |
| **Discord** | https://discord.gg/pollen-robotics |

---

## 🔄 Routine de vérification

```bash
# Lancer la vérification locale
./scripts/verify-docs.sh

# Ou via GitHub Actions (automatique sur push/schedule)
```

La CI vérifie:
- Tous les fichiers référencés dans l'index existent
- Liens internes valides
- Pas de références obsolètes

---

## 📝 Contribuer

1. Éditer les fichiers dans `docs/`
2. Mettre à jour `docs/CHANGELOG.md`
3. Lancer `./scripts/verify-docs.sh`
4. Commit + push

---

**Dernière mise à jour:** Janvier 2026  
**Status:** ✅ Production Ready  
**SDK:** Voir badge PyPI ci-dessus