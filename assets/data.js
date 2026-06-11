window.BUTTONVERSE_CATEGORIES = [
  {
    "id": "cta-actions",
    "title": "CTA Actions",
    "desc": "Primary calls-to-action for landing pages, forms and funnels.",
    "icon": "\u2197",
    "count": 12
  },
  {
    "id": "commerce",
    "title": "Commerce",
    "desc": "Checkout, cart, pricing and purchase buttons.",
    "icon": "\u25c6",
    "count": 12
  },
  {
    "id": "forms-submit",
    "title": "Forms",
    "desc": "Submit, upload, save, apply and form action buttons.",
    "icon": "\u2713",
    "count": 12
  },
  {
    "id": "developer",
    "title": "Developer",
    "desc": "Deploy, API, Git and technical product buttons.",
    "icon": "\u2318",
    "count": 12
  },
  {
    "id": "ai-automation",
    "title": "AI & Automation",
    "desc": "Generate, refine, analyze and workflow buttons.",
    "icon": "AI",
    "count": 12
  },
  {
    "id": "security",
    "title": "Security",
    "desc": "Login, verify, unlock and privacy/security buttons.",
    "icon": "\u25c8",
    "count": 12
  },
  {
    "id": "media",
    "title": "Media",
    "desc": "Play, record, watch, stream and creator controls.",
    "icon": "\u25b6",
    "count": 12
  },
  {
    "id": "navigation",
    "title": "Navigation",
    "desc": "Tabs, routes, menus and compact navigation buttons.",
    "icon": "\u2301",
    "count": 12
  },
  {
    "id": "utility",
    "title": "Utility",
    "desc": "Copy, filter, download, search and small product actions.",
    "icon": "\u25cc",
    "count": 12
  },
  {
    "id": "editorial",
    "title": "Editorial",
    "desc": "Minimal, portfolio, luxury and content buttons.",
    "icon": "\u2726",
    "count": 12
  }
];

window.BUTTONVERSE_BUILD = function () {
  const families = ["glass", "solid", "outline", "soft", "neon", "paper", "terminal", "depth", "mono", "halo", "split", "beam", "calm", "flare", "corner", "pillbox", "chrome", "bevel", "label", "wire", "ribbon", "notch", "liquid", "magnet"];
  const motions = ["shine-pass", "press-down", "shadow-lift", "halo-grow", "arrow-launch", "focus-lock", "wipe-fill", "magnet-pull", "soft-breathe", "glint-turn", "under-trace", "beam-slice", "pop-bounce", "outline-push", "terminal-blink", "liquid-swell", "tilt-card", "ring-pop", "slide-glow", "label-swap"];
  const shapes = ["pill", "squircle", "round", "capsule", "ticket", "tab", "cut", "notch"];
  const patterns = ["plain", "softlight", "grain", "dots", "scan", "stripe"];
  const icons = ["\u2197", "\u2192", "\u2713", "+", "\u2318", "\u25c6", "\u2726", "\u25cf", "AI", "\u25c7", "\u21e3", "\u2301", "\u25cc", "\u26a1", "\u25a3", "\u2661", "\u25b6", "\u25c8"];
  const verbs = {
  "cta-actions": [
    "Start Now",
    "Get Started",
    "Continue",
    "Create",
    "Launch",
    "Join",
    "Explore",
    "Open App",
    "Try Free",
    "Begin",
    "Save",
    "Confirm"
  ],
  "commerce": [
    "Buy Now",
    "Checkout",
    "Add Cart",
    "Upgrade",
    "Subscribe",
    "Reserve",
    "Claim Deal",
    "Pay Securely",
    "Get Bundle",
    "Unlock Pro",
    "Order",
    "View Plan"
  ],
  "forms-submit": [
    "Submit",
    "Send Form",
    "Save Draft",
    "Apply Now",
    "Upload File",
    "Attach",
    "Verify",
    "Send Request",
    "Book Slot",
    "Finish",
    "Approve",
    "Review"
  ],
  "developer": [
    "Deploy",
    "Run Build",
    "Open API",
    "Copy Token",
    "Fork",
    "Merge",
    "Push",
    "Debug",
    "Start Server",
    "Ship Patch",
    "Open Docs",
    "Generate Key"
  ],
  "ai-automation": [
    "Generate",
    "Refine",
    "Summarize",
    "Analyze",
    "Auto Tag",
    "Build Flow",
    "Train Agent",
    "Compose",
    "Optimize",
    "Queue Task",
    "Improve Copy",
    "Run Agent"
  ],
  "security": [
    "Login",
    "Verify",
    "Unlock",
    "Enable 2FA",
    "Authorize",
    "Scan Key",
    "Encrypt",
    "Trust Device",
    "Create Passkey",
    "Secure Vault",
    "Allow",
    "Protect"
  ],
  "media": [
    "Play",
    "Watch",
    "Record",
    "Stream",
    "Replay",
    "Mute",
    "Remix",
    "Queue",
    "Tune In",
    "Upload Clip",
    "Export Video",
    "Open Studio"
  ],
  "navigation": [
    "Home",
    "Back",
    "Next",
    "Menu",
    "Overview",
    "Details",
    "Library",
    "Timeline",
    "Browse",
    "See More",
    "Open Panel",
    "Close"
  ],
  "utility": [
    "Copy",
    "Search",
    "Filter",
    "Sort",
    "Pin",
    "Star",
    "Download",
    "Export",
    "Import",
    "Sync",
    "Archive",
    "Delete"
  ],
  "editorial": [
    "Read More",
    "View Case",
    "Open Gallery",
    "Explore Archive",
    "Request Access",
    "Enter Lounge",
    "See Collection",
    "Begin Tour",
    "Download Kit",
    "Preview",
    "Inspect",
    "Learn"
  ]
};

  const cats = window.BUTTONVERSE_CATEGORIES;
  const out = [];
  let number = 1;

  cats.forEach((cat, ci) => {
    const list = verbs[cat.id] || [];
    for (let i = 0; i < list.length; i += 1) {
      out.push({
        id: cat.id + "-" + String(i + 1).padStart(2, "0"),
        number: number++,
        category: cat.id,
        categoryTitle: cat.title,
        categoryIcon: cat.icon,
        label: list[i],
        name: cat.title + " / " + String(i + 1).padStart(2, "0"),
        family: families[(i + ci * 3) % families.length],
        motion: motions[(i * 5 + ci * 2) % motions.length],
        shape: shapes[(i * 2 + ci) % shapes.length],
        pattern: patterns[(i + ci) % patterns.length],
        icon: icons[(i + ci * 2) % icons.length],
        hue: (i * 31 + ci * 27 + 18) % 360,
        hue2: ((i * 31 + ci * 27 + 18) + 58 + (i % 5) * 12) % 360,
        weight: (i + ci) % 7,
        variant: i + 1
      });
    }
  });

  return out;
};
