//
//  UserService.swift
//  RenderforestTask
//
//  Created by Alvard Dallakyan on 29.01.21.
//

import Foundation
import Moya

enum UserService {
	case readUsers(seed:String, results: Int, page: Int)
}

extension UserService: TargetType {
	var baseURL: URL {
		guard let url = URL(string: "https://randomuser.me/") else { fatalError() }
			   return url
	}
	
	var path: String {
		return "api"
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		 case .readUsers(let seed , let results, let page):
			return .requestParameters(parameters: ["seed" :seed , "results" : results , "page" : page], encoding: URLEncoding.queryString)
		}
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
}
