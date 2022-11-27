Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0991F63993D
	for <lists+bpf@lfdr.de>; Sun, 27 Nov 2022 04:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiK0D13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Nov 2022 22:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiK0D11 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Nov 2022 22:27:27 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2074.outbound.protection.outlook.com [40.92.74.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE41EBF8;
        Sat, 26 Nov 2022 19:27:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uask4IVPYmGO+P/4WIq0mx+qgqG00ILb58MXVIytkkaH18tbcB/Nf4y4ezlfLlSp8lfJobClgtFVF855rn4/kvKPCekumweENZInH0sb6qhnmGf/LDc3I/uBObahy83ZrPpG/HPjlH0PzOGYQ1DRlmK0Q252PAQb/hEMbUlwpPo/cTQReQ4C4kombNMXgD+Yr6DQ1nrrlfJdKbLWAhWQ+4yoH6qnNEVCauworYmUVMKzGWfP42O/W8fn1s5iGNCbgXYXwaLpxbH3h/5FB6IwMnVk/6WULYug0QB8nQckJ5Qr4brS91yiozQ0vqjx3mjYmGKLUfUIAAXo5gBPm/Kflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ackfQM7fexNTvC5EUOCA2cWH3piiALQb7mJBhabm118=;
 b=WhebDmMnLDeReZfp3F/pGketaHdGb+4injcUP8w3DSPjEiqCghdncSsCLKvvO/xrVunMsl0CfDeCXbiItUIXHY9FrIo6FuvUUrsoPbC1P0sDAp/QU6sIeZ60B5YtDayacdd0Lyf7MB30caRapfV2cH2k+WMwNT6nq/qqFquJqw7gXamhaJeaW1pNZ4Thm1Aou5pCptWgcZ3IPHrEL5F5vol3Vrc9qCGZG/oVAOKx7cm2lvsMlPHZe2a1SlUsCNbshYHIRulyx377FcIFVXoqCZRamGDYmUp8uU++gZIx8CZsuVecAPcUcuZrD1NeSBH7YDJqG6GYXXAGO+O76IhwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ackfQM7fexNTvC5EUOCA2cWH3piiALQb7mJBhabm118=;
 b=Z+1ad5ZOTBRJNzAJr7aHvmud4eGUdeLVytin58OsNO+WiNaiSztaWI/+oz812jBlYl79PiIDREQlbHF43xflIO26SOOsi+lRiCdtF/5kVQqe7oE/8efkJInmbi+wtfMqfOimQdwH+VjJV8cMD8ohf6csL/VRmp+Yoq/6lwnlT4uATEuArpQQK9GTZge/5u7BoWF0WXiwyNI7pjqiHrDDHXaAkbxchJyFub09VGlljGAntd0Rv/JF9gG+WHjULbG6WLqaw/ZGkywoO9yoFLaR9eVGto9GD8JuKiFxUVvAidYkHRveWY+ZscZsXVMyoAH8+9oS0LfijSOvTt7tgVZ95g==
Received: from DU0P192MB1547.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34b::15)
 by AM7P192MB0817.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:14f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Sun, 27 Nov
 2022 03:27:24 +0000
Received: from DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 ([fe80::a67b:5da2:88f8:f28b]) by DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 ([fe80::a67b:5da2:88f8:f28b%7]) with mapi id 15.20.5857.021; Sun, 27 Nov 2022
 03:27:24 +0000
Message-ID: <DU0P192MB15474DA29DF17452DC3E95A9D6109@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
Date:   Sun, 27 Nov 2022 11:27:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf v2] bpf: Update bpf_{g,s}etsockopt() documentation
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, joannelkoong@gmail.com,
        kuifeng@fb.com, lorenzo@kernel.org, maximmi@nvidia.com,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <DU0P192MB15479B86200B1216EC90E162D6099@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
 <0977584d-8aff-624d-4cf8-a6e4868958c5@iogearbox.net>
 <6fbd8c35-04de-c379-5062-a0b9d4a8ebbe@linux.dev>
