extends TextureProgress

func animate(val):
	$Tween.interpolate_property(
		self,
		"value",
		value,
		val,
		0.5,
		Tween.TRANS_BACK,
		Tween.EASE_OUT_IN
	)
	$Tween.start()