import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { text: String }

  copy(event) {
    event.preventDefault()
    const button = event.currentTarget
    const text = button.dataset.clipboardTextValue || this.textValue

    navigator.clipboard.writeText(text).then(() => {
      const original = button.textContent
      button.textContent = "¡Copiado!"
      setTimeout(() => {
        button.textContent = original
      }, 2000)
    }).catch(() => {
      alert("No se pudo copiar el texto")
    })
  }
}
