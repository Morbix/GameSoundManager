//
//  GameSoundManager.swift
//  Sticks HD Swift
//
//  Created by Henrique Morbin on 11/01/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit
import AVFoundation

public class GameSound : NSObject {
    
    public static let shared = GameSound()
    
    private var tracks = [Track]()
    private var sounds = [Sound]()
    
    private let volumeStateKey = "GameSoundManager.VolumeStateKey.State"
    
    private func getNextTrackFrom(current : AVAudioPlayer) -> AVAudioPlayer {
        let currentTrack = tracks.indexOf { (track) -> Bool in
            return track.player == current
        }
        
        if let index = currentTrack {
            if index+1 < tracks.endIndex {
                return tracks[index+1].player
            }else{
                return tracks[0].player
            }
        }
        
        return current
    }
    
    // MARK: Methods
    
    public func addTrack(path: String, type: String, volume : Float = 1.0, rate: Float = 1.0) {
        if let path = NSBundle.mainBundle().pathForResource(path, ofType: type), let player = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path)) {
            
            player.prepareToPlay()
            player.volume = volume
            player.rate = rate
            player.delegate = self
            
            let track = Track(player: player, originalVolume: volume)
            track.setVolumeState(isVolumeOn())
            tracks.append(track)
        }
    }
    
    public func addSound(identifier: String, path: String, type: String, volume : Float = 1.0, rate: Float = 1.0) {
        let sound = Sound(identifier: identifier, path: path, type: type, volume: volume, rate: rate)
        sound.setVolumeState(isVolumeOn())
        sounds.append(sound)
    }
    
    public func playTracks() {
        tracks.first?.player.play()
    }
    
    public func playSound(identifier: String) {
        let soundsToPlay = sounds.filter { (sound) -> Bool in
            return sound.identifier == identifier
        }
        
        for sound in soundsToPlay {
            sound.play()
        }
    }
    
    public func isVolumeOn() -> Bool {
        let defaults = NSUserDefaults()
        
        guard let volumeState = defaults.objectForKey(volumeStateKey) as? String else {
            defaults.setObject("on", forKey: volumeStateKey)
            defaults.synchronize()
            return true
        }
        
        return (volumeState == "on")
    }
    
    public func setVolumeState(on: Bool) {
        NSUserDefaults().setObject(on ? "on" : "off", forKey: volumeStateKey)
        NSUserDefaults().synchronize()
        
        for track in tracks {
            track.setVolumeState(on)
        }
        for sound in sounds {
            sound.setVolumeState(on)
        }
    }
}

extension GameSound : AVAudioPlayerDelegate {
    public func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        let next = getNextTrackFrom(player)
        next.play()
    }
}

private class Track {
    let player: AVAudioPlayer
    private let originalVolume: Float
    
    init(player : AVAudioPlayer, originalVolume : Float) {
        self.player = player
        self.originalVolume = originalVolume
    }
    
    func setVolumeState(on : Bool) {
        player.volume = on ? originalVolume : 0
    }
}

private class Sound {
    
    var identifier : String
    
    private var index = 0
    private var sounds = [AVAudioPlayer]()
    private var originalVolume : Float = 1.0
    
    init(identifier : String, path: String, type: String, volume : Float = 1.0, rate: Float = 1.0) {
        self.identifier = identifier
        self.originalVolume = volume
        
        if let path = NSBundle.mainBundle().pathForResource(path, ofType: type) {
            
            for _ in 1...1 {
                if let player = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path)) {
                    player.prepareToPlay()
                    player.volume = volume
                    player.rate = rate
                    sounds.append(player)
                }
            }
        }
    }
    
    func play() {
        if sounds.count > index {
            let player = sounds[index]
            index += 1
            player.play()
        }
        
        if index >= sounds.count {
            index = 0
        }
    }
    
    func setVolumeState(on : Bool) {
        for player in sounds {
            player.volume = on ? originalVolume : 0
        }
    }
}