return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
      require("mason").setup {
        ui = {
          border = "rounded",
        },
        PATH = "prepend", -- Add Mason bin to PATH
      }
      local registry = require "mason-registry"

      -- auto install formatters
      for _, pkg_name in ipairs { "stylua", "prettierd", "eslint_d" } do
        local ok, pkg = pcall(registry.get_package, pkg_name)
        if ok then
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        automatic_enable = false,
        ensure_installed = {
          "ts_ls",
          "vue_ls",
          "tailwindcss",
          "cssls",
          "yamlls",
          "emmet_ls",
          "graphql",
          "lua_ls",
          "eslint",
          "jsonls",
          "html",
          "bashls",
        },
        automatic_installation = true,
      }
    end,
  },
}
