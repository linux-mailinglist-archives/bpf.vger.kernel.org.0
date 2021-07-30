Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781C43DC114
	for <lists+bpf@lfdr.de>; Sat, 31 Jul 2021 00:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhG3W3K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 18:29:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45912 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232384AbhG3W3K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 18:29:10 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UM92xf023112;
        Fri, 30 Jul 2021 15:28:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Zpl97xF/bZo0GT/5lK/ODDf6M6FmAo3KboRw3ZdQl1w=;
 b=hNp3WF6Eb7gDXgggcx3VG7BpjJL0ZG2nlbWUe5qgFfg6eibjzgtAj4jtPoVedadDC5pf
 ESPnCPFmpPeTnyq/NKNMiUH6+4kMqlObCEbeu44ww7TYhnT0ATu8jHTs+4QFDB+wvBF/
 a7r2qFym+Zb1l4pNzX6n5oBVd9ZW8/AsVXY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a4dhtn07g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Jul 2021 15:28:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 15:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/h2wK5FEuvbv8SyWY/ZzZW6RqFb4PqlrYqzIcTJs02MOuMlkEcj8UgLQsFKoLZXOX2ZXtvp+p77tllNbvVe4a+G7KB+VusB0U+QosaQj3vJ6wpg8a65yKqbKaRU5CB+h4MbllKFcmjN7eSkXs+kJtaiY4rEi70uQ/Wll3Xry94UHzQKVCd7y87BRrmhPHdAGxvf8wNsrLH6Y/B2MqVvs7XxMmb2aIpqieY9/Od3+pLgiZGxediKuU9DsVEsRQ3cxgtmTbXA4dzKoIgjj2EBq6e+MYp1CFtC3Zrqsp2TpdnMSTCLoEyPhvzP24nK3JEIVAI8mmbCvXsDp3EjgVE97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zpl97xF/bZo0GT/5lK/ODDf6M6FmAo3KboRw3ZdQl1w=;
 b=Iw0oyG9i+hyVt3g1dDVEvsICWk+b5LSZflQzLtJyHT4ZtOHHnZfn/JerIXkGDiHfUa0ybt9gBsYpIYTgTopD0GBRrZq3wEsaLpt8gEQo56i2VvPqQ7xqXAWQH3+1gdW2rzwi6jaBEG7Z8vBd4sDPQxjA8hvmBAR5ZxiEYoPMzTWkhe3dVBx+if66vUjXx/P7KTp0iHC0aQPOO0UP8oz0nmXu3/nvROCaHYaqkZ0SUtoZTZChyEt3AFyoayqP5QuVSAeE2v7Q4U/y6ubNTfGFWT7s+3zg/+1YAG0kallEE/LUsk83L9VHmCstgsuxVioJHk1nOKyaE4P53u/JLWIIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4339.namprd15.prod.outlook.com (2603:10b6:806:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 22:28:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 22:28:43 +0000
Subject: Re: [PATCH v2 bpf-next 05/14] bpf: allow to specify user-provided
 context value for BPF perf links
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-6-andrii@kernel.org>
 <138b1ab0-1d9c-7288-06bd-fbe29285fc4f@fb.com>
 <CAEf4Bzb39v5kz1Gc2YjNvGwN8kK8H2fSp1qvipie=ZLpuxRV6Q@mail.gmail.com>
 <5ffd3338-fe76-2080-13a9-5102917a434a@fb.com>
 <CAEf4BzbR=m3Qusth-1JU_E5YMYaoxrNom9tS_pcArsHyiBD85w@mail.gmail.com>
 <dc7489f5-724b-367e-400f-86d7ccf068d3@fb.com>
 <CAEf4BzbLAoLhGnT9Q5OjVjjSROeZVrJ=Mu3F9sE8iSoymWjwAQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <08e123c3-2f67-eaf1-1ba9-832671938377@fb.com>
Date:   Fri, 30 Jul 2021 15:28:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <CAEf4BzbLAoLhGnT9Q5OjVjjSROeZVrJ=Mu3F9sE8iSoymWjwAQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:301:1::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1130] (2620:10d:c090:400::5:890f) by MWHPR11CA0006.namprd11.prod.outlook.com (2603:10b6:301:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend Transport; Fri, 30 Jul 2021 22:28:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f79b15b-feac-4ff0-2969-08d953a96349
X-MS-TrafficTypeDiagnostic: SA1PR15MB4339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB433948F91FD07C48F480CD18D3EC9@SA1PR15MB4339.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZhu3pM4RPONxDuqDxccW01qPuTxp/bA2LAbJRUgB3uW8+6OZ6YNrGDJVbiH8rtEvhvTusqB8gPe0Y03uumUaHWvh+Uk+mTKCiyOMhJNgWLBxNlz5hkf4/yTgqmki/gCZcjbgTnITPZK2pcVF4TRpMgZo2/6g7dPDkpgfBZzw/QmTHgdtkhJ02AfsiexrgAfUQXcfKBeG6k2JyPdawtKHdRKPJQ4iybmPl8faP3biYj/QsvgylCCNKBSw1GOnpvgkFrrKFB3z6hJj/sVVzFfMHLIQCT/oabZZzt4i4KYrgu5j4GyOGORFMztyw1FJ/d/N9qJ42UASrm6rbr5DpHXFPeL/NMvhHJM9NlwCe8f8b11zkV2mi7vauj7Sx876DPwjCaqewrxqRqhCSo5l5zzG72H7yPzL1TU7MFBIA7Ktjrlyuvj1huJt9xi2QlKHWLVMZyWblVfplfxX9arCwB+xeGEdOk7Nr2rrfYdJwNMvPftHLtXLbU5Ak87aiuFyjoH2wDNSun6vbmOPrFDCLtc9yGo2uMvpoGPNXV2SUTiKfmf1t3nD1ABNtYBbxdlxxqJA8dst0wf9QLHtNOETzqySZBVaoIGahjw4mnSZIBJ6y0GD/bMKFiDY2EE+nrh9x+sqJWDuFk2z7dq5bCw9IQpZsSdF6CFHa79WGM/rxt9yryy2gQlI1d9Di44dO4UuXQClaQOTytXRu7v9ISnlRwDaJektwxIy/JeFxYmJ9JkskM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(36756003)(66556008)(66476007)(66946007)(53546011)(6486002)(6666004)(54906003)(8676002)(6916009)(30864003)(8936002)(2616005)(316002)(52116002)(38100700002)(5660300002)(31696002)(478600001)(86362001)(186003)(4326008)(83380400001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUdycjhiNk5WT0s4c29HRU1FdStJOUdBZU45NzdTZzhsSFlobml0ai8xSjNX?=
 =?utf-8?B?aFJkckNZQlBWYUQ3Y1kva0RDVUdjK1pvSzMrYVpGa2pRQlpBbDExSVNIamtW?=
 =?utf-8?B?eTl6MDA3QkpHTks0TzA5SXhnaUtDWDZLRFRIa0ZnY3g2ZTlCU2JLZ2kyenBp?=
 =?utf-8?B?S21ZVXZTWFJiYUJySjJzNnBBdWw2SmlMZGJ4QnVuc3JYbTFxd1Q1RGU5ZCtF?=
 =?utf-8?B?WFlYT3lMQ2VyZ2NCSjQwZFNubEhtK0ovbkl4Y1RSZWdVOVZIK3JYZHJieGZS?=
 =?utf-8?B?NGRUU0loRlBUQVVjQW11NXBZLzh6T05KakMvT3dnSzBoTi91elVZTWF2U1cr?=
 =?utf-8?B?THZzS0czRVB3dHNXVytaREtZV2UxcDdmN1ZTM1R1MG40UDVOWVdGRjQybm1s?=
 =?utf-8?B?MmlOWWljUXlUdkhEU0dFRlZqc1JwaHVnY2xINHVma2dXRUNCdHArNmpGV2NN?=
 =?utf-8?B?a3F5MUQ3T0tTWk9UaU9yMWNhZmRrZkRzaDJGQ21SRFJtcTNSMzRLWERRYnp3?=
 =?utf-8?B?Y1NNZU0wcHArck9sUUVFN1lDVWJ6ZnQxV1dYR2pWcE9nZkpUOUhuQm1PZEEw?=
 =?utf-8?B?QTI1eHhIVUpMMUZra2hLTTcvcHRNZml3clUwVXVuM3JUdUFpcjkzNXl4UzVy?=
 =?utf-8?B?c2RvbUcxVVMxdkExK21kelFLa1g5aUlJaXdGbVFrK1ZMdzJ6ZTh1ZG5UY01y?=
 =?utf-8?B?cnFzN1lWVjZDU2s4S0ZWYWZIeHVvREYrVDBhcnJjREdMd2plUlZ1ZjFTZTNI?=
 =?utf-8?B?aUV0RjdvS0QxNmlpSGhHVlVHY05VWjBsUXF4VGdyT0JMdDh6ZlJ1MDFCM0Z6?=
 =?utf-8?B?WWZwUXZKSEFtcHBTZzVpTDhjRFd0Q1JKd2NXUjhJZy9XejdRMXR3Q3BKaVpN?=
 =?utf-8?B?WFRoVGlOcFZsTXZQbWw1dUdhNEpwTElNeGRReFFCQ294eW01Si85QUxBb0FR?=
 =?utf-8?B?UUYwS2s5bmpsQ3hxR0l2aHllODdVQU9vZEtuSCtob1h1Wlc3amp5ZnYzRGda?=
 =?utf-8?B?Y3VrU2xnYUV6SmVsL2JEYVdEeFRoNHhzRFgzb0lVb3lyeDZTRlRWcWNPUlZ1?=
 =?utf-8?B?eW9oUmJGNGZmcXZhamw4TUtHMW9lb0tmU090Y0xWNDVJa2hpUEhHTy9aa1FD?=
 =?utf-8?B?bTlCclBldlpQRmRZbUE2M2h4ZlJ1V1RPN050OGlQb3oraXcrczBVWWgvZWtO?=
 =?utf-8?B?OXZ4eWZSYjAyM0NUcnVnMjN6QTZKUHdpVHBnR0VoVDl1Z1BRTU9VWVVaWG9R?=
 =?utf-8?B?VGcvWU56SUxaMGhqK3BDYTNuaDFvNTdLcXJtb3cxek1MOW1ST044dDR6OXdF?=
 =?utf-8?B?ZHFSckdUKy8zdi9JQTdvR0pMR2JaaXFtOG5RdFNQakZxUVMvNHBmN2xPRnB3?=
 =?utf-8?B?N3lYSy9PODBLSEhmcEpyN2JRN0ZHMWU5NVpTb2V5ck9ubEViOU9FWEVVWkxp?=
 =?utf-8?B?NmJEVUIzZWhrWEN4dzdlVHArcTU0aUQzZFVGY0Fja0ZHQmNKamc1L0dtVzNK?=
 =?utf-8?B?Z2s1ZFZ1NEdRVndOSkltczdJWk13UUM3VHdTVzRtaTYzeTFKS1JSNUkra2pY?=
 =?utf-8?B?RFJNSWxUSFM4dWprckpDeU5ZZ2taTkYwM2VueTlOUEgvbmhrMmhTQ29JelVH?=
 =?utf-8?B?Uit3TlJmaG9PbGF6S2NIOE5hTUpEWngwVVZ2UFpUajZCakRzbGJvMFpUTm12?=
 =?utf-8?B?YWgycDJSK0RMMUxBUWEvVGxEYzRkMWdyQ2dQbm4xbXZMbkNic1E0WE5xY2pZ?=
 =?utf-8?B?bDkrTFMza2FqNWp6aVlGdWsxbkk0SDhBRno2aVFmZ3FnTHg5TFNacGV2Mmt5?=
 =?utf-8?Q?LyjgymDn1u8rgoHdvE7pgB2QvybINLbdevOdc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f79b15b-feac-4ff0-2969-08d953a96349
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 22:28:43.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7/oBg9HRnSK7YTTLeoggjejlq2A5tGLrd7cPGLEb5ljhJ3AIxu0GDwGfx613HoT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4339
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 43i3Lu16wXhG-1g5pYt0ZlOcDW6siWQ1
X-Proofpoint-ORIG-GUID: 43i3Lu16wXhG-1g5pYt0ZlOcDW6siWQ1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_11:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107300151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/30/21 3:06 PM, Andrii Nakryiko wrote:
> On Fri, Jul 30, 2021 at 2:34 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 7/30/21 10:48 AM, Andrii Nakryiko wrote:
>>> On Thu, Jul 29, 2021 at 10:49 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/29/21 9:31 PM, Andrii Nakryiko wrote:
>>>>> On Thu, Jul 29, 2021 at 11:00 AM Yonghong Song <yhs@fb.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
>>>>>>> Add ability for users to specify custom u64 value when creating BPF link for
>>>>>>> perf_event-backed BPF programs (kprobe/uprobe, perf_event, tracepoints).
>>>>>>>
>>>>>>> This is useful for cases when the same BPF program is used for attaching and
>>>>>>> processing invocation of different tracepoints/kprobes/uprobes in a generic
>>>>>>> fashion, but such that each invocation is distinguished from each other (e.g.,
>>>>>>> BPF program can look up additional information associated with a specific
>>>>>>> kernel function without having to rely on function IP lookups). This enables
>>>>>>> new use cases to be implemented simply and efficiently that previously were
>>>>>>> possible only through code generation (and thus multiple instances of almost
>>>>>>> identical BPF program) or compilation at runtime (BCC-style) on target hosts
>>>>>>> (even more expensive resource-wise). For uprobes it is not even possible in
>>>>>>> some cases to know function IP before hand (e.g., when attaching to shared
>>>>>>> library without PID filtering, in which case base load address is not known
>>>>>>> for a library).
>>>>>>>
>>>>>>> This is done by storing u64 user_ctx in struct bpf_prog_array_item,
>>>>>>> corresponding to each attached and run BPF program. Given cgroup BPF programs
>>>>>>> already use 2 8-byte pointers for their needs and cgroup BPF programs don't
>>>>>>> have (yet?) support for user_ctx, reuse that space through union of
>>>>>>> cgroup_storage and new user_ctx field.
>>>>>>>
>>>>>>> Make it available to kprobe/tracepoint BPF programs through bpf_trace_run_ctx.
>>>>>>> This is set by BPF_PROG_RUN_ARRAY, used by kprobe/uprobe/tracepoint BPF
>>>>>>> program execution code, which luckily is now also split from
>>>>>>> BPF_PROG_RUN_ARRAY_CG. This run context will be utilized by a new BPF helper
>>>>>>> giving access to this user context value from inside a BPF program. Generic
>>>>>>> perf_event BPF programs will access this value from perf_event itself through
>>>>>>> passed in BPF program context.
>>>>>>>
>>>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>>>>>> ---
>>>>>>>      drivers/media/rc/bpf-lirc.c    |  4 ++--
>>>>>>>      include/linux/bpf.h            | 16 +++++++++++++++-
>>>>>>>      include/linux/perf_event.h     |  1 +
>>>>>>>      include/linux/trace_events.h   |  6 +++---
>>>>>>>      include/uapi/linux/bpf.h       |  7 +++++++
>>>>>>>      kernel/bpf/core.c              | 29 ++++++++++++++++++-----------
>>>>>>>      kernel/bpf/syscall.c           |  2 +-
>>>>>>>      kernel/events/core.c           | 21 ++++++++++++++-------
>>>>>>>      kernel/trace/bpf_trace.c       |  8 +++++---
>>>>>>>      tools/include/uapi/linux/bpf.h |  7 +++++++
>>>>>>>      10 files changed, 73 insertions(+), 28 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
>>>>>>> index afae0afe3f81..7490494273e4 100644
>>>>>>> --- a/drivers/media/rc/bpf-lirc.c
>>>>>>> +++ b/drivers/media/rc/bpf-lirc.c
>>>>>>> @@ -160,7 +160,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
>>>>>>>                  goto unlock;
>>>>>>>          }
>>>>>>>
>>>>>>> -     ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
>>>>>>> +     ret = bpf_prog_array_copy(old_array, NULL, prog, 0, &new_array);
>>>>>>>          if (ret < 0)
>>>>>>>                  goto unlock;
>>>>>>>
>>>>>> [...]
>>>>>>>      void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
>>>>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>>>>> index 00b1267ab4f0..bc1fd54a8f58 100644
>>>>>>> --- a/include/uapi/linux/bpf.h
>>>>>>> +++ b/include/uapi/linux/bpf.h
>>>>>>> @@ -1448,6 +1448,13 @@ union bpf_attr {
>>>>>>>                                  __aligned_u64   iter_info;      /* extra bpf_iter_link_info */
>>>>>>>                                  __u32           iter_info_len;  /* iter_info length */
>>>>>>>                          };
>>>>>>> +                     struct {
>>>>>>> +                             /* black box user-provided value passed through
>>>>>>> +                              * to BPF program at the execution time and
>>>>>>> +                              * accessible through bpf_get_user_ctx() BPF helper
>>>>>>> +                              */
>>>>>>> +                             __u64           user_ctx;
>>>>>>> +                     } perf_event;
>>>>>>
>>>>>> Is it possible to fold this field into previous union?
>>>>>>
>>>>>>                     union {
>>>>>>                             __u32           target_btf_id;  /* btf_id of
>>>>>> target to attach to */
>>>>>>                             struct {
>>>>>>                                     __aligned_u64   iter_info;      /*
>>>>>> extra bpf_iter_link_info */
>>>>>>                                     __u32           iter_info_len;  /*
>>>>>> iter_info length */
>>>>>>                             };
>>>>>>                     };
>>>>>>
>>>>>>
>>>>>
>>>>> I didn't want to do it, because different types of BPF links will
>>>>> accept this user_ctx (or now bpf_cookie). And then we'll have to have
>>>>> different locations of that field for different types of links.
>>>>>
>>>>> For example, when/if we add this user_ctx to BPF iterator programs,
>>>>> having __u64 user_ctx in the same anonymous union will make it overlap
>>>>> with iter_info, which is a problem. So I want to have a link
>>>>> type-specific sections in LINK_CREATE command section, to allow the
>>>>> same field name at different locations.
>>>>>
>>>>> I actually think that we should put iter_info/iter_info_len into a
>>>>> named field, like this (also added user_ctx for bpf_iter link as a
>>>>> demonstration):
>>>>>
>>>>> struct {
>>>>>        __aligned_u64 info;
>>>>>        __u32         info_len;
>>>>>        __aligned_u64 user_ctx;  /* see how it's at a different offset
>>>>> than perf_event.user_ctx */
>>>>> } iter;
>>>>> struct {
>>>>>        __u64         user_ctx;
>>>>> } perf_event;
>>>>>
>>>>> (of course keeping already existing fields in anonymous struct for
>>>>> backwards compatibility)
>>>>
>>>> Okay, then since user_ctx may be used by many link types. How
>>>> about just with the field "user_ctx" without struct perf_event.
>>>
>>> I'd love to do it because it is indeed generic and common field, like
>>> target_fd. But I'm not sure what you are proposing below. Where
>>> exactly that user_ctx (now called bpf_cookie) goes in your example? I
>>> see few possible options that allow preserving ABI backwards
>>> compatibility. Let's see if you and everyone else likes any of those
>>> better. I'll use the full LINK_CREATE sub-struct definition from
>>> bpf_attr to make it clear. And to demonstrate how this can be extended
>>> to bpf_iter in the future, please note this part as this is an
>>> important aspect.
>>>
>>> 1. Full backwards compatibility and per-link type sections (my current
>>> approach):
>>>
>>>           struct { /* struct used by BPF_LINK_CREATE command */
>>>                   __u32           prog_fd;
>>>                   union {
>>>                           __u32           target_fd;
>>>                           __u32           target_ifindex;
>>>                   };
>>>                   __u32           attach_type;
>>>                   __u32           flags;
>>>                   union {
>>>                           __u32           target_btf_id;
>>>                           struct {
>>>                                   __aligned_u64   iter_info;
>>>                                   __u32           iter_info_len;
>>>                           };
>>>                           struct {
>>>                                   __u64           bpf_cookie;
>>>                           } perf_event;
>>>                           struct {
>>>                                   __aligned_u64   info;
>>>                                   __u32           info_len;
>>>                                   __aligned_u64   bpf_cookie;
>>>                           } iter;
>>>                  };
>>>           } link_create;
>>>
>>> The good property here is that we can keep easily extending link
>>> type-specific sections with extra fields where needed. For common
>>> stuff like bpf_cookie it's suboptimal because we'll need to duplicate
>>> field definition in each struct inside that union, but I think that's
>>> fine. From end-user point of view, they will know which type of link
>>> they are creating, so the use will be straightforward. This is why I
>>> went with this approach. But let's consider alternatives.
>>>
>>> 2. Non-backwards compatible layout but extra flag to specify that new
>>> field layout is used.
>>>
>>>           struct { /* struct used by BPF_LINK_CREATE command */
>>>                   __u32           prog_fd;
>>>                   union {
>>>                           __u32           target_fd;
>>>                           __u32           target_ifindex;
>>>                   };
>>>                   __u32           attach_type;
>>>                   __u32           flags; /* this will start supporting
>>> some new flag like BPF_F_LINK_CREATE_NEW */
>>>                   __u64           bpf_cookie; /* common field now */
>>>                   union { /* this parts is effectively deprecated now */
>>>                           __u32           target_btf_id;
>>>                           struct {
>>>                                   __aligned_u64   iter_info;
>>>                                   __u32           iter_info_len;
>>>                           };
>>>                           struct { /* this is new layout, but needs
>>> BPF_F_LINK_CREATE_NEW, at least for ext/ and bpf_iter/ programs */
>>>                               __u64       bpf_cookie;
>>>                               union {
>>>                                   struct {
>>>                                       __u32     target_btf_id;
>>>                                   } ext;
>>>                                   struct {
>>>                                       __aligned_u64 info;
>>>                                       __u32         info_len;
>>>                                   } iter;
>>>                               }
>>>                           }
>>>                   };
>>>           } link_create;
>>>
>>> This makes bpf_cookie a common field, but at least for EXT (freplace/)
>>> and ITER (bpf_iter/) links we need to specify extra flag to specify
>>> that we are not using iter_info/iter_info_len/target_btf_id. bpf_iter
>>> then will use iter.info and iter.info_len, and can use plain
>>> bpf_cookie.
>>>
>>> IMO, this is way too confusing and a maintainability nightmare.
>>>
>>> I'm trying to guess what you are proposing, I can read it two ways,
>>> but let me know if I missed something.
>>>
>>> 3. Just add bpf_cookie field before link type-specific section.
>>>
>>>           struct { /* struct used by BPF_LINK_CREATE command */
>>>                   __u32           prog_fd;
>>>                   union {
>>>                           __u32           target_fd;
>>>                           __u32           target_ifindex;
>>>                   };
>>>                   __u32           attach_type;
>>>                   __u32           flags;
>>>                   __u64           bpf_cookie;  // <<<<<<<<<< HERE
>>>                   union {
>>>                           __u32           target_btf_id;
>>>                           struct {
>>>                                   __aligned_u64   iter_info;
>>>                                   __u32           iter_info_len;
>>>                           };
>>>                   };
>>>           } link_create;
>>>
>>> This looks really nice and would be great, but that changes offsets
>>> for target_btf_id/iter_info/iter_info_len, so a no go. The only way to
>>> rectify this is what proposal #2 above does with an extra flag.
>>>
>>> 4. Add bpf_cookie after link-type specific part:
>>>
>>>           struct { /* struct used by BPF_LINK_CREATE command */
>>>                   __u32           prog_fd;
>>>                   union {
>>>                           __u32           target_fd;
>>>                           __u32           target_ifindex;
>>>                   };
>>>                   __u32           attach_type;
>>>                   __u32           flags;
>>>                   union {
>>>                           __u32           target_btf_id;
>>>                           struct {
>>>                                   __aligned_u64   iter_info;
>>>                                   __u32           iter_info_len;
>>>                           };
>>>                           struct {
>>>                   };
>>>                   __u64           bpf_cookie; // <<<<<<<<<<<<<<<<<< HERE
>>>           } link_create;
>>>
>>> This could work. But we are wasting 16 bytes currently used for
>>> target_btf_id/iter_info/iter_info_len. If we later need to do
>>> something link type-specific, we can add it to the existing union if
>>> we need <= 16 bytes, otherwise we'll need to start another union after
>>> bpf_cookie, splitting this into two link type-specific sections.
>>>
>>> Overall, this might work, especially assuming we won't need to extend
>>> iter-specific portions. But I really hate that we didn't do named
>>> structs inside that union (i.e., ext.target_btf_id and
>>> iter.info/iter.info_len) and I'd like to rectify that in the follow up
>>> patches with named structs duplicating existing field layout, but with
>>> proper naming. But splitting this LINK_CREATE bpf_attr part into two
>>> unions would make it hard and awkward in the future.
>>>
>>> So, thoughts? Did you have something else in mind that I missed?
>>
>> What I proposed is your option 4. Yes, in the future if there is there
>> are something we want to add to bpf iter, we can add to iter_info, so
>> it should not be an issue. Any other new link_type may utilized the same
>> union with
>>      struct {
>>         __aligned_u64  new_type_info;
>>         __u32          new_type_info_len;
>>      };
>> and this will put extensibility into new_type_info.
>> I know this may be a little bit hassle but it should work.
>>
> 
> I see what you mean. With this extra pointer we shouldn't need more
> than 16 bytes per link type. That's unnecessary complication for a lot
> of simpler types of links, unfortunately, though definitely an option.
> 
> We could have also done approach #4 but maybe leave 16-32 bytes before
> bpf_cookie for the union, so that it's much less likely that we'll run
> out of space there. Not very clean either, so I don't know.
> 
> I'll keep it here for discussion for now, let's see if anyone has
> strong preferences and opinions.
> 
>> Your option 1 should work too, which is what I proposed in the beginning
>> to put into the union and we can feel free to add bpf_cookie for each
>> individual link type. This is actually cleaner.
> 
> Oh, you did? I must have misunderstood then. If you like approach #1,
> then it's what I'm doing right now, so let's keep it as is and let's
> see if anyone else has preferences.

Just checked old emails. It is actually my misunderstanding.
I probably mismatched "{" and "}" and thought you placed
outside the union and made the suggestion. So never mind,
we are on the same page :-)

> 
>>
>>>
>>>
>>>> Sometime like
>>>>
>>>> __u64   user_ctx;
>>>>
>>>> instead of
>>>>
>>>> struct {
>>>>           __u64   user_ctx;
>>>> } perf_event;
>>>>
>>>>>
>>>>> I decided to not do that in this patch set, though, to not distract
>>>>> from the main goal. But I think we should avoid this shared field
>>>>> "namespace" across different link types going forward.
>>>>>
>>>>>
>>>>>>>                  };
>>>>>>>          } link_create;
>>>>>>>
>>>>>> [...]
