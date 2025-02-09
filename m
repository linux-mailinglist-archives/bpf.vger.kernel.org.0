Return-Path: <bpf+bounces-50906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FCDA2DFC4
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 19:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD947A07F4
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3BB1E130F;
	Sun,  9 Feb 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrT1Up2G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA981E0DED;
	Sun,  9 Feb 2025 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124467; cv=none; b=uoloDf0aRpusKMK7T+LtWfuk/IIS5uKQRDRvRQEOK0vmKVBw0MO/Dd4gEoHxLluTH4LoRt6J8rNGr2X32Ff7K4y/UXxO3uub6hUHwiEZlivYg9NelH3HOfIP9JfnarjbmtcmmoCva5e6KudWtrlg1jzuTVIsh63y7WNtV4BVWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124467; c=relaxed/simple;
	bh=71gxaixQFvz/IlPJxluK+ZBJKcDDsGiORU8wEUKvzIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCGLlfQn1dhwE32F8vFN6Ru8zgcE6/OLRL/gJZ54V/FR5/xpeJqOQ4qCPsUoi/yENXXY//yyoKgSK9qu0OrsBFWG08FuSjLJUpLPOdolhzmbTSpyKI9Q0RxfXJLorA62sFqAqO94y2KsPfa9q+rBpEnIf6X8pEL9qX8S59ES6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrT1Up2G; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f9cc6fefa8so8412527b3.3;
        Sun, 09 Feb 2025 10:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739124464; x=1739729264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCTvRP6fRLel77tsrtJDzftGFCuqiRr6Qu9t1KNzlI8=;
        b=SrT1Up2GQA3Q2S3qJ0icL0LJjJOKtELPTspMP4inb4jTeevbm8iTy5iyzgW4IQ4Q8e
         GAUWcPeM2RRBsfnejBc3M6iNyIcsiAx2KrdYIp0SI3h+cYWxXl9XfD3h04FfgITw25yv
         wRaYX3yp8iSssEo1FZbcOH34uMCZsqCP80DFHVnobpraFVwVcEH6XchxGBZUg6S+wniW
         vgVMQswt7ZHbL9Bb9EnnWlUKD3FIzaFKfd4xbAlPVpjuj0240o+A6Zs/2F7W0j4NhUIu
         ZCv7TI4rFet/uUeFWVrZXRxfittgqFHGKJcpTWQtsod9JTaPvLE59Jdos3AQhQZpcDbl
         Y7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739124464; x=1739729264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCTvRP6fRLel77tsrtJDzftGFCuqiRr6Qu9t1KNzlI8=;
        b=NBIXM/J61zBVOFsJkiIjoNwQj2gL6cWEbOO7UdrV9z2IRpQNS8A0VTlRocLMfCH3Ox
         pwSsPYOMttHsi2whQu46M0cvZo1B3SC2EicHFJxY8Z04SCCsnr6ygC/w2Pr+5lk+I90x
         3s3nTS/jq7mbEFzQs7j1MvSEN2JDznTZRWwH7+UXO4/RcALxdVynZYt/QiYxs2mfRCum
         Mvg2HP89EyedP12J23EnFrxljAInEU9WAVqMWboHg5azDaqjpjYN3o3jr8qb8/DSjneG
         2ZQBy/lQuF6UhQtf2vw9qr2fCH9Ry6zGJyLsNhd7KekphbzfPNgVJj6Dk3XSg/KGFv1E
         yPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2HfkgXYEfvy9Txh3efWaO7EKqXQCDZPhVqLWmfkmFvjLUP2/19xcinO0Gu6G9uYI9fQg=@vger.kernel.org, AJvYcCWN4z3oy+0XwT7SWJDLIPkAqKtK1U1jmf2R7ShbPK5GuR39kJdIyeYwpgYXH2HduZlm4bscfG+cOT0ztUHc@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+On327eaF6HX+OXdMzGW4rT+abQjiKMYenwLf7lefwtpLc/i
	cbZMPPbzeQ8g3FghCp4MRtDDcPpv3Bh1EIKlHqitRQtL2plzjbp5
X-Gm-Gg: ASbGncuSbvMir9xvX08gnFJ2zVz/3rffeBZxmHJ4z+1rT1WcgVLNFbo3kx0GzBA0643
	kP57fRWEljPCMooZQ2/7XS48v6Uy2gmpkLV38IpwDsIDB4L0YyxsUxUJm1+pPOqYIIUAOjISyYK
	Gjj6Y2YrACfvP7CI7X9o7FAuj4gyseRxsdCYW/s0cOOuMPISobvhMN0fGlbcGRdoFnU2KZV3f7m
	haY3gRH8rCyeLZ5dYisnumxN002o2bzQJ7SIWU9zvo+O2Cs/R62wwrmCiDaRZcA9gbQIBg5aD9j
	d9cStB8uopiMiNQnIKBsEHGR2iWIi2COe38x7hF64oxdpmnAkMc=
X-Google-Smtp-Source: AGHT+IFX43nflAcmXVFKPPaPnrsl93YDDQ4wCcYeIcF0cZUK7JSdihnZtHKMNIu3hIFm/fT+FQEmQQ==
X-Received: by 2002:a05:690c:4986:b0:6f7:3e01:8a49 with SMTP id 00721157ae682-6f9b29e61c4mr96419587b3.26.1739124464196;
        Sun, 09 Feb 2025 10:07:44 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99fd5b0a4sm12948177b3.66.2025.02.09.10.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 10:07:43 -0800 (PST)
