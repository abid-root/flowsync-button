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