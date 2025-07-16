local formatter_to_use = "prettierd"

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      typescriptreact = { formatter_to_use },
      javascriptreact = { formatter_to_use },
      javascript = { formatter_to_use },
      typescript = { formatter_to_use },
      json = { formatter_to_use },
      jsonc = { formatter_to_use },
      html = { formatter_to_use },
      css = { formatter_to_use },
      scss = { formatter_to_use },
      graphql = { formatter_to_use },
      markdown = { formatter_to_use },
      vue = { formatter_to_use },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
