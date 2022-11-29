Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2418E63C23B
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 15:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiK2ORY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 09:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiK2ORA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 09:17:00 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2109.outbound.protection.outlook.com [40.92.59.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B606868B;
        Tue, 29 Nov 2022 06:15:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhOOaEVq580kUKt31KJP9LfqLunzL0zV2AIAEtA+i0voSxo9vXthlV0sLheT5mJGu19zmtxzmsFY4AIzPl4/aru2IOEq4WqmrriDvLHRHOcJCgFOE3eqKu56TjbThhvdeoOORHfWLyC6CD9YKBIHlDijub79wULm8MjsucIHT+h13hRgBTD7T9JlWVyV6Ojc01KsDMzOLt33MYQ0JN9MdA+T72+j1KE2KDzENfkFzkXbwq03Nve7ZlX1IjAYeM68Q9EdR8+IkqLTg3kE5bFC0nTzN6/H0vSfvEER5UKaxAEiUMiwruzQzFrba2Zv2rDJtkadafxr1CR/5sijTnXa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/jNOTb8AqtA4OpT6GvC1gcpefnv61UWKg2NQdrNKUc=;
 b=IqfUyo8IpVCP62fRx4jdjaF0c/BEPZYICBkNixDQ9Q9APS1WzHmnvuMe4U8Z42Qky1K5J+5xnppKVuqBk437tBZm3XZXHeY3WvqhwLJx5+0YSoUw9G6EfzjnXQ7uKyyuUCjvHGhtMAChVN66zUIDHATH3YkOjvqt7uPaO8B+kBBasfHpPaDrA7AYO4UkTnr9nIdeiHMW1fLiAwkvuBpQaSlJOVjUU/eLDZLDG0Q5CxGlfPuRZKvx2qJ/B+s6My9cpWGsj9H2cMARKYsGmrbUBIT62qB/Cwh9mJCnop6y5qH6mBXj3sLD5PAJ7eaAYyGPNk7quFwCcIp9WccAfjHhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/jNOTb8AqtA4OpT6GvC1gcpefnv61UWKg2NQdrNKUc=;
 b=hwle7dlDqYI1/bGRJL+ePT9y+l07d/NKBBvC1QG4FoosCzkDEnfMheMNrIY5Hbcu3MCJSgHT6Nwzp/UQ5XkXuY2fEm6aOQI0sAbTJDSOvuHRywfyzYaoDg0YRR2W2GirrnxjEiE0/pFnPzPzNSJsboXaoPFPB14uQ9Wd0ciMMfscEHgVB7bAg+WMUEtQ8VOaqULQnkpy9u8dkk/pVbxR3PSrHOnzXv0P2zdQ1Fj6cDD7vTwjEPEmEZstRlxiS+IHXdXJcQHKVuHfDpaXRZ3Piisfagay9i3kBCv0I4i7Gq9+YXNVVdA0seKdkVrRl2eIXsCIOMVjPMhu3s/z/tEg2Q==
Received: from DU0P192MB1547.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34b::15)
 by DU0P192MB1596.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:328::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 14:15:08 +0000
