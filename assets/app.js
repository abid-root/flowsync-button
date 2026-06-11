
const App = {
  buttons: [],
  filtered: [],
  shown: 0,
  pageSize: 60,
  category: "all",
  style: "all",
  search: "",
  activeButton: null,
  activeTab: "html"
};

function $(q, root = document) { return root.querySelector(q); }
function $all(q, root = document) { return [...root.querySelectorAll(q)]; }

function escapeHtml(value) {
  return String(value).replace(/[&<>"']/g, (m) => ({
    "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#039;"
  }[m]));
}

function setTheme(theme) {
  document.documentElement.setAttribute("data-theme", theme);
  localStorage.setItem("buttonverse-theme", theme);
}

function initTheme() {
  const saved = localStorage.getItem("buttonverse-theme"); if (saved === "light" || saved === "dark") setTheme(saved); else setTheme("dark");
  const toggle = $("#themeToggle");
  if (!toggle) return;
  toggle.addEventListener("click", () => {
    setTheme(document.documentElement.getAttribute("data-theme") === "light" ? "dark" : "light");
  });
}

function btnClass(btn) {
  return [
    "bv-btn",
    `family-${btn.family}`,
    `motion-${btn.motion}`,
    `shape-${btn.shape}`,
    `pattern-${btn.pattern}`
  ].join(" ");
}

function btnStyle(btn) {
  return `--hue:${btn.hue};--hue2:${btn.hue2};--weight:${btn.weight}`;
}

function renderButton(btn) {
  return `<button class="${btnClass(btn)}" style="${btnStyle(btn)}"><span>${btn.icon}</span><b>${escapeHtml(btn.label)}</b></button>`;
}

function renderLobby() {
  const map = $("#categoryMap");
  if (!map) return;
  map.innerHTML = BUTTONVERSE_CATEGORIES.map((cat) => `
    <a class="category-card" href="library.html?category=${cat.id}">
      <span class="icon">${cat.icon}</span>
      <small>${cat.count} buttons</small>
      <h3>${escapeHtml(cat.title)}</h3>
      <p>${escapeHtml(cat.desc)}</p>
    </a>
  `).join("");
}

function hydrateFilters() {
  const select = $("#categorySelect");
  if (!select) return;

  select.innerHTML = `<option value="all">All categories</option>` + BUTTONVERSE_CATEGORIES.map((cat) => (
    `<option value="${cat.id}">${escapeHtml(cat.title)}</option>`
  )).join("");

  const params = new URLSearchParams(location.search);
  const startCat = params.get("category");
  if (startCat && BUTTONVERSE_CATEGORIES.some((cat) => cat.id === startCat)) {
    App.category = startCat;
    select.value = startCat;
  }
}

function styleMatches(btn) {
  if (App.style === "all") return true;
  if (App.style === "minimal") return ["outline","wire","stamp","label","mono","calm"].includes(btn.family);
  if (App.style === "depth") return ["depth","brutal","paper","bevel","deck"].includes(btn.family);
  return btn.family === App.style || btn.motion.includes(App.style);
}

function applyFilters() {
  const q = App.search.trim().toLowerCase();
  App.filtered = App.buttons.filter((btn) => {
    const catOk = App.category === "all" || btn.category === App.category;
    const styleOk = styleMatches(btn);
    const text = `${btn.label} ${btn.name} ${btn.categoryTitle} ${btn.family} ${btn.motion} ${btn.shape}`.toLowerCase();
    return catOk && styleOk && (!q || text.includes(q));
  });

  App.shown = 0;
  const grid = $("#buttonGrid");
  if (grid) grid.innerHTML = "";
  renderMore();
}

function renderMore() {
  const grid = $("#buttonGrid");
  if (!grid) return;

  const next = App.filtered.slice(App.shown, App.shown + App.pageSize);
  const frag = document.createDocumentFragment();

  next.forEach((btn) => {
    const card = document.createElement("article");
    card.className = "button-card";
    card.innerHTML = `
      <div class="card-meta">
        <span>#${String(btn.number).padStart(4, "0")}</span>
        <span>${escapeHtml(btn.categoryTitle)}</span>
      </div>
      <div class="stage">${renderButton(btn)}</div>
      <div class="card-bottom">
        <div>
          <strong>${escapeHtml(btn.name)}</strong>
          <small>${btn.family} · ${btn.motion}</small>
        </div>
        <button class="source-btn" type="button" data-id="${btn.id}">Source</button>
      </div>
    `;
    frag.appendChild(card);
  });

  grid.appendChild(frag);
  App.shown += next.length;

  const visible = $("#visibleCount");
  const pager = $("#pagerText");
  const load = $("#loadMoreBtn");
  if (visible) visible.textContent = Math.min(App.shown, App.filtered.length);
  if (pager) pager.textContent = `${App.filtered.length} matching buttons`;
  if (load) load.hidden = App.shown >= App.filtered.length;
}

function randomize() {
  const pool = [...App.buttons];
  for (let i = pool.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1));
    [pool[i], pool[j]] = [pool[j], pool[i]];
  }
  App.filtered = pool.slice(0, 60);
  App.shown = 0;
  $("#buttonGrid").innerHTML = "";
  $("#searchInput").value = "";
  $("#categorySelect").value = "all";
  $("#styleSelect").value = "all";
  App.search = "";
  App.category = "all";
  App.style = "all";
  renderMore();
}

