(function () {
  const state = {
    all: window.FLOWSYNC_PHYSICAL_BUTTONS || [],
    category: "all",
    search: "",
    active: null,
    tab: "html"
  };

  const grid = document.getElementById("physicalGrid");
  const tabs = document.getElementById("physicalTabs");
  const search = document.getElementById("physicalSearch");
  const hero = document.getElementById("physicalHeroPreview");
  const dialog = document.getElementById("physicalSourceDialog");
  const dialogTitle = document.getElementById("physicalDialogTitle");
  const dialogPreview = document.getElementById("physicalDialogPreview");
  const codeBlock = document.getElementById("physicalCodeBlock");
  const copyCode = document.getElementById("physicalCopyCode");

  function esc(value) {
    return String(value).replace(/[&<>"']/g, function (m) {
      return ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#039;" })[m];
    });
  }

  function buttonMarkup(item) {
    return '<button class="fs-physical-btn ' + item.cls + '" type="button" aria-pressed="false">' +
      '<span class="pb-icon pb-off">' + item.iconOff + '</span>' +
      '<span class="pb-icon pb-on">' + item.iconOn + '</span>' +
      '<b class="pb-label pb-off">' + esc(item.off) + '</b>' +
      '<b class="pb-label pb-on">' + esc(item.on) + '</b>' +
    '</button>';
  }

  function bind(root) {
    root.querySelectorAll(".fs-physical-btn").forEach(function (button) {
      if (button.dataset.bound === "1") return;
      button.dataset.bound = "1";

      button.addEventListener("click", function () {
        const pressed = !button.classList.contains("is-pressed");
        button.classList.toggle("is-pressed", pressed);
        button.setAttribute("aria-pressed", pressed ? "true" : "false");

        button.animate(
          [
            { transform: pressed ? "translateY(0)" : "translateY(6px)" },
            { transform: "translateY(8px) scale(0.985)" },
            { transform: pressed ? "translateY(6px)" : "translateY(0)" }
          ],
          { duration: 180, easing: "ease-out" }
        );
      });
    });
  }

  function renderTabs() {
    tabs.innerHTML = '<button class="physical-tab active" type="button" data-category="all">All 30</button>' +
      window.FLOWSYNC_PHYSICAL_BUTTON_CATEGORIES.map(function (cat) {
        return '<button class="physical-tab" type="button" data-category="' + cat.id + '">' + esc(cat.title) + ' <small>' + cat.count + '</small></button>';
      }).join("");

    tabs.addEventListener("click", function (event) {
      const tab = event.target.closest(".physical-tab");
      if (!tab) return;
      state.category = tab.dataset.category;
      document.querySelectorAll(".physical-tab").forEach(function (item) {
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
    const picks = [state.all[0], state.all[6], state.all[13], state.all[17]].filter(Boolean);
    hero.innerHTML = picks.map(buttonMarkup).join("");
    bind(hero);
  }

  function renderGrid() {
    grid.innerHTML = filtered().map(function (item, index) {
      return '<article class="physical-card">' +
        '<div class="physical-card-top"><span>#' + String(index + 1).padStart(2, "0") + '</span><span>' + esc(item.title) + '</span></div>' +
        '<div class="physical-stage">' + buttonMarkup(item) + '</div>' +
        '<div class="physical-info"><div><h3>' + esc(item.title) + '</h3><p>' + esc(item.desc) + ' · ' + esc(item.off) + ' → ' + esc(item.on) + '</p></div>' +
        '<button class="physical-source-btn" type="button" data-id="' + item.id + '">Source</button></div>' +
      '</article>';
    }).join("");
    bind(grid);
  }

  function baseCss() {
    return `.fs-physical-btn {
  position: relative;
  isolation: isolate;
  border: 0;
  cursor: pointer;
  min-height: 54px;
  padding: 0 24px;
  border-radius: 18px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: .65em;
  color: #fff8ed;
  background: linear-gradient(180deg, var(--pb-a), color-mix(in srgb, var(--pb-a) 54%, black 26%));
  box-shadow:
    inset 0 1px 0 rgba(255,255,255,.32),
    inset 0 -10px 18px rgba(0,0,0,.22),
    0 8px 0 color-mix(in srgb, var(--pb-a) 42%, #050609 58%);
  transition: transform .12s ease, box-shadow .16s ease, background .22s ease;
}

.fs-physical-btn.is-pressed {
  transform: translateY(6px);
  background: linear-gradient(180deg, var(--pb-b), color-mix(in srgb, var(--pb-b) 58%, black 28%));
}`;
  }

  function source(item, tab) {
    if (tab === "html") return buttonMarkup(item).replaceAll("><", ">\n<");

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
      return baseCss() + "\n\n/* Specific style */\n" + (css || "/* See physical-buttons.css for full style. */");
    }

    return `document.querySelector(".${item.cls}")?.addEventListener("click", (event) => {
  const button = event.currentTarget;
  const pressed = !button.classList.contains("is-pressed");

  button.classList.toggle("is-pressed", pressed);
  button.setAttribute("aria-pressed", pressed ? "true" : "false");
});`;
  }

  function openSource(item) {
    state.active = item;
    state.tab = "html";
    dialogTitle.textContent = item.title;
    dialogPreview.innerHTML = buttonMarkup(item);
    bind(dialogPreview);
    document.querySelectorAll(".physical-code-tab").forEach(function (tab) {
      tab.classList.toggle("active", tab.dataset.tab === "html");
    });
    codeBlock.textContent = source(item, "html");
    dialog.showModal();
  }

  grid.addEventListener("click", function (event) {
    const btn = event.target.closest(".physical-source-btn");
    if (!btn) return;
    const item = state.all.find(function (entry) { return entry.id === btn.dataset.id; });
    if (item) openSource(item);
  });

  document.querySelector(".physical-code-tabs").addEventListener("click", function (event) {
    const tab = event.target.closest(".physical-code-tab");
    if (!tab || !state.active) return;
    state.tab = tab.dataset.tab;
    document.querySelectorAll(".physical-code-tab").forEach(function (item) {
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