-- lazydocker.nvim
return {
  "mgierada/lazydocker.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  config = function()
    require("lazydocker").setup({
      border = "curved", -- valid options are "single" | "double" | "shadow" | "curved"
    })
  end,
  event = "BufRead",
  keys = {
    { "<leader>td", "", desc = "Docker" },
    {
      "<leader>tdl",
      function()
        require("lazydocker").open()
      end,
      desc = "Open Lazydocker floating window",
    },
  },
}
