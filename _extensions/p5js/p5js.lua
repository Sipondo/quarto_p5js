return {
  ['p5js'] = function(args, kwargs, meta, raw_args, context)
    -- see https://quarto.org/docs/extensions/shortcodes.html
    -- for documentation on shortcode development
    -- first positional arg becomes src query param for the embedded page
    local base_url = "https://raw.githack.com/Sipondo/p5micro/0f5e17071c77dc23edf329fe435d06b1cc6c0cd0/p5micro.html"

    local function urlencode(str)
      if not str then return "" end
      return (str:gsub("([^%w%-_%.~])", function(c)
        return string.format("%%%02X", string.byte(c))
      end))
    end

    local src_arg = args and args[1] or nil
    local width = args and args[2] or "100%"
    local height = args and args[3] or "80%"
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
    return pandoc.RawBlock('html',
      '<iframe width="' ..
      width .. '" height="' .. height .. '" src="' .. iframe_url .. '" title="P5.js Applet"></iframe>')
  end
}
