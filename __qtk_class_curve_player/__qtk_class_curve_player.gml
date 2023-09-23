enum QCURVE_PLAYER_STATE 
{
	STOPPED,
	PLAYING,
	COMPLETE
}

function QCurvePlayer() constructor 
{
	__state = QCURVE_PLAYER_STATE.STOPPED;
	__curve_library = __qc_ac_qcam_library;
	__current_curve = animcurve_get_channel(__curve_library, 0);
	__on_complete = undefined;
	__total_curve_time = 0;
	__current_curve_time = 0;
	
	Start = function(_curve_time = 1) 
	{
		__state = QCURVE_PLAYER_STATE.PLAYING;
		__total_curve_time = _curve_time;
		__current_curve_time = 0;
	}
	
	/// @desc This function returns the value for the current time on the curve, and increases the time.
	/// @param {Struct.QCameraZoomConfiguration} _configuration
	/// @return {real | undefined} The evaluated value of the curve.
	UpdateAndEvaluate = function() 
	{
		var _curve_y = animcurve_channel_evaluate(__current_curve, __current_curve_time / __total_curve_time);
		if (__state = QCURVE_PLAYER_STATE.PLAYING) {
			__current_curve_time += (delta_time / 1000000);
			// Complete Zoom
			if (__current_curve_time >= __total_curve_time) {
				__state = QCURVE_PLAYER_STATE.COMPLETE;
				__current_curve_time = __total_curve_time;
				if (is_callable(__on_complete)) {
					__on_complete();
				}
			}
		}
		
		return _curve_y;
	}
	
	/// @desc Set the curve that this player will reference. Calling it a library because the channels are treated as such.
	/// @param {Asset.GMAnimCurve} _library An animation curve.
	SetCurveLibrary = function(_library) {
		__curve_library = _library;
		return self;
	}
	
	/// @desc Set the curve channel that this player will reference.
	/// @param {String OR Real} _channel A curve channel.
	SetCurveChannel = function(_channel) 
	{
		__current_curve = animcurve_get_channel(__curve_library, _channel);
		return self;
	}
	
	/// @desc Set a function to play when the curve reaches its end.
	/// @param {Function} _on_complete A function to execute when the player reaches the end of the curve.
	SetOnComplete = function(_on_complete) 
	{
		__on_complete = _on_complete;	
		return self;
	}
	
	/// @ Returns true if the the curve is in the process of playing.
	IsPlaying = function()
	{
		return __state == QCURVE_PLAYER_STATE.PLAYING;	
	}
}