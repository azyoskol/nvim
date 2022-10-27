require("core.base")
require("core.highlights")
require("core.maps")
require("core.plugins")

local has = vim.fn.has
local is_mac = has("macunix")
local is_win = has("win32")

if is_mac then
  require("core.macos")
end
if is_win then
  require("core.windows")
end

vim.g.gruvbox_flat_style = "dark"
vim.cmd("colorscheme gruvbox-flat")
