//
//  MatchesInLeagueController.swift
//  Bet Helper
//
//  Created by Vladyslav Zhulavskyi on 2/14/19.
//  Copyright © 2019 Vladyslav Zhulavskyi. All rights reserved.
//

import UIKit

class MatchesInLeagueController {
}
final class MatchesInLeague {
    var api: API
    init(api: API) {
        self.api = api
    }
}
final class API {
    var results: Int
    var fixtures: [String: Fixture]
    init(results: Int, fixtures: [String: Fixture]) {
        self.results = results
        self.fixtures = fixtures
    }
}
final class Fixture {
    var fixtureID: String
    var eventDate: String
    var leagueID, round, homeTeamID, awayTeamID: String
    var homeTeam, awayTeam: String
    
    init(fixtureID: String, eventDate: String, leagueID: String, round: String, homeTeamID: String, awayTeamID: String, homeTeam: String, awayTeam: String) {
        self.fixtureID = fixtureID
        self.eventDate = eventDate
        self.leagueID = leagueID
        self.round = round
        self.homeTeamID = homeTeamID
        self.awayTeamID = awayTeamID
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
}
extension MatchesInLeague: Decodable {
    private enum Key: String, CodingKey {
        case api
    }
    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Key.self)
        let api = try values.decode(API.self, forKey: .api)
        self.init(api: api)
    }
}
extension API: Decodable {
    private enum Key: String, CodingKey {
        case results
        case fixtures
    }
    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Key.self)
        let results = try values.decode(Int.self, forKey: .results)
        let fixtures = try values.decode([String: Fixture].self, forKey: .fixtures)
        self.init(results: results, fixtures: fixtures)
    }
}
extension Fixture: Decodable {
    private enum Key: String, CodingKey {
        case fixtureID = "fixture_id"
        case eventDate = "event_date"
        case leagueID = "league_id"
        case round
        case homeTeamID = "homeTeam_id"
        case awayTeamID = "awayTeam_id"
        case homeTeam
        case awayTeam
    }
    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Key.self)
        let fixtureID = try values.decode(String.self, forKey: .fixtureID)
        let eventDate = try values.decode(String.self, forKey: .eventDate)
        let leagueID = try values.decode(String.self, forKey: .leagueID)
        let round = try values.decode(String.self, forKey: .round)
        let homeTeamID = try values.decode(String.self, forKey: .homeTeamID)
        let awayTeamID = try values.decode(String.self, forKey: .awayTeamID)
        let homeTeam = try values.decode(String.self, forKey: .homeTeam)
        let awayTeam = try values.decode(String.self, forKey: .awayTeam)
        
        self.init(fixtureID: fixtureID, eventDate: eventDate, leagueID: leagueID, round: round, homeTeamID: homeTeamID, awayTeamID: awayTeamID, homeTeam: homeTeam, awayTeam: awayTeam)
    }
}
