
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */


document.addEventListener("DOMContentLoaded", function() {
    let url = '/data'
    let $container = document.querySelector('.container');
    let $CSRF_TOKEN = document.querySelector('meta[name="csrf-token"]')
                              .getAttribute('content');

    function generate_card(url, image, title) {
        return `<a href="${url}" target="_blank" class="card card-style card-hover-animation">
                              <div class="card-content">
                                <img class="card-image" src="${image}" alt="" />
                              </div>

                              <p class="card-title">${title}</p>
                            </a>`
    }

    headers = new Headers();
    headers.append('X-CSRF-TOKEN', $CSRF_TOKEN);

    fetch(url, {
            method: 'get',
            credentials: "same-origin",
            headers: headers
        })
        .then(res => res.json())
        .then((out) => out.filter((post) => post.tag.includes('[正妹]')))
        .then((out) => out.filter((post) => post.images[0].match(/\.(jpeg|jpg|gif|png)$/) != null))
        .then((beauties) => beauties.map((post) => generate_card(post.url, post.images[0], post.title)))
        .then((post_html) => $container.innerHTML += post_html.join(''))
        .catch(err => console.error(err));
});