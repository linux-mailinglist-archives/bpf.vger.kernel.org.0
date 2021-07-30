Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACCA3DB2FA
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 07:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhG3Fxu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 01:53:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229948AbhG3Fxt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 01:53:49 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U5qvRG022040;
        Thu, 29 Jul 2021 22:53:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4EJZ3jccGAjv1niOuxodDFCJoojwKEL5Bq83Gjq+JLA=;
 b=dpYkGlQ8/5ipl/46pgIDeSjWUxEX0NWnnIotjnbBoXrAX0/A10U6jlk8OmUsuGOtKXXv
 KtjExF11JS7C6C3J/ejZrNlsY8OvS2r9+nS3s7RdPekO3r0uYCnwUjM6o9X6ACyX5b76
 i9oyeON9ueecaj3K/OCoYCComjiW+LHWBFo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3cde36b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 22:53:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 22:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7Gxs9apZ5zlB0nmalQ1/fg0d6nGRUh0QooyuoUf3EFnzP5zjBK/xk7afiCkpTziKlU/SOPAIR8xJoaY4bR9PPqoKg0WvMNrHRzXFX+Zm39hJiDuxCDwQ5wnxv8HLdz/NTh79vPsrbcznkDuDbk7O2KSRhIVttOiuUzfpdVR9wn8UR/Un00K/4sGL9CiD3fQ0vZ6+Tefjb+v52sJ2Xil+XEnKoeXfh25339LhHMeW27ypo2s5tGGR9a84omrVgzsy5jF9h4KuubM9P334V02kOKftvNjWWyFGGqSViAMNFAZh6tRh7KHqL42jlVLQjVymHMJ0dE6N2ZT9PuAoWnNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EJZ3jccGAjv1niOuxodDFCJoojwKEL5Bq83Gjq+JLA=;
 b=h2gCARp6Ou1myhKN1jcNKDwdOnPQZ4USOmscNcCMlLCf+S6DJ6tnWVbKvZn/NHtUD1g1wa1bW5NdIR/cfv0j+7h3mkDprxYFsC3n9JN9oeEtnbSf4+oc78PZ6uUr4m4+v2fIVM0QJkWavJA6cqBrWqKdiHtWoDRd6dWXK/ndlEztwJvOmrWjyg847lZ5GCarhww0dT/3Og0EiPmUwLDxzPLdu5exwPhZiOllgJ82wdE5Fi4Qjexa6+p95ZC1tu8111vEZqu/39NA26i6fZQaNQjCeDEKl741tgPqGcCFWBzAl61VNaRd2pgQmJCI7sQSFRGETqv6XvPrbumhUwnv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5030.namprd15.prod.outlook.com (2603:10b6:806:1d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 05:53:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 05:53:27 +0000
Subject: Re: [PATCH v2 bpf-next 06/14] bpf: add bpf_get_user_ctx() BPF helper
 to access user_ctx value
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-7-andrii@kernel.org>
 <ca7119de-3bb5-7a68-4005-4485ec151bb9@fb.com>
 <CAEf4BzY2fVJN5CEdWDDNkWQ9En4N6Rynnnzj7hTnWG65BqdusQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <6d044e53-7d39-84c1-74b7-8664084c4735@fb.com>
Date:   Thu, 29 Jul 2021 22:53:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <CAEf4BzY2fVJN5CEdWDDNkWQ9En4N6Rynnnzj7hTnWG65BqdusQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0035.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::48) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1130] (2620:10d:c090:400::5:1fa2) by BYAPR07CA0035.namprd07.prod.outlook.com (2603:10b6:a02:bc::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 05:53:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 678d5f35-f7ed-42bc-2789-08d9531e59a7
X-MS-TrafficTypeDiagnostic: SA1PR15MB5030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB50305E6D9DC10060F35716A9D3EC9@SA1PR15MB5030.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pk97Ro/dMLFxGUocZI6DZHUeBSBEyZHLBOyewgtU5e4hlhM43PgLhKrnGLdIl6hsl2ZBBtfSrqPbfFL+AY68f5IfXbNsIZ2kE4mRKwFTPfs9D1CLbZY3iXV6pcVRCRMZYerRWVy7m5IcID//H3LI9hB9k7udp7djs2XSDvBOthe4d8BHiDn+aw+XN99l/wbgu1DRQ1gFdOv9Jo/iSBZVUZty7MChnE0ddzBhYNfstjFvU7NOaiI4Vq9L06WroZrEwAFRVtFxWo3YQThON5glJD48FAiaboldNQ8M+48zmgOH4eDSEExVB7YkJNeDkgM/QOoh+35KhLZOnbby0eitG5hKKkwdIyNGKc950pcjkyIK7PgKkS2XkOmZ4ERa/eDTXqGc6HmEQRw+ajMKVrONfTuEP3pmxzmUZuRpt9qhUzarSBojHS04lH4yM+bd6sN6q6racCVKz0OM3eim7oIEYuTrlhCBij6LekoxDTuDNzc3Hf2LgNZv4Vv6sWFTebanY6Gf96t4WFiaW7Dwz6V4Te+3WDePBb+vqCGzzGE3vFbyoh9AdzlSyYou46fUaT0IQXEwb2iC0g3g4r+euGHM9WBBIvf5HTWt/Jl8pUTRTOq2pb/cK3PzGd3I8wSNP4KirjPfFxWhA4GJdLE/bW9puLG0KHDO4XhfkAEh+pEAZk+Z7ZGcB8GSyMT88z092znSs4Jveu0YGKvCaGLcRpyemUN8Uw6k0fv3zoZI93sVYN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(186003)(83380400001)(31686004)(36756003)(6916009)(4326008)(86362001)(38100700002)(66556008)(66946007)(66476007)(6486002)(2616005)(2906002)(8676002)(52116002)(31696002)(478600001)(53546011)(8936002)(54906003)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDR0Rm5pRXZYbnlSZ1BlVzB0dGZRYnN6ai9IL2RBTlZqSkErUEpUaUNwU1pF?=
 =?utf-8?B?a2NmcUUvb0lTOGUraE15ek9UUHRKSWRnL2NNTmJHejNJUFpRckdBWlhBaSsw?=
 =?utf-8?B?Ly9yYkF2NVpXZlBIcll6ZDcxaEd3TkV5eXBCcWZ0YmZIMGZsVmFJUm5peGhm?=
 =?utf-8?B?eVkvbW5paGFOVVhqeDhaK3phUXNkZkNreWFXK1ZqZlVrZXJPMFUycXJJQnRy?=
 =?utf-8?B?d1RJcXQ5bzJLSmlmUHpNelR6VDJTTnVIYnRrNVBEK1ZDRCtpQ0liby9kcXRP?=
 =?utf-8?B?ZEtLOUNvdW10S1h6MlA1cmNIcmVsYjFITFlJRSsxUVZYRlBnRUpDWURDNjM3?=
 =?utf-8?B?Y2t1VkpjRXRyYmlCenNoTmNKMzdvcTIwNjJYb0dnNXZHaFVxZDd0M2lONk52?=
 =?utf-8?B?RUkrMktBb3ExV0JzeGV3NjJETWk4RFhtN3hBSHNhUjRLOGhLY3dmQ2o2c1Ay?=
 =?utf-8?B?NXZiMC9kS1RRRTN3MnE2SElmQ1M3alpzL213a2MrZjhFazN3VVAyRlBIdkN2?=
 =?utf-8?B?TjdiMTBaWklDQWMyUndXY3JMNEE4b3E4VEo0L2RYMEhwNSt5SExRdEJkQ2Y2?=
 =?utf-8?B?RiszRFJJSFc3eTI3cmtvOW1LWUxVSWFPK1NTWE8zZ0I5U0hNQmVuVnIyZDRD?=
 =?utf-8?B?QWw2NXJsZW5MZzBucFdMbGtJRktZQzhJSnRtQmZkeWFTVW9NbWNhL3RaeklJ?=
 =?utf-8?B?Q3E0NlpZT3VHY0t6cnQ4WmVFTEJNS3d5QlhNd0pQUWppSDJlVEs1VW81MENV?=
 =?utf-8?B?b0RWUURpbEhCcjljeWVsVjM2RVZTbzVYZW83cEFZbGNBdUx0ZnZRNEl6N0p2?=
 =?utf-8?B?eno5SWgvOTZrTUwxUFJyYkNGdUxPdFNEVlZGajNJVmFWSysvZkVIRmNvaGdL?=
 =?utf-8?B?cDdYUnVwNVJFYytCSnZ1RENtR1Vqd1c3bVpqaXlRT2o2ZVhic1JwZnpobDFN?=
 =?utf-8?B?MlVvN0sycGsxaFJuRXZWQitsL2VxaTlRUVRqby9rMTRaa3lqT25oRzhqMUox?=
 =?utf-8?B?b2thQ2xYVUNLM1BuZ3J5ZlZQb1FxSE1ES3hKY084ZzR0QXFkVWZkbUZldG02?=
 =?utf-8?B?UUo1SEpIN0psQXhteHVpanhIN1V3L1pLV050YmpTdWF2R1l3aDk2d1hiOHJu?=
 =?utf-8?B?YkFQZG9UVlJDQ2g4ckVidmxXWm1oVjVWb0hhd01LSTdUWnB4WVhkUDltdkcx?=
 =?utf-8?B?MnVFRlNpMzhSanpHcnRUYW1QeE5XY3VSTkRmUXUvcUtmT0YzVmFmbFBiQzhh?=
 =?utf-8?B?TlpHb3NBWU15RThvMWNrMHdzL3RpekhRQWJCajFsTndJdGgxNEZxOUYvRUlG?=
 =?utf-8?B?QWdBNTMvQ0U2Z1pqL0JWSjFLcTQybUZ4KzlQUVNCRHZiWktFbEZCaUZhcm84?=
 =?utf-8?B?cmczRytzMDE1WWI0SmN2cC9LQ3h2eXVsS3ZsclkzK3dlUE5ORytjR2JzRXNK?=
 =?utf-8?B?MnpqQVI3djlFdUVkTXgrcTA4SVlLRGJQSWdFb3NPU25wc2JIcWlxRnhlYWNu?=
 =?utf-8?B?aUI2VTlRMGlTaVNMczRkR1drTFk3ZGxTbXFUcWdYUkZUUEkxN2FTbFFUSzRu?=
 =?utf-8?B?WGZqZDAwcjBFNWZOVEdlWXRKZ3JwbGRVK2VDa2tYV0ZvTHRHSGx0amxEY21J?=
 =?utf-8?B?SW4yME5sckR2YnljejRuTFVHZWZKVEdqaVlVeUZaK2tkY2FpM0QwSlpZWnBP?=
 =?utf-8?B?cWJLdFNmZ1gzZjVOU1BSRDJvQU9iZUxLQk5oMmNQaDVaNEdROTRQdXpCTDJD?=
 =?utf-8?B?SUVPR0k1eGFHalY1S1kxVjcrbVZZRDQ5Q1c5RndUTExTd2FjWTBWcU9rd2Jw?=
 =?utf-8?Q?VDt59xuPuMx+CceRzQ3O/D39xOFdwfhC4Aqog=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 678d5f35-f7ed-42bc-2789-08d9531e59a7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 05:53:26.8936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8z+Zj54DlETFMw+/sZp0Mpsr9SWClndENKlXWXPMOg2BjXai+mHqE9yX/fobseO2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5030
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: rL3ueKK0d_WtpAf7M8ptIeZynL8h-lvI
X-Proofpoint-GUID: rL3ueKK0d_WtpAf7M8ptIeZynL8h-lvI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_03:2021-07-29,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/21 9:49 PM, Andrii Nakryiko wrote:
> On Thu, Jul 29, 2021 at 11:17 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
>>> Add new BPF helper, bpf_get_user_ctx(), which can be used by BPF programs to
>>> get access to the user_ctx value, specified during BPF program attachment (BPF
>>> link creation) time.
>>>
>>> Currently all perf_event-backed BPF program types support bpf_get_user_ctx()
>>> helper. Follow-up patches will add support for fentry/fexit programs as well.
>>>
>>> While at it, mark bpf_tracing_func_proto() as static to make it obvious that
>>> it's only used from within the kernel/trace/bpf_trace.c.
>>>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>>    include/linux/bpf.h            |  3 ---
>>>    include/uapi/linux/bpf.h       | 16 ++++++++++++++++
>>>    kernel/trace/bpf_trace.c       | 35 +++++++++++++++++++++++++++++++++-
>>>    tools/include/uapi/linux/bpf.h | 16 ++++++++++++++++
>>>    4 files changed, 66 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 74b35faf0b73..94ebedc1e13a 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -2110,9 +2110,6 @@ extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
>>>    extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
>>>    extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
>>>
>>> -const struct bpf_func_proto *bpf_tracing_func_proto(
>>> -     enum bpf_func_id func_id, const struct bpf_prog *prog);
>>> -
>>>    const struct bpf_func_proto *tracing_prog_func_proto(
>>>      enum bpf_func_id func_id, const struct bpf_prog *prog);
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index bc1fd54a8f58..96afeced3467 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -4856,6 +4856,21 @@ union bpf_attr {
>>>     *          Get address of the traced function (for tracing and kprobe programs).
>>>     *  Return
>>>     *          Address of the traced function.
>>> + *
>>> + * u64 bpf_get_user_ctx(void *ctx)
>>> + *   Description
>>> + *           Get user_ctx value provided (optionally) during the program
>>> + *           attachment. It might be different for each individual
>>> + *           attachment, even if BPF program itself is the same.
>>> + *           Expects BPF program context *ctx* as a first argument.
>>> + *
>>> + *           Supported for the following program types:
>>> + *                   - kprobe/uprobe;
>>> + *                   - tracepoint;
>>> + *                   - perf_event.
>>
>> I think it is possible in the future we may need to support more
>> program types with user_ctx, not just u64 but more than 64bit value.
>> Should we may make this helper extensible like
>>       long bpf_get_user_ctx(void *ctx, void *user_ctx, u32 user_ctx_len)
>>
>> The return value will 0 to be good and a negative indicating an error.
>> What do you think?
> 
> I explicitly wanted to keep this user_ctx/bpf_cookie to a small fixed
> size. __u64 is perfect because it's small enough to not require
> dynamic memory allocation, but big enough to store any kind of index
> into an array *or* user-space pointer. So if user needs more storage
> than 8 bytes, they will be able to have a bigger array where
> user_ctx/bpf_cookie is just an integer index or some sort of key into
> hashmap, whichever is more convenient.

Okay. returning an index to a map is a good idea. This way, indeed a u64 
return value is enough.

> 
> So I'd like to keep it lean and simple. It is already powerful enough
> to support any scenario, IMO.
> 
>>
>>> + *   Return
>>> + *           Value specified by user at BPF link creation/attachment time
>>> + *           or 0, if it was not specified.
>>>     */
>>>    #define __BPF_FUNC_MAPPER(FN)               \
>>>        FN(unspec),                     \
>>> @@ -5032,6 +5047,7 @@ union bpf_attr {
>>>        FN(timer_start),                \
>>>        FN(timer_cancel),               \
>>>        FN(get_func_ip),                \
>>> +     FN(get_user_ctx),               \
>>>        /* */
>>>
>>>    /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>> index c9cf6a0d0fb3..b14978b3f6fb 100644
>>> --- a/kernel/trace/bpf_trace.c
>>> +++ b/kernel/trace/bpf_trace.c
>>> @@ -975,7 +975,34 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_kprobe = {
>>>        .arg1_type      = ARG_PTR_TO_CTX,
>>>    };
>>>
>>> -const struct bpf_func_proto *
>>> +BPF_CALL_1(bpf_get_user_ctx_trace, void *, ctx)
>>> +{
>>> +     struct bpf_trace_run_ctx *run_ctx;
>>> +
>>> +     run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
>>> +     return run_ctx->user_ctx;
>>> +}
>>> +
>>> +static const struct bpf_func_proto bpf_get_user_ctx_proto_trace = {
>>> +     .func           = bpf_get_user_ctx_trace,
>>> +     .gpl_only       = false,
>>> +     .ret_type       = RET_INTEGER,
>>> +     .arg1_type      = ARG_PTR_TO_CTX,
>>> +};
>>> +
>> [...]
