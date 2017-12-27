#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas

    Description:
    Registers a Local Variable that gets Carryed Over to each state and is allways accessible

    Parameter(s):
    0: Statemachine Object <Location>
    1: Variable Name <String>
    2: Start Value <Any> (default: nil)

    Returns:
    None
*/
params ["_stateMachine", "_varName", "_var"];
if (_varName select [0, 1] != "_") then {
    _varName = _varName + "_";
    LOG("Error Varname " + _varName + " Needs a _ in the begining to work Correctly");
};

private _allVars = _stateMachine getVariable [SMVAR(allLocalStateVariables), [[], []]];
_allVars params ["_names", "_vars"];
private _index = _names find _varName;
if (_index == -1) then {
    _names pushback _varName;
};
_vars set [_index, _var];

_allVars = [_names, _vars];
_stateMachine setVariable [SMVAR(allLocalStateVariables), _allVars];
