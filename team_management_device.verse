
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
team_management_device := class(creative_device):
    @editable TeamChoiceTeleporter : teleporter_device = teleporter_device{}
    @editable TeamPlayerCounter : team_player_counter_device = team_player_counter_device{}
    @editable var TeamID : int = 1

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        TeamChoiceTeleporter.EnterEvent.Subscribe(ChooseTeam)
        return

    ChooseTeam(AgentIn : agent) : void =
        Print("Team Chosen.")
        TeamCollection := GetPlayspace().GetTeamCollection()
        Teams : []team = TeamCollection.GetTeams()
        TeamPlayerCounter.DecrementAgentTeamCount(AgentIn)
        if (TeamCollection.AddToTeam[AgentIn, Teams[TeamID-1]]):
            TeamPlayerCounter.IncrementAgentTeamCount(AgentIn)
