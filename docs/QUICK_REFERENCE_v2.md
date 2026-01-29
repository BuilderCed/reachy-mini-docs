# 📋 REACHY MINI - QUICK REFERENCE & CHECKLISTS
## Janvier 2026 | Pour consultation rapide

> **SDK v1.2.0** - API officielle validée PyPI

---

## 🎯 QUICK START (5 minutes)

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
    print(f"✓ Battery: {reachy.battery_level}%")
    pose = create_head_pose(pitch=10, degrees=True)
    reachy.goto_target(head=pose, duration=1.0)
EOF

# 4. Open dashboard
open http://reachy.local:8000
```

✓ **If battery shows = you're ready!**

---

## 📐 COORDINATE SYSTEM (à mémoriser)

```
Head (relative to head):
├─ pitch   : -40° to +40°  (nod down/up)
├─ roll    : -40° to +40°  (tilt left/right)
└─ yaw     : -180° to +180° (turn left/right)

Body (rotate base):
└─ yaw     : -160° to +160° (full rotation, almost)

Rule: |head_yaw - body_yaw| ≤ 65°
```

---

## 💻 SDK CHEAT SHEET (v1.2.0)

### Connect

```python
from reachy_mini import ReachyMini
from reachy_mini.utils import create_head_pose

# Context manager synchrone (SDK v1.2.0)
with ReachyMini() as reachy:
    # Your code here
    print(f"Battery: {reachy.battery_level}%")
```

### Move

```python
# Head
pose = create_head_pose(pitch=10, roll=-5, yaw=20, degrees=True)
reachy.goto_target(head=pose, duration=1.0)

# Body (base)
reachy.goto_target(body_yaw=45, duration=1.0)

# Antennas
reachy.goto_target(antennas=[0.5, -0.5], duration=0.5)

# Combined
reachy.goto_target(
    head=create_head_pose(pitch=5),
    antennas=[0.3, 0.3],
    body_yaw=-30,
    duration=1.5
)
```

### Motor control

```python
reachy.enable_motors()           # Stiff
reachy.disable_motors()          # Limp
reachy.enable_gravity_compensation()  # Soft
```

### Audio

```python
# Microphone
sample = reachy.media.get_audio_sample()

# Camera
frame = reachy.media.get_frame()  # OpenCV format (BGR)

# Speaker
reachy.media.push_audio_sample(audio_data)
```

### State

```python
print(reachy.battery_level)      # 0-100
print(reachy.version)            # Firmware version
print(reachy.state)              # Full state dict
```

---

## 🔒 SAFETY LIMITS (à connaître par cœur)

| Joint | Min | Max | Comment |
|-------|-----|-----|--------|
| head.pitch | -40° | +40° | Baisse/lève |
| head.roll | -40° | +40° | Penche |
| head.yaw | -180° | +180° | Tourne |
| body.yaw | -160° | +160° | Base rotate |
| \|head.yaw - body.yaw\| | – | ≤65° | Combined limit |

**AUTO-CLAMP:** SDK clamps automatiquement. Pas de crash. ✓

---

## 🧠 AI QUICK MODELS

### ASR (Speech→Text)
```python
from transformers import pipeline

pipe = pipeline("automatic-speech-recognition",
               model="openai/whisper-tiny")
text = pipe(audio_array)["text"]
```

### TTS (Text→Speech)
```python
from transformers import pipeline

pipe = pipeline("text-to-speech",
               model="suno/bark")
output = pipe("Hello world")["audio"]
reachy.media.push_audio_sample(output)
```

### VLM (Vision + Language)
```python
from anthropic import Anthropic
import base64

client = Anthropic()
# Convert frame to base64...
response = client.messages.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=256,
    messages=[{
        "role": "user",
        "content": [
            {"type": "image", "source": {"type": "base64", "media_type": "image/jpeg", "data": img_b64}},
            {"type": "text", "text": "What do you see?"}
        ]
    }]
)
```

### LLM (Claude) with Context
```python
from anthropic import Anthropic

client = Anthropic()

# Multi-turn conversation
messages = [
    {"role": "user", "content": "Hi!"},
    {"role": "assistant", "content": "Hello! How can I help?"},
    {"role": "user", "content": "Tell me a joke"}
]

response = client.messages.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=256,
    messages=messages
)
text = response.content[0].text
```

---

## 🎯 MULTIMODAL INTERACTION

```python
# Listen + Look + React pattern
def interact(reachy):
    # 1. Listen (ASR)
    audio = reachy.media.get_audio_sample()
    text = asr.transcribe(audio)
    
    # 2. Look (VLM)
    frame = reachy.media.get_frame()
    visual_context = vlm.analyze(frame, "What am I seeing?")
    
    # 3. Think (LLM)
    response = llm.chat([
        {"role": "user", "content": f"{text}\n[Context: {visual_context}]"}
    ])
    
    # 4. Respond (TTS + Motion)
    audio = tts.speak(response)
    reachy.media.push_audio_sample(audio)
    reachy.goto_target(antennas=[0.5, 0.5], duration=0.5)
