
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/Diagnostics }

team_player_counter_device := class(creative_device):
    var TeamOneCount : int = 0
    var TeamTwoCount : int = 0
    @editable BillboardTeamOne : billboard_device = billboard_device{}
    @editable BillboardTeamTwo : billboard_device = billboard_device{}
    @editable PregameSpawners : []player_spawner_device = array{}

    OnBegin<override>()<suspends>:void=
        for(CurrentElement : PregameSpawners):
            CurrentElement.SpawnedEvent.Subscribe(IncrementAgentTeamCount)
        return

    UpdateBillboards() : void =
        BillboardTeamOne.SetText(StringToMessage(ToString(TeamOneCount)))
        BillboardTeamTwo.SetText(StringToMessage(ToString(TeamTwoCount)))

    DecrementAgentTeamCount(AgentIn : agent) : void =
        AgentTeamNumber := GetAgentTeamNumber(AgentIn)
        DecrementTeamCount(AgentTeamNumber + 1)
        UpdateBillboards()

    IncrementAgentTeamCount(AgentIn : agent) : void =
        AgentTeamNumber := GetAgentTeamNumber(AgentIn)
        IncrementTeamCount(AgentTeamNumber + 1)
        UpdateBillboards()

    GetAgentTeamNumber(AgentIn : agent) : int =
        TeamCollection := GetPlayspace().GetTeamCollection()
        if (AgentsTeam := TeamCollection.GetTeam[AgentIn]):
            TeamArray := TeamCollection.GetTeams()
            for (TeamNumber->Team : TeamArray):
                if (AgentsTeam = Team):
                    return TeamNumber
        return 0
    
    DecrementTeamCount(TeamID : int) : void =
        if (TeamID = 1):
            set TeamOneCount = TeamOneCount - 1
        else if (TeamID = 2):
            set TeamTwoCount = TeamTwoCount - 1                    
        else:
            return
                                                        
    IncrementTeamCount(TeamID : int) : void =
        if (TeamID = 1):
            set TeamOneCount = TeamOneCount + 1
        else if (TeamID = 2):
            set TeamTwoCount = TeamTwoCount + 1                    
        else:
            return

    StringToMessage<localizes>(value:string) : message = "{value}"