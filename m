Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA974559F98
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 19:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiFXRZK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 13:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiFXRYy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 13:24:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EF4792B2;
        Fri, 24 Jun 2022 10:23:16 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OButmm008732;
        Fri, 24 Jun 2022 10:22:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=nVpm3oNC4GlWZ6RWtz+76JkXC7PyT/bitDj1zCKFsf8=;
 b=rEIEnacaSLaKo3TVGECG5fBI34cDTLekNcVvJdVn5ib2mEO8+/kP6SvK3V6RcpO6Zqj1
 t4v9DbC6fuLi9YcDLs1mOwocuIsbuSjd3IfJx5QNeJZd3KA6JqD0ZLIhBrIBi/QXw9dF
 gDI8wKpUmtrFnkRmpoPqpDbcsv5gxbc6oyw= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gwcu729kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 10:22:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD+5OxbydnKiXigc0Am/TFL8Z8/TAliddt+wgrjCnJCKOhmHBwaDv5o7hE1IX5BYidzOLzJCkUSvZ2FtCesLtgf+MzU/Rk3cXHqrDQkX1YP4Wbj4SIM4f0295eGRlxUjbuCgO+qSyq4koWrV7cgEYu8sa6Du0wpBJB+2QrApQ+wfsDwrslpEiRhUTCm4fi3XMRfHuD2S2O5pfW4AwXIFw0DtTTfm7kzxGVYvqafW+qkGhsj6xlbFFaephq3aCVKnbQGyrAudeBPUija/6c4xIw8hZ3lSR3kPwwK21AwsCzi2aN242fxBAkKaUxJuO6HyJmdoliNCIpl2KiA1IHFbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVpm3oNC4GlWZ6RWtz+76JkXC7PyT/bitDj1zCKFsf8=;
 b=b5bxjx+X1Evoq21NxhP3BtaRTX2sOOZ5Rr6M3QeG/K6dOoAVxm8+ZmjEIuoHnWjCKg5psQ6MI0EVWP7714Mc1/Px7NziA2SLn5ns6wBfnelZbLt6YhKbWCLcN0oQYpXCpjqDkqbRGIQAcuH473fpnVhNoklkay5FBmFsMJ8582cGTZPcwFjBUCck++qB4AjID+IHj5NyARrbnYr6YiCC7o+hAufMnCE+Wr/tn47XwdZ9gQTZinqlkfMcSjfEMCHAnrR7eni+zlRC3qNwFwkkWe3MDp7MlUqgH6fN0r7iF1cNJ5Jzh8h7Dz43Dwtbrzakb+V2KgrFwlloInh0bERGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4321.namprd15.prod.outlook.com (2603:10b6:806:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 17:22:41 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 17:22:40 +0000
Date:   Fri, 24 Jun 2022 10:22:38 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, rcu@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add benchmark for local_storage
 RCU Tasks Trace usage
Message-ID: <20220624172238.wpioajigxywd4hxv@kafai-mbp>
References: <20220623234609.543263-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623234609.543263-1-davemarchevsky@fb.com>
X-ClientProxiedBy: MWHPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:300:117::23) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 208a4136-0ab2-4332-aa13-08da5606246b
X-MS-TrafficTypeDiagnostic: SA1PR15MB4321:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxMzBllj8av5dN8p0HrH3VLN4mfY49lREASH6A5zmxN2yH2hSQsqQYVkA7llSBrnLsqCUCUhMP9RRfRT2T7+xM3eYfxpI+1uP8nOZo16ltwjqrYBvMtDgBgN8bBtSwPhhMdrrskNED3rgGObifefBMDEEzDCTRfmhTmjgln+N26aor0x7jQuNwDb7w1lDpflVtukEldv86qTtcC+T4KCV103uL86qabDYKlqJzSAzUx0DX7ST1ujboEv3J/tBDHC6MNqewb2I60Lu8BwhjZ2bxU+kH6Ekto0YPdtu494b1YG9uSk24NL/PKHmv9VaQ5zf9jIjizfgACPtbdXJ8bc8JKvnN1tuvFLXKWBnFAkeBWtoDeV6iPSnRcV3RmPpfN8YPPROYdb4kLatN9lSme+055TFmSGhOE19t8r7ADRp7GEFD53+czIGu0syQa7W6KO+nQ573pLv6GJ1D4pP84Ko1CrZTVG8nAI8XUI8smwt1UXdp+R8pRGXHw5Mn1oVPn6RBnOYxWkBVIaYSxk97HOxbSfUF0dns00VTcJDczAvkcyxB5Trbgh/5T+FCcPjlJ1teZ2XcL7YyVTG+ZF2OJnHnw6fb9t+qYyxdhp1z/QocMjKL/25AFjqvhuQaQ0QS83v9nbl6XFTzZBcxZNUhVuuAedq8TlikTon48AUMxKSKr5E2A4P7+vPeFnHzv8Abx/n24BHu6KQVcMkdTh0lNKNJ2XUwh9ay63H6kvkADPj8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(316002)(66556008)(8676002)(83380400001)(66476007)(66946007)(41300700001)(38100700002)(4326008)(2906002)(1076003)(6486002)(54906003)(478600001)(6862004)(33716001)(86362001)(52116002)(5660300002)(6512007)(6636002)(9686003)(8936002)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9EuQmhLkEthPVV43wZYh70leTk9CmB/DhyuDVcKYQQBf64JaEDAqNqDFdDKc?=
 =?us-ascii?Q?aFowpZCdNYFhbFI5bcbF1r7dz/mwtd48jkKy1el49f9IVULi51vnB3RJbDZk?=
 =?us-ascii?Q?rGilG1gZMmUvoOLaCfQ+sYqKcm/YvbKMC+egWrDcerHZVznNS9krDZapt3cA?=
 =?us-ascii?Q?TQc/rSxcRcW6vVQ1vbbt06GRrLUFh9VMrI0HMjiWjlsU6n66yxHkcsX68hD4?=
 =?us-ascii?Q?Dv5aAHxfA/VApBr/2KeWDFsQAOJcV/BKhW+aOhGOFIGwVRwLg4j6k8zf9VPx?=
 =?us-ascii?Q?vbMS5bvtpC7693kdZnK6lfhd5Dc/77JVXsSLdixTIjLFeFF7w+0KRomrhU4z?=
 =?us-ascii?Q?GYwfgTkhdp/QOGOd2ZXoxs8O6C7ruOz7woRfNMFyUZk6K2CWPj2pkHTy4qrK?=
 =?us-ascii?Q?N/aIxykO7/LViHrSr8Q2fNYk9X2Lc0YXpQnFmrpmThuqI6uuy635XnUAUa/z?=
 =?us-ascii?Q?/Z0894GeswesiBIxdCoM+M0mlqIPlD8DViMZqUF0EBpXHWLXVd0LJdMiq2tG?=
 =?us-ascii?Q?pQTnHrhyqZVnqKlt1VihdbgeSKvBScq+ERH5IG/XADpHc9d2PFmbM/JoNMDN?=
 =?us-ascii?Q?j6Ba8XWPrFYydz/0Wf3D4jhy3jOsg+cMZd4dZq6ja5NkIrGgMgh2mRe31M69?=
 =?us-ascii?Q?kSLgDJ97dDExnUyRgXnyRV0TIY499H/diWNdJKu6qdwcMSVusZRowqmMm88Z?=
 =?us-ascii?Q?0b1nr8fTZcTDBZT0eRXrWyZrO4v+9Z7hBr9DLsLxc/qCzULPxTapvrSKP8c1?=
 =?us-ascii?Q?NMcl9Q2SQqSXajRf0QCKhPxw+O9K/r523mJUz0QmM+UFSfxo8WOox3b3JHz8?=
 =?us-ascii?Q?bJMOsp0D8IADcSueW0wUDNTsxXnvuiFAUkne9NGVE87khTmAH1BcPhJIuUlI?=
 =?us-ascii?Q?niem9qYPQhSTgiP6Ehj1554SL9X2Jx5+iFq4LjhYowBqT3AQ1+rO2AvC+Eg/?=
 =?us-ascii?Q?X9fBYuGUyOSFXCs18n87StL9EbkNTejiVQwjdkm1jsLZwOawK4QeYIcmx/QY?=
 =?us-ascii?Q?gN6j2CD4FtEjTlU65QqwxlJskwT2qM8II6expVzdB0oDfZIA+aCS3QgSSyYN?=
 =?us-ascii?Q?25FUE2a5pTrM8LMam1vZGKgC0lbTo+isx9SVD8y8F/Rqb2IzLLDM8eppYbw5?=
 =?us-ascii?Q?opaQ1vY3ifFxh7oTvDeuk47k3dDgUqLzPXIMJr7bHg/i6Wd7cmhin/IebZ+1?=
 =?us-ascii?Q?Crr7Z94yPLwSaqpmHqR0F/FYSC3fuTWY0LqUQ3+nQ0c0YI5yN/npor223sjN?=
 =?us-ascii?Q?sB0v3QI84tK87Kfxxm/EYn17AkaY0M0nE7Zj6eR5X3yNtuoXJ+fpMOkOTgVP?=
 =?us-ascii?Q?H2LuraLJdU8zwdRGcWmRs5tzuPsuLMqM4zTM1myn45ytbTku9j+DUQU4H4C1?=
 =?us-ascii?Q?cxvsHJcN0OsHNmEYRa1XjIJ9mMsBvDO7dSni6aa51Xt9Hy94unr08tJafohD?=
 =?us-ascii?Q?b6eH07CLMqhaEYT6AUGgwhq/e5lZLcWN1xzwCBCPVR+SMXHIzd18MAVuLCsS?=
 =?us-ascii?Q?NDZemy0MGSieEg+Fd5x5/BkbJGhgW4YtRArosrcGd3fEDkdzss1vQxdqK1J7?=
 =?us-ascii?Q?oNStoB2Qgkao3ieXdqmhGdRAAPjZkdAx7USrC8t0jWYVVmgP7WaVUhP7ttpw?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208a4136-0ab2-4332-aa13-08da5606246b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 17:22:40.9205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+3xD3UhoPhPGzmkyObi/CoLvr6b1xH6Raq7bo5TaJ0IEfRKgw3GaQ5SChK0WCRR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4321
