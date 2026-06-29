import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source"]
  static values = { text: String }

  copy(event) {
    event.preventDefault()
    const text = this.textValue || this.sourceTarget.textContent || this.sourceTarget.value

    navigator.clipboard.writeText(text).then(() => {
      const original = event.target.textContent
      event.target.textContent = "¡Copiado!"
      setTimeout(() => {
        event.target.textContent = original
      }, 2000)
    }).catch(() => {
      alert("No se pudo copiar el texto")
    })
  }
}