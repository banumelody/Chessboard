//
//  SocketIOManager.swift
//  Chessboard
//
//  Created by Banu Antoro on 6/20/16.
//  Copyright © 2016 Banu Desi Antoro. All rights reserved.
//

import UIKit
import SocketIOClientSwift


class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(fileURLWithPath: "xinuc.org:7387"))
    
    override init() {
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
}