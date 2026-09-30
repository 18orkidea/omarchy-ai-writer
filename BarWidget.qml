import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

// Botón de la barra para ai-writer: corrige o reescribe el texto seleccionado con Ollama.
// El icono se ilumina mientras el corrector trabaja.
BarWidget {
  id: root
  moduleName: "eu.orkidea.ai-writer"

  // Por defecto usa el script que viene con el plugin; el ajuste "command" permite otro.
  readonly property string bundledCommand: decodeURIComponent(Qt.resolvedUrl("bin/ai-writer").toString().replace(/^file:\/\//, ""))
  readonly property string command: setting("command", "") || bundledCommand
  readonly property bool busy: writer.running

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  function launch(action) {
    if (writer.running) return
    const cmd = root.command.replace(/^~(?=\/)/, Quickshell.env("HOME"))
    writer.command = action ? [cmd, action] : [cmd]
    writer.running = true
  }

  Process {
    id: writer
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "󰓆"
    active: root.busy
    slotSize: Style.bar.statusSlot
    tooltipText: root.busy
      ? "Corrector IA: trabajando…"
      : "Corrector IA\nClic: elegir acción, tono y plataforma\nDerecho: corregir ortografía\nCentral: mejorar redacción"
    onPressed: function(buttonCode) {
      if (buttonCode === Qt.RightButton) root.launch("Corregir ortografía")
      else if (buttonCode === Qt.MiddleButton) root.launch("Mejorar redacción")
      else root.launch("")
    }
  }
}
