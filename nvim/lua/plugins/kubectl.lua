return {
  "Ramilito/kubectl.nvim",
  opts = {},
  cmd = { "Kubectl", "Kubectx", "Kubens" },
  keys = {
    { "<leader>tk", "", desc = "Kubernetes" },
    { "<leader>tkl", '<cmd>lua require("kubectl").toggle()<cr>', desc = "Open Kubectl" },
  },
}
