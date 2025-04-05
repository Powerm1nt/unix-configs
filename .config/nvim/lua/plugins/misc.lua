return {
  { "nvim-tree/nvim-tree.lua" },
  { "folke/which-key.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
      {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
{
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp"
},
{ "m4xshen/autoclose.nvim" }
}
