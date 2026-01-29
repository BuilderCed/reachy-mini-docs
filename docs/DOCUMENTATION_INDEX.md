# REACHY MINI - DOCUMENTATION INDEX
## Janvier 2026 | Navigation complète de toute la documentation

---

## 📚 DOCUMENT OVERVIEW

Vous avez maintenant **4 fichiers principaux + 1 Quick Start** :

| Document | Purpose | Read Time | When? |
|----------|---------|-----------|-------|
| **QUICK_REFERENCE_v2.md** | 5-min cheat sheet + most common patterns | 10 min | First, before every session |
| **MASTER_CHECKLIST.md** | Decision flowchart + safety checklist | 5 min | Before starting ANY project |
| **SUPER_PROMPTS_READY.md** | Prompts to copy-paste into Claude/ChatGPT | 15 min | Every time you create a new app |
| **REACHY_MINI_COMPLETE_GUIDE.md** | Exhaustive reference (1000+ lines) | 60 min | Reference (sections as needed) |

---

## 🎯 GETTING STARTED (Choose Your Path)

### Path 1: "I'm a non-developer who wants to use the robot"

```
1. Read: MASTER_CHECKLIST.md (section: SAFETY MASTER CHECKLIST)
2. Read: QUICK_REFERENCE_v2.md (section: 🎯 QUICK START)
3. Test: Connect robot
4. Next: Use Dashboard (http://reachy.local:8000)
5. For help: Ask a developer to build apps for you
```

### Path 2: "I want to build an app WITH Claude/ChatGPT"

```
1. Read: MASTER_CHECKLIST.md (section: PRE-DEVELOPMENT CHECKLIST)
2. Read: QUICK_REFERENCE_v2.md (entire file - 10 min)
3. Copy: SUPER_PROMPTS_READY.md → [UNIVERSAL CONTEXT BLOCK]
4. Paste: Into Claude/ChatGPT
5. Add: Your specific requirements
6. Get: Complete, working code
7. Run: python main.py
8. Test: On real robot
9. Reference: REACHY_MINI_COMPLETE_GUIDE.md if stuck
```

### Path 3: "I'm building something complex (embodied AI, multi-agent, etc)"

```
1. Read: MASTER_CHECKLIST.md (all sections)
2. Deep dive: REACHY_MINI_COMPLETE_GUIDE.md:
   ├─ Section 5 (Network Robustness)
   ├─ Section 8 (Context Management)
   ├─ Section 9 (Real-time Decision Making)
   └─ Section 10 (Multimodal Interaction)
3. Use: SUPER_PROMPTS_READY.md for advanced patterns
4. Reference: QUICK_REFERENCE_v2.md for common tasks
5. Test: Validate performance metrics
```

### Path 4: "I'm debugging a problem"

```
1. Check: QUICK_REFERENCE_v2.md → 🐛 COMMON ERRORS & FIXES
2. Check: Dashboard (http://reachy.local:8000)
3. If still stuck:
   ├─ REACHY_MINI_COMPLETE_GUIDE.md section 5 (Network)
   ├─ REACHY_MINI_COMPLETE_GUIDE.md section 6 (Hardware)
   └─ REACHY_MINI_COMPLETE_GUIDE.md section 12.4 (Troubleshooting)
4. Last resort: Search GitHub issues or ask Discord
```

---

## 📖 DETAILED NAVIGATION

### QUICK_REFERENCE_v2.md

**Best for:** Quick lookups, code patterns, common tasks

| Section | Use For | Read Time |
|---------|---------|----------|
| 🎯 QUICK START | First-time setup | 2 min |
| 📐 COORDINATE SYSTEM | Understanding pose angles | 1 min |
| 💻 SDK CHEAT SHEET | Code examples | 5 min |
| 🔒 SAFETY LIMITS | Joint limits | 1 min |
| 🧠 AI QUICK MODELS | ASR/TTS/VLM/LLM code | 3 min |
| 🎯 MULTIMODAL INTERACTION | Audio+Vision+Motion pattern | 2 min |
| 🔄 CONVERSATION CONTEXT | Multi-turn dialogue | 2 min |
| ⚡ REAL-TIME STATE MACHINE | Decision making | 2 min |
| 📊 MONITORING BASICS | Logging setup | 1 min |
| 🎯 COMMON TASKS | Greet, Listen, Follow | 3 min |
| 🎓 LEARNING PATH | Week-by-week timeline | 1 min |
| 💡 PRO TIPS | Best practices | 2 min |

