
#import "UnityProfileEventDispatcher.h"
#import "SoomlaEventHandling.h"
#import "ProfileEventHandling.h"
#import "UserProfile.h"
#import "SocialActionUtils.h"
#import "Reward.h"
#import "SoomlaUtils.h"
#import "UserProfileUtils.h"

extern "C"{
    
    // events pushed from external provider (Unity FB SDK etc.)
    
    void soomlaProfile_PushEventLoginStarted (const char* sProvider, bool autoLogin, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postLoginStarted:provider withAutoLogin:autoLogin andPayload:payloadS];
    }
    void soomlaProfile_PushEventLoginFinished(const char* sUserProfileJson, bool autoLogin, const char* payload) {
        NSString *userProfileJson = [NSString stringWithUTF8String:sUserProfileJson];
        UserProfile* userProfile = [[UserProfile alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:userProfileJson]];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postLoginFinished:userProfile withAutoLogin:autoLogin andPayload:payloadS];
    }
    void soomlaProfile_PushEventLoginFailed(const char* sProvider, const char* sMessage, bool autoLogin, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postLoginFailed:provider withMessage:message andAutoLogin:autoLogin andPayload:payloadS];
    }
    void soomlaProfile_PushEventLoginCancelled(const char* sProvider, bool autoLogin, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postLoginCancelled:provider withAutoLogin:autoLogin andPayload:payloadS];
    }
    void soomlaProfile_PushEventLogoutStarted(const char* sProvider) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        [ProfileEventHandling postLogoutStarted:provider];
    }
    void soomlaProfile_PushEventLogoutFinished(const char* sProvider) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        [ProfileEventHandling postLogoutFinished:provider];
    }
    void soomlaProfile_PushEventLogoutFailed(const char* sProvider, const char* sMessage) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        [ProfileEventHandling postLogoutFailed:provider withMessage:message];
    }
    void soomlaProfile_PushEventSocialActionStarted(const char* sProvider, const char* sActionType, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postSocialActionStarted:provider withType:socialActionType withPayload:payloadS];
    }
    void soomlaProfile_PushEventSocialActionFinished(const char* sProvider, const char* sActionType, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postSocialActionFinished:provider withType:socialActionType withPayload:payloadS];
    }
    void soomlaProfile_PushEventSocialActionCancelled(const char* sProvider, const char* sActionType, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postSocialActionCancelled:provider withType:socialActionType withPayload:payloadS];
    }
    void soomlaProfile_PushEventSocialActionFailed(const char* sProvider, const char* sActionType,  const char* sMessage, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postSocialActionFailed:provider withType:socialActionType withMessage:message withPayload:payloadS];
    }
    void soomlaProfile_PushEventGetContactsStarted(const char* sProvider, bool fromStart, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        SocialActionType socialActionType = SocialActionType::GET_CONTACTS;
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postGetContactsStarted: provider withType: socialActionType withFromStart: fromStart withPayload:payloadS];
    }
    void soomlaProfile_PushEventGetContactsFinished(const char* sProvider, const char* sUserProfilesJson, const char* payload, bool hasMore) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        SocialActionType socialActionType = SocialActionType::GET_CONTACTS;
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        
        NSMutableArray *contacts = [NSMutableArray array];
        NSMutableArray *contactsDictArray = [SoomlaUtils jsonStringToArray:[NSString stringWithUTF8String:sUserProfilesJson]];
        if (contactsDictArray) {
            for (NSDictionary *contactDict in contactsDictArray) {
                UserProfile *contactProfile = [[UserProfile alloc] initWithDictionary:contactDict];
                if (contactProfile) {
                    [contacts addObject:contactProfile];
                }
            }
        }

        [ProfileEventHandling postGetContactsFinished:provider withType:socialActionType withContacts:contacts withPayload:payloadS withHasMore:hasMore];
    }
    void soomlaProfile_PushEventGetContactsFailed(const char* sProvider, const char* sMessage, bool fromStart, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        SocialActionType socialActionType = SocialActionType::GET_CONTACTS;
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postGetContactsFailed:provider withType:socialActionType withMessage:message withFromStart: fromStart withPayload:payloadS];
    }

    void soomlaProfile_PushEventGetFeedFinished(const char* sProvider, const char* sFeedJson, const char* payload, bool hasMore) {
        NSString *providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        SocialActionType socialActionType = SocialActionType::GET_FEED;
        NSString *payloadS = [NSString stringWithUTF8String:payload];

        NSMutableArray *feeds = [NSMutableArray array];
        NSMutableArray *feedDictArray = [SoomlaUtils jsonStringToArray:[NSString stringWithUTF8String:sFeedJson]];
        if (feedDictArray) {
            for (NSString *feedEntry in feedDictArray) {
                [feeds addObject:feedEntry];
            }
        }

        [ProfileEventHandling postGetFeedFinished:provider withType:socialActionType withContacts:feeds withPayload:payloadS withHasMore:hasMore];
    }

    void soomlaProfile_PushEventGetFeedFailed(const char* sProvider, const char* sMessage, bool fromStart, const char * payload) {
        NSString *providerIdS = [NSString stringWithUTF8String:sProvider];
       Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        SocialActionType socialActionType = SocialActionType::GET_FEED;
        NSString *payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postGetFeedFailed:provider withType:socialActionType withMessage:message withFromStart:fromStart withPayload:payloadS];
    }
    
    void soomlaProfile_PushEventInviteStarted(const char* sProvider, const char* sActionType, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postInviteStarted:provider withType:socialActionType withPayload:payloadS];
    }
    void soomlaProfile_PushEventInviteFinished(const char* sProvider, const char* sActionType, const char* requestId, const char *invitedIdsJson, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        NSString *requestIdS = [NSString stringWithUTF8String:requestId];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        NSMutableArray *invitedIds = [NSMutableArray array];
        NSMutableArray *idsDictArray = [SoomlaUtils jsonStringToArray:[NSString stringWithUTF8String:invitedIdsJson]];
        if (idsDictArray) {
            for (NSString *feedEntry in idsDictArray) {
                [invitedIds addObject:feedEntry];
            }
        }
        [ProfileEventHandling postInviteFinished:provider withType:socialActionType requestId:requestIdS invitedIds:invitedIds withPayload:payloadS];
    }
    void soomlaProfile_PushEventInviteCancelled(const char* sProvider, const char* sActionType, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postInviteCancelled:provider withType:socialActionType withPayload:payloadS];
    }
    void soomlaProfile_PushEventInviteFailed(const char* sProvider, const char* sActionType,  const char* sMessage, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postInviteFailed:provider withType:socialActionType withMessage:message withPayload:payloadS];
    }
    
    void soomlaProfile_PushEventGetLeaderboardsStarted(const char * sProvider, bool fromStart, const char * payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postGetLeaderboardsStarted:provider fromStart:fromStart withPayload:payloadS];
    }
    
    void soomlaProfile_PushEventGetLeaderboardsFinished(const char * sProvider, const char * leaderboardsJson, const char * payload, bool hasNext) {
        
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        
        NSMutableArray *leaderboards = [NSMutableArray array];
        NSMutableArray *leaderboardsDictArray = [SoomlaUtils jsonStringToArray:[NSString stringWithUTF8String:leaderboardsJson]];
        if (leaderboardsDictArray) {
            for (NSDictionary *leaderboardsDict in leaderboardsDictArray) {
                Leaderboard *leaderboard = [[Leaderboard alloc] initWithDictionary:leaderboardsDict];
                if (leaderboard) {
                    [leaderboards addObject:leaderboard];
                }
            }
        }
        
        [ProfileEventHandling postGetLeaderboardsFinished:provider withLeaderboardsList:leaderboards hasMore:hasNext andPayload:payloadS];
    }
    
    void soomlaProfile_PushEventGetLeaderboardsFailed(const char * sProvider, const char * sMessage, bool fromStart, const char * payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postGetLeaderboardsFailed:provider fromStart:fromStart withMessage:message andPayload:payloadS];
    }
    
    void soomlaProfile_PushEventGetScoresStarted(const char * sProvider, const char * fromJson, bool fromStart, const char * payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        Leaderboard *from = [[Leaderboard alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:[NSString stringWithUTF8String:fromJson]]];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postGetScoresStarted:provider forLeaderboard:from fromStart:fromStart withPayload:payloadS];
    }
    
    void soomlaProfile_PushEventGetScoresFinished(const char * sProvider, const char * fromJson, const char * scoresJson, const char * payload, bool hasNext) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        Leaderboard *from = [[Leaderboard alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:[NSString stringWithUTF8String:fromJson]]];
        
        NSMutableArray *scores = [NSMutableArray array];
        NSMutableArray *scoresDictArray = [SoomlaUtils jsonStringToArray:[NSString stringWithUTF8String:scoresJson]];
        if (scoresDictArray) {
            for (NSDictionary *scoresDict in scoresDictArray) {
                Score *score = [[Score alloc] initWithDictionary:scoresDict];
                if (score) {
                    [scores addObject:score];
                }
            }
        }
        
        [ProfileEventHandling postGetScoresFinished:provider forLeaderboard:from withScoresList:scores hasMore:hasNext andPayload:payloadS];
    }
    
    void soomlaProfile_PushEventGetScoresFailed(const char * sProvider, const char * fromJson, const char * sMessage, bool fromStart, const char * payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        Leaderboard *from = [[Leaderboard alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:[NSString stringWithUTF8String:fromJson]]];
        [ProfileEventHandling postGetScoresFailed:provider forLeaderboard:from fromStart:fromStart withMessage:message andPayload:payloadS];
    }
    
    void soomlaProfile_PushEventReportScoreStarted(const char * sProvider, const char * fromJson, const char * payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        Leaderboard *from = [[Leaderboard alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:[NSString stringWithUTF8String:fromJson]]];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postReportScoreStarted:provider forLeaderboard:from withPayload:payloadS];
    }
    
    void soomlaProfile_PushEventReportScoreFinished(const char * sProvider, const char * fromJson, const char * scoreJson, const char * payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        Leaderboard *from = [[Leaderboard alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:[NSString stringWithUTF8String:fromJson]]];
        Score *score = [[Score alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:[NSString stringWithUTF8String:scoreJson]]];
        
        [ProfileEventHandling postReportScoreFinished:provider score:score forLeaderboard:from andPayload:payloadS];
    }
    
    void soomlaProfile_PushEventReportScoreFailed(const char * sProvider, const char * fromJson, const char * sMessage, const char * payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        Leaderboard *from = [[Leaderboard alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:[NSString stringWithUTF8String:fromJson]]];
        [ProfileEventHandling postReportScoreFailed:provider forLeaderboard:from withMessage:message andPayload:payloadS];
    }
}