From:   Ji Rongfeng <SikoJobs@outlook.com>
In-Reply-To: <6fbd8c35-04de-c379-5062-a0b9d4a8ebbe@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [r+AFiboAZLtjZOeeWFFUHdwdAkZMotz/]
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:34b::15)
X-Microsoft-Original-Message-ID: <7ede0b02-6fe6-f51e-eb3c-bf6dab63aa21@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0P192MB1547:EE_|AM7P192MB0817:EE_
X-MS-Office365-Filtering-Correlation-Id: ff57024e-8f28-45e5-8150-08dad0274d0a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYrycaXG9SEVa1zDXoMZd3yQK+4RI8LBP+dk9i3RYZvDrR5XNFWd56+LCQWiBBItB+0yeK6XWrLbUisWpc00XWVr+iAT1NBWLI4ec3kw/R0EVHusK4YaLiKneimmYBVBJ27edNTA/nye+pu44nTZdjuZFWr9Pug1CHaeCwvOPsrDEweFob7H/+W5gtswpf/l8f5YPEdV892mg9aN1uvijweWfcdp8GPJCq03LYmovt8iDngUOC/2TqHMxXCjkxfd5xFiGQYLvSt7Mh/Pqgl8pBl09fTN3g2lsoaFlP4ZsEqj2+hUhTM/5vRAYPpSl4f5ldwitLyIGDerF3xfBrzH2r58lqE4Qwt1LGUeIPCxxXWfPmBmVw4bSFnuXA055MEYTHZYYoGN3DwXBY2Feb2ctp5P/ACMxSq7GB9FZzAtGZEyjbbLWWz26y2EjS11nYLe2MmCyIu1ytf43Y7QI/XaOokeq2aSN5Jdak/WxYZrfT5R75FIv7zUnUkjV73aOn0gF5v1z5J07wTEnBFkjF85A9ejby019eHEXl14tpu+niNSV0SkcOK4I+0o3qBeufWUnO29dF2/VZAXnFv9Kn1OagAjYLgPfIe/BwWQqDnBG3op71ReCbw85cpB+oQ/j3tVeh7LDhg3Aq5EwGSBGw3Z6A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2Q4UjRFNEYveUF0YnNUMHlmZndnRk5IOFZWcnJVSUxXQ0N0Y1BrSGxsdkZQ?=
 =?utf-8?B?Z0FPQ1NPSU9SVkprWmt3Mi9RQkszcWJ2UjJpa0N1bUxaMXFMWFlqMlVzOHRZ?=
 =?utf-8?B?NVFPV3JqNTV5Q1RmSDg5bldmc1dpQ0pGMzh2b0s2bXZYQ3g0Wjg1VEJ0ZWxI?=
 =?utf-8?B?RVk2dmtPVkIyc0RjdDFGaEl4SEE5QWtmYjhWTkxDWTFlMXNqSXZhNnh4eHpJ?=
 =?utf-8?B?eHQrdlFNV005TXhicHlyeVRxbHJ3dTM1QndRYm9zL05nZGVkZk5rMjRyZ0Qy?=
 =?utf-8?B?amptQkVUUDhDWVZ6VDVySDZBUnNQcndPZk5KSEhTQ3VOMngycmxZQU1sTHEy?=
 =?utf-8?B?bzQvUVUralg0cnRGSzQzc2xUTW5Gemk0NXE5TFd3NW5KdzBnRHdGak92ZmhO?=
 =?utf-8?B?WkhvSHV2eEY0K25Ua0g5Y3pFMStmenFsdzhWZnhmRUxna0krVW5YSmxIZGhp?=
 =?utf-8?B?dFRPamZtZ2liT29lVlJwWWQ0WXJoNU9KVExYNnFYbUdWYU01R1I1bTFSbkh2?=
 =?utf-8?B?MVpWTllvQWNoT2FyVjlsd0MzT3l4Q1JBUkxGQ1loL25NSnZXaTNUaWRHcThN?=
 =?utf-8?B?MzM0QVQ5K3BwcCtITVVpTWs0Sm1uVmFPRE56S3FuN3ViWlViRmZtb1lwQ01Q?=
 =?utf-8?B?a2lQdEUxRmpzQ1NuRit3MTNTbkxVL0trQUxXYWNRMGVvTndQUENlNnRqckd0?=
 =?utf-8?B?NGxxb2NPbDMwMHJCWFZ3WVN3aTVleUxDanQ2UzhHVzByb0xQdUc5WDFzOVk2?=
 =?utf-8?B?ZHdpanVhNysrZWl5SVRQeHM1dmd5L1ZJeFQzVTQvcitiTGlwNmU3R3MzNDZn?=
 =?utf-8?B?VTg2M2dmaUFxczB3WG5DYjRhdllOMVl6YldXSWJrb1VrbW5EUE1IaHVnSzRO?=
 =?utf-8?B?bVZzaDdSUUt2dzRUR3h1elVmUUZqWjBxeE11V1c5ODV2MHhad3BKbFJoTzVo?=
 =?utf-8?B?RUNybEZxTXlvcERMeHJMT21wZ2RhWTY1LzVmZmxIYkJBVS9vS3J6cEE5Ukkv?=
 =?utf-8?B?YTZqZWdRRzBhWk42ZUVzNmRjV3ZlQVR4MmdjbTczQSt3L1htWks4K29vamMr?=
 =?utf-8?B?QjVQWmUrcEk0eFNOVnhRaW9ieXk0bUNOTENVajBkMHdRVFJwcTdUNHU0N0N4?=
 =?utf-8?B?cnNONVo0dHpCZTlKK0J5TFhoVkVQMDFrcmszcVYzdVRiUnBhZTJZYUVhME1W?=
 =?utf-8?B?SytkNThsaHE3VGRPMFEwYlUyZ0RVWUJ0QURPbVZHOFZQMWt3NUgvQXVHUFZY?=
 =?utf-8?B?c3NmOGZrYWZOTC91R0RYaHQyajNOaWZxeHVjbWcrZ2szMVdsZ3MwWitHTU5I?=
 =?utf-8?B?UmdzS2V0cDJFRDd3eUNkSitET1FBYTdMM0xsNWFHMHByMVZnRytobkp0QTVB?=
 =?utf-8?B?YW0rTStBK05YNjJ5eDdSWW5xaXl4MGdFUW1BVmJ1V1BObDkwTkxPRWFZMGJy?=
 =?utf-8?B?eGhucXNKL21rd2p5NnlSeUVXdVhrSUgyQzBtWElCaWtMTlEvZkdKbkh2OG9x?=
 =?utf-8?B?RnRwa0xyYnBRcXh6OXoyajRKc2hsOXNIMFpmWUdMZFNuZ0pta0tzU2R4ZEEx?=
 =?utf-8?B?OTgyV1E0ZWQ0YkZqYmh1L29BQ2ZwNENwM0FHSzRmelJGTkljQkoyWGI0a3lT?=
 =?utf-8?B?TG01NkNuNHNtTkJVVUlTSkxBOGZxNDBCSUl6RGh5cm1TYUFpSnZnQ1JndU0x?=
 =?utf-8?B?dzkzViticktwSE8wSVRaVWdSNlJCaGVHRkV2QWhaUVRCRmkzUWE0S3lBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff57024e-8f28-45e5-8150-08dad0274d0a
