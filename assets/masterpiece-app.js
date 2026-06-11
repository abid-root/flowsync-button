
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
