Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CE052ACE7
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 22:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiEQUoP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 16:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiEQUoO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 16:44:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F8F52B07
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 13:44:12 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24HKFHJZ002129;
        Tue, 17 May 2022 13:43:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jwSUnntQfV+VB3PXBh5qnXuqR0rP4dHlrA1aTixj4K8=;
 b=NZ9vBE9Gk+2McnE0un+/wJFPIslLnhckE8bjuWWofUBfV+LHZbAI9FlLoer+1FM500Ne
 sPeeZnR6paYVARba7zVP7tdk95zNFaFAROIxI31qF9rF7qsS96afZmYeb3V5jDiavJr7
 T7fGpqTU5SGGymezS11cvCMJzqK3ptcbO00= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g283wmn3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 13:43:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKt91AGGeKZZy8Ds17R8z0ZsBRjLKmSJ3s2UfVPbASkPJLM7G7ZlmwhqQgUb68LHp3lX8kPYeZsnt+54T3r9Xr3sSEMW+Hc10LwflnL0KGgevVGNaMKkAWH6dCqCdxPcl3lvA33bI5rNBLFNeU420izLbzw/WKpzNyyoKVeTh0d95Dxs8MXZkgZ1+LUMSVMl7R86KtsfiH4iu7RWtVDh9/7+BxF33cWitIOat0WqMojv338MjgB3HHw7mdoG+/pjuVV5/jGVPF+U8H1aLQ2iYByaDVJzULEl1vKSvkpHYGg7hu2eBS5xvpMhM20XtUZmg1HgbSgZ88FO/5iWm3W7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwSUnntQfV+VB3PXBh5qnXuqR0rP4dHlrA1aTixj4K8=;
 b=DhIpKxD+YuyptY/qxDXc9FLPt7GPWpQ3FUmLnuXbjHwVYRv04E8TE3YUwtGt3d5p6MzChfKaaefXODcC3Iv9IFIb5YIrTzLrx9iHf6BZ2rnUPBB7zX1ZskfQkz8EX7gC7j9Lm6facb1mHUoV/NlN5XwxklJRh2+TCJGzIuIg6rkOsh18SZTp2rx/xk5RPgGGRFUEIouvVEVLV3MQzLMsT4XLsXFwsLbiQi6Wduf1Y867MlLAnakYnXdZS1NFlMB8F3Dz08K/lnUx51xr2mVZ9OW2K1IGnGtIZXh80g0rSZBDRz5mSPl8cDXChbbRX6SZgxmMgnRR2zwrRoSuF1q0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL0PR1501MB2051.namprd15.prod.outlook.com (2603:10b6:207:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 20:43:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 20:43:52 +0000
Message-ID: <6562d7d5-74d3-a091-4615-fd2d10ef1cae@fb.com>
Date:   Tue, 17 May 2022 13:43:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add tests verifying
 unprivileged bpf disabled behaviour
Content-Language: en-US
To:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, keescook@chromium.org, bpf@vger.kernel.org
References: <1652788780-25520-1-git-send-email-alan.maguire@oracle.com>
 <1652788780-25520-3-git-send-email-alan.maguire@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <1652788780-25520-3-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 977926d6-e6bf-423e-da41-08da3845f3e6
X-MS-TrafficTypeDiagnostic: BL0PR1501MB2051:EE_
X-Microsoft-Antispam-PRVS: <BL0PR1501MB2051942DFEE641D5FE249408D3CE9@BL0PR1501MB2051.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcvcIpwgNLZ4gZ+LL/szlToJYYQ25qS4EPpRsOlzlFefvqtC1LcR2C+tEYMSF0mhIk5G/LwVrpSmLXWHnss3+lxW+xPIvJi3Raw1HKQY+H1Gn1aJ61Are5LcyLaiBUTdrVm8YHSgcNifm4pgF/mJfkBG71EWoHJaQb1w/iJNPWiIukyfkzs/jrcEYB9tww93dKPhJvT5pnyPC3ft4RVwn8LbCmdxPoyMhF5srR4TElPFkqxqHQXdza5EsOp7faFNDd3EijcmYP0raM9nFdYaK1qIG0aVSFu/vAsXdjjbW6VkobYC69f0EIhMHBDsr0yTdOg38q96YIYPizUxWZuuU1TMG6tyCAOqR8jcXrsnFUUyuV/xOtXKmZFbmDQWW7Hml+65CIHuEjrNT2/AnBT9zWu+wfMxsoZlovpU2Q6nBL947vM1ey41kaYYj1Q01hHf1nogaLvEcj4eHAXpwKfZbDVxFuEnousVhocq24r+5bwbxYAhvOs8vaDKSduQ9i1wxxjO8eAi1Mm1hn6fjXCl2uInXyTzSpFZgqBZ70Tb9V48GNJ0iKgizB+tmmpJkKyAa+BJ3Jx3N8aTOwQYT9bv3TJT3M6PxYMbp6ISDtR1nsTqcn1lUM/Gc5ymz9vYEyXxqIxues4TxcYNMYJaCdBvirmkX+BInEcYp9WH4Fqo8ZGjFsIV9pEjNlzwsEBJ3oF/rFengmWS7owWUk94RN0jNks9aI5XAEI2+w2k6+1kYG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66556008)(66946007)(4326008)(86362001)(31696002)(8676002)(8936002)(53546011)(508600001)(5660300002)(38100700002)(15650500001)(186003)(2906002)(83380400001)(6486002)(6512007)(316002)(2616005)(36756003)(31686004)(6506007)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2hydDUvcVIvNkJ2THJMRlpNSDc4OW1IWEM0MG91dnF4Tm01RklIMGo2WWd2?=
 =?utf-8?B?NDdLbkM2QUJEM1NySk5OeWtrOU1lWi9wSmRYZW1VekhpUGdPU00vcFBCNEFx?=
 =?utf-8?B?UGtzMnliSkpuZTdhZzdEaStQU0VnS2s4dzRDeTljeXUrby9TY3dvRXI1aGFl?=
 =?utf-8?B?a1dPbmIxSVh1NVdaS05DRC9FWHFtSlZGUmdia01vOFRqei9GSkZHN3pRcWh5?=
 =?utf-8?B?Y1pSRTZZcjl4MlpOMFkycjRLQlZ3bmNGZjJ4Q2FOL2txU3d2cEplMVZjMW5L?=
 =?utf-8?B?Yzk4ZG5nZWtPV1RuSFRxb3ZZWEdTTVAyT2twalhrYXorUHk3MEF0UCtlalFY?=
 =?utf-8?B?RmVtM2Vab2VlWXRqOHBvWDhJN0JuUlhvYlFtMFJ3S0d0bGNnYU9XUHI2L0Fz?=
 =?utf-8?B?V2UzN2ZmVUtZMk1GMmZFVmhvZng1VVVubXlETEZveW9IdVZxMjRmTGxHakNF?=
 =?utf-8?B?d2FGNGV5RzU1TzRRdDU5a0dyM2RjeG1rOXQvak5LZ1BGeFl3SkJZcUpwOVl1?=
 =?utf-8?B?MFdVOFRCZEVtK0oxSkVJaFFCUUllb0tmL2ZXcUQwRmxaZmkwY0xSUTQ4ODk3?=
 =?utf-8?B?TzhIeU1YbzNQS0Zwd0ExT2lueHg1UFM0a3JQRUNpWHN2ekI3UHFiU0hrOC8z?=
 =?utf-8?B?cWVwNVR1Qm82UTVGdURwYURmc01wNG90VVUvejBkckNha2VhbTQzZ1ZDSHVY?=
 =?utf-8?B?R0lZQnMvSUVjenFERFd1TjljOWRtcnJMZnQ4TlFIVmpPVU5RZTZDVjdDUW1X?=
 =?utf-8?B?Ry9hOXh2VE9nWnptaGhOT1ViYUMxRDYzQnJaQXl3a1VRWXdwL2dkSEhXUUZt?=
 =?utf-8?B?RGl0T0tHeEtadGs1ekJsV2cwL2xNZnNqM2QyK0dFYk02REhoU3pzRE5kTC92?=
 =?utf-8?B?NnNlaFZFM1IzYTgydVBkUDZPeUJiNnZ3WWpzR2Y3SS90RWJWb2lTenlFR2FJ?=
 =?utf-8?B?eC9vekFpWmFpbEp1cmgrakVpVC9WcnBmbWp2RVV6VURNaXJtWnA3cDFxQmtj?=
 =?utf-8?B?UEc0N2N6Q0FaZUljQklSNjNwOFhtTkdRZUl1M2VlTEdLTW1QZWhQUzNCQW14?=
 =?utf-8?B?eG5KNXVONXdoSE1oOTlIS29DTWJabXlScmYvdDdES1ZvNFRONzNUT3FWZW53?=
 =?utf-8?B?WlNuakpkQ2w4RXp2U0ZmL3FHejM0K3ZZUS9iTy9GY3IwL2h3R3hrSFJGMktV?=
 =?utf-8?B?OWtjODhnR3FVYVc3dXZqQ2Zxd2xWNjNyNVZPWFo3dm9MZmlyTENibHJXWERn?=
 =?utf-8?B?Q1dsYW4rUkF2Y2NVK0xvYVRUMWJIelU1bW1ObWlFWi9reVE0N0ZLV3J3L0tO?=
 =?utf-8?B?YVhIalQxbi8rcFIxcksxOTFyS0UxRC93cXFCaEs2Z1M2c0pnRUZRNmxhSlRM?=
 =?utf-8?B?NW43cTFmZUNSN3prOGpHbWZDQ1dQK1VSUkVGTUxhRWQza00weTQzODA2WDJV?=
 =?utf-8?B?eU9JSjVnbXJGUGRVQ1V3YW42UEY4aUFQYWxJZ1VZSFlWODZ5bGppMUpBWU9z?=
 =?utf-8?B?bVJaenp1NlFNSCs0MHpMU2tCWkJIK3d5SzZwU3JhYitOYmliaUl1KzdwRVlh?=
 =?utf-8?B?Y2U3OXFralRPT2JBMGFRRlptNzc4THNqMTd4akJjYW5hOXhUK0xkbnk1K0FL?=
 =?utf-8?B?MmdxZW1XUnJzREFpbGVnTUNJNkN4akRPd2UzbTBsWXYwbWRtWGxMT2F3WHVR?=
 =?utf-8?B?OXJEQy9oWUc5WUpWU3dTSlErNURySkJOWFhJZ0k2UW9qR2M5MWNrUFF1T0g0?=
 =?utf-8?B?S21QdlUwVzJlMlhkTVFBUDY5YTdwWDlLNzhJUG0xdzY5VnBudEJVUms4YTNL?=
 =?utf-8?B?Q0JjM2ZpKy8veHBiU1JVWWl2U2ZxeCtqVmJXVnBYNDloUStWYllMZVNoMzJl?=
 =?utf-8?B?dXhIWnA1QnhjR3RScmtIWDhFMWZDeWl3bmdVWnNpNjQ3K1plajh5aVBvODRz?=
 =?utf-8?B?RlJpOEF4YVNGTDRhVm1sTFEycFNmUTBkckVKTW9wQjY1eWg1MkJ1SmxHbGV3?=
 =?utf-8?B?UWtFekI3U3lrZkFuUS9XK2t3TTA1a0tqVVNpN3UwbDlxdHB1YzJOaEJwRnc2?=
 =?utf-8?B?NlJDREFIK1NwQXhYeEJQV2EzOG5oKzUreDEzODNHa1N4b0lQU1NFSkRnZXRn?=
 =?utf-8?B?VHV3MGZNeEtDVjNyNmNSMFJDOTg3U3l1ZEtKNGlFVm9GaUc2ZXBDR1lWaUpo?=
 =?utf-8?B?SUdncGJlSkFTWVZocUdoWnQxSzdTNWh1b1JyRXM5N3ZjUWMremRDR1Z3K2pB?=
 =?utf-8?B?L1p2dUhIV2VQMWdoTmxjb1ZTWmd0NUV3RWQyajVhaFdXbCsvM2xnVUorYUtT?=
 =?utf-8?B?LzhYRHFYUjVVOXZKdm1XekYybnNwL2sxazNZTU9tb3pMZGx5aEoxZmNMdWU3?=
 =?utf-8?Q?j/Hp8UDKO7IR0QB4=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977926d6-e6bf-423e-da41-08da3845f3e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 20:43:52.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohsshFxhrnXMMcONO3cqedwMQ7cnjfmWaCZam2QJfpoaz8ElD3I6pmuQoUdi6+XZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2051
