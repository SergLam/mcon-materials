//
//  ScanSystem.swift
//  Sky (iOS)
//
//  Created by Serhii Liamtsev on 1/16/22.
//

import Foundation

actor ScanSystem {
  
  let name: String
  let service: ScanTransport?
  
  private(set) var count = 0
  
  init(name: String, service: ScanTransport? = nil) {
    self.name = name
    self.service = service
  }
  
  func commit() {
    count += 1
  }
  
  func run(_ task: ScanTask) async throws -> String {
    defer {
      count -= 1
    }
    if let service = service {
      return try await service.send(task: task, to: name)
    } else {
      return try await task.run()
    }
  }
}
