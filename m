Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660B4570A4B
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 21:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiGKTFU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 15:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKTFT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 15:05:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777DF371A9
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 12:05:18 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BJ4ZcV029741;
        Mon, 11 Jul 2022 12:04:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VcimdLEmQ6pPmqdeJFlI7T7NS4+wcOFJzMxoTfeQ4xY=;
 b=C35EC13csNOeZUY3LrSBnWZcS+FYuQoHBZM25IZasTjShauEa9Y6k9ZE6/oSl6tJXM8G
 gdD6HPXmtotc+dj93i4d0ycCLdp0UZhflXSUHnD9F4Jp1zKpzPdlsMZ0p+Ze1EnPfj9z
 cCTJi5VPAd7PleHL3j2w4Xyx+Pi1YLMkKEM= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h8pgnsjh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 12:04:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/IxOJCuZTuYbn0yngZaL1HELPMOt2mgEtgRRnfW7Qkunn53qRrJYSa+ktOMcDIOpALbgmDZsp5Hwtt7Iga2ndhlF25miuP5g4eITAPDsfwuXD7B14rmNU8ra8ENko4EeHmhppMaZMlX0u6EcJsRqnD4w4VDt9hY1I753FetT9MPebisXzYxXp+0FlSf2Hk5yilxpd4PZCGDkJkrDFf+rTIJyLK7pbALJ1P2zbA9hsuIfBMQpBD61/B+BWyfmsMKMHhWnkIHpu67u3aPEHbVQ0/7mHSCChCjpOMDEbOecjp/IK2izld3dS9mxWrGSk1K5KLrqR2QXtPRaT59IJAq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcimdLEmQ6pPmqdeJFlI7T7NS4+wcOFJzMxoTfeQ4xY=;
 b=hqSwBE3o7FC/bVm611383zS5LO37+IcrIvDEejmmiAWy9IbaFk5qvmLG02d4pzzk3vKs5vXw/0jVAlUQDYHVLzYdaY1pEXAGwCZ6pwYep4Y8FkUoKlxL3lAutXrooOo7qmOZH4ofYipjwdVGhPJDnguvcDi7dHfJKraLoQOMTZqjtO7YBQMs53o96kbClV0QfFmOHRsQSB1zIRiEo8spt5cfCCI+dcXHBvRicWJ73QMA1sAi9q4DyeH8V9pp90as+H77+3NwIpxb75dmhAndDev6oC2ueKHAgBWW6QjCXAmQz8pOjpnzPgEODukGmQcBUm7oaau5Io3s+Cj77aj6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2224.namprd15.prod.outlook.com (2603:10b6:805:22::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 19:04:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 19:04:46 +0000
Message-ID: <a1c2eb2b-e5d4-d27b-53e9-ab6b51fdc9bf@fb.com>
Date:   Mon, 11 Jul 2022 12:04:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Warn on non-preallocated case for
 missed trace types
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hao Luo <haoluo@google.com>,
        Shakeel Butt <shakeelb@google.com>, bpf <bpf@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20220709154457.57379-1-laoar.shao@gmail.com>
 <20220709154457.57379-3-laoar.shao@gmail.com>
 <05e5931e-98a7-d7b4-4775-7c17fad57450@fb.com>
 <CALOAHbB__jK-MpzZw6nz8fr5yxM9vtWAsQ0d714BPys7qGqC-Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CALOAHbB__jK-MpzZw6nz8fr5yxM9vtWAsQ0d714BPys7qGqC-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90610834-9949-47c9-a0f9-08da637038d3
X-MS-TrafficTypeDiagnostic: SN6PR15MB2224:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGp09OW/rTG933rnaPC819kjr1V6qrhee8UUbMVuhEzief2Ryjqj2d0lgD+4y47TmptGwXNfC+YNHrDOQhc+KMO03MVMW/HQUm8Ibb92XUoMBL+ppO7+FYqL/yqmBWLBFwt7T7O8KPGPFhINCFDOtjsTw/gVqG0kbmi70RHOzsW9Ogneq09auTLpLHCMA113GQbQCh/84/GzHSaxY9leByWdKDzv6ZknNkiuHU36eeef/0mJNpGsFq0RSUNSihmOBxPw7JJCUJVXsVSmJrf7rN9FOsxtpmbHYQyFF0R5Uiy19DLA728d+Erv9e/bsObt9XbO5zA7FJOYRN9+uBWSeRWiRflv2KzO05s8d/+MgnC6MexiCThPfqiEbYqVFtwZwBargCjwz92Wo/I4l2zN3aHv8JnSl3ckrMkf4uouTsKmSnwAKMCa4gruWY+qk92mw4pD0QP98IR13lVugqLKeejUNwpvOdNSirf4mRg7xZjzmjtO32WMLSXh5S5h1Ot/qJQ5GDt1f0zw9Ktxf3buiLSmWqTxhRVe1maimTaziIj1Yao6Xjwp48j+Y5n0tgpMCpo+rMxIxPeWsMaMADPKevBwrN87QC0BW4Nu+RNcD4kashUP6F65DQsJqn7yfyhEo7HggnsBOVYikLQNxw3D4VLMhme5gIJljv0em9Y4yTbXmchqVfyQcvysDn2vmzx/H4W/xW1nYwwg0RzNnkcauhi5hHbx14CA1YtKtXn0mbUU31HoyLrEHtyqtVdwQPOWhMPloBEHjcWgCgjzWRrjAzWvMt3oqiWXSOmGGK/B+Pv64Pp95qzL8zjPkLTHMnn5OoO0zWz2Q/NW4P+CgcWNFqUBswI3V/kIawEL0tq4zQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(38100700002)(83380400001)(31696002)(186003)(6486002)(36756003)(66946007)(6916009)(66556008)(4326008)(316002)(66476007)(54906003)(8676002)(31686004)(2906002)(53546011)(7416002)(6512007)(2616005)(478600001)(6506007)(41300700001)(8936002)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGFFY2s4c3dja0Z0Z3VGZW5TY3BJYnpGYzhabElDd0d2c3FzRTJseTRCVlpI?=
 =?utf-8?B?U3VUV2MzcDU2bFJ0bk0rTDcyQjdrbVA4VTN1Nm5tWjBuZjFPbFNONVFEdDZT?=
 =?utf-8?B?MnU4UWJ6VXJQSUdlZ3ZYd0ZpOEdxeE1xRmN6a0tnQldNT09Qc0pRUURSRjVi?=
 =?utf-8?B?SlIwWjh3TDRJZVZ6SVgrVXR0RXpWbjBLSUd0UXZML2U3dlN5UnZIb1RERExZ?=
 =?utf-8?B?MVBlRytGRGxGZ1ZzUlhZY1dJT2M3MVpKOXQwZis1U1hGUlFqbzhFZVVxK0JE?=
 =?utf-8?B?Rkp5MjBrWS9DV2NLVU5TZjdub2ZtclpteHVSMlhOV2dld1ArVG1aRFFrTDky?=
 =?utf-8?B?QlNhTnh2dkduenFJOXN1ZlduekJJS3VMU0tLNlFaMDNxMXlmUDMzMnZTWm9R?=
 =?utf-8?B?NnhKMW10NlJYK3pLMFhXaXNUSitFVTgxbkczejRRVTJOVEUvREJ2UG8zTkl1?=
 =?utf-8?B?K3MvRmVqWWlFZ0JpaXpSRjlyVUlSOXJnb0N1MmtnSzVkT1FqMzErTjhsakFB?=
 =?utf-8?B?RUJzR2RpRUhFaGZwV0loQUYzNUNOVHFyNHFxNEdTMWk1ZkRtTzBqUlcrbGJG?=
 =?utf-8?B?NGlNQXpUUEhrdGdLQkhlaHRrUjZJcmpkbVZsV0VEendTdUtVNDBIVGU5S2Z3?=
 =?utf-8?B?YmVMOVBHN04vV0Q5amtZeWhOVlcwam8rVzk4NkU4cU9IdkJvWTNCWGxnRGlM?=
 =?utf-8?B?TThrcnVldnl0blJ4eW95eEg5WVAyMEhjU3czbVl0UUhHVEsvY042MUVWbVVI?=
 =?utf-8?B?TzVjY3ZUY3VnWm1YM0NnLyt1d3N1TTdQcGZMRzZHYktKbGt2d2RYcXZxYnFt?=
 =?utf-8?B?dzgvUTZvbmtzdFMyRXhBWkUvLzlKR3h2cXdXYVBVek9WSjlCRTVucklqUGhD?=
 =?utf-8?B?RW9tQ3JLejdLb1RkUTkwTkE3dnNhaDAzRDBPWHdPdWJta2kxZUNMWExGR3kv?=
 =?utf-8?B?Y2xUVFA3TXNLcVVzeFl2MXR1Zlg5MzNEcFJwWjhrWUJnVlZHMGdaajlWLzZD?=
 =?utf-8?B?VlBGMmdwMy9UKzJUanRwbHRTbldnVVNDZDk0NXFFNlBTVUtUdkhzYjFTdUZq?=
 =?utf-8?B?d25ReEFKR2lxU0Q0bDhUYVFkVUVENFlMeml4anFZc0ptbVVDZ1ZaUWNQMVFK?=
 =?utf-8?B?K2N3YW1BMlJNS0VJV2xGZmlvN1ZFT0FIZ2RmQzBsQU1xTWt4eUV2bDZwWWhm?=
 =?utf-8?B?V082UnJPLytzT2VjS0FxelVHc2d6Q1M2VXJzK1NyL1EycnMvOTQwOHlYejVE?=
 =?utf-8?B?ZXZaNSsrSUFjWUE0SnhIOTlEaVZjRWQ5QVNsMHE5bmlVbkRtVWpwY1U2VVdu?=
 =?utf-8?B?M1d3MGhqcDkwOE9WaSsxVXVoTXZveEppbEFsbk42cCtqUTNqVDNtQThXaGJ0?=
 =?utf-8?B?a3hiUVpHSXVXNlVJUDZkVnpkUDNWakFQbGw5c0taTVJ0VVFqbms5Q05BRS81?=
 =?utf-8?B?dWtJNVY5cEN3MVl1d0t2RENLWDBCekEvL2hCSHFYUnFvVTNJTTQ1WnV3blpG?=
 =?utf-8?B?UmkzWFhjZjJ0aVFVVVRhaGZWaEQvSDY3LzU4Rm1IbExtSXVLU1MrZ01hZmR3?=
 =?utf-8?B?cW5CTTc3VkxoSUxRY21ZdkIxc3FVUVJrbEZoNFUweEZObERwQWxqL2EvR09B?=
 =?utf-8?B?T0FoanJMRzlIeS94UVJieDN4NG9vK0NWUjdyUG0zQ2JNV2NvbGVTK2pRanBU?=
 =?utf-8?B?RHUwcGVISVVDNk5vdVhPUXNRQThjZ21LckxtY20vb0VnMi9jWnFjcU5pS0pR?=
 =?utf-8?B?UzhKcVRTNWk0Um80TEczRjd4OGhOM3NqTkhOdXlBTElUWUNuTzRtNElwdVNZ?=
 =?utf-8?B?MkFCS25VbURjNmo0ZDlUNzZLc0p3bmErSG5MZ29GNjFSaFl5M05wSHc4VnM2?=
 =?utf-8?B?YmwxMkJNd1RqKzI5ZWM5N2ZsR3BrNmNKSG8xVUQ5MlFGblBsWWRMZXFJUHUr?=
 =?utf-8?B?Tm8rVkZsczNtNzFabkg2S0JGdkpDb1pZREh4V01XZWlnb2gyTmI4UjZpa1Zm?=
 =?utf-8?B?b212UkxNR09RMnlYUStid0tUcnFrOFJIb2tsaEdiYWZIUW5DVFR2MUllRXdS?=
 =?utf-8?B?aHhnb3BYRW0yVi9RRnZoOXhycWVxT0xrcTZaMTQwQUt4dEdJQWhQQlhrV1Zz?=
 =?utf-8?B?RnVYejR4Tktsdk5BS2VpeUh2Z2xHdCtSSkkzeWkxa2IxQjBwcDJDOXg2ZUxO?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90610834-9949-47c9-a0f9-08da637038d3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 19:04:46.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCrJKayYJZcSMjmUdc0x6xoLyizGjoo27VA+MFdODpIJ28ZIATmbmC/FG+g0QyzC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2224
X-Proofpoint-ORIG-GUID: OYcJgwzCoSds0p4awLLPYrQykKAvNYPV
X-Proofpoint-GUID: OYcJgwzCoSds0p4awLLPYrQykKAvNYPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_23,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/10/22 11:48 PM, Yafang Shao wrote:
> On Mon, Jul 11, 2022 at 1:51 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 7/9/22 8:44 AM, Yafang Shao wrote:
>>> The raw tracepoint may cause unexpected memory allocation if we set
>>> BPF_F_NO_PREALLOC. So let's warn on it.
>>
>> Please extend raw_tracepoint to other attach types which
>> may cause runtime map allocations.
>>
> 
> Per my understanding, it is safe to allocate memory in a non-process
> context as long as we don't allow blocking it.
> So this issue doesn't matter with whether it causes runtime map
> allocations or not, while it really matters with the tracepoint or
> kprobe.
> Regarding the tracepoint or kprobe, if we don't use non-preallocated
> maps, it may allocate other extra memory besides the map element
> itself.
> I have verified that it is safe to use non-preallocated maps in
> BPF_TRACE_ITER or BPF_TRACE_FENTRY.
> So filtering out BPF_TRACE_RAW_TP only is enough. >
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>> ---
>>>    kernel/bpf/verifier.c | 18 +++++++++++++-----
>>>    1 file changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index e3cf6194c24f..3cd8260827e0 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -12574,14 +12574,20 @@ static int check_map_prealloc(struct bpf_map *map)
>>>                !(map->map_flags & BPF_F_NO_PREALLOC);
>>>    }
>>>
>>> -static bool is_tracing_prog_type(enum bpf_prog_type type)
>>> +static bool is_tracing_prog_type(enum bpf_prog_type prog_type,
>>> +                              enum bpf_attach_type attach_type)
>>>    {
>>> -     switch (type) {
>>> +     switch (prog_type) {
>>>        case BPF_PROG_TYPE_KPROBE:
>>>        case BPF_PROG_TYPE_TRACEPOINT:
>>>        case BPF_PROG_TYPE_PERF_EVENT:
>>>        case BPF_PROG_TYPE_RAW_TRACEPOINT:
>>> +     case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
>>>                return true;
>>> +     case BPF_PROG_TYPE_TRACING:
>>> +             if (attach_type == BPF_TRACE_RAW_TP)
>>> +                     return true;
>>
>> As Alexei mentioned earlier, here we should have
>>                  if (attach_type != BPF_TRACE_ITER)
>>                          return true;
> 
> That will break selftests/bpf/progs/timer.c, because it uses timer in fentry.

Okay. Let us remove BPF_PROG_TYPE_TRACING from this patch for now.
fentry/fexit/fmod may attach any kallsyms functions and many of them
are called in process context and non-preallocated hashmap totally fine.
It is not good to prohibit non-preallocated hashmap for any 
fentry/fexit/fmod bpf programs.

> 
>> For attach types with BPF_PROG_TYPE_TRACING programs,
>> BPF_TRACE_ITER attach type can only appear in process context.
>> All other attach types may appear in non-process context.
>>
> 
> Thanks for the explanation.
> 
>>> +             return false;
>>>        default:
>>>                return false;
>>>        }
>>> @@ -12601,7 +12607,9 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>>>                                        struct bpf_prog *prog)
>>>
>>>    {
>>> +     enum bpf_attach_type attach_type = prog->expected_attach_type;
>>>        enum bpf_prog_type prog_type = resolve_prog_type(prog);
>>> +
>> [...]
> 
> 
> 