X-Proofpoint-GUID: sAZfXM7D2ToUdaI2v1YBBXR0LIqgNKoK
X-Proofpoint-ORIG-GUID: sAZfXM7D2ToUdaI2v1YBBXR0LIqgNKoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/17/22 4:59 AM, Alan Maguire wrote:
> tests load/attach bpf prog with maps, perfbuf and ringbuf, pinning
> them.  Then effective caps are dropped and we verify we can
> 
> - pick up the pin
> - create ringbuf/perfbuf
> - get ringbuf/perfbuf events, carry out map update, lookup and delete
> - create a link
> 
> Negative testing also ensures
> 
> - BPF prog load fails
> - BPF map create fails
> - get fd by id fails
> - get next id fails
> - query fails
> - BTF load fails
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

LGTM except a few minor nits below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../bpf/prog_tests/unpriv_bpf_disabled.c      | 308 ++++++++++++++++++
>   .../bpf/progs/test_unpriv_bpf_disabled.c      |  83 +++++
>   2 files changed, 391 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
> new file mode 100644
> index 000000000000..7c58c4f7ecc7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022, Oracle and/or its affiliates. */
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +
> +#include "test_unpriv_bpf_disabled.skel.h"
> +
> +#include "cap_helpers.h"
> +
> +#define ADMIN_CAPS (1ULL << CAP_SYS_ADMIN |	\
> +		    1ULL << CAP_NET_ADMIN |	\
> +		    1ULL << CAP_PERFMON |	\
> +		    1ULL << CAP_BPF)

