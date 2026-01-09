# P5.js Quarto Extension

Embed interactive p5.js sketch editors in your Quarto documents using [p5micro](https://github.com/Sipondo/p5micro)—a lightweight, in-browser editor that lets readers experiment with and modify sketches without leaving the page.

## Installation

```bash
quarto add Sipondo/quarto_p5js
```

## Usage

### Basic shortcode

```
{{< p5js >}}
```

### With a sketch URL (first argument)

```
{{< p5js "https://example.com/sketch.js" >}}
```

### With custom dimensions (second and third arguments)

```
{{< p5js "https://example.com/sketch.js" "50%" "600px" >}}
```

Defaults are `100%` width and `80%` height.

### With p5micro parameters (named arguments)

Named arguments are passed as URL query parameters to p5micro:

- **`viewMode="view"`** – Hide the editor, display sketch output only.
- **`libs="url1,url2"`** – Load additional libraries alongside p5.js.

Example:
```
{{< p5js "https://example.com/sketch.js" "100%" "600px" viewMode="view" libs="https://example.com/lib.js" >}}
```

## Example

See [example.qmd](example.qmd) for a minimal example. Render with:

```bash
quarto render example.qmd
```

