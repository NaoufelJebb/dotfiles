return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
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
      template = "dailies_template.md",
    },
    templates = {
      folder = "templates",
    },
  },
  keys = {
    { "<leader>o", "", desc = "Obsidian" },
    { "<leader>os", ":ObsidianSearch<cr>", desc = "Search for (or create) notes" },
    { "<leader>od", ":ObsidianDailies<cr>", desc = "Open a picker list of daily notes" },
    { "<leader>ow", ":ObsidianWorkspace<cr>", desc = "Switch to another workspace" },
    { "<leader>oq", ":ObsidianQuickSwitch<cr>", desc = "Quickly switch to (or open) another note" },
    { "<leader>on", ":ObsidianNew<cr>", desc = "Create a new note" },
  },
}
