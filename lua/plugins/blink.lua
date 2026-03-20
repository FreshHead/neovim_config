return {
  "saghen/blink.cmp",
  version = "*",
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    keymap = {
      preset = "default",
      ["<C-y>"] = { "select_and_accept" },
    },
    completion = {
      list = {
        selection = { preselect = true, auto_insert = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
  },
}
