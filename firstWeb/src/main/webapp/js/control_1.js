function getTime() {
    var time = new Date();
    var hour = time.getHours();
    var minute = time.getMinutes();
    var second = time.getSeconds();
    if(hour < 10) hour = "0" + hour;
    if(minute < 10) minute = "0" + minute;
    if(second < 10) second = "0" + second;
    document.getElementById("clk").innerHTML = "" + hour + ":" + minute + ":" +second;
    if(hour > 0 && hour < 12) document.getElementById("wel").innerHTML = "早上好";
    else if(hour >= 12 && hour < 18) document.getElementById("wel").innerHTML = "下午好";
    else document.getElementById("wel").innerHTML = "晚上好";
    setTimeout("getTime()", 1000);
}

/* global bootstrap: false */
(function () {
    'use strict'
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    tooltipTriggerList.forEach(function (tooltipTriggerEl) {
        new bootstrap.Tooltip(tooltipTriggerEl)
    })
})()
