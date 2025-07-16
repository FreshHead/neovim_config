local Path = require 'plenary.path'
local function normalize_path(buf_name, root)
  return Path:new(buf_name):make_relative(root)
end
return {
  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    commit = 'e76cb03',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon'):setup {
        default = {
          create_list_item = function(config, name)
            name = name or normalize_path(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), config.get_root_dir())

            local bufnr = vim.fn.bufnr(name, false)
            local pos = { 1, 0 }
            if bufnr ~= -1 then
              pos = vim.api.nvim_win_get_cursor(0)
            end

            return {
              value = vim.fn.expand '%:p',
              context = {
                row = pos[1],
                col = pos[2],
                name = name,
              },
            }
          end,
          display = function(list_item)
            local name = list_item.context.name

            local windowWidth = vim.api.nvim_win_get_width(0)
            local ui_fallback_width = 69
            local ui_width_ratio = 0.62569

            local truncateAt = math.floor(windowWidth * ui_width_ratio)

            if truncateAt < ui_fallback_width then
              truncateAt = ui_fallback_width
            end

            if string.len(name) >= truncateAt then
              name = Path:new(name):shorten(2)
            end

            return name
          end,
        },
        settings = {
          save_on_toggle = true,
          key = function()
            local Job = require 'plenary.job'

            local function get_os_command_output(cmd, cwd)
              if type(cmd) ~= 'table' then
                return {}
              end
              local command = table.remove(cmd, 1)
              local stderr = {}
              local stdout, ret = Job:new({
                command = command,
                args = cmd,
                cwd = cwd,
                on_stderr = function(_, data)
                  table.insert(stderr, data)
                end,
              }):sync()
              return stdout, ret, stderr
            end

            -- Use git branch name if available
            local branch = get_os_command_output({
              'git',
              'rev-parse',
              '--abbrev-ref',
              'HEAD',
            })[1]

            if branch then
              return vim.loop.cwd() .. '-' .. branch
            else
              return vim.loop.cwd()
            end
          end,
        },
      }
    end,
    keys = {
      {
        '<leader>a',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'harpoon file',
      },
      {
        '<leader>h',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list(), { ui_width_ratio = 0.9 })
        end,
        desc = 'harpoon quick menu',
      },
      {
        '<leader>j',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'harpoon to file 1',
      },
      {
        '<leader>k',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'harpoon to file 2',
      },
      {
        '<leader>l',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'harpoon to file 3',
      },
      {
        '<leader>;',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'harpoon to file 4',
      },
      {
        "<leader>'",
        function()
          require('harpoon'):list():select(5)
        end,
        desc = 'harpoon to file 5',
      },
      {
        '<leader>[',
        function()
          require('harpoon'):list():prev()
        end,
        desc = 'harpoon prev buffer',
      },
      {
        '<leader>]',
        function()
          require('harpoon'):list():next()
        end,
        desc = 'harpoon next buffer',
      },
    },
  },
}
