const std = @import("std");
const mem = std.mem;

const concept = @import("../vec/concept.zig");

const FIELD_NAME = "cols";

pub fn isMat(comptime Type: type) bool {
    const T = @typeInfo(Type);
    if (T != .@"struct")
        return false;

    const fields = T.@"struct".fields;
    if (fields.len != 1 or !@hasField(Type, FIELD_NAME))
        return false;

    const F = @typeInfo(fields[0].type);

    return F == .array and F.array.len >= 2 and F.array.len <= 4 and concept.isVec(F.array.child);
}

pub fn requireMat(comptime Type: type) void {
    if (!isMat(Type))
        @compileError("Invalid std.builtin.Type - does not satisfy Mat type requirements");
}
