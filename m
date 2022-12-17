Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A53B64FB59
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 18:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLQRin (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 12:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLQRil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 12:38:41 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF6B11456
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 09:38:40 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BHENElX029018;
        Sat, 17 Dec 2022 09:38:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=VGtirYJXtkbwiFxyVwBZB8vjlycksOihDdVBA8u6BoY=;
 b=ahSlkBwRF3l/uQ42/f2DfU1fPpyTYQPtihTUj8nf5qZMn1th8d8paYBQDUpNsY+01wEe
 lzw9e74KqpQDGXVODn4a+KYfbyZ0hCAe61UUljLUHPGYrbvJnDNNcH2YPc/KcroNNn52
 2/6CNeCRYUKgUA+V5T7pkhZBOZqKg5ZV5+0bJZZO6Ba3BXxIJ6oTH9LkzDmr0CkPWVXQ
 WuYHEbeGfQK05E/UivrZEqjAig7/iUxRkxj8JrSFjs55KjVAdQ4urMk30F/8lWnR/9S2
 dOggT3IjUJQKhYwtt42LLfikJFCm5swHWrOh5ZIQxaTZWfj7mZA3rOamr+JmemB6W5BI cQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mhcbsruy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 09:38:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEi7/JTsiIC4w9MTA2ZbC2NJnachtTDbQjPEZMLz2fc78LWE2/bIyswv647GgdNq0NQQF0muOciznrj3EnYZSsZRyyXRGkJikLTMkf/VMpSneJQCbNEP61/pp9qAqG0ZkNZWixXkOySHxIrL4uRGlVjHFgc8YX+SBJCfmZmZJT7e7RySOw+rpzntsmmGdZPKwj2HtbhOnVc+tU2+kR7EYHUfpIa39lDYXM9MkQh4D8wbzPCIV+V5nHO/iKwmqu+v3c4i6arb+x5hw0JsjNmT79Hb2dqiO1kQCwrfL9f0PBtwqhvqgyEE6ywj8Y0PughBwJtPlSMBCM2PBpSAjBecCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGtirYJXtkbwiFxyVwBZB8vjlycksOihDdVBA8u6BoY=;
 b=jPMDJhUoVTEQ0jcFUfR6rT5oEIOw5TVX4DxcacrjfEp05TS5I+kAkCfMM+8mWUtRkpDEOLEO7z5U6M+4oDpTnDeXNGJPSkZ3hZjDgG2Kh9rMwokAil2khIZQpaTxfLbd/DB13XTHHxy0GknQYyst5nb9o+kDor4yMsvlLVwYbH9xf3Hggq+yBrKe4iYx8F933adRrMZkTi3JP5zUZS3VO9eU3HTJTcGDUUn7jlFOg0bBW4nw3jbORuan7LMJ1WkgBtyAyOJK4PAyKY2MBGS9+1p4Ijbs5w/EMv/DBQ91KgyWtXUu19fDG+IEzPwO8wbrlyhkdjoCxXCkyXQWHv/aCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1240.namprd15.prod.outlook.com (2603:10b6:903:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 17:38:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 17:38:00 +0000
Message-ID: <ad206ab9-27f6-d08e-b215-2ceda94fd2bd@meta.com>
Date:   Sat, 17 Dec 2022 09:37:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [bpf-next v2 2/2] selftests/bpf: add test case for htab map
Content-Language: en-US
To:     xiangxia.m.yue@gmail.com, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20221217150207.58577-1-xiangxia.m.yue@gmail.com>
 <20221217150207.58577-2-xiangxia.m.yue@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221217150207.58577-2-xiangxia.m.yue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY4PR15MB1240:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b06520-003a-4d77-af23-08dae055716a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+SZvKzZM2NU2iYPl1kojZ/aiHHoM8Oer7bUJiwVPfdNiw6Bl3faoe4UENaloRTItpYY1rEzfnBazY17KRG7Zzg/oeW1rPQJhkll9Ux4NQu/+khWkKAxrbA86NboN4cZTrsem+w4rXLKDIgGU1VRNYyCLBikAWPmFc5NUPT6sBeLaB0C8HYYPUSJ7wIQkAYexr2EPwUBGZDyz7zBWwZLJMntLrLtgo4WdaU9Vz5Qu/6eJ7t0s6vfhfiXgkZ3NK51Gb3mK3hZoNvGF0E6JtXnOHDRB318VF1xGvNVNPcfiUo9mPl3EiMsYEssLnh3XkZ0swecWFN0BXDeyn94lxGfljOSMuZ2DmxIYjgTGe7v/Sj6MXitKOumv5X+1I4MvWvt14UPPMvpYyM9JqB2WatKhe5rI7DDYI9IhPZwmUPW31XVc/NhzDO0389p/6Xca+JK98iLXvOSifRhlhVO1KUgzsnFENL9tDCAk+wSOW6HKXuTvpA0duNKEqdw++CJH6qsMQyixWyBZ7GqyACUIyXsxxpX8l21ecey5a8/l5IPj2Cci7YSMf6pLsg4TBXR/LEWatAgsJZ51EtHdKhT+bzDWbYyJ3mEPC5itEwguEiTltEPz9yhWS1eFvcxV2GE9yOsc3qC5QGDX1U91xdTlaQHjfStm9HjNPE+X6W161G3EXS3NQxI0VIhrPSybQQyCWGqPWhQz7pJAZ1xUEaWA51Bst6KORr+0WdMtRKfixPuOL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(31686004)(2906002)(5660300002)(7416002)(4326008)(316002)(54906003)(66946007)(66556008)(8936002)(8676002)(66476007)(36756003)(41300700001)(6486002)(478600001)(186003)(31696002)(6506007)(53546011)(86362001)(2616005)(38100700002)(6512007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhWN1lXUWRNSDdieXdIcS9JdUNLblNZTGxkbktUWk9vY2xtTjJibUpCQmhz?=
 =?utf-8?B?MDdYSklvMmFZRVJlc2JLa2MzdXNIRFdGM2d0MzJaTERLM0RneXMwd25Ua3do?=
 =?utf-8?B?d0svQVNKQXhIWkJpQlBTVllUNHpGRmw4Nm9jWFhXNDdVZVoxZElVZmVhRzEz?=
 =?utf-8?B?RElJOUxWbFFRUm85WXR1Y2t0WGRDVnhVSGN5UHZpb3lIYmpBbElvUzF1RS9q?=
 =?utf-8?B?MW9HWlVRSm5tWU5zS1JDKzFqVkJVeDRtT2FJM2hNaVlaRk9wdkZxWmlQRUE0?=
 =?utf-8?B?WUI2ZHhCU25McVY5dExXaUxkbmFGTW9xNnQ1QlBGY2x5cStKekZDTUJwVVpE?=
 =?utf-8?B?SUhPV00zVllOU3NtTWx1eGxaNUNWZUI4a01WSC9abE1nWG91WWVmTnhrWWg5?=
 =?utf-8?B?OVNQMWorNlJkcGk3bmhyWDFuaHE1a3gxU0hpUU5RR1lXMmhhWUVrOWlWSWMr?=
 =?utf-8?B?VzQ2SENyM1B5alJtQlh2RzZ2cGpjN2ZYZnJZdkZKZXpZckt1RzRZL1J0ajQ2?=
 =?utf-8?B?UmRCemtoQS9oQWVvVnUyTU1HWkU5RUFzNUJXRUh4cW11T3FhOTN2aEdicHFl?=
 =?utf-8?B?cnowSUYzWlVsWVhIdjNjY3FOQmdkeVpHRW1qcXhWMjF0WmY4WkhsTjRVaThP?=
 =?utf-8?B?engzYXNGVnUvTFpjQlBHQmJWWWg3VzBLaUdTOHJCc1VSSUFvODQ0OGZJcW9R?=
 =?utf-8?B?Q0JLcXJZL2xJZ3h2c2w5K0xXNWlzRzBlN3pDcDBkUXZLY0sxOVI2Zmo4U2dR?=
 =?utf-8?B?ajhseHlneW5WbEkrclhMMWx6T1orZ091dnh2WWQxUjlhZkxDVU9IZmRlS3ZX?=
 =?utf-8?B?RktTVzdLMmxzeU56RXgvTmtoTEd6amxiTXUwSjlmbGlQeFYrZmtDWXVOYWFj?=
 =?utf-8?B?QmRFeVpFM2pYQ2JkTzRTckNOSzlWc3JsMHlHNWdlamVkNEQ4QkZleG5XUGVV?=
 =?utf-8?B?Y2xORERaK2p1RHpKTEpGZTh4MXlHNHU5S2dYQmFMOW1tVnNjZW5ObUV4d0FC?=
 =?utf-8?B?cWtBUFR4NW5pL1FVR0VJdVNKekwvalFsZ1hPNCt3VnVBVjREYWhPZGdFOWVF?=
 =?utf-8?B?TG1jZnVJai9tMmdMTlQ5c2lJbjZCUG83RmJKUkU1NVo3akw3TjFVdHR3Z3N4?=
 =?utf-8?B?MSt3K05sNDlpQUI3L1NET2p2dWVwQlJZZnlEQmVxUkZmS0IwL2c5SERFWE1D?=
 =?utf-8?B?UTgydFY1bWlwMjZIVmQ1MGQrM1pQdW5NcnNsVXhabkg2UW5ZbitGLzQ1R2dt?=
 =?utf-8?B?SGpGS3NJQUZGd2ROR1FMMmpRb0UzVEpEOWY5SmxnQnVNa09teUpoMndQdjZk?=
 =?utf-8?B?TUE2NlBXdGRTSFUvdFhPeDFhTnFUdjZqRlY4bXFkVGVpdWU4cG1xQVBnNVN5?=
 =?utf-8?B?VXk2SG5GYi9VOHc3QTFXRGhsL0RDVHprV2sreWU3ZUNPTm5UTWZsNjlveGFt?=
 =?utf-8?B?Z0dqeDVQcVQ0WGd3NHhTRWk2M0Ftb1dZbGNld2YycEFueXlrTHBaNWdIV0Uy?=
 =?utf-8?B?ZHFIeVhJVm94VE9md0lTS2g4VEtqaWxBdDU4MjczTDlQdkRJbUVSNWlpQXVZ?=
 =?utf-8?B?Y3M4a25mRHBPZVJGcVVBcGk3ZzN2NjF4WkY2N0VXZnBPVGxKMDJldVFsM2Iw?=
 =?utf-8?B?aW9QR1lnTmVGMERaQU9kODBYM2pWQzZSQWx2VDh1cVBiMlBSRWRrYjA1QXBJ?=
 =?utf-8?B?eXY0Qnh3U0s0VUNXbm5ISzE1U0Nld1NCNjJNQkp1ckZ4a2R6dnpwajdPWUZP?=
 =?utf-8?B?TkhhaE5jMC9YdGVId0RHWHEzUlpzOFhIUWxpVEc2MkppZDU0d3FabkUra09n?=
 =?utf-8?B?SmNmV3JYOGVKZllaT1BtNlZwdVl5NWRiMVVZeDNKRkhVMXBHb2g5bURnbkNY?=
 =?utf-8?B?MmRoZ29YeDdiRjdmdUxUYkVWa1NzczBKcW5tallTYnJlNWQ0czJHNmVrUFNh?=
 =?utf-8?B?MVVzak9iNEUzUm5FQlZjV1Y2Q3duRHVhcERCUmNlYllIWkRaL2psOWd1Z2JW?=
 =?utf-8?B?U214Z0piSlViN0Z4T1hiL3RaOEt1bzVsRkdiTHNYVy9kejlVb3NJNVhtVU5s?=
 =?utf-8?B?WHFWWDk3c1RkejJkMnBodGdoQ3BoaVQrNmtEbnlVaUhmUWhEcnFvbUJCSjZV?=
 =?utf-8?B?d0xQbmU2WFFabnJ1QUYzbVdTSUZ3WnVmWGxjK05JYmt1dE8wQXlJZ01aeDdU?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b06520-003a-4d77-af23-08dae055716a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 17:38:00.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jOAk884dDHaXiqRiboSLfVzWvhp980UgtZ8DpCR1DLqimyh8wWFXFT6kTJVz8XJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1240
X-Proofpoint-ORIG-GUID: sEowTj4cKDn5IBZVMGVtMfw4LNxZywrD
X-Proofpoint-GUID: sEowTj4cKDn5IBZVMGVtMfw4LNxZywrD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_09,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/17/22 7:02 AM, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> This testing show how to reproduce deadlock in special case.
> We update htab map in Task and NMI context. Task can be interrupted by
> NMI, if the same map bucket was locked, there will be a deadlock.
> 
> * map max_entries is 2.
> * NMI using key 4 and Task context using key 20.
> * so same bucket index but map_locked index is different.
> 
> The selftest use perf to produce the NMI and fentry nmi_handle.
> Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
> map syscall increase this counter in bpf_disable_instrumentation.
> Then fentry nmi_handle and update hash map will reproduce the issue.
> 
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Hou Tao <houtao1@huawei.com>

Ack with a small nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
>   tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>   .../selftests/bpf/prog_tests/htab_deadlock.c  | 75 +++++++++++++++++++
>   .../selftests/bpf/progs/htab_deadlock.c       | 30 ++++++++
>   4 files changed, 107 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>   create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
> 
[...]
> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> new file mode 100644
> index 000000000000..72178f073667
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 DiDi Global Inc. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 2);
> +	__uint(map_flags, BPF_F_ZERO_SEED);
> +	__type(key, unsigned int);
> +	__type(value, unsigned int);
> +} htab SEC(".maps");
> +
> +SEC("fentry/nmi_handle")

nmi_handle() is a static function. In my setup, it is not inlined.
But if it is inlined, the test will succeed regardless of the
previous fix. But currently we don't have mechanisms to
discover such situations, so I am okay with the test.
But it would be good if you can add a small comment
to explain this caveat.

> +int bpf_nmi_handle(struct pt_regs *regs)
> +{
> +	unsigned int val = 0, key = 4;
> +
> +	bpf_map_update_elem(&htab, &key, &val, BPF_ANY);
> +	return 0;
> +}
> +
> +SEC("perf_event")
> +int bpf_empty(struct pt_regs *regs)
> +{
> +	return 0;
> +}
