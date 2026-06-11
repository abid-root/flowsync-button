$ErrorActionPreference = "Stop"

# Run inside either:
# 1) flowsync-button-site
# 2) flowsync-button-site\buttonverse-lab

$start = (Get-Location).Path

if ((Test-Path ".\buttonverse-lab\index.html") -and (Test-Path ".\buttonverse-lab\assets\app.js")) {
  $site = Join-Path $start "buttonverse-lab"
} elseif ((Test-Path ".\index.html") -and (Test-Path ".\assets\app.js") -and (Test-Path ".\library.html")) {
  $site = $start
} else {
  throw "Wrong folder. Run inside flowsync-button-site or inside buttonverse-lab."
}

$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backup = Join-Path (Split-Path $site -Parent) "buttonverse-lab-before-lobby-masterpiece-card-fix_$stamp"
Copy-Item $site $backup -Recurse -Force

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)

function Read-Utf8($p) {
  [System.IO.File]::ReadAllText($p, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
}

function Save-Utf8($p, $t) {
  [System.IO.File]::WriteAllText($p, $t, $script:utf8NoBom)
}

Write-Host "1) Removing misplaced static Masterpiece card from lobby..."

$indexPath = Join-Path $site "index.html"
$index = Read-Utf8 $indexPath

# Remove the card if it was inserted outside the category grid.
$index = [regex]::Replace(
  $index,
  '(?is)\s*<a\s+class=["'']category-card masterpiece-card-link["''][\s\S]*?</a>\s*',
  "`r`n"
)

Save-Utf8 $indexPath $index

Write-Host "2) Creating safe lobby card injector..."

$lobbyFixJs = @'
(function () {
  function addMasterpieceCard() {
    var grid = document.getElementById("categoryMap");
    if (!grid) return;

    document.querySelectorAll(".masterpiece-card-link").forEach(function (card) {
      if (!grid.contains(card)) card.remove();
    });

    if (grid.querySelector(".masterpiece-card-link")) return;

    var card = document.createElement("a");
    card.className = "category-card masterpiece-card-link";
    card.href = "masterpieces/index.html";
    card.innerHTML = [
      '<span class="icon">✦</span>',
      '<small>100 buttons</small>',
      '<h3>Masterpiece Set</h3>',
      '<p>Curated premium buttons kept separate from the mass library.</p>'
    ].join("");

    grid.appendChild(card);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", addMasterpieceCard);
  } else {
    addMasterpieceCard();
  }

  window.addEventListener("load", function () {
    setTimeout(addMasterpieceCard, 60);
    setTimeout(addMasterpieceCard, 180);
  });
})();
'@

Save-Utf8 (Join-Path $site "assets\lobby-masterpiece-fix.js") $lobbyFixJs

Write-Host "3) Loading lobby fix only in index.html..."

$index = Read-Utf8 $indexPath

$index = [regex]::Replace(
  $index,
  '(?im)^\s*<script[^>]+assets/lobby-masterpiece-fix\.js[^>]*></script>\s*',
  ''
)

$tag = '  <script src="assets/lobby-masterpiece-fix.js?v=' + $stamp + '"></script>'

if ($index -match 'assets/app\.js') {
  $index = [regex]::Replace(
    $index,
    '(?im)(^\s*<script[^>]+assets/app\.js[^>]*></script>\s*)',
    ('$1' + $tag + "`r`n"),
    1
  )
} else {
  $index = $index -replace '(?i)</body>', "$tag`r`n</body>"
}

Save-Utf8 $indexPath $index

Write-Host "4) Adding CSS guard so the card always stays inside the grid..."

$stylePath = Join-Path $site "assets\styles.css"
$style = Read-Utf8 $stylePath

$style = [regex]::Replace(
  $style,
  '(?s)\r?\n?/\* ===== LOBBY MASTERPIECE CARD FIX START ===== \*/.*?/\* ===== LOBBY MASTERPIECE CARD FIX END ===== \*/',
  ''
)

$css = @'

/* ===== LOBBY MASTERPIECE CARD FIX START ===== */

/* Masterpiece card should behave exactly like the other lobby category cards */
#categoryMap .masterpiece-card-link {
  position: relative !important;
  inset: auto !important;
  width: auto !important;
  margin: 0 !important;
  transform: none;
}

/* If any old card is accidentally outside the category grid, hide it */
.category-map > .masterpiece-card-link,
.lobby-shell > .masterpiece-card-link {
  display: none !important;
}

/* Slight premium border for the Masterpiece card */
#categoryMap .masterpiece-card-link {
  border-color: color-mix(in srgb, var(--accent) 38%, var(--line)) !important;
  background:
    radial-gradient(circle at 20% 15%, color-mix(in srgb, var(--accent) 12%, transparent), transparent 150px),
    var(--surface) !important;
}

/* ===== LOBBY MASTERPIECE CARD FIX END ===== */
'@

Save-Utf8 $stylePath ($style.TrimEnd() + "`r`n" + $css)

Write-Host "5) Syntax check..."

$node = Get-Command node -ErrorAction SilentlyContinue
if ($node) {
  node --check (Join-Path $site "assets\lobby-masterpiece-fix.js") | Out-Null
}

Write-Host ""
Write-Host "DONE:"
Write-Host "- removed the broken/misplaced Masterpiece card"
Write-Host "- added Masterpiece Set inside the correct lobby grid"
Write-Host "- kept the Masterpieces page/folder"
Write-Host "- backup saved here:"
Write-Host $backup
