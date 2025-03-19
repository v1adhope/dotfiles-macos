local ok, _ = pcall(require, "features/create_keymap")
if not ok then
	return
end

-- No highlighting
Map("n", "<C-n>", ":noh<CR>")

-- Move line
Map("n", "<C-i>", ":m-2<CR>")
Map("n", "<C-o>", ":m+<CR>")

-- Split navigation
Map("n", "<C-h>", ":wincmd h<CR>")
Map("n", "<C-j>", ":wincmd j<CR>")
Map("n", "<C-k>", ":wincmd k<CR>")
Map("n", "<C-l>", ":wincmd l<CR>")

-- File explorer
Map("n", "<C-f>", ":NvimTreeToggle<CR>")

-- Gitsigns
Map("n", "<C-p>", ":Gitsigns preview_hunk<CR>")
-- Map("n", "<C-s>", ":Gitsigns select_hunk<CR>")
-- Map("n", "<M-b>", ":Gitsigns blame_line<CR>")

-- Markdown
Map("n", "<C-m>", ":MPToggle<CR>")

-- Telescope
Map("n", "ff", ":Telescope find_files<CR>")
Map("n", "fg", ":Telescope live_grep<CR>")
Map("n", "fb", ":Telescope buffers<CR>")
Map("n", "fh", ":Telescope help_tags<CR>")
