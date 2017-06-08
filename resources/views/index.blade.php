<!doctype html>
<html lang="{{ app()->getLocale() }}">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Laravel</title>

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,600" rel="stylesheet" type="text/css">

        <!-- Styles -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.css">
        <style>
            html, body {
                color: #636b6f;
                font-family: 'Raleway', sans-serif;
                background-color: #566;
            }

            .card {
                display: inline-flex;
                flex-direction: column;
                overflow: hidden;
                max-width: 280px;
                margin: 40px auto 20px;
            }

            .card-style {
                background-color: white;
                border-radius: 4px;
                color: #636b6f;
                text-decoration: none;
            }

            .card-hover-animation {
                -webkit-transition: box-shadow 0.5s;
                -moz-transition: box-shadow 0.5s;
                -ms-transition: box-shadow 0.5s;
                -o-transition: box-shadow 0.5s;
                transition: box-shadow 0.5s;
                box-shadow: 1px 1px 1px darkslategray;
            }

            .card-hover-animation:hover {
                box-shadow: 4px 8px 8px darkslategray;
            }

            .container {
                display: flex;
                flex-wrap: wrap;
                flex-direction: column;
                justify-content: space-between;
            }

            .card:active, .card:visited {
                background-color: #855;
            }

            .card:active .card-title,
            .card:visited .card-title{
                color: white;
            }

            .card-title {
                word-wrap: break-word;
                padding: 5px 10px;
            }

            .card-content .card-image {
                width: 100%;
                height: auto;
                overflow: auto;
                overflow-wrap: break-word;
                background-color: gray;
            }
        </style>
    </head>
    <body>
        <div class="container">

        </div>

        <script type="application/javascript">
            window.onload = function() {
                let url = '/data'
                let $container = document.querySelector('.container');

                function generate_card(url, image, title) {
                    return `<a href="${url}" target="_blank" class="card card-style card-hover-animation">
                              <div class="card-content">
                                <img class="card-image" src="${image}" alt="" />
                              </div>

                              <p class="card-title">${title}</p>
                            </a>`
                }

                fetch(url)
                    .then(res => res.json())
                    .then((out) => out.filter((post) => post.tag.includes('[正妹]')))
                    .then((out) => out.filter((post) => post.images[0].match(/\.(jpeg|jpg|gif|png)$/) != null))
                    .then((beauties) => beauties.map((post) => generate_card(post.url, post.images[0], post.title)))
                    .then((post_html) => $container.innerHTML += post_html.join(''))
                    .catch(err => console.error(err));
            }
        </script>
    </body>
</html>
