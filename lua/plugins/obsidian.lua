return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "3rd/image.nvim",
  },
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre ~/Documents/frontend/*.md",
    "BufNewFile ~/Documents/frontend/*.md",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    -- workspaces = {
    --   {
    --     name = "personal",
    --     path = "~/Documents/frontend",
    --   },
    -- },

    -- see below for full list of options 👇
  },
  config = function()
    require("obsidian").setup {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/frontend",
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      -- Use new keymap system instead of deprecated mappings
      -- Set up the gf mapping outside of obsidian config
      disable_frontmatter = true,
      legacy_commands = false,
      ui = {
        enable = false, -- Disable UI features to avoid conceallevel warning
      },
      -- Настройка для обработки изображений
      follow_url_func = function(url)
        -- Если это локальный файл изображения - открыть в nvim для inline просмотра
        if
          url:match "^[^:]*%.png$"
          or url:match "^[^:]*%.jpg$"
          or url:match "^[^:]*%.jpeg$"
          or url:match "^[^:]*%.gif$"
        then
          vim.cmd("edit " .. url)
        else
          -- Внешние ссылки открываем в браузере
          vim.fn.jobstart({ "xdg-open", url }, { detach = true })
        end
      end,
    }

    -- Set up keymaps after obsidian setup (replaces deprecated mappings config)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.keymap.set("n", "gf", function()
          local success, result = pcall(function()
            return vim.cmd("ObsidianFollowLink")
          end)
          if not success then
            vim.cmd("normal! gf")
          end
        end, { buffer = true, desc = "Follow obsidian link or normal gf" })
      end,
    })
  end,
}
