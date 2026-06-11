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
$backup = Join-Path (Split-Path $site -Parent) "buttonverse-lab-before-custom-dropdowns_$stamp"
Copy-Item $site $backup -Recurse -Force

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)

function Read-Utf8($p) {
  [System.IO.File]::ReadAllText($p, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
}

function Save-Utf8($p, $t) {
  [System.IO.File]::WriteAllText($p, $t, $script:utf8NoBom)
}

Write-Host "1) Creating custom dropdown script..."

$dropdownJs = @'
(function () {
  function initCustomSelects() {
    document.querySelectorAll("select").forEach(function (select) {
      if (select.dataset.bvCustomSelect === "ready") return;

      select.dataset.bvCustomSelect = "ready";
      select.classList.add("bv-native-select");

      var holder = document.createElement("div");
      holder.className = "bv-select";
      holder.tabIndex = 0;
      holder.setAttribute("role", "combobox");
      holder.setAttribute("aria-expanded", "false");

      var value = document.createElement("span");
      value.className = "bv-select-value";

      var arrow = document.createElement("span");
      arrow.className = "bv-select-arrow";
      arrow.setAttribute("aria-hidden", "true");

      var trigger = document.createElement("div");
      trigger.className = "bv-select-trigger";
      trigger.appendChild(value);
      trigger.appendChild(arrow);

      var menu = document.createElement("div");
      menu.className = "bv-select-menu";
      menu.setAttribute("role", "listbox");

      holder.appendChild(trigger);
      holder.appendChild(menu);

      if (select.parentElement && select.parentElement.tagName.toLowerCase() === "label") {
        select.parentElement.classList.add("has-bv-select");
      }

      select.insertAdjacentElement("afterend", holder);

      function selectedText() {
        var option = select.options[select.selectedIndex];
        return option ? option.textContent.trim() : "Select";
      }

      function close() {
        holder.classList.remove("is-open");
        holder.setAttribute("aria-expanded", "false");
      }

      function open() {
        document.querySelectorAll(".bv-select.is-open").forEach(function (item) {
          if (item !== holder) {
            item.classList.remove("is-open");
            item.setAttribute("aria-expanded", "false");
          }
        });

        holder.classList.add("is-open");
        holder.setAttribute("aria-expanded", "true");
      }

      function toggle() {
        if (holder.classList.contains("is-open")) close();
        else open();
      }

      function rebuild() {
        value.textContent = selectedText();
        menu.innerHTML = "";

        Array.prototype.forEach.call(select.options, function (option) {
          var item = document.createElement("button");
          item.type = "button";
          item.className = "bv-select-option";
          item.setAttribute("role", "option");
          item.dataset.value = option.value;
          item.textContent = option.textContent.trim();

          if (option.selected) {
            item.classList.add("is-selected");
            item.setAttribute("aria-selected", "true");
          } else {
            item.setAttribute("aria-selected", "false");
          }

          item.addEventListener("click", function (event) {
            event.preventDefault();
            event.stopPropagation();

            select.value = option.value;
            select.dispatchEvent(new Event("change", { bubbles: true }));
            rebuild();
            close();
          });

          menu.appendChild(item);
        });
      }

      trigger.addEventListener("click", function (event) {
        event.preventDefault();
        event.stopPropagation();
        toggle();
      });

      holder.addEventListener("keydown", function (event) {
        var options = Array.prototype.slice.call(menu.querySelectorAll(".bv-select-option"));
        var current = options.findIndex(function (item) { return item.classList.contains("is-selected"); });

        if (event.key === "Enter" || event.key === " ") {
          event.preventDefault();
          if (!holder.classList.contains("is-open")) open();
        }

        if (event.key === "Escape") {
          close();
        }

        if (event.key === "ArrowDown" || event.key === "ArrowUp") {
          event.preventDefault();
          if (!holder.classList.contains("is-open")) open();

          var next = current;
          if (event.key === "ArrowDown") next = Math.min(options.length - 1, current + 1);
          if (event.key === "ArrowUp") next = Math.max(0, current - 1);
          if (next < 0) next = 0;

          if (options[next]) {
            select.value = options[next].dataset.value;
            select.dispatchEvent(new Event("change", { bubbles: true }));
            rebuild();
          }
        }
      });

      select.addEventListener("change", rebuild);

      var observer = new MutationObserver(rebuild);
      observer.observe(select, { childList: true, subtree: true, attributes: true });

      rebuild();
    });
  }

  document.addEventListener("click", function () {
    document.querySelectorAll(".bv-select.is-open").forEach(function (item) {
      item.classList.remove("is-open");
      item.setAttribute("aria-expanded", "false");
    });
  });

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initCustomSelects);
  } else {
    initCustomSelects();
  }

  window.addEventListener("load", initCustomSelects);
})();
'@

$assetsDir = Join-Path $site "assets"
Save-Utf8 (Join-Path $assetsDir "custom-dropdowns.js") $dropdownJs

Write-Host "2) Loading custom dropdown script into HTML pages..."

Get-ChildItem -Path $site -File -Filter "*.html" | ForEach-Object {
  $html = Read-Utf8 $_.FullName

  $html = [regex]::Replace(
    $html,
    '(?im)^\s*<script[^>]+assets/custom-dropdowns\.js[^>]*></script>\s*',
    ''
  )

  $tag = '  <script src="assets/custom-dropdowns.js?v=' + $stamp + '"></script>'

  if ($html -match 'assets/app\.js') {
    $html = [regex]::Replace(
      $html,
      '(?im)(^\s*<script[^>]+assets/app\.js[^>]*></script>\s*)',
      ('$1' + $tag + "`r`n"),
      1
    )
  } else {
    $html = $html -replace '(?i)</body>', "$tag`r`n</body>"
  }

  Save-Utf8 $_.FullName $html
}

