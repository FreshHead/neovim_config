-- Проверяет, что курсор внутри <script> секции Vue файла
local function in_vue_script()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].filetype ~= "vue" then
    return false
  end

  local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
  if not ok then
    return false
  end

  local node = ts_utils.get_node_at_cursor()
  while node do
    if node:type() == "script_element" then
      return true
    end
    node = node:parent()
  end
  return false
end

return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = { "L3MON4D3/LuaSnip" },
  opts = {
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lsp = {
          transform_items = function(_, items)
            if not in_vue_script() then
              return items
            end
            -- Фильтруем emmet completions внутри <script> секций Vue
            return vim.tbl_filter(function(item)
              return not (item.client_name == "emmet_ls" or item.client_name == "emmet_language_server")
            end, items)
          end,
        },
      },
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
