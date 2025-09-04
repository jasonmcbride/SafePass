// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import { initFlowbite } from "flowbite";

// run once on initial load, and again after every Turbo visit
document.addEventListener("DOMContentLoaded", () => {
  initFlowbite();
});

document.addEventListener("turbo:load", () => {
  initFlowbite();
});