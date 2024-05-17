import Foundation

struct LevelItem {
    var id: String
    var levelNum: Int
    var gameFieldData: GameFieldData
    var time: Int
}

struct GameFieldData {
    var obstacles: [[Int]]
    var chainBlocks: [(Int, Int)] // (x, y)
}

let gameLevels = [
    LevelItem(id: "level1", levelNum: 1, gameFieldData: gameFieldDataItems[0], time: 12),
    LevelItem(id: "level2", levelNum: 2, gameFieldData: gameFieldDataItems[1], time: 15),
    LevelItem(id: "level3", levelNum: 3, gameFieldData: gameFieldDataItems[2], time: 12),
    LevelItem(id: "level4", levelNum: 4, gameFieldData: gameFieldDataItems[3], time: 12),
    LevelItem(id: "level5", levelNum: 5, gameFieldData: gameFieldDataItems[4], time: 12),
    LevelItem(id: "level6", levelNum: 6, gameFieldData: gameFieldDataItems[5], time: 10),
    LevelItem(id: "level7", levelNum: 7, gameFieldData: gameFieldDataItems[6], time: 10),
    LevelItem(id: "level8", levelNum: 8, gameFieldData: gameFieldDataItems[7], time: 10),
    LevelItem(id: "level9", levelNum: 9, gameFieldData: gameFieldDataItems[8], time: 10),
    LevelItem(id: "level10", levelNum: 10, gameFieldData: gameFieldDataItems[9], time: 10),
    LevelItem(id: "level11", levelNum: 11, gameFieldData: gameFieldDataItems[10], time: 10),
    LevelItem(id: "level12", levelNum: 12, gameFieldData: gameFieldDataItems[11], time: 9),
    LevelItem(id: "level13", levelNum: 13, gameFieldData: gameFieldDataItems[12], time: 9),
    LevelItem(id: "level14", levelNum: 14, gameFieldData: gameFieldDataItems[13], time: 9),
    LevelItem(id: "level15", levelNum: 15, gameFieldData: gameFieldDataItems[7], time: 9),
    LevelItem(id: "level16", levelNum: 16, gameFieldData: gameFieldDataItems[6], time: 9),
    LevelItem(id: "level17", levelNum: 17, gameFieldData: gameFieldDataItems[3], time: 9),
    LevelItem(id: "level18", levelNum: 18, gameFieldData: gameFieldDataItems[4], time: 9),
    LevelItem(id: "level19", levelNum: 19, gameFieldData: gameFieldDataItems[2], time: 9),
    LevelItem(id: "level20", levelNum: 20, gameFieldData: gameFieldDataItems[1], time: 9),
    LevelItem(id: "level21", levelNum: 21, gameFieldData: gameFieldDataItems[9], time: 8)
]