@implementation UnityProfileEventDispatcher

+ (void)initialize {
    static UnityProfileEventDispatcher* instance = nil;
    if (!instance) {
        instance = [[UnityProfileEventDispatcher alloc] init];
    }
}

- (id) init {
    if (self = [super init]) {
        LogDebug(@"UnityProfileEventDispatcher", @"INIT");
        [ProfileEventHandling observeAllEventsWithObserver:self withSelector:@selector(handleEvent:)];
    }
    
    return self;
}

- (void)handleEvent:(NSNotification*)notification{
    if ([notification.name isEqualToString:EVENT_UP_PROFILE_INITIALIZED]) {
        //TODO!: filter to GP and TW
        UnitySendMessage("ProfileEvents", "onSoomlaProfileInitialized", "");
    }
    else if ([notification.name isEqualToString:EVENT_UP_USER_PROFILE_UPDATED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSLog(@"EVENT_UP_USER_PROFILE_UPDATED %@", userInfo);
        UserProfile *userProfile = [userInfo valueForKey:DICT_ELEMENT_USER_PROFILE];
        
        NSString* jsonStr = [SoomlaUtils dictToJsonString:@{@"userProfile":[userProfile toDictionary]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onUserProfileUpdated"
                                     withFilter:@([userProfile provider])];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSLog(@"EVENT_UP_LOGIN_STARTED %@", userInfo);
        NSNumber *provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"autoLogin":[userInfo valueForKey:DICT_ELEMENT_AUTO_LOGIN],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLoginStarted"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSLog(@"EVENT_UP_LOGIN_FINISHED %@", userInfo);
        UserProfile* userProfile = [userInfo valueForKey:DICT_ELEMENT_USER_PROFILE];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"userProfile":[userProfile toDictionary],
                                                            @"autoLogin":[userInfo valueForKey:DICT_ELEMENT_AUTO_LOGIN],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLoginFinished"
                                     withFilter:@([userProfile provider])];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_CANCELLED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSLog(@"EVENT_UP_LOGIN_CANCELLED %@", userInfo);
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"autoLogin":[userInfo valueForKey:DICT_ELEMENT_AUTO_LOGIN],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLoginCancelled"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                                                            @"autoLogin":[userInfo valueForKey:DICT_ELEMENT_AUTO_LOGIN],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLoginFailed"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGOUT_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLogoutStarted"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGOUT_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider}];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLogoutFinished"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGOUT_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLogoutFailed"
                                     withFilter:provider];
        
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSocialActionStarted"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSocialActionFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_CANCELLED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSocialActionCancelled"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSocialActionFailed"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_CONTACTS_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        NSNumber* fromStart = [userInfo valueForKey:DICT_ELEMENT_FROM_START];

        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                @"provider":provider,
                @"fromStart":fromStart,
                @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
        }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetContactsStarted"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_CONTACTS_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        NSNumber*hasMore = [userInfo valueForKey:DICT_ELEMENT_HAS_MORE];

        NSArray* contacts = [userInfo valueForKey:DICT_ELEMENT_CONTACTS];
        NSMutableArray* contactsJsonArray = [NSMutableArray array];
        for (int i = 0; i < [contacts count]; i++) {
            [contactsJsonArray addObject:[[contacts objectAtIndex:i] toDictionary]];
        }
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                @"provider":provider,
                @"contacts":contactsJsonArray,
                @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD],
                @"hasMore": hasMore
        }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetContactsFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_CONTACTS_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        NSNumber* fromStart = [userInfo valueForKey:DICT_ELEMENT_FROM_START];

        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                @"provider":provider,
                @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                @"fromStart":fromStart,
                @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
        }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetContactsFailed"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_FEED_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        NSNumber* fromStart = [userInfo valueForKey:DICT_ELEMENT_FROM_START];

        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                @"provider":provider,
                @"fromStart":fromStart,
                @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
        }];

        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetFeedStarted"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_FEED_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        NSArray* feeds = [userInfo valueForKey:DICT_ELEMENT_FEEDS];
        NSNumber*hasMore = [userInfo valueForKey:DICT_ELEMENT_HAS_MORE];
        
        NSMutableArray* feedsJsonArray = [NSMutableArray array];
        for (int i = 0; i < [feeds count]; i++) {
            [feedsJsonArray addObject:[feeds objectAtIndex:i]];
        }
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                @"provider":provider,
                @"feeds":feedsJsonArray,
                @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD],
                @"hasMore": hasMore
        }];
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetFeedFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_FEED_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        NSNumber* fromStart = [userInfo valueForKey:DICT_ELEMENT_FROM_START];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                @"provider":provider,
                @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                @"fromStart":fromStart,
                @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
        }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetFeedFailed"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_INVITE_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onInviteStarted"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_INVITE_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
                                                            @"requestId": [userInfo valueForKey:DICT_ELEMENT_REQUEST_ID],
                                                            @"invitedIds": [userInfo valueForKey:DICT_ELEMENT_INVITED_LIST],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onInviteFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_INVITE_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onInviteFailed"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_INVITE_CANCELLED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onInviteCancelled"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_LEADERBOARDS_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetLeaderboardsStarted"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_LEADERBOARDS_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        NSArray* leaderboards = [userInfo valueForKey:DICT_ELEMENT_LEADERBOARDS];
        
        NSMutableArray* leaderboardsJsonArray = [NSMutableArray array];
        for (int i = 0; i < [leaderboards count]; i++) {
            [leaderboardsJsonArray addObject:[(Leaderboard *)[leaderboards objectAtIndex:i] toDictionary]];
        }
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"leaderboards": leaderboardsJsonArray,
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetLeaderboardsFinished"
                                      withFilter:provider];

    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_LEADERBOARDS_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                                                            @"provider":provider,
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetLeaderboardsFailed"
                                      withFilter:provider];

    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_SCORES_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"leaderboard": [(Leaderboard *)[userInfo valueForKey:DICT_ELEMENT_LEADERBOARD] toDictionary],
                                                            @"fromStart": [userInfo valueForKey:DICT_ELEMENT_FROM_START],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetScoresStarted"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_SCORES_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSArray* scores = [userInfo valueForKey:DICT_ELEMENT_SCORES];
        
        NSMutableArray* scoresJsonArray = [NSMutableArray array];
        for (int i = 0; i < [scores count]; i++) {
            [scoresJsonArray addObject:[(Score *)[scores objectAtIndex:i] toDictionary]];
        }
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"leaderboard": [(Leaderboard *)[userInfo valueForKey:DICT_ELEMENT_LEADERBOARD] toDictionary],
                                                            @"scores": scoresJsonArray,
                                                            @"hasMore": [userInfo valueForKey:DICT_ELEMENT_HAS_MORE],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetScoresFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_SCORES_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        NSNumber* fromStart = [userInfo valueForKey:DICT_ELEMENT_FROM_START];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                                                            @"provider":provider,
                                                            @"leaderboard": [(Leaderboard *)[userInfo valueForKey:DICT_ELEMENT_LEADERBOARD] toDictionary],
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                                                            @"fromStart":fromStart,
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetScoresFailed"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SUBMIT_SCORE_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"leaderboard": [(Leaderboard *)[userInfo valueForKey:DICT_ELEMENT_LEADERBOARD] toDictionary],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSubmitScoreStarted"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SUBMIT_SCORE_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"leaderboard": [(Leaderboard *)[userInfo valueForKey:DICT_ELEMENT_LEADERBOARD] toDictionary],
                                                            @"score": [(Score *)[userInfo valueForKey:DICT_ELEMENT_SCORE] toDictionary],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSubmitScoreFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SUBMIT_SCORE_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                                                            @"provider":provider,
                                                            @"leaderboard": [(Leaderboard *)[userInfo valueForKey:DICT_ELEMENT_LEADERBOARD] toDictionary],
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSubmitScoreFailed"
                                      withFilter:provider];
    }
}

//wrapper for UnitySendMessage
//send only to providers with native implementation
+ (void) sendMessage:(NSString*) message toRecepient:(NSString*) callbackName withFilter:(NSNumber *) provider{
    //don't send for facebook
    if ([provider intValue] == 0)
        return;
    UnitySendMessage("ProfileEvents", [callbackName UTF8String], [message UTF8String]);
}

@end
