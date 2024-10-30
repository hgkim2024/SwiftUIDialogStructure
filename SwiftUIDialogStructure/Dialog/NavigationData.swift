//
//  NavigationData.swift
//  SwiftUIDialogStructure
//
//  Created by 김현구 on 10/29/24.
//

import Foundation
import SwiftUI

class NavigationData: ObservableObject {
    
    static let shared = NavigationData()
    static let mock = NavigationData()
    
    @Published var path = NavigationPath()
    
    @MainActor
    func clear() {
        path.removeLast(path.count)
    }
    
    func append(_ type: NavigationStackType) {
        path.append(type.rawValue)
    }
    
    func removePaths(_ type: NavigationStackType) {
        removePaths(upto: type.rawValue)
    }
    
    func removePaths(upto target: String) {
        // TODO: - 아직 테스트 진행 중인 함수, 이렇게 사용해도 문제 없을지 모르겠다. 다음 프로젝트에 적용해봐야겠다.
        
        /*
         참고 사이트
         https://www.pointfree.co/blog/posts/78-reverse-engineering-swiftui-s-navigationpath-codability
         */
        
        if let codable = path.codable {
            
            do {
                let data = try JSONEncoder().encode(codable)
                let str = String(decoding: data, as: UTF8.self)
                Log.tag(.LOG).d(String(decoding: data, as: UTF8.self))
                let list = str
                    .replacingOccurrences(of: " ", with: "")
                    .replacingOccurrences(of: "[", with: "")
                    .replacingOccurrences(of: "]", with: "")
                    .replacingOccurrences(of: "\"", with: "")
                    .replacingOccurrences(of: "\\", with: "")
                    .split(separator: ",").filter { $0 != "Swift.String" }
                
                var find = false
                var count = 0
                
                for item in list {
                    let str = String(item)
                    Log.tag(.LOG).d(str)
                    if str == target {
                        find = true
                        break
                    }
                    count += 1
                }
                
                assert(find)
                assert(count <= path.count)
                
                path.removeLast(count)
            } catch {
                assert(false)
            }
        }
    }
}
