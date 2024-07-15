Return-Path: <bpf+bounces-34811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A91C5931292
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 12:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4129CB22C70
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B79188CC7;
	Mon, 15 Jul 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3KsUgT4"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812413D8B1;
	Mon, 15 Jul 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040454; cv=none; b=MbR2MO6e7k/YsTrcUDNTbSKCbuoi7YtnPiP68BcvK3qS340np3/wGrKo5Uqg6HxRs2XDD32VQEyR/7KUBTvinFrPRuZk8Iv5B7yi6HiUsjamiy+se2MUEd34WK9DQ1AEAxE/PG6VrEIhFH8Zak0MvgiYPcm2qxRAURd0jnLZNrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040454; c=relaxed/simple;
	bh=UwOwjRIPId3MzSFTYliEs+J+7giC8fz2YOnusqx+vFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDH551HnV7ELhu0CMYRoDZE0odljzxobeRCNYzBhJFXQgRCfteLDWyxrZABzxRTfk3urSc2U84aXtWC7sQLTL8aqogEXNIJHRXOw4xr/Lxl1xeDld2SoI/p4VQmZDgCXTLymzzdmpWpUw/8vK/f7czaEsCrIq6L4HWmfs8Vgaqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W3KsUgT4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kwP3k0MYAZqHQtpweUNey7MZGCcgrYPRk6j0LQVUVUc=; b=W3KsUgT4h0kADdrtR1DPpli7sk
	M1k/KOMK/M3EyHHyPUNlH2DS3GQbEdct15zEa/ldwO+zo8F9EWadk0Dxylwbi4PDBja4VVV1ShOSd
	rPFkdfa3NgprTj3n1Qhmv/7gbG7z2L8C981qX9Jt3vM1JFBTECrMgr1vdjPIY2a65gIMoH08KJzLm
	MK6HIA5k8kP4S5Z2OVnLh/bjP8gTHXRaayENtZVe7pbFiPj1wG5W6wV5ZgwECpRnukGhIgwPKQvSO
	Xr4SSzA30hU3Mujs+EHaKYsYPuwgdfrUEYxP3h2/BPr1nRQzZQIBhn4393wLkBetR9qUwZuhQvJce
	3avD0YIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTJEm-00000001mH9-2FT1;
	Mon, 15 Jul 2024 10:47:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 224FB3003FF; Mon, 15 Jul 2024 12:47:20 +0200 (CEST)
Date: Mon, 15 Jul 2024 12:47:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Subject: Re: [PATCH] perf callchain: Fix suspicious RCU usage in
 get_callchain_entry()
Message-ID: <20240715104719.GA14400@noisy.programming.kicks-ass.net>
References: <20240715102326.1910790-2-radoslaw.zielonek@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715102326.1910790-2-radoslaw.zielonek@gmail.com>

On Mon, Jul 15, 2024 at 12:23:27PM +0200, Radoslaw Zielonek wrote:
> The rcu_dereference() is using rcu_read_lock_held() as a checker, but
> BPF in bpf_prog_test_run_syscall() is using rcu_read_lock_trace() locker.
> To fix this issue the proper checker has been used
> (rcu_read_lock_trace_held() || rcu_read_lock_held())

How does that fix it? release_callchain_buffers() does call_rcu(), not
call_rcu_tracing().

Does a normal RCU grace period fully imply an RCU-tracing grace period?

> ---
>  kernel/events/callchain.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 1273be84392c..a8af7cd50626 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -11,6 +11,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/slab.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/rcupdate_trace.h>
>  
>  #include "internal.h"
>  
> @@ -32,7 +33,7 @@ static inline size_t perf_callchain_entry__sizeof(void)
>  static DEFINE_PER_CPU(int, callchain_recursion[PERF_NR_CONTEXTS]);
>  static atomic_t nr_callchain_events;
>  static DEFINE_MUTEX(callchain_mutex);
> -static struct callchain_cpus_entries *callchain_cpus_entries;
> +static struct callchain_cpus_entries __rcu *callchain_cpus_entries;
>  
>  
>  __weak void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
> @@ -158,7 +159,13 @@ struct perf_callchain_entry *get_callchain_entry(int *rctx)
>  	if (*rctx == -1)
>  		return NULL;
>  
> -	entries = rcu_dereference(callchain_cpus_entries);
> +	/*
> +	 * BPF locked rcu using rcu_read_lock_trace() in
> +	 * bpf_prog_test_run_syscall()
> +	 */
> +	entries = rcu_dereference_check(callchain_cpus_entries,
> +					rcu_read_lock_trace_held() ||
> +					rcu_read_lock_held());
>  	if (!entries) {
>  		put_recursion_context(this_cpu_ptr(callchain_recursion), *rctx);
>  		return NULL;
> -- 
> 2.43.0
> 

