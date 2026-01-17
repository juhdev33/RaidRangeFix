RRFix = {
  loadedCUFs = {}
}

-- should catch creation of all raid groups, main tank, raid pet frames etc
hooksecurefunc("CompactUnitFrame_OnLoad", function(frame)
  if not RRFix.loadedCUFs[frame] then
    RRFix.loadedCUFs[frame] = true
  end
end)

-- seem to be created before our code is loaded
for i = 1, 5 do
  RRFix.loadedCUFs[_G["CompactPartyFrameMember" .. i]] = true
  RRFix.loadedCUFs[_G["CompactPartyFramePet" .. i]] = true
end

local updater = CreateFrame("Frame")
local elapsed = 0
local throttleSeconds = 0.2

updater:SetScript("OnUpdate", function(_, dt)
  elapsed = elapsed + dt
  if elapsed < throttleSeconds then return end
  elapsed = 0

  for frame in pairs(RRFix.loadedCUFs) do
    if frame and frame:IsShown() then
      local unit = frame.displayedUnit
      if unit and unit ~= "" then
        local inRange = UnitInRange(unit)
        frame:SetAlpha(inRange and 1 or 0.55)
      end
    end
  end
end)

StaticPopupDialogs["RANGE_FIX_WARNING"] = {
  text =
  "UNIT_IN_RANGE_UPDATE event fired. Maybe blizzard has fixed the event.\nConsider disabling this RaidRangeFix addon.",
  button1 = "OK",
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
}

updater:RegisterEvent("UNIT_IN_RANGE_UPDATE")
updater:SetScript("OnEvent", function()
  updater:UnregisterEvent("UNIT_IN_RANGE_UPDATE")
  StaticPopup_Show("RANGE_FIX_WARNING")
end)