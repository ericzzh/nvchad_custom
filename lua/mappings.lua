require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- manually added
map("n","<A-UP>","<Cmd> resize -2<CR>", {desc = "resize window up"})
map("n","<A-DOWN>", "<Cmd> resize +2<CR>",{desc = "resize window down"})
map("n","<A-LEFT>", "<Cmd> vertical resize -2<CR>",{desc = "resize window left"})
map("n","<A-RIGHT>","<Cmd> vertical resize +2<CR>",{desc = "resize window right"})
