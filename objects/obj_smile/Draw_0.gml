draw_self()
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_color(c_white)
draw_text(x + 50, y, "Время: " + string(round(seconds)))

draw_sprite(spr_flag, 0, x - 85, y - 5)
draw_text(x - 30, y, obj_controller.num_flags)