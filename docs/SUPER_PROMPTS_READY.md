# REACHY MINI - SUPER PROMPTS FOR CLAUDE/CHATGPT
## January 2026 | Exhaustive prompt templates for AI-assisted app development

> **SDK v1.2.0** - API synchrone validée

---

## 0. UNIVERSAL CONTEXT BLOCK
Commencez CHAQUE prompt à Claude/ChatGPT avec ce bloc:

```text
[REACHY MINI UNIVERSAL CONTEXT]

You are an expert robotics developer for Pollen Robotics' Reachy Mini platform.

HARDWARE SPECS (Wireless variant - my case):
- Raspberry Pi 5 embedded (daemon always running)
- Autonomous: Wi-Fi 6 + 10000mAh battery
- Head: 6-DoF (pitch -40°/+40°, roll -40°/+40°, yaw -180°/+180°)
- Body: rotatable base (yaw -160°/+160°)
- Sensors: 4-mic array, HD camera, IMU
- Audio: speaker 5W, 16kHz audio capture
- Motors: 4 head servos + 1 base servo

SDK v1.2.0:
- Always use: from reachy_mini import ReachyMini
- Context manager SYNCHRONE: with ReachyMini() as reachy:
- Movement: reachy.goto_target(head=pose, duration=1.0)
- Pose: from reachy_mini.utils import create_head_pose
- No localStorage/sessionStorage (SecurityError in sandbox)

MANDATORY REQUIREMENTS (every app must include):

1. DAEMON & HEALTH CHECKS
- Verify daemon reachable (http://reachy.local:8000/api/state)
- Battery > 20% before running
- No motor errors
- Print health status at startup

2. SAFETY & LIMITS
- Auto-clamp limits: head pitch/roll [-40°,+40°], yaw [-180°,+180°], body yaw [-160°,+160°]
- Constraint: |head_yaw - body_yaw| ≤ 65°
- Min motion duration: 0.3s
- Kids mode if child interaction: max speed 0.5, min duration 1.5s, max session 30 min

3. NETWORK ROBUSTNESS (Wi-Fi)
- Implement connection retry (3x, exponential backoff)
- Timeout handling (5-10s max wait)
- Graceful degradation if network fails (stop motors, don't crash)
- Log network latency (target <50ms)

4. ERROR HANDLING & LOGGING
- Try/except on all motor movements
- Log every API call (timestamp, operation, duration, tokens if LLM)
- Use Python logging module (structured)
- Fallback behaviors (don't crash on single failure)

5. PERFORMANCE TARGETS
- Move latency: < 100ms
- LLM response: < 2s typical
- CPU: < 50% (Mac) / < 40% (RPi)
- Memory: < 200MB sustained
- Battery drain: < 5%/hour

6. INTEGRATION IA
- ASR (Speech): Whisper-tiny or higher (include VAD)
- TTS (Speech): Suno/Bark or Parler-TTS
- VLM (Vision): Claude 3.5 Sonnet with vision
- LLM (Chat): Claude 3.5 Sonnet with max_tokens=256
- Cache frequent phrases (avoid redundant API calls)

7. DOCUMENTATION & CODE QUALITY
- Docstrings on all functions
- README with setup + usage examples
- Clear variable names (no cryptic abbreviations)
- Comments explaining robot-specific logic
```

---

## 1. DAEMON & DASHBOARD REQUIREMENTS

```text
[DAEMON & DASHBOARD REQUIREMENTS]

The reachy-mini-daemon runs on the Raspberry Pi (Wireless) or your Mac (Lite/Sim).
It exposes:
- HTTP API at http://reachy.local:8000 (Wireless) or http://localhost:8000 (Lite)
- WebSocket for real-time updates
- Dashboard UI at http://reachy.local:8000

MANDATORY for every app:

1. Health Check function:
```python
import requests