**→ Total: 25 min** (but you don't need all sections at once)

---

### MASTER_CHECKLIST.md

**Best for:** Planning, safety, decision-making

| Section | Use For | Read Time |
|---------|---------|----------|
| 📊 DOCUMENTATION STRUCTURE | Overview | 2 min |
| 🎯 DECISION FLOWCHART | Choose architecture | 3 min |
| ✅ PRE-DEVELOPMENT CHECKLIST | Before coding | 3 min |
| 🚀 QUICK APP CREATION PROCESS | 5-step workflow | 5 min |
| 🛡️ SAFETY MASTER CHECKLIST | Before each session | 3 min |
| 📈 PERFORMANCE METRICS | What to track | 2 min |
| 🎓 LEARNING TIMELINE | 7-day plan | 2 min |
| 🔥 MOST COMMON MISTAKES | Avoid these | 3 min |
| 🔗 QUICK LINKS | Find resources | 1 min |

**→ Total: 24 min** (perfect for planning a new project)

---

### SUPER_PROMPTS_READY.md

**Best for:** Generating code via AI

| Block | Use For | Read Time |
|-------|---------|----------|
| [UNIVERSAL CONTEXT BLOCK] | START HERE - every prompt | 5 min |
| [DAEMON & DASHBOARD REQUIREMENTS] | Any app | 2 min |
| [ARCHITECTURE - WIRELESS vs LITE vs SIMULATION] | Multi-platform apps | 2 min |
| [SAFETY & KIDS MODE] | Children's apps | 2 min |
| [NETWORK RESILIENCE & OPS] | Production apps | 3 min |
| [IA INTEGRATION REQUIREMENTS] | ASR/TTS/VLM/LLM | 4 min |
| [CONTEXT MANAGEMENT - MULTI-TURN CONVERSATIONS] | Dialogue apps | 3 min |
| [REAL-TIME DECISION MAKING - STATE MACHINE] | Reactive apps | 3 min |
| [MULTIMODAL INTERACTION PATTERN] | Embodied AI | 3 min |
| [TESTING & VALIDATION REQUIREMENTS] | QA | 2 min |
| [DEPLOYMENT CHECKLIST] | Release | 2 min |
| [NEW APP TEMPLATE] | Quick start | 2 min |

**→ Total: 33 min** (or just copy what you need)

**Usage:**
```
1. Copy [UNIVERSAL CONTEXT BLOCK]
2. Add 1-3 specialized blocks relevant to your app
3. Paste into Claude/ChatGPT
4. Add your specific requirements
5. Hit Send
6. Get working code
```

---

### REACHY_MINI_COMPLETE_GUIDE.md

**Best for:** Deep understanding, advanced patterns, reference

| Section | Use For | Read Time |
|---------|---------|----------|
| 1. Configuration & Setup | macOS M4 Pro first-time setup | 10 min |
| 2. Architecture | Wireless vs Lite vs Sim detailed | 15 min |
| 3. Daemon & Dashboard | How the backend works | 10 min |
| 4. Security & Kids Mode | Parent guide + code patterns | 15 min |
| 5. Network Robustness | Wi-Fi failures + recovery | 15 min |
| 6. Hardware Maintenance | RPi upkeep, reflashing | 10 min |
| 7. IA Integration | ASR/TTS/VLM detailed | 25 min |
| 8. Context Management | Multi-turn conversations deep-dive | 15 min |
| 9. Real-time Decision Making | State machines detailed | 15 min |
| 10. Multimodal Interaction | Audio+Vision+Motion patterns | 20 min |
| 11. Process & Quality | Versioning, optimization | 15 min |
| 12. Checklists & Reference | Quick lookup | 5 min |

**→ Total: 160 min** (reference - read sections as needed)

---

## 🔍 TOPIC-BASED NAVIGATION

### "I want to add speech recognition (ASR)"

```
Quick lookup:    QUICK_REFERENCE_v2.md → 🧠 AI QUICK MODELS
Example code:    SUPER_PROMPTS_READY.md → [IA INTEGRATION REQUIREMENTS]
Deep dive:       REACHY_MINI_COMPLETE_GUIDE.md → Section 7.1
Complete pattern: REACHY_MINI_COMPLETE_GUIDE.md → Section 10 (multimodal)
```

### "I want to make it speak (TTS)"

```
Quick lookup:    QUICK_REFERENCE_v2.md → 🧠 AI QUICK MODELS
Example code:    SUPER_PROMPTS_READY.md → [IA INTEGRATION REQUIREMENTS]
Deep dive:       REACHY_MINI_COMPLETE_GUIDE.md → Section 7.2
Sync with motion: REACHY_MINI_COMPLETE_GUIDE.md → Section 10.2
```

### "I want to use the camera (VLM)"

```
Quick lookup:    QUICK_REFERENCE_v2.md → 🧠 AI QUICK MODELS
Example code:    SUPER_PROMPTS_READY.md → [IA INTEGRATION REQUIREMENTS]
Deep dive:       REACHY_MINI_COMPLETE_GUIDE.md → Section 7.3
Multimodal:      REACHY_MINI_COMPLETE_GUIDE.md → Section 10
```

### "I want multi-turn conversation"

```
Quick start:     QUICK_REFERENCE_v2.md → 🔄 CONVERSATION CONTEXT
Example code:    SUPER_PROMPTS_READY.md → [CONTEXT MANAGEMENT]
Deep dive:       REACHY_MINI_COMPLETE_GUIDE.md → Section 8
```

### "I want real-time responses"

```
Quick lookup:    QUICK_REFERENCE_v2.md → ⚡ REAL-TIME STATE MACHINE
Example code:    SUPER_PROMPTS_READY.md → [REAL-TIME DECISION MAKING]
Deep dive:       REACHY_MINI_COMPLETE_GUIDE.md → Section 9
```

### "I want audio + vision + motion together"

```
Quick pattern:   QUICK_REFERENCE_v2.md → 🎯 MULTIMODAL INTERACTION
Example code:    SUPER_PROMPTS_READY.md → [MULTIMODAL INTERACTION PATTERN]
Deep dive:       REACHY_MINI_COMPLETE_GUIDE.md → Section 10
```

### "I want to build for kids"

```
Safety first:    MASTER_CHECKLIST.md → 🛡️ SAFETY MASTER CHECKLIST
Code template:   SUPER_PROMPTS_READY.md → [SAFETY & KIDS MODE]
Complete guide:  REACHY_MINI_COMPLETE_GUIDE.md → Section 4.3
```

### "I want to handle network issues"

```
Quick patterns:  QUICK_REFERENCE_v2.md → 🐛 COMMON ERRORS & FIXES
Code examples:   SUPER_PROMPTS_READY.md → [NETWORK RESILIENCE & OPS]
Deep dive:       REACHY_MINI_COMPLETE_GUIDE.md → Section 5
```

### "I want to deploy to production"

```
Checklist:       MASTER_CHECKLIST.md → 🚀 QUICK APP CREATION PROCESS
Detailed:        SUPER_PROMPTS_READY.md → [DEPLOYMENT CHECKLIST]
Complete:        REACHY_MINI_COMPLETE_GUIDE.md → Section 11
```

---

## 🔗 CROSS-REFERENCES

### Common Question: "How do I handle network failures?"

**Locations:**
1. QUICK_REFERENCE_v2.md → 🐛 COMMON ERRORS & FIXES (quick answer)
2. REACHY_MINI_COMPLETE_GUIDE.md → Section 5.2 Connection Manager (detailed code)
3. SUPER_PROMPTS_READY.md → [NETWORK RESILIENCE & OPS] (copy-paste)

**Answer:** Implement retry logic with exponential backoff. See code in all 3 locations.

---

### Common Question: "What are the safety limits?"

**Locations:**
1. QUICK_REFERENCE_v2.md → 🔒 SAFETY LIMITS (table)
2. REACHY_MINI_COMPLETE_GUIDE.md → Section 4.1 (detailed explanation)

**Answer:** 
- Head pitch/roll: -40° to +40°
- Head yaw: -180° to +180°
- Body yaw: -160° to +160°
- Constraint: |head_yaw - body_yaw| ≤ 65°

---

### Common Question: "How much does it cost to use Claude?"

**Locations:**
1. REACHY_MINI_COMPLETE_GUIDE.md → Section 11.3 Token Optimizer (pricing)
2. SUPER_PROMPTS_READY.md → [IA INTEGRATION REQUIREMENTS] (budget tracking)

**Answer:** ~0.003¢ per 1K input tokens, ~0.015¢ per 1K output tokens. Budget: 10k tokens/day = ~$0.15/day.

---

## ✅ SETUP CHECKLIST

Before you start reading the docs:

```
Hardware:
☐ Robot powered on
☐ Robot on Wi-Fi (same as your Mac)
☐ Dashboard accessible (http://reachy.local:8000)
☐ Battery > 30%

Software:
☐ Python 3.10+ installed
☐ Virtual env activated
☐ `pip install reachy-mini` successful
☐ Connection test passed

Keys:
☐ Anthropic API key saved in .env or env var

Documents:
☐ All 4 files downloaded/saved
☐ This index open for reference
```

---

## 💡 QUICK WORKFLOW

```
"I have a new idea for an app"
        ↓
1. Open MASTER_CHECKLIST.md
2. Follow "🚀 QUICK APP CREATION PROCESS" (5 steps)
3. At step 3 (Generate Code):
   ├─ Open SUPER_PROMPTS_READY.md
   ├─ Copy [UNIVERSAL CONTEXT BLOCK]
   ├─ Add relevant specialized blocks
   ├─ Paste into Claude
   └─ Get working code
4. At step 4 (Test Locally):
   ├─ Save code as main.py
   ├─ Run: python main.py
   ├─ Reference: QUICK_REFERENCE_v2.md
   └─ Check: REACHY_MINI_COMPLETE_GUIDE.md sections as needed
5. At step 5 (Deploy):
   ├─ Use: SUPER_PROMPTS_READY.md → [DEPLOYMENT CHECKLIST]
   └─ Ship!

Result: Complete app in ~1 day
```

---

## 🚀 NEXT STEPS

**1. First time?**
→ Read MASTER_CHECKLIST.md (15 min) + QUICK_REFERENCE_v2.md (10 min) = 25 min setup

**2. Building an app?**
→ Follow MASTER_CHECKLIST.md → 🚀 QUICK APP CREATION PROCESS (5 steps, ~30 min)

**3. Complex app?**
→ Read REACHY_MINI_COMPLETE_GUIDE.md sections 8, 9, 10 (60 min)

**4. Stuck?**
→ Use topic-based navigation above to find answer

**5. Ready to code?**
→ Copy [UNIVERSAL CONTEXT BLOCK] from SUPER_PROMPTS_READY.md, paste into Claude

---

## 📞 SUPPORT CHANNELS

**In order of effectiveness:**

1. **This documentation** (you are here!)
   - Topic-based navigation above
   - Examples + code patterns

2. **GitHub Issues** (https://github.com/pollen-robotics/reachy_mini/issues)
   - Search existing issues
   - Open new issue with details

3. **Discord** (https://discord.gg/pollen-robotics)
   - Community support
   - Get feedback quickly

4. **Dashboard** (http://reachy.local:8000)
   - Logs show errors
   - Daemon health visible

5. **Pollen Support** (support@pollen-robotics.com)
   - For hardware issues
   - Last resort

---

**Status:** ✅ FULLY DOCUMENTED  
**Coverage:** 100% (Config, Hardware, Network, IA, Kids, Ops, Quality)  
**Updated:** January 2026  

**You're ready! 🚀**