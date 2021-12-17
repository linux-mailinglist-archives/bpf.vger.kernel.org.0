Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3BA478562
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 08:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhLQHHX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 02:07:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhLQHHX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Dec 2021 02:07:23 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BH2tivL022421;
        Thu, 16 Dec 2021 23:07:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KjLa2RW8NQ5nMrkN492ACEsEq9voSsOeKVU4Ee+/eTs=;
 b=p/cb6UPsvjf24APBZpqruPy3hiKxbKLP6VTBl01pNp0Q6QiHeMH9ltzjS1BWsnWsd8AF
 Km7NlTM35aQLlQOBPBNXfWmJP6bhxJelX3b0l8IlPwev7efB/WlawXrQ5SapRqzc5WqT
 bdJt9P2GhFsEotxGSDFvIZJIc0Y/hs6j1Hw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d0j6q92n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 23:07:08 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 23:07:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR4tm/LpfaW7ITB6bjOOSM2iNOd6t9U7e++9gsv/Kt9IU7Bg4T9U0Nq06tQxpVUHMtzT9o28B0aNlyk6a3nMLDCD8B4S6rvccxNr4R+zU8AoxRfTgIcGjZ+KzbxPWUWZJO6qCxiB/iYTlGIQGuf0xkQbFyw5kpzTwny2C1+1M3SXguw/I7hhk+XcQezdcMdhrXlZOXVJVVe7edL3sPtbGO2BHIZxMpZOjgYateOf1LLih7HkfcwEL3pYXgE/94dK6TUHjr2UWoUjs/RKndwYOyBeDaz7wkQcICfW6R7ZfQ719DXaiuRD28tr9i6mjy7a5eq5OAUEfSdqkDpzImzgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjLa2RW8NQ5nMrkN492ACEsEq9voSsOeKVU4Ee+/eTs=;
 b=FVypwBycwhaIksDZfEx3Q36Ujx66fzwRw/eaPlHzE4XDlg26h35q+0a+t7yuiQJOTvaIqb/v9KmeS1t4nl6lbSMFH2P0x5lQIns1s7h/qB4RwyICEB8oQSY2VoMbegG9NBLJ1luyVhidGkQV3q/dc/GBiqMyL6nbj6H8VJ292AzmzIL6xQsdDrj5/cj3P2W76iC++cW7o05cS89ORgmxVEjDgLbtjjrHrfXzccWzOMH7Y0cixiiM3VQLGFIQJP6YAl+E6HzLbAEYMLbExBMzkryGcijA5o2SyEiCN+/QpgBsQMkLU1g7vZWlLNbwirqiduruJKxYSzt6QUpwyU9Agg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3611.namprd15.prod.outlook.com (2603:10b6:5:1fa::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Fri, 17 Dec
 2021 07:07:05 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%7]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 07:07:05 +0000
Message-ID: <4ae6ec7a-5149-bb1d-8edb-c07048e8332d@fb.com>
Date:   Fri, 17 Dec 2021 02:07:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH bpf-next 1/3] libbpf: rework feature-probing APIs
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Julia Kartseva <hex@fb.com>
References: <20211216070442.1492204-1-andrii@kernel.org>
 <20211216070442.1492204-2-andrii@kernel.org>
 <587861ab-e072-c448-c649-ddc6e51353d6@fb.com>
 <CAEf4BzYpxJKcXH9DGDT0J=f2jFa+_tAabz2j2+_kfYtdzcrkdw@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAEf4BzYpxJKcXH9DGDT0J=f2jFa+_tAabz2j2+_kfYtdzcrkdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: BL1PR13CA0444.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::29) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13bb89a5-f1cf-4d25-0233-08d9c12bd52e
