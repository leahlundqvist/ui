import ui
import gx
import rand

const (
	win_width = 250
	win_height = 250
)

struct App {
mut:
	window  &ui.Window
	scroller ui.Stack
	transition ui.Transition
	state int
}

fn gen_name_list() []ui.Widget {
	first_names := ["Harry","Ross",
                 "Bruce","Cook",
                 "Carolyn","Morgan",
                 "Albert","Walker",
                 "Randy","Reed",
                 "Larry","Barnes",
                 "Lois","Wilson",
                 "Jesse","Campbell",
                 "Ernest","Rogers",
                 "Theresa","Patterson",
                 "Henry","Simmons",
                 "Michelle","Perry",
                 "Frank","Butler",
                 "Shirley"]
	last_names := ["Ruth","Jackson",
					"Debra","Allen",
					"Gerald","Harris",
					"Raymond","Carter",
					"Jacqueline","Torres",
					"Joseph","Nelson",
					"Carlos","Sanchez",
					"Ralph","Clark",
					"Jean","Alexander",
					"Stephen","Roberts",
					"Eric","Long",
					"Amanda","Scott",
					"Teresa","Diaz",
					"Wanda","Thomas"]

	mut widgets := []ui.Widget
	mut i := 0
	for i < 50 {
		widgets << ui.label(
			text: first_names[rand.next(first_names.len)]+" "+last_names[rand.next(last_names.len)]
		)
		i++
	}
	return widgets
}

fn main() {
	mut app := &App{ window: 0, state: 0 }
	mut children := gen_name_list()
	children << ui.rectangle(height: 32, width: 200, color: gx.rgb(255, 100, 100))

	window := ui.window({
		width: win_width
		height: win_height
		title: 'V UI Window'
		user_ptr: app
	}, [
		ui.button(
			text: 'Scroll'
			onclick: btn_toggle_click
		),
		ui.scrollable({
			alignment: .center
			spacing: 5
			stretch: true
			ref: &app.scroller
			margin: ui.MarginConfig{5,5,5,5}
		}, children),
		ui.transition(
			duration: 2000
			easing: ui.easing(.ease_in_out_quart)
			ref: &app.transition
		)
	])

	app.window = window
	ui.run(window)
}

fn btn_toggle_click(mut app App, x voidptr) {
	if app.transition.animated_value == 0 {
		app.transition.set_value(&app.scroller.scroll)
	}

	match (app.state) {
		0 {
			app.transition.target_value = 852
			app.state = 1
		}
		1 {
			app.transition.target_value = 426
			app.state = 2
		}
		2 {
			app.transition.target_value = 600
			app.state = 3
		}
		3 {
			app.transition.target_value = 0
			app.state = 0
		}
		else { app.state = 0 }
	}
}