# AI Writer for Omarchy

Fix spelling or rewrite the text you have selected in **any window**, with a **local** AI model (Ollama). Pick the action, the tone and the platform — or let it detect where you are writing (X, LinkedIn, YouTube, email, GitHub…). The result replaces your selection and is also copied to the clipboard.

Your text never leaves your computer: it only talks to Ollama on `127.0.0.1`.

![AI Writer in the Omarchy bar](preview.png)

## Usage

1. Select some text in any app.
2. Click the icon in the bar:

| Click | Action |
|---|---|
| **Left** | Menus: action → tone → platform |
| **Right** | Fix spelling right away (no menus) |
| **Middle** | Improve wording right away (no menus) |

The icon lights up while the model is working. In terminals the result is only copied (not pasted).

**Actions:** fix spelling · improve wording · rewrite · shorten · expand · translate to English · translate to Spanish.
**Tones:** keep original · professional · formal · friendly · funny · persuasive · empathetic · direct · enthusiastic.
**Platforms:** auto-detected from the active window, or pick one (X/Twitter keeps it under 280 characters, LinkedIn uses short paragraphs, email adds greeting and sign-off…).

> The menus are in Spanish for now. The model always answers in the language of your text (or the target language when translating).

## Requirements

- Omarchy (Hyprland + the Omarchy shell)
- [Ollama](https://ollama.com) running locally, with a model pulled. Default: `gemma4:e4b`
- `wl-clipboard`, `wtype`, `jq`, `curl`, `libnotify` (all standard on Omarchy)

```bash
omarchy pkg add ollama wtype        # if missing
sudo systemctl enable --now ollama
ollama pull gemma4:e4b
```

On AMD iGPUs, `ollama-vulkan` plus `OLLAMA_VULKAN=1` and `OLLAMA_IGPU_ENABLE=1` in the Ollama service gives a noticeable boost.

## Install

```bash
omarchy plugin add https://github.com/<owner>/omarchy-ai-writer.git --enable
omarchy bar move eu.orkidea.ai-writer --section right   # optional
```

### Optional keyboard shortcuts

Add to `~/.config/hypr/bindings.lua` (adjust the path to where the plugin was installed):

```lua
local aiw = os.getenv("HOME") .. "/.config/omarchy/plugins/eu.orkidea.ai-writer/bin/ai-writer"
o.bind("SUPER + ALT + W", "AI Writer: menu", aiw)
o.bind("SUPER + ALT + C", "AI Writer: fix spelling", aiw .. " 'Corregir ortografía'")
o.bind("SUPER + ALT + R", "AI Writer: improve wording", aiw .. " 'Mejorar redacción'")
```

## Configuration

| Variable | Default | |
|---|---|---|
| `AI_WRITER_MODEL` | `gemma4:e4b` | Any Ollama chat model |
| `OLLAMA_HOST` | `http://127.0.0.1:11434` | Ollama server |

The widget setting **command** lets you point to your own script; empty uses the bundled `bin/ai-writer`.

## Uninstall

```bash
omarchy plugin disable eu.orkidea.ai-writer
rm -rf ~/.config/omarchy/plugins/eu.orkidea.ai-writer
```

---

## Español

Corrige la ortografía o reescribe el texto seleccionado en cualquier ventana con un modelo **local** de Ollama. Elige acción, tono y plataforma, o deja que detecte dónde escribes. Clic izquierdo: menús · clic derecho: corregir ortografía · clic central: mejorar redacción. Tu texto no sale de tu ordenador.

---

Maintained by **[Orkidea](https://orkidea.eu)** · MIT License
