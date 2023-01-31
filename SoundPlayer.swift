//
//  SoundPlayer.swift
//  Russian Roulette
//
//  Created by Shimpei on 2022/12/23.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
    let PatterA = NSDataAsset(name: "success")!.data
    let PatterB = NSDataAsset(name: "lose")!.data
    let PatterC = NSDataAsset(name: "start")!.data
    var PlayerA: AVAudioPlayer!
    var PlayerB: AVAudioPlayer!
    var PlayerC: AVAudioPlayer!
    
    func PlayA() {
        do {
            PlayerA = try AVAudioPlayer(data: PatterA)
            PlayerA.play()
        } catch {
            print("")
        }
    }
    
    func PlayB() {
        do {
            PlayerB = try AVAudioPlayer(data: PatterB)
            PlayerB.play()
        } catch {
            print("")
        }
    }
    
    func PlayC() {
        do {
            PlayerC = try AVAudioPlayer(data: PatterC)
            PlayerC.play()
        } catch {
            print("")
        }
    }
}

