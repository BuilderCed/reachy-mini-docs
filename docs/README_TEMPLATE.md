# [YOUR APP NAME] - Reachy Mini Robot App
*An interactive [app category] built with Reachy Mini + AI*

---

## 📋 Overview

**[App Description in 1-2 sentences]**

Example: "Interactive Dance Robot plays music and dances along with you. Features voice commands, gesture recognition, and multi-turn conversations."

### Features
- 🎤 Speech recognition (ASR) - understand what you say
- 💬 AI responses (LLM) - answer intelligently
- 🎨 Dynamic gestures - express emotions
- 👁️ Vision awareness - see and understand surroundings
- 🎭 Multi-turn conversations - natural dialogue flow
- 👨‍👩‍👧 Kids-friendly mode - safety limits & content filtering

### Target Audience
- [ ] Kids (4-12 years)
- [ ] Teens (13-17 years)
- [ ] Adults
- [ ] Developers
- [ ] Other: _______

---

## 🚀 Quick Start

### Prerequisites
- Reachy Mini Wireless (or Lite/Simulation)
- Python 3.10+
- Anthropic API key (for Claude)
- macOS / Linux / Windows

### Installation

```bash
# 1. Clone repo
git clone https://github.com/YOUR-USERNAME/YOUR-REPO.git
cd YOUR-REPO

# 2. Virtual environment
python3 -m venv venv
source venv/bin/activate  # macOS/Linux
# or: venv\\Scripts\\activate  # Windows

# 3. Install dependencies
pip install -r requirements.txt

# 4. Set environment variables (use macOS Keychain recommended)
export ANTHROPIC_API_KEY="your-key-here"
export REACHY_HOST="reachy.local"

# 5. Verify setup
python -c "from reachy_mini import ReachyMini; print('✓ OK')"
```

### Running the App

```bash
# Quick test (1 interaction)
python -m YOUR_APP_NAME --demo

# Full app
python -m YOUR_APP_NAME

# With kids mode enabled
python -m YOUR_APP_NAME --kids-mode

# Simulation mode (no hardware)
python -m YOUR_APP_NAME --sim
```

---

## 📖 Usage Examples

### Example 1: Basic Usage
```python
from YOUR_APP_NAME import YourApp
from reachy_mini import ReachyMini

with ReachyMini() as reachy:
    app = YourApp(reachy)
    app.startup()
    app.interact()
    app.shutdown()
```

### Example 2: Interactive Session
```bash
$ python -m YOUR_APP_NAME
✓ Connected to Reachy Mini (Battery: 85%)
✓ Daemon responding
✓ All health checks passed

🎤 Listening... 
> "What's your name?"
💬 "I'm Reachy! Nice to meet you!"
🎭 [Robot nods]

🎤 Listening...
> "Tell me a joke"
💬 "Why did the robot go to school? To improve its byte-ness!"
🎭 [Robot laughs]

⏱️ Session: 5 min | Battery: 80% | Tokens: 450/10000
```

---

## 🎯 Architecture

```
┌─────────────────────────────────────┐
│    Your Mac (Intel/M4)              │
│  ┌───────────────────────────────┐  │
│  │  Your App (this script)       │  │
│  │  - Speech recognition (ASR)   │  │
│  │  - LLM integration (Claude)   │  │
│  │  - Vision processing (VLM)    │  │
│  └──────────────┬────────────────┘  │
│                 │ gRPC over Wi-Fi    │
└─────────────────┼───────────────────┘
                  │
        ┌─────────┴──────────┐
        │  Reachy Mini Base   │
        │  ┌────────────────┐ │
        │  │ Raspberry Pi 5 │ │
        │  │ (daemon)       │ │
        │  └────────────────┘ │
        │  - Head movement    │
        │  - Audio I/O        │
        │  - Camera capture   │
        └────────────────────┘
```

**Flow:**
1. **Perceive** - Listen (audio) + Look (camera)
2. **Decide** - Call LLM with context
3. **Act** - Move (gesture) + Speak (TTS)
4. **Loop** - Maintain conversation

---

## ⚙️ Configuration

See [.env.example](../.env.example) for all variables.

### Environment Variables

| Variable | Default | Description |
|----------|---------|------------|
| `ANTHROPIC_API_KEY` | (required) | Your Claude API key |
| `REACHY_HOST` | `reachy.local` | Robot hostname or IP |
| `REACHY_PORT` | `50051` | gRPC port |
| `KIDS_MODE` | `false` | Enable safety limits |
| `MAX_SESSION_MINUTES` | `60` | Max session duration |
| `TOKEN_BUDGET` | `10000` | Daily LLM token limit |
| `LOG_LEVEL` | `INFO` | Python logging level |

---

## 🛡️ Safety & Supervision

### Before Each Session (Mandatory!)

