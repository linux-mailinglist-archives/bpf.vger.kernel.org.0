Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE46081E3
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 00:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJUW5n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 18:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJUW5m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 18:57:42 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8052958EC
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:57:39 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LMHiZR019597;
        Fri, 21 Oct 2022 15:57:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=nLsG7dzis7Et8EIVvTIJdgswLzrc0GrqRzK7AmoAH0U=;
 b=i6Uixrco/Le9DdTYf9dP1f63ZU58tmRwGjsowxX7eMNT7oM29x+xruFkujkdx9kuWYzu
 jNCpFKckyk6Htx3MBBQnVSSNIo9S5LK2w03YdWyufQ3oqhpwSekANsUlo0uZIRPqaxNn
 T+DqW5J2HQImagjggIl4IVg3vk4qDm8raeq4qNapzivg5l8GNbFgCcZCJN4Jal4fWfLv
 ro5W35WQL8UIYCBgVWLmVrnVWeMJ+g0BaRnbmv4NZKbXMlu7zHP7k+fetuCavZO517t9
 cB3DSzhmoaRv9WSeXxgbVppyp7rx32Jtvz9hsGLxEc8EYeylKwLLBP+o1ItYs1KN2fDy mg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kbx02c7ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 15:57:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M70fZILpSkpwfy3G+v+AiBlPxSnMkvBcXds23n4koYYdDavR4JjPmWMGDc32odcB5ekq2LJh2mi+B/XSJbyNIU4vRhbg/SJKiU5z0LV92WZ51chCa2p0SsrKoDAXFCyv7fQKwES0z95RwyprkeG6TSOP/l6SO4s2sjk5lLf+Dr410hIyDj3TsoBS6iPQK43D7w2Mxdn1JMaG+3UYhU4DcYusnvmJ1j7H6FwR1Q8GuJmbNDSC1UpE7gZDqJqDhNEjl/mh0XZj8PWAQCDJfo3SL6QaAIzSOoJj4FDa+zSpc/ySpDqV3iFNf15AOyJMZllTG3sr+75ce8GLQJj7qVShxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLsG7dzis7Et8EIVvTIJdgswLzrc0GrqRzK7AmoAH0U=;
 b=S6yvhcg0vN2svpwK5MeUuZNWKdGTXcqBW5IEq8Cy5Za83s5rmgkx1b3cT+Sz9fqHspuvT+wF2lANIa8OTeZ7uOS4kwuSG3V9qqndjTLe3i+auR4Fic/tdy8JgdDuHFHND92UCUzvTzLSMpPER0OyhYm2fzv6rwtHk2fEWR1kMJS8Bs0sMOIQTBcD3xglzbvI9goSK/WHn+v0tY4x8Khnk7ydM/6Nx5cDF/qwb6hv+zFDqjmTKLNP+gKr1KEAwmFyxuEluqm+98Bm3S6j7yR3uFYdXKqLwf4EOOF9scnZ+9nIRbvTjbziOc1/9wnX3zngnNws1l7OsFZJcDGRw3zEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2554.namprd15.prod.outlook.com (2603:10b6:5:1a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 22:57:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.036; Fri, 21 Oct 2022
 22:57:19 +0000
Message-ID: <c815edb6-b008-07f4-2377-17b53ccdc289@meta.com>
Date:   Fri, 21 Oct 2022 15:57:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221306.3554250-1-yhs@fb.com>
 <Y1IsqVB2H7kksOh8@maniforge.dhcp.thefacebook.com>
 <a9f1be39-4f8e-3f33-f3e0-368f3beec1a8@meta.com>
 <Y1L5oZdzn3kxZL+G@maniforge.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y1L5oZdzn3kxZL+G@maniforge.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:208:234::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2554:EE_
X-MS-Office365-Filtering-Correlation-Id: 121b7b19-cf42-484f-cbe4-08dab3b79b6d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noNGrvypryphSQ+cDZUl5W3C5lcFDWLd14O+8YAbrpRd9HMwsR/e/YUwyzO/O+62DhfCdigwZCZ0yvTo5ss6DVGkeNL3ljUcO2SwqULadH2IJyeepMtQGW4S20xiwTPZOcQxtO2UeK0v/OG66ZlE55yKj+Xf22KOXN+qrf/57MoMEIcimSHeNlQ1BMo/85w/jGL49XTFxEcQF3lzunVe1q2e5hdpjWX7K2E3l62gt0iqoaE4nXcy/LVt76L4Hwsz4RzWiy2cubIJNzDf1OjT3sDilgLR2n9sPiw0qVECMsRBRznfTLZptfTFs4+QRxNStIZlnmTf8lJeqcrZVk2c4FPzOL0nQ17e6LLTLCRLboiWbtDfGdyFbtuqr6E04kt1ovt2D9ViM9wU51rMV5IR9F9FQZfp+THNKnV4k+WLEajCguAag1AtHGXsDbmDDuiTwZh717UaBRHMjLN7YJApt12Uye3mo6r+qGTTUs1oFzjyjZBYI8Ya/jHJHa6LTLvrc7EZqY6PQvQZ8tya+e1aqFgpwgw8PjVbelQya1w9BwXt492+ubsx6mR3hXACwKHkGl9E1sz2I6cCKGZorrIdG5G6kLn5ZvgZ79sJm8ie4AINPRlvV8WM7m4NEdLPrZnDyguhlQ7MgCA3JEtsDyEOYr8ZQkeM29lNir0bhtnInSukhCq6ejNF4XhajEb1S6UZpLxyT3be2An03V2B9DBI3pRdaKC29LQ4X0qZq1q0C72gxt+QcxPCaSZXM8SzT5HH/3+MX1gvFNUqzqZIck5rYChmnpvFeOGp3GqwPVFZmsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(8936002)(54906003)(66476007)(478600001)(41300700001)(66556008)(6486002)(5660300002)(6916009)(30864003)(36756003)(316002)(8676002)(66946007)(4326008)(83380400001)(31696002)(38100700002)(86362001)(53546011)(6512007)(6666004)(6506007)(186003)(2616005)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RERXVHowU2RyN3JzZFNDRklwbkFDVG8zLyt0ZVdHT2JrL0pjR2dibVRnaUFG?=
 =?utf-8?B?OVFRdjFRaHowYUxHUStjSWJvVUNZVjYrTENDMDB6dzRkVHdpMzlKVTFCcVVs?=
 =?utf-8?B?L0tUaWcvTSs0SHB3OHZQODNEVmtITW5qWkZrbWh5azAyeklodVkyRTVWYzNG?=
 =?utf-8?B?U0dGRm5VdExab1J6YTNXb0UxWHBTTnh4NjRNSllRQkcxYTJRdldEY2VnZGVD?=
 =?utf-8?B?WHBjZHZ2OFA4bkUvQlhQRjJVRmVkMm9KNkVkVG9VMURBV0NQa0MwVzNBMms5?=
 =?utf-8?B?QlZpVHhBM1R5Ri8vdUI0MUlJQjh3dTQvNjJqVWZUU1NKdzBmK0NFeFhJNWtP?=
 =?utf-8?B?Tm9qVllDdU9ubG5YUVFGOFAwbXJnVFRvbDUzNlRYT0JrMUM2dmR6TUxtSCtN?=
 =?utf-8?B?OGdSRVZ3QkFoNmNaclgxQVRwOUpkNWxYbW84MWUzaXNyUThRT2doZDBXelQ0?=
 =?utf-8?B?U3dEUXY0UVdMc2VrSjVYbXhoOHlFb3JXOFdvYUtWdlAvRWpLNWNkRlZjTC80?=
 =?utf-8?B?SnJVSDBFV0ZVZzlOZEtlekkvQTJCNVBsZWhIMENpaVpnTTlGb09STEl5Wit3?=
 =?utf-8?B?QU8zdk9LOFRyaTFhUzFVV043U2dlK1JXd3dIVnhKamc3eEdvOWhBajEvVkVo?=
 =?utf-8?B?OWlFVnh3WStxanQvUVprdGxRYS9YL0pweXQ0dVRLejFKeW1xRGlZZm1oSi9h?=
 =?utf-8?B?S1orZUNGQlQ3NlQ0Y0hNelBrK2NuQ1JCQ3JQL1hnaytHUktURzF0azZJOWtk?=
 =?utf-8?B?aE5XaEZPQmpZdWtQOWxzdUlSY1J4em5QWlNOODljK0ZQeThaS2dXNWV6cVhS?=
 =?utf-8?B?UUdBUTFvT29nNlcveURRRHJXQ2tyY1RWNlA1TjFvQno1Z1Z1MFFTUTAwS2lE?=
 =?utf-8?B?V1ZwMlNsWmNvUTRHb0p6dWFsb09kVEM1THlobHNhOWZwb0pmRkpaSWJoRUJv?=
 =?utf-8?B?dTNSMlJrazlmRjQzMlMzRldHdE9MejIvdnBsL0J6MEJtc3V0MU5LMGYwK2pp?=
 =?utf-8?B?UFkzSTU4dTJGMGlyK1o5UnlHREhmWGlFUDlZck44cWh3Kzh0U2gwb3BodWZD?=
 =?utf-8?B?QllmdGRyWGw1UEdtRjlBQ2dpWlQ5UkM0djhWc0tFMHdSaDhoRmlpcngrSjJH?=
 =?utf-8?B?bklnYXFIdkl2ZnJ3ajY0WmNXd1hzUGxJdzZIV285TUhSbU1wOHo4U1FuY01Z?=
 =?utf-8?B?RGNLL2tGcnliaC9qa0YxUjJWZVlhWGxOQy9WdFlTWExkY0o5WjA3amFJNjd2?=
 =?utf-8?B?clcwbktFNXZVcFYza3F1aEVKK2pXZmhMOEN4L2FKNi9LYm1ZNmVjQzFvTG15?=
 =?utf-8?B?RUNnY3VnRVFqMFcrN1N3TS96bXhET3loZDhGYVByZU9sYUNSMVdkaVM1eVls?=
 =?utf-8?B?TjhjUWxwRk9pWmNNOGsxOXoxU1RFOXMxQ0ZTTUdJMlkxN3FnenB4TG5mSlM1?=
 =?utf-8?B?ckZkOUc2MHcrRUJCbGp6THhJdGtLQ2duZVBaNmFOeWtMYzdPNGxnU2MwaDhB?=
 =?utf-8?B?UDV0NW1JbEZUZmsyN1VWY3Z0UGZNeGNWL2lOcnMrb1BDKzVRNUZWUmtMdnho?=
 =?utf-8?B?bjlNTHp4QzVJNm5pRjdZWEZINVVXSnM1Sk1JZytFTkFQWndvUTdIbWorSmpw?=
 =?utf-8?B?UkF2Z3RqRVZqQ0lUeXNHVG1QZmwvR0cyWnV0NGFUNDQzcnhFb1VXMG10dGZH?=
 =?utf-8?B?Z2lwMUR1UzBmbHR4TEJBK2txalh2OEhHLzV1UnBBZ2xFaDNlWHVyWHZ0Ulkv?=
 =?utf-8?B?QjBqeVhzMUlvU0kwT2MxOW01ZHp0dXNVdVJqMWZTUHNLaWV3Q2xRNmFTTkVa?=
 =?utf-8?B?NGlxSTkwcnFlVlJCZ2QvNVIvQXIxdkZZZ1ZCVXpCN0RZbDY4c21Lc2FqanZP?=
 =?utf-8?B?MnBSSWZJbmcvNmJIMFdFMzRSSTE2cWsrbkZFQkdUUE1aYUFjc2tEK2szNlN4?=
 =?utf-8?B?MkxvRXZKMjhsVjFwN000NHg4RmN2R0w3N2RGbUdLMEltd2tOM2tMekN1OXFl?=
 =?utf-8?B?NEZ0YVFnSERxbWRKUTNPemdxNFBWci9qRVcvZ3RxbHhSMDhsbVV0VzcyeEJ4?=
 =?utf-8?B?bk1EN1p3THh5cjBkUWhwRkM4SmtLdUZHMGRtU1Q1ZU5yaHFEaUxUczJQNThT?=
 =?utf-8?Q?NvuLGFR9+WnBQymrYhksU8DdK?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121b7b19-cf42-484f-cbe4-08dab3b79b6d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 22:57:19.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaSVII005A7MlWJlglQTeQrclt7L6ewYYrUYvzGnjr+bwc7RXjXZIO9C4g4l4uAB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2554
X-Proofpoint-GUID: HSU6e1Xfi9vz2LdtRZc02QuaQBlPnCu3
X-Proofpoint-ORIG-GUID: HSU6e1Xfi9vz2LdtRZc02QuaQBlPnCu3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/21/22 12:57 PM, David Vernet wrote:
> On Fri, Oct 21, 2022 at 10:33:41AM -0700, Yonghong Song wrote:
> 
> [...]
> 
>>>>    /* Note that tracing related programs such as
>>>> @@ -5435,6 +5443,42 @@ union bpf_attr {
>>>>     *		**-E2BIG** if user-space has tried to publish a sample which is
>>>>     *		larger than the size of the ring buffer, or which cannot fit
>>>>     *		within a struct bpf_dynptr.
>>>> + *
>>>> + * void *bpf_cgrp_storage_get(struct bpf_map *map, struct cgroup *cgroup, void *value, u64 flags)
>>>> + *	Description
>>>> + *		Get a bpf_local_storage from the *cgroup*.
>>>> + *
>>>> + *		Logically, it could be thought of as getting the value from
>>>> + *		a *map* with *cgroup* as the **key**.  From this
>>>> + *		perspective,  the usage is not much different from
>>>> + *		**bpf_map_lookup_elem**\ (*map*, **&**\ *cgroup*) except this
>>>> + *		helper enforces the key must be a cgroup struct and the map must also
>>>> + *		be a **BPF_MAP_TYPE_CGRP_STORAGE**.
>>>> + *
>>>> + *		Underneath, the value is stored locally at *cgroup* instead of
>>>> + *		the *map*.  The *map* is used as the bpf-local-storage
>>>> + *		"type". The bpf-local-storage "type" (i.e. the *map*) is
>>>> + *		searched against all bpf_local_storage residing at *cgroup*.
>>>
>>> IMO this paragraph is a bit hard to parse. Please correct me if I'm
>>> wrong, but I think what it's trying to convey is that when an instance
>>> of cgroup bpf-local-storage is accessed by a program in e.g.
>>> bpf_cgrp_storage_get(), all of the cgroup bpf_local_storage entries are
>>> iterated over in the struct cgroup object until this program's local
>>> storage instance is found. Is that right? If so, perhaps something like
>>> this would be more clear:
>>
>> yes. your above interpretation is correct.
>>
>>>
>>> In reality, the local-storage value is embedded directly inside of the
>>> *cgroup* object itself, rather than being located in the
>>> **BPF_MAP_TYPE_CGRP_STORAGE** map. When the local-storage value is
>>> queried for some *map* on a *cgroup* object, the kernel will perform an
>>> O(n) iteration over all of the live local-storage values for that
>>> *cgroup* object until the local-storage value for the *map* is found.
>>
>> Sounds okay. I can change the explanation like the above.
> 
> Thanks!
> 
>>>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>>>> index 341c94f208f4..3a12e6b400a2 100644
>>>> --- a/kernel/bpf/Makefile
>>>> +++ b/kernel/bpf/Makefile
>>>> @@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
>>>>    obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
>>>>    endif
>>>>    ifeq ($(CONFIG_CGROUPS),y)
>>>
>>> I assume that you double checked that it's valid to compile the helper
>>> with CONFIG_CGROUPS && !CONFIG_CGROUP_BPF, but I must admit that even if
>>> that's the case, I'm not following why we would want the map to be
>>> compiled with a different kconfig option than the helper that provides
>>> access to it. If theres's a precedent for doing this then I suppose it's
>>> fine, but it does seem wrong and/or at least wasteful to compile these
>>> helpers in if CONFIG_CGROUPS is defined but CONFIG_CGROUP_BPF is not.
>>
>> The following is my understanding.
>> CONFIG_CGROUP_BPF guards kernel/bpf/cgroup.c which contains implementation
>> mostly for cgroup-attached program types, helpers, etc.
> 
> Then why are we using it to guard
> BPF_MAP_TYPE(BPF_MAP_TYPE_CGRP_STORAGE, cgrp_storage_map_ops)?
> 
>> A lot of other cgroup-related implementation like cgroup_iter, some
>> cgroup related helper (not related to cgroup-attached program types), etc.
>> are guarded with CONFIG_CGROUPS and CONFIG_BPF_SYSCALL.
>>
>> Note that it is totally possible CONFIG_CGROUP_BPF is 'n' while
>> CONFIG_CGROUPS and CONFIG_BPF_SYSCALL are 'y'.
>>
>> So for cgroup local storage implemented in this patch set,
>> using CONFIG_CGROUPS and CONFIG_BPF_SYSCALL seems okay.
> 
> I agree that it's fine to use CONFIG_CGROUPS here. What I'm not
> understanding is why we're using CONFIG_CGROUP_BPF to guard defining
> BPF_MAP_TYPE(BPF_MAP_TYPE_CGRP_STORAGE, cgrp_storage_map_ops), and then
> in the Makefile we're using CONFIG_CGROUPS to add bpf_cgrp_storage.o.
> 
> In other words, I think there's a mismatch between:
> 
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -90,6 +90,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
>   #ifdef CONFIG_CGROUP_BPF
> 
> ^^ why this instead of CONFIG_CGROUPS for BPF_MAP_TYPE_CGRP_STORAGE?
> 
>   BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
>   BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_CGRP_STORAGE, cgrp_storage_map_ops)
>   #endif
>   BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
>   BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
> 
> and
> 
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 341c94f208f4..3a12e6b400a2 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
>   obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
>   endif
>   ifeq ($(CONFIG_CGROUPS),y)
> -obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
> +obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgrp_storage.o
>   endif
>   obj-$(CONFIG_CGROUP_BPF) += cgroup.o
>   ifeq ($(CONFIG_INET),y)

This makes sense. I will guard
   BPF_MAP_TYPE(BPF_MAP_TYPE_CGRP_STORAGE, cgrp_storage_map_ops)
with CONFIG_CGROUPS.

> 
>>>> -obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
>>>> +obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgrp_storage.o
>>>>    endif
>>>>    obj-$(CONFIG_CGROUP_BPF) += cgroup.o
>>>>    ifeq ($(CONFIG_INET),y)
> 
> [...]
> 
>>>> +	 * could be modifying the local_storage->list now.
>>>> +	 * Thus, no elem can be added-to or deleted-from the
>>>> +	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
>>>> +	 *
>>>> +	 * It is racing with bpf_local_storage_map_free() alone
>>>> +	 * when unlinking elem from the local_storage->list and
>>>> +	 * the map's bucket->list.
>>>> +	 */
>>>> +	bpf_cgrp_storage_lock();
>>>> +	raw_spin_lock_irqsave(&local_storage->lock, flags);
>>>> +	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>>>> +		bpf_selem_unlink_map(selem);
>>>> +		free_cgroup_storage =
>>>> +			bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
>>>
>>> This still requires a comment explaining why it's OK to overwrite
>>> free_cgroup_storage with a previous value from calling
>>> bpf_selem_unlink_storage_nolock(). Even if that is safe, this looks like
>>> a pretty weird programming pattern, and IMO doing this feels more
>>> intentional and future-proof:
>>>
>>> if (bpf_selem_unlink_storage_nolock(local_storage, selem, false, false))
>>> 	free_cgroup_storage = true;
>>
>> We have a comment a few lines below.
>>    /* free_cgroup_storage should always be true as long as
>>     * local_storage->list was non-empty.
>>     */
>>    if (free_cgroup_storage)
>> 	kfree_rcu(local_storage, rcu);
> 
> IMO that comment doesn't provide much useful information -- it states an
> assumption, but doesn't give a reason for it.
> 
>> I will add more explanation in the above code like
>>
>> 	bpf_selem_unlink_map(selem);
>> 	/* If local_storage list only have one element, the
>> 	 * bpf_selem_unlink_storage_nolock() will return true.
>> 	 * Otherwise, it will return false. The current loop iteration
>> 	 * intends to remove all local storage. So the last iteration
>> 	 * of the loop will set the free_cgroup_storage to true.
>> 	 */
>> 	free_cgroup_storage =
>> 		bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> 
> Thanks, this is the type of comment I was looking for.
> 
> Also, I realize this was copy-pasted from a number of other possible
> locations in the codebase which are doing the same thing, but I still
> think this pattern is an odd and brittle way to do this. We're relying
> on an abstracted implementation detail of
> bpf_selem_unlink_storage_nolock() for correctness, which IMO is a signal
> that bpf_selem_unlink_storage_nolock() should probably be the one
> invoking kfree_rcu() on behalf of callers in the first place.  It looks
> like all of the callers end up calling kfree_rcu() on the struct
> bpf_local_storage * if bpf_selem_unlink_storage_nolock() returns true,
> so can we just move the responsibility of freeing the local storage
> object down into bpf_selem_unlink_storage_nolock() where it's unlinked?

We probably cannot do this. bpf_selem_unlink_storage_nolock()
is inside the rcu_read_lock() region. We do kfree_rcu() outside
the rcu_read_lock() region.


> 
> IMO this can be done in a separate patch set, if we decide it's worth
> doing at all.
> 
>>>
>>>> +	}
>>>> +	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>>>> +	bpf_cgrp_storage_unlock();
>>>> +	rcu_read_unlock();
>>>> +
>>>> +	/* free_cgroup_storage should always be true as long as
>>>> +	 * local_storage->list was non-empty.
>>>> +	 */
>>>> +	if (free_cgroup_storage)
>>>> +		kfree_rcu(local_storage, rcu);
>>>> +}
>>>> +
>>>> +static struct bpf_local_storage_data *
>>>> +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool cacheit_lockit)
>>>> +{
>>>> +	struct bpf_local_storage *cgroup_storage;
>>>> +	struct bpf_local_storage_map *smap;
>>>> +
>>>> +	cgroup_storage = rcu_dereference_check(cgroup->bpf_cgrp_storage,
>>>> +					       bpf_rcu_lock_held());
>>>> +	if (!cgroup_storage)
>>>> +		return NULL;
>>>> +
>>>> +	smap = (struct bpf_local_storage_map *)map;
>>>> +	return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
>>>> +}
>>>> +
>>>> +static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
>>>> +{
>>>> +	struct bpf_local_storage_data *sdata;
>>>> +	struct cgroup *cgroup;
>>>> +	int fd;
>>>> +
>>>> +	fd = *(int *)key;
>>>> +	cgroup = cgroup_get_from_fd(fd);
>>>> +	if (IS_ERR(cgroup))
>>>> +		return ERR_CAST(cgroup);
>>>> +
>>>> +	bpf_cgrp_storage_lock();
>>>> +	sdata = cgroup_storage_lookup(cgroup, map, true);
>>>> +	bpf_cgrp_storage_unlock();
>>>> +	cgroup_put(cgroup);
>>>> +	return sdata ? sdata->data : NULL;
>>>> +}
>>>
>>> Stanislav pointed out in the v1 revision that there's a lot of very
>>> similar logic in task storage, and I think you'd mentioned that you were
>>> going to think about generalizing some of that. Have you had a chance to
>>> consider?
>>
>> It is hard to have a common function for
>> lookup_elem/update_elem/delete_elem(). They are quite different as each
>> heavily involves
>> task/cgroup-specific functions.
> 
> Yes agreed, each implementation is acquiring their own references, and
> finding the backing element in whatever way it was implemented, etc.
> 
>> but map_alloc and map_free could have common helpers.
> 
> Agreed, and many of the static functions that are invoked on those paths
> such as bpf_cgrp_storage_free(), bpf_cgrp_storage_lock(), etc possibly
> as well. In general this feels like something we could pretty easily
> simplify using something like a structure with callbacks to implement
> the pieces of logic that are specific to each local storage type, such
> as getting the struct bpf_local_storage __rcu
> * pointer from some context (e.g.  cgroup_storage_ptr()). It doesn't
> necessarily need to block this change, but IMO we should clean this up
> soon because a lot of this is nearly a 100% copy-paste of other local
> storage implementations.

Further refactoring is possible. Martin is working to simplify the
locking mechanism. We can wait for that done before doing refactoring.

> 
> Thanks,
> David
