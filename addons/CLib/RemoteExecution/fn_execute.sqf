#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas

    Description:
    Execute RemoteExecCommands

    Parameter(s):
    0: Function or Command that get Executed <String>
    1: Arguments that passes to the Event;

    Returns:
    Function Return <Any>
*/

EXEC_ONLY_UNSCHEDULED

params ["_function", "_args"];
if (isNil {currentNamespace getVariable _function} && {((currentNamespace getVariable _function) isEqualType {})}) then {
    LOG("ERROR: Unknown Function: " + _function)
} else {
    _args call (currentNamespace getVariable _function);
};