```
☐ Robot powered on
☐ Battery > 30%
☐ No motor errors (check Dashboard)
☐ Kids mode ENABLED (if children present)
☐ Emergency stop tested (Ctrl+C)
☐ Adult supervision confirmed
☐ Play area cleared (1m radius)
```

### Safety Features

- **Speed limit:** 50% (kids mode) or 100% (normal)
- **Motion duration:** Min 1.5s (kids) / 0.3s (normal)
- **Session timeout:** Max 30 min per session
- **Battery protection:** Auto-stop if < 20%
- **Thermal protection:** Auto-stop if > 60°C
- **Content filter:** Blocks inappropriate responses
- **Emergency stop:** Ctrl+C immediately disables motors

---

## 📊 Performance Metrics

### Target Performance

| Metric | Target | Typical | Status |
|--------|--------|---------|-------|
| Move latency | < 100ms | ~50ms | ✓ |
| LLM response | < 2s | ~1.2s | ✓ |
| Network latency | < 50ms | ~25ms | ✓ |
| CPU usage | < 50% | ~35% | ✓ |
| Memory | < 200MB | ~150MB | ✓ |
| Battery drain | < 5%/h | ~3%/h | ✓ |
| Thermal | < 60°C | ~50°C | ✓ |

---

## 🐛 Troubleshooting

### "Daemon unreachable"
```bash
# Check if robot is on
ping reachy.local

# Check dashboard
open http://reachy.local:8000

# If still failing
ssh pi@reachy.local
sudo systemctl status reachy-mini-daemon
```

### "Network latency high"
```bash
# Get closer to Wi-Fi router
# Check for interference
# Restart router
ping -c 10 reachy.local  # Measure latency
```

### "Motor errors"
```bash
# Check Dashboard → Logs
# Power cycle robot (OFF → wait 5s → ON)
# Contact support if persists
```

---

## 🧪 Testing

### Unit Tests
```bash
pytest tests/unit/ -v
```

### Integration Tests
```bash
pytest tests/integration/ -v  # Requires real robot
```

### Network Resilience Test
```bash
# Disable Wi-Fi during app execution
# Verify graceful degradation (no crash)
# Re-enable Wi-Fi
# Verify recovery
```

---

## 📚 Documentation

- **Setup Guide:** See [REACHY_MINI_COMPLETE_GUIDE.md](./REACHY_MINI_COMPLETE_GUIDE.md)
- **API Reference:** See [QUICK_REFERENCE_v2.md](./QUICK_REFERENCE_v2.md)
- **Advanced Patterns:** See [SUPER_PROMPTS_READY.md](./SUPER_PROMPTS_READY.md)
- **Safety Checklist:** See [MASTER_CHECKLIST.md](./MASTER_CHECKLIST.md)

---

## 🤝 Contributing

### Found a bug?
1. Check existing issues
2. Open a new issue with:
   - Reachy Mini variant (Wireless/Lite/Sim)
   - Python version
   - Steps to reproduce
   - Expected vs. actual behavior

### Code Style
```bash
# Format code
black .

# Type check
mypy .

# Lint
ruff check .

# Run tests
pytest --cov=. --cov-report=term-missing
```

---

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|--------|
| `reachy-mini` | ≥1.2.0 | Robot SDK |
| `anthropic` | ≥0.7.0 | Claude API client |
| `transformers` | ≥4.30 | ASR/TTS models |
| `python-dotenv` | ≥0.21 | Environment config |

See `requirements.txt` for exact versions.

---

## 📝 License

[Choose: MIT, Apache 2.0, GPL, etc.]

---

## 👥 Authors

- **Your Name** (main developer)
- **Contributors:** [list]

---

## 🙏 Acknowledgments

- **Pollen Robotics** for Reachy Mini platform
- **Anthropic** for Claude API
- **Hugging Face** for ASR/TTS models
- **Community:** Special thanks to Discord contributors

---

## 📞 Support

### Getting Help

1. **Documentation** → See links above
2. **GitHub Issues** → https://github.com/pollen-robotics/reachy_mini/issues
3. **Discord** → https://discord.gg/pollen-robotics
4. **Email** → support@pollen-robotics.com

---

## 📈 Roadmap

- [ ] v1.0.0 - Initial release
- [ ] v1.1.0 - Add [feature X]
- [ ] v1.2.0 - Add [feature Y]
- [ ] v2.0.0 - Multi-robot support
- [ ] Future: [your ideas]

---

## ⭐ Show Your Support

If you found this app useful, please:
- ⭐ Star this repo
- 📢 Share with others
- 💬 Give feedback
- 🐛 Report bugs
- 💡 Suggest features

---

## 🎉 Changelog

### [1.0.0] - 2026-01-XX
- Initial release
- Speech recognition
- Multi-turn conversations
- Dynamic gestures
- Vision awareness
- Kids mode
- Performance monitoring

---

**Last Updated:** January 2026  
**Status:** ✅ Production Ready  
**Version:** 1.0.0