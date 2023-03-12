local status, devcontainer = pcall(require, "devcontainer")
if not status then
  return
end

devcontainer.setup({
  log_level = "info",
})
