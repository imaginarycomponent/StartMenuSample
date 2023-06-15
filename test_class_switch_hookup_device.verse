
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
test_class_switch_hookup_device := class(creative_device):

    @editable VoteManager : vote_manager_device = vote_manager_device{}
    @editable Button : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        Button.InteractedWithEvent.Subscribe(CallVoteClassSwitch)
        return

    CallVoteClassSwitch (AgentIn : agent) : void =
        Print("Calling Class Switch To Follow Vote.")
        VoteManager.GetWinnerAndSetClass()