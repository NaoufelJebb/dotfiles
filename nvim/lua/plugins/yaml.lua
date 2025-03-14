return {
  "cuducos/yaml.nvim",
  ft = { "yaml" }, -- optional
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- optional
  },
  keys = {
    { "<leader>ty", "", desc = "YAML" },
    { "<leader>tys", ":YAMLTelescope<CR>", desc = "Full path key/value finder via Telescope" },
    { "<leader>tyv", ":!yamllint %<CR>", desc = "Validate YAML file" },
  },
}