Not sure whether we could simply disable all capabilities
for this particular test since we know what capabilities
are need for bpf subsystem.

> +
> +#define PINPATH		"/sys/fs/bpf/unpriv_bpf_disabled_"
> +
> +struct test_unpriv_bpf_disabled *skel;
> +__u32 prog_id;
> +int prog_fd;
> +int perf_fd;

int prog_fd, perf_fd?

> +char *map_paths[7] =	{ PINPATH "array",
> +			  PINPATH "percpu_array",
> +			  PINPATH "hash",
> +			  PINPATH "percpu_hash",
> +			  PINPATH "perfbuf",
> +			  PINPATH "ringbuf",
> +			  PINPATH "prog_array" };

define a macro for '7' and used below as well?

> +int map_fds[7];
> +
> +static __u32 got_perfbuf_val;
> +static __u32 got_ringbuf_val;
> +
> +static int process_ringbuf(void *ctx, void *data, size_t len)
> +{
> +	if (len == sizeof(__u32))

ASSERT if len != sizeof(__u32)?

> +		got_ringbuf_val = *(__u32 *)data;
> +	return 0;
> +}
> +
> +static void process_perfbuf(void *ctx, int cpu, void *data, __u32 len)
> +{
> +	if (len == sizeof(__u32))

ASSERT if len != sizeof(__u32)?

> +		got_perfbuf_val = *(__u32 *)data;
> +}
> +
> +static int sysctl_set(const char *sysctl_path, char *old_val, const char *new_val)
> +{
> +	int ret = 0;
> +	FILE *fp;
> +
> +	fp = fopen(sysctl_path, "r+");
> +	if (!fp)
> +		return -errno;
> +	if (old_val && fscanf(fp, "%s", old_val) <= 0) {
> +		ret = -ENOENT;
> +	} else if (!old_val || strcmp(old_val, new_val) != 0) {
> +		fseek(fp, 0, SEEK_SET);
> +		if (fprintf(fp, "%s", new_val) < 0)
> +			ret = -errno;
> +	}
> +	fclose(fp);
> +
> +	return ret;
> +}
> +
> +static void test_unpriv_bpf_disabled_positive(void)
> +{
> +	struct perf_buffer *perfbuf = NULL;
> +	struct ring_buffer *ringbuf = NULL;
> +	int i, nr_cpus, link_fd = -1;
> +
> +	nr_cpus = bpf_num_possible_cpus();
> +
> +	skel->bss->perfbuf_val = 1;
> +	skel->bss->ringbuf_val = 2;
> +
> +	/* Positive tests for unprivileged BPF disabled. Verify we can
> +	 * - retrieve and interact with pinned maps;
> +	 * - set up and interact with perf buffer;
> +	 * - set up and interact with ring buffer;
> +	 * - create a link
> +	 */
> +	perfbuf = perf_buffer__new(bpf_map__fd(skel->maps.perfbuf), 8, process_perfbuf, NULL, NULL,
> +				   NULL);
> +	if (!ASSERT_OK_PTR(perfbuf, "perf_buffer__new"))
> +		goto cleanup;
> +
> +	ringbuf = ring_buffer__new(bpf_map__fd(skel->maps.ringbuf), process_ringbuf, NULL, NULL);
> +	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
> +		goto cleanup;
> +
> +	/* trigger & validate perf event, ringbuf output */
> +	usleep(1);
> +
> +	ASSERT_GT(perf_buffer__poll(perfbuf, 100), -1, "perf_buffer__poll");
> +
> +	ASSERT_EQ(got_perfbuf_val, skel->bss->perfbuf_val, "check_perfbuf_val");
> +
> +	ASSERT_EQ(ring_buffer__consume(ringbuf), 1, "ring_buffer__consume");
> +
> +	ASSERT_EQ(got_ringbuf_val, skel->bss->ringbuf_val, "check_ringbuf_val");

You can remove empty lines between above ASSERT_* statements.

> +
> +	for (i = 0; i < ARRAY_SIZE(map_fds); i++) {
> +		map_fds[i] = bpf_obj_get(map_paths[i]);
> +		if (!ASSERT_GT(map_fds[i], -1, "obj_get"))
> +			goto cleanup;
> +	}
> +
[...]
