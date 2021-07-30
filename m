Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95183DC04C
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 23:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhG3Vea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 17:34:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34630 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229871AbhG3Ve3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 17:34:29 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16ULTc3C022632;
        Fri, 30 Jul 2021 14:34:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VVjEziU9RvxeoDRJnx1iQ2Xl10aYYJZHlxvnndxCwRY=;
 b=DcWtEQn+7uR17qWrGG+nM+fMB1P482iOqu3L9mktXWtYkHcq2xxTZBWLU+urGx/a6Ozb
 AE80PkTYgy4aPfQz7G386kyo0BlvDz+OYrWmzoDWxhAF3JL2/+iQ//JX4LHxJoWidcNb
 5RkTH7TzM0ZRe6Zm1YB/20PfpdP7IRo4Wq0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a4ea2c4pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Jul 2021 14:34:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 14:34:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIgYfgf5tFCdCnf1tYhNaz52SVw4LZWrNC+QPydpYjAGHzB34twxagWgUfQomLqkwnKt75PZgNvDFBkKUc55ZVwQBbNbreaFOlcIHy9fHnMLseP9cYYe6UgF+3YilqeLPqCzwUDhQxcQUC3fyPdFH9OG1nlLC30XgrNY+DCLPiTlxR00cRDVsnVWc5y0A0PWdCwpAZXyITy8WuKxSLgSCjTg/HZhDH9fhgYce3Zo8Jjbyf1K0+OtK0CTgizDklGaYrDK1wdeux/N8UgwlR795Z3HRGfEIM+0zkvlK1a0Vztj5K7uRCVKo/DEhL8oXZdc48TQmGtk8ispD5YQZfd3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVjEziU9RvxeoDRJnx1iQ2Xl10aYYJZHlxvnndxCwRY=;
 b=da5IaOihQopoeFHy8OUJnNCljqngPImiN4HsG+rqMoBv2Z57QINK8wWQ2W33htdxHi6co4Dj2elOGRiWaP+yI3Nwh8mxxWDnGAZofRVdcqdr6c4zcfTDeJRsOyKYYGvR3T7A/RuhqMU3mJP4XfMRL15EvwnqBWtqRccOqenMBCbv5J+QVwzZNkwXNnb6TagfP4KmlbBnG5iZG+bTKNl9yyeLqAt3IRieiP/clvoNFXgrLPeLirAc++0yyW9vStjfDAgTuMkBjjORG561RkFaTZ2vi1C8lOIVSlwBmllAFNeZWb1YECn5ish/B8AVxA5LbvY6pHCJDibCQzlxPQg42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4385.namprd15.prod.outlook.com (2603:10b6:806:190::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 21:34:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 21:34:02 +0000
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
From:   Yonghong Song <yhs@fb.com>
Message-ID: <dc7489f5-724b-367e-400f-86d7ccf068d3@fb.com>
Date:   Fri, 30 Jul 2021 14:34:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <CAEf4BzbR=m3Qusth-1JU_E5YMYaoxrNom9tS_pcArsHyiBD85w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1130] (2620:10d:c090:400::5:890f) by BYAPR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:e0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.6 via Frontend Transport; Fri, 30 Jul 2021 21:34:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12e471e8-58b4-4e07-4a8e-08d953a1bff6
X-MS-TrafficTypeDiagnostic: SA1PR15MB4385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4385E6A3E0E14C779EE7FDFED3EC9@SA1PR15MB4385.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIF4IpM4Cshav+71YU/nsoaAl1SxOs0lS206rSfchVCyTHdZiM2wy+kx52KeAgKUL/+eyPAxBNx9np3EdcfNjxl8pLon8mLNoWCxhWPILCOovJPnuMt0uVW8+oEdsHeasSANHjjgJP3kx6y0xEtXdykKSsRH893Ievc/ZcaWPNtYkRMxg7pzijjDOFMFrbD9PnUZRgsIdzckM5P1ncMT9ib+vSO90XkZqZEkJGuXlR++LXKkqUCyDv8WhTQGUBBl/ye9ZXarAHfnT2qIUXJg7f2r3TdoRye00HSwV/oDqUv018maVPjdOEKBCIrDsEtx8nYQashcIiMPcGkJHTiETQIjD0vrgBd1nOclLXzvTB6MjCXnXOnrL5mUuhsNoTlqHC8SJZbwQ1eN0VBsF9YC/ZJJ5VkPNgPyKh8IkCk5iKpFUi70ekK6fmrTKIlwruGcwed/R/hGrddYG+ie81wYC8Uo0L5Qn/9WIkZ+zV4tBpOd1OiRU1ElSbujzN9RGdzH9dR9B5l0tHIbGMc5CY510ONXBWo2wCxejQfKL2zDDL6S0SCulNQSpo341JMcqOfCkGsfZkkuXlMoNOFCIAbo0reim0BOGiepdLZk8qFhJ/QV1pN6WRYLi95WRcYCFaCPTYEGOCdiQgNPhIm4EakSxGiEctw2DEALRlxsD8Ke3fbCO3b/usFRYSsaexoVeIxZdJmWjE9fX7QUHrqp4htetSdSH8wvX3ylB0jlVH+GLFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(5660300002)(2906002)(31696002)(316002)(38100700002)(478600001)(6486002)(8676002)(8936002)(54906003)(52116002)(2616005)(66946007)(30864003)(6916009)(31686004)(53546011)(66556008)(66476007)(4326008)(36756003)(86362001)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdQeUVlUmN4eG1SVk8xTzdKNGttNTBlNlZPRERXQ21EOFpPVHJtbkF5RmNR?=
 =?utf-8?B?U2wwSmlqeWRoNVpsK213dURMZEMvdHp1ZmpJT0REMUpwMmRiYVhiUnZUUkNu?=
 =?utf-8?B?akcrRVRIRU0rVDMyWW9hTjIrNXN1aXVIRElXZHhQUWZJTWhITmxOV3VtdXFW?=
 =?utf-8?B?STZiRGs3RkJ2NnFsMERUZFk5SktGNzkzeDMySTNZdEdqQ0RpOExBbGJkcmxH?=
 =?utf-8?B?elE2dW9JQmxpeE9iU2Z3QTdTK2hoOXhQVzNlSG53NWpQa3ZtMFZ5b1BVeHJu?=
 =?utf-8?B?VGVsVU9GWm5kUjhUYzM0aERiQmtYRnNGTVhJYmwzY2t2UUI5ZUI0UUo0QlZa?=
 =?utf-8?B?VXEzUjZ0OXFab3IrQ24vNXk3aGRYWWJqU1RFeXpnR0ladkRhSmEwakFWakRJ?=
 =?utf-8?B?SXNjckZNbkJIZWMxcTROMjFiVjJIMHJWVHhJeVllSGxZQ1l5OE5LOHhSRnVZ?=
 =?utf-8?B?MUxxQkFGM240eEJwSW9tQWtiWjkwMnFHM1FhdjY4ekZ3WlFoOERSMS82UThm?=
 =?utf-8?B?T05TTllhQnlZdytUNzFCSk9qQUIrdUppUTNNUUd5d0dVZERrdG54QnpJTU1y?=
 =?utf-8?B?SWdkMnFjbkZEbEFpOWRRL0duZ2QwRnozQzZ2dXBuT0FVakFueldiUnI4a1Nx?=
 =?utf-8?B?NzJvTUhjYXVyRG1iV3lHYVlWY0JEQnA1WTZDZ1hoWDY3RE04cm9nOXF0cHJo?=
 =?utf-8?B?S2I5N2duVlpReTlwcVRBWnNmS0JBVEZCR3phVlFYcURtaHdkSEJjT2xMUS9W?=
 =?utf-8?B?UkFXOW1XREVDTG5jTHFDTGFMcFZabTFOZ2V6TnJDTkFEYlpVcG9SSjgyUzNp?=
 =?utf-8?B?eG04RmZNMDYyQS8zN3dpQjNPMzVhRWtoS2FRZVBYanAxazVWMzN5WExpdWxD?=
 =?utf-8?B?Zm1sQ1FhRWVWSUMxbFJtbzFGVzNzYzRWbWlaQVlVa1hId2xXTDg5bjVPb0Ux?=
 =?utf-8?B?eDF5ZGs4b2VNaGtTNUJSOE5CQ0tSY2V5L0hyNkZjQ05JR3V4VHJMSkNzZ2po?=
 =?utf-8?B?Q1lOeTJlMzdMdWtpUkIxRlNGSlE5dGkzcElyZWZ2bGViNy9tUGZySEVTb2Rx?=
 =?utf-8?B?V3JrYU5xSDlucHNLc3NIUlYzL1dEc05DVkZyTFB4bG0zTE43bWhKUzYyUmFP?=
 =?utf-8?B?U0hYM1ZaWWtRb3NwL1dPQ09wL2x6d2JaTXlLdmJNdEdwY2RkUjI2RGdlUitj?=
 =?utf-8?B?ZWhWN1RkVDFhR2c1MHNBT1dOWkhra0ZGOEdQMjh5TmRoNFo5bzV0QU15RDFS?=
 =?utf-8?B?OUdWcml3c1lyaWMvSHNoUG0rV1k4TE00SmlCMzRnZkJzT1A0WEVXRXgrcGNS?=
 =?utf-8?B?eDJVU1VwVkR1MEZCV3ZpMkR1YXVlMndNL1N3dFlWdWQzTDRob2dOVG0ra0g1?=
 =?utf-8?B?OFp5TVpTaW5BVjBqRkw0dkRRN0dtb2tubmxCTG4vTDdTRnBNRktwUzZzTkpk?=
 =?utf-8?B?d1NUZjNFMFRBOFpvZTZNSFFTdFJrV2pUUGcwdG43RTVmM1hsVmdNYjZicUFY?=
 =?utf-8?B?OWZoMk1DanlLYklwZUdjUG1nZEVQWTBtL1lVVVF1RkM1OXh2NzAzOEVDRldW?=
 =?utf-8?B?YTU3THJ4UURFZ3d0dEV6SmxHR0hUaVN3cTAxeFlVSkkrOU93ZmZsUlFHUW9t?=
 =?utf-8?B?R1R4bGhXcWJ1d3NPczNYeHg0czJkdGE2S0o4VTJEZXdCMmJkUE96VEFuclhV?=
 =?utf-8?B?TlQ0UTJWeWhxWlNZcEo2bHc4SDhSeHNnZWZ0NHpjTGlHS2dCMkJpMTdwNnBk?=
 =?utf-8?B?SHUrcTdLdFZLM3dGMGJ3L3dLZmhiMEJHV05RUndMWEZ2dFdIYlFZK2VkWmJ3?=
 =?utf-8?Q?CKVTWcpyryp79laza0GgXTIR0/DN8SKa77avU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e471e8-58b4-4e07-4a8e-08d953a1bff6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 21:34:02.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+Gyys7w6DT/C6yWU9XQoGp5dp23coW1cNtieALHWCTdH19sJiOrsfVTuTHgI3AZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4385
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 9ILqkx-JWOSgzN08Bna3TSJ6WwBwqeO0
X-Proofpoint-GUID: 9ILqkx-JWOSgzN08Bna3TSJ6WwBwqeO0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_11:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107300146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/30/21 10:48 AM, Andrii Nakryiko wrote:
> On Thu, Jul 29, 2021 at 10:49 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 7/29/21 9:31 PM, Andrii Nakryiko wrote:
>>> On Thu, Jul 29, 2021 at 11:00 AM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
>>>>> Add ability for users to specify custom u64 value when creating BPF link for
>>>>> perf_event-backed BPF programs (kprobe/uprobe, perf_event, tracepoints).
>>>>>
>>>>> This is useful for cases when the same BPF program is used for attaching and
>>>>> processing invocation of different tracepoints/kprobes/uprobes in a generic
>>>>> fashion, but such that each invocation is distinguished from each other (e.g.,
>>>>> BPF program can look up additional information associated with a specific
>>>>> kernel function without having to rely on function IP lookups). This enables
>>>>> new use cases to be implemented simply and efficiently that previously were
>>>>> possible only through code generation (and thus multiple instances of almost
>>>>> identical BPF program) or compilation at runtime (BCC-style) on target hosts
>>>>> (even more expensive resource-wise). For uprobes it is not even possible in
>>>>> some cases to know function IP before hand (e.g., when attaching to shared
>>>>> library without PID filtering, in which case base load address is not known
>>>>> for a library).
>>>>>
>>>>> This is done by storing u64 user_ctx in struct bpf_prog_array_item,
>>>>> corresponding to each attached and run BPF program. Given cgroup BPF programs
>>>>> already use 2 8-byte pointers for their needs and cgroup BPF programs don't
>>>>> have (yet?) support for user_ctx, reuse that space through union of
>>>>> cgroup_storage and new user_ctx field.
>>>>>
>>>>> Make it available to kprobe/tracepoint BPF programs through bpf_trace_run_ctx.
>>>>> This is set by BPF_PROG_RUN_ARRAY, used by kprobe/uprobe/tracepoint BPF
>>>>> program execution code, which luckily is now also split from
>>>>> BPF_PROG_RUN_ARRAY_CG. This run context will be utilized by a new BPF helper
>>>>> giving access to this user context value from inside a BPF program. Generic
>>>>> perf_event BPF programs will access this value from perf_event itself through
>>>>> passed in BPF program context.
>>>>>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>>>> ---
>>>>>     drivers/media/rc/bpf-lirc.c    |  4 ++--
>>>>>     include/linux/bpf.h            | 16 +++++++++++++++-
>>>>>     include/linux/perf_event.h     |  1 +
>>>>>     include/linux/trace_events.h   |  6 +++---
>>>>>     include/uapi/linux/bpf.h       |  7 +++++++
>>>>>     kernel/bpf/core.c              | 29 ++++++++++++++++++-----------
>>>>>     kernel/bpf/syscall.c           |  2 +-
>>>>>     kernel/events/core.c           | 21 ++++++++++++++-------
>>>>>     kernel/trace/bpf_trace.c       |  8 +++++---
>>>>>     tools/include/uapi/linux/bpf.h |  7 +++++++
>>>>>     10 files changed, 73 insertions(+), 28 deletions(-)
>>>>>
>>>>> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
>>>>> index afae0afe3f81..7490494273e4 100644
>>>>> --- a/drivers/media/rc/bpf-lirc.c
>>>>> +++ b/drivers/media/rc/bpf-lirc.c
>>>>> @@ -160,7 +160,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
>>>>>                 goto unlock;
>>>>>         }
>>>>>
>>>>> -     ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
>>>>> +     ret = bpf_prog_array_copy(old_array, NULL, prog, 0, &new_array);
>>>>>         if (ret < 0)
>>>>>                 goto unlock;
>>>>>
>>>> [...]
>>>>>     void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
>>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>>> index 00b1267ab4f0..bc1fd54a8f58 100644
>>>>> --- a/include/uapi/linux/bpf.h
>>>>> +++ b/include/uapi/linux/bpf.h
>>>>> @@ -1448,6 +1448,13 @@ union bpf_attr {
>>>>>                                 __aligned_u64   iter_info;      /* extra bpf_iter_link_info */
>>>>>                                 __u32           iter_info_len;  /* iter_info length */
>>>>>                         };
>>>>> +                     struct {
>>>>> +                             /* black box user-provided value passed through
>>>>> +                              * to BPF program at the execution time and
>>>>> +                              * accessible through bpf_get_user_ctx() BPF helper
>>>>> +                              */
>>>>> +                             __u64           user_ctx;
>>>>> +                     } perf_event;
>>>>
>>>> Is it possible to fold this field into previous union?
>>>>
>>>>                    union {
>>>>                            __u32           target_btf_id;  /* btf_id of
>>>> target to attach to */
>>>>                            struct {
>>>>                                    __aligned_u64   iter_info;      /*
>>>> extra bpf_iter_link_info */
>>>>                                    __u32           iter_info_len;  /*
>>>> iter_info length */
>>>>                            };
>>>>                    };
>>>>
>>>>
>>>
>>> I didn't want to do it, because different types of BPF links will
>>> accept this user_ctx (or now bpf_cookie). And then we'll have to have
>>> different locations of that field for different types of links.
>>>
>>> For example, when/if we add this user_ctx to BPF iterator programs,
>>> having __u64 user_ctx in the same anonymous union will make it overlap
>>> with iter_info, which is a problem. So I want to have a link
>>> type-specific sections in LINK_CREATE command section, to allow the
>>> same field name at different locations.
>>>
>>> I actually think that we should put iter_info/iter_info_len into a
>>> named field, like this (also added user_ctx for bpf_iter link as a
>>> demonstration):
>>>
>>> struct {
>>>       __aligned_u64 info;
>>>       __u32         info_len;
>>>       __aligned_u64 user_ctx;  /* see how it's at a different offset
>>> than perf_event.user_ctx */
>>> } iter;
>>> struct {
>>>       __u64         user_ctx;
>>> } perf_event;
>>>
>>> (of course keeping already existing fields in anonymous struct for
>>> backwards compatibility)
>>
>> Okay, then since user_ctx may be used by many link types. How
>> about just with the field "user_ctx" without struct perf_event.
> 
> I'd love to do it because it is indeed generic and common field, like
> target_fd. But I'm not sure what you are proposing below. Where
> exactly that user_ctx (now called bpf_cookie) goes in your example? I
> see few possible options that allow preserving ABI backwards
> compatibility. Let's see if you and everyone else likes any of those
> better. I'll use the full LINK_CREATE sub-struct definition from
> bpf_attr to make it clear. And to demonstrate how this can be extended
> to bpf_iter in the future, please note this part as this is an
> important aspect.
> 
> 1. Full backwards compatibility and per-link type sections (my current
> approach):
> 
>          struct { /* struct used by BPF_LINK_CREATE command */
>                  __u32           prog_fd;
>                  union {
>                          __u32           target_fd;
>                          __u32           target_ifindex;
>                  };
>                  __u32           attach_type;
>                  __u32           flags;
>                  union {
>                          __u32           target_btf_id;
>                          struct {
>                                  __aligned_u64   iter_info;
>                                  __u32           iter_info_len;
>                          };
>                          struct {
>                                  __u64           bpf_cookie;
>                          } perf_event;
>                          struct {
>                                  __aligned_u64   info;
>                                  __u32           info_len;
>                                  __aligned_u64   bpf_cookie;
>                          } iter;
>                 };
>          } link_create;
> 
> The good property here is that we can keep easily extending link
> type-specific sections with extra fields where needed. For common
> stuff like bpf_cookie it's suboptimal because we'll need to duplicate
> field definition in each struct inside that union, but I think that's
> fine. From end-user point of view, they will know which type of link
> they are creating, so the use will be straightforward. This is why I
> went with this approach. But let's consider alternatives.
> 
> 2. Non-backwards compatible layout but extra flag to specify that new
> field layout is used.
> 
>          struct { /* struct used by BPF_LINK_CREATE command */
>                  __u32           prog_fd;
>                  union {
>                          __u32           target_fd;
>                          __u32           target_ifindex;
>                  };
>                  __u32           attach_type;
>                  __u32           flags; /* this will start supporting
> some new flag like BPF_F_LINK_CREATE_NEW */
>                  __u64           bpf_cookie; /* common field now */
>                  union { /* this parts is effectively deprecated now */
>                          __u32           target_btf_id;
>                          struct {
>                                  __aligned_u64   iter_info;
>                                  __u32           iter_info_len;
>                          };
>                          struct { /* this is new layout, but needs
> BPF_F_LINK_CREATE_NEW, at least for ext/ and bpf_iter/ programs */
>                              __u64       bpf_cookie;
>                              union {
>                                  struct {
>                                      __u32     target_btf_id;
>                                  } ext;
>                                  struct {
>                                      __aligned_u64 info;
>                                      __u32         info_len;
>                                  } iter;
>                              }
>                          }
>                  };
>          } link_create;
> 
> This makes bpf_cookie a common field, but at least for EXT (freplace/)
> and ITER (bpf_iter/) links we need to specify extra flag to specify
> that we are not using iter_info/iter_info_len/target_btf_id. bpf_iter
> then will use iter.info and iter.info_len, and can use plain
> bpf_cookie.
> 
> IMO, this is way too confusing and a maintainability nightmare.
> 
> I'm trying to guess what you are proposing, I can read it two ways,
> but let me know if I missed something.
> 
> 3. Just add bpf_cookie field before link type-specific section.
> 
>          struct { /* struct used by BPF_LINK_CREATE command */
>                  __u32           prog_fd;
>                  union {
>                          __u32           target_fd;
>                          __u32           target_ifindex;
>                  };
>                  __u32           attach_type;
>                  __u32           flags;
>                  __u64           bpf_cookie;  // <<<<<<<<<< HERE
>                  union {
>                          __u32           target_btf_id;
>                          struct {
>                                  __aligned_u64   iter_info;
>                                  __u32           iter_info_len;
>                          };
>                  };
>          } link_create;
> 
> This looks really nice and would be great, but that changes offsets
> for target_btf_id/iter_info/iter_info_len, so a no go. The only way to
> rectify this is what proposal #2 above does with an extra flag.
> 
> 4. Add bpf_cookie after link-type specific part:
> 
>          struct { /* struct used by BPF_LINK_CREATE command */
>                  __u32           prog_fd;
>                  union {
>                          __u32           target_fd;
>                          __u32           target_ifindex;
>                  };
>                  __u32           attach_type;
>                  __u32           flags;
>                  union {
>                          __u32           target_btf_id;
>                          struct {
>                                  __aligned_u64   iter_info;
>                                  __u32           iter_info_len;
>                          };
>                          struct {
>                  };
>                  __u64           bpf_cookie; // <<<<<<<<<<<<<<<<<< HERE
>          } link_create;
> 
> This could work. But we are wasting 16 bytes currently used for
> target_btf_id/iter_info/iter_info_len. If we later need to do
> something link type-specific, we can add it to the existing union if
> we need <= 16 bytes, otherwise we'll need to start another union after
> bpf_cookie, splitting this into two link type-specific sections.
> 
> Overall, this might work, especially assuming we won't need to extend
> iter-specific portions. But I really hate that we didn't do named
> structs inside that union (i.e., ext.target_btf_id and
> iter.info/iter.info_len) and I'd like to rectify that in the follow up
> patches with named structs duplicating existing field layout, but with
> proper naming. But splitting this LINK_CREATE bpf_attr part into two
> unions would make it hard and awkward in the future.
> 
> So, thoughts? Did you have something else in mind that I missed?

What I proposed is your option 4. Yes, in the future if there is there
are something we want to add to bpf iter, we can add to iter_info, so
it should not be an issue. Any other new link_type may utilized the same
union with
    struct {
       __aligned_u64  new_type_info;
       __u32          new_type_info_len;
    };
and this will put extensibility into new_type_info.
I know this may be a little bit hassle but it should work.

Your option 1 should work too, which is what I proposed in the beginning
to put into the union and we can feel free to add bpf_cookie for each
individual link type. This is actually cleaner.

> 
> 
>> Sometime like
>>
>> __u64   user_ctx;
>>
>> instead of
>>
>> struct {
>>          __u64   user_ctx;
>> } perf_event;
>>
>>>
>>> I decided to not do that in this patch set, though, to not distract
>>> from the main goal. But I think we should avoid this shared field
>>> "namespace" across different link types going forward.
>>>
>>>
>>>>>                 };
>>>>>         } link_create;
>>>>>
>>>> [...]
