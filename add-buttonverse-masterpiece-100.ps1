$ErrorActionPreference = "Stop"

# Run inside either:
# 1) flowsync-button-site
# 2) flowsync-button-site\buttonverse-lab

$start = (Get-Location).Path

if ((Test-Path ".\buttonverse-lab\index.html") -and (Test-Path ".\buttonverse-lab\assets\styles.css")) {
  $site = Join-Path $start "buttonverse-lab"
} elseif ((Test-Path ".\index.html") -and (Test-Path ".\assets\styles.css") -and (Test-Path ".\library.html")) {
  $site = $start
} else {
  throw "Wrong folder. Run inside flowsync-button-site or inside buttonverse-lab."
}

$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backup = Join-Path (Split-Path $site -Parent) "buttonverse-lab-before-masterpiece-100_$stamp"
Copy-Item $site $backup -Recurse -Force

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)

function Save-Utf8($p, $t) {
  [System.IO.File]::WriteAllText($p, $t, $script:utf8NoBom)
}

function Read-Utf8($p) {
  [System.IO.File]::ReadAllText($p, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
}

Write-Host "1) Creating Masterpieces folder..."
New-Item -ItemType Directory -Path (Join-Path $site "masterpieces") -Force | Out-Null

Write-Host "2) Writing data, css, app files..."
$masterpieceData = @'
window.MASTERPIECE_BUTTONS = [
  {
    "id": "mp-001",
    "className": "mpb-001",
    "number": 1,
    "collection": "commerce",
    "collectionTitle": "Premium Commerce",
    "label": "Buy with Confidence",
    "desc": "Shielded premium checkout",
    "style": "paper-press",
    "motion": "tilt",
    "icon": "\u2713",
    "css": ".mpb-001 {\n  --mp-a: hsl(51 88% 60%);\n  --mp-b: hsl(111 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 22px;\n  border-radius: 18px 18px 8px 8px;\n  background: #f5dfbf;\n  color: #17100b;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 8px 0 rgba(89, 66, 36, .38), 0 22px 34px rgba(0,0,0,.14);\n  \n}\n.mpb-001::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 9px 11px;\n  opacity: .18;\n}\n.mpb-001:hover { transform: perspective(520px) rotateX(7deg) rotateY(-6deg) translateY(-2px); }\n"
  },
  {
    "id": "mp-002",
    "className": "mpb-002",
    "number": 2,
    "collection": "commerce",
    "collectionTitle": "Premium Commerce",
    "label": "Reserve Drop",
    "desc": "Limited release product button",
    "style": "secure-lock",
    "motion": "press",
    "icon": "\u25c6",
    "css": ".mpb-002 {\n  --mp-a: hsl(74 88% 60%);\n  --mp-b: hsl(152 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 24px;\n  border-radius: 34px 18px 28px 16px;\n  background: linear-gradient(135deg, #0b0d12, color-mix(in srgb, var(--mp-a) 20%, #0b0d12));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 30px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-002::before {\n  content: \"\";\n  position: absolute;\n  inset: 50%;\n  border-radius: inherit;\n  background: color-mix(in srgb, var(--mp-a) 22%, transparent);\n  transition: inset .42s ease, opacity .42s ease;\n  opacity: 0;\n}\n.mpb-002:hover::before { inset: -30%; opacity: 1; }\n.mpb-002:active { transform: translateY(2px) scale(.985); }\n"
  },
  {
    "id": "mp-003",
    "className": "mpb-003",
    "number": 3,
    "collection": "commerce",
    "collectionTitle": "Premium Commerce",
    "label": "Upgrade Studio",
    "desc": "SaaS upgrade with calm luxury",
    "style": "halo-soft",
    "motion": "rise",
    "icon": "\u2726",
    "css": ".mpb-003 {\n  --mp-a: hsl(97 88% 60%);\n  --mp-b: hsl(193 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 26px;\n  border-radius: 14px;\n  background: color-mix(in srgb, var(--mp-a) 14%, transparent);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 33px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-003:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }\n.mpb-003:hover { transform: translateY(-6px); }\n"
  },
  {
    "id": "mp-004",
    "className": "mpb-004",
    "number": 4,
    "collection": "commerce",
    "collectionTitle": "Premium Commerce",
    "label": "Add to Vault",
    "desc": "Cart action with storage feel",
    "style": "command-frame",
    "motion": "fill",
    "icon": "\u2318",
    "css": ".mpb-004 {\n  --mp-a: hsl(120 88% 60%);\n  --mp-b: hsl(234 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 28px;\n  border-radius: 10px;\n  background: #080b0d;\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 36px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  \n}\n.mpb-004::after {\n  content: \"_\";\n  margin-left: .08em;\n  color: currentColor;\n  animation: mpBlink 900ms steps(1) infinite;\n}\n.mpb-004:hover { letter-spacing: .025em; }\n"
  },
  {
    "id": "mp-005",
    "className": "mpb-005",
    "number": 5,
    "collection": "commerce",
    "collectionTitle": "Premium Commerce",
    "label": "Claim Offer",
    "desc": "Deal button without cheap neon",
    "style": "status-rail",
    "motion": "soft-pop",
    "icon": "\u25cc",
    "css": ".mpb-005 {\n  --mp-a: hsl(143 88% 60%);\n  --mp-b: hsl(275 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 20px;\n  border-radius: 26px;\n  background: linear-gradient(90deg, color-mix(in srgb, var(--mp-a) 20%, transparent), transparent);\n  color: #fff8ed;\n  border: 0;\n  box-shadow: 0 10px 39px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-005::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 8px 10px;\n  opacity: .18;\n}\n.mpb-005:hover { transform: scale(1.045); }\n"
  },
  {
    "id": "mp-006",
    "className": "mpb-006",
    "number": 6,
    "collection": "commerce",
    "collectionTitle": "Premium Commerce",
    "label": "Start Trial",
    "desc": "Modern trial CTA",
    "style": "mesh-pulse",
    "motion": "fold",
    "icon": "\u21e3",
    "css": ".mpb-006 {\n  --mp-a: hsl(166 88% 60%);\n  --mp-b: hsl(208 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 22px;\n  border-radius: 999px 20px 999px 20px;\n  background: linear-gradient(135deg, color-mix(in srgb,var(--mp-a) 18%, transparent), color-mix(in srgb,var(--mp-b) 16%, transparent));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 42px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  \n}\n.mpb-006::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 9px 11px;\n  opacity: .18;\n}\n.mpb-006:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }\n"
  },
  {
    "id": "mp-007",
    "className": "mpb-007",
    "number": 7,
    "collection": "commerce",
    "collectionTitle": "Premium Commerce",
    "label": "Secure Pay",
    "desc": "Payment with trust signal",
    "style": "floating-tab",
    "motion": "shimmer",
    "icon": "\u21bb",
    "css": ".mpb-007 {\n  --mp-a: hsl(189 88% 60%);\n  --mp-b: hsl(249 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 24px;\n  border-radius: 22px 12px;\n  background: color-mix(in srgb, var(--mp-a) 20%, var(--mp-panel));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 24px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;\n}\n.mpb-007::before {\n  content: \"\";\n  position: absolute;\n  right: 0;\n  top: 0;\n  border-top: 18px solid rgba(255,255,255,.42);\n  border-left: 18px solid transparent;\n  opacity: .75;\n}\n.mpb-007:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }\n"
  },
  {
    "id": "mp-008",
    "className": "mpb-008",
    "number": 8,
    "collection": "commerce",
    "collectionTitle": "Premium Commerce",
    "label": "Unlock Plan",
    "desc": "Pricing unlock action",
    "style": "liquid-core",
    "motion": "breath",
    "icon": "\u27e1",
    "css": ".mpb-008 {\n  --mp-a: hsl(212 88% 60%);\n  --mp-b: hsl(290 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 26px;\n  border-radius: 14px;\n  background: radial-gradient(circle at 30% 20%, white, var(--mp-a) 24%, var(--mp-b));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 27px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-008:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }\n.mpb-008:hover { animation: mpBreath 1.1s ease-in-out infinite; }\n"
  },
  {
    "id": "mp-009",
    "className": "mpb-009",
    "number": 9,
    "collection": "commerce",
    "collectionTitle": "Premium Commerce",
    "label": "Book Slot",
    "desc": "Appointment purchase action",
    "style": "editorial-line",
    "motion": "launch",
    "icon": "\u2192",
    "css": ".mpb-009 {\n  --mp-a: hsl(235 88% 60%);\n  --mp-b: hsl(331 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 28px;\n  border-radius: 18px;\n  background: transparent;\n  color: var(--mp-a);\n  border: 1.5px solid var(--mp-a);\n  box-shadow: none;\n  \n}\n.mpb-009::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 12px 9px;\n  opacity: .18;\n}\n.mpb-009:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }\n"
  },
  {
    "id": "mp-010",
    "className": "mpb-010",
    "number": 10,
    "collection": "commerce",
    "collectionTitle": "Premium Commerce",
    "label": "Get Bundle",
    "desc": "Bundle checkout button",
    "style": "ribbon-cut",
    "motion": "snap",
    "icon": "\u25c7",
    "css": ".mpb-010 {\n  --mp-a: hsl(258 88% 60%);\n  --mp-b: hsl(12 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 20px;\n  border-radius: 999px;\n  background: linear-gradient(90deg, var(--mp-a), var(--mp-b));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 33px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-010::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);\n  opacity: .55;\n}\n.mpb-010:hover { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-011",
    "className": "mpb-011",
    "number": 11,
    "collection": "saas",
    "collectionTitle": "SaaS Dashboard",
    "label": "Create Workspace",
    "desc": "Primary app action",
    "style": "magnetic-outline",
    "motion": "press",
    "icon": "\u25cf",
    "css": ".mpb-011 {\n  --mp-a: hsl(298 88% 60%);\n  --mp-b: hsl(70 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 22px;\n  border-radius: 34px 18px 28px 16px;\n  background: transparent;\n  color: var(--mp-a);\n  border: 1.5px solid var(--mp-a);\n  box-shadow: none;\n  \n}\n.mpb-011::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 9px 11px;\n  opacity: .18;\n}\n.mpb-011:active { transform: translateY(2px) scale(.985); }\n"
  },
  {
    "id": "mp-012",
    "className": "mpb-012",
    "number": 12,
    "collection": "saas",
    "collectionTitle": "SaaS Dashboard",
    "label": "Invite Team",
    "desc": "Collaboration CTA",
    "style": "folded-corner",
    "motion": "rise",
    "icon": "\u2727",
    "css": ".mpb-012 {\n  --mp-a: hsl(321 88% 60%);\n  --mp-b: hsl(3 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 24px;\n  border-radius: 14px;\n  background: linear-gradient(135deg, var(--mp-a) 0 76%, color-mix(in srgb, var(--mp-a) 58%, black) 76%);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 39px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-012::before {\n  content: \"\";\n  position: absolute;\n  right: 0;\n  top: 0;\n  border-top: 18px solid rgba(255,255,255,.42);\n  border-left: 18px solid transparent;\n  opacity: .75;\n}\n.mpb-012:hover { transform: translateY(-6px); }\n"
  },
  {
    "id": "mp-013",
    "className": "mpb-013",
    "number": 13,
    "collection": "saas",
    "collectionTitle": "SaaS Dashboard",
    "label": "Open Report",
    "desc": "Analytics dashboard action",
    "style": "frost-panel",
    "motion": "fill",
    "icon": "\u25a3",
    "css": ".mpb-013 {\n  --mp-a: hsl(344 88% 60%);\n  --mp-b: hsl(44 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 26px;\n  border-radius: 18px;\n  background: rgba(255,255,255,.08);\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 42px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-013::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);\n  transform: translateX(-130%);\n  transition: transform .62s cubic-bezier(.2,.8,.2,1);\n}\n.mpb-013:hover::before { transform: translateX(130%); }\n.mpb-013:hover { letter-spacing: .025em; }\n"
  },
  {
    "id": "mp-014",
    "className": "mpb-014",
    "number": 14,
    "collection": "saas",
    "collectionTitle": "SaaS Dashboard",
    "label": "Sync Changes",
    "desc": "Status-based app button",
    "style": "split-ticket",
    "motion": "soft-pop",
    "icon": "\u21e1",
    "css": ".mpb-014 {\n  --mp-a: hsl(7 88% 60%);\n  --mp-b: hsl(85 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 28px;\n  border-radius: 26px;\n  background: linear-gradient(90deg, var(--mp-a) 0 52%, var(--mp-b) 52%);\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 24px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-014::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);\n  opacity: .55;\n}\n.mpb-014:hover { transform: scale(1.045); }\n"
  },
  {
    "id": "mp-015",
    "className": "mpb-015",
    "number": 15,
    "collection": "saas",
    "collectionTitle": "SaaS Dashboard",
    "label": "Launch Board",
    "desc": "Project workspace action",
    "style": "neon-minimal",
    "motion": "fold",
    "icon": "AI",
    "css": ".mpb-015 {\n  --mp-a: hsl(30 88% 60%);\n  --mp-b: hsl(126 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 20px;\n  border-radius: 999px 20px 999px 20px;\n  background: #070810;\n  color: var(--mp-a);\n  border: 1px solid var(--mp-a);\n  box-shadow: 0 10px 27px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-015::before {\n  content: \"\";\n  position: absolute;\n  inset: 50%;\n  border-radius: inherit;\n  background: color-mix(in srgb, var(--mp-a) 22%, transparent);\n  transition: inset .42s ease, opacity .42s ease;\n  opacity: 0;\n}\n.mpb-015:hover::before { inset: -30%; opacity: 1; }\n.mpb-015:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }\n"
  },
  {
    "id": "mp-016",
    "className": "mpb-016",
    "number": 16,
    "collection": "saas",
    "collectionTitle": "SaaS Dashboard",
    "label": "Save View",
    "desc": "Dashboard view save",
    "style": "gradient-frame",
    "motion": "shimmer",
    "icon": "\u2316",
    "css": ".mpb-016 {\n  --mp-a: hsl(53 88% 60%);\n  --mp-b: hsl(167 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 22px;\n  border-radius: 22px 12px;\n  background: linear-gradient(var(--mp-bg), var(--mp-bg)) padding-box, linear-gradient(135deg,var(--mp-a),var(--mp-b)) border-box;\n  color: #fff8ed;\n  border: 1px solid transparent;\n  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-016::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 9px 11px;\n  opacity: .18;\n}\n.mpb-016:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }\n"
  },
  {
    "id": "mp-017",
    "className": "mpb-017",
    "number": 17,
    "collection": "saas",
    "collectionTitle": "SaaS Dashboard",
    "label": "New Pipeline",
    "desc": "CRM style action",
    "style": "terminal-pill",
    "motion": "breath",
    "icon": "\u2661",
    "css": ".mpb-017 {\n  --mp-a: hsl(76 88% 60%);\n  --mp-b: hsl(208 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 24px;\n  border-radius: 0;\n  background: #060b08;\n  color: #b9ff57;\n  border: 1px solid #b9ff57;\n  box-shadow: none;\n  \n}\n.mpb-017::after {\n  content: \"_\";\n  margin-left: .08em;\n  color: currentColor;\n  animation: mpBlink 900ms steps(1) infinite;\n}\n.mpb-017:hover { animation: mpBreath 1.1s ease-in-out infinite; }\n"
  },
  {
    "id": "mp-018",
    "className": "mpb-018",
    "number": 18,
    "collection": "saas",
    "collectionTitle": "SaaS Dashboard",
    "label": "Export Metrics",
    "desc": "Data export button",
    "style": "soft-depth",
    "motion": "launch",
    "icon": "\u266b",
    "css": ".mpb-018 {\n  --mp-a: hsl(99 88% 60%);\n  --mp-b: hsl(141 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 26px;\n  border-radius: 18px;\n  background: linear-gradient(180deg, color-mix(in srgb, var(--mp-a) 90%, white 10%), color-mix(in srgb, var(--mp-a) 62%, black 20%));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 36px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-018::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-018:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }\n"
  },
  {
    "id": "mp-019",
    "className": "mpb-019",
    "number": 19,
    "collection": "saas",
    "collectionTitle": "SaaS Dashboard",
    "label": "Connect Tool",
    "desc": "Integration CTA",
    "style": "orbital-chip",
    "motion": "snap",
    "icon": "\u2197",
    "css": ".mpb-019 {\n  --mp-a: hsl(122 88% 60%);\n  --mp-b: hsl(182 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 28px;\n  border-radius: 999px;\n  background: linear-gradient(135deg, var(--mp-a), var(--mp-b));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 39px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-019::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 12px 9px;\n  opacity: .18;\n}\n.mpb-019:hover { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-020",
    "className": "mpb-020",
    "number": 20,
    "collection": "saas",
    "collectionTitle": "SaaS Dashboard",
    "label": "Publish Update",
    "desc": "Product update action",
    "style": "monochrome-badge",
    "motion": "lift",
    "icon": "\u2713",
    "css": ".mpb-020 {\n  --mp-a: hsl(145 88% 60%);\n  --mp-b: hsl(223 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 20px;\n  border-radius: 18px 18px 8px 8px;\n  background: linear-gradient(135deg, #111, #2b2b2b);\n  color: #fff8ed;\n  border: 2px solid #000;\n  box-shadow: 4px 4px 0 #000;\n  \n}\n.mpb-020::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 8px 10px;\n  opacity: .18;\n}\n.mpb-020:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }\n"
  },
  {
    "id": "mp-021",
    "className": "mpb-021",
    "number": 21,
    "collection": "security",
    "collectionTitle": "Auth & Security",
    "label": "Verify Identity",
    "desc": "KYC/Auth button",
    "style": "command-frame",
    "motion": "rise",
    "icon": "\u2726",
    "css": ".mpb-021 {\n  --mp-a: hsl(185 88% 60%);\n  --mp-b: hsl(281 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 22px;\n  border-radius: 14px;\n  background: #080b0d;\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 24px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  \n}\n.mpb-021::after {\n  content: \"_\";\n  margin-left: .08em;\n  color: currentColor;\n  animation: mpBlink 900ms steps(1) infinite;\n}\n.mpb-021:hover { transform: translateY(-6px); }\n"
  },
  {
    "id": "mp-022",
    "className": "mpb-022",
    "number": 22,
    "collection": "security",
    "collectionTitle": "Auth & Security",
    "label": "Unlock Session",
    "desc": "Secure login action",
    "style": "status-rail",
    "motion": "fill",
    "icon": "\u2318",
    "css": ".mpb-022 {\n  --mp-a: hsl(208 88% 60%);\n  --mp-b: hsl(322 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 24px;\n  border-radius: 18px;\n  background: linear-gradient(90deg, color-mix(in srgb, var(--mp-a) 20%, transparent), transparent);\n  color: #fff8ed;\n  border: 0;\n  box-shadow: 0 14px 27px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-022::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 10px 12px;\n  opacity: .18;\n}\n.mpb-022:hover { letter-spacing: .025em; }\n"
  },
  {
    "id": "mp-023",
    "className": "mpb-023",
    "number": 23,
    "collection": "security",
    "collectionTitle": "Auth & Security",
    "label": "Enable 2FA",
    "desc": "Security settings CTA",
    "style": "mesh-pulse",
    "motion": "soft-pop",
    "icon": "\u25cc",
    "css": ".mpb-023 {\n  --mp-a: hsl(231 88% 60%);\n  --mp-b: hsl(3 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 26px;\n  border-radius: 999px;\n  background: linear-gradient(135deg, color-mix(in srgb,var(--mp-a) 18%, transparent), color-mix(in srgb,var(--mp-b) 16%, transparent));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-023::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-023:hover { transform: scale(1.045); }\n"
  },
  {
    "id": "mp-024",
    "className": "mpb-024",
    "number": 24,
    "collection": "security",
    "collectionTitle": "Auth & Security",
    "label": "Approve Device",
    "desc": "Device trust button",
    "style": "floating-tab",
    "motion": "fold",
    "icon": "\u21e3",
    "css": ".mpb-024 {\n  --mp-a: hsl(254 88% 60%);\n  --mp-b: hsl(296 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 28px;\n  border-radius: 18px 18px 8px 8px;\n  background: color-mix(in srgb, var(--mp-a) 20%, var(--mp-panel));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 33px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;\n}\n.mpb-024::before {\n  content: \"\";\n  position: absolute;\n  right: 0;\n  top: 0;\n  border-top: 18px solid rgba(255,255,255,.42);\n  border-left: 18px solid transparent;\n  opacity: .75;\n}\n.mpb-024:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }\n"
  },
  {
    "id": "mp-025",
    "className": "mpb-025",
    "number": 25,
    "collection": "security",
    "collectionTitle": "Auth & Security",
    "label": "Scan Key",
    "desc": "Key/security action",
    "style": "liquid-core",
    "motion": "shimmer",
    "icon": "\u21bb",
    "css": ".mpb-025 {\n  --mp-a: hsl(277 88% 60%);\n  --mp-b: hsl(337 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 20px;\n  border-radius: 22px 12px;\n  background: radial-gradient(circle at 30% 20%, white, var(--mp-a) 24%, var(--mp-b));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 36px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-025:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }\n.mpb-025:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }\n"
  },
  {
    "id": "mp-026",
    "className": "mpb-026",
    "number": 26,
    "collection": "security",
    "collectionTitle": "Auth & Security",
    "label": "Create Passkey",
    "desc": "Modern auth CTA",
    "style": "editorial-line",
    "motion": "breath",
    "icon": "\u27e1",
    "css": ".mpb-026 {\n  --mp-a: hsl(300 88% 60%);\n  --mp-b: hsl(18 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 22px;\n  border-radius: 0;\n  background: transparent;\n  color: var(--mp-a);\n  border: 1.5px solid var(--mp-a);\n  box-shadow: none;\n  \n}\n.mpb-026::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 9px 11px;\n  opacity: .18;\n}\n.mpb-026:hover { animation: mpBreath 1.1s ease-in-out infinite; }\n"
  },
  {
    "id": "mp-027",
    "className": "mpb-027",
    "number": 27,
    "collection": "security",
    "collectionTitle": "Auth & Security",
    "label": "Secure Vault",
    "desc": "Password vault action",
    "style": "ribbon-cut",
    "motion": "launch",
    "icon": "\u2192",
    "css": ".mpb-027 {\n  --mp-a: hsl(323 88% 60%);\n  --mp-b: hsl(59 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 24px;\n  border-radius: 10px;\n  background: linear-gradient(90deg, var(--mp-a), var(--mp-b));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 42px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-027::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);\n  opacity: .55;\n}\n.mpb-027:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }\n"
  },
  {
    "id": "mp-028",
    "className": "mpb-028",
    "number": 28,
    "collection": "security",
    "collectionTitle": "Auth & Security",
    "label": "Authorize",
    "desc": "Permission button",
    "style": "quiet-luxury",
    "motion": "snap",
    "icon": "\u25c7",
    "css": ".mpb-028 {\n  --mp-a: hsl(346 88% 60%);\n  --mp-b: hsl(100 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 26px;\n  border-radius: 999px;\n  background: linear-gradient(135deg, #fff7e9, color-mix(in srgb, var(--mp-a) 16%, #f7e8d1));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 24px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-028::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-028:hover { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-029",
    "className": "mpb-029",
    "number": 29,
    "collection": "security",
    "collectionTitle": "Auth & Security",
    "label": "Trust Browser",
    "desc": "Login trust action",
    "style": "steel-bevel",
    "motion": "lift",
    "icon": "\u2301",
    "css": ".mpb-029 {\n  --mp-a: hsl(9 88% 60%);\n  --mp-b: hsl(141 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 28px;\n  border-radius: 18px 18px 8px 8px;\n  background: linear-gradient(135deg, #f9f4e8, #6d7480, #fff8ed);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 27px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  \n}\n.mpb-029::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);\n  transform: translateX(-130%);\n  transition: transform .62s cubic-bezier(.2,.8,.2,1);\n}\n.mpb-029:hover::before { transform: translateX(130%); }\n.mpb-029:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }\n"
  },
  {
    "id": "mp-030",
    "className": "mpb-030",
    "number": 30,
    "collection": "security",
    "collectionTitle": "Auth & Security",
    "label": "Encrypt File",
    "desc": "Privacy tool button",
    "style": "warm-clay",
    "motion": "unlock",
    "icon": "\u25cf",
    "css": ".mpb-030 {\n  --mp-a: hsl(32 88% 60%);\n  --mp-b: hsl(74 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 20px;\n  border-radius: 34px 18px 28px 16px;\n  background: linear-gradient(135deg, #b86b3a, #e7ba78);\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;\n}\n.mpb-030::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 8px 10px;\n  opacity: .18;\n}\n.mpb-030:hover .mp-icon { transform: translate(4px,-4px); }\n"
  },
  {
    "id": "mp-031",
    "className": "mpb-031",
    "number": 31,
    "collection": "creative",
    "collectionTitle": "Creative Studio",
    "label": "Render Scene",
    "desc": "3D/render button",
    "style": "split-ticket",
    "motion": "fill",
    "icon": "\u25a3",
    "css": ".mpb-031 {\n  --mp-a: hsl(72 88% 60%);\n  --mp-b: hsl(132 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 22px;\n  border-radius: 18px;\n  background: linear-gradient(90deg, var(--mp-a) 0 52%, var(--mp-b) 52%);\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 33px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-031::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);\n  opacity: .55;\n}\n.mpb-031:hover { letter-spacing: .025em; }\n"
  },
  {
    "id": "mp-032",
    "className": "mpb-032",
    "number": 32,
    "collection": "creative",
    "collectionTitle": "Creative Studio",
    "label": "Export Canvas",
    "desc": "Design export CTA",
    "style": "neon-minimal",
    "motion": "soft-pop",
    "icon": "\u21e1",
    "css": ".mpb-032 {\n  --mp-a: hsl(95 88% 60%);\n  --mp-b: hsl(173 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 24px;\n  border-radius: 999px;\n  background: #070810;\n  color: var(--mp-a);\n  border: 1px solid var(--mp-a);\n  box-shadow: 0 14px 36px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-032::before {\n  content: \"\";\n  position: absolute;\n  inset: 50%;\n  border-radius: inherit;\n  background: color-mix(in srgb, var(--mp-a) 22%, transparent);\n  transition: inset .42s ease, opacity .42s ease;\n  opacity: 0;\n}\n.mpb-032:hover::before { inset: -30%; opacity: 1; }\n.mpb-032:hover { transform: scale(1.045); }\n"
  },
  {
    "id": "mp-033",
    "className": "mpb-033",
    "number": 33,
    "collection": "creative",
    "collectionTitle": "Creative Studio",
    "label": "Generate Palette",
    "desc": "Color workflow action",
    "style": "gradient-frame",
    "motion": "fold",
    "icon": "AI",
    "css": ".mpb-033 {\n  --mp-a: hsl(118 88% 60%);\n  --mp-b: hsl(214 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 26px;\n  border-radius: 18px 18px 8px 8px;\n  background: linear-gradient(var(--mp-bg), var(--mp-bg)) padding-box, linear-gradient(135deg,var(--mp-a),var(--mp-b)) border-box;\n  color: #fff8ed;\n  border: 1px solid transparent;\n  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-033::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-033:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }\n"
  },
  {
    "id": "mp-034",
    "className": "mpb-034",
    "number": 34,
    "collection": "creative",
    "collectionTitle": "Creative Studio",
    "label": "Add Layer",
    "desc": "Creative tool button",
    "style": "terminal-pill",
    "motion": "shimmer",
    "icon": "\u2316",
    "css": ".mpb-034 {\n  --mp-a: hsl(141 88% 60%);\n  --mp-b: hsl(255 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 28px;\n  border-radius: 34px 18px 28px 16px;\n  background: #060b08;\n  color: #b9ff57;\n  border: 1px solid #b9ff57;\n  box-shadow: none;\n  \n}\n.mpb-034::after {\n  content: \"_\";\n  margin-left: .08em;\n  color: currentColor;\n  animation: mpBlink 900ms steps(1) infinite;\n}\n.mpb-034:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }\n"
  },
  {
    "id": "mp-035",
    "className": "mpb-035",
    "number": 35,
    "collection": "creative",
    "collectionTitle": "Creative Studio",
    "label": "Open Moodboard",
    "desc": "Design board action",
    "style": "soft-depth",
    "motion": "breath",
    "icon": "\u2661",
    "css": ".mpb-035 {\n  --mp-a: hsl(164 88% 60%);\n  --mp-b: hsl(296 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 20px;\n  border-radius: 0;\n  background: linear-gradient(180deg, color-mix(in srgb, var(--mp-a) 90%, white 10%), color-mix(in srgb, var(--mp-a) 62%, black 20%));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 24px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-035::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 8px 10px;\n  opacity: .18;\n}\n.mpb-035:hover { animation: mpBreath 1.1s ease-in-out infinite; }\n"
  },
  {
    "id": "mp-036",
    "className": "mpb-036",
    "number": 36,
    "collection": "creative",
    "collectionTitle": "Creative Studio",
    "label": "Publish Artwork",
    "desc": "Creator CTA",
    "style": "orbital-chip",
    "motion": "launch",
    "icon": "\u266b",
    "css": ".mpb-036 {\n  --mp-a: hsl(187 88% 60%);\n  --mp-b: hsl(229 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 22px;\n  border-radius: 10px;\n  background: linear-gradient(135deg, var(--mp-a), var(--mp-b));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 27px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-036::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 9px 11px;\n  opacity: .18;\n}\n.mpb-036:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }\n"
  },
  {
    "id": "mp-037",
    "className": "mpb-037",
    "number": 37,
    "collection": "creative",
    "collectionTitle": "Creative Studio",
    "label": "Crop Frame",
    "desc": "Image editing action",
    "style": "monochrome-badge",
    "motion": "snap",
    "icon": "\u2197",
    "css": ".mpb-037 {\n  --mp-a: hsl(210 88% 60%);\n  --mp-b: hsl(270 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 24px;\n  border-radius: 26px;\n  background: linear-gradient(135deg, #111, #2b2b2b);\n  color: #fff8ed;\n  border: 2px solid #000;\n  box-shadow: 4px 4px 0 #000;\n  \n}\n.mpb-037::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 10px 12px;\n  opacity: .18;\n}\n.mpb-037:hover { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-038",
    "className": "mpb-038",
    "number": 38,
    "collection": "creative",
    "collectionTitle": "Creative Studio",
    "label": "Style Variant",
    "desc": "Design variant action",
    "style": "aurora-glass",
    "motion": "lift",
    "icon": "\u2713",
    "css": ".mpb-038 {\n  --mp-a: hsl(233 88% 60%);\n  --mp-b: hsl(311 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 26px;\n  border-radius: 18px 18px 8px 8px;\n  background: linear-gradient(135deg, color-mix(in srgb, var(--mp-a) 28%, transparent), color-mix(in srgb, var(--mp-b) 18%, transparent));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 33px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-038::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);\n  transform: translateX(-130%);\n  transition: transform .62s cubic-bezier(.2,.8,.2,1);\n}\n.mpb-038:hover::before { transform: translateX(130%); }\n.mpb-038:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }\n"
  },
  {
    "id": "mp-039",
    "className": "mpb-039",
    "number": 39,
    "collection": "creative",
    "collectionTitle": "Creative Studio",
    "label": "Save Preset",
    "desc": "Creative preset button",
    "style": "paper-press",
    "motion": "unlock",
    "icon": "\u25c6",
    "css": ".mpb-039 {\n  --mp-a: hsl(256 88% 60%);\n  --mp-b: hsl(352 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 28px;\n  border-radius: 34px 18px 28px 16px;\n  background: #f5dfbf;\n  color: #17100b;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 8px 0 rgba(89, 66, 36, .38), 0 22px 34px rgba(0,0,0,.14);\n  \n}\n.mpb-039::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 12px 9px;\n  opacity: .18;\n}\n.mpb-039:hover .mp-icon { transform: translate(4px,-4px); }\n"
  },
  {
    "id": "mp-040",
    "className": "mpb-040",
    "number": 40,
    "collection": "creative",
    "collectionTitle": "Creative Studio",
    "label": "Start Draft",
    "desc": "Writing/design draft",
    "style": "secure-lock",
    "motion": "glint",
    "icon": "\u2726",
    "css": ".mpb-040 {\n  --mp-a: hsl(279 88% 60%);\n  --mp-b: hsl(33 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 20px;\n  border-radius: 14px;\n  background: linear-gradient(135deg, #0b0d12, color-mix(in srgb, var(--mp-a) 20%, #0b0d12));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 39px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-040::before {\n  content: \"\";\n  position: absolute;\n  inset: 50%;\n  border-radius: inherit;\n  background: color-mix(in srgb, var(--mp-a) 22%, transparent);\n  transition: inset .42s ease, opacity .42s ease;\n  opacity: 0;\n}\n.mpb-040:hover::before { inset: -30%; opacity: 1; }\n.mpb-040:hover .mp-icon { transform: rotate(18deg) scale(1.12); }\n"
  },
  {
    "id": "mp-041",
    "className": "mpb-041",
    "number": 41,
    "collection": "developer",
    "collectionTitle": "Developer Console",
    "label": "Deploy Build",
    "desc": "Production deploy button",
    "style": "floating-tab",
    "motion": "soft-pop",
    "icon": "\u25cc",
    "css": ".mpb-041 {\n  --mp-a: hsl(319 88% 60%);\n  --mp-b: hsl(91 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 22px;\n  border-radius: 26px;\n  background: color-mix(in srgb, var(--mp-a) 20%, var(--mp-panel));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 42px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;\n}\n.mpb-041::before {\n  content: \"\";\n  position: absolute;\n  right: 0;\n  top: 0;\n  border-top: 18px solid rgba(255,255,255,.42);\n  border-left: 18px solid transparent;\n  opacity: .75;\n}\n.mpb-041:hover { transform: scale(1.045); }\n"
  },
  {
    "id": "mp-042",
    "className": "mpb-042",
    "number": 42,
    "collection": "developer",
    "collectionTitle": "Developer Console",
    "label": "Run Test",
    "desc": "Dev tool action",
    "style": "liquid-core",
    "motion": "fold",
    "icon": "\u21e3",
    "css": ".mpb-042 {\n  --mp-a: hsl(342 88% 60%);\n  --mp-b: hsl(24 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 24px;\n  border-radius: 18px 18px 8px 8px;\n  background: radial-gradient(circle at 30% 20%, white, var(--mp-a) 24%, var(--mp-b));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 24px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-042:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }\n.mpb-042:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }\n"
  },
  {
    "id": "mp-043",
    "className": "mpb-043",
    "number": 43,
    "collection": "developer",
    "collectionTitle": "Developer Console",
    "label": "Merge Request",
    "desc": "Git workflow CTA",
    "style": "editorial-line",
    "motion": "shimmer",
    "icon": "\u21bb",
    "css": ".mpb-043 {\n  --mp-a: hsl(5 88% 60%);\n  --mp-b: hsl(65 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 26px;\n  border-radius: 34px 18px 28px 16px;\n  background: transparent;\n  color: var(--mp-a);\n  border: 1.5px solid var(--mp-a);\n  box-shadow: none;\n  \n}\n.mpb-043::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-043:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }\n"
  },
  {
    "id": "mp-044",
    "className": "mpb-044",
    "number": 44,
    "collection": "developer",
    "collectionTitle": "Developer Console",
    "label": "Open API",
    "desc": "Developer docs action",
    "style": "ribbon-cut",
    "motion": "breath",
    "icon": "\u27e1",
    "css": ".mpb-044 {\n  --mp-a: hsl(28 88% 60%);\n  --mp-b: hsl(106 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 28px;\n  border-radius: 14px;\n  background: linear-gradient(90deg, var(--mp-a), var(--mp-b));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 30px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-044::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);\n  opacity: .55;\n}\n.mpb-044:hover { animation: mpBreath 1.1s ease-in-out infinite; }\n"
  },
  {
    "id": "mp-045",
    "className": "mpb-045",
    "number": 45,
    "collection": "developer",
    "collectionTitle": "Developer Console",
    "label": "Fork Project",
    "desc": "Repo action",
    "style": "quiet-luxury",
    "motion": "launch",
    "icon": "\u2192",
    "css": ".mpb-045 {\n  --mp-a: hsl(51 88% 60%);\n  --mp-b: hsl(147 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 20px;\n  border-radius: 10px;\n  background: linear-gradient(135deg, #fff7e9, color-mix(in srgb, var(--mp-a) 16%, #f7e8d1));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 33px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-045::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 8px 10px;\n  opacity: .18;\n}\n.mpb-045:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }\n"
  },
  {
    "id": "mp-046",
    "className": "mpb-046",
    "number": 46,
    "collection": "developer",
    "collectionTitle": "Developer Console",
    "label": "Ship Patch",
    "desc": "Release action",
    "style": "steel-bevel",
    "motion": "snap",
    "icon": "\u25c7",
    "css": ".mpb-046 {\n  --mp-a: hsl(74 88% 60%);\n  --mp-b: hsl(188 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 22px;\n  border-radius: 26px;\n  background: linear-gradient(135deg, #f9f4e8, #6d7480, #fff8ed);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 36px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  \n}\n.mpb-046::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);\n  transform: translateX(-130%);\n  transition: transform .62s cubic-bezier(.2,.8,.2,1);\n}\n.mpb-046:hover::before { transform: translateX(130%); }\n.mpb-046:hover { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-047",
    "className": "mpb-047",
    "number": 47,
    "collection": "developer",
    "collectionTitle": "Developer Console",
    "label": "Start Server",
    "desc": "Local dev button",
    "style": "warm-clay",
    "motion": "lift",
    "icon": "\u2301",
    "css": ".mpb-047 {\n  --mp-a: hsl(97 88% 60%);\n  --mp-b: hsl(229 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 24px;\n  border-radius: 999px 20px 999px 20px;\n  background: linear-gradient(135deg, #b86b3a, #e7ba78);\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 39px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;\n}\n.mpb-047::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 10px 12px;\n  opacity: .18;\n}\n.mpb-047:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }\n"
  },
  {
    "id": "mp-048",
    "className": "mpb-048",
    "number": 48,
    "collection": "developer",
    "collectionTitle": "Developer Console",
    "label": "Debug Flow",
    "desc": "Debugging action",
    "style": "vault-door",
    "motion": "unlock",
    "icon": "\u25cf",
    "css": ".mpb-048 {\n  --mp-a: hsl(120 88% 60%);\n  --mp-b: hsl(162 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 26px;\n  border-radius: 22px 12px;\n  background: linear-gradient(90deg, #101319 0 48%, color-mix(in srgb,var(--mp-a) 18%,#101319) 48%);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 42px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-048::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-048:hover .mp-icon { transform: translate(4px,-4px); }\n"
  },
  {
    "id": "mp-049",
    "className": "mpb-049",
    "number": 49,
    "collection": "developer",
    "collectionTitle": "Developer Console",
    "label": "Copy Token",
    "desc": "API token action",
    "style": "magnetic-outline",
    "motion": "glint",
    "icon": "\u2727",
    "css": ".mpb-049 {\n  --mp-a: hsl(143 88% 60%);\n  --mp-b: hsl(203 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 28px;\n  border-radius: 14px;\n  background: transparent;\n  color: var(--mp-a);\n  border: 1.5px solid var(--mp-a);\n  box-shadow: none;\n  \n}\n.mpb-049::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 12px 9px;\n  opacity: .18;\n}\n.mpb-049:hover .mp-icon { transform: rotate(18deg) scale(1.12); }\n"
  },
  {
    "id": "mp-050",
    "className": "mpb-050",
    "number": 50,
    "collection": "developer",
    "collectionTitle": "Developer Console",
    "label": "Push Commit",
    "desc": "Git action",
    "style": "folded-corner",
    "motion": "focus",
    "icon": "\u25a3",
    "css": ".mpb-050 {\n  --mp-a: hsl(166 88% 60%);\n  --mp-b: hsl(244 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 20px;\n  border-radius: 18px;\n  background: linear-gradient(135deg, var(--mp-a) 0 76%, color-mix(in srgb, var(--mp-a) 58%, black) 76%);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 27px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-050::before {\n  content: \"\";\n  position: absolute;\n  right: 0;\n  top: 0;\n  border-top: 18px solid rgba(255,255,255,.42);\n  border-left: 18px solid transparent;\n  opacity: .75;\n}\n.mpb-050:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 10px 27px color-mix(in srgb, var(--mp-a) 18%, transparent); }\n"
  },
  {
    "id": "mp-051",
    "className": "mpb-051",
    "number": 51,
    "collection": "ai",
    "collectionTitle": "AI Workflow",
    "label": "Generate Answer",
    "desc": "Prompt action",
    "style": "terminal-pill",
    "motion": "fold",
    "icon": "AI",
    "css": ".mpb-051 {\n  --mp-a: hsl(206 88% 60%);\n  --mp-b: hsl(302 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 22px;\n  border-radius: 999px 20px 999px 20px;\n  background: #060b08;\n  color: #b9ff57;\n  border: 1px solid #b9ff57;\n  box-shadow: none;\n  \n}\n.mpb-051::after {\n  content: \"_\";\n  margin-left: .08em;\n  color: currentColor;\n  animation: mpBlink 900ms steps(1) infinite;\n}\n.mpb-051:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }\n"
  },
  {
    "id": "mp-052",
    "className": "mpb-052",
    "number": 52,
    "collection": "ai",
    "collectionTitle": "AI Workflow",
    "label": "Refine Prompt",
    "desc": "AI editing CTA",
    "style": "soft-depth",
    "motion": "shimmer",
    "icon": "\u2316",
    "css": ".mpb-052 {\n  --mp-a: hsl(229 88% 60%);\n  --mp-b: hsl(343 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 24px;\n  border-radius: 34px 18px 28px 16px;\n  background: linear-gradient(180deg, color-mix(in srgb, var(--mp-a) 90%, white 10%), color-mix(in srgb, var(--mp-a) 62%, black 20%));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 33px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-052::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 10px 12px;\n  opacity: .18;\n}\n.mpb-052:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }\n"
  },
  {
    "id": "mp-053",
    "className": "mpb-053",
    "number": 53,
    "collection": "ai",
    "collectionTitle": "AI Workflow",
    "label": "Summarize Notes",
    "desc": "AI summary action",
    "style": "orbital-chip",
    "motion": "breath",
    "icon": "\u2661",
    "css": ".mpb-053 {\n  --mp-a: hsl(252 88% 60%);\n  --mp-b: hsl(24 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 26px;\n  border-radius: 14px;\n  background: linear-gradient(135deg, var(--mp-a), var(--mp-b));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 36px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-053::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-053:hover { animation: mpBreath 1.1s ease-in-out infinite; }\n"
  },
  {
    "id": "mp-054",
    "className": "mpb-054",
    "number": 54,
    "collection": "ai",
    "collectionTitle": "AI Workflow",
    "label": "Train Agent",
    "desc": "Agent workflow CTA",
    "style": "monochrome-badge",
    "motion": "launch",
    "icon": "\u266b",
    "css": ".mpb-054 {\n  --mp-a: hsl(275 88% 60%);\n  --mp-b: hsl(317 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 28px;\n  border-radius: 18px;\n  background: linear-gradient(135deg, #111, #2b2b2b);\n  color: #fff8ed;\n  border: 2px solid #000;\n  box-shadow: 4px 4px 0 #000;\n  \n}\n.mpb-054::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 12px 9px;\n  opacity: .18;\n}\n.mpb-054:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }\n"
  },
  {
    "id": "mp-055",
    "className": "mpb-055",
    "number": 55,
    "collection": "ai",
    "collectionTitle": "AI Workflow",
    "label": "Analyze Data",
    "desc": "Insight button",
    "style": "aurora-glass",
    "motion": "snap",
    "icon": "\u2197",
    "css": ".mpb-055 {\n  --mp-a: hsl(298 88% 60%);\n  --mp-b: hsl(358 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 20px;\n  border-radius: 26px;\n  background: linear-gradient(135deg, color-mix(in srgb, var(--mp-a) 28%, transparent), color-mix(in srgb, var(--mp-b) 18%, transparent));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 42px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-055::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);\n  transform: translateX(-130%);\n  transition: transform .62s cubic-bezier(.2,.8,.2,1);\n}\n.mpb-055:hover::before { transform: translateX(130%); }\n.mpb-055:hover { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-056",
    "className": "mpb-056",
    "number": 56,
    "collection": "ai",
    "collectionTitle": "AI Workflow",
    "label": "Compose Reply",
    "desc": "Email/chat AI action",
    "style": "paper-press",
    "motion": "lift",
    "icon": "\u2713",
    "css": ".mpb-056 {\n  --mp-a: hsl(321 88% 60%);\n  --mp-b: hsl(39 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 22px;\n  border-radius: 999px 20px 999px 20px;\n  background: #f5dfbf;\n  color: #17100b;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 8px 0 rgba(89, 66, 36, .38), 0 22px 34px rgba(0,0,0,.14);\n  \n}\n.mpb-056::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 9px 11px;\n  opacity: .18;\n}\n.mpb-056:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }\n"
  },
  {
    "id": "mp-057",
    "className": "mpb-057",
    "number": 57,
    "collection": "ai",
    "collectionTitle": "AI Workflow",
    "label": "Auto Tag",
    "desc": "Automation action",
    "style": "secure-lock",
    "motion": "unlock",
    "icon": "\u25c6",
    "css": ".mpb-057 {\n  --mp-a: hsl(344 88% 60%);\n  --mp-b: hsl(80 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 24px;\n  border-radius: 22px 12px;\n  background: linear-gradient(135deg, #0b0d12, color-mix(in srgb, var(--mp-a) 20%, #0b0d12));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 27px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-057::before {\n  content: \"\";\n  position: absolute;\n  inset: 50%;\n  border-radius: inherit;\n  background: color-mix(in srgb, var(--mp-a) 22%, transparent);\n  transition: inset .42s ease, opacity .42s ease;\n  opacity: 0;\n}\n.mpb-057:hover::before { inset: -30%; opacity: 1; }\n.mpb-057:hover .mp-icon { transform: translate(4px,-4px); }\n"
  },
  {
    "id": "mp-058",
    "className": "mpb-058",
    "number": 58,
    "collection": "ai",
    "collectionTitle": "AI Workflow",
    "label": "Queue Tasks",
    "desc": "Workflow queue button",
    "style": "halo-soft",
    "motion": "glint",
    "icon": "\u2726",
    "css": ".mpb-058 {\n  --mp-a: hsl(7 88% 60%);\n  --mp-b: hsl(121 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 26px;\n  border-radius: 0;\n  background: color-mix(in srgb, var(--mp-a) 14%, transparent);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-058:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }\n.mpb-058:hover .mp-icon { transform: rotate(18deg) scale(1.12); }\n"
  },
  {
    "id": "mp-059",
    "className": "mpb-059",
    "number": 59,
    "collection": "ai",
    "collectionTitle": "AI Workflow",
    "label": "Improve Copy",
    "desc": "AI writing CTA",
    "style": "command-frame",
    "motion": "focus",
    "icon": "\u2318",
    "css": ".mpb-059 {\n  --mp-a: hsl(30 88% 60%);\n  --mp-b: hsl(162 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 28px;\n  border-radius: 18px;\n  background: #080b0d;\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 33px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  \n}\n.mpb-059::after {\n  content: \"_\";\n  margin-left: .08em;\n  color: currentColor;\n  animation: mpBlink 900ms steps(1) infinite;\n}\n.mpb-059:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 18px 33px color-mix(in srgb, var(--mp-a) 30%, transparent); }\n"
  },
  {
    "id": "mp-060",
    "className": "mpb-060",
    "number": 60,
    "collection": "ai",
    "collectionTitle": "AI Workflow",
    "label": "Build Flow",
    "desc": "AI automation button",
    "style": "status-rail",
    "motion": "orbit",
    "icon": "\u25cc",
    "css": ".mpb-060 {\n  --mp-a: hsl(53 88% 60%);\n  --mp-b: hsl(95 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 20px;\n  border-radius: 999px;\n  background: linear-gradient(90deg, color-mix(in srgb, var(--mp-a) 20%, transparent), transparent);\n  color: #fff8ed;\n  border: 0;\n  box-shadow: 0 10px 36px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-060::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 8px 10px;\n  opacity: .18;\n}\n.mpb-060:hover .mp-icon { animation: mpSpin 700ms ease; }\n"
  },
  {
    "id": "mp-061",
    "className": "mpb-061",
    "number": 61,
    "collection": "mobile",
    "collectionTitle": "Mobile App",
    "label": "Get Started",
    "desc": "Mobile onboarding CTA",
    "style": "ribbon-cut",
    "motion": "shimmer",
    "icon": "\u21bb",
    "css": ".mpb-061 {\n  --mp-a: hsl(93 88% 60%);\n  --mp-b: hsl(153 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 22px;\n  border-radius: 22px 12px;\n  background: linear-gradient(90deg, var(--mp-a), var(--mp-b));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 39px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-061::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);\n  opacity: .55;\n}\n.mpb-061:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }\n"
  },
  {
    "id": "mp-062",
    "className": "mpb-062",
    "number": 62,
    "collection": "mobile",
    "collectionTitle": "Mobile App",
    "label": "Continue",
    "desc": "App flow button",
    "style": "quiet-luxury",
    "motion": "breath",
    "icon": "\u27e1",
    "css": ".mpb-062 {\n  --mp-a: hsl(116 88% 60%);\n  --mp-b: hsl(194 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 24px;\n  border-radius: 14px;\n  background: linear-gradient(135deg, #fff7e9, color-mix(in srgb, var(--mp-a) 16%, #f7e8d1));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 42px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-062::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 10px 12px;\n  opacity: .18;\n}\n.mpb-062:hover { animation: mpBreath 1.1s ease-in-out infinite; }\n"
  },
  {
    "id": "mp-063",
    "className": "mpb-063",
    "number": 63,
    "collection": "mobile",
    "collectionTitle": "Mobile App",
    "label": "Set Reminder",
    "desc": "Reminder action",
    "style": "steel-bevel",
    "motion": "launch",
    "icon": "\u2192",
    "css": ".mpb-063 {\n  --mp-a: hsl(139 88% 60%);\n  --mp-b: hsl(235 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 26px;\n  border-radius: 18px;\n  background: linear-gradient(135deg, #f9f4e8, #6d7480, #fff8ed);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 24px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-063::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);\n  transform: translateX(-130%);\n  transition: transform .62s cubic-bezier(.2,.8,.2,1);\n}\n.mpb-063:hover::before { transform: translateX(130%); }\n.mpb-063:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }\n"
  },
  {
    "id": "mp-064",
    "className": "mpb-064",
    "number": 64,
    "collection": "mobile",
    "collectionTitle": "Mobile App",
    "label": "Track Habit",
    "desc": "Habit app CTA",
    "style": "warm-clay",
    "motion": "snap",
    "icon": "\u25c7",
    "css": ".mpb-064 {\n  --mp-a: hsl(162 88% 60%);\n  --mp-b: hsl(276 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 28px;\n  border-radius: 999px;\n  background: linear-gradient(135deg, #b86b3a, #e7ba78);\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 27px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;\n}\n.mpb-064::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 12px 9px;\n  opacity: .18;\n}\n.mpb-064:hover { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-065",
    "className": "mpb-065",
    "number": 65,
    "collection": "mobile",
    "collectionTitle": "Mobile App",
    "label": "Save Place",
    "desc": "Location/mobile action",
    "style": "vault-door",
    "motion": "lift",
    "icon": "\u2301",
    "css": ".mpb-065 {\n  --mp-a: hsl(185 88% 60%);\n  --mp-b: hsl(317 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 20px;\n  border-radius: 18px 18px 8px 8px;\n  background: linear-gradient(90deg, #101319 0 48%, color-mix(in srgb,var(--mp-a) 18%,#101319) 48%);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-065::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 8px 10px;\n  opacity: .18;\n}\n.mpb-065:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }\n"
  },
  {
    "id": "mp-066",
    "className": "mpb-066",
    "number": 66,
    "collection": "mobile",
    "collectionTitle": "Mobile App",
    "label": "Start Workout",
    "desc": "Fitness CTA",
    "style": "magnetic-outline",
    "motion": "unlock",
    "icon": "\u25cf",
    "css": ".mpb-066 {\n  --mp-a: hsl(208 88% 60%);\n  --mp-b: hsl(250 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 22px;\n  border-radius: 22px 12px;\n  background: transparent;\n  color: var(--mp-a);\n  border: 1.5px solid var(--mp-a);\n  box-shadow: none;\n  \n}\n.mpb-066::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 9px 11px;\n  opacity: .18;\n}\n.mpb-066:hover .mp-icon { transform: translate(4px,-4px); }\n"
  },
  {
    "id": "mp-067",
    "className": "mpb-067",
    "number": 67,
    "collection": "mobile",
    "collectionTitle": "Mobile App",
    "label": "Log Meal",
    "desc": "Health app action",
    "style": "folded-corner",
    "motion": "glint",
    "icon": "\u2727",
    "css": ".mpb-067 {\n  --mp-a: hsl(231 88% 60%);\n  --mp-b: hsl(291 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 24px;\n  border-radius: 0;\n  background: linear-gradient(135deg, var(--mp-a) 0 76%, color-mix(in srgb, var(--mp-a) 58%, black) 76%);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 36px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-067::before {\n  content: \"\";\n  position: absolute;\n  right: 0;\n  top: 0;\n  border-top: 18px solid rgba(255,255,255,.42);\n  border-left: 18px solid transparent;\n  opacity: .75;\n}\n.mpb-067:hover .mp-icon { transform: rotate(18deg) scale(1.12); }\n"
  },
  {
    "id": "mp-068",
    "className": "mpb-068",
    "number": 68,
    "collection": "mobile",
    "collectionTitle": "Mobile App",
    "label": "Book Ride",
    "desc": "Travel button",
    "style": "frost-panel",
    "motion": "focus",
    "icon": "\u25a3",
    "css": ".mpb-068 {\n  --mp-a: hsl(254 88% 60%);\n  --mp-b: hsl(332 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 26px;\n  border-radius: 10px;\n  background: rgba(255,255,255,.08);\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 39px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-068::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);\n  transform: translateX(-130%);\n  transition: transform .62s cubic-bezier(.2,.8,.2,1);\n}\n.mpb-068:hover::before { transform: translateX(130%); }\n.mpb-068:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 16px 39px color-mix(in srgb, var(--mp-a) 27%, transparent); }\n"
  },
  {
    "id": "mp-069",
    "className": "mpb-069",
    "number": 69,
    "collection": "mobile",
    "collectionTitle": "Mobile App",
    "label": "Check In",
    "desc": "Status button",
    "style": "split-ticket",
    "motion": "orbit",
    "icon": "\u21e1",
    "css": ".mpb-069 {\n  --mp-a: hsl(277 88% 60%);\n  --mp-b: hsl(13 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 28px;\n  border-radius: 999px;\n  background: linear-gradient(90deg, var(--mp-a) 0 52%, var(--mp-b) 52%);\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 42px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-069::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);\n  opacity: .55;\n}\n.mpb-069:hover .mp-icon { animation: mpSpin 700ms ease; }\n"
  },
  {
    "id": "mp-070",
    "className": "mpb-070",
    "number": 70,
    "collection": "mobile",
    "collectionTitle": "Mobile App",
    "label": "Open Wallet",
    "desc": "Finance/mobile action",
    "style": "neon-minimal",
    "motion": "slide",
    "icon": "AI",
    "css": ".mpb-070 {\n  --mp-a: hsl(300 88% 60%);\n  --mp-b: hsl(54 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 20px;\n  border-radius: 18px 18px 8px 8px;\n  background: #070810;\n  color: var(--mp-a);\n  border: 1px solid var(--mp-a);\n  box-shadow: 0 10px 24px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-070::before {\n  content: \"\";\n  position: absolute;\n  inset: 50%;\n  border-radius: inherit;\n  background: color-mix(in srgb, var(--mp-a) 22%, transparent);\n  transition: inset .42s ease, opacity .42s ease;\n  opacity: 0;\n}\n.mpb-070:hover::before { inset: -30%; opacity: 1; }\n.mpb-070:hover b { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-071",
    "className": "mpb-071",
    "number": 71,
    "collection": "social",
    "collectionTitle": "Social & Community",
    "label": "Follow Creator",
    "desc": "Social follow CTA",
    "style": "monochrome-badge",
    "motion": "breath",
    "icon": "\u2661",
    "css": ".mpb-071 {\n  --mp-a: hsl(340 88% 60%);\n  --mp-b: hsl(112 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 22px;\n  border-radius: 0;\n  background: linear-gradient(135deg, #111, #2b2b2b);\n  color: #fff8ed;\n  border: 2px solid #000;\n  box-shadow: 4px 4px 0 #000;\n  \n}\n.mpb-071::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 9px 11px;\n  opacity: .18;\n}\n.mpb-071:hover { animation: mpBreath 1.1s ease-in-out infinite; }\n"
  },
  {
    "id": "mp-072",
    "className": "mpb-072",
    "number": 72,
    "collection": "social",
    "collectionTitle": "Social & Community",
    "label": "Join Circle",
    "desc": "Community button",
    "style": "aurora-glass",
    "motion": "launch",
    "icon": "\u266b",
    "css": ".mpb-072 {\n  --mp-a: hsl(3 88% 60%);\n  --mp-b: hsl(45 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 24px;\n  border-radius: 18px;\n  background: linear-gradient(135deg, color-mix(in srgb, var(--mp-a) 28%, transparent), color-mix(in srgb, var(--mp-b) 18%, transparent));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 30px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-072::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);\n  transform: translateX(-130%);\n  transition: transform .62s cubic-bezier(.2,.8,.2,1);\n}\n.mpb-072:hover::before { transform: translateX(130%); }\n.mpb-072:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }\n"
  },
  {
    "id": "mp-073",
    "className": "mpb-073",
    "number": 73,
    "collection": "social",
    "collectionTitle": "Social & Community",
    "label": "Share Story",
    "desc": "Content sharing action",
    "style": "paper-press",
    "motion": "snap",
    "icon": "\u2197",
    "css": ".mpb-073 {\n  --mp-a: hsl(26 88% 60%);\n  --mp-b: hsl(86 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 26px;\n  border-radius: 999px;\n  background: #f5dfbf;\n  color: #17100b;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 8px 0 rgba(89, 66, 36, .38), 0 22px 34px rgba(0,0,0,.14);\n  \n}\n.mpb-073::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-073:hover { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-074",
    "className": "mpb-074",
    "number": 74,
    "collection": "social",
    "collectionTitle": "Social & Community",
    "label": "React Now",
    "desc": "Reaction button",
    "style": "secure-lock",
    "motion": "lift",
    "icon": "\u2713",
    "css": ".mpb-074 {\n  --mp-a: hsl(49 88% 60%);\n  --mp-b: hsl(127 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 28px;\n  border-radius: 18px 18px 8px 8px;\n  background: linear-gradient(135deg, #0b0d12, color-mix(in srgb, var(--mp-a) 20%, #0b0d12));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 36px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  \n}\n.mpb-074::before {\n  content: \"\";\n  position: absolute;\n  inset: 50%;\n  border-radius: inherit;\n  background: color-mix(in srgb, var(--mp-a) 22%, transparent);\n  transition: inset .42s ease, opacity .42s ease;\n  opacity: 0;\n}\n.mpb-074:hover::before { inset: -30%; opacity: 1; }\n.mpb-074:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }\n"
  },
  {
    "id": "mp-075",
    "className": "mpb-075",
    "number": 75,
    "collection": "social",
    "collectionTitle": "Social & Community",
    "label": "Send Invite",
    "desc": "Invitation CTA",
    "style": "halo-soft",
    "motion": "unlock",
    "icon": "\u25c6",
    "css": ".mpb-075 {\n  --mp-a: hsl(72 88% 60%);\n  --mp-b: hsl(168 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 20px;\n  border-radius: 34px 18px 28px 16px;\n  background: color-mix(in srgb, var(--mp-a) 14%, transparent);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 39px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-075:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }\n.mpb-075:hover .mp-icon { transform: translate(4px,-4px); }\n"
  },
  {
    "id": "mp-076",
    "className": "mpb-076",
    "number": 76,
    "collection": "social",
    "collectionTitle": "Social & Community",
    "label": "Open Chat",
    "desc": "Messaging action",
    "style": "command-frame",
    "motion": "glint",
    "icon": "\u2726",
    "css": ".mpb-076 {\n  --mp-a: hsl(95 88% 60%);\n  --mp-b: hsl(209 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 22px;\n  border-radius: 0;\n  background: #080b0d;\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 42px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  \n}\n.mpb-076::after {\n  content: \"_\";\n  margin-left: .08em;\n  color: currentColor;\n  animation: mpBlink 900ms steps(1) infinite;\n}\n.mpb-076:hover .mp-icon { transform: rotate(18deg) scale(1.12); }\n"
  },
  {
    "id": "mp-077",
    "className": "mpb-077",
    "number": 77,
    "collection": "social",
    "collectionTitle": "Social & Community",
    "label": "Boost Post",
    "desc": "Social boost action",
    "style": "status-rail",
    "motion": "focus",
    "icon": "\u2318",
    "css": ".mpb-077 {\n  --mp-a: hsl(118 88% 60%);\n  --mp-b: hsl(250 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 24px;\n  border-radius: 10px;\n  background: linear-gradient(90deg, color-mix(in srgb, var(--mp-a) 20%, transparent), transparent);\n  color: #fff8ed;\n  border: 0;\n  box-shadow: 0 14px 24px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-077::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 10px 12px;\n  opacity: .18;\n}\n.mpb-077:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 14px 24px color-mix(in srgb, var(--mp-a) 24%, transparent); }\n"
  },
  {
    "id": "mp-078",
    "className": "mpb-078",
    "number": 78,
    "collection": "social",
    "collectionTitle": "Social & Community",
    "label": "Mention Team",
    "desc": "Collaboration mention",
    "style": "mesh-pulse",
    "motion": "orbit",
    "icon": "\u25cc",
    "css": ".mpb-078 {\n  --mp-a: hsl(141 88% 60%);\n  --mp-b: hsl(183 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 26px;\n  border-radius: 26px;\n  background: linear-gradient(135deg, color-mix(in srgb,var(--mp-a) 18%, transparent), color-mix(in srgb,var(--mp-b) 16%, transparent));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 27px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-078::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-078:hover .mp-icon { animation: mpSpin 700ms ease; }\n"
  },
  {
    "id": "mp-079",
    "className": "mpb-079",
    "number": 79,
    "collection": "social",
    "collectionTitle": "Social & Community",
    "label": "Join Event",
    "desc": "Event/community button",
    "style": "floating-tab",
    "motion": "slide",
    "icon": "\u21e3",
    "css": ".mpb-079 {\n  --mp-a: hsl(164 88% 60%);\n  --mp-b: hsl(224 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 28px;\n  border-radius: 999px 20px 999px 20px;\n  background: color-mix(in srgb, var(--mp-a) 20%, var(--mp-panel));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 30px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;\n}\n.mpb-079::before {\n  content: \"\";\n  position: absolute;\n  right: 0;\n  top: 0;\n  border-top: 18px solid rgba(255,255,255,.42);\n  border-left: 18px solid transparent;\n  opacity: .75;\n}\n.mpb-079:hover b { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-080",
    "className": "mpb-080",
    "number": 80,
    "collection": "social",
    "collectionTitle": "Social & Community",
    "label": "Start Thread",
    "desc": "Forum/social action",
    "style": "liquid-core",
    "motion": "magnet",
    "icon": "\u21bb",
    "css": ".mpb-080 {\n  --mp-a: hsl(187 88% 60%);\n  --mp-b: hsl(265 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 20px;\n  border-radius: 34px 18px 28px 16px;\n  background: radial-gradient(circle at 30% 20%, white, var(--mp-a) 24%, var(--mp-b));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 33px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-080:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }\n.mpb-080:hover { filter: saturate(1.08) brightness(1.04); }\n"
  },
  {
    "id": "mp-081",
    "className": "mpb-081",
    "number": 81,
    "collection": "learning",
    "collectionTitle": "Learning & Wellness",
    "label": "Start Lesson",
    "desc": "Education CTA",
    "style": "warm-clay",
    "motion": "launch",
    "icon": "\u2192",
    "css": ".mpb-081 {\n  --mp-a: hsl(227 88% 60%);\n  --mp-b: hsl(323 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 22px;\n  border-radius: 10px;\n  background: linear-gradient(135deg, #b86b3a, #e7ba78);\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 36px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;\n}\n.mpb-081::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 9px 11px;\n  opacity: .18;\n}\n.mpb-081:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }\n"
  },
  {
    "id": "mp-082",
    "className": "mpb-082",
    "number": 82,
    "collection": "learning",
    "collectionTitle": "Learning & Wellness",
    "label": "Submit Work",
    "desc": "Assignment action",
    "style": "vault-door",
    "motion": "snap",
    "icon": "\u25c7",
    "css": ".mpb-082 {\n  --mp-a: hsl(250 88% 60%);\n  --mp-b: hsl(4 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 24px;\n  border-radius: 26px;\n  background: linear-gradient(90deg, #101319 0 48%, color-mix(in srgb,var(--mp-a) 18%,#101319) 48%);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 39px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-082::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 10px 12px;\n  opacity: .18;\n}\n.mpb-082:hover { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-083",
    "className": "mpb-083",
    "number": 83,
    "collection": "learning",
    "collectionTitle": "Learning & Wellness",
    "label": "Take Quiz",
    "desc": "Quiz start button",
    "style": "magnetic-outline",
    "motion": "lift",
    "icon": "\u2301",
    "css": ".mpb-083 {\n  --mp-a: hsl(273 88% 60%);\n  --mp-b: hsl(45 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 26px;\n  border-radius: 18px 18px 8px 8px;\n  background: transparent;\n  color: var(--mp-a);\n  border: 1.5px solid var(--mp-a);\n  box-shadow: none;\n  \n}\n.mpb-083::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-083:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }\n"
  },
  {
    "id": "mp-084",
    "className": "mpb-084",
    "number": 84,
    "collection": "learning",
    "collectionTitle": "Learning & Wellness",
    "label": "Review Cards",
    "desc": "Flashcard action",
    "style": "folded-corner",
    "motion": "unlock",
    "icon": "\u25cf",
    "css": ".mpb-084 {\n  --mp-a: hsl(296 88% 60%);\n  --mp-b: hsl(338 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 28px;\n  border-radius: 34px 18px 28px 16px;\n  background: linear-gradient(135deg, var(--mp-a) 0 76%, color-mix(in srgb, var(--mp-a) 58%, black) 76%);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 24px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  \n}\n.mpb-084::before {\n  content: \"\";\n  position: absolute;\n  right: 0;\n  top: 0;\n  border-top: 18px solid rgba(255,255,255,.42);\n  border-left: 18px solid transparent;\n  opacity: .75;\n}\n.mpb-084:hover .mp-icon { transform: translate(4px,-4px); }\n"
  },
  {
    "id": "mp-085",
    "className": "mpb-085",
    "number": 85,
    "collection": "learning",
    "collectionTitle": "Learning & Wellness",
    "label": "Practice Mode",
    "desc": "Learning action",
    "style": "frost-panel",
    "motion": "glint",
    "icon": "\u2727",
    "css": ".mpb-085 {\n  --mp-a: hsl(319 88% 60%);\n  --mp-b: hsl(19 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 20px;\n  border-radius: 14px;\n  background: rgba(255,255,255,.08);\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 27px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-085::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);\n  transform: translateX(-130%);\n  transition: transform .62s cubic-bezier(.2,.8,.2,1);\n}\n.mpb-085:hover::before { transform: translateX(130%); }\n.mpb-085:hover .mp-icon { transform: rotate(18deg) scale(1.12); }\n"
  },
  {
    "id": "mp-086",
    "className": "mpb-086",
    "number": 86,
    "collection": "learning",
    "collectionTitle": "Learning & Wellness",
    "label": "Breathe Now",
    "desc": "Wellness action",
    "style": "split-ticket",
    "motion": "focus",
    "icon": "\u25a3",
    "css": ".mpb-086 {\n  --mp-a: hsl(342 88% 60%);\n  --mp-b: hsl(60 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 22px;\n  border-radius: 10px;\n  background: linear-gradient(90deg, var(--mp-a) 0 52%, var(--mp-b) 52%);\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 30px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-086::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);\n  opacity: .55;\n}\n.mpb-086:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 12px 30px color-mix(in srgb, var(--mp-a) 21%, transparent); }\n"
  },
  {
    "id": "mp-087",
    "className": "mpb-087",
    "number": 87,
    "collection": "learning",
    "collectionTitle": "Learning & Wellness",
    "label": "Log Sleep",
    "desc": "Health tracker button",
    "style": "neon-minimal",
    "motion": "orbit",
    "icon": "\u21e1",
    "css": ".mpb-087 {\n  --mp-a: hsl(5 88% 60%);\n  --mp-b: hsl(101 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 24px;\n  border-radius: 26px;\n  background: #070810;\n  color: var(--mp-a);\n  border: 1px solid var(--mp-a);\n  box-shadow: 0 14px 33px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-087::before {\n  content: \"\";\n  position: absolute;\n  inset: 50%;\n  border-radius: inherit;\n  background: color-mix(in srgb, var(--mp-a) 22%, transparent);\n  transition: inset .42s ease, opacity .42s ease;\n  opacity: 0;\n}\n.mpb-087:hover::before { inset: -30%; opacity: 1; }\n.mpb-087:hover .mp-icon { animation: mpSpin 700ms ease; }\n"
  },
  {
    "id": "mp-088",
    "className": "mpb-088",
    "number": 88,
    "collection": "learning",
    "collectionTitle": "Learning & Wellness",
    "label": "Hydrate",
    "desc": "Habit button",
    "style": "gradient-frame",
    "motion": "slide",
    "icon": "AI",
    "css": ".mpb-088 {\n  --mp-a: hsl(28 88% 60%);\n  --mp-b: hsl(142 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 26px;\n  border-radius: 999px 20px 999px 20px;\n  background: linear-gradient(var(--mp-bg), var(--mp-bg)) padding-box, linear-gradient(135deg,var(--mp-a),var(--mp-b)) border-box;\n  color: #fff8ed;\n  border: 1px solid transparent;\n  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-088::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-088:hover b { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-089",
    "className": "mpb-089",
    "number": 89,
    "collection": "learning",
    "collectionTitle": "Learning & Wellness",
    "label": "Book Care",
    "desc": "Care appointment CTA",
    "style": "terminal-pill",
    "motion": "magnet",
    "icon": "\u2316",
    "css": ".mpb-089 {\n  --mp-a: hsl(51 88% 60%);\n  --mp-b: hsl(183 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 28px;\n  border-radius: 22px 12px;\n  background: #060b08;\n  color: #b9ff57;\n  border: 1px solid #b9ff57;\n  box-shadow: none;\n  \n}\n.mpb-089::after {\n  content: \"_\";\n  margin-left: .08em;\n  color: currentColor;\n  animation: mpBlink 900ms steps(1) infinite;\n}\n.mpb-089:hover { filter: saturate(1.08) brightness(1.04); }\n"
  },
  {
    "id": "mp-090",
    "className": "mpb-090",
    "number": 90,
    "collection": "learning",
    "collectionTitle": "Learning & Wellness",
    "label": "Set Goal",
    "desc": "Goal setting action",
    "style": "soft-depth",
    "motion": "quiet",
    "icon": "\u2661",
    "css": ".mpb-090 {\n  --mp-a: hsl(74 88% 60%);\n  --mp-b: hsl(116 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 20px;\n  border-radius: 14px;\n  background: linear-gradient(180deg, color-mix(in srgb, var(--mp-a) 90%, white 10%), color-mix(in srgb, var(--mp-a) 62%, black 20%));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 42px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-090::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 8px 10px;\n  opacity: .18;\n}\n.mpb-090:hover { opacity: .9; }\n"
  },
  {
    "id": "mp-091",
    "className": "mpb-091",
    "number": 91,
    "collection": "editorial",
    "collectionTitle": "Luxury Editorial",
    "label": "Read Feature",
    "desc": "Magazine style button",
    "style": "secure-lock",
    "motion": "snap",
    "icon": "\u2197",
    "css": ".mpb-091 {\n  --mp-a: hsl(114 88% 60%);\n  --mp-b: hsl(174 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 22px;\n  border-radius: 26px;\n  background: linear-gradient(135deg, #0b0d12, color-mix(in srgb, var(--mp-a) 20%, #0b0d12));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 24px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  \n}\n.mpb-091::before {\n  content: \"\";\n  position: absolute;\n  inset: 50%;\n  border-radius: inherit;\n  background: color-mix(in srgb, var(--mp-a) 22%, transparent);\n  transition: inset .42s ease, opacity .42s ease;\n  opacity: 0;\n}\n.mpb-091:hover::before { inset: -30%; opacity: 1; }\n.mpb-091:hover { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-092",
    "className": "mpb-092",
    "number": 92,
    "collection": "editorial",
    "collectionTitle": "Luxury Editorial",
    "label": "View Case",
    "desc": "Portfolio case CTA",
    "style": "halo-soft",
    "motion": "lift",
    "icon": "\u2713",
    "css": ".mpb-092 {\n  --mp-a: hsl(137 88% 60%);\n  --mp-b: hsl(215 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 24px;\n  border-radius: 999px 20px 999px 20px;\n  background: color-mix(in srgb, var(--mp-a) 14%, transparent);\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 27px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-092:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }\n.mpb-092:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }\n"
  },
  {
    "id": "mp-093",
    "className": "mpb-093",
    "number": 93,
    "collection": "editorial",
    "collectionTitle": "Luxury Editorial",
    "label": "Explore Archive",
    "desc": "Archive navigation",
    "style": "command-frame",
    "motion": "unlock",
    "icon": "\u25c6",
    "css": ".mpb-093 {\n  --mp-a: hsl(160 88% 60%);\n  --mp-b: hsl(256 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 26px;\n  border-radius: 34px 18px 28px 16px;\n  background: #080b0d;\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 27%, transparent);\n  \n}\n.mpb-093::after {\n  content: \"_\";\n  margin-left: .08em;\n  color: currentColor;\n  animation: mpBlink 900ms steps(1) infinite;\n}\n.mpb-093:hover .mp-icon { transform: translate(4px,-4px); }\n"
  },
  {
    "id": "mp-094",
    "className": "mpb-094",
    "number": 94,
    "collection": "editorial",
    "collectionTitle": "Luxury Editorial",
    "label": "Open Gallery",
    "desc": "Gallery action",
    "style": "status-rail",
    "motion": "glint",
    "icon": "\u2726",
    "css": ".mpb-094 {\n  --mp-a: hsl(183 88% 60%);\n  --mp-b: hsl(297 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 28px;\n  border-radius: 14px;\n  background: linear-gradient(90deg, color-mix(in srgb, var(--mp-a) 20%, transparent), transparent);\n  color: #fff8ed;\n  border: 0;\n  box-shadow: 0 18px 33px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  \n}\n.mpb-094::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 12px 9px;\n  opacity: .18;\n}\n.mpb-094:hover .mp-icon { transform: rotate(18deg) scale(1.12); }\n"
  },
  {
    "id": "mp-095",
    "className": "mpb-095",
    "number": 95,
    "collection": "editorial",
    "collectionTitle": "Luxury Editorial",
    "label": "Reserve Seat",
    "desc": "Event/luxury CTA",
    "style": "mesh-pulse",
    "motion": "focus",
    "icon": "\u2318",
    "css": ".mpb-095 {\n  --mp-a: hsl(206 88% 60%);\n  --mp-b: hsl(338 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 20px;\n  border-radius: 18px;\n  background: linear-gradient(135deg, color-mix(in srgb,var(--mp-a) 18%, transparent), color-mix(in srgb,var(--mp-b) 16%, transparent));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 36px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-095::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 8px 10px;\n  opacity: .18;\n}\n.mpb-095:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 10px 36px color-mix(in srgb, var(--mp-a) 18%, transparent); }\n"
  },
  {
    "id": "mp-096",
    "className": "mpb-096",
    "number": 96,
    "collection": "editorial",
    "collectionTitle": "Luxury Editorial",
    "label": "See Collection",
    "desc": "Fashion/product button",
    "style": "floating-tab",
    "motion": "orbit",
    "icon": "\u25cc",
    "css": ".mpb-096 {\n  --mp-a: hsl(229 88% 60%);\n  --mp-b: hsl(271 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 22px;\n  border-radius: 999px;\n  background: color-mix(in srgb, var(--mp-a) 20%, var(--mp-panel));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 12px 39px color-mix(in srgb, var(--mp-a) 21%, transparent);\n  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;\n}\n.mpb-096::before {\n  content: \"\";\n  position: absolute;\n  right: 0;\n  top: 0;\n  border-top: 18px solid rgba(255,255,255,.42);\n  border-left: 18px solid transparent;\n  opacity: .75;\n}\n.mpb-096:hover .mp-icon { animation: mpSpin 700ms ease; }\n"
  },
  {
    "id": "mp-097",
    "className": "mpb-097",
    "number": 97,
    "collection": "editorial",
    "collectionTitle": "Luxury Editorial",
    "label": "Enter Lounge",
    "desc": "Premium access button",
    "style": "liquid-core",
    "motion": "slide",
    "icon": "\u21e3",
    "css": ".mpb-097 {\n  --mp-a: hsl(252 88% 60%);\n  --mp-b: hsl(312 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 48px;\n  padding: 0 24px;\n  border-radius: 999px 20px 999px 20px;\n  background: radial-gradient(circle at 30% 20%, white, var(--mp-a) 24%, var(--mp-b));\n  color: #fff8ed;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 14px 42px color-mix(in srgb, var(--mp-a) 24%, transparent);\n  \n}\n.mpb-097:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }\n.mpb-097:hover b { transform: translateX(3px); }\n"
  },
  {
    "id": "mp-098",
    "className": "mpb-098",
    "number": 98,
    "collection": "editorial",
    "collectionTitle": "Luxury Editorial",
    "label": "Request Access",
    "desc": "Exclusive CTA",
    "style": "editorial-line",
    "motion": "magnet",
    "icon": "\u21bb",
    "css": ".mpb-098 {\n  --mp-a: hsl(275 88% 60%);\n  --mp-b: hsl(353 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 50px;\n  padding: 0 26px;\n  border-radius: 22px 12px;\n  background: transparent;\n  color: var(--mp-a);\n  border: 1.5px solid var(--mp-a);\n  box-shadow: none;\n  \n}\n.mpb-098::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 11px 8px;\n  opacity: .18;\n}\n.mpb-098:hover { filter: saturate(1.08) brightness(1.04); }\n"
  },
  {
    "id": "mp-099",
    "className": "mpb-099",
    "number": 99,
    "collection": "editorial",
    "collectionTitle": "Luxury Editorial",
    "label": "Download Kit",
    "desc": "Brand kit action",
    "style": "ribbon-cut",
    "motion": "quiet",
    "icon": "\u27e1",
    "css": ".mpb-099 {\n  --mp-a: hsl(298 88% 60%);\n  --mp-b: hsl(34 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 52px;\n  padding: 0 28px;\n  border-radius: 0;\n  background: linear-gradient(90deg, var(--mp-a), var(--mp-b));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 18px 27px color-mix(in srgb, var(--mp-a) 30%, transparent);\n  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;\n}\n.mpb-099::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);\n  opacity: .55;\n}\n.mpb-099:hover { opacity: .9; }\n"
  },
  {
    "id": "mp-100",
    "className": "mpb-100",
    "number": 100,
    "collection": "editorial",
    "collectionTitle": "Luxury Editorial",
    "label": "Begin Tour",
    "desc": "Editorial tour CTA",
    "style": "quiet-luxury",
    "motion": "trace",
    "icon": "\u2192",
    "css": ".mpb-100 {\n  --mp-a: hsl(321 88% 60%);\n  --mp-b: hsl(75 88% 62%);\n  --mp-bg: #10131b;\n  min-height: 46px;\n  padding: 0 20px;\n  border-radius: 18px;\n  background: linear-gradient(135deg, #fff7e9, color-mix(in srgb, var(--mp-a) 16%, #f7e8d1));\n  color: #13100c;\n  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);\n  box-shadow: 0 10px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);\n  \n}\n.mpb-100::before {\n  content: \"\";\n  position: absolute;\n  inset: 0;\n  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);\n  background-size: 8px 10px;\n  opacity: .18;\n}\n.mpb-100:hover { outline: 1px solid var(--mp-b); outline-offset: 7px; }\n"
  }
];
window.MASTERPIECE_COLLECTIONS = [
  {
    "id": "commerce",
    "title": "Premium Commerce",
    "count": 10
  },
  {
    "id": "saas",
    "title": "SaaS Dashboard",
    "count": 10
  },
  {
    "id": "security",
    "title": "Auth & Security",
    "count": 10
  },
  {
    "id": "creative",
    "title": "Creative Studio",
    "count": 10
  },
  {
    "id": "developer",
    "title": "Developer Console",
    "count": 10
  },
  {
    "id": "ai",
    "title": "AI Workflow",
    "count": 10
  },
  {
    "id": "mobile",
    "title": "Mobile App",
    "count": 10
  },
  {
    "id": "social",
    "title": "Social & Community",
    "count": 10
  },
  {
    "id": "learning",
    "title": "Learning & Wellness",
    "count": 10
  },
  {
    "id": "editorial",
    "title": "Luxury Editorial",
    "count": 10
  }
];

'@
$masterpieceCss = @'

/* ===== MASTERPIECE BUTTONS PAGE START ===== */
.masterpiece-body {
  background:
    radial-gradient(circle at 16% 0%, color-mix(in srgb, var(--accent-3) 18%, transparent), transparent 24rem),
    radial-gradient(circle at 92% 8%, color-mix(in srgb, var(--accent-2) 16%, transparent), transparent 28rem),
    linear-gradient(180deg, var(--bg), color-mix(in srgb, var(--bg) 88%, #000)) !important;
}

.master-shell {
  width: min(1240px, calc(100% - 28px));
  margin: 22px auto 90px;
}

.master-hero,
.master-tools,
.master-card,
.master-source {
  border: 1px solid var(--line);
  background: var(--surface);
  backdrop-filter: blur(24px) saturate(140%);
  box-shadow: 0 22px 60px var(--shadow);
}

.master-hero {
  border-radius: 34px;
  padding: clamp(30px, 6vw, 70px);
  display: grid;
  grid-template-columns: 1fr minmax(280px, 390px);
  gap: 22px;
  align-items: center;
}

.master-hero h1 {
  font-size: clamp(2.8rem, 7vw, 6.6rem) !important;
  max-width: 820px;
}

.master-preview-wall {
  min-height: 250px;
  border-radius: 26px;
  border: 1px solid var(--line);
  background:
    linear-gradient(var(--grid) 1px, transparent 1px),
    linear-gradient(90deg, var(--grid) 1px, transparent 1px),
    color-mix(in srgb, var(--surface-2) 88%, transparent);
  background-size: 24px 24px;
  display: grid;
  place-items: center;
  gap: 14px;
  padding: 24px;
  overflow: hidden;
}

.master-tools {
  position: sticky;
  top: 104px;
  z-index: 35;
  margin-top: 16px;
  border-radius: 24px;
  padding: 12px;
  display: grid;
  grid-template-columns: 1fr auto;
  gap: 12px;
  align-items: center;
}

.master-tabs {
  display: flex;
  gap: 8px;
  overflow-x: auto;
  scrollbar-width: none;
}

.master-tabs::-webkit-scrollbar { display: none; }

.master-tab {
  flex: 0 0 auto;
  border: 1px solid var(--line);
  border-radius: 999px;
  background: color-mix(in srgb, var(--surface-2) 72%, transparent);
  color: var(--muted);
  padding: 10px 13px;
  cursor: pointer;
  font-weight: 950;
}

.master-tab.active,
.master-tab:hover {
  color: var(--text);
  border-color: color-mix(in srgb, var(--accent-2) 34%, var(--line));
  background: color-mix(in srgb, var(--accent-2) 11%, transparent);
}

.master-search {
  min-width: 260px;
  border: 1px solid var(--line);
  border-radius: 999px;
  padding: 11px 15px;
  background: color-mix(in srgb, var(--surface-2) 76%, transparent);
  color: var(--text);
  font-weight: 850;
}

.master-grid {
  margin-top: 16px;
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 14px;
}

.master-card {
  content-visibility: auto;
  contain-intrinsic-size: 300px;
  border-radius: 28px;
  padding: 16px;
  display: grid;
  gap: 14px;
}

.master-card-top {
  display: flex;
  justify-content: space-between;
  gap: 12px;
  color: var(--muted);
  font-weight: 950;
  font-size: .78rem;
}

.master-stage {
  min-height: 132px;
  border-radius: 22px;
  border: 1px solid var(--line);
  background:
    radial-gradient(circle at 24% 15%, color-mix(in srgb, var(--accent-2) 8%, transparent), transparent 160px),
    linear-gradient(180deg, rgba(35,36,43,.86), rgba(17,18,24,.92));
  display: grid;
  place-items: center;
  padding: 24px;
  overflow: hidden;
}

:root[data-theme="light"] .master-stage {
  background:
    radial-gradient(circle at 24% 15%, rgba(10,115,131,.08), transparent 160px),
    linear-gradient(180deg, rgba(250,246,238,.96), rgba(226,218,203,.96));
}

.master-info {
  display: grid;
  grid-template-columns: 1fr auto;
  gap: 14px;
  align-items: center;
}

.master-info h3 {
  margin: 0;
  font-size: 1.05rem;
}

.master-info p {
  margin: 4px 0 0;
  color: var(--muted);
  font-weight: 760;
}

.master-source-btn {
  border: 1px solid var(--line);
  border-radius: 15px;
  background: color-mix(in srgb, var(--accent) 12%, transparent);
  color: var(--text);
  padding: 10px 13px;
  font-weight: 1000;
  cursor: pointer;
}

.master-source-btn:hover {
  border-color: color-mix(in srgb, var(--accent-2) 35%, var(--line));
}

.mp-master-btn {
  position: relative;
  isolation: isolate;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: .64em;
  border: 0;
  outline: 0;
  cursor: pointer;
  overflow: hidden;
  font: 950 .92rem/1 Inter, ui-sans-serif, system-ui, sans-serif;
  letter-spacing: -.01em;
  transition:
    transform .18s ease,
    box-shadow .18s ease,
    border-color .18s ease,
    filter .18s ease,
    letter-spacing .18s ease,
    border-radius .22s ease,
    opacity .18s ease;
  transform: translateZ(0);
  white-space: nowrap;
}

.mp-master-btn b,
.mp-master-btn .mp-icon {
  position: relative;
  z-index: 2;
  transition: transform .2s ease;
}

.mp-master-btn .mp-icon {
  font-weight: 1000;
}

.mp-source-dialog {
  width: min(980px, calc(100% - 24px));
  max-height: 88vh;
  border: 1px solid var(--line);
  border-radius: 28px;
  padding: 0;
  color: var(--text);
  background: var(--surface);
  backdrop-filter: blur(22px);
}

.mp-source-dialog::backdrop {
  background: rgba(0,0,0,.68);
  backdrop-filter: blur(6px);
}

.mp-dialog-head {
  padding: 18px;
  border-bottom: 1px solid var(--line);
  display: flex;
  justify-content: space-between;
  gap: 14px;
}

.mp-dialog-head h2 {
  margin: 0;
}

.mp-dialog-close {
  width: 44px;
  height: 44px;
  border: 1px solid var(--line);
  border-radius: 999px;
  background: transparent;
  color: var(--text);
  cursor: pointer;
  font-size: 1.4rem;
}

.mp-dialog-preview {
  min-height: 128px;
  display: grid;
  place-items: center;
  padding: 28px;
  border-bottom: 1px solid var(--line);
}

.mp-code-tabs {
  display: flex;
  gap: 8px;
  padding: 13px;
  border-bottom: 1px solid var(--line);
  overflow: auto;
}

.mp-code-tab,
.mp-copy-code {
  border: 1px solid var(--line);
  border-radius: 13px;
  background: transparent;
  color: var(--text);
  padding: 9px 13px;
  cursor: pointer;
  font-weight: 900;
}

.mp-code-tab.active,
.mp-copy-code {
  background: linear-gradient(135deg, var(--accent), var(--accent-2));
  color: #11100d;
}

.mp-copy-code {
  margin-left: auto;
}

.mp-code-box {
  margin: 0;
  max-height: 44vh;
  overflow: auto;
  padding: 22px;
  background: #07070c;
  color: #f7e7c4;
  font-size: .84rem;
  line-height: 1.6;
  white-space: pre;
}

/* generated masterpiece buttons */
.mpb-001 {
  --mp-a: hsl(51 88% 60%);
  --mp-b: hsl(111 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 22px;
  border-radius: 18px 18px 8px 8px;
  background: #f5dfbf;
  color: #17100b;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 8px 0 rgba(89, 66, 36, .38), 0 22px 34px rgba(0,0,0,.14);
  
}
.mpb-001::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 9px 11px;
  opacity: .18;
}
.mpb-001:hover { transform: perspective(520px) rotateX(7deg) rotateY(-6deg) translateY(-2px); }


.mpb-002 {
  --mp-a: hsl(74 88% 60%);
  --mp-b: hsl(152 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 24px;
  border-radius: 34px 18px 28px 16px;
  background: linear-gradient(135deg, #0b0d12, color-mix(in srgb, var(--mp-a) 20%, #0b0d12));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 30px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-002::before {
  content: "";
  position: absolute;
  inset: 50%;
  border-radius: inherit;
  background: color-mix(in srgb, var(--mp-a) 22%, transparent);
  transition: inset .42s ease, opacity .42s ease;
  opacity: 0;
}
.mpb-002:hover::before { inset: -30%; opacity: 1; }
.mpb-002:active { transform: translateY(2px) scale(.985); }


.mpb-003 {
  --mp-a: hsl(97 88% 60%);
  --mp-b: hsl(193 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 26px;
  border-radius: 14px;
  background: color-mix(in srgb, var(--mp-a) 14%, transparent);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 33px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-003:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }
.mpb-003:hover { transform: translateY(-6px); }


.mpb-004 {
  --mp-a: hsl(120 88% 60%);
  --mp-b: hsl(234 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 28px;
  border-radius: 10px;
  background: #080b0d;
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 36px color-mix(in srgb, var(--mp-a) 30%, transparent);
  
}
.mpb-004::after {
  content: "_";
  margin-left: .08em;
  color: currentColor;
  animation: mpBlink 900ms steps(1) infinite;
}
.mpb-004:hover { letter-spacing: .025em; }


.mpb-005 {
  --mp-a: hsl(143 88% 60%);
  --mp-b: hsl(275 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 20px;
  border-radius: 26px;
  background: linear-gradient(90deg, color-mix(in srgb, var(--mp-a) 20%, transparent), transparent);
  color: #fff8ed;
  border: 0;
  box-shadow: 0 10px 39px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-005::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 8px 10px;
  opacity: .18;
}
.mpb-005:hover { transform: scale(1.045); }


.mpb-006 {
  --mp-a: hsl(166 88% 60%);
  --mp-b: hsl(208 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 22px;
  border-radius: 999px 20px 999px 20px;
  background: linear-gradient(135deg, color-mix(in srgb,var(--mp-a) 18%, transparent), color-mix(in srgb,var(--mp-b) 16%, transparent));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 42px color-mix(in srgb, var(--mp-a) 21%, transparent);
  
}
.mpb-006::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 9px 11px;
  opacity: .18;
}
.mpb-006:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }


.mpb-007 {
  --mp-a: hsl(189 88% 60%);
  --mp-b: hsl(249 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 24px;
  border-radius: 22px 12px;
  background: color-mix(in srgb, var(--mp-a) 20%, var(--mp-panel));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 24px color-mix(in srgb, var(--mp-a) 24%, transparent);
  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;
}
.mpb-007::before {
  content: "";
  position: absolute;
  right: 0;
  top: 0;
  border-top: 18px solid rgba(255,255,255,.42);
  border-left: 18px solid transparent;
  opacity: .75;
}
.mpb-007:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }


.mpb-008 {
  --mp-a: hsl(212 88% 60%);
  --mp-b: hsl(290 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 26px;
  border-radius: 14px;
  background: radial-gradient(circle at 30% 20%, white, var(--mp-a) 24%, var(--mp-b));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 27px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-008:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }
.mpb-008:hover { animation: mpBreath 1.1s ease-in-out infinite; }


.mpb-009 {
  --mp-a: hsl(235 88% 60%);
  --mp-b: hsl(331 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 28px;
  border-radius: 18px;
  background: transparent;
  color: var(--mp-a);
  border: 1.5px solid var(--mp-a);
  box-shadow: none;
  
}
.mpb-009::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 12px 9px;
  opacity: .18;
}
.mpb-009:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }


.mpb-010 {
  --mp-a: hsl(258 88% 60%);
  --mp-b: hsl(12 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 20px;
  border-radius: 999px;
  background: linear-gradient(90deg, var(--mp-a), var(--mp-b));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 33px color-mix(in srgb, var(--mp-a) 18%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-010::before {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);
  opacity: .55;
}
.mpb-010:hover { transform: translateX(3px); }


.mpb-011 {
  --mp-a: hsl(298 88% 60%);
  --mp-b: hsl(70 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 22px;
  border-radius: 34px 18px 28px 16px;
  background: transparent;
  color: var(--mp-a);
  border: 1.5px solid var(--mp-a);
  box-shadow: none;
  
}
.mpb-011::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 9px 11px;
  opacity: .18;
}
.mpb-011:active { transform: translateY(2px) scale(.985); }


.mpb-012 {
  --mp-a: hsl(321 88% 60%);
  --mp-b: hsl(3 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 24px;
  border-radius: 14px;
  background: linear-gradient(135deg, var(--mp-a) 0 76%, color-mix(in srgb, var(--mp-a) 58%, black) 76%);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 39px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-012::before {
  content: "";
  position: absolute;
  right: 0;
  top: 0;
  border-top: 18px solid rgba(255,255,255,.42);
  border-left: 18px solid transparent;
  opacity: .75;
}
.mpb-012:hover { transform: translateY(-6px); }


.mpb-013 {
  --mp-a: hsl(344 88% 60%);
  --mp-b: hsl(44 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 26px;
  border-radius: 18px;
  background: rgba(255,255,255,.08);
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 42px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-013::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);
  transform: translateX(-130%);
  transition: transform .62s cubic-bezier(.2,.8,.2,1);
}
.mpb-013:hover::before { transform: translateX(130%); }
.mpb-013:hover { letter-spacing: .025em; }


.mpb-014 {
  --mp-a: hsl(7 88% 60%);
  --mp-b: hsl(85 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 28px;
  border-radius: 26px;
  background: linear-gradient(90deg, var(--mp-a) 0 52%, var(--mp-b) 52%);
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 24px color-mix(in srgb, var(--mp-a) 30%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-014::before {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);
  opacity: .55;
}
.mpb-014:hover { transform: scale(1.045); }


.mpb-015 {
  --mp-a: hsl(30 88% 60%);
  --mp-b: hsl(126 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 20px;
  border-radius: 999px 20px 999px 20px;
  background: #070810;
  color: var(--mp-a);
  border: 1px solid var(--mp-a);
  box-shadow: 0 10px 27px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-015::before {
  content: "";
  position: absolute;
  inset: 50%;
  border-radius: inherit;
  background: color-mix(in srgb, var(--mp-a) 22%, transparent);
  transition: inset .42s ease, opacity .42s ease;
  opacity: 0;
}
.mpb-015:hover::before { inset: -30%; opacity: 1; }
.mpb-015:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }


.mpb-016 {
  --mp-a: hsl(53 88% 60%);
  --mp-b: hsl(167 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 22px;
  border-radius: 22px 12px;
  background: linear-gradient(var(--mp-bg), var(--mp-bg)) padding-box, linear-gradient(135deg,var(--mp-a),var(--mp-b)) border-box;
  color: #fff8ed;
  border: 1px solid transparent;
  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-016::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 9px 11px;
  opacity: .18;
}
.mpb-016:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }


.mpb-017 {
  --mp-a: hsl(76 88% 60%);
  --mp-b: hsl(208 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 24px;
  border-radius: 0;
  background: #060b08;
  color: #b9ff57;
  border: 1px solid #b9ff57;
  box-shadow: none;
  
}
.mpb-017::after {
  content: "_";
  margin-left: .08em;
  color: currentColor;
  animation: mpBlink 900ms steps(1) infinite;
}
.mpb-017:hover { animation: mpBreath 1.1s ease-in-out infinite; }


.mpb-018 {
  --mp-a: hsl(99 88% 60%);
  --mp-b: hsl(141 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 26px;
  border-radius: 18px;
  background: linear-gradient(180deg, color-mix(in srgb, var(--mp-a) 90%, white 10%), color-mix(in srgb, var(--mp-a) 62%, black 20%));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 36px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-018::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-018:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }


.mpb-019 {
  --mp-a: hsl(122 88% 60%);
  --mp-b: hsl(182 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 28px;
  border-radius: 999px;
  background: linear-gradient(135deg, var(--mp-a), var(--mp-b));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 39px color-mix(in srgb, var(--mp-a) 30%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-019::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 12px 9px;
  opacity: .18;
}
.mpb-019:hover { transform: translateX(3px); }


.mpb-020 {
  --mp-a: hsl(145 88% 60%);
  --mp-b: hsl(223 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 20px;
  border-radius: 18px 18px 8px 8px;
  background: linear-gradient(135deg, #111, #2b2b2b);
  color: #fff8ed;
  border: 2px solid #000;
  box-shadow: 4px 4px 0 #000;
  
}
.mpb-020::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 8px 10px;
  opacity: .18;
}
.mpb-020:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }


.mpb-021 {
  --mp-a: hsl(185 88% 60%);
  --mp-b: hsl(281 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 22px;
  border-radius: 14px;
  background: #080b0d;
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 24px color-mix(in srgb, var(--mp-a) 21%, transparent);
  
}
.mpb-021::after {
  content: "_";
  margin-left: .08em;
  color: currentColor;
  animation: mpBlink 900ms steps(1) infinite;
}
.mpb-021:hover { transform: translateY(-6px); }


.mpb-022 {
  --mp-a: hsl(208 88% 60%);
  --mp-b: hsl(322 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 24px;
  border-radius: 18px;
  background: linear-gradient(90deg, color-mix(in srgb, var(--mp-a) 20%, transparent), transparent);
  color: #fff8ed;
  border: 0;
  box-shadow: 0 14px 27px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-022::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 10px 12px;
  opacity: .18;
}
.mpb-022:hover { letter-spacing: .025em; }


.mpb-023 {
  --mp-a: hsl(231 88% 60%);
  --mp-b: hsl(3 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 26px;
  border-radius: 999px;
  background: linear-gradient(135deg, color-mix(in srgb,var(--mp-a) 18%, transparent), color-mix(in srgb,var(--mp-b) 16%, transparent));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-023::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-023:hover { transform: scale(1.045); }


.mpb-024 {
  --mp-a: hsl(254 88% 60%);
  --mp-b: hsl(296 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 28px;
  border-radius: 18px 18px 8px 8px;
  background: color-mix(in srgb, var(--mp-a) 20%, var(--mp-panel));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 33px color-mix(in srgb, var(--mp-a) 30%, transparent);
  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;
}
.mpb-024::before {
  content: "";
  position: absolute;
  right: 0;
  top: 0;
  border-top: 18px solid rgba(255,255,255,.42);
  border-left: 18px solid transparent;
  opacity: .75;
}
.mpb-024:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }


.mpb-025 {
  --mp-a: hsl(277 88% 60%);
  --mp-b: hsl(337 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 20px;
  border-radius: 22px 12px;
  background: radial-gradient(circle at 30% 20%, white, var(--mp-a) 24%, var(--mp-b));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 36px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-025:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }
.mpb-025:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }


.mpb-026 {
  --mp-a: hsl(300 88% 60%);
  --mp-b: hsl(18 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 22px;
  border-radius: 0;
  background: transparent;
  color: var(--mp-a);
  border: 1.5px solid var(--mp-a);
  box-shadow: none;
  
}
.mpb-026::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 9px 11px;
  opacity: .18;
}
.mpb-026:hover { animation: mpBreath 1.1s ease-in-out infinite; }


.mpb-027 {
  --mp-a: hsl(323 88% 60%);
  --mp-b: hsl(59 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 24px;
  border-radius: 10px;
  background: linear-gradient(90deg, var(--mp-a), var(--mp-b));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 42px color-mix(in srgb, var(--mp-a) 24%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-027::before {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);
  opacity: .55;
}
.mpb-027:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }


.mpb-028 {
  --mp-a: hsl(346 88% 60%);
  --mp-b: hsl(100 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 26px;
  border-radius: 999px;
  background: linear-gradient(135deg, #fff7e9, color-mix(in srgb, var(--mp-a) 16%, #f7e8d1));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 24px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-028::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-028:hover { transform: translateX(3px); }


.mpb-029 {
  --mp-a: hsl(9 88% 60%);
  --mp-b: hsl(141 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 28px;
  border-radius: 18px 18px 8px 8px;
  background: linear-gradient(135deg, #f9f4e8, #6d7480, #fff8ed);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 27px color-mix(in srgb, var(--mp-a) 30%, transparent);
  
}
.mpb-029::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);
  transform: translateX(-130%);
  transition: transform .62s cubic-bezier(.2,.8,.2,1);
}
.mpb-029:hover::before { transform: translateX(130%); }
.mpb-029:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }


.mpb-030 {
  --mp-a: hsl(32 88% 60%);
  --mp-b: hsl(74 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 20px;
  border-radius: 34px 18px 28px 16px;
  background: linear-gradient(135deg, #b86b3a, #e7ba78);
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);
  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;
}
.mpb-030::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 8px 10px;
  opacity: .18;
}
.mpb-030:hover .mp-icon { transform: translate(4px,-4px); }


.mpb-031 {
  --mp-a: hsl(72 88% 60%);
  --mp-b: hsl(132 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 22px;
  border-radius: 18px;
  background: linear-gradient(90deg, var(--mp-a) 0 52%, var(--mp-b) 52%);
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 33px color-mix(in srgb, var(--mp-a) 21%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-031::before {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);
  opacity: .55;
}
.mpb-031:hover { letter-spacing: .025em; }


.mpb-032 {
  --mp-a: hsl(95 88% 60%);
  --mp-b: hsl(173 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 24px;
  border-radius: 999px;
  background: #070810;
  color: var(--mp-a);
  border: 1px solid var(--mp-a);
  box-shadow: 0 14px 36px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-032::before {
  content: "";
  position: absolute;
  inset: 50%;
  border-radius: inherit;
  background: color-mix(in srgb, var(--mp-a) 22%, transparent);
  transition: inset .42s ease, opacity .42s ease;
  opacity: 0;
}
.mpb-032:hover::before { inset: -30%; opacity: 1; }
.mpb-032:hover { transform: scale(1.045); }


.mpb-033 {
  --mp-a: hsl(118 88% 60%);
  --mp-b: hsl(214 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 26px;
  border-radius: 18px 18px 8px 8px;
  background: linear-gradient(var(--mp-bg), var(--mp-bg)) padding-box, linear-gradient(135deg,var(--mp-a),var(--mp-b)) border-box;
  color: #fff8ed;
  border: 1px solid transparent;
  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-033::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-033:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }


.mpb-034 {
  --mp-a: hsl(141 88% 60%);
  --mp-b: hsl(255 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 28px;
  border-radius: 34px 18px 28px 16px;
  background: #060b08;
  color: #b9ff57;
  border: 1px solid #b9ff57;
  box-shadow: none;
  
}
.mpb-034::after {
  content: "_";
  margin-left: .08em;
  color: currentColor;
  animation: mpBlink 900ms steps(1) infinite;
}
.mpb-034:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }


.mpb-035 {
  --mp-a: hsl(164 88% 60%);
  --mp-b: hsl(296 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 20px;
  border-radius: 0;
  background: linear-gradient(180deg, color-mix(in srgb, var(--mp-a) 90%, white 10%), color-mix(in srgb, var(--mp-a) 62%, black 20%));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 24px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-035::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 8px 10px;
  opacity: .18;
}
.mpb-035:hover { animation: mpBreath 1.1s ease-in-out infinite; }


.mpb-036 {
  --mp-a: hsl(187 88% 60%);
  --mp-b: hsl(229 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 22px;
  border-radius: 10px;
  background: linear-gradient(135deg, var(--mp-a), var(--mp-b));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 27px color-mix(in srgb, var(--mp-a) 21%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-036::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 9px 11px;
  opacity: .18;
}
.mpb-036:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }


.mpb-037 {
  --mp-a: hsl(210 88% 60%);
  --mp-b: hsl(270 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 24px;
  border-radius: 26px;
  background: linear-gradient(135deg, #111, #2b2b2b);
  color: #fff8ed;
  border: 2px solid #000;
  box-shadow: 4px 4px 0 #000;
  
}
.mpb-037::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 10px 12px;
  opacity: .18;
}
.mpb-037:hover { transform: translateX(3px); }


.mpb-038 {
  --mp-a: hsl(233 88% 60%);
  --mp-b: hsl(311 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 26px;
  border-radius: 18px 18px 8px 8px;
  background: linear-gradient(135deg, color-mix(in srgb, var(--mp-a) 28%, transparent), color-mix(in srgb, var(--mp-b) 18%, transparent));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 33px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-038::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);
  transform: translateX(-130%);
  transition: transform .62s cubic-bezier(.2,.8,.2,1);
}
.mpb-038:hover::before { transform: translateX(130%); }
.mpb-038:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }


.mpb-039 {
  --mp-a: hsl(256 88% 60%);
  --mp-b: hsl(352 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 28px;
  border-radius: 34px 18px 28px 16px;
  background: #f5dfbf;
  color: #17100b;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 8px 0 rgba(89, 66, 36, .38), 0 22px 34px rgba(0,0,0,.14);
  
}
.mpb-039::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 12px 9px;
  opacity: .18;
}
.mpb-039:hover .mp-icon { transform: translate(4px,-4px); }


.mpb-040 {
  --mp-a: hsl(279 88% 60%);
  --mp-b: hsl(33 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 20px;
  border-radius: 14px;
  background: linear-gradient(135deg, #0b0d12, color-mix(in srgb, var(--mp-a) 20%, #0b0d12));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 39px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-040::before {
  content: "";
  position: absolute;
  inset: 50%;
  border-radius: inherit;
  background: color-mix(in srgb, var(--mp-a) 22%, transparent);
  transition: inset .42s ease, opacity .42s ease;
  opacity: 0;
}
.mpb-040:hover::before { inset: -30%; opacity: 1; }
.mpb-040:hover .mp-icon { transform: rotate(18deg) scale(1.12); }


.mpb-041 {
  --mp-a: hsl(319 88% 60%);
  --mp-b: hsl(91 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 22px;
  border-radius: 26px;
  background: color-mix(in srgb, var(--mp-a) 20%, var(--mp-panel));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 42px color-mix(in srgb, var(--mp-a) 21%, transparent);
  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;
}
.mpb-041::before {
  content: "";
  position: absolute;
  right: 0;
  top: 0;
  border-top: 18px solid rgba(255,255,255,.42);
  border-left: 18px solid transparent;
  opacity: .75;
}
.mpb-041:hover { transform: scale(1.045); }


.mpb-042 {
  --mp-a: hsl(342 88% 60%);
  --mp-b: hsl(24 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 24px;
  border-radius: 18px 18px 8px 8px;
  background: radial-gradient(circle at 30% 20%, white, var(--mp-a) 24%, var(--mp-b));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 24px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-042:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }
.mpb-042:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }


.mpb-043 {
  --mp-a: hsl(5 88% 60%);
  --mp-b: hsl(65 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 26px;
  border-radius: 34px 18px 28px 16px;
  background: transparent;
  color: var(--mp-a);
  border: 1.5px solid var(--mp-a);
  box-shadow: none;
  
}
.mpb-043::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-043:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }


.mpb-044 {
  --mp-a: hsl(28 88% 60%);
  --mp-b: hsl(106 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 28px;
  border-radius: 14px;
  background: linear-gradient(90deg, var(--mp-a), var(--mp-b));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 30px color-mix(in srgb, var(--mp-a) 30%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-044::before {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);
  opacity: .55;
}
.mpb-044:hover { animation: mpBreath 1.1s ease-in-out infinite; }


.mpb-045 {
  --mp-a: hsl(51 88% 60%);
  --mp-b: hsl(147 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 20px;
  border-radius: 10px;
  background: linear-gradient(135deg, #fff7e9, color-mix(in srgb, var(--mp-a) 16%, #f7e8d1));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 33px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-045::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 8px 10px;
  opacity: .18;
}
.mpb-045:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }


.mpb-046 {
  --mp-a: hsl(74 88% 60%);
  --mp-b: hsl(188 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 22px;
  border-radius: 26px;
  background: linear-gradient(135deg, #f9f4e8, #6d7480, #fff8ed);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 36px color-mix(in srgb, var(--mp-a) 21%, transparent);
  
}
.mpb-046::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);
  transform: translateX(-130%);
  transition: transform .62s cubic-bezier(.2,.8,.2,1);
}
.mpb-046:hover::before { transform: translateX(130%); }
.mpb-046:hover { transform: translateX(3px); }


.mpb-047 {
  --mp-a: hsl(97 88% 60%);
  --mp-b: hsl(229 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 24px;
  border-radius: 999px 20px 999px 20px;
  background: linear-gradient(135deg, #b86b3a, #e7ba78);
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 39px color-mix(in srgb, var(--mp-a) 24%, transparent);
  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;
}
.mpb-047::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 10px 12px;
  opacity: .18;
}
.mpb-047:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }


.mpb-048 {
  --mp-a: hsl(120 88% 60%);
  --mp-b: hsl(162 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 26px;
  border-radius: 22px 12px;
  background: linear-gradient(90deg, #101319 0 48%, color-mix(in srgb,var(--mp-a) 18%,#101319) 48%);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 42px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-048::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-048:hover .mp-icon { transform: translate(4px,-4px); }


.mpb-049 {
  --mp-a: hsl(143 88% 60%);
  --mp-b: hsl(203 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 28px;
  border-radius: 14px;
  background: transparent;
  color: var(--mp-a);
  border: 1.5px solid var(--mp-a);
  box-shadow: none;
  
}
.mpb-049::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 12px 9px;
  opacity: .18;
}
.mpb-049:hover .mp-icon { transform: rotate(18deg) scale(1.12); }


.mpb-050 {
  --mp-a: hsl(166 88% 60%);
  --mp-b: hsl(244 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 20px;
  border-radius: 18px;
  background: linear-gradient(135deg, var(--mp-a) 0 76%, color-mix(in srgb, var(--mp-a) 58%, black) 76%);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 27px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-050::before {
  content: "";
  position: absolute;
  right: 0;
  top: 0;
  border-top: 18px solid rgba(255,255,255,.42);
  border-left: 18px solid transparent;
  opacity: .75;
}
.mpb-050:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 10px 27px color-mix(in srgb, var(--mp-a) 18%, transparent); }


.mpb-051 {
  --mp-a: hsl(206 88% 60%);
  --mp-b: hsl(302 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 22px;
  border-radius: 999px 20px 999px 20px;
  background: #060b08;
  color: #b9ff57;
  border: 1px solid #b9ff57;
  box-shadow: none;
  
}
.mpb-051::after {
  content: "_";
  margin-left: .08em;
  color: currentColor;
  animation: mpBlink 900ms steps(1) infinite;
}
.mpb-051:hover { clip-path: polygon(10px 0,100% 0,100% calc(100% - 10px),calc(100% - 10px) 100%,0 100%,0 10px); }


.mpb-052 {
  --mp-a: hsl(229 88% 60%);
  --mp-b: hsl(343 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 24px;
  border-radius: 34px 18px 28px 16px;
  background: linear-gradient(180deg, color-mix(in srgb, var(--mp-a) 90%, white 10%), color-mix(in srgb, var(--mp-a) 62%, black 20%));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 33px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-052::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 10px 12px;
  opacity: .18;
}
.mpb-052:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }


.mpb-053 {
  --mp-a: hsl(252 88% 60%);
  --mp-b: hsl(24 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 26px;
  border-radius: 14px;
  background: linear-gradient(135deg, var(--mp-a), var(--mp-b));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 36px color-mix(in srgb, var(--mp-a) 27%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-053::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-053:hover { animation: mpBreath 1.1s ease-in-out infinite; }


.mpb-054 {
  --mp-a: hsl(275 88% 60%);
  --mp-b: hsl(317 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 28px;
  border-radius: 18px;
  background: linear-gradient(135deg, #111, #2b2b2b);
  color: #fff8ed;
  border: 2px solid #000;
  box-shadow: 4px 4px 0 #000;
  
}
.mpb-054::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 12px 9px;
  opacity: .18;
}
.mpb-054:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }


.mpb-055 {
  --mp-a: hsl(298 88% 60%);
  --mp-b: hsl(358 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 20px;
  border-radius: 26px;
  background: linear-gradient(135deg, color-mix(in srgb, var(--mp-a) 28%, transparent), color-mix(in srgb, var(--mp-b) 18%, transparent));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 42px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-055::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);
  transform: translateX(-130%);
  transition: transform .62s cubic-bezier(.2,.8,.2,1);
}
.mpb-055:hover::before { transform: translateX(130%); }
.mpb-055:hover { transform: translateX(3px); }


.mpb-056 {
  --mp-a: hsl(321 88% 60%);
  --mp-b: hsl(39 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 22px;
  border-radius: 999px 20px 999px 20px;
  background: #f5dfbf;
  color: #17100b;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 8px 0 rgba(89, 66, 36, .38), 0 22px 34px rgba(0,0,0,.14);
  
}
.mpb-056::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 9px 11px;
  opacity: .18;
}
.mpb-056:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }


.mpb-057 {
  --mp-a: hsl(344 88% 60%);
  --mp-b: hsl(80 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 24px;
  border-radius: 22px 12px;
  background: linear-gradient(135deg, #0b0d12, color-mix(in srgb, var(--mp-a) 20%, #0b0d12));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 27px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-057::before {
  content: "";
  position: absolute;
  inset: 50%;
  border-radius: inherit;
  background: color-mix(in srgb, var(--mp-a) 22%, transparent);
  transition: inset .42s ease, opacity .42s ease;
  opacity: 0;
}
.mpb-057:hover::before { inset: -30%; opacity: 1; }
.mpb-057:hover .mp-icon { transform: translate(4px,-4px); }


.mpb-058 {
  --mp-a: hsl(7 88% 60%);
  --mp-b: hsl(121 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 26px;
  border-radius: 0;
  background: color-mix(in srgb, var(--mp-a) 14%, transparent);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-058:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }
.mpb-058:hover .mp-icon { transform: rotate(18deg) scale(1.12); }


.mpb-059 {
  --mp-a: hsl(30 88% 60%);
  --mp-b: hsl(162 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 28px;
  border-radius: 18px;
  background: #080b0d;
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 33px color-mix(in srgb, var(--mp-a) 30%, transparent);
  
}
.mpb-059::after {
  content: "_";
  margin-left: .08em;
  color: currentColor;
  animation: mpBlink 900ms steps(1) infinite;
}
.mpb-059:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 18px 33px color-mix(in srgb, var(--mp-a) 30%, transparent); }


.mpb-060 {
  --mp-a: hsl(53 88% 60%);
  --mp-b: hsl(95 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 20px;
  border-radius: 999px;
  background: linear-gradient(90deg, color-mix(in srgb, var(--mp-a) 20%, transparent), transparent);
  color: #fff8ed;
  border: 0;
  box-shadow: 0 10px 36px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-060::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 8px 10px;
  opacity: .18;
}
.mpb-060:hover .mp-icon { animation: mpSpin 700ms ease; }


.mpb-061 {
  --mp-a: hsl(93 88% 60%);
  --mp-b: hsl(153 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 22px;
  border-radius: 22px 12px;
  background: linear-gradient(90deg, var(--mp-a), var(--mp-b));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 39px color-mix(in srgb, var(--mp-a) 21%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-061::before {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);
  opacity: .55;
}
.mpb-061:hover { text-shadow: 0 0 14px color-mix(in srgb,var(--mp-a) 50%, transparent); }


.mpb-062 {
  --mp-a: hsl(116 88% 60%);
  --mp-b: hsl(194 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 24px;
  border-radius: 14px;
  background: linear-gradient(135deg, #fff7e9, color-mix(in srgb, var(--mp-a) 16%, #f7e8d1));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 42px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-062::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 10px 12px;
  opacity: .18;
}
.mpb-062:hover { animation: mpBreath 1.1s ease-in-out infinite; }


.mpb-063 {
  --mp-a: hsl(139 88% 60%);
  --mp-b: hsl(235 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 26px;
  border-radius: 18px;
  background: linear-gradient(135deg, #f9f4e8, #6d7480, #fff8ed);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 24px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-063::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);
  transform: translateX(-130%);
  transition: transform .62s cubic-bezier(.2,.8,.2,1);
}
.mpb-063:hover::before { transform: translateX(130%); }
.mpb-063:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }


.mpb-064 {
  --mp-a: hsl(162 88% 60%);
  --mp-b: hsl(276 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 28px;
  border-radius: 999px;
  background: linear-gradient(135deg, #b86b3a, #e7ba78);
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 27px color-mix(in srgb, var(--mp-a) 30%, transparent);
  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;
}
.mpb-064::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 12px 9px;
  opacity: .18;
}
.mpb-064:hover { transform: translateX(3px); }


.mpb-065 {
  --mp-a: hsl(185 88% 60%);
  --mp-b: hsl(317 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 20px;
  border-radius: 18px 18px 8px 8px;
  background: linear-gradient(90deg, #101319 0 48%, color-mix(in srgb,var(--mp-a) 18%,#101319) 48%);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-065::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 8px 10px;
  opacity: .18;
}
.mpb-065:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }


.mpb-066 {
  --mp-a: hsl(208 88% 60%);
  --mp-b: hsl(250 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 22px;
  border-radius: 22px 12px;
  background: transparent;
  color: var(--mp-a);
  border: 1.5px solid var(--mp-a);
  box-shadow: none;
  
}
.mpb-066::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 9px 11px;
  opacity: .18;
}
.mpb-066:hover .mp-icon { transform: translate(4px,-4px); }


.mpb-067 {
  --mp-a: hsl(231 88% 60%);
  --mp-b: hsl(291 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 24px;
  border-radius: 0;
  background: linear-gradient(135deg, var(--mp-a) 0 76%, color-mix(in srgb, var(--mp-a) 58%, black) 76%);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 36px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-067::before {
  content: "";
  position: absolute;
  right: 0;
  top: 0;
  border-top: 18px solid rgba(255,255,255,.42);
  border-left: 18px solid transparent;
  opacity: .75;
}
.mpb-067:hover .mp-icon { transform: rotate(18deg) scale(1.12); }


.mpb-068 {
  --mp-a: hsl(254 88% 60%);
  --mp-b: hsl(332 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 26px;
  border-radius: 10px;
  background: rgba(255,255,255,.08);
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 39px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-068::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);
  transform: translateX(-130%);
  transition: transform .62s cubic-bezier(.2,.8,.2,1);
}
.mpb-068:hover::before { transform: translateX(130%); }
.mpb-068:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 16px 39px color-mix(in srgb, var(--mp-a) 27%, transparent); }


.mpb-069 {
  --mp-a: hsl(277 88% 60%);
  --mp-b: hsl(13 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 28px;
  border-radius: 999px;
  background: linear-gradient(90deg, var(--mp-a) 0 52%, var(--mp-b) 52%);
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 42px color-mix(in srgb, var(--mp-a) 30%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-069::before {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);
  opacity: .55;
}
.mpb-069:hover .mp-icon { animation: mpSpin 700ms ease; }


.mpb-070 {
  --mp-a: hsl(300 88% 60%);
  --mp-b: hsl(54 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 20px;
  border-radius: 18px 18px 8px 8px;
  background: #070810;
  color: var(--mp-a);
  border: 1px solid var(--mp-a);
  box-shadow: 0 10px 24px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-070::before {
  content: "";
  position: absolute;
  inset: 50%;
  border-radius: inherit;
  background: color-mix(in srgb, var(--mp-a) 22%, transparent);
  transition: inset .42s ease, opacity .42s ease;
  opacity: 0;
}
.mpb-070:hover::before { inset: -30%; opacity: 1; }
.mpb-070:hover b { transform: translateX(3px); }


.mpb-071 {
  --mp-a: hsl(340 88% 60%);
  --mp-b: hsl(112 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 22px;
  border-radius: 0;
  background: linear-gradient(135deg, #111, #2b2b2b);
  color: #fff8ed;
  border: 2px solid #000;
  box-shadow: 4px 4px 0 #000;
  
}
.mpb-071::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 9px 11px;
  opacity: .18;
}
.mpb-071:hover { animation: mpBreath 1.1s ease-in-out infinite; }


.mpb-072 {
  --mp-a: hsl(3 88% 60%);
  --mp-b: hsl(45 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 24px;
  border-radius: 18px;
  background: linear-gradient(135deg, color-mix(in srgb, var(--mp-a) 28%, transparent), color-mix(in srgb, var(--mp-b) 18%, transparent));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 30px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-072::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);
  transform: translateX(-130%);
  transition: transform .62s cubic-bezier(.2,.8,.2,1);
}
.mpb-072:hover::before { transform: translateX(130%); }
.mpb-072:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }


.mpb-073 {
  --mp-a: hsl(26 88% 60%);
  --mp-b: hsl(86 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 26px;
  border-radius: 999px;
  background: #f5dfbf;
  color: #17100b;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 8px 0 rgba(89, 66, 36, .38), 0 22px 34px rgba(0,0,0,.14);
  
}
.mpb-073::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-073:hover { transform: translateX(3px); }


.mpb-074 {
  --mp-a: hsl(49 88% 60%);
  --mp-b: hsl(127 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 28px;
  border-radius: 18px 18px 8px 8px;
  background: linear-gradient(135deg, #0b0d12, color-mix(in srgb, var(--mp-a) 20%, #0b0d12));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 36px color-mix(in srgb, var(--mp-a) 30%, transparent);
  
}
.mpb-074::before {
  content: "";
  position: absolute;
  inset: 50%;
  border-radius: inherit;
  background: color-mix(in srgb, var(--mp-a) 22%, transparent);
  transition: inset .42s ease, opacity .42s ease;
  opacity: 0;
}
.mpb-074:hover::before { inset: -30%; opacity: 1; }
.mpb-074:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }


.mpb-075 {
  --mp-a: hsl(72 88% 60%);
  --mp-b: hsl(168 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 20px;
  border-radius: 34px 18px 28px 16px;
  background: color-mix(in srgb, var(--mp-a) 14%, transparent);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 39px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-075:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }
.mpb-075:hover .mp-icon { transform: translate(4px,-4px); }


.mpb-076 {
  --mp-a: hsl(95 88% 60%);
  --mp-b: hsl(209 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 22px;
  border-radius: 0;
  background: #080b0d;
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 42px color-mix(in srgb, var(--mp-a) 21%, transparent);
  
}
.mpb-076::after {
  content: "_";
  margin-left: .08em;
  color: currentColor;
  animation: mpBlink 900ms steps(1) infinite;
}
.mpb-076:hover .mp-icon { transform: rotate(18deg) scale(1.12); }


.mpb-077 {
  --mp-a: hsl(118 88% 60%);
  --mp-b: hsl(250 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 24px;
  border-radius: 10px;
  background: linear-gradient(90deg, color-mix(in srgb, var(--mp-a) 20%, transparent), transparent);
  color: #fff8ed;
  border: 0;
  box-shadow: 0 14px 24px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-077::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 10px 12px;
  opacity: .18;
}
.mpb-077:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 14px 24px color-mix(in srgb, var(--mp-a) 24%, transparent); }


.mpb-078 {
  --mp-a: hsl(141 88% 60%);
  --mp-b: hsl(183 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 26px;
  border-radius: 26px;
  background: linear-gradient(135deg, color-mix(in srgb,var(--mp-a) 18%, transparent), color-mix(in srgb,var(--mp-b) 16%, transparent));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 27px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-078::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-078:hover .mp-icon { animation: mpSpin 700ms ease; }


.mpb-079 {
  --mp-a: hsl(164 88% 60%);
  --mp-b: hsl(224 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 28px;
  border-radius: 999px 20px 999px 20px;
  background: color-mix(in srgb, var(--mp-a) 20%, var(--mp-panel));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 30px color-mix(in srgb, var(--mp-a) 30%, transparent);
  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;
}
.mpb-079::before {
  content: "";
  position: absolute;
  right: 0;
  top: 0;
  border-top: 18px solid rgba(255,255,255,.42);
  border-left: 18px solid transparent;
  opacity: .75;
}
.mpb-079:hover b { transform: translateX(3px); }


.mpb-080 {
  --mp-a: hsl(187 88% 60%);
  --mp-b: hsl(265 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 20px;
  border-radius: 34px 18px 28px 16px;
  background: radial-gradient(circle at 30% 20%, white, var(--mp-a) 24%, var(--mp-b));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 33px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-080:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }
.mpb-080:hover { filter: saturate(1.08) brightness(1.04); }


.mpb-081 {
  --mp-a: hsl(227 88% 60%);
  --mp-b: hsl(323 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 22px;
  border-radius: 10px;
  background: linear-gradient(135deg, #b86b3a, #e7ba78);
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 36px color-mix(in srgb, var(--mp-a) 21%, transparent);
  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;
}
.mpb-081::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 9px 11px;
  opacity: .18;
}
.mpb-081:hover .mp-icon { transform: translate(5px,-5px) rotate(-10deg); }


.mpb-082 {
  --mp-a: hsl(250 88% 60%);
  --mp-b: hsl(4 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 24px;
  border-radius: 26px;
  background: linear-gradient(90deg, #101319 0 48%, color-mix(in srgb,var(--mp-a) 18%,#101319) 48%);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 39px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-082::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 10px 12px;
  opacity: .18;
}
.mpb-082:hover { transform: translateX(3px); }


.mpb-083 {
  --mp-a: hsl(273 88% 60%);
  --mp-b: hsl(45 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 26px;
  border-radius: 18px 18px 8px 8px;
  background: transparent;
  color: var(--mp-a);
  border: 1.5px solid var(--mp-a);
  box-shadow: none;
  
}
.mpb-083::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-083:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }


.mpb-084 {
  --mp-a: hsl(296 88% 60%);
  --mp-b: hsl(338 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 28px;
  border-radius: 34px 18px 28px 16px;
  background: linear-gradient(135deg, var(--mp-a) 0 76%, color-mix(in srgb, var(--mp-a) 58%, black) 76%);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 24px color-mix(in srgb, var(--mp-a) 30%, transparent);
  
}
.mpb-084::before {
  content: "";
  position: absolute;
  right: 0;
  top: 0;
  border-top: 18px solid rgba(255,255,255,.42);
  border-left: 18px solid transparent;
  opacity: .75;
}
.mpb-084:hover .mp-icon { transform: translate(4px,-4px); }


.mpb-085 {
  --mp-a: hsl(319 88% 60%);
  --mp-b: hsl(19 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 20px;
  border-radius: 14px;
  background: rgba(255,255,255,.08);
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 27px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-085::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(105deg, transparent 20%, rgba(255,255,255,.46), transparent 78%);
  transform: translateX(-130%);
  transition: transform .62s cubic-bezier(.2,.8,.2,1);
}
.mpb-085:hover::before { transform: translateX(130%); }
.mpb-085:hover .mp-icon { transform: rotate(18deg) scale(1.12); }


.mpb-086 {
  --mp-a: hsl(342 88% 60%);
  --mp-b: hsl(60 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 22px;
  border-radius: 10px;
  background: linear-gradient(90deg, var(--mp-a) 0 52%, var(--mp-b) 52%);
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 30px color-mix(in srgb, var(--mp-a) 21%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-086::before {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);
  opacity: .55;
}
.mpb-086:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 12px 30px color-mix(in srgb, var(--mp-a) 21%, transparent); }


.mpb-087 {
  --mp-a: hsl(5 88% 60%);
  --mp-b: hsl(101 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 24px;
  border-radius: 26px;
  background: #070810;
  color: var(--mp-a);
  border: 1px solid var(--mp-a);
  box-shadow: 0 14px 33px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-087::before {
  content: "";
  position: absolute;
  inset: 50%;
  border-radius: inherit;
  background: color-mix(in srgb, var(--mp-a) 22%, transparent);
  transition: inset .42s ease, opacity .42s ease;
  opacity: 0;
}
.mpb-087:hover::before { inset: -30%; opacity: 1; }
.mpb-087:hover .mp-icon { animation: mpSpin 700ms ease; }


.mpb-088 {
  --mp-a: hsl(28 88% 60%);
  --mp-b: hsl(142 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 26px;
  border-radius: 999px 20px 999px 20px;
  background: linear-gradient(var(--mp-bg), var(--mp-bg)) padding-box, linear-gradient(135deg,var(--mp-a),var(--mp-b)) border-box;
  color: #fff8ed;
  border: 1px solid transparent;
  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-088::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-088:hover b { transform: translateX(3px); }


.mpb-089 {
  --mp-a: hsl(51 88% 60%);
  --mp-b: hsl(183 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 28px;
  border-radius: 22px 12px;
  background: #060b08;
  color: #b9ff57;
  border: 1px solid #b9ff57;
  box-shadow: none;
  
}
.mpb-089::after {
  content: "_";
  margin-left: .08em;
  color: currentColor;
  animation: mpBlink 900ms steps(1) infinite;
}
.mpb-089:hover { filter: saturate(1.08) brightness(1.04); }


.mpb-090 {
  --mp-a: hsl(74 88% 60%);
  --mp-b: hsl(116 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 20px;
  border-radius: 14px;
  background: linear-gradient(180deg, color-mix(in srgb, var(--mp-a) 90%, white 10%), color-mix(in srgb, var(--mp-a) 62%, black 20%));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 42px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-090::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 8px 10px;
  opacity: .18;
}
.mpb-090:hover { opacity: .9; }


.mpb-091 {
  --mp-a: hsl(114 88% 60%);
  --mp-b: hsl(174 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 22px;
  border-radius: 26px;
  background: linear-gradient(135deg, #0b0d12, color-mix(in srgb, var(--mp-a) 20%, #0b0d12));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 24px color-mix(in srgb, var(--mp-a) 21%, transparent);
  
}
.mpb-091::before {
  content: "";
  position: absolute;
  inset: 50%;
  border-radius: inherit;
  background: color-mix(in srgb, var(--mp-a) 22%, transparent);
  transition: inset .42s ease, opacity .42s ease;
  opacity: 0;
}
.mpb-091:hover::before { inset: -30%; opacity: 1; }
.mpb-091:hover { transform: translateX(3px); }


.mpb-092 {
  --mp-a: hsl(137 88% 60%);
  --mp-b: hsl(215 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 24px;
  border-radius: 999px 20px 999px 20px;
  background: color-mix(in srgb, var(--mp-a) 14%, transparent);
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 27px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-092:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }
.mpb-092:hover { transform: translateY(-5px); box-shadow: 0 22px 38px color-mix(in srgb,var(--mp-a) 25%, transparent); }


.mpb-093 {
  --mp-a: hsl(160 88% 60%);
  --mp-b: hsl(256 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 26px;
  border-radius: 34px 18px 28px 16px;
  background: #080b0d;
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 16px 30px color-mix(in srgb, var(--mp-a) 27%, transparent);
  
}
.mpb-093::after {
  content: "_";
  margin-left: .08em;
  color: currentColor;
  animation: mpBlink 900ms steps(1) infinite;
}
.mpb-093:hover .mp-icon { transform: translate(4px,-4px); }


.mpb-094 {
  --mp-a: hsl(183 88% 60%);
  --mp-b: hsl(297 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 28px;
  border-radius: 14px;
  background: linear-gradient(90deg, color-mix(in srgb, var(--mp-a) 20%, transparent), transparent);
  color: #fff8ed;
  border: 0;
  box-shadow: 0 18px 33px color-mix(in srgb, var(--mp-a) 30%, transparent);
  
}
.mpb-094::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 12px 9px;
  opacity: .18;
}
.mpb-094:hover .mp-icon { transform: rotate(18deg) scale(1.12); }


.mpb-095 {
  --mp-a: hsl(206 88% 60%);
  --mp-b: hsl(338 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 20px;
  border-radius: 18px;
  background: linear-gradient(135deg, color-mix(in srgb,var(--mp-a) 18%, transparent), color-mix(in srgb,var(--mp-b) 16%, transparent));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 36px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-095::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 8px 10px;
  opacity: .18;
}
.mpb-095:hover { box-shadow: 0 0 0 7px color-mix(in srgb,var(--mp-a) 14%, transparent), 0 10px 36px color-mix(in srgb, var(--mp-a) 18%, transparent); }


.mpb-096 {
  --mp-a: hsl(229 88% 60%);
  --mp-b: hsl(271 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 22px;
  border-radius: 999px;
  background: color-mix(in srgb, var(--mp-a) 20%, var(--mp-panel));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 12px 39px color-mix(in srgb, var(--mp-a) 21%, transparent);
  clip-path: polygon(12px 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%,0 12px); border-radius:0;
}
.mpb-096::before {
  content: "";
  position: absolute;
  right: 0;
  top: 0;
  border-top: 18px solid rgba(255,255,255,.42);
  border-left: 18px solid transparent;
  opacity: .75;
}
.mpb-096:hover .mp-icon { animation: mpSpin 700ms ease; }


.mpb-097 {
  --mp-a: hsl(252 88% 60%);
  --mp-b: hsl(312 88% 62%);
  --mp-bg: #10131b;
  min-height: 48px;
  padding: 0 24px;
  border-radius: 999px 20px 999px 20px;
  background: radial-gradient(circle at 30% 20%, white, var(--mp-a) 24%, var(--mp-b));
  color: #fff8ed;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 14px 42px color-mix(in srgb, var(--mp-a) 24%, transparent);
  
}
.mpb-097:hover { border-radius: 34% 66% 52% 48% / 48% 42% 58% 52%; }
.mpb-097:hover b { transform: translateX(3px); }


.mpb-098 {
  --mp-a: hsl(275 88% 60%);
  --mp-b: hsl(353 88% 62%);
  --mp-bg: #10131b;
  min-height: 50px;
  padding: 0 26px;
  border-radius: 22px 12px;
  background: transparent;
  color: var(--mp-a);
  border: 1.5px solid var(--mp-a);
  box-shadow: none;
  
}
.mpb-098::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 11px 8px;
  opacity: .18;
}
.mpb-098:hover { filter: saturate(1.08) brightness(1.04); }


.mpb-099 {
  --mp-a: hsl(298 88% 60%);
  --mp-b: hsl(34 88% 62%);
  --mp-bg: #10131b;
  min-height: 52px;
  padding: 0 28px;
  border-radius: 0;
  background: linear-gradient(90deg, var(--mp-a), var(--mp-b));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 18px 27px color-mix(in srgb, var(--mp-a) 30%, transparent);
  clip-path: polygon(0 0, 94% 0, 100% 50%, 94% 100%, 0 100%, 6% 50%); border-radius:0;
}
.mpb-099::before {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at var(--mx, 20%) 50%, rgba(255,255,255,.28), transparent 34%);
  opacity: .55;
}
.mpb-099:hover { opacity: .9; }


.mpb-100 {
  --mp-a: hsl(321 88% 60%);
  --mp-b: hsl(75 88% 62%);
  --mp-bg: #10131b;
  min-height: 46px;
  padding: 0 20px;
  border-radius: 18px;
  background: linear-gradient(135deg, #fff7e9, color-mix(in srgb, var(--mp-a) 16%, #f7e8d1));
  color: #13100c;
  border: 1px solid color-mix(in srgb, var(--mp-a) 36%, transparent);
  box-shadow: 0 10px 30px color-mix(in srgb, var(--mp-a) 18%, transparent);
  
}
.mpb-100::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,.24) 1px, transparent 1.4px);
  background-size: 8px 10px;
  opacity: .18;
}
.mpb-100:hover { outline: 1px solid var(--mp-b); outline-offset: 7px; }


@keyframes mpBlink { 50% { opacity: 0; } }
@keyframes mpSpin { to { transform: rotate(1turn); } }
@keyframes mpBreath { 50% { transform: scale(1.035); } }

@media (max-width: 900px) {
  .master-hero {
    grid-template-columns: 1fr;
  }

  .master-tools {
    position: relative;
    top: auto;
    grid-template-columns: 1fr;
  }

  .master-search {
    width: 100%;
    min-width: 0;
  }

  .master-grid {
    grid-template-columns: 1fr;
  }

  .master-info {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 620px) {
  .master-shell {
    width: min(100% - 20px, 1240px);
  }

  .master-hero,
  .master-card {
    border-radius: 22px;
  }

  .master-stage {
    min-height: 116px;
    padding: 18px;
  }

  .mp-master-btn {
    max-width: 100%;
    transform: scale(.94);
  }
}
/* ===== MASTERPIECE BUTTONS PAGE END ===== */

'@
$masterpieceApp = @'

(function () {
  const state = {
    all: window.MASTERPIECE_BUTTONS || [],
    collection: "all",
    search: "",
    active: null,
    tab: "html"
  };

  const grid = document.getElementById("masterGrid");
  const tabs = document.getElementById("masterTabs");
  const search = document.getElementById("masterSearch");
  const hero = document.getElementById("masterHeroPreview");
  const dialog = document.getElementById("mpSourceDialog");
  const dialogTitle = document.getElementById("mpDialogTitle");
  const dialogPreview = document.getElementById("mpDialogPreview");
  const codeBlock = document.getElementById("mpCodeBlock");
  const copyCode = document.getElementById("mpCopyCode");

  function esc(value) {
    return String(value).replace(/[&<>"']/g, function (m) {
      return ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#039;" })[m];
    });
  }

  function html(btn) {
    return '<button class="mp-master-btn ' + btn.className + '">' +
      '<span class="mp-icon">' + btn.icon + '</span>' +
      '<b>' + esc(btn.label) + '</b>' +
      '</button>';
  }

  function renderTabs() {
    const collections = window.MASTERPIECE_COLLECTIONS || [];
    tabs.innerHTML = '<button class="master-tab active" type="button" data-collection="all">All 100</button>' +
      collections.map(function (item) {
        return '<button class="master-tab" type="button" data-collection="' + item.id + '">' +
          esc(item.title) + ' <small>' + item.count + '</small></button>';
      }).join("");

    tabs.addEventListener("click", function (event) {
      const tab = event.target.closest(".master-tab");
      if (!tab) return;
      state.collection = tab.dataset.collection;
      document.querySelectorAll(".master-tab").forEach(function (item) {
        item.classList.toggle("active", item === tab);
      });
      renderGrid();
    });
  }

  function renderHero() {
    const picks = [state.all[0], state.all[24], state.all[48], state.all[72]].filter(Boolean);
    hero.innerHTML = picks.map(html).join("");
  }

  function filtered() {
    const q = state.search.trim().toLowerCase();
    return state.all.filter(function (btn) {
      const collectionOk = state.collection === "all" || btn.collection === state.collection;
      const text = [btn.label, btn.desc, btn.collectionTitle, btn.style, btn.motion].join(" ").toLowerCase();
      return collectionOk && (!q || text.includes(q));
    });
  }

  function renderGrid() {
    grid.innerHTML = filtered().map(function (btn) {
      return '<article class="master-card">' +
        '<div class="master-card-top"><span>#' + String(btn.number).padStart(3, "0") + '</span><span>' + esc(btn.collectionTitle) + '</span></div>' +
        '<div class="master-stage">' + html(btn) + '</div>' +
        '<div class="master-info"><div><h3>' + esc(btn.label) + '</h3><p>' + esc(btn.desc) + ' · ' + esc(btn.style) + '</p></div>' +
        '<button class="master-source-btn" type="button" data-id="' + btn.id + '">Source</button></div>' +
      '</article>';
    }).join("");
  }

  function baseCss() {
    return `.mp-master-btn {
  position: relative;
  isolation: isolate;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: .64em;
  border: 0;
  outline: 0;
  cursor: pointer;
  overflow: hidden;
  font: 950 .92rem/1 ui-sans-serif, system-ui, sans-serif;
  letter-spacing: -.01em;
  transition: transform .18s ease, box-shadow .18s ease, border-color .18s ease, filter .18s ease, letter-spacing .18s ease, border-radius .22s ease;
  white-space: nowrap;
}

.mp-master-btn b,
.mp-master-btn .mp-icon {
  position: relative;
  z-index: 2;
  transition: transform .2s ease;
}`;
  }

  function source(btn, tab) {
    if (tab === "html") return html(btn).replaceAll('><', '>\n<');
    if (tab === "css") return baseCss() + "\n\n" + btn.css;
    return `document.querySelector(".${btn.className}")?.addEventListener("click", (event) => {
  event.currentTarget.animate(
    [
      { transform: "scale(1)" },
      { transform: "scale(0.97)" },
      { transform: "scale(1)" }
    ],
    { duration: 220, easing: "ease-out" }
  );
});`;
  }

  function openSource(btn) {
    state.active = btn;
    state.tab = "html";
    dialogTitle.textContent = btn.label;
    dialogPreview.innerHTML = html(btn);
    document.querySelectorAll(".mp-code-tab").forEach(function (tab) {
      tab.classList.toggle("active", tab.dataset.tab === "html");
    });
    codeBlock.textContent = source(btn, "html");
    dialog.showModal();
  }

  grid.addEventListener("click", function (event) {
    const sourceBtn = event.target.closest(".master-source-btn");
    if (!sourceBtn) return;
    const btn = state.all.find(function (item) { return item.id === sourceBtn.dataset.id; });
    if (btn) openSource(btn);
  });

  document.querySelector(".mp-code-tabs").addEventListener("click", function (event) {
    const tab = event.target.closest(".mp-code-tab");
    if (!tab || !state.active) return;
    state.tab = tab.dataset.tab;
    document.querySelectorAll(".mp-code-tab").forEach(function (item) {
      item.classList.toggle("active", item === tab);
    });
    codeBlock.textContent = source(state.active, state.tab);
  });

  copyCode.addEventListener("click", async function () {
    if (!state.active) return;
    await navigator.clipboard.writeText(source(state.active, state.tab));
    copyCode.textContent = "Copied";
    setTimeout(function () { copyCode.textContent = "Copy"; }, 850);
  });

  search.addEventListener("input", function () {
    state.search = search.value;
    renderGrid();
  });

  renderTabs();
  renderHero();
  renderGrid();
})();

'@
$masterpieceHtml = @'
<!doctype html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Masterpiece Buttons — Buttonverse Lab</title>
  <meta name="description" content="100 curated high-quality button designs with source code.">
  <link rel="icon" href="../assets/favicon.svg" type="image/svg+xml">
  <link rel="stylesheet" href="../assets/styles.css">
  <link rel="stylesheet" href="../assets/masterpiece-buttons.css">
</head>
<body class="masterpiece-body" data-page="masterpieces">
  <div class="ambient" aria-hidden="true"></div>

  <header class="topbar">
    <a class="brand" href="../index.html">
      <span class="brand-cube">BV</span>
      <span><strong>Buttonverse</strong><small>Masterpieces</small></span>
    </a>
    <nav class="toplinks">
      <a href="../index.html">Lobby</a>
      <a href="../library.html">Library</a>
      <a href="index.html" aria-current="page">Masterpieces</a>
      <a href="../source-guide.html">Source Guide</a>
      <button class="theme-btn" id="themeToggle" type="button">Theme</button>
    </nav>
  </header>

  <main class="master-shell">
    <section class="master-hero">
      <div>
        <p class="label">100 curated buttons</p>
        <h1>Masterpiece button set.</h1>
        <p class="lead">These are not mass filler buttons. This folder keeps 100 more polished, usable, premium-style button ideas separate from the 1,000 library.</p>
      </div>

      <div class="master-preview-wall" id="masterHeroPreview"></div>
    </section>

    <section class="master-tools">
      <div class="master-tabs" id="masterTabs"></div>
      <input class="master-search" id="masterSearch" type="search" placeholder="Search masterpiece buttons..." autocomplete="off">
    </section>

    <section class="master-grid" id="masterGrid"></section>
  </main>

  <dialog class="mp-source-dialog" id="mpSourceDialog">
    <form method="dialog" class="mp-dialog-head">
      <div>
        <p class="label">copy source</p>
        <h2 id="mpDialogTitle">Button source</h2>
      </div>
      <button class="mp-dialog-close" type="submit">×</button>
    </form>

    <div class="mp-dialog-preview" id="mpDialogPreview"></div>

    <div class="mp-code-tabs">
      <button class="mp-code-tab active" type="button" data-tab="html">HTML</button>
      <button class="mp-code-tab" type="button" data-tab="css">CSS</button>
      <button class="mp-code-tab" type="button" data-tab="js">JS</button>
      <button class="mp-copy-code" id="mpCopyCode" type="button">Copy</button>
    </div>

    <pre class="mp-code-box"><code id="mpCodeBlock"></code></pre>
  </dialog>

  <script src="../assets/data.js"></script>
  <script src="../assets/app.js"></script>
  <script src="../assets/masterpiece-data.js"></script>
  <script src="../assets/masterpiece-app.js"></script>
</body>
</html>

'@

Save-Utf8 (Join-Path $site "assets\masterpiece-data.js") $masterpieceData
Save-Utf8 (Join-Path $site "assets\masterpiece-buttons.css") $masterpieceCss
Save-Utf8 (Join-Path $site "assets\masterpiece-app.js") $masterpieceApp
Save-Utf8 (Join-Path $site "masterpieces\index.html") $masterpieceHtml

Write-Host "3) Adding Masterpieces nav link to root pages..."

Get-ChildItem -Path $site -File -Filter "*.html" | ForEach-Object {
  $html = Read-Utf8 $_.FullName

  if ($html -notmatch 'masterpieces/index\.html') {
    $html = [regex]::Replace(
      $html,
      '(<a\s+href=["'']source-guide\.html["''][^>]*>Source Guide</a>)',
      '<a href="masterpieces/index.html">Masterpieces</a>' + "`r`n      " + '$1',
      1
    )
  }

  Save-Utf8 $_.FullName $html
}

Write-Host "4) Adding lobby card link..."

$indexPath = Join-Path $site "index.html"
$index = Read-Utf8 $indexPath

if ($index -notmatch 'masterpiece-card-link') {
  $card = @'
      <a class="category-card masterpiece-card-link" href="masterpieces/index.html">
        <span class="icon">✦</span>
        <small>100 buttons</small>
        <h3>Masterpiece Set</h3>
        <p>Curated premium buttons kept separate from the mass library.</p>
      </a>
'@

  $index = [regex]::Replace(
    $index,
    '(<div\s+class=["'']map-grid["'']\s+id=["'']categoryMap["'']>\s*</div>)',
    '<div class="map-grid" id="categoryMap"></div>' + "`r`n" + $card,
    1
  )
}

Save-Utf8 $indexPath $index

Write-Host "5) Syntax check..."

$node = Get-Command node -ErrorAction SilentlyContinue
if ($node) {
  node --check (Join-Path $site "assets\masterpiece-data.js") | Out-Null
  node --check (Join-Path $site "assets\masterpiece-app.js") | Out-Null
}

Write-Host ""
Write-Host "DONE:"
Write-Host "- kept the existing 1000 library"
Write-Host "- added 100 curated masterpiece buttons"
Write-Host "- created separate folder: masterpieces"
Write-Host "- added Masterpieces nav link"
Write-Host "- each button has source code modal"
Write-Host "- backup saved here:"
Write-Host $backup
Write-Host ""
Write-Host "Open:"
Write-Host ".\masterpieces\index.html"