Date: Sun, 9 Feb 2025 13:07:42 -0500
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
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: idle: Per-node idle cpumasks
Message-ID: <Z6ju7vFK5TpJamn5@thinkpad>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207211104.30009-6-arighi@nvidia.com>

On Fri, Feb 07, 2025 at 09:40:52PM +0100, Andrea Righi wrote:
> Using a single global idle mask can lead to inefficiencies and a lot of
> stress on the cache coherency protocol on large systems with multiple
> NUMA nodes, since all the CPUs can create a really intense read/write
> activity on the single global cpumask.

Can you put your perf numbers here too?
 
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
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext_idle.c | 242 ++++++++++++++++++++++++++++++++--------
>  kernel/sched/ext_idle.h |  11 +-
>  2 files changed, 203 insertions(+), 50 deletions(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index a3f2b00903ac2..4b90ec9018c1a 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -18,25 +18,88 @@ DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
>  DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
>  
>  #ifdef CONFIG_SMP
> -#ifdef CONFIG_CPUMASK_OFFSTACK
> -#define CL_ALIGNED_IF_ONSTACK
> -#else
> -#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
> -#endif
> -
>  /* Enable/disable LLC aware optimizations */
>  DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
>  
>  /* Enable/disable NUMA aware optimizations */
>  DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
>  
> -static struct {
> +/*
> + * cpumasks to track idle CPUs within each NUMA node.
> + *
> + * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled, a single global cpumask
> + * from is used to track all the idle CPUs in the system.
> + */
> +struct idle_cpus {
>  	cpumask_var_t cpu;
>  	cpumask_var_t smt;
> -} idle_masks CL_ALIGNED_IF_ONSTACK;
> +};
> +
> +/*
> + * Global host-wide idle cpumasks (used when SCX_OPS_BUILTIN_IDLE_PER_NODE
> + * is not enabled).
> + */
> +static struct idle_cpus scx_idle_global_masks;
> +
> +/*
> + * Per-node idle cpumasks.
> + */
> +static struct idle_cpus **scx_idle_node_masks;
> +
> +/*
> + * Initialize per-node idle cpumasks.
> + *
> + * In case of a single NUMA node or if NUMA support is disabled, only a
> + * single global host-wide cpumask will be initialized.
> + */
> +void scx_idle_init_masks(void)
> +{
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
> +}
> +
> +/*
> + * Return the idle masks associated to a target @node.
> + */
> +static struct idle_cpus *idle_cpumask(int node)
> +{
> +	return node == NUMA_NO_NODE ? &scx_idle_global_masks : scx_idle_node_masks[node];
> +}
> +
> +/*
> + * Return the node id associated to a target idle CPU (used to determine
> + * the proper idle cpumask).
> + */
> +static int idle_cpu_to_node(int cpu)
> +{
> +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> +		return NUMA_NO_NODE;
> +
> +	return cpu_to_node(cpu);
> +}
>  
>  bool scx_idle_test_and_clear_cpu(int cpu)
>  {
> +	int node = idle_cpu_to_node(cpu);
> +	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
> +
>  #ifdef CONFIG_SCHED_SMT
>  	/*
>  	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
> @@ -45,33 +108,38 @@ bool scx_idle_test_and_clear_cpu(int cpu)
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
> +s32 pick_idle_cpu_from_node(const struct cpumask *cpus_allowed, int node, u64 flags)
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
> @@ -79,7 +147,7 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
>  			return -EBUSY;
>  	}
>  
> -	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
> +	cpu = cpumask_any_and_distribute(idle_cpumask(node)->cpu, cpus_allowed);
>  	if (cpu >= nr_cpu_ids)
>  		return -EBUSY;
>  
> @@ -90,6 +158,55 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
>  		goto retry;
>  }
>  
> +/*
> + * Find the best idle CPU in the system, relative to @node.
> + */
> +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> +{
> +	nodemask_t unvisited = NODE_MASK_ALL;
> +	s32 cpu = -EBUSY;
> +
> +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> +		return pick_idle_cpu_from_node(cpus_allowed, NUMA_NO_NODE, flags);
> +
> +	/*
> +	 * If an initial node is not specified, start with the current
> +	 * node.
> +	 */
> +	if (node == NUMA_NO_NODE)
> +		node = numa_node_id();
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
> +	 * As a future optimization we may want to cache the list of hop
> +	 * nodes in a per-node array, instead of actually traversing them
> +	 * every time.
> +	 */
> +	for_each_numa_node(node, unvisited, N_POSSIBLE) {
> +		cpu = pick_idle_cpu_from_node(cpus_allowed, node, flags);
> +		if (cpu >= 0)
> +			break;
> +
> +		/*
> +		 * Check if the search is restricted to the same core or
> +		 * the same node.
> +		 */
> +		if (flags & SCX_PICK_IDLE_IN_NODE)
> +			break;

If SCX_PICK_IDLE_IN_NODE is set, you can avoid the loop at all, right?
Just:
	if (flags & SCX_PICK_IDLE_IN_NODE)
	        return pick_idle_cpu_from_node(cpus_allowed, node, flags);

	for_each_numa_node(node, unvisited, N_POSSIBLE) {
		cpu = pick_idle_cpu_from_node(cpus_allowed, node, flags);
		if (cpu >= 0)
			return cpu;
        }

Thanks,
Yury

