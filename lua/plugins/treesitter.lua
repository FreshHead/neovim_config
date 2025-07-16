return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      context_commentstring = {
        enable = true,
      },
      ignore_install = { "help" },
      ensure_installed = {
        "bash",
        "comment",
        "css",
        "gitcommit",
        "gitignore",
        "graphql",
        "html",
        "http",
        "javascript",
        "json",
        "jsdoc",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "scss",
        "svelte",
        "tmux",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "xml",
        "yaml",
      }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      -- ignore_install = {}, -- List of parsers to ignore installing
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = function(lang, bufnr) -- Disable in large typescript buffers i.e. type definitions
          return lang == "typescript" and vim.api.nvim_buf_line_count(bufnr) > 5000
        end,
      },
      auto_install = true,
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<TAB>",
          scope_incremental = "<CR>",
          node_decremental = "<S-TAB>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- Detect jsx files and set filetype to javascript
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.jsx" },
        callback = function()
          vim.cmd([[set filetype=javascript]])
        end,
      })
    end,
  },
}
