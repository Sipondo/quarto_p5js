return {
  ['p5js'] = function(args, kwargs, meta, raw_args, context)
    -- see https://quarto.org/docs/extensions/shortcodes.html
    -- for documentation on shortcode development
    -- first positional arg becomes src query param for the embedded page
    local base_url = "https://raw.githack.com/Sipondo/p5micro/f36396d565fb635f4df8cc8396ed5ef210029233/p5micro.html"

    local function urlencode(str)
      if not str then return "" end
      return (str:gsub("([^%w%-_%.~])", function(c)
        return string.format("%%%02X", string.byte(c))
      end))
    end

    local src_arg = args and args[1] or nil
    local src_qs = ""
    local sep = "?"

    if src_arg and src_arg ~= "" then
      src_qs = sep .. "src=" .. urlencode(src_arg)
      sep = "&"
    end

    -- append all kwargs as url parameters
    if kwargs then
      for key, value in pairs(kwargs) do
        src_qs = src_qs .. sep .. urlencode(key) .. "=" .. urlencode(tostring(value))
        sep = "&"
      end
    end

    local iframe_url = base_url .. src_qs
    -- return pandoc.RawBlock('html',
    --   '<iframe width="' ..
    --   width .. '" height="' .. height .. '" src="' .. iframe_url .. '" title="P5.js Applet"></iframe>')
    return pandoc.RawBlock('html',
      [[
    <div class="p5-frame">
      <iframe src="]] .. iframe_url .. [[" title="P5.js Applet"></iframe>
    </div>
    <style>
    /* Make the slide a flex container */
    .reveal .slide {
      display: flex !important;
      flex-direction: column !important;
    }

    /* Wrapper around the iframe */
    .p5-frame {
      flex: 1;        /* take remaining vertical space */
      min-height: 0;  /* allow flex shrinking */
      display: flex;  /* let iframe fill container */
    }

    /* The iframe itself */
    .p5-frame iframe {
      flex: 1;
      width: 100%;
      height: 100%;
      border: none;
    }
    </style>
    ]])
  end
}
