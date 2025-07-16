local map = require("utils").map

-- Normal mode mappings
map({ "n", "v" }, "<C-e>", ":wa<cr>", { desc = "Save all" })

map("n", "[d", function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = "Prev diagnostic" })
map("n", "]d", function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = "Next diagnostic" })
map("n", "<leader>d", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Line Diagnostics" })

map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "List References" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map("n", "K", function()
  vim.lsp.buf.hover { border = "rounded" }
end)
map("n", "<leader>le", "<cmd>e<CR>", { desc = "LSP restart", remap = true })

map("n", "<leader>c", vim.lsp.buf.code_action, { desc = "Code Actions" })

-- Копируем текущее имя файла в буфер
map("n", "cp", ':let @+ = expand("%:t:r")<cr>')

map("x", "p", '"_dP', { desc = "Replace without yanking" })
map("n", "c", '"_c', { desc = "Change without yanking" })
map("n", "C", '"_C', { desc = "Change until EOL without yanking" })

-- function to toggle quick fix list
local function qf_toggle()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  end
end

map("n", "<leader>q", qf_toggle, { desc = "Toggle Quickfix list" })
map("n", "<leader>M", "<cmd>Mason<CR>", { desc = "Mason" })
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy" })
map("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Перемешение строк
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
