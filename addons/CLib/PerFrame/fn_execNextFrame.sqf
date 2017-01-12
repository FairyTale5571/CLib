#include "macros.hpp"
/*
    Community Lib - CLib

    Author: esteldunedain
    Ported by: joko // Jonas

    Description:
    Execture a Code on the Next Frame

    Parameter(s):
    0: Code to execute <Code>
    1: Parameters to run the code with <Array>

    Returns:
    None
*/

EXEC_ONLY_UNSCHEDULED

params [["_func",{}], ["_params", []]];
if (diag_frameno == GVAR(nextFrameNo)) then {
    GVAR(nextFrameBufferB) pushBack [_params, _func];
} else {
    GVAR(nextFrameBufferA) pushBack [_params, _func];
};