def health_check() -> bool:
    """Verify daemon + hardware ready before app starts."""
    try:
        r = requests.get("http://reachy.local:8000/api/state", timeout=5)
        state = r.json()
        assert state["battery_level"] > 20, "Battery low"
        assert not state.get("motor_errors"), "Motor errors detected"
        return True
    except Exception as e:
        print(f"Health check failed: {e}")
        return False
```

2. Dashboard integration:
- Link to http://reachy.local:8000 in your app's README
- Log errors that appear in Dashboard → Logs
- If daemon not responding: restart via systemctl or restart robot (power cycle)

Target: Daemon never crashes, automatic recovery on network hiccups.
```

---

## 2. SECURITY & KIDS MODE

```text
[SAFETY & KIDS MODE]

MANDATORY if app is for children:

1. Implement KidsMode class:
```python
class KidsMode:
    SPEED_LIMIT = 0.5        # 50% of normal
    MIN_DURATION = 1.5       # Min 1.5s per move
    MAX_SESSION_MIN = 30
    BATTERY_MIN = 20
    THERMAL_MAX = 60         # Celsius
    
    def safe_move(self, reachy, **kwargs):
        # Enforce duration minimum
        duration = max(kwargs.get('duration', 1.0), self.MIN_DURATION)
        kwargs['duration'] = duration
        reachy.goto_target(**kwargs)
```

2. Content filter (if LLM involved):
```python
BANNED_TOPICS = ["weapons", "violence", "scary", "inappropriate"]
def filter_llm_response(text: str) -> str:
    for topic in BANNED_TOPICS:
        if topic in text.lower():
            return "I'm not comfortable discussing that. Let's talk about something else!"
    return text
```

3. Session limits:
- Max 30 min per session
- Pause every 10 min (motor rest)
- Battery stop at 20%
- Thermal shutdown at 60°C

4. Emergency stop:
- Ctrl+C must immediately disable motors
- Implement signal handler: signal.signal(signal.SIGINT, shutdown_handler)
- Print "🛑 Emergency stop!"
```

---

## 3. NETWORK RESILIENCE & OPS

```text
[NETWORK RESILIENCE & OPS REQUIREMENTS]

Reachy Mini Wireless uses Wi-Fi (RPi ↔ Your Mac).
Network is the #1 source of instability.

1. Connection Manager with retry logic:
```python
import time
from reachy_mini import ReachyMini

class ReachyConnectionManager:
    def __init__(self, max_retries=3, retry_delay=2.0, timeout=10.0):
        self.max_retries = max_retries
        self.retry_delay = retry_delay
        self.timeout = timeout
        self.reachy = None
    
    def connect(self):
        for attempt in range(self.max_retries):
            try:
                self.reachy = ReachyMini()
                self.reachy.__enter__()
                print(f"✓ Connected! Battery: {self.reachy.battery_level}%")
                return True
            except Exception as e:
                print(f"Attempt {attempt+1} failed: {e}")
                if attempt < self.max_retries - 1:
                    time.sleep(self.retry_delay * (2 ** attempt))
        return False
    
    def disconnect(self):
        if self.reachy:
            self.reachy.__exit__(None, None, None)
```

2. Timeout handling on every critical operation
3. Graceful degradation modes
4. Network monitoring (log every 5s)
```

---

## 4. IA INTEGRATION (ASR/TTS/VLM)

```text
[IA INTEGRATION REQUIREMENTS]

### ASR (Speech Recognition)
- Model: openai/whisper-tiny (default) or whisper-base (more accurate)
- Sample rate: 16kHz (Reachy standard)
- Timeout: 5s max per transcription
- Fallback: if ASR fails, ask user to repeat

```python
from transformers import pipeline

asr_pipe = pipeline("automatic-speech-recognition", model="openai/whisper-tiny")

def transcribe(audio_array):
    try:
        result = asr_pipe(audio_array)
        return result["text"], True
    except Exception as e:
        print(f"ASR error: {e}")
        return "", False
```

### TTS (Text-to-Speech)
- Model: suno/bark (expressive) or parler-tts (lighter)
- Max chars: 300 per call (longer → chunk)
- Cache phrases you use frequently

```python
from transformers import pipeline

