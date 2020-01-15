window.addEventListener("beforeunload", function() { 
    localStorage.setItem("sidebar_scroll", document.getElementsByClassName("sidebar")[0].scrollTop); 
});

if (localStorage.getItem("sidebar_scroll")){ 
    y = localStorage.getItem("sidebar_scroll");
    document.getElementsByClassName("sidebar")[0].scrollTop = y;
  }