function initLibrary() {
  if (!$("#buttonGrid")) return;

  hydrateFilters();
  applyFilters();

  $("#searchInput").addEventListener("input", (event) => {
    App.search = event.target.value;
    applyFilters();
  });
  $("#categorySelect").addEventListener("change", (event) => {
    App.category = event.target.value;
    applyFilters();
  });
  $("#styleSelect").addEventListener("change", (event) => {
    App.style = event.target.value;
    applyFilters();
  });
  $("#loadMoreBtn").addEventListener("click", renderMore);
  $("#randomBtn").addEventListener("click", randomize);

  $("#buttonGrid").addEventListener("click", (event) => {
    const source = event.target.closest(".source-btn");
    if (!source) return;
    const btn = App.buttons.find((item) => item.id === source.dataset.id);
    if (btn) openSource(btn);
  });

  initSourceDialog();
}

function openSource(btn) {
  App.activeButton = btn;
  App.activeTab = "html";
  $("#dialogTitle").textContent = btn.name;
  $("#dialogPreview").innerHTML = renderButton(btn);
  $all(".code-tab").forEach((tab) => tab.classList.toggle("active", tab.dataset.tab === "html"));
  $("#codeBlock").textContent = sourceCode(btn, "html");
  $("#sourceDialog").showModal();
}

function sourceCode(btn, tab) {
  const custom = `button-${btn.id}`;
  if (tab === "html") {
    return `<button class="bv-btn ${custom}">
  <span>${btn.icon}</span>
  <b>${escapeHtml(btn.label)}</b>
</button>`;
  }

  if (tab === "js") {
    return `document.querySelector(".${custom}")?.addEventListener("click", (event) => {
  event.currentTarget.animate(
    [
      { transform: "scale(1)" },
      { transform: "scale(0.96)" },
      { transform: "scale(1)" }
    ],
    { duration: 220, easing: "ease-out" }
  );
});`;
  }

  return `.bv-btn {
  --hue: ${btn.hue};
  --hue2: ${btn.hue2};
  --weight: ${btn.weight};
  --c1: hsl(var(--hue) 88% 60%);
  --c2: hsl(var(--hue2) 88% 62%);
  position: relative;
  isolation: isolate;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: .62em;
  min-height: 48px;
  padding: 0 22px;
  border: 0;
  cursor: pointer;
  overflow: hidden;
  font: 950 .92rem/1 ui-sans-serif, system-ui, sans-serif;
  transition: transform .18s ease, filter .18s ease, box-shadow .18s ease;
}

.${custom} {
  ${btnStyle(btn).replaceAll(";", ";\n  ")}
  border-radius: ${radius(btn.shape)};
  background: ${familyBackground(btn.family)};
  color: ${btn.family === "outline" || btn.family === "wire" ? "var(--c1)" : "#fffaf0"};
}

.${custom}:hover {
  transform: translateY(-3px) scale(1.02);
  ${motionCSS(btn.motion)}
}`;
}

function radius(shape) {
  return ({
    pill:"999px", squircle:"23px 13px", slant:"12px", ticket:"999px 16px 999px 16px",
    tab:"18px 18px 7px 7px", cut:"0", round:"28px", square:"8px", capsule:"26px", notch:"0"
  })[shape] || "16px";
}

function familyBackground(family) {
  if (family === "glass") return "linear-gradient(135deg, color-mix(in srgb,var(--c1) 28%,transparent), color-mix(in srgb,var(--c2) 18%,transparent))";
  if (family === "outline" || family === "wire" || family === "stamp") return "transparent";
  if (family === "terminal") return "#080b0a";
  if (family === "paper") return "#f2dfc3";
  if (family === "mono") return "#fffaf0";
  return "linear-gradient(135deg, var(--c1), var(--c2))";
}

function motionCSS(motion) {
  if (motion === "shine-pass") return "filter: brightness(1.08);";
  if (motion === "press-down") return "transform: translateY(3px) scale(.99);";
  if (motion === "magnet-pull") return "letter-spacing: .055em;";
  if (motion === "halo-grow") return "box-shadow: 0 0 0 7px color-mix(in srgb,var(--c1) 18%,transparent);";
  if (motion === "liquid-swell") return "border-radius: 38% 62% 45% 55% / 52% 36% 64% 48%;";
  return "filter: saturate(1.08) brightness(1.04);";
}

function initSourceDialog() {
  const dialog = $("#sourceDialog");
  if (!dialog) return;

  $(".code-toolbar").addEventListener("click", async (event) => {
    const tab = event.target.closest(".code-tab");
    if (!tab || !App.activeButton) return;
    App.activeTab = tab.dataset.tab;
    $all(".code-tab").forEach((item) => item.classList.toggle("active", item === tab));
    $("#codeBlock").textContent = sourceCode(App.activeButton, App.activeTab);
  });

  $("#copyCode").addEventListener("click", async () => {
    if (!App.activeButton) return;
    await navigator.clipboard.writeText(sourceCode(App.activeButton, App.activeTab));
    $("#copyCode").textContent = "Copied";
    setTimeout(() => $("#copyCode").textContent = "Copy", 850);
  });
}

function init() {
  initTheme();
  App.buttons = BUTTONVERSE_BUILD();
  App.filtered = App.buttons;
  renderLobby();
  initLibrary();
}

init();