Write-Host "3) Adding custom dropdown CSS..."

$stylePath = Join-Path $site "assets\styles.css"
$style = Read-Utf8 $stylePath

$style = [regex]::Replace(
  $style,
  '(?s)\r?\n?/\* ===== BUTTONVERSE CUSTOM DROPDOWNS START ===== \*/.*?/\* ===== BUTTONVERSE CUSTOM DROPDOWNS END ===== \*/',
  ''
)

$css = @'

/* ===== BUTTONVERSE CUSTOM DROPDOWNS START ===== */

/* Hide browser default select completely */
.bv-native-select {
  display: none !important;
}

/* Keep label as custom input box */
.has-bv-select {
  overflow: visible !important;
}

.bv-select {
  position: relative !important;
  width: 100% !important;
  margin-top: 2px !important;
  user-select: none !important;
  z-index: 30 !important;
}

.bv-select-trigger {
  position: relative !important;
  min-height: 32px !important;
  display: flex !important;
  align-items: center !important;
  justify-content: space-between !important;
  gap: 12px !important;
  color: var(--text) !important;
  font-size: .98rem !important;
  font-weight: 950 !important;
  line-height: 1.1 !important;
  cursor: pointer !important;
}

.bv-select-value {
  display: block !important;
  min-width: 0 !important;
  overflow: hidden !important;
  text-overflow: ellipsis !important;
  white-space: nowrap !important;
}

.bv-select-arrow {
  width: 10px !important;
  height: 10px !important;
  flex: 0 0 auto !important;
  border-right: 2px solid var(--muted) !important;
  border-bottom: 2px solid var(--muted) !important;
  transform: rotate(45deg) translateY(-2px) !important;
  transition: transform 160ms ease, border-color 160ms ease !important;
}

.bv-select.is-open .bv-select-arrow {
  transform: rotate(225deg) translate(-2px, -2px) !important;
  border-color: var(--accent-2) !important;
}

.bv-select-menu {
  position: absolute !important;
  left: -13px !important;
  right: -13px !important;
  top: calc(100% + 13px) !important;
  z-index: 9999 !important;
  max-height: 290px !important;
  overflow: auto !important;
  padding: 8px !important;
  border: 1px solid color-mix(in srgb, var(--accent-2) 30%, var(--line)) !important;
  border-radius: 18px !important;
  background: color-mix(in srgb, var(--surface) 94%, var(--bg)) !important;
  backdrop-filter: blur(22px) saturate(145%) !important;
  box-shadow: 0 22px 70px var(--shadow) !important;
  opacity: 0 !important;
  transform: translateY(-8px) scale(.98) !important;
  pointer-events: none !important;
  transition: opacity 150ms ease, transform 150ms ease !important;
  scrollbar-width: thin !important;
  scrollbar-color: color-mix(in srgb, var(--accent-2) 45%, var(--muted)) transparent !important;
}

.bv-select.is-open .bv-select-menu {
  opacity: 1 !important;
  transform: translateY(0) scale(1) !important;
  pointer-events: auto !important;
}

.bv-select-option {
  width: 100% !important;
  min-height: 38px !important;
  border: 0 !important;
  border-radius: 12px !important;
  display: flex !important;
  align-items: center !important;
  justify-content: flex-start !important;
  padding: 9px 11px !important;
  background: transparent !important;
  color: var(--muted) !important;
  font: inherit !important;
  font-size: .92rem !important;
  font-weight: 850 !important;
  text-align: left !important;
  cursor: pointer !important;
  transition: background 130ms ease, color 130ms ease, transform 130ms ease !important;
}

.bv-select-option:hover {
  color: var(--text) !important;
  background: color-mix(in srgb, var(--accent) 12%, transparent) !important;
  transform: translateX(3px) !important;
}

.bv-select-option.is-selected {
  color: #11100d !important;
  background: linear-gradient(135deg, var(--accent), var(--accent-2)) !important;
  font-weight: 1000 !important;
}

/* Make dropdown appear above cards */
.filter-dock {
  overflow: visible !important;
}

.filter-dock label {
  overflow: visible !important;
}

/* Mobile dropdown is still controlled and not huge */
@media (max-width: 660px) {
  .bv-select-menu {
    max-height: 240px !important;
    left: -10px !important;
    right: -10px !important;
  }

  .bv-select-option {
    min-height: 36px !important;
    font-size: .88rem !important;
  }
}

/* ===== BUTTONVERSE CUSTOM DROPDOWNS END ===== */
'@

Save-Utf8 $stylePath ($style.TrimEnd() + "`r`n" + $css)

Write-Host "4) Syntax check..."

$node = Get-Command node -ErrorAction SilentlyContinue
if ($node) {
  node --check (Join-Path $site "assets\custom-dropdowns.js") | Out-Null
  node --check (Join-Path $site "assets\app.js") | Out-Null
}

Write-Host ""
Write-Host "DONE:"
Write-Host "- removed native/default dropdown look"
Write-Host "- added custom styled dropdown UI"
Write-Host "- category and style dropdown both fixed"
Write-Host "- backup saved here:"
Write-Host $backup
