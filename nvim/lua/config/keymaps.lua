local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)

-- Split window
keymap.set("n", "wh", ":split<Return>", opts)
keymap.set("n", "wv", ":vsplit<Return>", opts)