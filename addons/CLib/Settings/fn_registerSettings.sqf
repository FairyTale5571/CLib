#include "macros.hpp"
/*
    Community Lib - CLib

    Author: BadGuy

    Description:
    Registers config class from configFile to settings framework

    Parameter(s):
    0: Array with config path <Array> (Default: [])

    Returns:
    None
*/

params [
    ["_basePath", [], [[]], []]
];

private _configClasses = [configFile, missionConfigFile] apply {
    private _temp = _x;
    {
        _temp = (_temp >> _x);
        nil;
    } count _basePath;
    _temp
};

private _prefix = _basePath joinString "/";
private _subClasses = GVAR(allSettings) getVariable ["classes:" + _prefix, []];
private _settings = GVAR(allSettings) getVariable ["settings:" + _prefix, []];

private _fnc_getValue = {
    if (isText _this) exitWith {
        getText _this;
    };
    if (isNumber _this) exitWith {
        getNumber _this;
    };
    if (isArray _this) exitWith {
        getArray _this;
    };
    nil;
};

{
    {
        private _name = configName _x;
        private _path = _basePath + [_name];
        private _pathString = (_path joinString "/");

        (GVAR(allSettings) getVariable [_pathString, [nil, 0, 0, ""]]) params ["_value", "_force", "_isClient", "_description"];

        if (_force == 0) then {
            if (isClass _x) then {
                if (isText (_x >> "value") || isNumber (_x >> "value") || isArray (_x >> "value")) then {
                    if (isNumber (_x >> "force")) then {
                        _force = getNumber (_x >> "force");
                    };
                    if (isNumber (_x >> "value")) then {
                        _isClient = getNumber (_x >> "isClient");
                    };
                    if (isText (_x >> "description")) then {
                        _description = getText (_x >> "description");
                    };
                    _value = (_x >> "value") call _fnc_getValue;
                } else {
                    [_path] call CFUNC(registerSettings);
                };
            } else {
                if (isText _x || isNumber _x || isArray _x) then {
                    _value = _x call _fnc_getValue;
                };
            };
        };

        if (!isNil "_value") then {
            _settings pushBackUnique _name;
            GVAR(allSettings) setVariable [_pathString, [_value, _force, _isClient, _description], true];
        } else {
            _subClasses pushBackUnique _name;
        };
        nil;
    } count configProperties [_x, "true", true];
    nil;
} count _configClasses;

GVAR(allSettings) setVariable ["classes:" + _prefix, _subClasses, true];
GVAR(allSettings) setVariable ["settings:" + _prefix, _settings, true];
