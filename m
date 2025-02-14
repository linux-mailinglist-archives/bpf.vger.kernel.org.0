Return-Path: <bpf+bounces-51613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C467A3676B
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 22:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E051188F6AE
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ADD1C861E;
	Fri, 14 Feb 2025 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkOD3yr9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD600158870;
	Fri, 14 Feb 2025 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568118; cv=none; b=AH30O6C15aiDijDUJb6jMoWfzHPfVAdVHaalJNke2Z5DACK3px/0mklY1yOkcJunks2OiBrpYIcB+nJgY/8+l9gCwXEAAr5zb0n/GZOmL6LCINhO222il23V80ctbwAaG5fwDffznvOweslL7VEc+ALznfti2TrH6O0SvXl/qqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568118; c=relaxed/simple;
	bh=rE1nCO5yFwsxXxdZhU1uWgwIXOsJJ1RRB5gPD/VP0Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rE7rjIcQjjyeULeOWzci4jAbDdONdC58CkscWscK9jdtQprSO2onJ8qPzJONWeS+4rpH451twmaSN3KlSUyPnG5Wf6mUUGhZjeSyk6u1tz9qPXn9huJ0jl8eyUrEQuV/ycVLvPNrb0jWRDwMtGxgJfnkNbo2n7ok93RRJnuPdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkOD3yr9; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f88509dad2so23747097b3.3;
        Fri, 14 Feb 2025 13:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739568115; x=1740172915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iTH34XI3+LLVmJ3b84tPVtNMH6sJXVE8BABD6i37xYE=;
        b=EkOD3yr9DTiAnPzFLzJDQpeKg3/EV5iKh4AZRwB+yquzXBwIEUrH/NgxRfJU2Rg3YW
         ogLPFzwtOZhrSb5UtHgCy4LcMWfo+a+L41oOCQGpZ8oRzmvteOElL5nyAM1d716eG0No
         rYTD9dAR0hbVvxV2OgMMODYxYJ3Tcp61Xe200h5cTz8ceETwjU3Qh6jHtbYQEcn47Typ
         iCfs0QYjZZMYdx1yZ2Uwv4feny+iY0Wx25x8W3BbfnrjX2U5QlNUuqTIBQDRCasbBn6Y
         jF+ZnKF9XfJJHg+hDVhbZN45wu8NQ6gtSppf+BpVHAhK2Ak8th3utsBjG1TddU5qQtL9
         rnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739568115; x=1740172915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTH34XI3+LLVmJ3b84tPVtNMH6sJXVE8BABD6i37xYE=;
        b=pd4J/HIDVBqG3xzf3pEN3PZ9WCXigf7SbzgwDkY4YEvEcrS9RklTba1EPRzJHgt/O/
         TCfafutyqOh6muoGkFkmNLj2Um/iz5Mqr27mVg+l9qGeVc8Xu9ohiSfEO5bfqkeSHI2N
         Yl2KMCizbo81ps8dp1ztdJERHHTezLGTe0ih0S82zvLL7X2yhWcMh0VPciN9f8SmPxQe
         x3QITQ7y9pjh4pfA/LwlHiPSUO6d+V7T+0UdYZ9YDfUbBi7XlXhGmIMcNtkEQiSAgPNF
         MdB3vSlhW8F/YUMrFmQCzvvygc0dmebngaMpSHqJxu6WyQQ7u9q2Icqt7Ehf+7Cv1POe
         tKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXO9Qcm0nv8bvmGzJIAaBkaGNj+QhddUWHZdopkK1vUukyqp8VmD8gKyFEtyb1REoy9ou7G7oiYWuL/ca/@vger.kernel.org, AJvYcCWAMxqu0gq7pNpid1ufij7wmcY21udSismL12SMvlBYsdez7am7isihY0mSuxrQGM7GXSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xKEnsEqvU7AV8dwq6XZ4IvqNnNkPpXO5+Kgv2dKs+f5DLojQ
	T8JALRbitSX2u/gbdpbhGFmwazt6ZjdbINI5P7jphOrEE7u78s8y