X-MS-Exchange-CrossTenant-AuthSource: DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2022 03:27:24.7118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P192MB0817
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/11/24 8:40, Martin KaFai Lau wrote:
> On 11/23/22 4:18 PM, Daniel Borkmann wrote:
>> On 11/18/22 9:18 AM, Ji Rongfeng wrote:
>>> * append missing optnames to the end
>>> * simplify bpf_getsockopt()'s doc
>>>
>>> Signed-off-by: Ji Rongfeng <SikoJobs@outlook.com>
>>> ---
>>>   include/uapi/linux/bpf.h       | 20 ++++++++++++--------
>>>   tools/include/uapi/linux/bpf.h | 20 ++++++++++++--------
>>>   2 files changed, 24 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 51b9aa640ad2..14f29d95ea71 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -2576,14 +2576,19 @@ union bpf_attr {
>>>    *         * **SOL_SOCKET**, which supports the following 
>>> *optname*\ s:
>>>    *           **SO_RCVBUF**, **SO_SNDBUF**, **SO_MAX_PACING_RATE**,
>>>    *           **SO_PRIORITY**, **SO_RCVLOWAT**, **SO_MARK**,
>>> - *           **SO_BINDTODEVICE**, **SO_KEEPALIVE**.
>>> + *           **SO_BINDTODEVICE**, **SO_KEEPALIVE**, **SO_REUSEADDR**,
>>> + *           **SO_REUSEPORT**, **SO_BINDTOIFINDEX**, **SO_TXREHASH**.
>>>    *         * **IPPROTO_TCP**, which supports the following 
>>> *optname*\ s:
>>>    *           **TCP_CONGESTION**, **TCP_BPF_IW**,
>>>    *           **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
>>>    *           **TCP_KEEPIDLE**, **TCP_KEEPINTVL**, **TCP_KEEPCNT**,
>>> - *          **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, 
>>> **TCP_NOTSENT_LOWAT**.
>>> + *           **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, 
>>> **TCP_NOTSENT_LOWAT**,
>>> + *           **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
>>> + *           **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
>>> + *           **TCP_BPF_RTO_MIN**.
>>>    *         * **IPPROTO_IP**, which supports *optname* **IP_TOS**.
>>> - *         * **IPPROTO_IPV6**, which supports *optname* 
>>> **IPV6_TCLASS**.
>>> + *         * **IPPROTO_IPV6**, which supports the following 
>>> *optname*\ s:
>>> + *           **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
>>>    *     Return
>>>    *         0 on success, or a negative error in case of failure.
>>>    *
>>> @@ -2800,12 +2805,11 @@ union bpf_attr {
>>>    *           and **BPF_CGROUP_INET6_CONNECT**.
>>>    *
>>>    *         This helper actually implements a subset of 
>>> **getsockopt()**.
>>> - *         It supports the following *level*\ s:
>>> + *         It supports the same set of *optname*\ s that supported by
>>
>> nit: that is supported by
>>
>>> + *         **bpf_setsockopt**\ () helper with a few exceptions:
>>>    *
>>> - *         * **IPPROTO_TCP**, which supports *optname*
>>> - *           **TCP_CONGESTION**.
>>> - *         * **IPPROTO_IP**, which supports *optname* **IP_TOS**.
>>> - *         * **IPPROTO_IPV6**, which supports *optname* 
>>> **IPV6_TCLASS**.
>>> + *         * **bpf_setsockopt**\ () helper only: **TCP_BPF_***.
>>> + *         * **bpf_getsockopt**\ () helper only: **TCP_SAVED_SYNC**.
>>
>> I think from a user PoV the above is a bit hard to follow, maybe take 
>> Martin's
>> earlier feedback into account and add a proper sentence; it will be 
>> much easier
>> to understand.
>
> +1  Made the change and also fixed TCP_SAVED_SYNC with s/SYNC/SYN/ 
> while applying.  Thanks!

Thanks for the helpful reviews. I chose the form of lists was because we 
could
append more optnames easily in the future. But I believe it's not late 
to apply
that form when we really need it : )

In my opinion, this patch doesn't contain any new feature, but just a 
kind of fix
to the documentation, according to the corresponding code in the bpf tree,
which hasn't been modified yet in the bpf-next tree. So I targeted the 
former,
as this patch could be useful there. Please let me know if there's any 
customary
rules outside bpf_devel_QA. Thanks!
