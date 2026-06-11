$ErrorActionPreference = "Stop"

# Run inside either:
# 1) flowsync-button-site  OR
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
$backup = Join-Path (Split-Path $site -Parent) "buttonverse-lab-before-simple-ui_$stamp"
Copy-Item $site $backup -Recurse -Force

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)

function Read-Utf8($p) {
  [System.IO.File]::ReadAllText($p, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
}

function Save-Utf8($p, $t) {
  [System.IO.File]::WriteAllText($p, $t, $script:utf8NoBom)
}

Write-Host "1) Simplifying UI layout..."

$stylePath = Join-Path $site "assets\styles.css"
$style = Read-Utf8 $stylePath

$style = [regex]::Replace(
  $style,
  '(?s)\r?\n?/\* ===== BUTTONVERSE SIMPLE UI PATCH START ===== \*/.*?/\* ===== BUTTONVERSE SIMPLE UI PATCH END ===== \*/',
  ''
)

$css = @'

/* ===== BUTTONVERSE SIMPLE UI PATCH START ===== */

/* Softer, simpler page spacing */
body {
  background:
    radial-gradient(circle at 12% 0%, color-mix(in srgb, var(--accent-3) 16%, transparent), transparent 24rem),
    radial-gradient(circle at 88% 6%, color-mix(in srgb, var(--accent-2) 14%, transparent), transparent 26rem),
    var(--bg) !important;
}

.ambient {
  opacity: .55 !important;
}

/* Cleaner top nav */
.topbar {
  width: min(1160px, calc(100% - 28px)) !important;
  min-height: 74px !important;
  border-radius: 22px !important;
  padding: 12px 16px !important;
}

.brand-cube {
  width: 40px !important;
  height: 40px !important;
  border-radius: 13px !important;
}

.toplinks {
  gap: 6px !important;
}

.toplinks a,
.theme-btn {
  padding: 9px 12px !important;
  border-radius: 14px !important;
  font-size: .92rem !important;
  letter-spacing: 0 !important;
}

/* Lobby: less huge, easier to read */
.lobby-shell,
.guide-shell {
  width: min(1160px, calc(100% - 28px)) !important;
  margin-top: 18px !important;
}

.lobby-hero {
  min-height: auto !important;
  grid-template-columns: minmax(0, 1.08fr) minmax(300px, .72fr) !important;
}

.hero-left,
.lobby-device,
.guide-hero {
  border-radius: 28px !important;
}

.hero-left {
  padding: clamp(28px, 5vw, 58px) !important;
}

h1 {
  font-size: clamp(2.8rem, 7vw, 6.2rem) !important;
  line-height: .88 !important;
}

.lead {
  max-width: 760px !important;
  margin-top: 20px !important;
}

.hero-actions {
  margin-top: 26px !important;
}

.mega-link,
.ghost-link,
.dock-random,
.load-more,
.copy-code,
.dialog-close {
  border-radius: 15px !important;
  padding: 12px 15px !important;
}

/* Make category cards cleaner */
.category-map {
  margin-top: 34px !important;
}

.map-grid {
  grid-template-columns: repeat(3, minmax(0, 1fr)) !important;
}

.category-card {
  min-height: 150px !important;
  border-radius: 22px !important;
  padding: 18px !important;
}

.category-card .icon {
  width: 38px !important;
  height: 38px !important;
  border-radius: 12px !important;
}

.category-card h3 {
  margin-top: 16px !important;
  margin-bottom: 6px !important;
}

/* Main library: remove confusing side-dock feel */
.library-layout {
  width: min(1180px, calc(100% - 28px)) !important;
  grid-template-columns: 1fr !important;
  gap: 14px !important;
}

.filter-dock {
  position: sticky !important;
  top: 104px !important;
  z-index: 40 !important;
  border-radius: 24px !important;
  padding: 14px !important;
  display: grid !important;
  grid-template-columns: 1.2fr 1fr 1fr auto auto !important;
  gap: 10px !important;
  align-items: end !important;
}

.filter-dock > .label,
.filter-dock > h2 {
  display: none !important;
}

.filter-dock label {
  min-width: 0 !important;
  padding: 10px 12px !important;
  border-radius: 15px !important;
  position: relative !important;
}

.filter-dock label span {
  font-size: .62rem !important;
  letter-spacing: .1em !important;
}

.filter-meta {
  min-height: 58px !important;
  border-radius: 15px !important;
  padding: 9px 12px !important;
  display: grid !important;
  align-content: center !important;
}

.filter-meta strong {
  font-size: 1.25rem !important;
  line-height: 1 !important;
}

.filter-meta span {
  font-size: .72rem !important;
}

.dock-random {
  min-height: 58px !important;
  white-space: nowrap !important;
}

/* Custom clean inputs/dropdowns */
input,
select {
  width: 100% !important;
  min-height: 26px !important;
  color: var(--text) !important;
  font-size: .95rem !important;
}

select {
  appearance: none !important;
  -webkit-appearance: none !important;
  cursor: pointer !important;
  padding-right: 28px !important;
  background:
    linear-gradient(45deg, transparent 50%, var(--muted) 50%) calc(100% - 15px) 55% / 6px 6px no-repeat,
    linear-gradient(135deg, var(--muted) 50%, transparent 50%) calc(100% - 9px) 55% / 6px 6px no-repeat !important;
}

select:focus,
input:focus {
  outline: none !important;
}

.filter-dock label:focus-within {
  border-color: color-mix(in srgb, var(--accent-2) 42%, var(--line)) !important;
  box-shadow: 0 0 0 4px color-mix(in srgb, var(--accent-2) 10%, transparent) !important;
}

/* Library header simpler */
.library-head {
  border-radius: 28px !important;
  padding: 24px !important;
  grid-template-columns: 1fr auto !important;
  align-items: center !important;
}

.library-head h1 {
  max-width: 760px !important;
  font-size: clamp(2rem, 4.2vw, 4rem) !important;
}

.library-head > p {
  max-width: 300px !important;
  font-size: .92rem !important;
}

/* Button cards: cleaner and less noisy */
.button-grid {
  grid-template-columns: repeat(3, minmax(0, 1fr)) !important;
  gap: 14px !important;
}

.button-card {
  border-radius: 22px !important;
  padding: 14px !important;
  gap: 12px !important;
  box-shadow: 0 12px 34px var(--shadow) !important;
}

.stage {
  min-height: 108px !important;
  border-radius: 18px !important;
  padding: 18px !important;
}

.card-bottom {
  grid-template-columns: 1fr !important;
}

.source-btn {
  width: 100% !important;
  border-radius: 13px !important;
  padding: 10px 12px !important;
  background: color-mix(in srgb, var(--accent) 10%, transparent) !important;
}

.source-btn:hover {
  border-color: color-mix(in srgb, var(--accent) 45%, var(--line)) !important;
}

/* Source dialog: clearer */
.source-dialog {
  border-radius: 24px !important;
}

.dialog-head {
  padding: 18px !important;
}

.dialog-preview {
  min-height: 108px !important;
}

.code-toolbar {
  padding: 12px !important;
}

.code-tab {
  border-radius: 12px !important;
}

.code-box {
  max-height: 42vh !important;
}

/* Mobile */
@media (max-width: 980px) {
  .lobby-hero {
    grid-template-columns: 1fr !important;
  }

  .map-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
  }

  .filter-dock {
    position: relative !important;
    top: auto !important;
    grid-template-columns: 1fr 1fr !important;
  }

  .dock-random,
  .filter-meta {
    min-height: 52px !important;
  }

  .button-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
  }

  .library-head {
    grid-template-columns: 1fr !important;
  }

  .library-head > p {
    max-width: none !important;
  }
}

