<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('index');
});

Route::get('/data', function() {
    $path = storage_path() . "/json/data.json"; // ie: /var/www/laravel/app/storage/json/filename.json
    $json = json_decode(file_get_contents($path), true);
    return $json;
});