```

---

## 🔄 CONVERSATION CONTEXT

```python
# Keep multi-turn conversation history
context_messages = [
    {"role": "user", "content": "What's your name?"},
    {"role": "assistant", "content": "I'm Reachy!"},
    {"role": "user", "content": "Nice to meet you"}
]

# Each call includes full context (saves coherence)
response = client.messages.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=256,
    messages=context_messages  # Full history!
)

# Add response to history
context_messages.append({"role": "assistant", "content": response.content[0].text})
```

---

## ⚡ REAL-TIME STATE MACHINE

```python
from enum import Enum

class State(Enum):
    IDLE = "idle"
    LISTENING = "listening"
    THINKING = "thinking"
    RESPONDING = "responding"

current_state = State.IDLE

def transition(event: str):
    global current_state
    
    transitions = {
        (State.IDLE, "user_talks"): State.LISTENING,
        (State.LISTENING, "done_listening"): State.THINKING,
        (State.THINKING, "response_ready"): State.RESPONDING,
        (State.RESPONDING, "done_responding"): State.IDLE,
    }
    
    key = (current_state, event)
    if key in transitions:
        current_state = transitions[key]
        print(f"State: {current_state.value}")
        # Execute action for new state...
```

---

## 📊 MONITORING BASICS

```python
import logging

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Log every interaction
logger.info(f"Movement: head_pitch={pitch}, duration={duration}")
logger.error(f"API Error: {error_msg}")
```

---

## ⚡ PERFORMANCE TARGETS

| Metric | Target | Current | Status |
|--------|--------|---------|-------|
| Latency (move) | <100ms | ? | |
| Latency (LLM) | <2s | ? | |
| CPU usage | <50% | ? | |
| Memory | <200MB | ? | |
| WiFi (RSSI) | >-70dBm | ? | |
| Battery drain | <5%/hour | ? | |
| Thermal | <60°C | ? | |

---

## 📱 DASHBOARD (http://reachy.local:8000)

| Tab | Use For |
|-----|--------|
| **Home** | Battery %, version, mode |
| **Motions** | Test pre-built motions |
| **Logs** | Errors, warnings, thermal alerts |
| **Settings** | WiFi, updates, reboot |
| **API Docs** | OpenAPI interactive |

**Good habit:** Check dashboard before every session!

---

## 🐛 COMMON ERRORS & FIXES

| Error | Cause | Fix |
|-------|-------|----|
| `Daemon unreachable` | Network issue | Ping reachy.local, restart robot |
| `Motor overload` | Misaligned motor | Check assembly (motor 1→slot 1) |
| `High latency` | WiFi degraded | Get closer to router |
| `Import error: reachy_mini` | SDK not installed | `pip install reachy-mini` |
| `Permission denied /dev/tty` | USB permissions (Lite) | `sudo chmod a+rw /dev/tty*` |
| `Audio volume low` | Firmware old | `apt update && apt upgrade` |
| `Head touches body` | Extreme pose | Reduce pitch/roll magnitude |

---

## 🔐 KIDS MODE ESSENTIALS

```python
class KidsMode:
    MAX_SPEED = 0.5         # 50% speed
    MIN_DURATION = 1.5      # Min 1.5s per move
    MAX_SESSION = 1800      # 30 minutes
    BATTERY_MIN = 20        # Stop if <20%
    THERMAL_MAX = 60        # °C
```

**Before session:**
- [ ] Battery > 30%
- [ ] No motor errors
- [ ] Cleared play area
- [ ] Adult can stop (Ctrl+C)

---

## 📊 API BUDGET TRACKING

```python
# Daily budget: 10,000 tokens
# Per request: 500 tokens max
# Cost estimate: 1 token ≈ 4 chars