Received: from DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 ([fe80::a67b:5da2:88f8:f28b]) by DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 ([fe80::a67b:5da2:88f8:f28b%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 14:15:08 +0000
Message-ID: <DU0P192MB1547F9BBDF22F7FB799C45BCD6129@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
Date:   Tue, 29 Nov 2022 22:14:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf v2] bpf: Update bpf_{g,s}etsockopt() documentation
Content-Language: en-US
From:   Ji Rongfeng <SikoJobs@outlook.com>
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
 <7ede0b02-6fe6-f51e-eb3c-bf6dab63aa21@outlook.com>
In-Reply-To: <7ede0b02-6fe6-f51e-eb3c-bf6dab63aa21@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [xDDyhZssqHqCDnlc4usfye30jkGEO7sM]
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To DU0P192MB1547.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34b::15)
X-Microsoft-Original-Message-ID: <682fc3f0-7df8-03c5-19bd-00c6c300db82@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0P192MB1547:EE_|DU0P192MB1596:EE_
X-MS-Office365-Filtering-Correlation-Id: 9394b916-6f6d-466c-de3e-08dad2141ddb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqlh/IeTx9VzzNoBn91uFFwXRSb3OSGASDJ5UaDgLsBkU4w5ndzKD88zajF700Bv9TN0xAnagv5OssBuUVNbCUUMsMJ+SiLqiMkT8E07cPh43ptV8DO4PaltDnQsMAImtJVLtqyuUPKNQVXsY4SG2n5qFmDI9aO7qN4QIWV0dcZ7gUZuP4ECyNUdmCNiG2UTt2zPX2SmDhkGD0oPB7arhAXeBcfjmD5BaETGAj1ratJtI27BEby4E9NKEqWhst4PdhCZhVDzQWbqdPuWY72adyiTgh6j56KvKzz36KeqdzYE2Rluo67pJmbii+K67BOIVnwYOyYp48vRoQpR8q0GPBvAcJ55v6F/zV7kDcTTFhUpDVZeZ2E+sDYd6gtACRf783ywKZsTOkcZrFZl0ffRnorvkjJe/StCZF/Yt0HWDwJIZz59q814cBBg2k4qQiSeFA4xcSJvvTMtsznVHTm5ixueauLTHb+9ER/iQzTFFX44bMt3B4aQqtkkkCnFqJHNoNkelJqB6I0KpGa9oZ+oG1wMQgm9CZidOUSnUVujRECfEYiS/nvTqBAhPvDOCouw9EIAJQD9suXkfa8GvmW72qbIVXzIwipfFyCnqqrPUIQawosvVC/P5X7av3v3Lg3JSFeDID7IOipPD34nU4L50g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1p6ZVhxWUhpV1dZWXU1NDBGWllvdnVzZWlFaUZ3ZzNHRURGQ2JVZ2JnZ0Rr?=
 =?utf-8?B?eG53STV0cGlVckJNbUlzTGRIajVGejVINFdzQU9BNTl5MkpXblU4VnlMMGpL?=
 =?utf-8?B?VVZhb1BGSERtUkR0Si9haG9rNkR1Z3lyb1IvOE1tZ2l2dXd2cDRQK3UyVFBz?=
 =?utf-8?B?TjYxWGErdXRuOEl4NlZtUmNlNVpqakkyZXNEZXBnb2ZsMFBsdnF5QUphWFhK?=
 =?utf-8?B?dUxkUWNWOWN2a2p0VU80WUVzNVY3TXVBYVlrdWpyQU9SVEo2ZkI5VlR3ajN6?=
 =?utf-8?B?a2IrdHdydC82SEZtQ3pOSHkwdGtYRFlDNFJOTmVzbjBVaHlqVFdhcEwvZnJD?=
 =?utf-8?B?SjdDQmRWRzV0S1JjeTEzS3ptM3UvSWNXdGozYVdKZklkQ0d5bGZtdXFlbzhi?=
 =?utf-8?B?L0oxYlNEbW5YcVdOZ0UzMU9DZmFtc3VvODhkdDJYL2hTMjVkdElqZTB2YVdI?=
 =?utf-8?B?RWdEQUk0ZCsxaGNhUEhFSmQ3ajUxMTBEZ2xPRXVyRzQ1YzFkMVFzZmhNalph?=
 =?utf-8?B?L3p1QnE3SkJpaEE2TTY2TjYyL013N1lya0tDZHF6SytWdlBwN1lFNzNOZWxs?=
 =?utf-8?B?U2JjRzlyR0lWL3o2d3h1cEVEbGg5dkRwejlnRkQzWHUvRm9qZEJSK0dYblVr?=
 =?utf-8?B?NEJNNjQrcVBUZzhicG4yZ09kNjBLVnZKNVltVS9qdE4walpRMHo3SzdwRnJn?=
 =?utf-8?B?b1FQR0xVYkVsdVVvbG1pWlUvOTEyanRyYURzdDFwWm15cG15NWFzMDZxczRa?=
 =?utf-8?B?ZmM0ZFpYeGM0a3FhRFRRNmUyZ0d1ZHZnS0wzY3YzSkd1WnBlV0RwbmhUbjNI?=
 =?utf-8?B?MzhkU3gvS3ZIYkNBTGh4TmxFY3I1cHdOWHU5MVVQMDJRVlhZSEk5blo2d0RK?=
 =?utf-8?B?QUhUZGFHWmpvSStLVW93V0pRVkdFdnZvcWdBaC9RSFFHTFdEdHZmN25JR0VG?=
 =?utf-8?B?K2ZoSUpSMktjUGVSV0FMYk84VDhBUTdWV01zZ1VqSExwcmtKV2xYWmdnaklr?=
 =?utf-8?B?NEc3NXFuVzN3STJLdlgxOUlNZ0FlVU81Vmg5NEZtRjRPc2owMk01RzVpTHk2?=
 =?utf-8?B?UEJpaHNoMmRFbFV5YjlSUTRrdE41KzVydjNzQTZ0ZEYvNTdjMWtmcW1SbmRW?=
 =?utf-8?B?STVpSy9ZdmVWeXpmc1RtZEdraGJyYSthQVF5RWo3bGh0R2FuM09Sd0hBVmp4?=
 =?utf-8?B?MTBuSVdUOXZqNWhoTkIwZFZJYjlhSGtQeGI0WHh4c3FBczRmV1ZGZmN4eEQz?=
 =?utf-8?B?bDREeEZSdE5aamVxYXIzMHkyNDVYclpWQnVaS0hkMkxDUkJYYUZReHRVSFkr?=
 =?utf-8?B?SG16SlpVcjdLQTlXb1FIMjk3aGEwL3g4dktYVGQ5c0VrRSt4UTdJTHVVV2xH?=
 =?utf-8?B?cnhkVkhPcjJxQlR2cGxhUU16WnBxTXNMaUVOb3JxS0tLZmRybmhuam1PTkJJ?=
 =?utf-8?B?UjRKUnFUdHJhUlluQ0d2Y1A5MDF3RElxS0xMRlhIT2t5Y2oxL3kyNDh0Sytw?=
 =?utf-8?B?SDM1NEY3a21QTWJOSlY3aWd4MVZ0cWdHZXdjVlVwcklhN0ZMZ00zN3d0VWhV?=
 =?utf-8?B?cDhHWDJZb2dySUlTU0RLV1VCem1uRFBsL1dsZldDdC9WTlZGajNMck5yWm9T?=
 =?utf-8?B?SEljTWwxVWd1d0tndURDeVpCNzFJU3J4dDhKbVpsQm9ZcXo2OEdkK2NKMHds?=
 =?utf-8?B?S3pVdkc1clNXbmRvRGJzeWlyNGZYbG8reXNzOVJ3MVJwVUJ1TlBVcElRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9394b916-6f6d-466c-de3e-08dad2141ddb