var gameFieldDataItems = [
    GameFieldData(obstacles: [
        [0,0,0,0,1,0,1,1,1],
        [0,1,1,0,1,0,1,1,1],
        [0,1,1,0,1,0,1,1,1],
        [0,0,0,0,0,0,0,0,0],
        [1,1,1,0,1,0,1,1,0],
        [1,1,1,0,1,0,1,1,0],
        [1,1,1,0,1,0,0,0,0]
    ], chainBlocks: [(0, 0), (8, 6)]),
    GameFieldData(obstacles: [
        [0,0,0,0,0,0,0,0,0,0,0,0],
        [0,1,1,1,1,1,1,0,1,1,1,0],
        [0,1,0,0,0,1,1,0,1,0,0,0],
        [0,1,1,1,0,1,1,0,1,1,1,1],
        [0,0,0,0,0,1,0,0,1,0,0,0],
        [0,1,1,1,1,1,1,0,1,0,1,0],
        [0,1,0,0,0,1,1,0,1,0,1,0],
        [0,1,1,1,0,1,1,0,1,1,1,0],
        [0,0,0,0,0,1,1,0,0,0,0,0],
    ], chainBlocks: [(9, 6), (2, 2)]),
    GameFieldData(obstacles: [
        [0,0,0,0,0,0,0,0,0,1,0,0],
        [0,0,0,0,0,1,0,0,0,0,0,0],
        [0,1,0,0,0,0,0,0,1,0,0,0],
        [0,0,0,0,0,0,1,0,1,0,0,1],
        [0,0,0,0,0,1,0,0,1,0,0,0],
        [0,0,0,0,0,0,1,0,1,0,1,0],
        [0,0,0,0,0,0,0,0,1,0,1,0],
        [0,1,0,0,0,0,0,0,1,1,1,0],
        [0,0,0,0,0,1,1,0,0,0,0,0],
    ], chainBlocks: [(9, 8), (0, 7)]),
    GameFieldData(obstacles: [
        [0,0,0,0,0,0],
        [0,1,1,1,1,1],
        [0,1,0,0,0,1],
        [0,1,0,0,0,1],
        [0,1,1,1,0,1],
        [0,0,0,0,0,0]
    ], chainBlocks: [(5, 0), (2, 2)]),
    GameFieldData(obstacles: [
        [0,0,1,0,0,0],
        [0,0,0,0,0,0],
        [0,0,1,0,1,1],
        [0,1,0,0,0,1],
        [0,0,0,0,1,0],
        [0,1,0,0,1,0]
    ], chainBlocks: [(5, 0), (0, 5)]),
    GameFieldData(obstacles: [
        [0,0,0,1,0,0,0],
        [0,0,0,1,0,0,0],
        [0,0,0,0,0,0,0],
        [0,0,0,1,0,0,0],
        [0,1,1,1,0,0,0],
        [0,0,0,1,0,0,0]
    ], chainBlocks: [(6, 0), (2, 5)]),
    GameFieldData(obstacles: [
        [0,0,0,0,0,0,1,1,0,1,0,0],
        [0,0,0,0,0,1,0,0,0,0,0,0],
        [0,1,0,0,0,0,0,0,1,0,0,0],
        [0,0,0,1,1,0,1,0,1,0,0,1],
        [0,0,0,0,0,1,0,0,1,0,0,0],
        [0,0,0,0,0,0,1,0,1,0,1,0],
        [0,0,0,1,1,0,0,1,1,0,1,0],
        [0,1,0,1,1,0,0,0,1,1,1,0],
        [0,0,0,0,0,1,1,0,0,0,0,0],
    ], chainBlocks: [(9, 8), (0, 7)]),
    GameFieldData(obstacles: [
        [0,0,0,0,0,0,0,0,0,0,0,0],
        [0,1,1,1,1,1,1,0,1,1,1,0],
        [0,1,0,0,0,1,1,0,1,0,0,0],
        [0,1,1,1,0,1,1,0,1,1,1,1],
        [0,0,0,0,0,1,0,0,1,0,0,0],
        [0,1,1,1,1,1,1,0,1,0,1,0],
        [0,1,0,0,0,1,1,0,1,0,1,0],
        [0,1,1,1,0,1,1,0,1,1,1,0],
        [0,0,0,0,0,1,1,0,0,0,0,0],
    ], chainBlocks: [(9, 6), (2, 2)]),
    GameFieldData(obstacles: [
        [0,0,0,1,0,0,0],
        [0,1,0,1,0,1,0],
        [0,1,0,0,0,1,0],
        [0,1,1,1,1,1,0],
        [0,1,1,1,1,1,0],
        [0,0,0,1,0,0,0]
    ], chainBlocks: [(6, 0), (2, 5)]),
    GameFieldData(obstacles: [
        [0,0,0,1,0,0,0],
        [0,1,0,1,0,1,0],
        [0,1,0,0,0,1,0],
        [0,1,1,1,1,1,0],
        [0,1,1,1,1,1,0],
        [0,0,0,1,0,0,0]
    ], chainBlocks: [(6, 5), (2, 5)]),
    GameFieldData(obstacles: [
        [0,0,0,1,0,0,0],
        [0,1,0,1,0,1,0],
        [0,1,0,0,0,1,0],
        [1,1,0,1,1,1,0],
        [0,1,0,1,1,1,0],
        [0,0,0,1,0,0,0]
    ], chainBlocks: [(6, 2), (2, 5)]),
    GameFieldData(obstacles: [
        [0,0,0,0,1,0,1,1,1],
        [0,1,1,0,1,0,1,0,1],
        [0,1,0,0,0,0,1,0,1],
        [0,0,0,0,0,0,0,0,0],
        [1,1,1,0,1,0,1,1,0],
        [1,0,0,0,1,0,1,1,0],
        [1,1,1,0,1,0,0,0,0]
    ], chainBlocks: [(0, 0), (8, 6)]),
    GameFieldData(obstacles: [
        [0,0,1,0,1,0,1,1,1],
        [1,0,0,0,1,0,1,0,1],
        [1,1,0,1,0,0,1,0,1],
        [0,0,0,0,0,0,0,0,0],
        [1,1,1,0,1,0,1,1,0],
        [1,0,0,0,1,0,1,1,0],
        [1,1,1,0,1,0,0,0,0]
    ], chainBlocks: [(0, 0), (8, 6)]),
    GameFieldData(obstacles: [
        [0,1,0,0,0,1,1],
        [0,1,0,1,0,1,1],
        [1,0,0,1,0,0,0],
        [1,0,1,1,1,0,0],
        [0,0,1,1,1,0,1],
        [0,0,0,1,0,0,0]
    ], chainBlocks: [(4, 5), (2, 5)]),
]