X-MS-TrafficTypeDiagnostic: DM6PR15MB3611:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB3611D65530ABFE80ED649879A0789@DM6PR15MB3611.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tah1PSP3mrez61L0uc3pkHPNdlKzqe6dAaehAufKhud49tYThaCVkZfVQy6vdUkZ6LVEVT6soaGsqbh/4eqDugf4ZKSFZ+s3juccU2A/N+YlULMe/y5TjVJSFed9aktzNb7n7wCrZcW8hIbFTY6JzdSe/16DEPEldJt13Q1mI4U9JoGjYcz3YbKAek+sd3MhdMzkLmg9ToGtVUAX491NN4IoJboN+r16ODEm6DUgkLfIuBBP7ctHKUSd0s5VYp4iR9qyPFsBjA6oj8KIztrgqopBKy+VDyvOwTConr0wFlhpzXJlp5m2Jwua0pR5IhlL5vLlTzg+OCQTwciSE4amEEOfF9kPQBwolEspWRqbhl9PVSB1V1ULBRsU5iYvtSC8y7LWPX9gpPqOoEtmZYrsw9HxLH9zE88x/TAo+ngIER+Q7XhYoHoUX5n5pPQLuyVoGFnqZnVo8Sm16gaWLaXpuO4Qi8S3+0uQ+GxbSp9MFoiXfZPXOlzJK1UNZW/XXGQMADhT9Oc/DqQl+78qOnpv0iKbhQee5f9jjTsqE2MV84KK74crFn84HliriCz6EpT9FTNxHHczBH6SWdSBL/aj5QpLNIiHMZk/w00KJR1INpP1sFW5b4ClDYXbFSDShIiEaEJMp0coU+dewcYNlBj//ShcB2x9azWIZGTAGpZFH4HyfTEax1vinOJHttvCf9ZLYeq+bdRxqJjm5JWCJZdd9YK8hQD0bYCtmxAiL2FNA3c/cT7UTjfu04515yI022EGqG/llITwG4MkeR90TZ1mkqCpBmnah0jsok6Z2bNIrejt50BY/1Lz+KHyxVExCG7n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(38100700002)(186003)(26005)(83380400001)(31686004)(6512007)(2906002)(66946007)(966005)(4326008)(66476007)(508600001)(6486002)(66556008)(5660300002)(6916009)(8676002)(2616005)(8936002)(53546011)(31696002)(36756003)(6506007)(86362001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVVIWDYxNzlPUlRaRW0rcDFDNitsYmZYN1NGekgyc0JESUFyWkhQdkw2WWNF?=
 =?utf-8?B?MkNDR0MwWGgrZXAvajdsV3NoVTQ4S1hpdDNiR29yY2wwWndSd1hFUTFUV0dh?=
 =?utf-8?B?ZWdURmxTWVR6SmZZUHE3d3Jtc3lHRytSaVRXdndsRjd0Y1NBb2M4RjJtYjA5?=
 =?utf-8?B?NWI0T0gxaERFblhiZ0V6OTlkNWpjancwckZRKzNRR1Y1eHR0WG9DVEVXLzFj?=
 =?utf-8?B?TmphVWRIRzNTcXBwYzU4cVNWWmJ2RkxsMFJRMVYxemVLMDFxZDlqZHpwRzB0?=
 =?utf-8?B?a1NXcnhpb0ZQbTFMeUpqODhmMmgvRjlzSnFNcW1GL0E3Y3RIN21HbStCY0Zt?=
 =?utf-8?B?RUNweW5jcWlBZUU3Wm1BdHpXUzVkSGJUYVNvRTlqWHpiZXRTMnE2UGtpYlJl?=
 =?utf-8?B?cmc0R2dYWUI2WUFzMUNpdmdXOC84bEgwT3hSYkR2YnFVR21qZXM3MWZyeEFP?=
 =?utf-8?B?RlI1dkhQanRQaGIxUzNMZGlvWTZOUGZrMEVlQ1RxL2psNmh1RlNBeGR5cFdH?=
 =?utf-8?B?UW9CTzJmWGlOeDJVUVorM0dHdGd3ZHlqL2owdUc3Nm5MNXVtQzlKc3ViRmR5?=
 =?utf-8?B?K21DTkNYTjJiMkc2cWQ3Y2FWcHcxQms5NkkxUzhYQXdPd2VtQ3k2bmEyVjVh?=
 =?utf-8?B?UnlsSmZHekZROG5uNlhjOG5TMC9ZVlBaZnZMZFZxTjBUUWZodFJWMnZESVNN?=
 =?utf-8?B?YzhTU2Rwd0VpOXRNdXB1TFBxODRQQ0dUYXpmdzNLeWN1MkJqZm50MFFOTEZj?=
 =?utf-8?B?ZjlFVksrYW9nMXN1ZWtaeFZwSFNPRTBFRVhVcFZpNjhFMFdKS1gySU1jS0t3?=
 =?utf-8?B?UldHaFRhWFBOM2FwS3B1cStyZHBjWHFnM2V2WW1XRGx1QkgySzByc2hyTExF?=
 =?utf-8?B?R282WWF3MXJHZHVScGNxVXdqMThDV1J2QTlNVzIzM1JpYjJkZHQ4Uk9qRjB3?=
 =?utf-8?B?dW5FdzJSeURPdWFtMVB6Tm1ka3hqNXpqQW5jSUNBcUIwUW1ncXdBZUEySG9v?=
 =?utf-8?B?cjEvcmpZNnA5TmNNbmFpZXFBWEhUaWxOVEhyMlVNQ2J1bnFEd1lGak56RkVF?=
 =?utf-8?B?Vjhkd05pbmNVZHM3WFU4MTVzeldUTmNVOVMwMTYvMVBWNzV4Tm4wdzFXSkFT?=
 =?utf-8?B?cUJsaWdkY3ZGaDhXcUc1c2l0VnBPdFdQb3dIcHloWmZ6RHN0M2x3L2dQZjV4?=
 =?utf-8?B?US96Vng0bkxXNE9ZN2p3SzZwL1NUSHNoR2Q2dkhMR0pXR3cvWU9oSGZ6VFdN?=
 =?utf-8?B?MVg2b3BpL2NRRFN5cmVWLzBpYVIzN2lPdnRLcFNySTVmUzQrL0hNTWFnc1Bh?=
 =?utf-8?B?ZGJUeUNsN3pSK3lING1jVjFkcUNuQmVwVGRFL3JtbC9MU254dHNzV1VESWpj?=
 =?utf-8?B?amVPMGx0V3hoSll3N0hQaTIrdVF5cEIvdkJjbGk3NjE0VHdXOWFtUDUyWWow?=
 =?utf-8?B?dnVTZjVMYkd0WHBjb01SVzhLMThkV3RvbFJIUUxwd3ZlN2M2YnhzNkZURlpM?=
 =?utf-8?B?NHBMZlFaTUw4RkE1NElmWXZpYklYQ0NneE1lWkRWTXlldXIxUlhWSHRTY1NH?=
 =?utf-8?B?SzFBMzlwOWJRMDBZMlk0OWx4T1czaHhmbEdEOXp0UkZWbEZNREtHR3R1dWhs?=
 =?utf-8?B?NVlnRGlDdWt6Nmc0TlJ5blRFYk1qRWtEOUZTZzA3YWoxcWg3SDFZUGlxajhP?=
 =?utf-8?B?K3VHalNLVjAybEEyZmxQOVNqeWlhNzQzWm5DMGlGWTBZdGxrS0hIMmVjNzY3?=
 =?utf-8?B?RXJIZVZhTWF6eWVGb3R4WmNJV2JoakpyaHNLUExSM3Q1WjV0M3RZTTlqMXcy?=
 =?utf-8?B?SGVzNEhRQTF0UE1mc1dWdEdNZWowV3BFTTNOT1dreTg4YWVaNVNRdG1mcUNP?=
 =?utf-8?B?YmphQzJQcG5ZeXNTcytBc01pcTd2SyswZnJmYVlxMXN0RzNRclhleFBDdmIv?=
 =?utf-8?B?VTd1Tm9vMUg3bG9iR29HbjFXelJRYUJ4Rng4ZFdIbWNUYmZ5dk50TFNkSTN5?=
 =?utf-8?B?TXpiaEQ0RjhnUVJNSkpVVmcwQlJUcnZLR0doNDVQZnR3b1diZlgxcEYxd0xY?=
 =?utf-8?B?b05EMy9OVk5Mb2xmYmR5SnBadXp1aHh4cCtLTVFXNWVsbjVrRnBWVS9KbmN6?=
 =?utf-8?B?WDI1dTZIdENRRlp4Z3AyRENuR1lFRUp3bHBmakgzbzZJaFN1dkNpVmVkUUZT?=
 =?utf-8?Q?EjMA+TJzdH6LiAST18p+mpE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bb89a5-f1cf-4d25-0233-08d9c12bd52e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 07:07:05.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9MKmg0wDdPETlmnY9M90t5BcSF0hBW+hhkyBn2HtXKpsOL09DrplgSJBwgyUQ7MUYxrddCFyTJNVpnce2Vssg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3611
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 0NXJRtufUfm1D9pSigsd5vlwXm54tLf3
X-Proofpoint-GUID: 0NXJRtufUfm1D9pSigsd5vlwXm54tLf3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-17_02,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/16/21 7:41 PM, Andrii Nakryiko wrote:   
> On Thu, Dec 16, 2021 at 4:10 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> On 12/16/21 2:04 AM, Andrii Nakryiko wrote:
>>> Create three extensible alternatives to inconsistently named
>>> feature-probing APIs:
>>>   - libbpf_probe_bpf_prog_type() instead of bpf_probe_prog_type();
>>>   - libbpf_probe_bpf_map_type() instead of bpf_probe_map_type();
>>>   - libbpf_probe_bpf_helper() instead of bpf_probe_helper().
>>>
>>> Set up return values such that libbpf can report errors (e.g., if some
>>> combination of input arguments isn't possible to validate, etc), in
>>> addition to whether the feature is supported (return value 1) or not
>>> supported (return value 0).
>>>
>>> Also schedule deprecation of those three APIs. Also schedule deprecation
>>> of bpf_probe_large_insn_limit().
>>>
>>> Also fix all the existing detection logic for various program and map
>>> types that never worked:
>>>   - BPF_PROG_TYPE_LIRC_MODE2;
>>>   - BPF_PROG_TYPE_TRACING;
>>>   - BPF_PROG_TYPE_LSM;
>>>   - BPF_PROG_TYPE_EXT;
>>>   - BPF_PROG_TYPE_SYSCALL;
>>>   - BPF_PROG_TYPE_STRUCT_OPS;
>>>   - BPF_MAP_TYPE_STRUCT_OPS;
>>>   - BPF_MAP_TYPE_BLOOM_FILTER.
>>>
>>> Above prog/map types needed special setups and detection logic to work.
>>> Subsequent patch adds selftests that will make sure that all the
>>> detection logic keeps working for all current and future program and map
>>> types, avoiding otherwise inevitable bit rot.
>>>
>>>   [0] Closes: https://github.com/libbpf/libbpf/issues/312
>>>
>>> Cc: Dave Marchevsky <davemarchevsky@fb.com>
>>> Cc: Julia Kartseva <hex@fb.com>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>
>> [...]
>>
>>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>>> index 4bdec69523a7..65232bcaa84c 100644
>>> --- a/tools/lib/bpf/libbpf_probes.c
>>> +++ b/tools/lib/bpf/libbpf_probes.c
>>
>> [...]
>>
>>> @@ -84,6 +92,38 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
>>>       case BPF_PROG_TYPE_KPROBE:
>>>               opts.kern_version = get_kernel_version();
>>>               break;
>>> +     case BPF_PROG_TYPE_LIRC_MODE2:
>>> +             opts.expected_attach_type = BPF_LIRC_MODE2;
>>> +             break;
>>> +     case BPF_PROG_TYPE_TRACING:
>>> +     case BPF_PROG_TYPE_LSM:
>>> +             opts.log_buf = buf;
>>> +             opts.log_size = sizeof(buf);
>>> +             opts.log_level = 1;
>>> +             if (prog_type == BPF_PROG_TYPE_TRACING)
>>> +                     opts.expected_attach_type = BPF_TRACE_FENTRY;
>>> +             else
>>> +                     opts.expected_attach_type = BPF_MODIFY_RETURN;
>>> +             opts.attach_btf_id = 1;
>>> +
>>> +             exp_err = -EINVAL;
>>> +             exp_msg = "attach_btf_id 1 is not a function";
>>> +             break;
>>> +     case BPF_PROG_TYPE_EXT:
>>> +             opts.log_buf = buf;
>>> +             opts.log_size = sizeof(buf);
>>> +             opts.log_level = 1;
>>> +             opts.attach_btf_id = 1;
>>> +
>>> +             exp_err = -EINVAL;
>>> +             exp_msg = "Cannot replace kernel functions";
>>> +             break;
>>> +     case BPF_PROG_TYPE_SYSCALL:
>>> +             opts.prog_flags = BPF_F_SLEEPABLE;
>>> +             break;
>>> +     case BPF_PROG_TYPE_STRUCT_OPS:
>>> +             exp_err = -524; /* -EOPNOTSUPP */
>>
>> Why not use the ENOTSUPP macro here, and elsewhere in this patch?
> 
> ENOTSUPP is kernel-internal code, so there is no #define ENOTSUPP
> available to user-space applications.
> 
>> Also, maybe the comment in this particular instance is incorrect?
>> (EOPNOTSUPP -> ENOTSUPP)
> 
> Yeah, I seem to constantly mess up comments. It should be -ENOTSUPP.
> 
>>
>>> +             break;
>>>       case BPF_PROG_TYPE_UNSPEC:
>>>       case BPF_PROG_TYPE_SOCKET_FILTER:
>>>       case BPF_PROG_TYPE_SCHED_CLS:
>>
>> [...]
>>
>>> +int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
>>> +                         const void *opts)
>>> +{
>>> +     struct bpf_insn insns[] = {
>>> +             BPF_EMIT_CALL((__u32)helper_id),
>>> +             BPF_EXIT_INSN(),
>>> +     };
>>> +     const size_t insn_cnt = ARRAY_SIZE(insns);
>>> +     char buf[4096];
>>> +     int ret;
>>> +
>>> +     if (opts)
>>> +             return libbpf_err(-EINVAL);
>>> +
>>> +     /* we can't successfully load all prog types to check for BPF helper
>>> +      * support, so bail out with -EOPNOTSUPP error
>>> +      */
>>> +     switch (prog_type) {
>>> +     case BPF_PROG_TYPE_TRACING:
>>> +     case BPF_PROG_TYPE_EXT:
>>> +     case BPF_PROG_TYPE_LSM:
>>> +     case BPF_PROG_TYPE_STRUCT_OPS:
>>> +             return -EOPNOTSUPP;
>>> +     default:
>>> +             break;
>>> +     }
>>> +
>>> +     buf[0] = '\0';
>>> +     ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf), 0);
>>> +     if (ret < 0)
>>> +             return libbpf_err(ret);
>>> +
>>> +     /* If BPF verifier doesn't recognize BPF helper ID (enum bpf_func_id)
>>> +      * at all, it will emit something like "invalid func unknown#181".
>>> +      * If BPF verifier recognizes BPF helper but it's not supported for
>>> +      * given BPF program type, it will emit "unknown func bpf_sys_bpf#166".
>>> +      * In both cases, provided combination of BPF program type and BPF
>>> +      * helper is not supported by the kernel.
>>> +      * In all other cases, probe_prog_load() above will either succeed (e.g.,
>>> +      * because BPF helper happens to accept no input arguments or it
>>> +      * accepts one input argument and initial PTR_TO_CTX is fine for
>>> +      * that), or we'll get some more specific BPF verifier error about
>>> +      * some unsatisfied conditions.
>>> +      */
>>> +     if (ret == 0 && (strstr(buf, "invalid func ") || strstr(buf, "unknown func ")))
>>> +             return 0;
>>
>> Maybe worth adding a comment where these are logged in verifier.c, so that if
>> format is changed or a less brittle way of conveying this info is added, this
>> fn can be updated.
> 
> Not sure I want to point out that this is done in verifier.c
> specifically. What if that code is moved somewhere else? Seems like a
> bit too detailed and specific comment to add. I was hoping the above
> big comment explains what we do here, thought?
> 
> As for the need to change this, with selftests I added we'll get
> immediate selftests failure, so this won't bit rot and we'll be always
> aware when the detection breaks.

Ah, I think there's a misunderstanding. I meant "In verifier.c,
could you point out that this is done here". But I agree with
your point that this is unnecessary given the selftests added
later in the series.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

>>
>>> +     return 1; /* assume supported */
>>>  }
>>>
>>
>> [...]