X-MS-Exchange-CrossTenant-AuthSource: DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 14:15:07.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1596
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/11/27 11:27, Ji Rongfeng wrote:
> On 2022/11/24 8:40, Martin KaFai Lau wrote:
>> On 11/23/22 4:18 PM, Daniel Borkmann wrote:
>>> On 11/18/22 9:18 AM, Ji Rongfeng wrote:
>>>> * append missing optnames to the end
>>>> * simplify bpf_getsockopt()'s doc
>>>>
>>>> Signed-off-by: Ji Rongfeng <SikoJobs@outlook.com>
>>>> ---
>>>>   include/uapi/linux/bpf.h       | 20 ++++++++++++--------
>>>>   tools/include/uapi/linux/bpf.h | 20 ++++++++++++--------
>>>>   2 files changed, 24 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>> index 51b9aa640ad2..14f29d95ea71 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -2576,14 +2576,19 @@ union bpf_attr {
>>>>    *         * **SOL_SOCKET**, which supports the following 
>>>> *optname*\ s:
>>>>    *           **SO_RCVBUF**, **SO_SNDBUF**, **SO_MAX_PACING_RATE**,
>>>>    *           **SO_PRIORITY**, **SO_RCVLOWAT**, **SO_MARK**,
>>>> - *           **SO_BINDTODEVICE**, **SO_KEEPALIVE**.
>>>> + *           **SO_BINDTODEVICE**, **SO_KEEPALIVE**, **SO_REUSEADDR**,
>>>> + *           **SO_REUSEPORT**, **SO_BINDTOIFINDEX**, **SO_TXREHASH**.
>>>>    *         * **IPPROTO_TCP**, which supports the following 
>>>> *optname*\ s:
>>>>    *           **TCP_CONGESTION**, **TCP_BPF_IW**,
>>>>    *           **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
>>>>    *           **TCP_KEEPIDLE**, **TCP_KEEPINTVL**, **TCP_KEEPCNT**,
>>>> - *          **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, 
>>>> **TCP_NOTSENT_LOWAT**.
>>>> + *           **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, 
>>>> **TCP_NOTSENT_LOWAT**,
>>>> + *           **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
>>>> + *           **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
>>>> + *           **TCP_BPF_RTO_MIN**.
>>>>    *         * **IPPROTO_IP**, which supports *optname* **IP_TOS**.
>>>> - *         * **IPPROTO_IPV6**, which supports *optname* 
>>>> **IPV6_TCLASS**.
>>>> + *         * **IPPROTO_IPV6**, which supports the following 
>>>> *optname*\ s:
>>>> + *           **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
>>>>    *     Return
>>>>    *         0 on success, or a negative error in case of failure.
>>>>    *
>>>> @@ -2800,12 +2805,11 @@ union bpf_attr {
>>>>    *           and **BPF_CGROUP_INET6_CONNECT**.
>>>>    *
>>>>    *         This helper actually implements a subset of 
>>>> **getsockopt()**.
>>>> - *         It supports the following *level*\ s:
>>>> + *         It supports the same set of *optname*\ s that supported by
>>>
>>> nit: that is supported by
>>>
>>>> + *         **bpf_setsockopt**\ () helper with a few exceptions:
>>>>    *
>>>> - *         * **IPPROTO_TCP**, which supports *optname*
>>>> - *           **TCP_CONGESTION**.
>>>> - *         * **IPPROTO_IP**, which supports *optname* **IP_TOS**.
>>>> - *         * **IPPROTO_IPV6**, which supports *optname* 
>>>> **IPV6_TCLASS**.
>>>> + *         * **bpf_setsockopt**\ () helper only: **TCP_BPF_***.
>>>> + *         * **bpf_getsockopt**\ () helper only: **TCP_SAVED_SYNC**.
>>>
>>> I think from a user PoV the above is a bit hard to follow, maybe take 
>>> Martin's
>>> earlier feedback into account and add a proper sentence; it will be 
>>> much easier
>>> to understand.
>>
>> +1  Made the change and also fixed TCP_SAVED_SYNC with s/SYNC/SYN/ 
>> while applying.  Thanks!
> 
> Thanks for the helpful reviews. I chose the form of lists was because we 
> could
> append more optnames easily in the future. But I believe it's not late 
> to apply
> that form when we really need it : )
> 
> In my opinion, this patch doesn't contain any new feature, but just a 

new features

> kind of fix
> to the documentation, according to the corresponding code in the bpf tree,
> which hasn't been modified yet in the bpf-next tree. So I targeted the 
> former,
> as this patch could be useful there. Please let me know if there's any 

if there're

> customary
> rules outside bpf_devel_QA. Thanks!

I just found that SO_BINDTODEVICE is bpf_setsockopt() only. I checked 
sock_getbindtodevice() and there's nothing special comparing with 
sock_setbindtodevice(), except "down_read(&devnet_rename_sem);" and 
"up_read(&devnet_rename_sem);". Martin once wrote:

 > The only exception is SO_BINDTODEVICE because it needs to acquire a
 > blocking lock.  Thus, SO_BINDTODEVICE is not supported.

Were you referring to "down_read(&devnet_rename_sem);"? Seems it's not 
acquiring a blocking lock. Maybe "devnet_rename_sem" has been locked for 
writing somewhere in bpf before? Please let me know. Thanks!
