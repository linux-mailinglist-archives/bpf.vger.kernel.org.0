Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A4621DCC
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 21:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiKHUlF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 15:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKHUlD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 15:41:03 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD76713E
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 12:41:02 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8JRPJG009107;
        Tue, 8 Nov 2022 12:40:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=9Rqm6XxVkmOXw2IcuO7oxX6xpGAUZzJmnLMb2QXKJrI=;
 b=n7jVJ/KXKAKhZGfs9GW8vCUezmjjFNlmL1bKWcrrkd23IcwmUR9EamYwP/aE7lNhC8f7
 shgX/9o3w13q1a7mnINDWxLRxJHurhxePb7Q6/EWw5HwhqA+cVMyWeuV3DG65klZYpwE
 yjyUKAtOW2rHnXqi6Sv53heDRPbs9aW52OrIBzIDjV0IBF0ZyEUKbK4ozcgE4QxVTR6B
 UZ4tK4GkpQu9VKNgPARfdbylbfaa2YZjfuHyUxnEBF02HESK6w4BsKOKy7u4fphVWZU0
 Bi17VjX6Ct/FtCPafG35Bz5oy1z7pB+Z2Hni6GmY54YMRvZaLLZDsB5xQdxE3A/7f5ic 4w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqj3npdfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 12:40:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AABOgcWb6VXu5mbHwwnEgS5f/YTKZwIXDKseY0wxdR2UuY3rvvIOelmnjUzTxTVYf3tV+LCReEabIlQMqld9sjIwKXGHqsCeLHnL+1uE8GPj0ooZf/1tBdgyHQuy6pDghhezBqikpDamH/YDCS9uJncoD58KXBlSlCNrQ8gF4GqXsb0kX36KIFnNot9cAZorb84YdwYp7Qy1ne+AcN+XsuSZ13rBWogzuw2yxPQF17Deu6Xr3i0aGF6o6vKHX+/0QuUolpDT3PF5SFVtGuE3SQkacyPthTHicxCLL3ced7ury8cXH7aGJMqVM9IenjaZAzGFhxeAOWJysU4QXU0JuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Rqm6XxVkmOXw2IcuO7oxX6xpGAUZzJmnLMb2QXKJrI=;
 b=Zp9gGmFuf+rBzOLUHpZU8L96GwVD1ry43xM/dNCrJqaDT6W15G8l0cn9NPdfqPCOmyV7LB3p55z+Ll/nTzFo5gFPX67RCiQDE+KqEaoXmEWB9GFkOarRITsWpwfdgzE1WsWAm/tIRYKtE5z5jdP2pH61XJ/r19VsFtRQwpIVOUG+gEYFN0Pf94xIh94Ks4hP3tfeXkZ+4IiRXe/6cugLg9rafWQ4g8cm3gujcTr3389Zgb5iRjW6hfDg67qP2zOwzdNJfjKgF2utfZL455+Qg7WmruAS6sS2ElHRhOI0wALroYpBkVS8gznNLzn47aXknjKndjV0PgnTcW79k6ST/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY5PR15MB3601.namprd15.prod.outlook.com (2603:10b6:a03:1fb::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Tue, 8 Nov
 2022 20:40:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 20:40:44 +0000
Message-ID: <bb6a4598-2e28-9b95-bd23-ac6ed3b87260@meta.com>
Date:   Tue, 8 Nov 2022 12:40:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v2 5/8] bpf: Add bpf_rcu_read_lock() verifier
 support
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221108074047.261848-1-yhs@fb.com>
 <20221108074114.264485-1-yhs@fb.com> <20221108170452.jq24rymkfeozxtwj@apollo>
 <04ed904e-a901-70ea-ddb6-a87aa5bd2736@meta.com>
 <20221108201938.byemttanmpbh3gn4@apollo>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108201938.byemttanmpbh3gn4@apollo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:40::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY5PR15MB3601:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a6a3a5-34cb-4ba3-93eb-08dac1c98215
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxWmm7DJZofSr7iFwDMmFVV2E9UTAFWpT9NA03UP8IhI8QHsXs2D/ObTPY5R9iHUNarN2u7ry3Jsb/yCvR4M6EyqFNoF+rRbYJSGQphroI8GKvEAY808pJbqeKBN46k/bVEGQEBi82jQ3L27EgNl1+LvvI8uLVzEhm5+VlKIdBlvjodcEPfJijkNbFLk9WxY7Ab0HvxaeK20v5xsk9iag1OIm9yGriBIhA2HehZVyJRnFJA/V6czl5Yrh+bmC0kwvR2zsrq+pkHD/rl/bKM26ueFrrcDuSO8rcMgolPbnmmKqW6/xt4kyZmwkdMgpeIyMKp6ecE9e7I1Rn4GWdiY5f59K2msbkizhZmMEMzLI86ze3mPGvzN2qR+DPUL+u3JnZn8tdc5jt16rVXPMc2Oa5YlcypoFgqUqnRxHgcUNX9B1ZxH0kyqZ+ZAP7AZbbl6atEsY7B64p+c1MufT/quBLFwsytkmRcq+Q//UvXjAhLCDCxGYdcOrFV48rmGQeNDI+6wvqHlMBr1Ud2R7jxAV4nQH2mIU0LPtci/CrQ8Ptz3Y7EBf1BfA+LMNBOvN4ZSDxWqaUVzG+1CnPllwC/9d4zc6u+xKH57LRGNacU2I+QiOOlHfE6kl0SdWT3Z9SQ8bPz0moCjv39imy0YeZZrRCr8Ee9/MX2xE+h6CEVrie1ksJe3pjBSR7G5+9ZiUxVuU5bW+VwC5MAG1UbgQIZ7hNX+yTcRYZqvI8tOGrXQxwBaupSOaFgQM3pG/ojlPfZVTTWb2LQAOwfRvKB3Tavhj12lD7dWgBIZ8KRTZWve0Y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199015)(36756003)(83380400001)(31686004)(5660300002)(6506007)(38100700002)(86362001)(31696002)(2906002)(8936002)(8676002)(4326008)(41300700001)(316002)(6916009)(53546011)(6512007)(66556008)(478600001)(54906003)(66476007)(6486002)(186003)(2616005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aStXQ3IwSzBiTjNrZktqcmVncldBbC9Da2Z5MmZ2LzhBT2dpZFl6bVMyZGtj?=
 =?utf-8?B?VzhHTlBocGprckh0T1UyODNGKzJERzdTWStMczNad1RuSERMTTJqZ05ydFVa?=
 =?utf-8?B?dEF2bW51MmFKV1lkZ1Y5SEg4NnRPUU1jcnhub1dyTThiYUJHNzhERFRDbldT?=
 =?utf-8?B?SHQyYzQ0RnhPaUdTa1NDZnZtQ3JGLzBGNFNOTGpON25adzlTSkxRSXcwdnZn?=
 =?utf-8?B?SHBGMnU2SjlaK2RkM0ZkMVFrNUIwS2NUcGRtaU1xRSsyZ2JQSEQwS0ljU01N?=
 =?utf-8?B?S3JjVGxNMzdLMWZyMTlETE9ZSndSWC9zd2ZCb3FFRU5WUE9HNkZUZDBvVjR4?=
 =?utf-8?B?MHdFV05DZFlIeVlOejl3ZDRDd0xBcE9mMWVla3lpYVNFUXZTMUZnNTl1MDNJ?=
 =?utf-8?B?ZkdUZTBZMG8yOWFYRTNaZmY1SWFoU054cHY1ZVNQTk1TcVRSdkcwUlBQSHdy?=
 =?utf-8?B?VkxZTDVTeXpQc2oxSzhjSVdoN2RtcjNvZlkraVJ0c1ZXcVh4dWFvNWRWV3Bk?=
 =?utf-8?B?THVzSXlFNUZ5T2FyQWpnMXg0aStINzlyakQ0cjBEWWx6cUEyMzdZajNRRFpk?=
 =?utf-8?B?cXdINGJHOHk4cllieWV2b1FucjlUVXJrV0FTc0J3Yy8vb29CUkRyeEEwZDNx?=
 =?utf-8?B?V3k1aG9SSUUvNTdxRjQzMUNMMUlGMEREQlExMVNTcjFTWTVSRXFwUnhKNzh3?=
 =?utf-8?B?eitOdDJERFluaUhTb1FvbWxHb3dpeWtGM3NxK1RRSTh0VW5KT0JKTG9ZUlNN?=
 =?utf-8?B?VDRlUGF1RFRsSUFyV3hITG9RTWErUkt3TUI4em1QbG44bHl3VnFoZm5iQ21a?=
 =?utf-8?B?VlZqZzFpVnlNRWlhWndCcW92U2lCYVkzaDI4WWtkVmZTS1pxTnFkUEVwOVBq?=
 =?utf-8?B?NHpLbWY5ZlZPN1lYcDJBNFlDLzF1OHlDaS8rbEpuV2xzMDQ1ZW96TEtCNmd1?=
 =?utf-8?B?cEhUd1Z3b0NHK3FCMGhzVGxBbDBQM3REcng5ekNVTm1SNnVDR0pIT0Rqa1p1?=
 =?utf-8?B?YzluVGthN2xNbkZTd2txOEJNbmM3Ym03eFEyNmpOVXJRTXVLYkZPLzh3UGd2?=
 =?utf-8?B?ZGEyK2JQT2lYc2JxdkEveVArc3JMZmM5OGNzczMrU255KytGWmhDdDJSbU5k?=
 =?utf-8?B?YTNWUjEvM1pzQVFQWVJyd2ZSY2c2dGZ6Ym5naXVvSTRrZHpacktRYU55dVAy?=
 =?utf-8?B?eWdtR3ErTGhML0J2VUt6SUdLZXJPQ1gwSHVTcmRCaTBTZjN0WmwvZU9PeFA2?=
 =?utf-8?B?b1JhbFBPajRncmtEZVFaZkpuRmZGWktTdE1iUk1QdzByclpWVFIvODRTRHhC?=
 =?utf-8?B?c3AwMXJmMzFITDg0Mm83VGVWWnVCcE5waG1PWnVGcWVKVFB1RHhWN1BhaEU5?=
 =?utf-8?B?Z3NqUDdxcCtaZFZpd0FhQU93RUtkTjVXWkFyU0tsR1hMTkQwZTJETXltNjdE?=
 =?utf-8?B?RHBJTmNqalFZb3E4anRNcTVubERuK2hxYUwzWGxPSWFrTlNiZ09aaWh3SFBI?=
 =?utf-8?B?VUE1SW91TUlDa3lHOENBQTBYdnBwMUJQRTc1UUdUR3BNN1pESWNMU2xzSGcx?=
 =?utf-8?B?T1BlZ3ZLOE5qTUF3Y1ByN3MwTllZMTVuNXQxaklkaW5VWkZ6Z1ZNSGIxbzhO?=
 =?utf-8?B?M2JNdTlpbHdJdzNMcWcwQ1ZLYU9xeDA4NmEyb1hwS1VHcnVyTE1nOHE0ZWhL?=
 =?utf-8?B?dHNlenFQK3FjbFJ5R3pmNDQ0WDloNkVDNWlUOFJhUHFPZW1nL2c1bS9uc3Zi?=
 =?utf-8?B?S1dQQ0dGMUk3UFNHKzJNRS9EcVY1S2lxSjkwTXk2ZkdiRWN5THY3Y1M1MzFu?=
 =?utf-8?B?dUtDTFVCZW14OXVuQXNOL3NWeWFTanpydkNyWUhRMmwwanEva2Iya3pPMkUz?=
 =?utf-8?B?TzMzSkhzckxtZ1BxNHhWQTNMb1ZpUVZLR2FTV1VMS21jN2pFaWZOUkRIN1ZV?=
 =?utf-8?B?L3RIbVN5TmQ0bUhtaDhEYy93Ykk0NFpPbC9KZUU2UGVSakdTS0k0SVhacEw2?=
 =?utf-8?B?bXgza1ovWVJjTzNmLzZBS3ZleW5CbllaOVY3SEZhQW5IWHBUaStQV1NBZDA3?=
 =?utf-8?B?cnFVRi9XRm44NUFuaHIyQ25xQitQeFA0TC9LRGlhL0w2L0VlcUJhb0NzRGNG?=
 =?utf-8?B?N3d0WDRvUE5kaWprRDR4WGVXdTRnWWxpVDZncVVmc1lmN2pueDJlTE94ZGJT?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a6a3a5-34cb-4ba3-93eb-08dac1c98215
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 20:40:44.2792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmoYPDnlDL2GvXxd7IZCmdRBeclZC74ssqNqhSuXo+mGafX4SnaFoHaiRav8E3sw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3601
X-Proofpoint-ORIG-GUID: W08tO3FZrxVseBzzKzbepfIHO920lG4C
X-Proofpoint-GUID: W08tO3FZrxVseBzzKzbepfIHO920lG4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 12:19 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, Nov 09, 2022 at 01:33:04AM IST, Yonghong Song wrote:
>>
>>
>> On 11/8/22 9:04 AM, Kumar Kartikeya Dwivedi wrote:
>>> On Tue, Nov 08, 2022 at 01:11:14PM IST, Yonghong Song wrote:
>>>> To simplify the design and support the common practice, no
>>>> nested bpf_rcu_read_lock() is allowed. During verification,
>>>> each paired bpf_rcu_read_lock()/unlock() has a unique
>>>> region id, starting from 1. Each rcu ptr register also
>>>> remembers the region id when the ptr reg is initialized.
>>>> The following is a simple example to illustrate the
>>>> rcu lock regions and usage of rcu ptr's.
>>>>
>>>>        ...                    <=== rcu lock region 0
>>>>        bpf_rcu_read_lock()    <=== rcu lock region 1
>>>>        rcu_ptr1 = ...         <=== rcu_ptr1 with region 1
>>>>        ... using rcu_ptr1 ...
>>>>        bpf_rcu_read_unlock()
>>>>        ...                    <=== rcu lock region -1
>>>>        bpf_rcu_read_lock()    <=== rcu lock region 2
>>>>        rcu_ptr2 = ...         <=== rcu_ptr2 with region 2
>>>>        ... using rcu_ptr2 ...
>>>>        ... using rcu_ptr1 ... <=== wrong, region 1 rcu_ptr in region 2
>>>>        bpf_rcu_read_unlock()
>>>>
>>>> Outside the rcu lock region, the rcu lock region id is 0 or negative of
>>>> previous valid rcu lock region id, so the next valid rcu lock region
>>>> id can be easily computed.
>>>>
>>>> Note that rcu protection is not needed for non-sleepable program. But
>>>> it is supported to make cross-sleepable/nonsleepable development easier.
>>>> For non-sleepable program, the following insns can be inside the rcu
>>>> lock region:
>>>>     - any non call insns except BPF_ABS/BPF_IND
>>>>     - non sleepable helpers or kfuncs
>>>> Also, bpf_*_storage_get() helper's 5th hidden argument (for memory
>>>> allocation flag) should be GFP_ATOMIC.
>>>>
>>>> If a pointer (PTR_TO_BTF_ID) is marked as rcu, then any use of
>>>> this pointer and the load which gets this pointer needs to be
>>>> protected by bpf_rcu_read_lock(). The following shows a couple
>>>> of examples:
>>>>     struct task_struct {
>>>>           ...
>>>>           struct task_struct __rcu        *real_parent;
>>>>           struct css_set __rcu            *cgroups;
>>>>           ...
>>>>     };
>>>>     struct css_set {
>>>>           ...
>>>>           struct cgroup *dfl_cgrp;
>>>>           ...
>>>>     }
>>>>     ...
>>>>     task = bpf_get_current_task_btf();
>>>>     cgroups = task->cgroups;
>>>>     dfl_cgroup = cgroups->dfl_cgrp;
>>>>     ... using dfl_cgroup ...
>>>>
>>>> The bpf_rcu_read_lock/unlock() should be added like below to
>>>> avoid verification failures.
>>>>     task = bpf_get_current_task_btf();
>>>>     bpf_rcu_read_lock();
>>>>     cgroups = task->cgroups;
>>>>     dfl_cgroup = cgroups->dfl_cgrp;
>>>>     bpf_rcu_read_unlock();
>>>>     ... using dfl_cgroup ...
>>>>
>>>> The following is another example for task->real_parent.
>>>>     task = bpf_get_current_task_btf();
>>>>     bpf_rcu_read_lock();
>>>>     real_parent = task->real_parent;
>>>>     ... bpf_task_storage_get(&map, real_parent, 0, 0);
>>>>     bpf_rcu_read_unlock();
>>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    include/linux/bpf.h          |  1 +
>>>>    include/linux/bpf_verifier.h |  7 +++
>>>>    kernel/bpf/btf.c             | 32 ++++++++++++-
>>>>    kernel/bpf/verifier.c        | 92 +++++++++++++++++++++++++++++++-----
>>>>    4 files changed, 120 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index b4bbcafd1c9b..98af0c9ec721 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>> @@ -761,6 +761,7 @@ struct bpf_prog_ops {
>>>>    struct btf_struct_access_info {
>>>>    	u32 next_btf_id;
>>>>    	enum bpf_type_flag flag;
>>>> +	bool is_rcu;
>>>>    };
>>>>
>>>>    struct bpf_verifier_ops {
>>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>>> index 1a32baa78ce2..5d703637bb12 100644
>>>> --- a/include/linux/bpf_verifier.h
>>>> +++ b/include/linux/bpf_verifier.h
>>>> @@ -179,6 +179,10 @@ struct bpf_reg_state {
>>>>    	 */
>>>>    	s32 subreg_def;
>>>>    	enum bpf_reg_liveness live;
>>>> +	/* 0: not rcu ptr; > 0: rcu ptr, id of the rcu read lock region where
>>>> +	 * the rcu ptr reg is initialized.
>>>> +	 */
>>>> +	int active_rcu_lock;
>>>>    	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
>>>>    	bool precise;
>>>>    };
>>>> @@ -324,6 +328,8 @@ struct bpf_verifier_state {
>>>>    	u32 insn_idx;
>>>>    	u32 curframe;
>>>>    	u32 active_spin_lock;
>>>> +	/* <= 0: not in rcu read lock region; > 0: the rcu lock region id */
>>>> +	int active_rcu_lock;
>>>>    	bool speculative;
>>>>
>>>>    	/* first and last insn idx of this verifier state */
>>>> @@ -424,6 +430,7 @@ struct bpf_insn_aux_data {
>>>>    	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
>>>>    	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
>>>>    	bool zext_dst; /* this insn zero extends dst reg */
>>>> +	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
>>>>    	u8 alu_state; /* used in combination with alu_limit */
>>>>
>>>>    	/* below fields are initialized once */
>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>> index d2ee1669a2f3..c5a9569f2ae0 100644
>>>> --- a/kernel/bpf/btf.c
>>>> +++ b/kernel/bpf/btf.c
>>>> @@ -5831,6 +5831,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>>>>    		if (btf_type_is_ptr(mtype)) {
>>>>    			const struct btf_type *stype, *t;
>>>>    			enum bpf_type_flag tmp_flag = 0;
>>>> +			bool is_rcu = false;
>>>>    			u32 id;
>>>>
>>>>    			if (msize != size || off != moff) {
>>>> @@ -5850,12 +5851,16 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>>>>    				/* check __percpu tag */
>>>>    				if (strcmp(tag_value, "percpu") == 0)
>>>>    					tmp_flag = MEM_PERCPU;
>>>> +				/* check __rcu tag */
>>>> +				if (strcmp(tag_value, "rcu") == 0)
>>>> +					is_rcu = true;
>>>>    			}
>>>>
>>>>    			stype = btf_type_skip_modifiers(btf, mtype->type, &id);
>>>>    			if (btf_type_is_struct(stype)) {
>>>>    				info->next_btf_id = id;
>>>>    				info->flag = tmp_flag;
>>>> +				info->is_rcu = is_rcu;
>>>>    				return WALK_PTR;
>>>>    			}
>>>>    		}
>>>> @@ -6317,7 +6322,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>>>>    {
>>>>    	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>>>    	bool rel = false, kptr_get = false, trusted_args = false;
>>>> -	bool sleepable = false;
>>>> +	bool sleepable = false, rcu_lock = false, rcu_unlock = false;
>>>>    	struct bpf_verifier_log *log = &env->log;
>>>>    	u32 i, nargs, ref_id, ref_obj_id = 0;
>>>>    	bool is_kfunc = btf_is_kernel(btf);
>>>> @@ -6356,6 +6361,31 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>>>>    		kptr_get = kfunc_meta->flags & KF_KPTR_GET;
>>>>    		trusted_args = kfunc_meta->flags & KF_TRUSTED_ARGS;
>>>>    		sleepable = kfunc_meta->flags & KF_SLEEPABLE;
>>>> +		rcu_lock = kfunc_meta->flags & KF_RCU_LOCK;
>>>> +		rcu_unlock = kfunc_meta->flags & KF_RCU_UNLOCK;
>>>> +	}
>>>> +
>>>> +	/* checking rcu read lock/unlock */
>>>> +	if (env->cur_state->active_rcu_lock > 0) {
>>>> +		if (rcu_lock) {
>>>> +			bpf_log(log, "nested rcu read lock (kernel function %s)\n", func_name);
>>>> +			return -EINVAL;
>>>> +		} else if (rcu_unlock) {
>>>> +			/* change active_rcu_lock to its corresponding negative value to
>>>> +			 * preserve the previous lock region id.
>>>> +			 */
>>>> +			env->cur_state->active_rcu_lock = -env->cur_state->active_rcu_lock;
>>>> +		} else if (sleepable) {
>>>> +			bpf_log(log, "kernel func %s is sleepable within rcu_read_lock region\n",
>>>> +				func_name);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +	} else if (rcu_lock) {
>>>> +		/* a new lock region started, increase the region id. */
>>>> +		env->cur_state->active_rcu_lock = (-env->cur_state->active_rcu_lock) + 1;
>>>> +	} else if (rcu_unlock) {
>>>> +		bpf_log(log, "unmatched rcu read unlock (kernel function %s)\n", func_name);
>>>> +		return -EINVAL;
>>>>    	}
>>>>
>>>
>>> Can you provide more context on why having ids is better than simply
>>> invalidating the registers when the section ends, and making active_rcu_lock a
>>> boolean instead? You can use bpf_for_each_reg_in_vstate to find every reg having
>>> MEM_RCU and mark it unknown.
>>
>> I think we also need to invalidate rcu-ptr related states as well in spills.
>>
>> I also tried to support cases like:
>> 	bpf_rcu_read_lock();
>> 	rcu_ptr = ...
>> 	   ... rcu_ptr ...
>> 	bpf_rcu_read_unlock();
>> 	... rcu_ptr ... /* no load, just use the rcu_ptr somehow */
>>
>> In the above case, outside the rcu read lock region, there is no
>> load with rcu_ptr but it can still be used for other purposes
>> with a property of a pointer.
>>
>> But for a second thought, it should be okay to invalidate
>> rcu_ptr during bpf_rcu_read_unlock() as a scalar. This should
>> satisfy almost all (if not all) cases.
>>
>>>
>>> You won't have to match the id in btf_struct_access as such registers won't ever
>>> reach that function (if marked unknown on invalidation, they become scalars).
>>> The reg state won't need another active_rcu_lock member either, it is simply
>>> part of reg->type.
>>
>> Right, if I don't maintain region id's, no need to have reg->active_rcu_lock
>> and using MEM_RCU should be enough.
>>
>>>
>>> It seems to that simply invalidating registers when rcu_read_unlock is called is
>>> both less code to write and simpler to understand.
>>
>> invalidating rcu_ptr in registers and spills.
>>
> 
> If you use bpf_for_each_reg_in_vstate, it should cover both.

Just checked the macro implementation. Yes, it covers both reg and 
spills. Thanks for mentioning bpf_for_each_reg_in_vstate which I
am not aware of.
