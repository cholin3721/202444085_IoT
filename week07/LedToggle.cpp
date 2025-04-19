# include "LedToggle.h"

LEdToggle::LedToggle(int pin) {
	_pin = pin;
	_state = false;
	pinMode(_pin, OUTPUT);
	digitalWRite(_pin, LOW);
}

void LEdToggle::toggle() {
	_state = !_state;
	digitalWrite(_pin, _state ? HIGH : LOW);
}