X-Gm-Gg: ASbGncsrnCu+PS60e1f621Rl0z/g8lKNuR09BFr5GNZsQw40HjOJYyNpI23tl0rq3Pr
	Y1x0AiLJ7EpqEvtaKoEu82VzkSkdeDbAinGQWPft3Y72zznEvRcfRGQrcOF5Xd3u24vZAr2QWVD
	LVGvgPkZ+ZopjrI/x2OiCOpbZdr+nwCXtDmFoxRWELD1BGxb40Y5SnpMIxFVhc9Nh9YUr4Zz5jR
	8T2w/woHcP1/7zHQXmP2zFfGr7lNSqcsLskyy7lOzHq0nMtlrOqQMlbzjVSNSenCA3oAxhX8DAl
	RiBZgYkSl/d8qS+PDlAFCFpvzjuBHPq9dG71eJXzN3w0PlQmQiI=
X-Google-Smtp-Source: AGHT+IFAtFOjbQ0JGHi1Y65iBl4ahS8xDGdYrbKpp2nkt0nUTwFAO+pWcZihqm8yKG/XMI7tQkib8Q==
X-Received: by 2002:a05:690c:3607:b0:6ef:9e74:c0b8 with SMTP id 00721157ae682-6fb582bc0d3mr12951277b3.17.1739568114483;
        Fri, 14 Feb 2025 13:21:54 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb360861adsm9284847b3.45.2025.02.14.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:21:53 -0800 (PST)
Date: Fri, 14 Feb 2025 16:21:53 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] sched_ext: idle: Per-node idle cpumasks
Message-ID: <Z6-z8aLFCiCVxbP4@thinkpad>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-8-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214194134.658939-8-arighi@nvidia.com>

