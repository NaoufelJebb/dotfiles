-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_user_command(
  "Config",
  "lua LazyVim.pick.config_files()()",
  { bang = true, desc = "Open Neovim config" }
)

vim.api.nvim_create_user_command("MyWorkflow", function()
  require("telescope.builtin").find_files({ cwd = "~/myWorkflow/config" })
end, { bang = true, desc = "Open my Workflow" })

-- Set apart Gitlab CI config files from other YAML files to avoid confusion when loading LSP
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--  pattern = "*.gitlab-ci*.{yml,yaml}",
--  callback = function()
--    vim.bo.filetype = "yaml.gitlab"
--  end,
-- })
