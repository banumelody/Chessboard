//
//  ViewController.swift
//  Chessboard
//
//  Created by Banu Antoro on 6/20/16.
//  Copyright © 2016 Banu Desi Antoro. All rights reserved.
//

import UIKit
import Alamofire
import SocketIOClientSwift

class ViewController: UIViewController {

    var board = Board()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        board = Board.init(frame:CGRect(x: 0, y: 0, width:self.view.bounds.width, height: self.view.bounds.width))
        
        view.addSubview(board)
        
//        let socket = SocketIOClient(socketURL: NSURL(string: "http://xinuc.org:7387")!, options: [.Log(true), .ForcePolling(true)])
//        
//        socket.on("connect") {data, ack in
//            print("socket connected")
//        }
//        
//        socket.on("currentAmount") {data, ack in
//            if let cur = data[0] as? Double {
//                socket.emitWithAck("canUpdate", cur)(timeoutAfter: 0) {data in
//                    socket.emit("update", ["amount": cur + 2.50])
//                }
//                
//                ack.with("Got your currentAmount", "dude")
//            }
//        }
//        
//        socket.connect()

        let conn = Connection()
        conn.connect("xinuc.org", port: 7387)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshButtonAction(sender: AnyObject) {
        
        print(board.blocks[1][1])
        
        board.clearBoard()
        
        Alamofire.request(.GET, "http://mobile.suitmedia.com/bl/chess.php", parameters: [:])
            .responseString { response in
                
                let data = response.result.value
                var possitions = data!.componentsSeparatedByString("<br/>")
                possitions.removeLast()
                
                self.board.refreshIcon(possitions)
                
                
        }
        
    }


}

class Connection: NSObject, NSStreamDelegate {
    var host:String?
    var port:Int?
    var inputStream: NSInputStream?
    var outputStream: NSOutputStream?
    
    func connect(host: String, port: Int) {
        
        self.host = host
        self.port = port
        
        NSStream.getStreamsToHostWithName(host, port: port, inputStream: &inputStream, outputStream: &outputStream)
        
        if inputStream != nil && outputStream != nil {
            
            // Set delegate
            inputStream!.delegate = self
            outputStream!.delegate = self
            
            // Schedule
            inputStream!.scheduleInRunLoop(.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            outputStream!.scheduleInRunLoop(.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            
            print("Start open()")
            
            // Open!
            inputStream!.open()
            outputStream!.open()
        }
    }
    
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        if aStream === inputStream {
            switch eventCode {
            case NSStreamEvent.ErrorOccurred:
                print("input: ErrorOccurred: \(aStream.streamError?.description)")
            case NSStreamEvent.OpenCompleted:
                print("input: OpenCompleted")
            case NSStreamEvent.HasBytesAvailable:
                print("input: HasBytesAvailable")
                
                // Here you can `read()` from `inputStream`
                
            default:
                break
            }
        }
        else if aStream === outputStream {
            switch eventCode {
            case NSStreamEvent.ErrorOccurred:
                print("output: ErrorOccurred: \(aStream.streamError?.description)")
            case NSStreamEvent.OpenCompleted:
                print("output: OpenCompleted")
            case NSStreamEvent.HasSpaceAvailable:
                print("output: HasSpaceAvailable")
                
                // Here you can write() to `outputStream`
                
            default:
                break
            }
        }
    }
    
}

