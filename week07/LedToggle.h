#ifndef LedToggle.h
#define LedToggle_h

#inlcude "Arduino.h"

class LedToggle {
	public :
		LedToggle(int pin);
		void toggle();
		
		private :
			int _pin;  // for capsulization using under score on variable name
			bool _state;
};

#endif
