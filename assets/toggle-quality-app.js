(function () {
  const state = {
    all: window.FLOWSYNC_QUALITY_TOGGLES || [],
    category: "all",
    search: "",
    active: null,
    tab: "html"
  };

  const grid = document.getElementById("toggleGrid");
  const tabs = document.getElementById("toggleTabs");
  const search = document.getElementById("toggleSearch");
  const hero = document.getElementById("toggleHeroPreview");
  const dialog = document.getElementById("toggleSourceDialog");
  const dialogTitle = document.getElementById("toggleDialogTitle");
  const dialogPreview = document.getElementById("toggleDialogPreview");
  const codeBlock = document.getElementById("toggleCodeBlock");
  const copyCode = document.getElementById("toggleCopyCode");

  function esc(value) {
    return String(value).replace(/[&<>"']/g, function (m) {
      return ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#039;" })[m];
    });
  }

  function toggleMarkup(item) {
    return '<button class="fs-quality-toggle ' + item.cls + '" type="button" aria-pressed="false">' +
      '<span class="qt-track">' +
        '<span class="qt-off-icon">' + item.iconOff + '</span>' +
        '<span class="qt-on-icon">' + item.iconOn + '</span>' +
        '<span class="qt-knob"></span>' +
      '</span>' +
      '<span class="qt-text">' +
        '<b class="qt-off-text">' + esc(item.off) + '</b>' +
        '<b class="qt-on-text">' + esc(item.on) + '</b>' +
      '</span>' +
    '</button>';
  }

  function bind(root) {
    root.querySelectorAll(".fs-quality-toggle").forEach(function (toggle) {
      if (toggle.dataset.bound === "1") return;
      toggle.dataset.bound = "1";
      toggle.addEventListener("click", function () {
        const on = !toggle.classList.contains("is-on");
        toggle.classList.toggle("is-on", on);
        toggle.setAttribute("aria-pressed", on ? "true" : "false");
      });
    });
  }

  function renderTabs() {
    tabs.innerHTML = '<button class="toggle-tab active" type="button" data-category="all">All 30</button>' +
      window.FLOWSYNC_QUALITY_TOGGLE_CATEGORIES.map(function (cat) {
        return '<button class="toggle-tab" type="button" data-category="' + cat.id + '">' + esc(cat.title) + ' <small>' + cat.count + '</small></button>';
      }).join("");

    tabs.addEventListener("click", function (event) {
      const tab = event.target.closest(".toggle-tab");
      if (!tab) return;
      state.category = tab.dataset.category;
      document.querySelectorAll(".toggle-tab").forEach(function (item) {
        item.classList.toggle("active", item === tab);
      });
      renderGrid();
    });
  }

  function filtered() {
    const q = state.search.trim().toLowerCase();
    return state.all.filter(function (item) {
      const catOk = state.category === "all" || item.category === state.category;
      const text = [item.title, item.desc, item.off, item.on, item.cls].join(" ").toLowerCase();
      return catOk && (!q || text.includes(q));
    });
  }

  function renderHero() {
    const picks = [state.all[0], state.all[6], state.all[11], state.all[16]].filter(Boolean);
    hero.innerHTML = picks.map(toggleMarkup).join("");
    bind(hero);
  }

  function renderGrid() {
    grid.innerHTML = filtered().map(function (item, index) {
      return '<article class="toggle-card">' +
        '<div class="toggle-card-top"><span>#' + String(index + 1).padStart(2, "0") + '</span><span>' + esc(item.title) + '</span></div>' +
        '<div class="toggle-stage">' + toggleMarkup(item) + '</div>' +
        '<div class="toggle-info"><div><h3>' + esc(item.title) + '</h3><p>' + esc(item.desc) + ' · ' + esc(item.off) + ' → ' + esc(item.on) + '</p></div>' +
        '<button class="toggle-source-btn" type="button" data-id="' + item.id + '">Source</button></div>' +
      '</article>';
    }).join("");
    bind(grid);
  }

  function baseCss() {
    return `.fs-quality-toggle {
  position: relative;
  isolation: isolate;
  border: 0;
  background: transparent;
  display: inline-flex;
  align-items: center;
  gap: 13px;
  cursor: pointer;
  font: 950 .9rem/1 ui-sans-serif, system-ui, sans-serif;
}

.qt-track {
  position: relative;
  width: 88px;
  height: 42px;
  display: flex;
  align-items: center;
  padding: 4px;
  border-radius: 999px;
  overflow: hidden;
  transition: background .25s ease, box-shadow .25s ease, border-color .25s ease;
}

.qt-knob {
  position: absolute;
  left: 4px;
  top: 50%;
  width: 34px;
  height: 34px;
  border-radius: 999px;
  transform: translate3d(0, -50%, 0);
  transition: transform .28s cubic-bezier(.18,.9,.2,1);
}

.fs-quality-toggle.is-on .qt-knob {
  transform: translate3d(calc(88px - 34px - 8px), -50%, 0);
}`;
  }

  function source(item, tab) {
    if (tab === "html") return toggleMarkup(item).replaceAll("><", ">\n<");
    if (tab === "css") {
      const styleSheets = Array.from(document.styleSheets);
      let css = "";
      styleSheets.forEach(function (sheet) {
        try {
          Array.from(sheet.cssRules || []).forEach(function (rule) {
            if (rule.cssText && rule.cssText.includes("." + item.cls)) css += rule.cssText + "\n\n";
          });
        } catch (e) {}
      });
      return baseCss() + "\n\n/* Specific style */\n" + (css || "/* See toggle-lab-quality.css for full style. */");
    }
    return `document.querySelector(".${item.cls}")?.addEventListener("click", (event) => {
  const toggle = event.currentTarget;
  const on = !toggle.classList.contains("is-on");
  toggle.classList.toggle("is-on", on);
  toggle.setAttribute("aria-pressed", on ? "true" : "false");
});`;
  }

  function openSource(item) {
    state.active = item;
    state.tab = "html";
    dialogTitle.textContent = item.title;
    dialogPreview.innerHTML = toggleMarkup(item);
    bind(dialogPreview);
    document.querySelectorAll(".toggle-code-tab").forEach(function (tab) {
      tab.classList.toggle("active", tab.dataset.tab === "html");
    });
    codeBlock.textContent = source(item, "html");
    dialog.showModal();
  }

  grid.addEventListener("click", function (event) {
    const btn = event.target.closest(".toggle-source-btn");
    if (!btn) return;
    const item = state.all.find(function (entry) { return entry.id === btn.dataset.id; });
    if (item) openSource(item);
  });

  document.querySelector(".toggle-code-tabs").addEventListener("click", function (event) {
    const tab = event.target.closest(".toggle-code-tab");
    if (!tab || !state.active) return;
    state.tab = tab.dataset.tab;
    document.querySelectorAll(".toggle-code-tab").forEach(function (item) {
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