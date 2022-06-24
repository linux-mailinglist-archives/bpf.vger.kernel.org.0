Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D41C559FF4
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 20:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiFXRcl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 13:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiFXRcl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 13:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6B680B2;
        Fri, 24 Jun 2022 10:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16A17618D6;
        Fri, 24 Jun 2022 17:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6E8C34114;
        Fri, 24 Jun 2022 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656091959;
        bh=vP9uJk0EKFbrZXzpEvpw6W6A/ks81LKE4xc8kSO0JTI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sXPFR9I1ah99viD4QvpI6GNPjJW93V0lPeutBvGAmJWh8nppT79fsh0Ou8JxTLyeT
         Woo3/dnDrL7xKFzWB7I9/7+9g0G9fGI52dPfkaXrNulOftS5Bh8w10RFRlSxqDr36e
         JH25PhICNA8Z8JTw3OAYEM6au7otl0wponnKnAsrQDALElqOcu4U0ccUYpUCB+xpt6
         ChZRFGfdl56FOcaET7EVp2EwxoK7egi0QGse9+N2WyyqhFypshKSYauHkrh+4M2ppu
         yGp703shE5J6RQGRuo+EQJnNXTS1+0BiB3xDLgK3jzk8Qm9XCnSHhQinfy4RWKHW6u
         iv5PsUNxEpTUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1A6645C0143; Fri, 24 Jun 2022 10:32:39 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:32:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        rcu@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add benchmark for local_storage
 RCU Tasks Trace usage
Message-ID: <20220624173239.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220623234609.543263-1-davemarchevsky@fb.com>
 <20220624172238.wpioajigxywd4hxv@kafai-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624172238.wpioajigxywd4hxv@kafai-mbp>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 10:22:38AM -0700, Martin KaFai Lau wrote:
> On Thu, Jun 23, 2022 at 04:46:09PM -0700, Dave Marchevsky wrote:
> > +static void report_progress(int iter, struct bench_res *res, long delta_ns)
> > +{
> > +	if (ctx.skel->bss->unexpected) {
> > +		fprintf(stderr, "Error: Unexpected order of bpf prog calls (postgp after pregp).");
> > +		fprintf(stderr, "Data can't be trusted, exiting\n");
> > +		exit(1);
> > +	}
> > +
> > +	if (args.quiet)
> > +		return;
> > +
> > +	printf("Iter %d\t avg tasks_trace grace period latency\t%lf ns\n",
> > +	       iter, res->gp_ns / (double)res->gp_ct);
> > +	printf("Iter %d\t avg ticks per tasks_trace grace period\t%lf\n",
> > +	       iter, res->stime / (double)res->gp_ct);
> > +}
> > +
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh b/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh
> > new file mode 100755
> > index 000000000000..5dac1f02892c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh
> > @@ -0,0 +1,11 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +kthread_pid=`pgrep rcu_tasks_trace_kthread`
> > +
> > +if [ -z $kthread_pid ]; then
> > +	echo "error: Couldn't find rcu_tasks_trace_kthread"
> > +	exit 1
> > +fi
> > +
> > +./bench --nr_procs 15000 --kthread_pid $kthread_pid -d 600 --quiet 1 local-storage-tasks-trace
> > diff --git a/tools/testing/selftests/bpf/progs/local_storage_rcu_tasks_trace_bench.c b/tools/testing/selftests/bpf/progs/local_storage_rcu_tasks_trace_bench.c
> > new file mode 100644
> > index 000000000000..9b11342b19a0
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/local_storage_rcu_tasks_trace_bench.c
> > @@ -0,0 +1,65 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > +	__uint(map_flags, BPF_F_NO_PREALLOC);
> > +	__type(key, int);
> > +	__type(value, int);
> > +} task_storage SEC(".maps");
> > +
> > +long hits;
> > +long gp_hits;
> > +long gp_times;
> > +long current_gp_start;
> > +long unexpected;
> > +
> > +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> > +int get_local(void *ctx)
> > +{
> > +	struct task_struct *task;
> > +	int idx;
> > +	int *s;
> > +
> > +	idx = 0;
> > +	task = bpf_get_current_task_btf();
> > +	s = bpf_task_storage_get(&task_storage, task, &idx,
> > +				 BPF_LOCAL_STORAGE_GET_F_CREATE);
> > +	if (!s)
> > +		return 0;
> > +
> > +	*s = 3;
> > +	bpf_task_storage_delete(&task_storage, task);
> > +	__sync_add_and_fetch(&hits, 1);
> > +	return 0;
> > +}
> > +
> > +SEC("kprobe/rcu_tasks_trace_pregp_step")
> nit.  Similar to the fentry sys_getpgid above.
> may as well use fentry for everything.
> 
> > +int pregp_step(struct pt_regs *ctx)
> > +{
> > +	current_gp_start = bpf_ktime_get_ns();
> > +	return 0;
> > +}
> > +
> > +SEC("kprobe/rcu_tasks_trace_postgp")
> > +int postgp(struct pt_regs *ctx)
> > +{
> > +	if (!current_gp_start) {
> > +		/* Will only happen if prog tracing rcu_tasks_trace_pregp_step doesn't
> > +		 * execute before this prog
> > +		 */
> > +		__sync_add_and_fetch(&unexpected, 1);
> I consistently hit this:
> ./bench --nr_procs 1500 --kthread_pid ... -d 60 --quiet 1 local-storage-tasks-trace
> Setting up benchmark 'local-storage-tasks-trace'...
> Spun up 1500 procs (our pid 28351)
> Benchmark 'local-storage-tasks-trace' started.
> Error: Unexpected order of bpf prog calls (postgp after pregp).Data can't be trusted, exiting
> 
> May be there is a chance for the very first postgp being called
> before the pregp_step?

If the test starts in the midst of a grace period, yes, this can
happen.  Can the code ignore a postgp that is not preceded by
a pregp?

> Thanks for working on this!

What Martin said!

							Thanx, Paul
