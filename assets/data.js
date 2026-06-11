window.BUTTONVERSE_CATEGORIES = [
  {
    "id": "action-submit",
    "title": "Submit Station",
    "desc": "Submit, send, approve, save and confirmation buttons.",
    "icon": "\u2197",
    "count": 50
  },
  {
    "id": "pill-capsule",
    "title": "Pill District",
    "desc": "Capsule, tag, chip, soft pill and rounded product buttons.",
    "icon": "\u25cf",
    "count": 50
  },
  {
    "id": "commerce-checkout",
    "title": "Checkout Dock",
    "desc": "Cart, price, product, billing and upgrade buttons.",
    "icon": "\u25c6",
    "count": 50
  },
  {
    "id": "file-transfer",
    "title": "Transfer Bay",
    "desc": "Download, upload, export, import and file action buttons.",
    "icon": "\u21e3",
    "count": 50
  },
  {
    "id": "social-community",
    "title": "Social Plaza",
    "desc": "Follow, like, share, invite and community buttons.",
    "icon": "\u2726",
    "count": 50
  },
  {
    "id": "navigation-tabs",
    "title": "Navigation Rail",
    "desc": "Tabs, links, routes, menu and page movement buttons.",
    "icon": "\u2301",
    "count": 50
  },
  {
    "id": "developer-tools",
    "title": "Dev Console",
    "desc": "Deploy, build, API, Git, debug and developer buttons.",
    "icon": "\u25a3",
    "count": 50
  },
  {
    "id": "ai-workflow",
    "title": "AI Workshop",
    "desc": "Generate, automate, analyze, prompt and workflow buttons.",
    "icon": "AI",
    "count": 50
  },
  {
    "id": "security-auth",
    "title": "Security Gate",
    "desc": "Login, verify, lock, shield and authorization buttons.",
    "icon": "\u25c8",
    "count": 50
  },
  {
    "id": "media-control",
    "title": "Media Stage",
    "desc": "Play, record, stream, remix and media control buttons.",
    "icon": "\u266b",
    "count": 50
  },
  {
    "id": "gaming-arcade",
    "title": "Arcade Room",
    "desc": "Quest, level, neon, reward and game-state buttons.",
    "icon": "\u2739",
    "count": 50
  },
  {
    "id": "minimal-editorial",
    "title": "Editorial Line",
    "desc": "Minimal, text-first, border, underline and quiet buttons.",
    "icon": "\u2014",
    "count": 50
  },
  {
    "id": "glass-frost",
    "title": "Glass House",
    "desc": "Frosted, translucent, blur, refraction and glass buttons.",
    "icon": "\u25c7",
    "count": 50
  },
  {
    "id": "depth-press",
    "title": "Press Lab",
    "desc": "3D, pressed, shadow, raised and tactile buttons.",
    "icon": "\u25b0",
    "count": 50
  },
  {
    "id": "liquid-organic",
    "title": "Liquid Garden",
    "desc": "Blob, melt, ripple, elastic and organic motion buttons.",
    "icon": "\u2248",
    "count": 50
  },
  {
    "id": "icon-micro",
    "title": "Micro Tools",
    "desc": "Small icon buttons, compact controls and utility actions.",
    "icon": "\u25cc",
    "count": 50
  },
  {
    "id": "map-location",
    "title": "Map Terminal",
    "desc": "Map pin, route, direction and location buttons.",
    "icon": "\u2316",
    "count": 50
  },
  {
    "id": "education-course",
    "title": "Study Hall",
    "desc": "Lesson, quiz, assignment and classroom platform buttons.",
    "icon": "\u270e",
    "count": 50
  },
  {
    "id": "health-habit",
    "title": "Habit Clinic",
    "desc": "Health, fitness, sleep, care and wellness buttons.",
    "icon": "\u2661",
    "count": 50
  },
  {
    "id": "creative-studio",
    "title": "Creator Desk",
    "desc": "Canvas, design, artboard, color and export buttons.",
    "icon": "\u2727",
    "count": 50
  }
];

