return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "3rd/image.nvim",
  },
  keys = {
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New Obsidian note" },
    { "<leader>ot", "<cmd>Obsidian template<cr>", desc = "Insert template" },
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
      -- Templates configuration
      templates = {
        folder = "5 - Templates",
        date_format = "%d.%m.%Y",
        time_format = "%H:%M",
        substitutions = {},
      },
      -- New notes location
      new_notes_location = "notes_subdir",
      notes_subdir = "6 - Main notes",
      -- Use title as filename instead of random ID
      note_id_func = function(title)
        if title ~= nil then
          return title
        else
          return tostring(os.time())
        end
      end,
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
            return vim.cmd("Obsidian follow")
          end)
          if not success then
            vim.cmd("normal! gf")
          end
        end, { buffer = true, desc = "Follow obsidian link or normal gf" })
      end,
    })

  end,
}
