Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211803DB2EF
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 07:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhG3Fmn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 01:42:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230162AbhG3Fmm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 01:42:42 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U5etXk024334;
        Thu, 29 Jul 2021 22:42:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Z44zpIlr/oKYymiknl3iZS/+SYXUiuXl6xkNACnzccw=;
 b=iALLIEN+mCtliSWRdju2+lwgOUATbE6dq7RdqTJb9vzcP3K1Q9dquaRn7UsV/E2fiJ3o
 aHOEh6r+OAAVHVdoDM88BsQwxOzYI+i6IRLqdt+QctJWrNFI7UvKsAHu5bwcEpTzN05L
 TCGHA1nSXLKpTSaG6DCzvEJXzKbken0kCtM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a491c8rnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 22:42:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 22:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GB7d+NB9VOKdCH25UzbAaxGvlUhNLoyjuTQQ+IdF2sPA/XX19YaxrRO2DoxuMMFDL528deN0ELFlg6SmFOAaDREKjGERIvJrsKqgsQkdudVCRoJiStFIOa/VyF1HKDqudkjKaNvBkDr8cYb8ay3qR/7RDbDef0En44UETs9u8l5bt+p2pW04wg5arHyPnjvWeNz3QaxEGVWTiNEXh0VgFdzbLFj4wlbT/qZk/zwCzQshH5nPeJcm2taYQ7++sGBpvHQbzUOas+mvBRaWwMKFAIUTDZu4eaVFTs7An+mLwkZXATNoJf0VkIF+D+le04lrOUcuYFqdjpVVX+1Ahp26JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z44zpIlr/oKYymiknl3iZS/+SYXUiuXl6xkNACnzccw=;
 b=lqpJl8td4U2rw7Q1mZHVKnA+N3ZbuIdGJttueyMK24qDvDD1EEPtSVL15PRAmcFlkiphYWMbBm4v85gkzyBLI88rUqpal0gTHLgmKKNMWdTwBci750ZQ7xFdOhH84fET5nfsaLNNnxqJc1jDBgYx3HgKDY7ynrMMNKFd7P4yUIXXej21ijPVfu0K6acVmwFNyQ4Jc+CYbMC6vNlqFiZXLGkhSxPpQpBKtgGvZNP0Aw8+Cu3OtgOxu9AF1wY5nOLISj6AhJ34A1uorlqHgEROduTiy+fBGiuCQxM1NHBqQOEhMqn0kDTopbbyvsnDFIdHFJ1Ut7FUzx8IgbUTh5UOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3822.namprd15.prod.outlook.com (2603:10b6:806:83::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 05:42:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 05:42:12 +0000
Subject: Re: [PATCH v2 bpf-next 04/14] bpf: implement minimal BPF perf link
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-5-andrii@kernel.org>
 <6b61514f-3ab8-34bd-539f-e5ff8d769e77@fb.com>
 <CAEf4BzYah9zEKiwygK_4=fqOWF7rDOXu3RH_7GLDYwn7Y7sR2A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <52d2383f-38f2-1af2-731e-26b163c1fc28@fb.com>
Date:   Thu, 29 Jul 2021 22:42:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <CAEf4BzYah9zEKiwygK_4=fqOWF7rDOXu3RH_7GLDYwn7Y7sR2A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1130] (2620:10d:c090:400::5:1fa2) by SJ0PR13CA0130.namprd13.prod.outlook.com (2603:10b6:a03:2c6::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Fri, 30 Jul 2021 05:42:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42b8164e-960a-4f7f-ed3f-08d9531cc74b
X-MS-TrafficTypeDiagnostic: SA0PR15MB3822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3822F5341E4FE60E4A5A69BFD3EC9@SA0PR15MB3822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VG6KE+SDePjlTw44ko5PBa4ij0ZQWl2YoQsi7mzEODcjj7wVBM143EfD5KS8Q7iR/gm4jpQsSIE33o/vzqu1/HCYiA+C6i4B6G2T3j23tBeih0NjFlzG/Nl3O7vXV4WV9jbCvLdervfSOCjDQj1tXjUIDBkBsCoOMF4Ym6yVWczMUEw3F+CdH3ufQYyEYNUXqQkU3v536PzIweOVEIzfnxy7zFFKBkluwOOQAdnV75piJ79ARZMeuODkhYJqAelfDjPiWoMSp5SgBPM/fFnMFm2AahULw5OZeJnu+5lD+A4P+7n+9pCFBVD3+yxAZD1I1b8NIpDVyY9g2x4XOpKwmRAQcXfLYhcnKEyecggWp7qffE/C5XnnYUgktmuMjc8EBXlSjxJtAEBejRE85e21TQtmLRzZkDEfHBJ2wpY5DUZ4YiUJbtqJelWcGOiQAUhGtJ1hrwseHxGAfFUyMmGAIg6yrWsLooGwpbwLOyoVkI1ipu+7vV6fvCxKGqUl8HiKhfEIhfsLOH52xe/QAAXHePeH2ycZUP1nzg+YN85mfBfX8UcUJeIz+SpPyM3Cb6xdJyrduAa1eHRzWQEAiEDs5Vizp7uQboSe5WNs0URVTgSzVqBr8Hth0jYHQJMcwCe31DfGjSBQc9Ed4oEpcMRxCq/yVXPINy3de1ZQAZUT7G1jCYwwDYKz7Ddmzf+9K535XnqTw/fpiKvzGNKgMv6819UV3WwsAlU5o2dEf0/a+c0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(8676002)(31696002)(8936002)(316002)(5660300002)(54906003)(53546011)(86362001)(4326008)(83380400001)(508600001)(6916009)(6486002)(36756003)(38100700002)(66476007)(52116002)(66556008)(2616005)(2906002)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnpBbVZVQlpBT0VHZXFOcGRMWUp4MnZBMU94ZklqMzNSZG1yT0ZrcFZYNWpG?=
 =?utf-8?B?eWk2N3JCSzgrb1d0MjloWWd3cVN5SEJKWjBnYW9iRTh0MlIvbjF2WksxYlJ1?=
 =?utf-8?B?ODJlRCtrbk5jbVZBZjczS0svclgvNFZ6dTFtckhlV0piV0wwNVRjZ2xlajE5?=
 =?utf-8?B?cndka3dLcVg0Ym96WElJeEh3Mms5Z0h5YW05dnNHREJ3bSthQ0hwUHJLditU?=
 =?utf-8?B?MC9vNWg3aG5yVW9yUlN0NENvNU5zVERERnd4MkJWSjk1WWdlMkVic3QrRWk2?=
 =?utf-8?B?OHpVYXJ1Y0NLNitOUXhKMUU2Z0hPRGNWbXYvMG1JQytGOG91cHRUaVZPa1d0?=
 =?utf-8?B?Z1BzTFZidWVJdEpUZUxFa2xSdTIyYThxbmh2aDNIanJ1RXN2d05DMS9mOHVT?=
 =?utf-8?B?aWE0Q3RKcXlkOHludjl5M05ZT0liU3ZHUXl5TExLMzVXN1htREs3RWhKOGVN?=
 =?utf-8?B?WGJ5cUE3bjExZUVFUlVOekFoWGJGUytyeFR6ckJMTlo0RU5IdzhEbTc4cndQ?=
 =?utf-8?B?dXQxbk9uNXNQSThTSFpCTlRFV2M0bHlzbXo4UFQ3Z0sxTGUxeFRJcEQzdFRy?=
 =?utf-8?B?T3BWSjdIUm92dzgwZkdBMFZ5WmxIdlFtRVlVWExvOFQ1UU81cjUzU00zbHdU?=
 =?utf-8?B?dWtQVTNjZERCU2x5RVE1T1JCUzlyaEtKVGpwcnkwY1kyN0Z5NjhzUm9PZUFn?=
 =?utf-8?B?TXlUdmtidys4dUJkWFVRM3JMV0YxanBJTzM3VW9KbFBCR3lxSFlEWDBXcnhX?=
 =?utf-8?B?S08zTk55Tnh2dUdYczlyeW1NRWhIald3SHR1MnJkUS8zcmgzOXRpU25YN1lQ?=
 =?utf-8?B?RENsUWdwWXRsci8yTVNWRnN1ZTI3bXJhVVFvSnpFVXI2cVBTVkwyK3FhaHdm?=
 =?utf-8?B?Z0FuNFpIZ1FxSlBPU3EzYWZIc0JxTnFTbXc3TGJtclBVZytiejl5N0VydkhX?=
 =?utf-8?B?Sy9PZkVpOTk2VWVOWkp2V043ZUw4Vjk0bmRPL0ViWTBETkgvUmlXS3FubDJK?=
 =?utf-8?B?QjhVR05KZEpST1k3dVIrUWNocHFYLzVtb0U5NTY5TkZSVWRqc2lNRXdUbVJv?=
 =?utf-8?B?RVdkcEJhbjJXNVovZmJnOEtHSWgzT2Yyb1NuT0Q0ZDdRV1k4b2hHb0FnbDN6?=
 =?utf-8?B?RkVJcTJxeSs1SjhsMGdROU11Z2R6bHBqQ1RYRmY2RnpFUWYzWTZhT25WcHMv?=
 =?utf-8?B?eTZSWHhvQSs3NUJHRDRkQUoyMWwxa0VtYUdWT05hOW45amZnRURxK0NSaGdY?=
 =?utf-8?B?b1pLRlpLN05idTRuRlhZRlA2eElsU05iU1U1OHQybmVwc000RXNIYmR1YWhS?=
 =?utf-8?B?SStjT29UOUU0YjdHVlk2cmxHdnlQSlVXWEZYUjRLanlZZmxneGNWK2JzUm9V?=
 =?utf-8?B?VE83UWdaZFYrMFFQUVE3Wm9UUTlEMG1sMmY1WGVYT0xJaUVoUXgrSlY2MWpx?=
 =?utf-8?B?ZGNKQTRCNThjWDQ2Wkh2aXpEc3p4ZVBkc1V0b05FcXl2Z2xNNkE3SFhISEh3?=
 =?utf-8?B?MG5JMkZ2cFM4T2ZUY252NlY0RG9wY0JRNW54a3NzNlpWamRwY2dtTTdaa1Nv?=
 =?utf-8?B?cHJRVzVhK1ZnRUsyeFMyRHJZZmJYOUZEcmJnd3ZMeU05c3lLY3lNU1U0L3U3?=
 =?utf-8?B?Mmx1M1BLRUIzNjVITkJMOEp4bmNqeGtGRDVPR1hHcVRnOGo4TEk4VnR1RGlw?=
 =?utf-8?B?a0wwZEpZMjYrckZiNVRnT3I1Y3RKNW96YTRiNjUyZ2QzQSt2eDlFdVdVNzFr?=
 =?utf-8?B?a1lONUl6dE9uNXJQM1p3R1BxaWhmM0s0ajgwOUEzRW01RFU0c1JQOFpsRlVa?=
 =?utf-8?Q?Jw6Q1Cc23KWh9wSYlxWnxG5sO4nzi2mTg/P0M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b8164e-960a-4f7f-ed3f-08d9531cc74b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 05:42:11.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kx7zALHV0fJBvCXWsXL1tUzrqzEdfCtPSn2c6D1E5WFyDv+Lpy1ZsbMyX7KUsFa8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3822
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: MJ1LDLakO3aSlyyob3T2v4UN1N45x5VJ
X-Proofpoint-GUID: MJ1LDLakO3aSlyyob3T2v4UN1N45x5VJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_03:2021-07-29,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/21 9:16 PM, Andrii Nakryiko wrote:
> On Thu, Jul 29, 2021 at 10:36 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
>>> Introduce a new type of BPF link - BPF perf link. This brings perf_event-based
>>> BPF program attachments (perf_event, tracepoints, kprobes, and uprobes) into
>>> the common BPF link infrastructure, allowing to list all active perf_event
>>> based attachments, auto-detaching BPF program from perf_event when link's FD
>>> is closed, get generic BPF link fdinfo/get_info functionality.
>>>
>>> BPF_LINK_CREATE command expects perf_event's FD as target_fd. No extra flags
>>> are currently supported.
>>>
>>> Force-detaching and atomic BPF program updates are not yet implemented, but
>>> with perf_event-based BPF links we now have common framework for this without
>>> the need to extend ioctl()-based perf_event interface.
>>>
>>> One interesting consideration is a new value for bpf_attach_type, which
>>> BPF_LINK_CREATE command expects. Generally, it's either 1-to-1 mapping from
>>> bpf_attach_type to bpf_prog_type, or many-to-1 mapping from a subset of
>>> bpf_attach_types to one bpf_prog_type (e.g., see BPF_PROG_TYPE_SK_SKB or
>>> BPF_PROG_TYPE_CGROUP_SOCK). In this case, though, we have three different
>>> program types (KPROBE, TRACEPOINT, PERF_EVENT) using the same perf_event-based
>>> mechanism, so it's many bpf_prog_types to one bpf_attach_type. I chose to
>>> define a single BPF_PERF_EVENT attach type for all of them and adjust
>>> link_create()'s logic for checking correspondence between attach type and
>>> program type.
>>>
>>> The alternative would be to define three new attach types (e.g., BPF_KPROBE,
>>> BPF_TRACEPOINT, and BPF_PERF_EVENT), but that seemed like unnecessary overkill
>>> and BPF_KPROBE will cause naming conflicts with BPF_KPROBE() macro, defined by
>>> libbpf. I chose to not do this to avoid unnecessary proliferation of
>>> bpf_attach_type enum values and not have to deal with naming conflicts.
>>>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>>    include/linux/bpf_types.h      |   3 +
>>>    include/linux/trace_events.h   |   3 +
>>>    include/uapi/linux/bpf.h       |   2 +
>>>    kernel/bpf/syscall.c           | 105 ++++++++++++++++++++++++++++++---
>>>    kernel/events/core.c           |  10 ++--
>>>    tools/include/uapi/linux/bpf.h |   2 +
>>>    6 files changed, 112 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
>>> index a9db1eae6796..0a1ada7f174d 100644
>>> --- a/include/linux/bpf_types.h
>>> +++ b/include/linux/bpf_types.h
>>> @@ -135,3 +135,6 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
>>>    #ifdef CONFIG_NET
>>>    BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
>>>    #endif
>>> +#ifdef CONFIG_PERF_EVENTS
>>> +BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
>>> +#endif
>>> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
>>> index ad413b382a3c..8ac92560d3a3 100644
>>> --- a/include/linux/trace_events.h
>>> +++ b/include/linux/trace_events.h
>>> @@ -803,6 +803,9 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
>>>    void perf_trace_buf_update(void *record, u16 type);
>>>    void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
>>>
>>> +int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
>>> +void perf_event_free_bpf_prog(struct perf_event *event);
>>> +
>>>    void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
>>>    void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
>>>    void bpf_trace_run3(struct bpf_prog *prog, u64 arg1, u64 arg2,
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 2db6925e04f4..00b1267ab4f0 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -993,6 +993,7 @@ enum bpf_attach_type {
>>>        BPF_SK_SKB_VERDICT,
>>>        BPF_SK_REUSEPORT_SELECT,
>>>        BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
>>> +     BPF_PERF_EVENT,
>>>        __MAX_BPF_ATTACH_TYPE
>>>    };
>>>
>>> @@ -1006,6 +1007,7 @@ enum bpf_link_type {
>>>        BPF_LINK_TYPE_ITER = 4,
>>>        BPF_LINK_TYPE_NETNS = 5,
>>>        BPF_LINK_TYPE_XDP = 6,
>>> +     BPF_LINK_TYPE_PERF_EVENT = 6,
>>
>> As Jiri has pointed out, BPF_LINK_TYPE_PERF_EVENT = 7.
> 
> yep, fixed
> 
>>
>>>
>>>        MAX_BPF_LINK_TYPE,
>>>    };
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 9a2068e39d23..80c03bedd6e6 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -2906,6 +2906,79 @@ static const struct bpf_link_ops bpf_raw_tp_link_lops = {
>>>        .fill_link_info = bpf_raw_tp_link_fill_link_info,
>>>    };
>>>
>>> +#ifdef CONFIG_PERF_EVENTS
>>> +struct bpf_perf_link {
>>> +     struct bpf_link link;
>>> +     struct file *perf_file;
>>> +};
>>> +
>>> +static void bpf_perf_link_release(struct bpf_link *link)
>>> +{
>>> +     struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
>>> +     struct perf_event *event = perf_link->perf_file->private_data;
>>> +
>>> +     perf_event_free_bpf_prog(event);
>>> +     fput(perf_link->perf_file);
>>> +}
>>> +
>>> +static void bpf_perf_link_dealloc(struct bpf_link *link)
>>> +{
>>> +     struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
>>> +
>>> +     kfree(perf_link);
>>> +}
>>> +
>>> +static const struct bpf_link_ops bpf_perf_link_lops = {
>>> +     .release = bpf_perf_link_release,
>>> +     .dealloc = bpf_perf_link_dealloc,
>>> +};
>>> +
>>> +static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>> +{
>>> +     struct bpf_link_primer link_primer;
>>> +     struct bpf_perf_link *link;
>>> +     struct perf_event *event;
>>> +     struct file *perf_file;
>>> +     int err;
>>> +
>>> +     if (attr->link_create.flags)
>>> +             return -EINVAL;
>>> +
>>> +     perf_file = perf_event_get(attr->link_create.target_fd);
>>> +     if (IS_ERR(perf_file))
>>> +             return PTR_ERR(perf_file);
>>> +
>>> +     link = kzalloc(sizeof(*link), GFP_USER);
>>
>> add __GFP_NOWARN flag?
> 
> I looked at few other bpf_link_alloc places in this file, they don't
> use NOWARN flag. I think the idea with NOWARN flag is to avoid memory
> alloc warnings when amount of allocated memory depends on
> user-specified parameter (like the size of the map value). In this
> case it's just a single fixed-size kernel object, so while users can
> create lots of them, each is fixed in size. It's similar as any other
> kernel object (e.g., struct file). So I think it's good as is.

That is fine. This is really a small struct, unlikely we have issues.

> 
>>
>>> +     if (!link) {
>>> +             err = -ENOMEM;
>>> +             goto out_put_file;
>>> +     }
>>> +     bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_link_lops, prog);
>>> +     link->perf_file = perf_file;
>>> +
>>> +     err = bpf_link_prime(&link->link, &link_primer);
>>> +     if (err) {
>>> +             kfree(link);
>>> +             goto out_put_file;
>>> +     }
>>> +
>>> +     event = perf_file->private_data;
>>> +     err = perf_event_set_bpf_prog(event, prog);
>>> +     if (err) {
>>> +             bpf_link_cleanup(&link_primer);
>>
>> Do you need kfree(link) here?
> 
> bpf_link_cleanup() will call kfree() in deferred fashion. This is due
> to bpf_link_prime() allocating anon_inode file internally, so it needs
> to be freed carefully and that's what bpf_link_cleanup() is for.

Looking at the code again, I am able to figure out. Indeed,
kfree(link) is called through file->release().

> 
>>
>>> +             goto out_put_file;
>>> +     }
>>> +     /* perf_event_set_bpf_prog() doesn't take its own refcnt on prog */
>>> +     bpf_prog_inc(prog);
>>> +
>>> +     return bpf_link_settle(&link_primer);
>>> +
>>> +out_put_file:
>>> +     fput(perf_file);
>>> +     return err;
>>> +}
>>> +#endif /* CONFIG_PERF_EVENTS */
>>> +
>>>    #define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
>>>
>> [...]
