import QtQuick
import Quickshell
import Quickshell.Io
import qs.modules.services

// Recolours Obsidian vaults through scripts/obsidian_sync.py, which reads
// ~/.cache/ambxst/colors.json, after every theme change.
QtObject {
    id: root

    property bool syncAgain: false

    function generate(Colors) {
        if (Colors) root.sync()
    }

    function sync() {
        if (syncProcess.running) {
            root.syncAgain = true
            return
        }
        ModsService.getSettings("ecta250.obsidian-sync", (settings, error) => {
            const values = error ? {} : (settings?.values ?? {})
            const command = ["python3", Quickshell.shellDir + "/scripts/obsidian_sync.py"]
            if (values.enableSnippet !== false)
                command.push("--enable")
            if (values.matchMode !== false)
                command.push("--match-mode")
            for (const vault of String(values.vaults ?? "").split(/[,\n]/)) {
                if (vault.trim())
                    command.push("--vault", vault.trim())
            }
            syncProcess.command = command
            syncProcess.running = true
        })
    }

    property Process syncProcess: Process {
        id: syncProcess
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                const text = this.text.trim()
                if (text) console.log("ObsidianSync:", text)
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                const text = this.text.trim()
                if (text) console.error("ObsidianSync Error:", text)
            }
        }
        onExited: {
            if (root.syncAgain) {
                root.syncAgain = false
                root.sync()
            }
        }
    }
}
