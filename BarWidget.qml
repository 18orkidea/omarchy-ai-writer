import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

// Bar button for ai-writer: fixes or rewrites the selected text with a local Ollama model.
// The icon lights up while the model is working.
BarWidget {
  id: root
  moduleName: "eu.orkidea.ai-writer"

  // Uses the bundled script unless the "command" setting points elsewhere.
  readonly property string bundledCommand: decodeURIComponent(Qt.resolvedUrl("bin/ai-writer").toString().replace(/^file:\/\//, ""))
  readonly property string command: setting("command", "") || bundledCommand
  readonly property bool busy: writer.running
  readonly property bool spanish: Qt.locale().name.startsWith("es")

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
      ? (root.spanish ? "AI Writer: trabajando…" : "AI Writer: working…")
      : (root.spanish
        ? "AI Writer\nClic: elegir acción, tono y plataforma\nDerecho: corregir ortografía\nCentral: mejorar redacción"
        : "AI Writer\nClick: choose action, tone and platform\nRight: fix spelling\nMiddle: improve wording")
    onPressed: function(buttonCode) {
      if (buttonCode === Qt.RightButton) root.launch("fix")
      else if (buttonCode === Qt.MiddleButton) root.launch("improve")
      else root.launch("")
    }
  }
}
