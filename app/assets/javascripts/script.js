var nav;
var items;
var burger;
var menu;

function show() {
    // Animate the popover
    dynamics.animate(nav, {
        opacity: 1,
        scale: 1
    }, {
        type: dynamics.spring,
        frequency: 200,
        friction: 270,
        duration: 800
    })

    // Animate each line individually
    for (var i = 0; i < items.length; i++) {
        var item = items[i]
        // Define initial properties
        dynamics.css(item, {
            opacity: 0,
            translateY: 20
        })

        // Animate to final properties
        dynamics.animate(item, {
            opacity: 1,
            translateY: 0
        }, {
            type: dynamics.spring,
            frequency: 300,
            friction: 435,
            duration: 1000,
            delay: 100 + i * 40
        })
    }
}

function hide() {
    // Animate the popover
    dynamics.animate(nav, {
        opacity: 0,
        scale: .1
    }, {
        type: dynamics.easeInOut,
        duration: 300,
        friction: 100
    })
}
document.addEventListener("DOMContentLoaded", function() {
    nav = document.querySelector('.dynamics-nav');
    items = document.querySelectorAll('.dynamics-li');
    if (document.getElementById("show-list") != null) {
        document.getElementById("show-list").onclick = function() {
            var elem = document.getElementById("show-list");
            var cla = document.getElementById("show-list").className.replace(/(?:^[\x09\x0A\x0C\x0D\x20]+)|(?:[\x09\x0A\x0C\x0D\x20]+$)/g, "").split(/[\x09\x0A\x0C\x0D\x20]+/);
            var result = cla.some(function(value) {
                return value === "is-active";
            });
            if (result) {
                hide();
            } else {
                show();
            }
            elem.classList.toggle('is-active');
        }
    };
    burger = document.querySelector('.burger');
    menu = document.querySelector('#' + burger.dataset.target);
    burger.addEventListener('click', function() {
        burger.classList.toggle('is-active');
        menu.classList.toggle('is-active');
    });
    $(function() {
        $("#scroll_bottom").click(function() {
            $('html, body').animate({
                scrollTop: $(document).height()
            }, 1000);
            return false;
        });
    });
});