def estimate_tokens(text):
    return max(50, len(text) // 4)

# Log every API call
print(f"Used: {tokens_used}/{daily_budget} tokens")

# Optimize: use cache for frequent phrases
cached_responses = {
    "greeting": "Hello! I'm Reachy.",
}
```

---

## 🔧 QUICK TROUBLESHOOTING

```bash
# Check daemon running
ping reachy.local

# View daemon logs (SSH)
ssh pi@reachy.local
journalctl -u reachy-mini-daemon -f

# Restart daemon (SSH)
ssh pi@reachy.local
sudo systemctl restart reachy-mini-daemon

# Update software (SSH)
ssh pi@reachy.local
cd ~/reachy_mini && git pull
pip install -e .
sudo systemctl restart reachy-mini-daemon

# Check temperature (SSH)
ssh pi@reachy.local
vcgencmd measure_temp

# Emergency: Power cycle robot
# OFF button → Wait 5s → ON button
```

---

## 📦 VENV REMINDER

```bash
# Create
python3 -m venv reachy-env

# Activate (EVERY new terminal!)
source reachy-env/bin/activate

# Install deps
pip install reachy-mini

# Deactivate (when done)
deactivate
```

---

## 🎨 EMOTIONS QUICK MAP

```python
EMOTIONS = {
    "happy": {
        "antennas": [0.5, 0.5],
        "head": create_head_pose(pitch=5),
        "duration": 0.3
    },
    "sad": {
        "antennas": [-0.3, -0.3],
        "head": create_head_pose(pitch=-10),
        "duration": 0.5
    },
    "curious": {
        "head": create_head_pose(yaw=20),
        "antennas": [0.2, -0.2],
        "duration": 0.3
    },
    "thinking": {
        "head": create_head_pose(roll=10),
        "duration": 1.0
    },
}
```

---

## 🚀 DEPLOYMENT CHECKLIST

```markdown
## Before Production

### Code Quality
- [ ] `mypy .` (type check)
- [ ] `ruff check .` (lint)
- [ ] `black --check .` (format)
- [ ] `pytest --cov=.` (>80% coverage)

### Safety
- [ ] Kids mode enabled (if for kids)
- [ ] Emergency stop tested
- [ ] All poses validated
- [ ] Content filter in place

### Performance
- [ ] <100ms latency measured
- [ ] <50% CPU sustained
- [ ] Network resilience tested
- [ ] Token budget tracked

### Reliability
- [ ] Health checks running
- [ ] Logs structured
- [ ] Monitoring dashboard working
- [ ] Graceful degradation tested

### Documentation
- [ ] README.md complete
- [ ] API documented
- [ ] Configuration examples
- [ ] Troubleshooting guide

### Deployment
- [ ] Version tagged (SemVer)
- [ ] Changelog updated
- [ ] Installation tested
- [ ] Dashboard accessible

✅ ALL CHECKED = READY TO DEPLOY!
```

---

## 🔗 ESSENTIAL LINKS

- **Docs:** https://github.com/pollen-robotics/reachy_mini
- **PyPI:** https://pypi.org/project/reachy-mini/
- **HF Hub:** https://huggingface.co/pollen-robotics
- **Discord:** https://discord.gg/pollen-robotics
- **GitHub Issues:** https://github.com/pollen-robotics/reachy_mini/issues

---

## 📈 METRICS TO TRACK

```python
# In your app, log these:
metrics = {
    "timestamp": time.time(),
    "battery_percent": reachy.battery_level,
    "movement_latency_ms": latency,
    "llm_latency_ms": llm_time,
    "api_tokens_used": tokens,
    "cpu_percent": psutil.cpu_percent(),
    "memory_mb": psutil.virtual_memory().used / 1024**2,
    "error_count": error_count,
}
```

---

## 🎯 COMMON TASKS (Code Patterns)

### Task: "Make robot greet someone"
```python
# 1. Look at person (head)
reachy.goto_target(head=create_head_pose(pitch=-5), duration=0.5)
# 2. Wave (antennas)
reachy.goto_target(antennas=[0.7, 0.7], duration=0.3)
# 3. Say hello (TTS)
audio = tts.speak("Hello!")
reachy.media.push_audio_sample(audio)
```

### Task: "Listen & respond"
```python
# 1. Listen (ASR)
audio = reachy.media.get_audio_sample()
text = asr.transcribe(audio)
# 2. Think (LLM)
response = llm.chat(text)
# 3. Express (TTS + motion)
audio = tts.speak(response)
reachy.goto_target(antennas=[0.3, 0.3])  # Curious pose
reachy.media.push_audio_sample(audio)
```

### Task: "Follow face"
```python
import cv2
from mediapipe import Face

face_detector = Face()
frame = reachy.media.get_frame()
faces = face_detector.detect(frame)
if faces:
    face = faces[0]
    x_center = face.center_x
    # Map x_center to head yaw
    yaw = (x_center - 0.5) * 80  # Scale to -40 to +40
    reachy.goto_target(head=create_head_pose(yaw=yaw, degrees=True))
```

---

## 🎓 LEARNING PATH

1. **Week 1:** Setup + Basic movements (section 1-3)
2. **Week 2:** Add audio (ASR/TTS) (section 9.1-9.2)
3. **Week 3:** Integrate LLM (Claude) (section 9.4)
4. **Week 4:** Safety + Testing (section 6, testing prompts)
5. **Week 5:** Deployment (section 13)

**Time estimate:** ~20 hours total for full app.

---

## 💡 PRO TIPS

1. **Always use virtual env** (isolates dependencies)
2. **Test in simulation first** (before real robot)
3. **Add logging everywhere** (debugging is easier)
4. **Cache LLM responses** (saves tokens & money)
5. **Monitor WiFi** (most common issue)
6. **Set token budgets** (prevents surprises)
7. **Use kids mode** (when with children)
8. **Backup your config** (before major updates)
9. **Check dashboard daily** (catches issues early)
10. **Read troubleshooting** (before contacting support)

---

## 🆘 WHEN STUCK

1. **Check dashboard** (http://reachy.local:8000)
2. **Read troubleshooting section** (REACHY_MINI_COMPLETE_GUIDE.md)
3. **Search GitHub issues** (https://github.com/pollen-robotics/reachy_mini/issues)
4. **Ask Discord** (https://discord.gg/pollen-robotics)
5. **Contact Pollen** (support@pollen-robotics.com)

---

**Last update:** January 2026  
**Version:** 2.0 (SDK v1.2.0 aligné)  
**Status:** Production Ready ✅