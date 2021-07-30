Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41913DB2F8
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 07:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhG3FuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 01:50:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24934 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229948AbhG3FuS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 01:50:18 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U5nweR010179;
        Thu, 29 Jul 2021 22:49:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Q8Li7Mpr2SfcyczA0GTJP+5BpxJfwlt72gI22AiRmxE=;
 b=VAEEgzCRgnhl31DbNre6+rvpljUsECKstAjQF4MoXyqfYay0w9XLiHVI5wVWOUwN+mfU
 HX2L6sRwC6Xl6ntEuCzB8Y9jnonY9eq04ssIT0B/Lw7o8MH+c1mgMVnLvN3TOFajoasT
 WCQAWaTrOpwCmMR9LtcrMiKAjFvnztSd50g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3bu9jtd4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 22:49:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 22:49:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD4gvlcbDz/wgy4d6l/B+VR/Ltyt6pj2EcCa1HvMTLPK8aDMwjEH7+WazeThtbQk4+TAeQrQ4i1u7lKAbpRH9ZKei3ICF7KFq2TUhPAqqpSqyDawQBEASIMlGCdgqjejVsKg6rmojJizvwhNGQxmZBeMteZyGVMJVVQjiy5FXkQQYZKrxRBSal5HbdHUpiWBnO6epxUvrK/co7VYIWQNWi0myg5sdCGx0jg/FDVQgo0VJFUUoqQqbbrle0lsd4p76+AdtLUDRzxyz91Kc6xOzXe3uEMDi6WKdluAD80jrmofC+zs2KW2letDLxy48JFxBGoiiXFoJdOTw3S+Lcnelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8Li7Mpr2SfcyczA0GTJP+5BpxJfwlt72gI22AiRmxE=;
 b=mMaoW6oCJGdsFa8MwKt4/6pxNynTHPBZ6KBW90OypPRd2gH56Fli7YFwQ+hHYFqS+4/Iq8k+G6mPqAkBBodISYFWBdw5Qpg9XYTVwMZMDmtqZA9RiHj7y/QSx/cQ2tuBENOVNYL2HGS/CEuca3vYcSIFBRGlvHKEYZ2XvNDX4cgZ1O2vy07aKd2P+LPHSt37gMERYrNzblkEIl7ioes2i9HEBLS2lRJWNr523hENYJhV1T1GIRdsBi8+KRCbC00mtGcOtoIWHpqsgARfUbcrV4KCW5595abgByOcDmwy/67rmEhVOQOl3TUsayvwwO5VWV7trf/dLk//Uv9pRh5xkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5030.namprd15.prod.outlook.com (2603:10b6:806:1d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 05:49:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 05:49:48 +0000
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
From:   Yonghong Song <yhs@fb.com>
Message-ID: <5ffd3338-fe76-2080-13a9-5102917a434a@fb.com>
Date:   Thu, 29 Jul 2021 22:49:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <CAEf4Bzb39v5kz1Gc2YjNvGwN8kK8H2fSp1qvipie=ZLpuxRV6Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1130] (2620:10d:c090:400::5:1fa2) by SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 05:49:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c371f1ae-e6a6-41c0-491d-08d9531dd748
X-MS-TrafficTypeDiagnostic: SA1PR15MB5030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB50306C93C9CA103AF958E6B8D3EC9@SA1PR15MB5030.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9uvJyFC313kTALVJVKjzq7ACxDWiKBB9bWCkMxWAQUg5hxv6JMUmGxTLd0jn9drR2IZKx5uaU7DRF+/NqThf5OlP6+XPYM256e46zCzQB75nQ8iQlBubl+nwuVW37/Vyd90H7PNtVbWyr5j5Mao0D7czuJL7wCm4lvJCxn6Vc6yN1Sw1YVN9N02a54DcHbx4sHJag6j6igGcMTdyI+A3/g8GbqG9G3AHiN1qJv8+Hv0F4Wcp99yu4FeRRh6sVbl4pn3q+ZI9lnjOCYN0PK0eXdToJReo/9/pxQoczuXRR4GNeA3VeolTSO5gUkP4GlZlO3X+Q0BzlBPGbn06BRT0IkSTMsOdlmfQAoTw70ajcKhC3bV7wYIwJwjNUhBFJ2JSNM7IuzF+BcpV0Gqwshfitjq1BpfFWK0J1IIQVAucGhFNUR5RLCASug7zrBzYrwP6LtGQgqOxTdkpatXxjhV6VngGLHpsXCdkU4FW30SvA3waCgIjxLuhlcdljM68pAKpW/luzzJf5M/lTqDBxQjt8C56QXJVCPDhaI4ah/iiKXjeHGLQUdBD7QIR0WIghiezF1Z9JnJLcN0qlCTPa8Ll9gu5S6KnwW47spIL4TDioIBA8maatbK9geCiAFnXSzAUsdX5DoRF7sBUGv8xSpf7J4SeyYNVC6t9oyx4mAHFOa18e2d3d44FlIS5vWsIbzSJPoyKsaYIYkKF8ZwcbRq2sQ2ZHoPgL4xdS4nqlIXDnRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(186003)(83380400001)(31686004)(36756003)(6916009)(4326008)(86362001)(38100700002)(66556008)(66946007)(66476007)(6486002)(2616005)(2906002)(8676002)(52116002)(31696002)(478600001)(53546011)(8936002)(54906003)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVvVDJiQkpOelBPZGhxbC9abUUvY1RrcXFNZkl3ZGlxV1BKeGJnTGNmazFs?=
 =?utf-8?B?YkJ6L3hKK2JPSDV0K1UrM3hxK1pGWCt6VEtnTmR3bDhld3BMSkdFTTVXZHph?=
 =?utf-8?B?d2I5TklXdlhjeUJmRkpEMWlRVkZZS1JTNWp4SmdwMThPU1hXOE56Q3NoR3dJ?=
 =?utf-8?B?aXEvb1hXN2JucTcwQWFJNlFvUkduOHJFOHJpclZYVEpGSkh2dndwM2tGdnpF?=
 =?utf-8?B?QkgvTjRsQXJtd0x1bnE3Sm1aaEUxYVdmU0FxMkdYTzVLNENoNS9zbkxKUVUz?=
 =?utf-8?B?MVVSWU9XYWowUmdrUWoxRkJGYXY4ZmpadGpDdlNkZys5dG5WNTZ1UHVKZXVN?=
 =?utf-8?B?czVTT0JLUGtzaUllMy95ZUMzYkczcTZTaXlaSVE4eENjYXlyK3RnWVFmVU8y?=
 =?utf-8?B?RmM2dURHWGZ3WlF1TjlEMk9TdHl4NjNySEQrVHZrOUFaaHZIUS9FMnJpcEpB?=
 =?utf-8?B?MDc3aUs4eGRmejdSM2E2eFptaE8rZkxkenpzaGVIYnl4S0NTTTFWcUhTUjNm?=
 =?utf-8?B?WVNTOHRKUWFlQzQ1RjZCaWluYnpHb2Z4U1dpWWs4N3NROGM2K2tjbnNRb2hT?=
 =?utf-8?B?c05BeVFjdlAyaythYmVSVXp2QnlGQ1o0cDRRTnVNMm04eHpaS01qTW5TalBF?=
 =?utf-8?B?cldGOVcvN1dwWFV4TVBzRmw5NTZRR2lCRWFVa3VFK29jL01LSUQ3d2dIdDB5?=
 =?utf-8?B?eGtHbFlUbDlxT1lPOVlocklqZ2krOXl3Mnh0dTZBcDFCa3FucnJYUFVmYlRK?=
 =?utf-8?B?RGhyK253YnBTSjFzMWZIZXpjNmdUOXNwU3hBSWx3dkFYNlpkOEw3Z21YcTNO?=
 =?utf-8?B?SDNvcFZJUFRxbk1Ic0NvaTB5cWExajdDWjdMMU83S3NweUk5WGcrRk1SS1Na?=
 =?utf-8?B?Mm52U3ZsNzVhbUhSRkZtY2V2NEtTV0thZStkdExmVXNiUW53Q3B2dHBzazFQ?=
 =?utf-8?B?SFZrV3B3U3l4QUVBczBlM2VkZFhlQ0NFSGZsTldyR2xyOTBZRTZmZi92cDEx?=
 =?utf-8?B?SUdud284bFBXeEZQWHY0VllobDFWZ2VsL283ejN6c2U5eVZsQ2o5bjZqSFkw?=
 =?utf-8?B?UXY2Z3F6NkdHQ3JQRzJ5bk5ibzVMeWhmajFCQmc1d2FndWVBNzFVYUtIb0RY?=
 =?utf-8?B?Umh0V1JlTlBRTTI5dkNBeS9rNkNlNGFpTlpkTlhqQUFSbGcrbWllTDUxQ0dn?=
 =?utf-8?B?TGg4YkcrZlgvaVJDY1Z5Q2E4UmNUSk15ek1JT2loWWpXUTVqN3FHcU01emFB?=
 =?utf-8?B?M2xkbnR4OUVjdjViSW1YdndUVDc1Y0Mva1Zlc1FYVHp3OTYxenBwOVFkbXpn?=
 =?utf-8?B?Rm9ZNXA1UjIyNU1zK0tYZFE0dU5VMXdsOXNYM3h2ZWQzUTM0dUtpc1hBOStn?=
 =?utf-8?B?dnFsT0RVaWZPTDh4QUtYWFZWaWtlemlPTHFHczJzMTNuaTd2VkM0M2g0V0VN?=
 =?utf-8?B?elJxQWkxZUVaMnJaeWFWeDZGSVUwLzdXVkc1enorM0pqVm8xa2o0RStCcUxO?=
 =?utf-8?B?TVViSDBXbWtWMDE0MTUxNnp2MWR1MmUvQWlZR1RMbzVJZUJpbjY0ZllBM2Rn?=
 =?utf-8?B?emFpUFNmdkRDVy9nNi9rV2pPaHoyekxYY1R0VCtFWGIvN2FJOEFKalA2dmho?=
 =?utf-8?B?Zi9DL05ZMGRMWElLdStBS2t1YmVTUTR5SlpUaTJPdkdIb21naUtWMk1zVms2?=
 =?utf-8?B?MnN2T3M2L21mM0g4NSt4NWI1dGFZSDR5eXJHYk1qRkR5VUVOOHh0MjZBbVNi?=
 =?utf-8?B?TXJuZW9VUkNWUTYwclJvQnBKOGI5TmdSdnl4K0NlZkR0dThiaVhzTFdidE11?=
 =?utf-8?Q?T82kIR8FezwVPeY2zXXZvjS1QK8YSGrNFrq5g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c371f1ae-e6a6-41c0-491d-08d9531dd748
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 05:49:48.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1v8AuBKmF58V7FK5XZ6VG6aalTlyMX8UrvUhxf8EGqfD5xzOsMXE0nGzqBOMI4Yw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5030
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: yLuyMZb65JHZtGGpTxKvygfw2LYum6XI
X-Proofpoint-GUID: yLuyMZb65JHZtGGpTxKvygfw2LYum6XI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_03:2021-07-29,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107300034
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/21 9:31 PM, Andrii Nakryiko wrote:
> On Thu, Jul 29, 2021 at 11:00 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
>>> Add ability for users to specify custom u64 value when creating BPF link for
>>> perf_event-backed BPF programs (kprobe/uprobe, perf_event, tracepoints).
>>>
>>> This is useful for cases when the same BPF program is used for attaching and
>>> processing invocation of different tracepoints/kprobes/uprobes in a generic
>>> fashion, but such that each invocation is distinguished from each other (e.g.,
>>> BPF program can look up additional information associated with a specific
>>> kernel function without having to rely on function IP lookups). This enables
>>> new use cases to be implemented simply and efficiently that previously were
>>> possible only through code generation (and thus multiple instances of almost
>>> identical BPF program) or compilation at runtime (BCC-style) on target hosts
>>> (even more expensive resource-wise). For uprobes it is not even possible in
>>> some cases to know function IP before hand (e.g., when attaching to shared
>>> library without PID filtering, in which case base load address is not known
>>> for a library).
>>>
>>> This is done by storing u64 user_ctx in struct bpf_prog_array_item,
>>> corresponding to each attached and run BPF program. Given cgroup BPF programs
>>> already use 2 8-byte pointers for their needs and cgroup BPF programs don't
>>> have (yet?) support for user_ctx, reuse that space through union of
>>> cgroup_storage and new user_ctx field.
>>>
>>> Make it available to kprobe/tracepoint BPF programs through bpf_trace_run_ctx.
>>> This is set by BPF_PROG_RUN_ARRAY, used by kprobe/uprobe/tracepoint BPF
>>> program execution code, which luckily is now also split from
>>> BPF_PROG_RUN_ARRAY_CG. This run context will be utilized by a new BPF helper
>>> giving access to this user context value from inside a BPF program. Generic
>>> perf_event BPF programs will access this value from perf_event itself through
>>> passed in BPF program context.
>>>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>>    drivers/media/rc/bpf-lirc.c    |  4 ++--
>>>    include/linux/bpf.h            | 16 +++++++++++++++-
>>>    include/linux/perf_event.h     |  1 +
>>>    include/linux/trace_events.h   |  6 +++---
>>>    include/uapi/linux/bpf.h       |  7 +++++++
>>>    kernel/bpf/core.c              | 29 ++++++++++++++++++-----------
>>>    kernel/bpf/syscall.c           |  2 +-
>>>    kernel/events/core.c           | 21 ++++++++++++++-------
>>>    kernel/trace/bpf_trace.c       |  8 +++++---
>>>    tools/include/uapi/linux/bpf.h |  7 +++++++
>>>    10 files changed, 73 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
>>> index afae0afe3f81..7490494273e4 100644
>>> --- a/drivers/media/rc/bpf-lirc.c
>>> +++ b/drivers/media/rc/bpf-lirc.c
>>> @@ -160,7 +160,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
>>>                goto unlock;
>>>        }
>>>
>>> -     ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
>>> +     ret = bpf_prog_array_copy(old_array, NULL, prog, 0, &new_array);
>>>        if (ret < 0)
>>>                goto unlock;
>>>
>> [...]
>>>    void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 00b1267ab4f0..bc1fd54a8f58 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -1448,6 +1448,13 @@ union bpf_attr {
>>>                                __aligned_u64   iter_info;      /* extra bpf_iter_link_info */
>>>                                __u32           iter_info_len;  /* iter_info length */
>>>                        };
>>> +                     struct {
>>> +                             /* black box user-provided value passed through
>>> +                              * to BPF program at the execution time and
>>> +                              * accessible through bpf_get_user_ctx() BPF helper
>>> +                              */
>>> +                             __u64           user_ctx;
>>> +                     } perf_event;
>>
>> Is it possible to fold this field into previous union?
>>
>>                   union {
>>                           __u32           target_btf_id;  /* btf_id of
>> target to attach to */
>>                           struct {
>>                                   __aligned_u64   iter_info;      /*
>> extra bpf_iter_link_info */
>>                                   __u32           iter_info_len;  /*
>> iter_info length */
>>                           };
>>                   };
>>
>>
> 
> I didn't want to do it, because different types of BPF links will
> accept this user_ctx (or now bpf_cookie). And then we'll have to have
> different locations of that field for different types of links.
> 
> For example, when/if we add this user_ctx to BPF iterator programs,
> having __u64 user_ctx in the same anonymous union will make it overlap
> with iter_info, which is a problem. So I want to have a link
> type-specific sections in LINK_CREATE command section, to allow the
> same field name at different locations.
> 
> I actually think that we should put iter_info/iter_info_len into a
> named field, like this (also added user_ctx for bpf_iter link as a
> demonstration):
> 
> struct {
>      __aligned_u64 info;
>      __u32         info_len;
>      __aligned_u64 user_ctx;  /* see how it's at a different offset
> than perf_event.user_ctx */
> } iter;
> struct {
>      __u64         user_ctx;
> } perf_event;
> 
> (of course keeping already existing fields in anonymous struct for
> backwards compatibility)

Okay, then since user_ctx may be used by many link types. How
about just with the field "user_ctx" without struct perf_event.
Sometime like

__u64	user_ctx;

instead of

struct {
	__u64	user_ctx;
} perf_event;

> 
> I decided to not do that in this patch set, though, to not distract
> from the main goal. But I think we should avoid this shared field
> "namespace" across different link types going forward.
> 
> 
>>>                };
>>>        } link_create;
>>>
>> [...]
