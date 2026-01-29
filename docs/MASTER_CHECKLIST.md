# REACHY MINI - MASTER CHECKLIST & SUMMARY
## Janvier 2026 | All-in-one reference for developers & parents

---

## 📊 DOCUMENTATION STRUCTURE (What You Have)

```
REACHY_MINI_COMPLETE_GUIDE.md
├─ 1. Configuration & Setup (macOS M4 Pro)
├─ 2. Architecture (Wireless vs Lite vs Simulation)
├─ 3. Daemon & Dashboard
├─ 4. Security & Hardware Limits
├─ 5. Network Robustness (Wi-Fi)
├─ 6. Hardware Maintenance & RPi
├─ 7. IA Integration (ASR/TTS/VLM/LLM)
├─ 8. Context Management (Multi-turn conversations)
├─ 9. Real-time Decision Making (State machines)
├─ 10. Multimodal Interaction (Audio+Vision+Motion)
├─ 11. Process & Product Quality
└─ 12. Checklists & Reference

QUICK_REFERENCE_v2.md
├─ 5-minute quick start
├─ SDK cheat sheet
├─ Safety limits
├─ Common errors & fixes
├─ Kids mode essentials
├─ Performance targets
└─ Learning path

SUPER_PROMPTS_READY.md
├─ Universal context block (use in EVERY prompt)
├─ 10 specialized prompt templates
├─ Testing & validation patterns
├─ Deployment checklist
└─ Copy-paste app template
```

---

## 🎯 DECISION FLOWCHART

```
I want to build a Reachy Mini app
        ↓
"Is it for kids?"
├─ YES → Use KIDS MODE (section 4.3 + SUPER_PROMPTS.md)
└─ NO  → Use STANDARD MODE

        ↓
"Does it need conversation?"
├─ YES → Use CONTEXT MANAGEMENT (section 8)
│        └─ Keep multi-turn history
│        └─ Budget tokens (10k/day)
└─ NO  → Skip context

        ↓
"Does it need to react in real-time?"
├─ YES → Use STATE MACHINE (section 9)
│        └─ Define states (IDLE, LISTENING, THINKING, etc)
│        └─ Define transitions (events trigger state changes)
└─ NO  → Use simple async/await flow

        ↓
"Does it combine audio + vision + motion?"
├─ YES → Use MULTIMODAL ENGINE (section 10)
│        └─ Parallel perception (listen + look simultaneously)
│        └─ Decision making (fuse both inputs)
│        └─ Synchronized action (speak + gesture together)
└─ NO  → Use simpler sequential flow

        ↓
START BUILDING!
├─ Copy template from SUPER_PROMPTS_READY.md
├─ Paste into Claude/ChatGPT
├─ Add specific requirements
├─ Get generated code
└─ Test on real robot
```

---

## ✅ PRE-DEVELOPMENT CHECKLIST

**Before you write ANY code:**

