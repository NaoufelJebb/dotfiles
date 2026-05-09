return {
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    cmd = { "ToggleTerm" },
    keys = {
      {
        "<leader>tt",
        "",
        desc = "ToggleTerm",
      },
      {
        "<S-Esc>",
        [[<C-\><C-n>]],
        mode = "t",
        noremap = true,
        silent = true,
      },
      {
        "<leader>ttf",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 0, LazyVim.root.get(), "float")
        end,
        desc = "ToggleTerm (float root_dir)",
      },
      {
        "<leader>tth",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 15, LazyVim.root.get(), "horizontal")
        end,
        desc = "ToggleTerm (horizontal root_dir)",
      },
      {
        "<leader>ttv",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, vim.o.columns * 0.4, LazyVim.root.get(), "vertical")
        end,
        desc = "ToggleTerm (vertical root_dir)",
      },
      {
        "<leader>ttn",
        "<cmd>ToggleTermSetName<cr>",
        desc = "Set term name",
      },
      {
        "<leader>tts",
        "<cmd>TermSelect<cr>",
        desc = "Select term",
      },
      {
        "<leader>ttt",
        function()
          require("toggleterm").toggle(1, 100, LazyVim.root.get(), "tab")
        end,
        desc = "ToggleTerm (tab root_dir)",
      },
      {
        "<leader>ttT",
        function()
          require("toggleterm").toggle(1, 100, vim.loop.cwd(), "tab")
        end,
        desc = "ToggleTerm (tab cwd_dir)",
      },
    },
    opts = {
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      -- on_open = fun(t: Terminal), -- function to run when the terminal opens
      -- on_close = fun(t: Terminal), -- function to run when the terminal closes
      -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
      -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
      -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = true,
      direction = "horizontal" or "vertical" or "window" or "float",
      -- direction = "vertical",
      close_on_exit = true, -- close the terminal window when the process exits
      on_open = function(t)
        local opts = { buffer = t.bufnr }
        vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
        vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
        vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
        vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)
      end,
    },
  },
}
