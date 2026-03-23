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
    {
      "<leader>oT",
      function()
        local vault_path = vim.fn.expand("~/Documents/frontend")
        local tags_dir = vault_path .. "/3 - Tags"

        -- Get list of tag files
        local tags = {}
        local handle = io.popen('ls "' .. tags_dir .. '" 2>/dev/null')
        if handle then
          for line in handle:lines() do
            local tag = line:gsub("%.md$", "")
            table.insert(tags, tag)
          end
          handle:close()
        end

        if #tags == 0 then
          vim.notify("No tags found in " .. tags_dir, vim.log.levels.WARN)
          return
        end

        -- Use vim.ui.select to pick a tag
        vim.ui.select(tags, { prompt = "Select tag:" }, function(choice)
          if not choice then return end
          -- Search for notes containing [[Tag]]
          require("telescope.builtin").grep_string({
            search = "\\[\\[" .. choice .. "\\]\\]",
            use_regex = true,
            cwd = vault_path,
            prompt_title = "Notes with [[" .. choice .. "]]",
          })
        end)
      end,
      desc = "Search notes by tag",
    },
    {
      "<leader>og",
      function()
        -- Get wiki link under cursor
        local line = vim.fn.getline(".")
        local col = vim.fn.col(".")
        local link = line:match("%[%[([^%]]+)%]%]")

        if link then
          local vault_path = vim.fn.expand("~/Documents/frontend")
          require("telescope.builtin").grep_string({
            search = "\\[\\[" .. link .. "\\]\\]",
            use_regex = true,
            cwd = vault_path,
            prompt_title = "Notes with [[" .. link .. "]]",
          })
        else
          vim.notify("No [[link]] under cursor", vim.log.levels.WARN)
        end
      end,
      desc = "Go to notes with tag under cursor",
    },
  },
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/Documents/frontend/**/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Documents/frontend/**/*.md",
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
        nvim_cmp = false,
        blink = true,
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
      frontmatter = { enabled = false },
      legacy_commands = false,
      ui = {
        enable = false, -- Disable UI features to avoid conceallevel warning
      },
    }

    -- Set up keymaps after obsidian setup (replaces deprecated mappings config)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.keymap.set("n", "gf", function()
          -- Get word under cursor (handle [[link]] format)
          local line = vim.fn.getline(".")
          local col = vim.fn.col(".")
          local link = line:match("%[%[([^%]]+)%]%]")

          if link then
            -- Search for file in vault
            local vault_path = vim.fn.expand("~/Documents/frontend")
            local handle = io.popen('find "' .. vault_path .. '" -name "' .. link .. '.md" 2>/dev/null | head -1')
            local result = handle:read("*a")
            handle:close()
            result = result:gsub("%s+$", "")

            if result ~= "" then
              vim.cmd("edit " .. result)
              return
            end
          end

          -- Fallback to Obsidian follow
          local success = pcall(function()
            vim.cmd("Obsidian follow")
          end)
          if not success then
            vim.notify("Link not found", vim.log.levels.WARN)
          end
        end, { buffer = true, desc = "Follow obsidian link" })
      end,
    })

  end,
}