@media (max-width: 660px) {
  .topbar {
    position: relative !important;
    top: auto !important;
    border-radius: 18px !important;
  }

  .toplinks {
    overflow-x: auto !important;
    justify-content: flex-start !important;
  }

  .map-grid,
  .filter-dock,
  .button-grid {
    grid-template-columns: 1fr !important;
  }

  .hero-left,
  .lobby-device,
  .library-head,
  .filter-dock,
  .guide-hero {
    border-radius: 22px !important;
  }

  h1 {
    font-size: clamp(2.45rem, 15vw, 4rem) !important;
  }
}

/* ===== BUTTONVERSE SIMPLE UI PATCH END ===== */
'@

Save-Utf8 $stylePath ($style.TrimEnd() + "`r`n" + $css)

Write-Host "2) Improving labels and text..."

$libraryPath = Join-Path $site "library.html"
$library = Read-Utf8 $libraryPath

$library = $library -replace 'Browse 1,000 copy-ready button ideas\.', 'Find a button. Copy the code.'
$library = $library -replace 'Only a small batch renders at once, so the page stays fast even with a thousand designs\.', 'Search, filter, preview, then copy HTML/CSS/JS.'
$library = $library -replace 'Random 60', 'Shuffle'
$library = $library -replace 'visible buttons', 'shown now'

Save-Utf8 $libraryPath $library

$indexPath = Join-Path $site "index.html"
$index = Read-Utf8 $indexPath

$index = $index -replace 'Buttonverse Lab\.', 'Button ideas, clean and ready.'
$index = $index -replace 'A new standalone site for button inspiration\. Different UI, different structure, different theme, and a fast library of 1,000 button concepts with source code\.', 'A separate button inspiration site with a clean lobby, simple library, dark/light theme, and copy-ready source code.'
$index = $index -replace 'Open Library', 'Browse Buttons'
$index = $index -replace 'How source works', 'Source Guide'

Save-Utf8 $indexPath $index

Write-Host ""
Write-Host "DONE:"
Write-Host "- UI simplified"
Write-Host "- dropdowns styled"
Write-Host "- filter area is cleaner"
Write-Host "- lobby/category cards are easier to understand"
Write-Host "- button cards are less confusing"
Write-Host "- backup saved here:"
Write-Host $backup