- [ ] Hardware
  - [ ] Robot powered on
  - [ ] Robot on same Wi-Fi as your Mac
  - [ ] Dashboard accessible (http://reachy.local:8000)
  - [ ] No motor errors in Dashboard
  - [ ] Battery > 30%

- [ ] Software
  - [ ] Python 3.10+ installed (`python3 --version`)
  - [ ] Virtual env created (`python3 -m venv reachy-env`)
  - [ ] Virtual env activated (`source reachy-env/bin/activate`)
  - [ ] SDK installed (`pip install reachy-mini`)
  - [ ] Connection test passed (section 1.2)

- [ ] API Keys
  - [ ] Anthropic API key (for Claude LLM/VLM)
  - [ ] Set as env var: `export ANTHROPIC_API_KEY="..."`
  - [ ] Test: `python -c "from anthropic import Anthropic; print('OK')"`

- [ ] Documentation
  - [ ] Read QUICK_REFERENCE_v2.md (5 min)
  - [ ] Skim SUPER_PROMPTS_READY.md (10 min)
  - [ ] Have REACHY_MINI_COMPLETE_GUIDE.md open for reference

---

## 🚀 QUICK APP CREATION PROCESS

### Step 1: Define Your App (5 minutes)

**Answer these questions:**
- **Name:** (e.g., "Dance Robot", "Quiz Master")
- **Target:** Kids / Adults / Both
- **Purpose:** (e.g., "Make robot dance to music", "Interactive Q&A")
- **Inputs:** (e.g., Voice, Face detection, Manual buttons)
- **Outputs:** (e.g., Speech, Movements, LED feedback)
- **Duration:** Minutes per session? (Max 30 for kids)

### Step 2: Choose Architecture (2 minutes)

```
Simple app (no AI)
├─ Basic movement sequences
└─ No multi-turn conversation
   → Use: Simple async/await

Interactive app (with AI)
├─ Single-turn Q&A
└─ Simple responses
   → Use: Context Management (keep conversation history)

Embodied AI (fully responsive)
├─ Real-time decision making
├─ Multi-sensory (audio + vision)
└─ Synchronized gestures
   → Use: State Machine + Multimodal Engine
```

### Step 3: Generate Code (10 minutes)

Copy the relevant prompt from SUPER_PROMPTS_READY.md:

1. Start with **[UNIVERSAL CONTEXT BLOCK]**
2. Add specific angles you need:
   - `[DAEMON & DASHBOARD REQUIREMENTS]`
   - `[SAFETY & KIDS MODE]`
   - `[IA INTEGRATION REQUIREMENTS]`
   - `[CONTEXT MANAGEMENT]`
   - `[REAL-TIME DECISION MAKING]`
   - `[MULTIMODAL INTERACTION PATTERN]`
3. Add your specific requirements
4. Paste into Claude/ChatGPT
5. Get complete, working code

### Step 4: Test Locally (15 minutes)

```bash
# 1. Save code as main.py
# 2. Run
python main.py

# 3. Check output
# ✓ Daemon connected
# ✓ Battery checked
# ✓ First movement works
# ✓ Audio plays
```

### Step 5: Deploy (5 minutes)

```bash
# 1. Test with real robot interaction
# 2. Update version (SemVer: 1.0.0)
# 3. Commit to git
# 4. Mark as "ready"

git tag v1.0.0
git push origin v1.0.0
```

---

## 🛡️ SAFETY MASTER CHECKLIST (CRITICAL FOR KIDS)

**Print this & check EVERY session:**

```
⚠️ SAFETY CHECKLIST - BEFORE KIDS USE ROBOT

PHYSICAL SETUP
☐ Robot on stable surface (not edge of table)
☐ Area clear 1m around robot (no obstacles)
☐ No water/spills near robot
☐ All cables secured (not stepping hazard)
☐ Antennae not bent/twisted
☐ No access to battery compartment

ROBOT STATE
☐ Powered on (red LED on)
☐ Battery > 30% (check Dashboard)
☐ No motor errors (check Dashboard → Logs)
☐ Temperature < 60°C (check Dashboard)
☐ Quick gesture test (move head, wave antennas)

APP CONFIGURATION
☐ Kids mode ENABLED
☐ Speed limited to 0.5x
☐ Min motion duration 1.5s
☐ Emergency stop tested (Ctrl+C works)
☐ Session timer set (max 30 min)
☐ Content filter ON (no scary responses)

SUPERVISION
☐ Adult present (can reach Ctrl+C in 2s)
☐ Child instructed (no pulling cables, respect robot)
☐ Distance maintained (30cm min from face)
☐ Interaction monitored (no bullying robot)
☐ Pause if robot gets warm (>50°C)

EMERGENCY
☐ Adult knows how to press Ctrl+C
☐ Adult knows how to turn OFF switch
☐ First aid kit nearby (just in case)
☐ Phone with Pollen support number handy

✅ ALL CHECKED = SAFE TO START SESSION
⏱️ SET TIMER FOR 30 MINUTES MAX
```

---

## 📈 PERFORMANCE METRICS TO MONITOR

**Track these for every session:**

```python
METRICS = {
    "battery_start": 85,         # %
    "battery_end": 78,           # %
    "battery_drain": 7,          # % per session
    
    "move_latency_avg": 45,      # ms (target <100)
    "move_latency_max": 120,     # ms
    
    "llm_latency_avg": 1200,     # ms (target <2000)
    "llm_latency_max": 3500,     # ms
    
    "network_latency_avg": 25,   # ms (target <50)
    "network_latency_max": 180,  # ms
    
    "cpu_usage_avg": 35,         # % (target <50)
    "cpu_usage_peak": 65,        # %
    
    "memory_usage": 150,         # MB (target <200)
    
    "thermal_peak": 52,          # °C (target <60)
    
    "api_tokens_used": 2450,     # tokens
    "api_calls": 12,             # number of calls
    
    "errors": 2,                 # exceptions caught
    "network_drops": 0,          # disconnections
    
    "session_duration": 1800,    # seconds (30 min)
    "user_satisfaction": 9,      # 1-10 rating
}
```

---

## 🎓 LEARNING TIMELINE

```
Day 1: Setup + Basics (2 hours)
├─ Install SDK
├─ Test connection
├─ Read QUICK_REFERENCE
└─ Do 5-minute quick start

Day 2: First Movement (2 hours)
├─ Create simple head gesture script
├─ Test motor control
├─ Practice safety limits
└─ Verify latency (<100ms)

Day 3: Add Audio (2 hours)
├─ Implement ASR (listen)
├─ Implement TTS (speak)
├─ Simple "echo" app
└─ Test on real robot

Day 4: Add AI (2 hours)
├─ Integrate LLM (Claude)
├─ Simple Q&A app
├─ Test token budget
└─ Monitor performance

Day 5: Make it Interactive (3 hours)
├─ Add context management (multi-turn)
├─ Add state machine (decision making)
├─ Test full flow
└─ Gather feedback

Day 6: Polish & Test (2 hours)
├─ Add logging + metrics
├─ Test with kids (if applicable)
├─ Fix bugs
└─ Document usage

Day 7: Deploy (1 hour)
├─ Version bump
├─ Tag release
├─ Create deployment notes
└─ Ship!

TOTAL: ~14 hours for complete app
```

---

## 🔥 MOST COMMON MISTAKES (Avoid!)

| Mistake | Why Bad | Fix |
|---------|---------|-----|
| ❌ No timeout on network calls | App hangs forever if Wi-Fi drops | Add `timeout=10` to all calls |
| ❌ Not using virtual env | Dependencies clash with system Python | Always: `python3 -m venv env` |
| ❌ Skipping health checks | App crashes if battery/daemon offline | Check health before startup |
| ❌ No kids mode for children | Safety risk | Use `KidsMode` class from section 4.3 |
| ❌ Sending poses out of limits | Motors error | SDK auto-clamps, but respect limits |
| ❌ Not caching LLM responses | Burn token budget fast | Use dict cache for frequent phrases |
| ❌ Blocking main thread (no async) | App freezes | Always use `async/await` |
| ❌ No fallback for LLM timeout | Crash when API slow | Return fallback response |
| ❌ Ignoring network latency | Unpredictable behavior | Monitor RSSI, place router close |
| ❌ Running 30+ min sessions | Motor overheat | Max 30 min per session, pause every 10 min |

---

## 🔗 QUICK LINKS

```
📚 DOCUMENTATION
├─ Complete Guide: REACHY_MINI_COMPLETE_GUIDE.md
├─ Quick Ref: QUICK_REFERENCE_v2.md
├─ Super Prompts: SUPER_PROMPTS_READY.md
└─ This file: MASTER_CHECKLIST.md

🤖 ROBOT
├─ Dashboard: http://reachy.local:8000
├─ API Docs: http://reachy.local:8000/docs
└─ Git Repo: https://github.com/pollen-robotics/reachy_mini

💬 COMMUNITY
├─ Discord: https://discord.gg/pollen-robotics
├─ Issues: https://github.com/pollen-robotics/reachy_mini/issues
└─ Discussions: https://github.com/pollen-robotics/reachy_mini/discussions

🔑 API KEYS
├─ Anthropic (Claude): https://console.anthropic.com
├─ HuggingFace (Whisper/Bark): https://huggingface.co
└─ Set env vars: export ANTHROPIC_API_KEY="..."
```

---

## 💡 FINAL TIPS

1. **Start simple** → Add features incrementally
2. **Test on simulation first** → Before real robot
3. **Monitor metrics** → Know what's slow/broken
4. **Cache aggressively** → Save money & latency
5. **Respect safety limits** → Motors are strong!
6. **Keep kids supervised** → Always
7. **Document everything** → Future you will thank you
8. **Ask community** → Discord is friendly
9. **Backup your work** → Git regularly
10. **Have fun!** → Reachy is awesome

---

## 🆘 STUCK?

**In order of likelihood to help:**

1. **Check Dashboard** → 80% of issues visible there
2. **Read troubleshooting** → Section 12.4 of COMPLETE_GUIDE
3. **Search GitHub issues** → Someone probably had this before
4. **Check network** → ping reachy.local, check RSSI
5. **Restart daemon** → `sudo systemctl restart reachy-mini-daemon`
6. **Power cycle robot** → OFF button, wait 5s, ON button
7. **Ask Discord** → Community is helpful
8. **Contact Pollen** → support@pollen-robotics.com

---

**Ready to build? 🚀**

1. Open SUPER_PROMPTS_READY.md
2. Copy [UNIVERSAL CONTEXT BLOCK]
3. Add your requirements
4. Paste into Claude
5. Get working code
6. Run on real robot
7. Iterate & improve

**Status:** ✅ PRODUCTION READY

**Last Update:** January 2026  
**Your Next Step:** Pick an app idea + start building!