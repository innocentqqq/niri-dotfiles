-- Setup nvim-cmp.
local cmp = require("cmp")

local has_python3 = vim.fn.has("python3") == 1

-- The extentions needed by nvim-cmp should be loaded beforehand
require("cmp_nvim_lsp")
require("cmp_path")
require("cmp_buffer")
require("cmp_omni")
if has_python3 then
  require("cmp_nvim_ultisnips")
end
require("cmp_cmdline")

local MiniIcons = require("mini.icons")

local sources = {
  { name = "nvim_lsp" }, -- For nvim-lsp
  { name = "path" }, -- for path completion
  { name = "buffer", keyword_length = 2 }, -- for buffer word completion
}

if has_python3 then
  table.insert(sources, { name = "ultisnips" })
end

cmp.setup {
  snippet = {
    expand = function(args)
      if has_python3 then
        -- For `ultisnips` user.
        vim.fn["UltiSnips#Anon"](args.body)
      end
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Esc>"] = cmp.mapping.close(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
  },
  sources = sources,
  completion = {
    keyword_length = 1,
    completeopt = "menu,noselect",
  },
  view = {
    entries = "custom",
  },
  -- solution taken from https://github.com/echasnovski/mini.nvim/issues/1007#issuecomment-2258929830
  formatting = {
    format = function(_, vim_item)
      local icon, hl = MiniIcons.get("lsp", vim_item.kind)
      vim_item.kind = icon .. " " .. vim_item.kind
      vim_item.kind_hl_group = hl
      return vim_item
    end,
  },
}

local tex_sources = {
  { name = "omni" },
  { name = "buffer", keyword_length = 2 }, -- for buffer word completion
  { name = "path" }, -- for path completion
}

if has_python3 then
  table.insert(tex_sources, { name = "ultisnips" })
end

cmp.setup.filetype("tex", {
  sources = tex_sources,
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})

--  see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
vim.cmd([[
  highlight! link CmpItemMenu Comment
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])
