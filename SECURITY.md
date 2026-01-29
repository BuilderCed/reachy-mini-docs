# Sécurité - Reachy Mini Documentation

## Signalement de vulnérabilités

Si vous découvrez une vulnérabilité de sécurité, veuillez **ne pas** ouvrir une issue publique.

Contactez: security@pollen-robotics.com (ou créez une issue privée via GitHub Security Advisory)

## Bonnes pratiques de sécurité

### Clés API

- **JAMAIS** de clés API dans le code source
- **JAMAIS** de clés dans les fichiers de documentation
- Utiliser macOS Keychain ou un gestionnaire de secrets
- Rotation des clés tous les 90 jours

### Configuration Keychain (macOS)

```bash
# Stocker une clé
security add-generic-password -a "account" -s "service" -w "secret" -U

# Lire une clé
security find-generic-password -a "account" -s "service" -w
```

### GitHub Tokens

Utiliser des **Fine-grained Personal Access Tokens** avec:
- Portée limitée à un seul repository
- Permissions minimales (Contents: Read/Write uniquement si nécessaire)
- Expiration courte (90 jours max)

### Code généré par IA

Les risques identifiés (2025-2026):
1. **45% du code IA** contient des vulnérabilités OWASP Top 10
2. **70-80%** reproduit des bugs existants
3. **60-70%** n'est pas prêt pour la production

Mitigations obligatoires:
- Revue humaine de tout code généré
- Analyse statique (SAST) avant merge
- Tests automatisés
- Validation des dépendances (SCA)

## Vérifications automatiques

Ce repository utilise GitHub Actions pour:
- Scanner les patterns de secrets dans les docs
- Vérifier les liens internes/externes
- Valider l'intégrité de la documentation

## Limites du robot

### Limites physiques (auto-clamp)

| Joint | Min | Max |
|-------|-----|-----|
| head.pitch | -40° | +40° |
| head.roll | -40° | +40° |
| head.yaw | -180° | +180° |
| body.yaw | -160° | +160° |

### Mode enfants (Kids Mode)

Obligatoire pour toute interaction avec des enfants:
- Vitesse réduite à 50%
- Durée minimale des mouvements: 1.5s
- Session maximale: 30 minutes
- Supervision adulte requise
- Filtrage du contenu LLM

## Ressources

- [OWASP Top 10](https://owasp.org/Top10/)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [Pollen Robotics Support](mailto:support@pollen-robotics.com)
