// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import { initFlowbite } from "flowbite";

let raf;
const reinitFlowbite = () => {
  if (raf) cancelAnimationFrame(raf);
  raf = requestAnimationFrame(() => initFlowbite());
};

document.addEventListener("turbo:load", reinitFlowbite);
document.addEventListener("turbo:frame-load", reinitFlowbite);
document.addEventListener("turbo:render", reinitFlowbite);
document.addEventListener("turbo:before-stream-render", () =>
  queueMicrotask(reinitFlowbite)
);
// If you still see a race, swap the line above for:
// document.addEventListener("turbo:before-stream-render", () => queueMicrotask(reinitFlowbite))
