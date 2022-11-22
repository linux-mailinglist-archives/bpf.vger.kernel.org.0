Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDA563345E
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 05:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKVEQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 23:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKVEQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 23:16:38 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601421E3F2
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 20:16:35 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALMdZXb006425;
        Mon, 21 Nov 2022 20:16:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=zACrTNy03HzINsOjeNWiIE6ryjRcEd+kXqAYNZn9OGs=;
 b=hV6Q0O5xR/xF+S6c1iUziSMJQSjEUGrqPLizkMGdLyRsGvvuM46cObMVqoWglD1rUWNF
 n89ys3oeDctpdlduNC7+wARPjr60WBtuW/KpysXdSEgo9psr2qbifTmlOJMQLCiu0R3e
 +B3nLtIPnGFRQBeYFn59nO+3hcfVl2+u4ihG/Lo5xYQkEbDCv3cNXI32HdF3qhAiGZ3X
 VF2yO2rOGjhWe+U0y1pjCQukFafhIDPWIRL21bniZKoryCS2uE2tzA+igBFB+UFH6QHG
 7juDwrt+8Ipg+bFtdzgTI3EI2DHgQ/BpkjxSmsVKRg2kh1guxExI7w4QmcK3A5r3P2Gw /g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m0d21me8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:16:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEc5oeYiWK/JpC4dNSERRl9OCPZDLvLjAcqNAXTc2wfvmN5VejjvKqHn/zboZISa46HiiFBrsBjrL12umSyh/P67jCjtICauGIq7kyikIRFiAITgk1k5EJ3TY2fBZHw5RGSY/orMUCbZtjrj9yQaLpnO7+WFwODBeyq+tst2YrJBeKzQ9iPVdSMBtsgqOw0alIYf4UrjmGtdQbY9N5ZOnkEmuXwqUgEL2NNIn8SHuDnT7BOS+P88d2oskt1EXFqhszKrvyE1fi7uy3un85wNNId9k7hZk8INFVN+q8wdpQfxTA6RCHWA1kuk3FLnFZ1rKCgkfbkilizcgxAMLAI6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zACrTNy03HzINsOjeNWiIE6ryjRcEd+kXqAYNZn9OGs=;
 b=kYvL5CTFrezUTIKZPoyDMy706VUfS0YZ6O1sGnQjH5c3gStIIVVqdNAj8AgwmB1F9P5/on4371TinCHOs1E1oBsDZ/lcP0GE2MNJstoP8aiOFte11X8gmE/j7JGFziVC23q9B2nhztWQeWMgN6NYMQIWJRiFUUnTrobH0eknTEAP7RL9S4ZZ9YVqFvpgPQadJXJpMXRuWCViUk+yu6x2+pJQTgbaQo90PphG4SRAzYkwIw3cCUR3Y6u0CsmqDCYoh5HbyxoSv3hhucbHR9FtcVH7R2QD6P3yEbCGCsZgAfIFYrIMpvStauZtfy2KszWDI+CVK9JEquTH4ISMzROc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2218.namprd15.prod.outlook.com (2603:10b6:5:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Tue, 22 Nov
 2022 04:16:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Tue, 22 Nov 2022
 04:16:16 +0000
Message-ID: <88ffa4fe-948c-d3be-cb54-e3cf34cf3b06@meta.com>
Date:   Mon, 21 Nov 2022 20:16:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v7 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221121170515.1193967-1-yhs@fb.com>
 <20221121170530.1196341-1-yhs@fb.com>
 <ee7248b9-50ae-f4cf-5592-49634913b6ce@linux.dev>
 <7b09c839-ea51-fc8d-99b3-a32c94d175b9@meta.com>
 <1b1d17a5-8178-0cf8-21c3-b60c7f011942@linux.dev>
 <8166d67a-de10-7c6a-c0c5-976fbac37a55@meta.com>
 <637c2dfe3277f_18ed920828@john.notmuch>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <637c2dfe3277f_18ed920828@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2218:EE_
X-MS-Office365-Filtering-Correlation-Id: 02054430-5d26-4838-f8e6-08dacc404c64
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ogcaq/IHSeUGwXTdzsD2gOgRixicJz5uRLnri1u7Ih9z7syOyK5W5nbdu2DWe29UQzANLQIBPAHUIuEiDKmLLX1R5hNdtflWSn6WJzQxtcZZDJeeabheA0cKUIiBM37VibtJ+uGgrRE3kO9YfVgUX5W5e1p4iGGSkJWD6Opf4rquJpKQsLVCfjxhXygX5SnfDKmT8Ls+Z0zlVJgf40D2E4fjkczLDUM+XX3EYg49pfZMHqsbDNcR/qlP+rRws173yuLiMrsyVulbkgqlAWTZMiZENlFLJZcsLEYJPAHIYTeyqvyFNtKBck5TgdyD32gmIskgtN7lFVEag9kE7RWNldEWNSdxY0j1WWnP72JVQSTOlkqAIoIyinX5kBVAJWjVcRcl3kCNLze4jNvS2AVbYiBijGQa2810nB0y/SkqyZiCiOJbKgckm07LRGqyGAbQK4w0V+17iZI+HyepnZY8bKPfE28oYjLyi5YC3eR2aZYRnrKV2tkLMzL8ie1nwl6B3Wyz87eEUJpDbmXT5sJJL/NTkj8G4LjyavmuQbPoeodwbDM0C6ZUVo8B+Joov59P9EZ9H6fl62tTt3hQkD94dSZ81OgzWRHYABmAM6fyem6e9ChpLCg4qOGEhMf6bBouvsOsupK1U/48Nu6ambjF664ScGi7YkI4owf/L8ZJTzI3DIAdA6Hp/qI2d4nQqYWrkqLi0OgTQR1i9VcCOnRrR1D6Vryd9TK4RB5yeVQrtCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(41300700001)(8936002)(316002)(66899015)(54906003)(4326008)(5660300002)(66556008)(31686004)(66476007)(66946007)(8676002)(6666004)(36756003)(6486002)(6512007)(478600001)(53546011)(2906002)(186003)(2616005)(110136005)(6506007)(31696002)(38100700002)(86362001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3BFODdUbUFycmtqOXRpc3NPWFcxQlVPSXZLM3QvLzZ2MkZJeTU5aGJCaXBL?=
 =?utf-8?B?WkorK1plR0t3VGJ0YmFHOEczekhKa0ZFK1M5RW5vVVFaeWRQK1BlN1YzdzVi?=
 =?utf-8?B?QVp4ZkNVRDJHYWtLWlRycjhYcDU2V2JJandhZzhzR3EwZld5SFA3OURldStQ?=
 =?utf-8?B?NEJ5d3hKNGNRK3Z1a1BheWt3NWlmeGNqU1pYc3dWMjdJRHE4THpxWnQrNWls?=
 =?utf-8?B?VWFiRU8wdjZWTkVubkZUYzkyMW9vYm5pMEl3MUFOeWtJVFRaRFRuWUQ3ZjQ2?=
 =?utf-8?B?UXNjdng1ZlFWWjN1bXVjSU85cUpLblZwVnIvSllkZnlncEtndVg3THNXcTNa?=
 =?utf-8?B?MHhhZWVkK0RYVjQ2U1h6R1A1LzhKZjNna1UvYmtKMlBhQjN4Q3pyOVZacTU3?=
 =?utf-8?B?aUlEYitOKzZySWxpa2dSUVcwNkEvaTRqaUw5T2JNSFFmcW1kblZuZFEya2Iw?=
 =?utf-8?B?WWZNYTlmbmp0SThQMldoM1VJY2JROXFobEY5cHpyWXIzQTdYYkdmQnYrZS9J?=
 =?utf-8?B?T0g4Z2Y3WmtIUGQ5M3luVEhnZGFhUmw2RndNKytmemZkZlVFRlNYN1g0SFN1?=
 =?utf-8?B?T0hsL3lhclcweVNKTFovSXpZUCtGVHgrRDlxR3c3YURUVDNjZE9DQU9oU1hi?=
 =?utf-8?B?dzlJYXM0QmtTOXJCQmMrZ3EvTThScHBnUnFJMkxBdFVvbUNjZ3BwSWNndW9J?=
 =?utf-8?B?cHlVYlU0cWdxTW1Ja3R0bXRjUFI4K3lYYXN0cTYxTndCaU5Na25xNFpPczNq?=
 =?utf-8?B?S1BNZXNISzAvc2ZNQklYM1E1eXFRSUZpSDF5OWNwZEFiV2Y1VHJLd0llazN0?=
 =?utf-8?B?bHVZekwwYzdCQ1pTTko5V3J3ME9jRWtLSWM5b055NnpWLzBZb1hyU0xhRUZY?=
 =?utf-8?B?V0VTenVaK3hwUVZtNituWHVGWDAxdGNLanBseVZXVHpRbndVUnhGZE9VVCt3?=
 =?utf-8?B?KzJ3M3NCNlhvcXdrSE5McTl2RG56MFloYnZCa3FodE1YcWlqUHo1cjFTT3JW?=
 =?utf-8?B?TE9PWkRFVWUrUlo0WTNaN2xHTFIxcnVtNUxyOTdVVVRUWU1UZ3dtcFU0UW9x?=
 =?utf-8?B?b1pKR1F5bTVidmZTcGNVNkxwdFBFSnFPdTc1d3hzcVpyVGpjUHE4aEtob3hk?=
 =?utf-8?B?cW9QQzZ5Z3BUVFJIODlwVlNQZ3pOaURBZEVpVWt2NXVxdVBlTHBWTVBQaFRs?=
 =?utf-8?B?VmlXT1F5M2xkMjczT3JzNit1R0x0enNIcDZXSVljellqRThhcG5wMDIzWEl5?=
 =?utf-8?B?Zldlb0ZoamtxeTF0Sjlic3JhaWRHTzA5aEJ3U2t5TUFYLzZyamVlcFAvdlU4?=
 =?utf-8?B?TUsvUldHYUgwWU85a0MvdWF3RzgzVHVib25iVSt6Q3BMY1pxYXJwSUlna2Zw?=
 =?utf-8?B?dUV0cTdlSktQMXdwQXR4RVdmOWJZS2tUQWRVWmpSWUYzcVRNNThYbHJtb0lQ?=
 =?utf-8?B?N0pOcFNzQThJRnlZeUcvZVBmRXVWT1VFUy84bEcvUzlEK0NpSnorUk15eU9B?=
 =?utf-8?B?UkJLLzF6enRvVHBjUE1yLytLUUtFUGxvSnA1NEZveDVCMEJuMlJyVWNBb29a?=
 =?utf-8?B?NUtXVE1xRTc5aHhJdklkM1Y0NlVYem9ZVjNTbmhhc2RudFNxZldrL0NJSmdI?=
 =?utf-8?B?LzZBcFZ6TU9pbDVyZ1RPRGFmRE9wR1dGcmEvSDN5ajBOVTVtQ2REZEREc0ZI?=
 =?utf-8?B?M3dCOEFFYmNiWURJcnpLQTBEQXNTNXdoTVVUekswWG9RWGtRNnIvVWRSd3hQ?=
 =?utf-8?B?cHFUbmVZQnZrbi9obStaaVYzeEtzVzUxTUZoU2swM1dCekh6RVNBVmN6Vmwz?=
 =?utf-8?B?NVEyMGVhcTVUVWJyVi9vWjRFYzB1bEI4Q2lZT3FoampqSlR4Y2MwaHhqT1hj?=
 =?utf-8?B?dHhzVnNyT21IQXdrMVhQb25obytDUzZjbzgrSzRKL01HT3g5dWdIeThhdmo5?=
 =?utf-8?B?bUtVY3BmRTFUQWRNdDZHb2NPVVVoQU00SXFqcHgycFR3ekhMTDRpanl1a0pJ?=
 =?utf-8?B?dlIwSVdYcFhqWkdCLy83RW0wZCtwdWtiSWw0MVpjYTJha1paV0lsbS95aHFE?=
 =?utf-8?B?Zm1udzVINGZyMkNXS0svSDVqbElBaS9IMjlDQ3dyWXdIUHZKc0FBTlY2K1Rw?=
 =?utf-8?B?L3o1SmxTK3ZpTy9UcjkzQ0RrUWc4Y3o4Vmd6QnVFNEtpcXdoWW9PSmVtU1k4?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02054430-5d26-4838-f8e6-08dacc404c64
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 04:16:15.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwDXhiGU1L9n7Rho0p4jWqEDtUZHb+MVhEYtu7ZqqVK4z89Y96JHL2E8SHO6g5Mx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2218
X-Proofpoint-GUID: XVAot6_ANePRFmA5MfoEAWjSzjTYLvAc
X-Proofpoint-ORIG-GUID: XVAot6_ANePRFmA5MfoEAWjSzjTYLvAc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_01,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/21/22 6:03 PM, John Fastabend wrote:
> Yonghong Song wrote:
>>
>>
>> On 11/21/22 2:56 PM, Martin KaFai Lau wrote:
>>> On 11/21/22 12:01 PM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 11/21/22 11:41 AM, Martin KaFai Lau wrote:
>>>>> On 11/21/22 9:05 AM, Yonghong Song wrote:
>>>>>> @@ -4704,6 +4715,15 @@ static int check_ptr_to_btf_access(struct
>>>>>> bpf_verifier_env *env,
>>>>>>            return -EACCES;
>>>>>>        }
>>>>>> +    /* Access rcu protected memory */
>>>>>> +    if ((reg->type & MEM_RCU) && env->prog->aux->sleepable &&
>>>>>> +        !env->cur_state->active_rcu_lock) {
>>>>>> +        verbose(env,
>>>>>> +            "R%d is ptr_%s access rcu-protected memory with off=%d,
>>>>>> not rcu protected\n",
>>>>>> +            regno, tname, off);
>>>>>> +        return -EACCES;
>>>>>> +    }
>>>>>> +
>>>>>>        if (env->ops->btf_struct_access && !type_is_alloc(reg->type)) {
>>>>>>            if (!btf_is_kernel(reg->btf)) {
>>>>>>                verbose(env, "verifier internal error: reg->btf must
>>>>>> be kernel btf\n");
>>>>>> @@ -4731,12 +4751,27 @@ static int check_ptr_to_btf_access(struct
>>>>>> bpf_verifier_env *env,
>>>>>>        if (ret < 0)
>>>>>>            return ret;
>>>>>> +    /* The value is a rcu pointer. The load needs to be in a rcu
>>>>>> lock region,
>>>>>> +     * similar to rcu_dereference().
>>>>>> +     */
>>>>>> +    if ((flag & MEM_RCU) && env->prog->aux->sleepable &&
>>>>>> !env->cur_state->active_rcu_lock) {
>>>>>> +        verbose(env,
>>>>>> +            "R%d is rcu dereference ptr_%s with off=%d, not in
>>>>>> rcu_read_lock region\n",
>>>>>> +            regno, tname, off);
>>>>>> +        return -EACCES;
>>>>>> +    }
>>>>>
>>>>> Would this make the existing rdonly use case fail?
>>>>>
>>>>> SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
>>>>> int task_real_parent(void *ctx)
>>>>> {
>>>>>       struct task_struct *task, *real_parent;
>>>>>
>>>>>       task = bpf_get_current_task_btf();
>>>>>           real_parent = task->real_parent;
>>>>>           bpf_printk("pid %u\n", real_parent->pid);
>>>>>           return 0;
>>>>> }
>>>>
>>>> Right, it will fail. To fix the issue, user can do
>>>>      bpf_rcu_read_lock();
>>>>      real_parent = task->real_parent;
>>>>      bpf_printk("pid %u\n", real_parent->pid);
>>>>      bpf_rcu_read_unlock();
>>>>
>>>> But this raised a good question. How do we deal with
>>>> legacy sleepable programs with newly-added rcu tagging
>>>> capabilities.
>>>>
>>>> My current option is to error out if rcu usage is not right.
>>>> But this might break existing sleepable programs.
>>>>
>>>> Another option intends to not break existing, like above,
>>>> codes. In this case, MEM_RCU will not tagged if it is
>>>> not inside bpf_rcu_read_lock() region.
>>>
>>> hmm.... it is to make MEM_RCU to mean a reg is protected by the current
>>> active_rcu_lock or not?
>>
>> Yes, for example, in 'real_parent = task->real_parent' where
>> 'real_parent' in task_struct is tagged with __rcu in the struct
>> definition. So the 'real_parent' variable in the above assignment
>> will be tagged with MEM_RCU.
>>
>>>
>>>> In this case, the above non-rcu-protected code should work. And the
>>>> following should work as well although it is a little
>>>> bit awkward.
>>>>      real_parent = task->real_parent; // real_parent not tagged with rcu
>>>>      bpf_rcu_read_lock();
>>>>      bpf_printk("pid %u\n", real_parent->pid);
>>>>      bpf_rcu_read_unlock();
>>>
>>> I think it should be fine.  bpf_rcu_read_lock() just not useful in this
>>> example but nothing break or crash.  Also, after bpf_rcu_read_unlock(),
>>> real_parent will continue to be readable because the MEM_RCU is not set?
>>
>> That is correct. the variable real_parent is not tagged with MEM_RCU
>> and it will stay that way for the rest of its life cycle.
>>
>> With new PTR_TRUSTED mechanism, real_parent will be marked as normal
>> PTR_TO_BTF_ID and it is not marked as PTR_UNTRUSTED for backward
>> compatibility. So in the above code, real_parent->pid is just a normal
>> load (not related to rcu/trusted/untrusted). People may think it
>> is okay, but actually it does not okay. Verifier could add more state
>> to issue proper warnings, but I am not sure whether it is worthwhile
>> or not. As you mentioned, nothing breaks. It is just the current
>> existing way. So we should be able to live with this.
>>
>>>
>>> On top of the active_rcu_lock, should MEM_RCU be set only when it is
>>> dereferenced from a PTR_TRUSTED ptr (or with ref_obj_id != 0)?
>>
>> I didn't consider PTR_TRUSTED because it is just introduced yesterday...
>>
>> My current implementation inherits the old ptr_to_btf_id way where by
>> default any ptr_to_btf_id is trusted. But since we have PTR_TRUSTED
>> we should be able to use it for a stronger guarantee.
>>
>>> I am thinking about the following more common case:
>>>
>>>       /* bpf_get_current_task_btf() may need to be changed
>>>        * to set PTR_TRUSTED at the retval?
>>>        */
>>>       /* task: PTR_TO_BTF_ID | PTR_TRUSTED */
>>>       task = bpf_get_current_task_btf();
>>>
>>>       bpf_rcu_read_lock();
>>>
>>>       /* real_parent: PTR_TO_BTF_ID | PTR_TRUSTED | MEM_RCU */
>>>       real_parent = task->real_parent;
>>>
>>>           /* bpf_task_acquire() needs to change to use
>>> refcount_inc_not_zero */
>>>       real_parent = bpf_task_acquire(real_parent);
>>>
>>>       bpf_rcu_read_unlock();
>>>
>>>       /* real_parent is accessible here (after checking NULL) and
>>>        * can be passed to kfunc
>>>        */
>>>
>>
>> Yes, the above is a typical use case. Or alternatively after
>>       real_parent = task->real_parent;
>>       /* use real_parent inside the bpf_rcu_read_lock() region */
>>
>> I will try to utilize PTR_TRUSTED concept in the next revision.
> 
> Also perhaps interesting is when task is read out of a map
> with reference already pinned. I think you should clear
> the MEM_RCU tag on all referenced objects?

The register tagged with MEM_RCU will not be a referenced obj.
MEM_RCU tag only appears to a register inside the rcu read lock
region as the rcu_reference() result. So the obj tagged with
MEM_RCU is protected with rcu read lock and it is valid and
trusted and there is no need to acquire additional reference.
If user calls another kfunc to acquire a reference, then
the resulted ptr will not have MEM_RCU tag but with non-zero
ref_obj_id.

The MEM_RCU reg will be invalidated when seeing bpf_rcu_read_unlock()
to prevent rcu-protected ptr to leak out of the rcu read lock region.
