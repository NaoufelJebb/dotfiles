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
vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      completion = true,
      validate = true,
      format = { enable = true },
      hover = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemaDownload = { enable = true },
      schemas = {
        -- Kubernetes
        kubernetes = {
          "k8s/**/*.yml",
          "k8s/**/*.yaml",
          "manifests/**/*.yml",
          "manifests/**/*.yaml",
          "deploy/**/*.yml",
          "deploy/**/*.yaml",
          "templates/**/*.yaml",
          "templates/**/*.yml",
          "helm/**/*.yaml",
          "helm/**/*.yml",
        },

        -- Docker Compose / Compose Spec
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
          "docker-compose.yml",
          "docker-compose.yaml",
          "compose.yml",
          "compose.yaml",
          "**/docker-compose.yml",
          "**/docker-compose.yaml",
          "**/compose.yml",
          "**/compose.yaml",
        },
        ["https://json.schemastore.org/github-workflow.json"] = {
          ".github/workflows/*.yml",
          ".github/workflows/*.yaml",
          "**/.github/workflows/*.yml",
          "**/.github/workflows/*.yaml",
        },

        ["https://json.schemastore.org/gitlab-ci.json"] = {
          ".gitlab-ci.yml",
          ".gitlab-ci.yaml",
          "**/.gitlab-ci.yml",
          "**/.gitlab-ci.yaml",
        },

        -- Helm Chart.yaml
        ["https://json.schemastore.org/chart.json"] = {
          "Chart.yaml",
          "**/Chart.yaml",
        },
      },
      trace = { server = "debug" },
    },
  },
})
--
--
--
-- local schema_companion = require("schema-companion")
--
-- require("lspconfig").yamlls.setup(schema_companion.setup_client(
--   schema_companion.adapters.yamlls.setup({
--     sources = {
--       -- keep normal yamlls / schemastore-backed schemas available
--       schema_companion.sources.lsp.setup(),
--
--       -- optional manual "none" reset
--       schema_companion.sources.none.setup(),
--
--       -- Kubernetes autodetection by file content
--       schema_companion.sources.matchers.kubernetes.setup({
--         version = "master",
--       }),
--
--       -- extra manual schemas you want available in picker
--       schema_companion.sources.schemas.setup({
--         {
--           name = "Docker Compose",
--           uri = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
--         },
--         {
--           name = "GitHub Workflow",
--           uri = "https://json.schemastore.org/github-workflow.json",
--         },
--         {
--           name = "GitLab CI",
--           uri = "https://json.schemastore.org/gitlab-ci.json",
--         },
--         {
--           name = "Helm Chart",
--           uri = "https://json.schemastore.org/chart.json",
--         },
--       }),
--     },
--   }),
--   {
--     settings = {
--       yaml = {
--         completion = true,
--         validate = true,
--         hover = true,
--         format = { enable = true },
--
--         -- when using SchemaStore.nvim, disable yamlls built-in catalog
--         schemaStore = {
--           enable = false,
--           url = "",
--         },
--
--         -- still provide normal catalog schemas to yamlls
--         schemas = require("schemastore").yaml.schemas(),
--       },
--     },
--   }
-- ))
