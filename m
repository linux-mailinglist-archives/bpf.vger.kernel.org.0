Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616A73FCF36
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 23:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhHaVie (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 17:38:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17868 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232580AbhHaVid (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 17:38:33 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VLYNLM026579;
        Tue, 31 Aug 2021 14:37:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rFf+hgEpy3nTTbdacXhY4Vry/60r4h9/fIbs1ekCPpc=;
 b=VMdTKmkHxv5DOn/fAvPT7efTJADlltl0O7XXjiQ9J3XzsDcVKu7YWKg/OvH8Z1AerBVu
 7qV8I/tctyR/2GEBPPpSPT6+Ne4Zpf4+UJh9U81wiBwtMdnyqsnUX9UgzOkhuvfrrf9J
 t7VwUNyUfsCFfkyyg8c4Bj2Wj+z9+71zgDU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aryp9cndc-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 31 Aug 2021 14:37:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 31 Aug 2021 14:37:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdtbPLhvWnxuo8IK5UhPccDFYS5uEiy2kMbyAxjGkrU6o+MqNFFz9gGSRAN8TjnQLvYMx/RKlleGrARvptLuUBXoHI8DaPMZLGp1FQbdKv4o1bUuCQ6ANhd9a2+qdmCFo+jwWXCqMzXoMwE2fhmzAZVbsx0ntzjQUhG29bsHCBxWwEE/mQEQk3rRwcwKK/vm0Vkvr0L5L54w6zxz1X1CovOc5y3NXJr88JydF4LvNPxW+iySD9TFdJ08yQw1TMc+oE+Ak6pPKYvtqmh5yY0+VAu0P79ItPZpFCzr4HQXKxAvbvuU5CCe4HXn1cuBkE/Ww4CG2t8aL4XnlhjbbJ2d4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFf+hgEpy3nTTbdacXhY4Vry/60r4h9/fIbs1ekCPpc=;
 b=TMb8fkbukSbNF2CcLStxZPBI1HWiQEHUGJ8gwRQKxWP502+ksyJlRn5QtQfLaYx7p/cAnm0kwDPhsoBtVb7KqE9//xmu9CU4PEFx1tRMCJ4fWrzGCVyyWZ0qSTKT36PE1bZGZM7Z7ioaU3eXKoYwZXdS/4b8jO3t5MESg/BxODbczMLXtGUQjT4g8aOPAI1ILUJ9sJLTmwdm64UVVyzcuxX7veDTezXyWn/y6cioANbXjArwfGi7HZSyhOWXlgTkS1cfjJesOFgLOsXDXcpAueCDmCPthd4FFOupE15PXdCkxNUCtSY6uk1JVjGFK9D1zBBOhG5KzpK9oa5yp0VtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by MWHPR15MB1662.namprd15.prod.outlook.com (2603:10b6:300:125::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 21:37:22 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::7d63:ef35:f43e:d7c2]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::7d63:ef35:f43e:d7c2%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 21:37:22 +0000
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
To:     Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kajoljain <kjain@linux.ibm.com>, Kernel Team <Kernel-team@fb.com>
References: <20210830214106.4142056-1-songliubraving@fb.com>
 <20210830214106.4142056-3-songliubraving@fb.com>
 <YS5LexDSokkcOJ7O@hirez.programming.kicks-ass.net>
 <26B5B18A-EC0B-4661-BE6F-E5D96DCDE0B9@fb.com>
 <F7738B87-1CD3-40F8-9278-DC69E9AB0395@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <651cce25-e354-1486-c6b6-7cca4a37e3b7@fb.com>
Date:   Tue, 31 Aug 2021 14:37:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <F7738B87-1CD3-40F8-9278-DC69E9AB0395@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::30) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c083:1409:1c24:fc44:3840:7252] (2620:10d:c090:500::5:618a) by SJ0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:a03:33e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Tue, 31 Aug 2021 21:37:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c48f182-1df4-4158-7a9a-08d96cc7841e
X-MS-TrafficTypeDiagnostic: MWHPR15MB1662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB16624B11714CB13DB801BB58D7CC9@MWHPR15MB1662.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+ETgwpuom5l6NQKqvizIuzsmNvtIoNn0IR1E3U4CLHCqsz17Kn01cH7fk7cCmqA+p1ULOuAqk3u85xgzO+HCnWg/4C5mFML0DnmTHODASoZDIz4KZh8hqSSZT4Gwq1dl0pR9e5De04GD5UPlLAuBy9YF2huYUajpswBapbMBMaPOhLbcI8fu9pUMlGJIn+l3UrRTtw0UxF64SIBwYCZBrNEpst9b4G5+b+PHHUHcO0XnZb1tALLIYCiejtqYidWg3q1MTskl/b45EKeGpNThTyPz+LMhHGR7KZZvH4HOkOGF4iarY8FivoY6Sd9cRJzarSDEFXEk6cbfi5QQV6s7k2xcY5wVwNvshfFWMMrhjyh7wMjDK5LUUiShe3sXKcKTu39PUOJoNW4QrdtzRxKUJRQ/8yH85xHV2IP1Fux0YDtT0YYKgN+jfqdRcHeENEjUFbONb/5SR4IfWCLfaQsMCR+0Z2EbsnpH+zCFchGmDEvd3CC/QhmHQh8vekwM7RlfS3BVcrGrC7FVkv5JfyZVzjTJcLlwSWIEnirc9rjuuuBLmExhAss/zM5bSZrnINS96lfC/Xc5uV3ilhu7nn5BnKs6fcbJ6O2INMTy1/sHmhv+RmLRDr5TnXn6qA8MkieZt212e2aRKCqt0C7wq/psqkuMw3LFeotn0Jxw87EfK2rCT4s9KNP2djoihZrrJSW/CZVCbdHnQ2aeqlm0sBvnwLTsqeq3EMU5m1RP9874FQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(110136005)(52116002)(4326008)(478600001)(53546011)(2616005)(83380400001)(66556008)(5660300002)(31696002)(66476007)(8676002)(54906003)(316002)(186003)(36756003)(38100700002)(2906002)(86362001)(66946007)(31686004)(6486002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRQb2grRm1IVURYcExLSUFMSmJpdEVMTlFYTXlZMzIyTVRQM2I2Sy9lS3Jo?=
 =?utf-8?B?cy9RSzFxYm5pV3Ywa2sxMEl6MDhhRXBSdlc2U2c2Nmd1djFtMEZoNTZ2OTNl?=
 =?utf-8?B?d3h1Y3Y4RHB1djlEdkVtQ0JLc1JFSndMcUxqM2VqK0ZGQldGM1VCd2xKdmlG?=
 =?utf-8?B?VDBnbzZqZTcvU0Nva3pmb3VCb0NOa0hOVUF1M2NFaDN1cUhCTlkxVHpkd0Zx?=
 =?utf-8?B?VnhHUjNVRXFMUmlCVlY2TkF3K0szOWFhQXhwazVRYnNEbE03aEJpdEp6eVpT?=
 =?utf-8?B?SW5OWWFUL0JQMC9yZ2dZeCs1NzZpUnNiSHB3Zzk0K29nencwcU9Ham1SOVF4?=
 =?utf-8?B?OFppbGFuV1RKTFJndTlxbzl2Nk52RkpqOTRPZGhTMjA3TmJWMHlYWGdGaTh0?=
 =?utf-8?B?YlBUL2laWWxxekhIQWg3Y2NxeUxpeE1yTHAzYzhIc2FuaUpWOEhMbnZjcXJv?=
 =?utf-8?B?Q3NRVmxVN3pHblhxWHJpdVRJVUpKclJNaUk5am5FZjRYTHJKYmtCMTFiVHNE?=
 =?utf-8?B?dWlPUE9zUDhpcVhaS3M5UHB0V01iNko5Rk1MRHpSYW80ZVhFdnFjV21qK240?=
 =?utf-8?B?U29VblFmK241NUE2bHg5Uk1rc2pPRFgxU1NObE5PeTU2bzZxRitXV0srQVhE?=
 =?utf-8?B?T2Fkc1R6QlFaMGZST2dhaWI0RjhBb3cwaHNoRURuR21oK3hZa011d0Y1NEIx?=
 =?utf-8?B?ZXBFSTZhUFNCWjJFUzdHbWY2aTNROHZjRkRXMUpGdTZkZnBpWTMzc1NNWFRK?=
 =?utf-8?B?eTZFVUdMVC8vVGk0TXBqa1JIKzUyQTBjTW5ZUk4rTDZaR2RYZFdhSUlqa0FZ?=
 =?utf-8?B?ajZxRVUzV3AvUFV2UHE0R3hvajZ0Ryt5UzFzcW9BekRZaGlTaW96SDQyUklh?=
 =?utf-8?B?ZW84U2cwYjY1NFREeHZuN1VMeEtGN3MrOUM2N0pwYm50S3ZkQ3Rnd3JzcDRQ?=
 =?utf-8?B?bXNobVpGQ1puMFFlWHVicHppTVA0Ty9xWnErWU0yMitXam9mMG9MS3NEWm81?=
 =?utf-8?B?eDFWQnA3czJHMnU0TnU1N2k0aGhBZXg1cnBkaURXbjdRY1NEa0Y1K0VZZU4r?=
 =?utf-8?B?MGxrS1FKT3A5ZCtEb3ZCYlJPMXR5OVgwVXFySExOUXJ6UHJsSW9oS2YxbW1s?=
 =?utf-8?B?SzRuSUlGMUxlNk9scjZQR2NJT0ExTm5ab3ZHOVFaSXk4TXF3c3JWYjdHcCtL?=
 =?utf-8?B?ZXZuc3JnVjU5UEhpZ3JoMGhkRXQvUjlIblhSaS95T1lsemIzVXB4SWs5RHN0?=
 =?utf-8?B?V2pXVjd2eUNSUUVadWY3d2tpeEdtcmNMN2FzRkttNmd3M1lXWXFNL3pzVmpo?=
 =?utf-8?B?djF0WEhJNWc2cjVud1QrMHYwUThqV2pOcFNWOG1CMjFEd2tVQVkvUVFWc2RM?=
 =?utf-8?B?cDludHJuMGdKU3hvakNJYlgzNHg1Y0dNeXB1UHVQVXE1WUtITUhkeE9PVXZl?=
 =?utf-8?B?bHNuMDhXamJSME1IUUloRmFGZ3lKVmg5eTRkODBLZTFLTS84djd4dVRrd3Zv?=
 =?utf-8?B?TVBEWG04VW1rdGFiYnhxVERjelZ0MEp0RzdBSldnRUx1aGZPb3VBc3hleXVY?=
 =?utf-8?B?T1o2RzdFQW13L0QxR1FkVzdjK0ZSV3N2ZHNRYnVrcnZsZHJIbHAyYnZ0OXlV?=
 =?utf-8?B?YWdINHYrQ3BVaG1WNUtlRUt2NldPOFFIeVhza2VwYkZCelhKaXFBRFJMOGZ6?=
 =?utf-8?B?eTB0U1F6M0VrcEtjQmszNkRzUVhKMloza1BuWEJialFXRWxKNVd4ZVNaYk1H?=
 =?utf-8?B?dUhTc3dZODdDMmFBaXJQYlArVmdWbC9uSkdsUkpvbjQzNFZKQUNFMlJkcVh3?=
 =?utf-8?B?d21TbDhJWTJ1akk4azdSdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c48f182-1df4-4158-7a9a-08d96cc7841e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 21:37:22.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8o6SB9lsPPLRE1R9MM9ckYnCLXn/CMis7h3OFVi7vjZ6/aP66Ub+x+3UQsrjO4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1662
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: zHxFsFseOm-KUEps-sFAIO3OgItw13pE
X-Proofpoint-ORIG-GUID: zHxFsFseOm-KUEps-sFAIO3OgItw13pE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_09:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/31/21 2:24 PM, Song Liu wrote:
> 
> 
>> On Aug 31, 2021, at 9:41 AM, Song Liu <songliubraving@fb.com> wrote:
>>
>>
>>
>>> On Aug 31, 2021, at 8:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Mon, Aug 30, 2021 at 02:41:05PM -0700, Song Liu wrote:
>>>
>>>> @@ -564,6 +565,18 @@ static void notrace inc_misses_counter(struct bpf_prog *prog)
>>>> u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
>>>> 	__acquires(RCU)
>>>> {
>>> 	preempt_disable_notrace();
>>>
>>>> +#ifdef CONFIG_PERF_EVENTS
>>>> +	/* Calling migrate_disable costs two entries in the LBR. To save
>>>> +	 * some entries, we call perf_snapshot_branch_stack before
>>>> +	 * migrate_disable to save some entries. This is OK because we
>>>> +	 * care about the branch trace before entering the BPF program.
>>>> +	 * If migrate happens exactly here, there isn't much we can do to
>>>> +	 * preserve the data.
>>>> +	 */
>>>> +	if (prog->call_get_branch)
>>>> +		static_call(perf_snapshot_branch_stack)(
>>>> +			this_cpu_ptr(&bpf_perf_branch_snapshot));
>>>
>>> Here the comment is accurate, but if you recall the calling context
>>> requirements of perf_snapshot_branch_stack from the last patch, you'll
>>> see it requires you have at the very least preemption disabled, which
>>> you just violated.
>>
>>>
>>> I think you'll find that (on x86 at least) the suggested
>>> preempt_disable_notrace() incurs no additional branches.
>>>
>>> Still, there is the next point to consider...
>>>
>>>> +#endif
>>>> 	rcu_read_lock();
>>>> 	migrate_disable();
>>>
>>> 	preempt_enable_notrace();
>>
>> Do we want preempt_enable_notrace() after migrate_disable()? It feels a
>> little weird to me.
>>
>>>
>>>> 	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
>>>
>>>> @@ -1863,9 +1892,23 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
>>>> 	preempt_enable();
>>>> }
>>>>
>>>> +DEFINE_PER_CPU(struct perf_branch_snapshot, bpf_perf_branch_snapshot);
>>>> +
>>>> static __always_inline
>>>> void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
>>>> {
>>>> +#ifdef CONFIG_PERF_EVENTS
>>>> +	/* Calling migrate_disable costs two entries in the LBR. To save
>>>> +	 * some entries, we call perf_snapshot_branch_stack before
>>>> +	 * migrate_disable to save some entries. This is OK because we
>>>> +	 * care about the branch trace before entering the BPF program.
>>>> +	 * If migrate happens exactly here, there isn't much we can do to
>>>> +	 * preserve the data.
>>>> +	 */
>>>> +	if (prog->call_get_branch)
>>>> +		static_call(perf_snapshot_branch_stack)(
>>>> +			this_cpu_ptr(&bpf_perf_branch_snapshot));
>>>> +#endif
>>>> 	cant_sleep();
>>>
>>> In the face of ^^^^^^ the comment makes no sense. Still, what are the
>>> nesting rules for __bpf_trace_run() and __bpf_prog_enter() ? I'm
>>> thinking the trace one can nest inside an occurence of prog, at which
>>> point you have pieces.
>>
>> I think broken LBR records is something we cannot really avoid in case
>> of nesting. OTOH, these should be rare cases and will not hurt the results
>> in most the use cases.
>>
>> I should probably tighten the rules in verifier to only apply it for
>> __bpf_prog_enter (where we have the primary use case). We can enable it
>> for other program types when there are other use cases.
> 
> Update about some offline discussion with Alexei and Andrii. We are planning
> to move static_call(perf_snapshot_branch_stack) to inside the helper
> bpf_get_branch_snapshot. This change has a few benefit:
> 
> 1. No need for extra check (prog->call_get_branch) before every program (even
>     when the program doesn't use the helper).
> 
> 2. No need to duplicate code of different BPF program hook.
> 3. BPF program always run with migrate_disable(), so it is not necessary to
>     run add extra preempt_disable_notrace.
> 
> It does flushes a few more LBR entries. But the result seems ok:
> 
> ID: 0 from intel_pmu_lbr_disable_all+58 to intel_pmu_lbr_disable_all+93
> ID: 1 from intel_pmu_lbr_disable_all+54 to intel_pmu_lbr_disable_all+58
> ID: 2 from intel_pmu_snapshot_branch_stack+88 to intel_pmu_lbr_disable_all+0
> ID: 3 from bpf_get_branch_snapshot+28 to intel_pmu_snapshot_branch_stack+0
> ID: 4 from <bpf_tramepoline> to bpf_get_branch_snapshot+0
> ID: 5 from <bpf_tramepoline> to <bpf_tramepoline>
> ID: 6 from __bpf_prog_enter+34 to <bpf_tramepoline>
> ID: 7 from migrate_disable+60 to __bpf_prog_enter+9
> ID: 8 from __bpf_prog_enter+4 to migrate_disable+0

If we make migrate_disable 'static inline' it will save these 2 entries.
It's probably worth doing regardless, since it will be immediate
performance benefit for all bpf programs.

> ID: 9 from __bpf_prog_enter+4 to __bpf_prog_enter+0
> ID: 10 from bpf_fexit_loop_test1+22 to __bpf_prog_enter+0
> ID: 11 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
> ID: 12 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
> ID: 13 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
> ID: 14 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
> ID: 15 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
> 
> We can save more by inlining intel_pmu_lbr_disable_all(). But it is probably
> not necessary at the moment.
> 
> Thanks,
> Song
> 
> 
> 

