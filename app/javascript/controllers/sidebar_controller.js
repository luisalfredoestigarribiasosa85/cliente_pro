import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "overlay"]

  connect() {
    this.sidebarTarget.classList.remove("hidden")
  }

  toggle() {
    this.sidebarTarget.classList.toggle("-translate-x-full")
    if (this.hasOverlayTarget) {
      this.overlayTarget.classList.toggle("hidden")
    }
  }

  close() {
    this.sidebarTarget.classList.add("-translate-x-full")
    if (this.hasOverlayTarget) {
      this.overlayTarget.classList.add("hidden")
    }
  }
}