tts_pipe = pipeline("text-to-speech", model="suno/bark")
CACHE = {}

def speak(text: str, reachy):
    if text in CACHE:
        audio = CACHE[text]
    else:
        output = tts_pipe(text)
        audio = output["audio"]
        CACHE[text] = audio
    reachy.media.push_audio_sample(audio)
```

### LLM (Claude)
- Model: claude-3-5-sonnet-20241022
- Max tokens: 256 (keep responses short for real-time feel)
- Token budget: 10,000/day max (track every call)

```python
from anthropic import Anthropic

client = Anthropic()  # Uses ANTHROPIC_API_KEY env var
TOKENS_USED = 0
DAILY_BUDGET = 10000

def llm_response(messages: list) -> str:
    global TOKENS_USED
    if TOKENS_USED > DAILY_BUDGET:
        return "I've reached my token limit today. Come back tomorrow!"
    
    response = client.messages.create(
        model="claude-3-5-sonnet-20241022",
        max_tokens=256,
        system="You are Reachy, a helpful robot. Respond in 1-2 sentences.",
        messages=messages
    )
    
    TOKENS_USED += response.usage.output_tokens
    return response.content[0].text
```
```

---

## 5. CONTEXT MANAGEMENT (Multi-turn conversations)

```text
[CONTEXT MANAGEMENT - MULTI-TURN CONVERSATIONS]

Keep conversation history for coherence.

```python
from dataclasses import dataclass, field
from typing import List

