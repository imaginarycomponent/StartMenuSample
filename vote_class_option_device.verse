
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
vote_class_option_device := class(creative_device):

    @editable VoteManager : vote_manager_device = vote_manager_device{}
    @editable Teleporter :teleporter_device  = teleporter_device{} 
    @editable Billboard : billboard_device = billboard_device{}
    @editable ClassID : int = 0

    OnBegin<override>()<suspends>:void=
        Teleporter.EnterEvent.Subscribe(PlayerEntersTeleporter)

    PlayerEntersTeleporter(AgentIn : agent) : void =
        #Print("Vote For Class Upcoming.")
        VoteManager.VoteForClass(AgentIn, ClassID)
        #Print("Billboard Update Coming.")
        VoteManager.UpdateOptionBillboards()

    UpdateBillboard() : void =
        var ClassVotes : int = VoteManager.GetVotesForClassID(ClassID)
        Billboard.SetText(StringToMessage(ToString(ClassVotes)))

    StringToMessage<localizes>(value:string) : message = "{value}"