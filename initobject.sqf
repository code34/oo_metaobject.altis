		
		private ["_object", "_metaobject"];

		_object = cursorTarget;
		_metaobject = ["new", _object] call OO_METAOBJECT;

		switch(_this select 3) do {
			case "valuebytime" : {
				_payload = { Bo_GBU12_LGB = createVehicle ["Bo_GBU12_LGB", position _this, [], 0, "CAN_COLLIDE"]; };
				["increaseValueByTime", [1,10]] spawn _metaobject;
				["triggerAtValue", [10, _payload]] spawn _metaobject;
			};

			case "valuebydistance" : {
				_payload = { Bo_GBU12_LGB = createVehicle ["Bo_GBU12_LGB", position _this, [], 0, "CAN_COLLIDE"]; };
				["increaseValueByDistance", [100, 1]] spawn _metaobject;
				["triggerAtValue", [40, _payload]] spawn _metaobject;
			};

			case "owner" : {
				["setOwner", name player] spawn _metaobject;
			};

			case "copy" : {
				copyToClipboard format ["%1", typeof _object];
			};

			default {};
		};

		 while { true } do {
			hint format ["%1 %2 %3", ("getValue" call _metaobject), ("getOwner" call _metaobject), ("getObject" call _metaobject)];
			sleep 1;
		 };
		 