// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//= require jquery-ui

//$(function() {
//    $("#date").datepicker();
//});

//
//$(document).ready(function(ev) {
//  $("#date").datepicker();
//});

function ajax_loader(div, url, pars, image){
    $(image).show();
    new Ajax.Updater(div, url, {
        method: 'get',
        parameters: pars,
        asynchronous: true,
        evalScripts: true,
        onComplete: function(request){
            $(image).hide()
        },
        onFailure: function(request){
            alert('Error occured')
        },
        onSuccess: function(request){
            $(div).visualEffect('highlight')
        }
    });
}