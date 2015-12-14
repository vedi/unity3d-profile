### v2.4.0 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.3.0...v2.4.0)

* New Features
  * Added Leaderboards to GameCenter

* Fixes
  * Fixed onProfileInitialized fires multiple times

* Changes
  * Added saving user settings to PlayerPrefs

### v2.3.0 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.2.1...v2.3.0)

* New Features
  * Updated Facebook SDK to v7.2.2
  * Added Game Center as a social provider

* Changes
  * Minor improvements and rearrangements to Editor script

### v2.2.1 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.2.0...v2.2.1)

* Changes
  * Minor improvements in Editor script

### v2.2.0 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.8...v2.2.0)

* Features
  * Added `logoutFromAllProviders` method to `SoomlaProfile`
  * Added Modal Dialog for FB
  * Added checking for latest version in Soomla Settings panel
  * Added "Remove Soomla" to Soomla menu
  * Added a new way of event handling without prefabs

* Changes
  * Moved all SOOMLA plugins into 'Soomla' folders

* Fixes
  * Minor bugfixes

### v2.1.8 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.7...v2.1.8)

* Fixes
  * OpenAppRatingPage can’t open app page in iOS AppStore

* Changes
  * Replaced deprecated read_stream permission with user_posts

### v2.1.7 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.6...v2.1.7)

* Fixes
  * Validate FB permissions in Unity3d
  * UserProfile fields now support Unicode symbols

### v2.1.6 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.5...v2.1.6)

* Changes
  * Removed binaries and improved build scripts

### v2.1.6 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.5...v2.1.6)

* Changes
  * Merge pull request #49 from soomla/removeBinaries
  * Merge branch 'master' into removeBinaries
  * Merge pull request #48 from vedi/dev
  * Merge branch 'removeBinaries' of github.com:soomla/unity3d-profile into removeBinaries
  * Removed unecessary meta files
  * Improved deploy script
  * updated submodules
  * Added deploy/out to gitignore
  * Removed binaries and improved build scripts
  * update submodules
  * update binaries
  * Merge branch 'dev' of github.com:vedi/unity3d-profile into dev
  * Merge branch 'master' into dev
  * Merge pull request #2 from vedi/fix_3755-add_gender_location_lang
  * Merge branch 'dev' of github.com:vedi/unity3d-profile into dev
  * fix inline comment
  * 3755 [FIX] UserProfile's fields are implemented in different way in different platforms
  * Merge pull request #1 from vedi/feature_3670-implement_getfeed
  * align free space according to other lines
  * Merge branch 'master' of https://github.com/vedi/unity3d-profile into feature_3670-implement_getfeed

### v2.1.5 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.4...v2.1.5)

* Changes
  * Supporting changes in submodules

### v2.1.4 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.3...v2.1.4)

* New Features
  * Support extra params in UserProfile

* Changes
  * New build way

* Fixes
  * Fixed build for Unity 4.x
  * Add "autoLogin" field to LoginFinishedEvent
  * Change dataFromBase64String to dataFromBase64String_soomla in Unity3d

### v2.1.3 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.2...v2.1.3)

* New Features
  * Implemented auto login

* Changes
  * Removed publish_actions permission requirement for posting a story

* Fixes
  * Fixed crash when Logout is called twice
  * Fixed IndexOutOfBoundsException in profile Editor
  * Fix uploadImage
  * Fixed crash in ProfileSettings.cs when editing FB permission in inspector

### v2.1.2 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.1...v2.1.2)

* Fixes
  * fixed pagination in GetContacts
  * multiShare crash on iPad with iOS8
* Changes
  * improve working with the permissions in FB

### v2.1.1 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.0...v2.1.1)

* Fixes
  * Fix `publish_actions` permission

* Changes
  * Upgraded to latest version of FB SDK

### v2.1.0 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.8...v2.1.0)

* New Features
  * Implemented Pagination for GetContacts and GetFeed
  * Implemented multi-sharing (sharing with the native functionality of your target platform)
  * Implemented methods to show confirmation dialog before some actions (not supported for FB)
  * Supporting permissions param in FB

* Fixes
 * Fixed an issue on Google+ & Android where cancellation of login didn't work properly

### v2.0.8 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.7...v2.0.8)

* Changes
  * Making Store module Unity 5 compatible

### v2.0.7 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.6...v2.0.7)

* Changes
  * Added core post build script

### v2.0.6 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.5...v2.0.6)

* Changes
  * Updated new changes from submodules

### v2.0.5 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.4...v2.0.5)

* Fixes
  * Making profile initialize event wait for FB to complete initialization
  * Adding missing social action failed event from native android
  * Login cancelled will be fired when going back from Twitter login web view (android)

### v2.0.4 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.3...v2.0.4)

* New Features
  * Ability to page contacts (supported in Facebook only)
  * Ability to invite friends (supported in Facebook only)

* Fixes
  * Pushing get contacts events to native

### v2.0.3 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.2...v2.0.3)

* New Features
  * Fully supporting uploadImage for all social platforms (Facebook, Twitter and Google+)
  * Added option for uploading image with byte array and Texture

* Fixes
  * Making profile remove the UserProfile from storage when doing Logout

### v2.0.2 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.1...v2.0.2)

* New Features
  * Supporting Facebook SDK v6.x
  * Supporting new features from submodules

* Fixes
  * Moving reward handout before event sending


### v2.0.1 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v1.0...v2.0.1)

* Changes
  * Getting google-play-services_lib from sdk
  * Disabling removal of plugins
  * Added debug.keystore for the sake of running example with google+
  * Documentation for social platform support for each social action
  * Updated new changes from submodules

* Fixes
  * Fixing google play services issues

### v2.0.0 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v1.0...v2.0.0)

* New Features
  * The module is integrated with Facebook, Google Plus and Twitter
  * Ability to preform following actions on multiple social networks (parallel):
    * Login/Logout
    * Update status
    * Update Story (supported fully in Facebook only)
    * Upload image (supported on Facebook only)
    * Get user profile + store it on the device
    * Get user's contacts (not all social networks provide all information)
    * Get user's most recent feed (not supported in Google Plus)

### v1.0.0

* Features
  * Facebook integration only
