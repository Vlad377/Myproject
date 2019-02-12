//
//  MainController.swift
//  Bet Helper
//
//  Created by Vladyslav Zhulavskyi on 2/7/19.
//  Copyright © 2019 Vladyslav Zhulavskyi. All rights reserved.
//

import UIKit
final class ApiData {
    var api: Leagues
    init(api: Leagues) {
        self.api = api
    }
}
final class Leagues {
    var results: Int
    var leagues: [String: DataLeagues]
    
    init(results: Int, leagues: [String: DataLeagues]) {
        self.results = results
        self.leagues = leagues
    }
}
final class DataLeagues {
    var leagueId: String
    var name: String
    var country: String
    var season: String
    var seasonStart: String
    var seasonEnd: String
    init(leagueId: String, name: String, country: String, season: String, seasonStart: String, seasonEnd: String) {
        self.leagueId = leagueId
        self.name = name
        self.country = country
        self.season = season
        self.seasonStart = seasonStart
        self.seasonEnd = seasonEnd
    }
}
class MainController {
}
extension ApiData: Decodable {
    private enum Key: String, CodingKey {
        case api
    }
    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Key.self)
        let api = try values.decode(Leagues.self, forKey: .api)
        self.init(api: api)
    }
}
extension Leagues: Decodable {
    private enum Key: String, CodingKey {
        case results
        case leagues
    }
    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Key.self)
        let results = try values.decode(Int.self, forKey: .results)
        let leagues = try values.decode([String: DataLeagues].self, forKey: .leagues)
        self.init(results: results, leagues: leagues)
    }
}
extension DataLeagues: Decodable {
    private enum Key: String, CodingKey {
        case leagueId = "league_id"
        case name
        case country
        case season
        case seasonStart = "season_start"
        case seasonEnd = "season_end"
    }
    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Key.self)
        let leagueId = try values.decode(String.self, forKey: .leagueId)
        let name = try values.decode(String.self, forKey: .name)
        let country = try values.decode(String.self, forKey: .country)
        let season = try values.decode(String.self, forKey: .season)
        let seasonStart = try values.decode(String.self, forKey: .seasonStart)
        let seasonEnd = try values.decode(String.self, forKey: .seasonEnd)
        self.init(leagueId: leagueId, name: name, country: country, season: season, seasonStart: seasonStart, seasonEnd: seasonEnd)
    }
}
