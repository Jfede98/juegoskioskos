pragma Singleton
import Felgo 3.0
import QtQuick 2.0

SlotMachineModel {

  // configure symbols and frequency of each symbol per reel
  symbols: {
    "cherry":      {
      frequency: 5,
      data: {
        source: "icon-cherry.png",
        winFactor: [1, 5, 20]
      }
    }, // 5 x cherry

    "watermelon":      {
      frequency: 5,
      data: {
        source: "icon-watermelon.png",
        winFactor: [1, 5, 20]
      }
    }, // 5 x watermelon

    "heart":        {
      frequency: 5,
      data: {
        source: "icon-heart.png",
        winFactor: [1, 5, 20]
      }
    }, // 5 x heart


    "bell":        {
      frequency: 4,
      data: {
        source: "icon-bell.png",
        winFactor: [1, 8, 30]
      }
    }, // 4 x bell


    "seven":   {
      frequency: 3,
      data: {
        source: "icon-seven.png",
        winFactor: [6, 20, 150]
      }
    }, // 3 x seven


  }

  // return symbol data for specific symbol
  function getSymbolData(symbol) {
    if(symbols[symbol] === undefined)
      return null
    else
      return symbols[symbol].data
  }

  // return win factor for specific type and line length
  function getWinFactor(symbol, length) {
    var symbolData = getSymbolData(symbol)
    if(symbolData === null)
      return 0

    var index = length - 3 // length 3 = index 0, length 4 = index 1, ...
    if(symbolData.winFactor === undefined || symbolData.winFactor[index] === undefined)
      return 0

    return symbolData.winFactor[index]
  }
}
