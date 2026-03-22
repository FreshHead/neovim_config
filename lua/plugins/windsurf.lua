return {
  "Exafunction/windsurf.nvim",
  enabled = false, -- отключено в пользу blink.cmp
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup {}
  end,
}
