function natToTz(const val: nat): tez is val * 1tz

function natToMutez(const val: nat): tez is val * 1mutez

function tezToNatWithMutez(const val: tez): nat is val / 1mutez

function tezToNatWithTz(const val: tez): nat is val / 1tz

function natToInt(const val: nat): int is val + 0
