module EnglishTests exposing (..)

import Test exposing (..)
import Expect
import Date.Distance exposing (defaultConfig, inWordsWithConfig)
import Date.Distance.Types exposing (Config, Locale)
import Date.Distance.I18n.En as English
import Date exposing (Month(..))
import Date.Extra as Date
import Date.Extra as Date exposing (Interval(..))


testMsg : Config -> String -> String
testMsg config msg =
    if config.includeSeconds then
        msg ++ " (with seconds)"
    else
        msg


t : String -> Config -> Date.Date -> Date.Date -> Test
t msg config d1 d2 =
    test (testMsg config msg) <|
        \() ->
            let
                result =
                    inWordsWithConfig config d1 d2
            in
                Expect.equal result msg


lessThan5 : Test
lessThan5 =
    t "less than 5 seconds"
        { defaultConfig | includeSeconds = True }
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 3 0)


lessThan10 : Test
lessThan10 =
    t "less than 10 seconds"
        { defaultConfig | includeSeconds = True }
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 7 0)


lessThan20 : Test
lessThan20 =
    t "less than 20 seconds"
        { defaultConfig | includeSeconds = True }
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 15 0)


halfAMinute : Test
halfAMinute =
    t "half a minute"
        { defaultConfig | includeSeconds = True }
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 25 0)


lessThanAMinute : Test
lessThanAMinute =
    t "less than a minute"
        { defaultConfig | includeSeconds = True }
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 45 0)


oneMinute : Test
oneMinute =
    t "1 minute"
        { defaultConfig | includeSeconds = True }
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 33 0 0)


lessThanAMinute_ : Test
lessThanAMinute_ =
    t "less than a minute"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 20 0)


oneMinute_ : Test
oneMinute_ =
    t "1 minute"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 50 0)


threeMinutes : Test
threeMinutes =
    t "3 minutes"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 34 50 0)


aboutOneHour : Test
aboutOneHour =
    t "about 1 hour"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 11 32 0 0)


aboutThreeHours : Test
aboutThreeHours =
    t "about 3 hours"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 13 32 0 0)


oneDay : Test
oneDay =
    t "1 day"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 5 10 32 0 0)


threeDays : Test
threeDays =
    t "3 days"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 7 10 32 0 0)


aboutOneMonth : Test
aboutOneMonth =
    t "about 1 month"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Apr 4 10 32 0 0)


threeMonths : Test
threeMonths =
    t "3 months"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Jun 4 10 32 0 0)


aboutOneYear : Test
aboutOneYear =
    t "about 1 year"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1987 Mar 4 10 32 0 0)


overOneYear : Test
overOneYear =
    t "over 1 year"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1987 Sep 4 10 32 0 0)


almostThreeYears : Test
almostThreeYears =
    t "almost 3 years"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1989 Feb 4 10 32 0 0)


aboutThreeYears : Test
aboutThreeYears =
    t "about 3 years"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1989 Mar 4 10 32 0 0)


overThreeYears : Test
overThreeYears =
    t "over 3 years"
        defaultConfig
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1989 Sep 4 10 32 0 0)


localeWithSuffix : Locale
localeWithSuffix =
    English.locale { addSuffix = True }


halfAMinuteAgo : Test
halfAMinuteAgo =
    t "half a minute ago"
        { defaultConfig | includeSeconds = True, locale = localeWithSuffix }
        (Date.fromParts 1986 Mar 4 10 32 25 0)
        (Date.fromParts 1986 Mar 4 10 32 0 0)


inAboutOneHour : Test
inAboutOneHour =
    t "in about 1 hour"
        { defaultConfig | locale = localeWithSuffix }
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 11 32 0 0)


all : Test
all =
    describe "elm-time-distance"
        [ lessThan5
        , lessThan10
        , lessThan20
        , halfAMinute
        , lessThanAMinute
        , oneMinute
        , lessThanAMinute_
        , oneMinute_
        , threeMinutes
        , aboutOneHour
        , aboutThreeHours
        , oneDay
        , threeDays
        , aboutOneMonth
        , threeMonths
        , aboutOneYear
        , overOneYear
        , almostThreeYears
        , aboutThreeYears
        , overThreeYears
        , halfAMinuteAgo
        , inAboutOneHour
        ]