On Fri, Feb 14, 2025 at 08:40:06PM +0100, Andrea Righi wrote:
> Using a single global idle mask can lead to inefficiencies and a lot of
> stress on the cache coherency protocol on large systems with multiple
> NUMA nodes, since all the CPUs can create a really intense read/write
> activity on the single global cpumask.
> 
> Therefore, split the global cpumask into multiple per-NUMA node cpumasks
> to improve scalability and performance on large systems.
> 
> The concept is that each cpumask will track only the idle CPUs within
> its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
> In this way concurrent access to the idle cpumask will be restricted
> within each NUMA node.
> 
> The split of multiple per-node idle cpumasks can be controlled using the
> SCX_OPS_BUILTIN_IDLE_PER_NODE flag.
> 
> By default SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled and a global
> host-wide idle cpumask is used, maintaining the previous behavior.
> 
> NOTE: if a scheduler explicitly enables the per-node idle cpumasks (via
> SCX_OPS_BUILTIN_IDLE_PER_NODE), scx_bpf_get_idle_cpu/smtmask() will
> trigger an scx error, since there are no system-wide cpumasks.
> 
> = Test =
> 
> Hardware:
>  - System: DGX B200
>     - CPUs: 224 SMT threads (112 physical cores)
>     - Processor: INTEL(R) XEON(R) PLATINUM 8570
>     - 2 NUMA nodes
> 
> Scheduler:
>  - scx_simple [1] (so that we can focus at the built-in idle selection
>    policy and not at the scheduling policy itself)
> 
> Test:
>  - Run a parallel kernel build `make -j $(nproc)` and measure the average
>    elapsed time over 10 runs:
> 
>           avg time | stdev
>           ---------+------
>  before:   52.431s | 2.895
>   after:   50.342s | 2.895
> 
> = Conclusion =
> 
> Splitting the global cpumask into multiple per-NUMA cpumasks helped to
> achieve a speedup of approximately +4% with this particular architecture
> and test case.
> 
> The same test on a DGX-1 (40 physical cores, Intel Xeon E5-2698 v4 @
> 2.20GHz, 2 NUMA nodes) shows a speedup of around 1.5-3%.
> 
> On smaller systems, I haven't noticed any measurable regressions or
> improvements with the same test (parallel kernel build) and scheduler
> (scx_simple).
> 
> Moreover, with a modified scx_bpfland that uses the new NUMA-aware APIs
> I observed an additional +2-2.5% performance improvement with the same
> test.
> 
> [1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_simple.bpf.c
> 
> Cc: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

> ---
>  kernel/sched/ext.c                   |   1 +
>  kernel/sched/ext_idle.c              | 283 ++++++++++++++++++++++-----
>  kernel/sched/ext_idle.h              |   4 +-
>  tools/sched_ext/include/scx/compat.h |   3 +
>  4 files changed, 236 insertions(+), 55 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 330a359d79301..95603db36f043 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -806,6 +806,7 @@ enum scx_deq_flags {
>  
>  enum scx_pick_idle_cpu_flags {
>  	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
> +	SCX_PICK_IDLE_IN_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
>  };
>  
>  enum scx_kick_flags {
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 0912f94b95cdc..8dacccc82ed63 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -18,25 +18,61 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
>  static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
>  
>  #ifdef CONFIG_SMP
> -#ifdef CONFIG_CPUMASK_OFFSTACK
> -#define CL_ALIGNED_IF_ONSTACK
> -#else
> -#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
> -#endif
> -
>  /* Enable/disable LLC aware optimizations */
>  static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
>  
>  /* Enable/disable NUMA aware optimizations */
>  static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
>  
> -static struct {
> +/*
> + * cpumasks to track idle CPUs within each NUMA node.
> + *
> + * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled, a single global cpumask
> + * from is used to track all the idle CPUs in the system.
> + */
> +struct scx_idle_cpus {
>  	cpumask_var_t cpu;
>  	cpumask_var_t smt;
> -} idle_masks CL_ALIGNED_IF_ONSTACK;
> +};
> +
> +/*
> + * Global host-wide idle cpumasks (used when SCX_OPS_BUILTIN_IDLE_PER_NODE
> + * is not enabled).
> + */
> +static struct scx_idle_cpus scx_idle_global_masks;
> +
> +/*
> + * Per-node idle cpumasks.
> + */
> +static struct scx_idle_cpus **scx_idle_node_masks;
> +
> +/*
> + * Return the idle masks associated to a target @node.
> + *
> + * NUMA_NO_NODE identifies the global idle cpumask.
> + */
> +static struct scx_idle_cpus *idle_cpumask(int node)
> +{
> +	return node == NUMA_NO_NODE ? &scx_idle_global_masks : scx_idle_node_masks[node];
> +}
> +
> +/*
> + * Returns the NUMA node ID associated with a @cpu, or NUMA_NO_NODE if
> + * per-node idle cpumasks are disabled.
> + */
> +static int scx_cpu_node_if_enabled(int cpu)
> +{
> +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> +		return NUMA_NO_NODE;
> +
> +	return cpu_to_node(cpu);
> +}
>  
>  bool scx_idle_test_and_clear_cpu(int cpu)
>  {
> +	int node = scx_cpu_node_if_enabled(cpu);
> +	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
> +
>  #ifdef CONFIG_SCHED_SMT
>  	/*
>  	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
> @@ -45,33 +81,38 @@ bool scx_idle_test_and_clear_cpu(int cpu)
>  	 */
>  	if (sched_smt_active()) {
>  		const struct cpumask *smt = cpu_smt_mask(cpu);
> +		struct cpumask *idle_smts = idle_cpumask(node)->smt;
>  
>  		/*
>  		 * If offline, @cpu is not its own sibling and
>  		 * scx_pick_idle_cpu() can get caught in an infinite loop as
> -		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
> -		 * is eventually cleared.
> +		 * @cpu is never cleared from the idle SMT mask. Ensure that
> +		 * @cpu is eventually cleared.
>  		 *
>  		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
>  		 * reduce memory writes, which may help alleviate cache
>  		 * coherence pressure.
>  		 */
> -		if (cpumask_intersects(smt, idle_masks.smt))
> -			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> -		else if (cpumask_test_cpu(cpu, idle_masks.smt))
> -			__cpumask_clear_cpu(cpu, idle_masks.smt);
> +		if (cpumask_intersects(smt, idle_smts))
> +			cpumask_andnot(idle_smts, idle_smts, smt);
> +		else if (cpumask_test_cpu(cpu, idle_smts))
> +			__cpumask_clear_cpu(cpu, idle_smts);
>  	}
>  #endif
> -	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
> +
> +	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
>  }
>  
> -s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> +/*
> + * Pick an idle CPU in a specific NUMA node.
> + */
> +static s32 pick_idle_cpu_in_node(const struct cpumask *cpus_allowed, int node, u64 flags)
>  {
>  	int cpu;
>  
>  retry:
>  	if (sched_smt_active()) {
> -		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
> +		cpu = cpumask_any_and_distribute(idle_cpumask(node)->smt, cpus_allowed);
>  		if (cpu < nr_cpu_ids)
>  			goto found;
>  
> @@ -79,7 +120,7 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
>  			return -EBUSY;
>  	}
>  
> -	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
> +	cpu = cpumask_any_and_distribute(idle_cpumask(node)->cpu, cpus_allowed);
>  	if (cpu >= nr_cpu_ids)
>  		return -EBUSY;
>  
> @@ -90,6 +131,85 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
>  		goto retry;
>  }
>  
> +/*
> + * Tracks nodes that have not yet been visited when searching for an idle
> + * CPU across all available nodes.
> + */
> +static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
> +
> +/*
> + * Search for an idle CPU across all nodes, excluding @node.
> + */
> +static s32 pick_idle_cpu_from_online_nodes(const struct cpumask *cpus_allowed, int node, u64 flags)
> +{
> +	nodemask_t *unvisited;
> +	s32 cpu = -EBUSY;
> +
> +	preempt_disable();
> +	unvisited = this_cpu_ptr(&per_cpu_unvisited);
> +
> +	/*
> +	 * Restrict the search to the online nodes (excluding the current
> +	 * node that has been visited already).
> +	 */
> +	nodes_copy(*unvisited, node_states[N_ONLINE]);
> +	node_clear(node, *unvisited);
> +
> +	/*
> +	 * Traverse all nodes in order of increasing distance, starting
> +	 * from @node.
> +	 *
> +	 * This loop is O(N^2), with N being the amount of NUMA nodes,
> +	 * which might be quite expensive in large NUMA systems. However,
> +	 * this complexity comes into play only when a scheduler enables
> +	 * SCX_OPS_BUILTIN_IDLE_PER_NODE and it's requesting an idle CPU
> +	 * without specifying a target NUMA node, so it shouldn't be a
> +	 * bottleneck is most cases.
> +	 *
> +	 * As a future optimization we may want to cache the list of nodes
> +	 * in a per-node array, instead of actually traversing them every
> +	 * time.
> +	 */
> +	for_each_node_numadist(node, *unvisited) {
> +		cpu = pick_idle_cpu_in_node(cpus_allowed, node, flags);
> +		if (cpu >= 0)
> +			break;
> +	}
> +	preempt_enable();
> +
> +	return cpu;
> +}
> +
> +/*
> + * Find an idle CPU in the system, starting from @node.
> + */
> +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> +{
> +	s32 cpu;
> +
> +	/*
> +	 * Always search in the starting node first (this is an
> +	 * optimization that can save some cycles even when the search is
> +	 * not limited to a single node).
> +	 */
> +	cpu = pick_idle_cpu_in_node(cpus_allowed, node, flags);
> +	if (cpu >= 0)
> +		return cpu;
> +
> +	/*
> +	 * Stop the search if we are using only a single global cpumask
> +	 * (NUMA_NO_NODE) or if the search is restricted to the first node
> +	 * only.
> +	 */
> +	if (node == NUMA_NO_NODE || flags & SCX_PICK_IDLE_IN_NODE)
> +		return -EBUSY;
> +
> +	/*
> +	 * Extend the search to the other online nodes.
> +	 */
> +	return pick_idle_cpu_from_online_nodes(cpus_allowed, node, flags);
> +}
> +
>  /*
>   * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
>   * domain is not defined).
> @@ -302,6 +422,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
>  {
>  	const struct cpumask *llc_cpus = NULL;
>  	const struct cpumask *numa_cpus = NULL;
> +	int node = scx_cpu_node_if_enabled(prev_cpu);
>  	s32 cpu;
>  
>  	*found = false;
> @@ -359,9 +480,9 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
>  		 * piled up on it even if there is an idle core elsewhere on
>  		 * the system.
>  		 */
> -		if (!cpumask_empty(idle_masks.cpu) &&
> -		    !(current->flags & PF_EXITING) &&
> -		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
> +		if (!(current->flags & PF_EXITING) &&
> +		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
> +		    !cpumask_empty(idle_cpumask(cpu_to_node(cpu))->cpu)) {
>  			if (cpumask_test_cpu(cpu, p->cpus_ptr))
>  				goto cpu_found;
>  		}
> @@ -375,7 +496,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
>  		/*
>  		 * Keep using @prev_cpu if it's part of a fully idle core.
>  		 */
> -		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
> +		if (cpumask_test_cpu(prev_cpu, idle_cpumask(node)->smt) &&
>  		    scx_idle_test_and_clear_cpu(prev_cpu)) {
>  			cpu = prev_cpu;
>  			goto cpu_found;
> @@ -385,7 +506,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
>  		 * Search for any fully idle core in the same LLC domain.
>  		 */
>  		if (llc_cpus) {
> -			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
> +			cpu = pick_idle_cpu_in_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
>  			if (cpu >= 0)
>  				goto cpu_found;
>  		}
> @@ -394,15 +515,19 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
>  		 * Search for any fully idle core in the same NUMA node.
>  		 */
>  		if (numa_cpus) {
> -			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
> +			cpu = pick_idle_cpu_in_node(numa_cpus, node, SCX_PICK_IDLE_CORE);
>  			if (cpu >= 0)
>  				goto cpu_found;
>  		}
>  
>  		/*
>  		 * Search for any full idle core usable by the task.
> +		 *
> +		 * If NUMA aware idle selection is enabled, the search will
> +		 * begin in prev_cpu's node and proceed to other nodes in
> +		 * order of increasing distance.
>  		 */
> -		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
> +		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, SCX_PICK_IDLE_CORE);
>  		if (cpu >= 0)
>  			goto cpu_found;
>  	}
> @@ -419,7 +544,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
>  	 * Search for any idle CPU in the same LLC domain.
>  	 */
>  	if (llc_cpus) {
> -		cpu = scx_pick_idle_cpu(llc_cpus, 0);
> +		cpu = pick_idle_cpu_in_node(llc_cpus, node, 0);
>  		if (cpu >= 0)
>  			goto cpu_found;
>  	}
> @@ -428,7 +553,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
>  	 * Search for any idle CPU in the same NUMA node.
>  	 */
>  	if (numa_cpus) {
> -		cpu = scx_pick_idle_cpu(numa_cpus, 0);
> +		cpu = pick_idle_cpu_in_node(numa_cpus, node, 0);
>  		if (cpu >= 0)
>  			goto cpu_found;
>  	}
> @@ -436,7 +561,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
>  	/*
>  	 * Search for any idle CPU usable by the task.
>  	 */
> -	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
> +	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
>  	if (cpu >= 0)
>  		goto cpu_found;
>  
> @@ -450,30 +575,54 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
>  	return cpu;
>  }
>  
> +/*
> + * Initialize global and per-node idle cpumasks.
> + */
>  void scx_idle_init_masks(void)
>  {
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
> +	int node;
> +
> +	/* Allocate global idle cpumasks */
> +	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.cpu, GFP_KERNEL));
> +	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.smt, GFP_KERNEL));
> +
> +	/* Allocate per-node idle cpumasks */
> +	scx_idle_node_masks = kcalloc(num_possible_nodes(),
> +				      sizeof(*scx_idle_node_masks), GFP_KERNEL);
> +	BUG_ON(!scx_idle_node_masks);
> +
> +	for_each_node(node) {
> +		scx_idle_node_masks[node] = kzalloc_node(sizeof(**scx_idle_node_masks),
> +							 GFP_KERNEL, node);
> +		BUG_ON(!scx_idle_node_masks[node]);
> +
> +		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->cpu, GFP_KERNEL, node));
> +		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->smt, GFP_KERNEL, node));
> +	}
>  }
>  
>  static void update_builtin_idle(int cpu, bool idle)
>  {
> -	assign_cpu(cpu, idle_masks.cpu, idle);
> +	int node = scx_cpu_node_if_enabled(cpu);
> +	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
> +
> +	assign_cpu(cpu, idle_cpus, idle);
>  
>  #ifdef CONFIG_SCHED_SMT
>  	if (sched_smt_active()) {
>  		const struct cpumask *smt = cpu_smt_mask(cpu);
> +		struct cpumask *idle_smts = idle_cpumask(node)->smt;
>  
>  		if (idle) {
>  			/*
> -			 * idle_masks.smt handling is racy but that's fine as
> -			 * it's only for optimization and self-correcting.
> +			 * idle_smt handling is racy but that's fine as it's
> +			 * only for optimization and self-correcting.
>  			 */
> -			if (!cpumask_subset(smt, idle_masks.cpu))
> +			if (!cpumask_subset(smt, idle_cpus))
>  				return;
> -			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
> +			cpumask_or(idle_smts, idle_smts, smt);
>  		} else {
> -			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> +			cpumask_andnot(idle_smts, idle_smts, smt);
>  		}
>  	}
>  #endif
> @@ -529,15 +678,36 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
>  		if (do_notify || is_idle_task(rq->curr))
>  			update_builtin_idle(cpu, idle);
>  }
> +
> +static void reset_idle_masks(struct sched_ext_ops *ops)
> +{
> +	int node;
> +
> +	/*
> +	 * Consider all online cpus idle. Should converge to the actual state
> +	 * quickly.
> +	 */
> +	if (!(ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)) {
> +		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->cpu, cpu_online_mask);
> +		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->smt, cpu_online_mask);
> +		return;
> +	}
> +
> +	for_each_node(node) {
> +		const struct cpumask *node_mask = cpumask_of_node(node);
> +
> +		cpumask_and(idle_cpumask(node)->cpu, cpu_online_mask, node_mask);
> +		cpumask_and(idle_cpumask(node)->smt, cpu_online_mask, node_mask);
> +	}
> +}
>  #endif	/* CONFIG_SMP */
>  
>  void scx_idle_enable(struct sched_ext_ops *ops)
>  {
> -	if (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
> +	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))
> +		static_branch_enable(&scx_builtin_idle_enabled);
> +	else
>  		static_branch_disable(&scx_builtin_idle_enabled);
> -		return;
> -	}
> -	static_branch_enable(&scx_builtin_idle_enabled);
>  
>  	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
>  		static_branch_enable(&scx_builtin_idle_per_node);
> @@ -545,12 +715,7 @@ void scx_idle_enable(struct sched_ext_ops *ops)
>  		static_branch_disable(&scx_builtin_idle_per_node);
>  
>  #ifdef CONFIG_SMP
> -	/*
> -	 * Consider all online cpus idle. Should converge to the actual state
> -	 * quickly.
> -	 */
> -	cpumask_copy(idle_masks.cpu, cpu_online_mask);
> -	cpumask_copy(idle_masks.smt, cpu_online_mask);
> +	reset_idle_masks(ops);
>  #endif
>  }
>  
> @@ -610,15 +775,21 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>   * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
>   * per-CPU cpumask.
>   *
> - * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
> + * Returns an empty mask if idle tracking is not enabled, or running on a
> + * UP kernel.
>   */
>  __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
>  {
> +	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
> +		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
> +		return cpu_none_mask;
> +	}
> +
>  	if (!check_builtin_idle_enabled())
>  		return cpu_none_mask;
>  
>  #ifdef CONFIG_SMP
> -	return idle_masks.cpu;
> +	return idle_cpumask(NUMA_NO_NODE)->cpu;
>  #else
>  	return cpu_none_mask;
>  #endif
> @@ -629,18 +800,24 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
>   * per-physical-core cpumask. Can be used to determine if an entire physical
>   * core is free.
>   *
> - * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
> + * Returns an empty mask if idle tracking is not enabled, or running on a
> + * UP kernel.
>   */
>  __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
>  {
> +	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
> +		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
> +		return cpu_none_mask;
> +	}
> +
>  	if (!check_builtin_idle_enabled())
>  		return cpu_none_mask;
>  
>  #ifdef CONFIG_SMP
>  	if (sched_smt_active())
> -		return idle_masks.smt;
> +		return idle_cpumask(NUMA_NO_NODE)->smt;
>  	else
> -		return idle_masks.cpu;
> +		return idle_cpumask(NUMA_NO_NODE)->cpu;
>  #else
>  	return cpu_none_mask;
>  #endif
> @@ -707,7 +884,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
>  	if (!check_builtin_idle_enabled())
>  		return -EBUSY;
>  
> -	return scx_pick_idle_cpu(cpus_allowed, flags);
> +	return scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
>  }
>  
>  /**
> @@ -730,7 +907,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
>  	s32 cpu;
>  
>  	if (static_branch_likely(&scx_builtin_idle_enabled)) {
> -		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
> +		cpu = scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
>  		if (cpu >= 0)
>  			return cpu;
>  	}
> diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
> index 339b6ec9c4cb7..68c4307ce4f6f 100644
> --- a/kernel/sched/ext_idle.h
> +++ b/kernel/sched/ext_idle.h
> @@ -16,12 +16,12 @@ struct sched_ext_ops;
>  void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
>  void scx_idle_init_masks(void);
>  bool scx_idle_test_and_clear_cpu(int cpu);
> -s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
> +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags);
>  #else /* !CONFIG_SMP */
>  static inline void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops) {}
>  static inline void scx_idle_init_masks(void) {}
>  static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
> -static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> +static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
>  {
>  	return -EBUSY;
>  }
> diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
> index d63cf40be8eee..03e06bd15c738 100644
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
> @@ -112,6 +112,9 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
>  #define SCX_OPS_BUILTIN_IDLE_PER_NODE						\
>  	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE")
>  
> +#define SCX_PICK_IDLE_IN_NODE \
> +	__COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", "SCX_PICK_IDLE_IN_NODE")
> +
>  static inline long scx_hotplug_seq(void)
>  {
>  	int fd;
> -- 
> 2.48.1

