module ui

pub struct Scrollable {
mut:
	stack  &Stack
}

pub struct ScrollConfig {
	width  int
	alignment HorizontalAlignment
	spacing int
	stretch bool
	margin	MarginConfig
	ref &Stack
}

pub fn scrollable(c ScrollConfig, children []Widget) &Stack {
	return stack({
		width: c.width
		horizontal_alignment: c.alignment
		spacing: c.spacing
		stretch: c.stretch
		direction: .column
		margin: c.margin
		scrollable: true
	}, children)
}
