-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      hide_dotfiles = false,
      follow_current_file = {
        enabled = false, -- This will find and focus the file in the active buffer every time
      },
      window = {
        position = 'float',
        popup = {               -- settings that apply to float position only
          size = { width = "150" },
          position = "50%",     -- 50% means center it
        },
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