window.BUTTONVERSE_BUILD = function () {
  const families = ["orbit", "capsule", "ticket", "glass", "solid", "outline", "rail", "soft", "chrome", "neon", "paper", "brutal", "tab", "chip", "ribbon", "notch", "wire", "stamp", "terminal", "magnet", "liquid", "pixel", "deck", "bevel", "mono", "halo", "split", "mesh", "fold", "switch", "label", "ink", "beam", "depth", "calm", "flare", "bubble", "corner", "pillbox", "laser"];
  const motions = ["slide-glow", "wipe-fill", "icon-hop", "ring-pop", "scan-line", "border-run", "shine-pass", "pulse-core", "tilt-card", "press-down", "split-open", "corner-grow", "magnet-pull", "liquid-swell", "pixel-jump", "terminal-blink", "shadow-lift", "stitch-dash", "wave-roll", "orb-spin", "label-swap", "gate-open", "beam-slice", "soft-breathe", "spark-field", "frost-haze", "paper-fold", "elastic-stretch", "noise-fade", "zip-cut", "under-trace", "radar-sweep", "trail-shift", "switch-flip", "depth-step", "halo-grow", "arrow-launch", "dot-orbit", "grid-flip", "ink-spread", "calm-dim", "pop-bounce", "slice-flare", "stripe-run", "bubble-rise", "data-scan", "focus-lock", "outline-push", "glint-turn", "ribbon-wave"];
  const shapes = ["pill", "squircle", "slant", "ticket", "tab", "cut", "round", "square", "capsule", "notch"];
  const patterns = ["plain", "grain", "dots", "grid", "diagonal", "scan", "rays", "mesh", "stripe", "softlight"];
  const icons = ["\u2197", "\u2192", "\u2713", "+", "\u2198", "\u27e1", "\u2301", "\u25cf", "\u25c6", "\u25cc", "\u25a3", "\u2726", "\u21e3", "\u26a1", "\u2318", "\u238b", "\u25c7", "\u21bb", "\u21e1", "\u2727", "\u2316", "\u2661", "\u266b", "AI"];
  const verbs = {"action-submit": ["Submit", "Send Form", "Save Draft", "Confirm", "Approve", "Continue", "Publish", "Apply Now", "Create", "Start"], "pill-capsule": ["Explore", "Choose", "Select", "Try Free", "Open", "Join", "Pick", "View", "Switch", "Launch"], "commerce-checkout": ["Buy Now", "Checkout", "Add Cart", "Upgrade", "Subscribe", "Pay", "Reserve", "Order", "Unlock", "Get Deal"], "file-transfer": ["Download", "Upload", "Export", "Import", "Sync", "Backup", "Restore", "Attach", "Drop File", "Get ZIP"], "social-community": ["Follow", "Like", "Share", "Invite", "Reply", "Message", "Connect", "Mention", "React", "Join Club"], "navigation-tabs": ["Home", "Next", "Previous", "Overview", "Details", "Docs", "Timeline", "Library", "Menu", "Back"], "developer-tools": ["Deploy", "Run Build", "Commit", "Merge", "Push", "Pull", "Open API", "Debug", "Fork", "Ship"], "ai-workflow": ["Generate", "Automate", "Summarize", "Refine", "Prompt", "Train", "Analyze", "Compose", "Optimize", "Queue"], "security-auth": ["Verify", "Login", "Unlock", "Secure", "Approve ID", "Scan Key", "Encrypt", "Protect", "Authorize", "Sign In"], "media-control": ["Play", "Pause", "Record", "Stream", "Mute", "Remix", "Queue", "Watch", "Tune In", "Replay"], "gaming-arcade": ["Play", "Start Quest", "Level Up", "Claim XP", "Enter Arena", "Respawn", "Power Up", "Join Raid", "Unlock Skin", "Ready"], "minimal-editorial": ["Read More", "Learn", "Preview", "Open", "Continue", "Details", "See More", "Browse", "View Case", "Inspect"], "glass-frost": ["Reveal", "Glow", "Focus", "Float", "Preview", "Layer", "Reflect", "Open Glass", "Unfold", "Drift"], "depth-press": ["Press", "Push", "Lift", "Drop", "Stack", "Elevate", "Punch In", "Pop Out", "Stamp", "Trigger"], "liquid-organic": ["Melt", "Pour", "Splash", "Flow", "Bubble", "Absorb", "Morph", "Squeeze", "Bloom", "Ripple"], "icon-micro": ["Copy", "Paste", "Pin", "Star", "Filter", "Sort", "Search", "Scan", "Edit", "Delete"], "map-location": ["Navigate", "Find Route", "Locate", "Drop Pin", "Book Ride", "Explore Map", "Arrive", "Nearby", "Track", "Set Home"], "education-course": ["Start Lesson", "Take Quiz", "Submit Work", "Review", "Practice", "Enroll", "Continue Class", "Grade", "Flashcards", "Learn"], "health-habit": ["Start Workout", "Log Meal", "Breathe", "Track Sleep", "Check In", "Hydrate", "Meditate", "Book Care", "Set Goal", "Rest"], "creative-studio": ["Create", "Design", "Export PNG", "Add Layer", "Pick Color", "Render", "Open Canvas", "Style", "Crop", "Publish Art"]};
  const cats = window.BUTTONVERSE_CATEGORIES;
  const out = [];

  cats.forEach((cat, ci) => {
    for (let i = 0; i < 50; i += 1) {
      const labelBase = verbs[cat.id][i % verbs[cat.id].length];
      const suffix = ["Core","Flow","Pulse","Edge","Prime","Nova","Shift","Arc","Mode","Lab"][(Math.floor(i / 10) + ci) % 10];
      out.push({
        id: cat.id + "-" + String(i + 1).padStart(3, "0"),
        number: ci * 50 + i + 1,
        category: cat.id,
        categoryTitle: cat.title,
        categoryIcon: cat.icon,
        label: i % 5 === 0 ? labelBase + " " + suffix : labelBase,
        name: cat.title + " / " + String(i + 1).padStart(2, "0"),
        family: families[(i + ci * 4) % families.length],
        motion: motions[(i * 11 + ci * 7) % motions.length],
        shape: shapes[(i * 3 + ci) % shapes.length],
        pattern: patterns[(i * 5 + ci) % patterns.length],
        icon: icons[(i + ci) % icons.length],
        hue: (i * 17 + ci * 23) % 360,
        hue2: ((i * 17 + ci * 23) + 54 + (i % 9) * 9) % 360,
        weight: (i + ci) % 9,
        variant: i + 1
      });
    }
  });

  return out;
};
