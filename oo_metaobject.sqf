	/*
	Author: code34 nicolas_boiteux@yahoo.fr
	Copyright (C) 2016 Nicolas BOITEUX

	CLASS OO_TEMPLATE - 
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>. 
	*/

	#include "oop.h"

	CLASS("OO_METAOBJECT")
		PRIVATE VARIABLE("object","object");
		PRIVATE VARIABLE("string","name");
		PRIVATE VARIABLE("scalar","timetolive");
		PRIVATE VARIABLE("scalar","value");
		PRIVATE VARIABLE("scalar","distance");
		PRIVATE VARIABLE("string","owner");
		PRIVATE VARIABLE("string","damage");
		PRIVATE VARIABLE("string","source");
		PRIVATE VARIABLE("string","target");
		PRIVATE VARIABLE("code","payload");

		PUBLIC FUNCTION("object","constructor") { 
			DEBUG(#, "OO_MARKER::constructor")
			MEMBER("setObject", _this);
			MEMBER("value", 0);
			MEMBER("timetolive", -1);
			MEMBER("distance", 0);
			MEMBER("owner", "");
			MEMBER("damage", 0);
			MEMBER("source", "");
			MEMBER("target", "");
			MEMBER("payload", {});
		};

		PUBLIC FUNCTION("","getObject") FUNC_GETVAR ("object");
		PUBLIC FUNCTION("","getName") FUNC_GETVAR ("name"); 
		PUBLIC FUNCTION("","getTimeToLive")FUNC_GETVAR ("timetolive");
		PUBLIC FUNCTION("","getValue")FUNC_GETVAR("value");
		PUBLIC FUNCTION("","getDistance") FUNC_GETVAR("distance"); 
		PUBLIC FUNCTION("","getOwner")FUNC_GETVAR("owner");
		PUBLIC FUNCTION("","getDamage") FUNC_GETVAR("damage");
		PUBLIC FUNCTION("scalar","setTimeToLive") { MEMBER("timetolive", _this); };
		PUBLIC FUNCTION("object","setObject") { MEMBER("object", _this); };
		PUBLIC FUNCTION("string","setName") { MEMBER("name", _this); };
		PUBLIC FUNCTION("string","setOwner") { MEMBER("owner", _this); };
		PUBLIC FUNCTION("scalar","setDistance") { MEMBER("distance", _this); };
		PUBLIC FUNCTION("scalar", "setDamage") { MEMBER("damage", _this); };
		PUBLIC FUNCTION("string", "setSource") { MEMBER("source", _this); };
		PUBLIC FUNCTION("string", "setTarget") { MEMBER("target", _this); };
		PUBLIC FUNCTION("code", "setPayLoad") { MEMBER("payload", _this); };

		/*
			_this select 0 : max value
			_this select 1: function to call
		*/
		PUBLIC FUNCTION("array", "triggerAtValue") {
			DEBUG(#, "OO_MARKER::triggerAtValue")
			private _max = param [0, 0, [0]];
			private _function = param [1, "", [{}]];
			private _current = 0;

			while { _current < _max } do {
				_current = MEMBER("value", _nil);
				sleep 0.1;
			};

			if!(_function isEqualTo "") then { MEMBER("object", nil) call _function;};
		};



		/*
			_this select 0 : time scale ex: 0.01
			_this select 1: max value
		*/
		PUBLIC FUNCTION("array", "increaseValueByTime") {
			DEBUG(#, "OO_MARKER::increaseValueByTime")
			private _scale = param [0, 1, [0]];
			private _max = param [1, 0, [0]];
			private _current = 0;

			while { _current < _max } do {
				_current = _current + 1;
				MEMBER("value", _current);
				sleep _scale;
			};
		};


		/*
			_this select 0 : max value
			_this select 1: scale
		*/
		PUBLIC FUNCTION("array", "increaseValueByDistance") {
			DEBUG(#, "OO_MARKER::increaseValueByDistance")
			private _max = param [0, 0, [0]];
			private _scale = param [1, 1, [0]];
			private _current = 0;
			private _object = MEMBER("object", nil);
			private _initialpos = getpos _object;

			while { _current < _max } do {
				_current = round(_initialpos distance (position _object)) * _scale;
				MEMBER("value", _current);
				sleep 1;
			};
		};

		PUBLIC FUNCTION("","deconstructor") { 
			DEBUG(#, "OO_MARKER::deconstructor")
			DELETE_VARIABLE("myobject");
			DELETE_VARIABLE("name");
			DELETE_VARIABLE("timetolive");
			DELETE_VARIABLE("value");
			DELETE_VARIABLE("distance");
			DELETE_VARIABLE("owner");
			DELETE_VARIABLE("damage");
			DELETE_VARIABLE("source");
			DELETE_VARIABLE("target");
			DELETE_VARIABLE("payload");
		};
	ENDCLASS;