-- Source https://github.com/Piotr1215/dotfiles/blob/master/.config/nvim/ftplugin/yaml.lua

vim.opt_local.cursorcolumn = true -- Highlight the current column
vim.opt_local.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt_local.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt_local.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.opt_local.expandtab = true -- Expand tab to 2 spaces

-- Folding
-- vim.opt_local.foldmethod = "indent"
-- vim.opt_local.foldlevel = 1

-- LSP Configuration
require("lspconfig").yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        kubernetes = "*.yaml",
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
        ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.{yml,yaml}",
      },
      format = {
        enable = true, -- Auto-format YAML file
      },
      validate = true, -- Enable schema validation
      completion = true, -- Enable autocoplete
    },
  },
})
