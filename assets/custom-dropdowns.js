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