# Arkam

Arkam is an iOS app for recording and viewing your outdoor workouts. It supports not just running, but also walking, hiking, cycling and skating.

This project is fully open-source and ad-free.

<a href="https://apps.apple.com/us/app/OutRun/id1477511092">
    <img src="https://outrun.tadris.de/src/download.svg">
</a>

## How to Launch

**Clone repo**

    git clone https://github.com/jkilakya/fyp.git

    cd fyp

**CHANGE BRANCH to what u want**

    git fetch origin
    
    git branch -a

    git checkout remotes/origin/<REMOTE_BRANCH_YOU_WANT>

**SETUP APP**

    pod install

**LAUNCH OutRun.xcworkspace file, CHANGE SETTINGS**

- First open the just generated OutRun.xcworkspace. This will be the file to open to get to work on the project in the future.

- NOTE: Do not use the OutRun.xcodeproj file, it does not include the libraries needed in the project and you will not get it to compile without these

- Since you will not use the same developer account as when the app gets published just remove the Team attribute in Project Settings > Signing and Capabilities or change it to your own if you want to install the app on anything other than a simulator.

- You might also need to change the Bundle Identifer to get the app working since it is already registered on the publishing Apple Developer Account.

**FIX COMPILE ERROR**

There is a compile error in the ChartDataSet.swift file. Solve it as follows: 

Add the following snippet to line 531, just after extension ChartDataSet: RangeReplaceableCollection {

    public func replaceSubrange<C>(_ subrange: Swift.Range<Int>, with newElements: C) where C : Collection, ChartDataEntry == C.Element {
            entries.replaceSubrange(subrange, with: newElements)
            notifyDataSetChanged()
        }

**BUILD**
Select iPhone 13 as simulator and build the app

## Features

Arkam has a rich feature set centered around customisation and privacy. The list of features includes:

- Keep full control over your data
- Record your outdoor workouts (Running, Walking, Hiking, Cycling and Skating)
- View detailed statistics
- Monetize your data and collect crypto rewards

## Translation

Arkam uses [Weblate](https://weblate.org/) as a tool to make translation easier. Once languages are fully translated on said platform they will be added to the project and published to the AppStore.

So far the following languages are supported:

| Language | Translation Status |
|----------|--------------------|
| Catalan  | [![ca translation status](https://hosted.weblate.org/widgets/outrun/ca/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/ca/) |
| Croatian | [![hr translation status](https://hosted.weblate.org/widgets/outrun/hr/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/hr/) |
| Czech    | [![cs translation status](https://hosted.weblate.org/widgets/outrun/cs/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/cs/) |
| Danish   | [![da translation status](https://hosted.weblate.org/widgets/outrun/da/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/da/) |
| Dutch    | [![nl translation status](https://hosted.weblate.org/widgets/outrun/nl/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/nl/) |
| English  | [![en translation status](https://hosted.weblate.org/widgets/outrun/en/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/en/) |
| Finnish  | [![fi translation status](https://hosted.weblate.org/widgets/outrun/fi/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/fi/) |
| French   | [![fr translation status](https://hosted.weblate.org/widgets/outrun/fr/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/fr/) |
| German   | [![de translation status](https://hosted.weblate.org/widgets/outrun/de/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/de/) |
| Italian  | [![it translation status](https://hosted.weblate.org/widgets/outrun/it/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/it/) |
| Polish   | [![pl translation status](https://hosted.weblate.org/widgets/outrun/pl/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/pl/) |
| Spanish  | [![es translation status](https://hosted.weblate.org/widgets/outrun/es/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/es/) |
| Swedish  | [![sv translation status](https://hosted.weblate.org/widgets/outrun/sv/svg-badge.svg)](https://hosted.weblate.org/engage/outrun/sv/) |

If you want to add languages or improve already translated ones you can do this [here](https://hosted.weblate.org/engage/outrun/).
