"use strict";

function ready(handler) {
  window.addEventListener('load', handler);
}

function on(object, action, handler) {
  object.addEventListener(action, handler);
}

function $(selector) {
  return document.querySelector(selector);
}
