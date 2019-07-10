import XMonad
import XMonad.Layout.Hidden
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig ( additionalKeys )
import qualified Data.Map as M

main :: IO ()
main = do
  xmonad $ defaultConfig
    { borderWidth        = 6
    , modMask            = mod4Mask -- Use Super instead of Alt
    , terminal           = "alacritty"
    , focusedBorderColor = "#a57b55"
    , normalBorderColor  = "#272524"
    , layoutHook         = myLayout
    } `additionalKeys` myKeys

windowMargin = 6
goldenRatio = toRational (2/(1+sqrt(5)::Double)) -- golden ratio

myLayout = spacingWithEdge windowMargin $ hiddenWindows $ ThreeColMid 1 (1/24) goldenRatio

-- myLayout = hiddenWindows (Tall 1 (3/100) (1/2)) ||| Full ||| etc..
-- main = xmonad def { layoutHook = myLayout }

myKeys = [ ((mod4Mask, xK_x), spawn "slock")
         , ((mod4Mask, xK_s), spawn "slock & systemctl suspend")
         , ((mod4Mask, xK_backslash), withFocused hideWindow)
         , ((mod4Mask .|. shiftMask, xK_backslash), popOldestHiddenWindow)
         -- TODO shellPrompt isn't doing anything
         , ((mod4Mask, xK_o), shellPrompt myXPConfig)
         ]

myXPConfig = defaultXPConfig
             { font              = "-misc-fixed-*-*-*-*-12-*-*-*-*-*-*-*"
             , bgColor           = "grey22"
             , fgColor           = "grey80"
             , fgHLight          = "black"
             , bgHLight          = "grey"
             , borderColor       = "white"
             , position          = Top
             , height            = 32
             }
