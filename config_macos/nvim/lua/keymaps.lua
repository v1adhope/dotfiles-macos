local ok, _ = pcall(require, "features/create_keymap")
if not ok then
	return
end

-- No highlighting
Map("n", "nh", ":noh<CR>")

-- Move line
Map("n", "<C-i>", ":m-2<CR>")
Map("n", "<C-o>", ":m+<CR>")

-- Buffer navigation
Map("n", "<C-p>", ":b#<CR>")

-- Split navigation
Map("n", "<C-h>", ":wincmd h<CR>")
Map("n", "<C-j>", ":wincmd j<CR>")
Map("n", "<C-k>", ":wincmd k<CR>")
Map("n", "<C-l>", ":wincmd l<CR>")

-- File explorer
Map("n", "fe", ":NvimTreeToggle<CR>")

-- Gitsigns
Map("n", "bl", ":Gitsigns blame_line<CR>")

-- Telescope
Map("n", "ff", ":Telescope find_files<CR>")
Map("n", "fg", ":Telescope live_grep<CR>")
Map("n", "fb", ":Telescope buffers<CR>")
Map("n", "fh", ":Telescope help_tags<CR>")
Map("n", "fc", ":Telescope git_commits<CR>")
Map("n", "fd", ":Telescope diagnostics<CR>")
