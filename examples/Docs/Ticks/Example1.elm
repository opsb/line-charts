module Docs.Ticks.Example1 exposing (main)


import Time
import Html
import LineChart
import LineChart.Colors as Colors
import LineChart.Junk as Junk
import LineChart.Area as Area
import LineChart.Axis as Axis
import LineChart.Axis.Title as Title
import LineChart.Axis.Range as Range
import LineChart.Axis.Line as AxisLine
import LineChart.Axis.Ticks as Ticks
import LineChart.Axis.Tick as Tick
import LineChart.Junk as Junk
import LineChart.Dots as Dots
import LineChart.Grid as Grid
import LineChart.Dots as Dots
import LineChart.Line as Line
import LineChart.Colors as Colors
import LineChart.Events as Events
import LineChart.Legends as Legends
import LineChart.Container as Container
import LineChart.Interpolation as Interpolation
import LineChart.Axis.Intersection as Intersection



main : Html.Html msg
main =
  chart


chart : Html.Html msg
chart =
  LineChart.viewCustom
    { x = xAxisConfig
    , y = Axis.default 400 "($)" .income
    , container = Container.default "line-chart-1"
    , interpolation = Interpolation.default
    , intersection = Intersection.default
    , legends = Legends.default
    , events = Events.default
    , junk = Junk.default
    , grid = Grid.default
    , area = Area.default
    , line = Line.default
    , dots = Dots.default
    }
    [ LineChart.line Colors.blueLight Dots.square "Chuck" chuck
    , LineChart.line Colors.pinkLight Dots.plus "Alice" alice
    , LineChart.line Colors.goldLight Dots.diamond "Bobby" bobby
    ]


xAxisConfig : Axis.Config Data msg
xAxisConfig =
  Axis.custom
    { title = Title.default "Weight"
    , variable = Just << .weight
    , pixels = 700
    , range = Range.default
    , axisLine = AxisLine.rangeFrame Colors.gray
    , ticks = ticksConfig
    }


ticksConfig : Ticks.Config msg
ticksConfig =
  -- Ticks.int 7
  -- Ticks.time 7
  -- Ticks.float 7
  Ticks.intCustom 7 someCustomTick



someCustomTick : Int -> Tick.Config msg
someCustomTick number =
  Tick.custom
    { position = toFloat number
    , color = Colors.black
    , width = 2
    , length = 2
    , grid = True
    , direction = Tick.negative
    , label = Just (Junk.label Colors.black (String.fromInt number))
    }



-- DATA


type alias Data =
  { age : Float
  , weight : Float
  , height : Float
  , income : Float
  , date : Time.Posix
  }


alice : List Data
alice =
  [ Data 4  24 0.94 0     (dateInterval 0)
  , Data 25 75 1.73 25000 (dateInterval 1)
  , Data 46 83 1.75 40000 (dateInterval 2)
  ]


bobby : List Data
bobby =
  [ Data 4  22 1.01 0     (dateInterval 0)
  , Data 25 75 1.87 28000 (dateInterval 1)
  , Data 46 77 1.87 52000 (dateInterval 2)
  ]


chuck : List Data
chuck =
  [ Data 4  21 0.98 0      (dateInterval 0)
  , Data 25 89 1.83 85000  (dateInterval 1)
  , Data 46 95 1.84 120000 (dateInterval 2)
  ]


average : List Data
average =
  [ Data 4  22.3 1.0  0     (dateInterval 0)
  , Data 25 79.7 1.8  46000 (dateInterval 1)
  , Data 46 85   1.82 70667 (dateInterval 2)
  ]


-- Creates a magic time interval
dateInterval : Float -> Time.Posix
dateInterval i =
  let
    magicHoursInterval =
      4 + i * 21 -- Feel free to change this
  in
  magicHoursInterval |> hoursToMillis |> Time.millisToPosix


-- Converts hours to miliseconds
hoursToMillis : Float -> Int
hoursToMillis h =
  h * millisPerHour |> round

millisPerHour =
  60 * 60 * 1000
