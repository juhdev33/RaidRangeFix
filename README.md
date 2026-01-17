# RaidRangeFix
Fix CompactRaidFrame range check in 2.5.5 client

Blizzard has bugged the range in the CompactRaidFrames and party frames in the 2.5.5 TBC anniversary client. This is a workaround that achieves the same effect without relying on the `UNIT_IN_RANGE_UPDATE`.

The range check is applied to every raid frame created; raid groups, main tank, raid pet frames etc. and raid style party frame.

## Install
You have to rename the folder so that it matches the name of the .toc

path should look like this `/AddOns/RaidRangeFix/RaidRangeFix.toc`
