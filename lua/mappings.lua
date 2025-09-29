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

map("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "Go to Definition" })
map("n", "gr", require("telescope.builtin").lsp_references, { desc = "List References" })
map("n", "gi", require("telescope.builtin").lsp_implementations, { desc = "Go to Implementation" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map("n", "K", function()
  vim.lsp.buf.hover { border = "rounded" }
end)
map("n", "<leader>le", "<cmd>e<CR>", { desc = "LSP restart", remap = true })

map("n", "<leader>c", vim.lsp.buf.code_action, { desc = "Code Actions" })

map("n", "<leader>ca", function()
  vim.lsp.buf.code_action {
    context = {
      only = { "source" },
      diagnostics = {},
    },
    apply = false,
  }
end, { desc = "File Code Actions" })

-- Копируем текущее имя файла в буфер
map("n", "cp", ':let @+ = expand("%:t:r")<cr>')

-- Копируем весь файл в буфер
map("n", "<leader>y", "ggVG\"+y``", { desc = "Copy entire file" })

map("x", "p", '"_dP', { desc = "Replace without yanking" })
map("n", "c", '"_c', { desc = "Change without yanking" })
map("n", "C", '"_C', { desc = "Change until EOL without yanking" })

map("n", "<leader>q", require("telescope.builtin").quickfix, { desc = "Show Quickfix in Telescope" })
map("n", "<leader>M", "<cmd>Mason<CR>", { desc = "Mason" })
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy" })
map("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename" })
map("n", "<leader>R", function()
  local word = vim.fn.expand("<cword>")
  local input = vim.fn.input("Replace '" .. word .. "' with: ")
  if input ~= "" then
    vim.cmd(":%s/\\b" .. word .. "\\b/" .. input .. "/gc")
  end
end, { desc = "Global Replace with confirmation" })

-- Spectre keybindings
map("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
map("n", "<leader>z", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = "Search current word" })
map("v", "<leader>z", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
map("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search on current file" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Перемешение строк
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
