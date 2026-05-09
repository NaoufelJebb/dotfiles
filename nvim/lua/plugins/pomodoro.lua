return {
  "epwalsh/pomo.nvim",
  version = "*", -- Recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
  dependencies = {
    -- Optional, but highly recommended if you want to use the "Default" timer
    "rcarriga/nvim-notify",
  },
  opts = {
    -- You can optionally define custom timer sessions.
    sessions = {
      Work = {
        { name = "Work", duration = "50m" },
        { name = "Short Break", duration = "10m" },
        { name = "Work", duration = "50m" },
        { name = "Short Break", duration = "10m" },
        { name = "Work", duration = "50m" },
        { name = "Long Break", duration = "15m" },
      },
    }, -- See below for full list of options 👇
  },
  keys = {
    { "<leader>tp", "", desc = "Pomodoro" },
    { "<leader>tps", ":TimerStart 50m<cr>", desc = "Start a new timer" },
    { "<leader>tpd", ":TimerStop", desc = "Stop current running timer" },
    { "<leader>tph", ":TimerHide<cr>", desc = "Hide the notifiers of a running timer" },
    { "<leader>tpS", ":TimerSession<cr>", desc = "Start a predefined Pomodoro session" },
  },
}