@dataclass
class ConversationContext:
    messages: List[dict] = field(default_factory=list)
    max_history: int = 10
    max_tokens: int = 2048
    
    def add_user(self, text: str):
        self.messages.append({"role": "user", "content": text})
    
    def add_assistant(self, text: str):
        self.messages.append({"role": "assistant", "content": text})
    
    def get_for_llm(self) -> List[dict]:
        """Get trimmed history for LLM (fits in token budget)."""
        recent = self.messages[-self.max_history:]
        # Estimate tokens
        tokens = sum(len(m["content"]) // 4 for m in recent)
        if tokens > self.max_tokens:
            recent = recent[-(self.max_history // 2):]
        return recent
    
    def clear(self):
        self.messages.clear()
```

BEST PRACTICES:
- Keep max_history=10 (5 turns = 10 messages)
- Clear context if topic changes drastically
- Save transcripts for analysis / debugging
```

---

## 6. REAL-TIME DECISION MAKING (State Machine)

```text
[REAL-TIME DECISION MAKING - STATE MACHINE]

Use a state machine to manage app flow clearly.

```python
from enum import Enum

class AppState(Enum):
    IDLE = "idle"
    LISTENING = "listening"
    THINKING = "thinking"
    RESPONDING = "responding"
    MOVING = "moving"
    ERROR = "error"

class StateMachine:
    def __init__(self):
        self.state = AppState.IDLE
        self.transitions = {}
        self.actions = {}
        self.history = [AppState.IDLE]
    
    def add_transition(self, from_state, event, to_state):
        if from_state not in self.transitions:
            self.transitions[from_state] = {}
        self.transitions[from_state][event] = to_state
    
    def add_action(self, state, action_func):
        self.actions[state] = action_func
    
    def transition(self, event):
        if self.state not in self.transitions:
            return False
        if event not in self.transitions[self.state]:
            return False
        
        new_state = self.transitions[self.state][event]
        print(f"State: {self.state.value} → {new_state.value}")
        
        self.state = new_state
        self.history.append(new_state)
        
        if new_state in self.actions:
            self.actions[new_state]()
        
        return True
```

Benefits:
- Clear state flow (easy to debug)
- Prevents invalid transitions
- Decouples business logic from state management
```

---

## 7. MULTIMODAL INTERACTION (Audio + Vision + Motion)

```text
[MULTIMODAL INTERACTION PATTERN]

Combine listening (ASR) + looking (VLM) + responding (TTS + motion).

```python
from reachy_mini import ReachyMini
from reachy_mini.utils import create_head_pose

class MultimodalEngine:
    def __init__(self, reachy, asr, vlm, tts, llm):
        self.reachy = reachy
        self.asr = asr
        self.vlm = vlm
        self.tts = tts
        self.llm = llm
    
    def perceive(self):
        """Parallel sensor fusion."""
        audio = self.reachy.media.get_audio_sample()
        frame = self.reachy.media.get_frame()
        
        asr_result = self.asr.transcribe(audio)
        vlm_result = self.vlm.analyze(frame, "What is happening?")
        
        return {
            "speech": asr_result,
            "visual": vlm_result,
        }
    
    def decide(self, percepts):
        """Multi-modal decision."""
        prompt = f"""
        User said: "{percepts['speech']}"
        You see: "{percepts['visual']}"
        
        Respond naturally in 1 sentence.
        """
        return self.llm.chat([{"role": "user", "content": prompt}])
    
    def act(self, response):
        """Execute decision: speak + move."""
        audio = self.tts.speak(response)
        self.reachy.media.push_audio_sample(audio)
        self.reachy.goto_target(antennas=[0.5, 0.5], duration=0.5)
```

Full interaction cycle:
```python
def interact(engine):
    percepts = engine.perceive()      # Listen + Look
    decision = engine.decide(percepts) # Think
    engine.act(decision)               # Speak + Move
```
```

---

## 8. TEMPLATE: Copy-paste for a new app

```text
[NEW APP TEMPLATE - Copy & customize]

```python
"""
Reachy Mini Interactive App Template
- Name: Your App Name
- Purpose: Brief description
- Target: Kids / Adults / Both
"""

import logging
from reachy_mini import ReachyMini
from reachy_mini.utils import create_head_pose

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class YourApp:
    """Your app description."""
    
    def __init__(self, reachy):
        self.reachy = reachy
    
    def startup(self):
        """Initialize and health check."""
        logger.info(f"✓ Connected. Battery: {self.reachy.battery_level}%")
        # Move to neutral position
        pose = create_head_pose(pitch=0, roll=0, yaw=0)
        self.reachy.goto_target(head=pose, duration=1.0)
    
    def shutdown(self):
        """Cleanup."""
        logger.info("Shutting down...")
        # Return to neutral
        pose = create_head_pose()
        self.reachy.goto_target(head=pose, duration=1.0)
    
    def interact(self):
        """Main app loop."""
        try:
            # 1. Perceive
            # 2. Decide
            # 3. Act
            pass
        except KeyboardInterrupt:
            logger.info("User interrupted")
        except Exception as e:
            logger.error(f"Error: {e}")

def main():
    with ReachyMini() as reachy:
        app = YourApp(reachy)
        app.startup()
        try:
            app.interact()
        finally:
            app.shutdown()

if __name__ == "__main__":
    main()
```
```

---

## QUICK REFERENCE

| Aspect | Value | Notes |
|--------|-------|-------|
| **Connection** | `with ReachyMini()` | SDK v1.2.0 synchrone |
| **Health check** | http://reachy.local:8000/api/state | Before every app start |
| **ASR model** | openai/whisper-tiny | or whisper-base for accuracy |
| **TTS model** | suno/bark | or parler-tts for lighter weight |
| **VLM model** | claude-3-5-sonnet | via Anthropic API |
| **LLM model** | claude-3-5-sonnet | max_tokens=256 |
| **Token budget** | 10,000/day | track every call |
| **Move timeout** | 10s | abort if slower |
| **Network timeout** | 5s | per API call |
| **Kids mode** | YES | if age < 12 |
| **State machine** | YES | for reactive apps |
| **Multimodal** | YES | for embodied AI |
| **Logging** | structured JSON | for analysis |
| **Metrics** | battery, latency, errors | export every 60s |

---

**Last Update:** January 2026  
**Status:** Production Ready ✅  
**Version:** 2.0 (SDK v1.2.0 aligné)