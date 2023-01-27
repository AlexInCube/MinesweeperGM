draw_self()
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_color(c_white)
draw_sprite(spr_flag, 0, x - 95, y - 5)
draw_text(x - 45, y, obj_controller.num_flags)

draw_set_halign(fa_left)
draw_text(x + 50, y, string(seconds))