X-Proofpoint-ORIG-GUID: YzgqwdV9oeSSshpnFWMg5aLRaJhEGuWn
X-Proofpoint-GUID: YzgqwdV9oeSSshpnFWMg5aLRaJhEGuWn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_08,2022-06-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 23, 2022 at 04:46:09PM -0700, Dave Marchevsky wrote:
> +static void report_progress(int iter, struct bench_res *res, long delta_ns)
> +{
> +	if (ctx.skel->bss->unexpected) {
> +		fprintf(stderr, "Error: Unexpected order of bpf prog calls (postgp after pregp).");
> +		fprintf(stderr, "Data can't be trusted, exiting\n");
> +		exit(1);
> +	}
> +
> +	if (args.quiet)
> +		return;
> +
> +	printf("Iter %d\t avg tasks_trace grace period latency\t%lf ns\n",
> +	       iter, res->gp_ns / (double)res->gp_ct);
> +	printf("Iter %d\t avg ticks per tasks_trace grace period\t%lf\n",
> +	       iter, res->stime / (double)res->gp_ct);
> +}
> +

[ ... ]

> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh b/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh
> new file mode 100755
> index 000000000000..5dac1f02892c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh
> @@ -0,0 +1,11 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +kthread_pid=`pgrep rcu_tasks_trace_kthread`
> +
> +if [ -z $kthread_pid ]; then
> +	echo "error: Couldn't find rcu_tasks_trace_kthread"
> +	exit 1
> +fi
> +
> +./bench --nr_procs 15000 --kthread_pid $kthread_pid -d 600 --quiet 1 local-storage-tasks-trace
> diff --git a/tools/testing/selftests/bpf/progs/local_storage_rcu_tasks_trace_bench.c b/tools/testing/selftests/bpf/progs/local_storage_rcu_tasks_trace_bench.c
> new file mode 100644
> index 000000000000..9b11342b19a0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/local_storage_rcu_tasks_trace_bench.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, int);
> +} task_storage SEC(".maps");
> +
> +long hits;
> +long gp_hits;
> +long gp_times;
> +long current_gp_start;
> +long unexpected;
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int get_local(void *ctx)
> +{
> +	struct task_struct *task;
> +	int idx;
> +	int *s;
> +
> +	idx = 0;
> +	task = bpf_get_current_task_btf();
> +	s = bpf_task_storage_get(&task_storage, task, &idx,
> +				 BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!s)
> +		return 0;
> +
> +	*s = 3;
> +	bpf_task_storage_delete(&task_storage, task);
> +	__sync_add_and_fetch(&hits, 1);
> +	return 0;
> +}
> +
> +SEC("kprobe/rcu_tasks_trace_pregp_step")
nit.  Similar to the fentry sys_getpgid above.
may as well use fentry for everything.

> +int pregp_step(struct pt_regs *ctx)
> +{
> +	current_gp_start = bpf_ktime_get_ns();
> +	return 0;
> +}
> +
> +SEC("kprobe/rcu_tasks_trace_postgp")
> +int postgp(struct pt_regs *ctx)
> +{
> +	if (!current_gp_start) {
> +		/* Will only happen if prog tracing rcu_tasks_trace_pregp_step doesn't
> +		 * execute before this prog
> +		 */
> +		__sync_add_and_fetch(&unexpected, 1);
I consistently hit this:
./bench --nr_procs 1500 --kthread_pid ... -d 60 --quiet 1 local-storage-tasks-trace
Setting up benchmark 'local-storage-tasks-trace'...
Spun up 1500 procs (our pid 28351)
Benchmark 'local-storage-tasks-trace' started.
Error: Unexpected order of bpf prog calls (postgp after pregp).Data can't be trusted, exiting

May be there is a chance for the very first postgp being called
before the pregp_step?

Thanks for working on this!
