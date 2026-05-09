return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = {
      enable = false,
    },
    workspaces = {
      {
        name = "Personal",
        path = "~/myWorkflow/vaults/personal",
      },
      {
        name = "Work",
        path = "~/myWorkflow/vaults/work",
      },
    },
    notes_subdir = "notes",
    daily_notes = {
      folder = "dailies",
      template = "dailies.md",
    },
    templates = {
      folder = "templates",
    },
  },
  keys = {
    { "<leader>to", "", desc = "Obsidian" },
    { "<leader>tos", ":ObsidianSearch<cr>", desc = "Search for (or create) notes" },
    { "<leader>tod", ":ObsidianDailies -5 2 <cr>", desc = "Open a picker list of daily notes" },
    { "<leader>tow", ":ObsidianWorkspace<cr>", desc = "Switch to another workspace" },
    { "<leader>toq", ":ObsidianQuickSwitch<cr>", desc = "Quickly switch to (or open) another note" },
    { "<leader>ton", ":ObsidianNew<cr>", desc = "Create a new note" },
    { "<leader>tot", ":ObsidianTags<cr>", desc = "Open a picker list of all tags" },
  },
}
