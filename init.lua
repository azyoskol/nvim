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

if vim.fn.exists(vim.g.neovide) then
  vim.g.neovide_transparency = 0.95
  vim.g.transparency = 0.95
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_scale_factor = 1.2
  vim.cmd("set guifont=JetBrains\\ Mono\\ NL\\ Nerd\\ Font:h14")
end

vim.g.gruvbox_flat_style = "dark"
vim.cmd("colorscheme gruvbox-flat")
