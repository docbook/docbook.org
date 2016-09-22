var stopsopa = {
    pagehtml: document.getElementsByTagName("html")[0],
    pagebody: document.getElementsByTagName("body")[0],
    sopaText: "Stop SOPA",
    // change to whatever you want
    date: new Date(),
    blackout: function () {
        var pageAry = [stopsopa.pagehtml, stopsopa.pagebody],
            div = document.createElement("div"),
            text = document.createTextNode(stopsopa.sopaText),
            footer = document.createElement("a"),
            footerText = document.createTextNode("Why is this page missing?");
        console.log(pageAry)
        for (var i in pageAry) {
            pageAry[i].setAttribute("style", "background:white;height:100%;font-family:Arial, sans-serif;");
        }
        //stopsopa.pagebody.setAttribute("style", "background:white;height:100%;");
        div.setAttribute("style", "width:100%;text-align:center;font-size:130px;color:red;text-transform:uppercase;white-space:nowrap;font-family:arial, san-serif;font-weight:bold;background:black;padding:50px 20px;line-height:1.2em;position:absolute;top:50%;margin-top:-100px;");
        stopsopa.pagebody.innerHTML = "";
        footer.setAttribute("style", "background:black;color:yellow;font-size:15px;position:absolute;bottom:0;width:100%;text-align:center;display:block;padding:10px;");
        footer.setAttribute("href", "http://www.mozilla.org/sopa/");
        footer.setAttribute("target", "_blank");
        footer.appendChild(footerText);
        stopsopa.pagebody.appendChild(footer);
        div.appendChild(text);
        stopsopa.pagebody.appendChild(div);
    },
    actionDate: function () {
        if (stopsopa.date.getMonth() === 0 && stopsopa.date.getDate() === 18 && stopsopa.date.getYear() === 112) {
            stopsopa.blackout();
        }
    }
};
stopsopa.actionDate();
