return {
  {
    "3rd/image.nvim",
    dependencies = {
      "leafo/magick", -- Lua биндинги для ImageMagick
    },
    config = function()
      require("image").setup {
        backend = "kitty",
        processor = "magick_rock", -- используем magick
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = 50,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      }
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = true,
        drag_and_drop = {
          insert_mode = true,
        },
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          dir_path = "assets",
        },
      },
    },
    keys = {
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
    },
  },
}
