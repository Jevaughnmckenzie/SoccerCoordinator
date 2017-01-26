// A dictionary of player information [Name : [Height, Has Experience?, Guardian Name(s)]]

var players = [
    "Joe Smith" : ["42", "yes", "Jim and Jan Smith"],
    "Arnold Willis" : ["43", "no", "Claire Willis"],
    "Philip Helm" : ["44", "yes", "Thomas Helm and Eva Jones"],
    "Les Clay" : ["42", "yes", "Wynonna Brown"],
    "Herschel Krustofski" : ["45", "yes", "Hyman and Rachel Krustofski"],
    "Sammy Adams" : ["45", "no", "Jeff Adams"],
    "Karl Saygan" : ["42", "yes", "Heather Bledsoe"],
    "Suzane Greenberg" : ["44", "yes", "Henrietta Dumas"],
    "Sal Dali" : ["41", "no", "Gala Dali"],
    "Joe Kavalier" : ["39", "no", "Sam and Elaine Kavalier"],
    "Jill Tanner" : ["36", "yes", "Clara Tanner"],
    "Bill Bon" : ["43", "yes", "Sara and Jenny Bon"],
    "Eva Gordon" : ["45", "no", "Wendy and Mike"],
    "Matt Gill" : ["40", "no", "Charles and Sylvia Gill" ],
    "Kimmy Stein" : ["41", "no", "Bill and Hillary Stein"],
    "Ben Finkelstein" : ["44", "no", "Aaron and Jill Finkelstein"],
    "Diego Soto" : ["41", "yes", "Robin and Sarika Soto"],
    "Chloe Alaska" : ["47", "no", "David and Jamie Alaska"]
]

let teams = [
    "Sharks", "Dragons", "Raptors"
]

let sharksPracticeDay = "March 17, 3pm"
let dragonsPracticeDay = "March 17, 1pm"
let raptorsPracticeDay = "March 18, 1pm"

// Core numbers for calculations
let numberOfPlayers = players.count
let numberOfTeams = teams.count
let numberOfPlayersOnTeams = numberOfPlayers / numberOfTeams
var numberOfExperiencedPlayers: Int = 0
var numberOfInexperiencedPlayers: Int = 0
let allowableAverageTeamHeightError = 1.5 //Given in problem

// Holds the final team lineup
var teamSharks = [String : Array<String>]()
var teamDragons  = [String : Array<String>]()
var teamRaptors = [String : Array<String>]()

// Will hold all letters to the gaurdians
var letters = [String]()

// Filters the experienced and inexperienced players before the drafting process
func findTheExperienced(players: [String : Array<String>]) {
    for player in players {
        let playerExperience: String = player.value[1]
        if playerExperience == "yes" {
            numberOfExperiencedPlayers += 1
        } else {
            numberOfInexperiencedPlayers += 1
        }
    }
}

// Calculates average Height for all players
func averageHeightOf(all: [String : Array<String>]) -> Double {
    var teamHeight: Double = 0
    var playerHeights = [String : Double]()
    
    for player in all {
        let height = Double(player.value[0])!
        playerHeights[player.key] = height
        teamHeight += height
    }
    
    let averageHeight = teamHeight / Double(numberOfPlayers)
    return averageHeight
}

// Used for calculations in the team draft function
let averageHeightOfAllPlayers = averageHeightOf(all: players)
let idealTotalTeamHeight = averageHeightOfAllPlayers * Double(numberOfPlayersOnTeams)

// Calculates the average height for each team
func averageHeight(of team: [String : Array<String>]) {
    var teamHeight: Double = 0
    var playerHeights = [String : Double]()
    
    for player in team {
        let height = Double(player.value[0])!
        playerHeights[player.key] = height
       teamHeight += height
    }

    let averageHeight = teamHeight / Double(numberOfPlayersOnTeams)
    
     print(averageHeight)
}

// Loops through players array to form the three teams

func teamDraft(for team: [String : Array<String>]) -> [String : Array<String>] {
    
    var experienced = [String : Array<String>] ()
    var inexperienced = [String : Array<String>] ()
    var playerCounter = 0
    var teamTotalHeight: Double = 0
    
    for player in players {
        let playerExperience: String = player.value[1]
        let height = Double(player.value[0])!
        
        if playerCounter == numberOfPlayersOnTeams {
            break
        }
        if teamTotalHeight + height > idealTotalTeamHeight - allowableAverageTeamHeightError && teamTotalHeight + height < idealTotalTeamHeight + allowableAverageTeamHeightError  {
            continue
        } else {
            switch playerExperience {
            case "yes":
                if experienced.count < (numberOfExperiencedPlayers / numberOfTeams) {
                    experienced[player.key] = player.value
                    teamTotalHeight += height
                    players.removeValue(forKey: player.key)
                } else {
                    continue
                }
            default:
                if inexperienced.count < (numberOfInexperiencedPlayers / numberOfTeams) {
                    inexperienced[player.key] = player.value
                    teamTotalHeight += height
                    players.removeValue(forKey: player.key)
                } else {
                    continue
                }
            }
        }
        
        playerCounter += 1
    }
    var newTeam = [String : Array<String>]()
    
    // Will be used to combine the experienced and inexperienced picks into one team
    func balanceExperience(_ group: [String : Array<String>]) {
        for player in group {
            newTeam[player.key] = player.value
        }
    }
    
    balanceExperience(inexperienced)
    balanceExperience(experienced)
    
    print(averageHeight(of: newTeam))
    return newTeam
}


// Letters

func lettersToGuardians(of team: [String : Array<String>], teamName: String, practiceDay: String) {
    var playerName: String
    var gaurdianName: String
    var letter: String
    
    for teamMember in team {
        playerName = teamMember.key
        gaurdianName = teamMember.value[2]
        letter = "Dear \(gaurdianName),\n\nYour child, \(playerName), has been selcted to be a part of team \(teamName). Your child's first practice will be on \(practiceDay). Please make sure your child is on time.\n\nSincerely,\nCoach McKenzie\n"
        print(letter)
        letters.append(letter)
    }
}

// ---------------------- Code Checks ----------------------------


findTheExperienced(players: players)
teamSharks = teamDraft(for: teamSharks)
teamDragons = teamDraft(for: teamDragons)
teamRaptors = teamDraft(for: teamRaptors)

lettersToGuardians(of: teamSharks, teamName: teams[0], practiceDay: sharksPracticeDay)
lettersToGuardians(of: teamDragons, teamName: teams[1], practiceDay: dragonsPracticeDay)
lettersToGuardians(of: teamRaptors, teamName: teams[2], practiceDay: raptorsPracticeDay)

print(letters)































































