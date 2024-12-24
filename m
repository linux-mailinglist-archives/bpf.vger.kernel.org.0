Return-Path: <bpf+bounces-47576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AEA9FB914
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 05:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97227165138
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 04:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD918129A78;
	Tue, 24 Dec 2024 04:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aePQNiEm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659D442C;
	Tue, 24 Dec 2024 04:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735013159; cv=none; b=HlMEkdyUGVWc+OikgrgDZ9c7jlhIgSeIJo8dbz8/zaUV7+Y1d3tULcWF/3nuEnNRVmRM0lUcW5tG2A5forrdY/RPNO1ZltQgM78ubYFPqFuPBuzPlO91mMqoqYY2loS4q1FzedmE6h8R2SM2Mn9e1nbO6enploavnJ1R/vz/GYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735013159; c=relaxed/simple;
	bh=L2ZetoE1Z024vex9gjmVAXVVOo0wIQcyG16BraX9ui0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7w+arus9wVuj9MzIXpridtdkWEd0H6/UnrIICiKzalWtZq7Ww+HHks2xLyPSgFUlD5V2WShuS0QXMrLb4OEyPQd8RnqkvuCVJrBnxhYgsk4tdqAWal/P+mBheqRzv+EsK/HPKcV/stfXhvizSyhaeomGKHRUd5Cw6ZVQF77Fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aePQNiEm; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e53537d8feeso3988317276.0;
        Mon, 23 Dec 2024 20:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735013156; x=1735617956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRoILmkTIHM6JaMgI7aGBRSL+HR4X3/lpdekjTCUJ/c=;
        b=aePQNiEm7bma5aTizQpzoLv1KjmVeWUZ3fuBgUbJGxGwWkVfTmACkAw8L8gK2nLYCM
         MvsZhrj8lW9N2LLI4s9LJTrX/aVQL1ohILJv62SjHnuW/piY1rrSOusP6eS+ta6Y+n5r
         GEzGj79CWunyH2v1hy1bILLXGZE4Gycmi8CzIpMJXUs4Lw0dmp2qeK1iFHwirvg+kN3D
         vUbYdWgr9OGZmRRqrYLg8wZglA3falImR+pDJ7gjczCf3eGGUTuks6Yh25lutIHRyBr0
         FL1uB6WBpiyca3d862vusVoIak2NjBktIHbhLdLPWs0UCktmq+6JGLF1pVV62Wkrx7k/
         m3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735013156; x=1735617956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRoILmkTIHM6JaMgI7aGBRSL+HR4X3/lpdekjTCUJ/c=;
        b=uN0uccDkCPcSXWUzXxjZxp/KYeP6VaCxeOBuKg+60zRB18gkluDdEkD2VnMGVdafEx
         9pSEK6n+wrLgnsPzvlHmSEB1JuK1i7CsHgY5IT9pcbZJ0m0AuPJX7rzpbaEE1JKPwCjj
         r+wGARIKMqSmfJXIyQ0arq4MvYmGb0dlrV5aa99w7XlRj0v77g+n8duvIauPh+C/u4zY
         qjW4ZhrPTMavBkLXjgkMvO0S1sjWqwv/3V60zKpi4iVaLGRjk+rkBes8pCLffHOgMMYM
         eW9hObDRzgvNzlLhdq82hAQ5gGO8MYoMqO1gLzOZFK2uwk+BYvCVk3PayfwopynJwJqa
         MLJw==
X-Forwarded-Encrypted: i=1; AJvYcCUasGbQ8LdjedYFz1I6hhGWywIBHmMW4YqWYajA8FzVQOG67r0E7eaZjA2CR2mcL0AO6Gv+PMFs0049p2rs@vger.kernel.org, AJvYcCV8gz/o2wXGxAGyNB5jgaVNq+dzZuWEloBnRrl4CCGsWExZtLJcQa27GdiC3Uyd3tKNIKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3vH+oxuyW96YDUMl4IKCcE4F+WP/XDYiGCqCICNFs0Ma9TIR
	4/Huupj1RzTWjxAef2wVy4C3j+NqnXYWnB/JQNBQmIJxIbMGKuuTiI8it8qu
X-Gm-Gg: ASbGnctQ4cr0Lh03uXXH9vkikdlkWO85M6isWCRAZ/TP57VIMpDZvf0Zht07kpq0/eR
	tnJLMfhkLu5LT6HF1hy/DaAnZfV0zbNcIb8iMHhUwhTCscCZE7G64ynN2vuXINUUtZiYFUQCNuY
	KKr5PkHSwfTowLl7HEu/3jkIyiyxeYKYZay7kWufywAz03yl453cDiUUuQ2gEWTjoRbyZNIzeYX
	1Uf5HTOPntiO+CTgD1I6Qhm6+Qet7OSYshLzAiCqII4dSC5d6ProhN9U9nX1Pfuh4hwVndxP1Jm
	K1C9HSzb2I15p8q/
X-Google-Smtp-Source: AGHT+IECtqctpl6Lnk6s5+U/qZn6iUCHlGw65sj0017CzLmh5ErXCOYRooEZuJbpxfJPaRFrRs1zmQ==
X-Received: by 2002:a05:690c:d96:b0:6ef:805c:ea15 with SMTP id 00721157ae682-6f3f815b496mr95524107b3.23.1735013155883;
        Mon, 23 Dec 2024 20:05:55 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7895f59sm26688647b3.125.2024.12.23.20.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 20:05:55 -0800 (PST)
Date: Mon, 23 Dec 2024 20:05:53 -0800
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
	Valentin Schneider <vschneid@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] sched_ext: Introduce per-node idle cpumasks
Message-ID: <Z2ozISbYmWPj7VNA@yury-ThinkPad>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-8-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154107.287478-8-arighi@nvidia.com>

On Fri, Dec 20, 2024 at 04:11:39PM +0100, Andrea Righi wrote:
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
> NOTE: if a scheduler enables the per-node idle cpumasks (via
> SCX_OPS_BUILTIN_IDLE_PER_NODE), scx_bpf_get_idle_cpu/smtmask() will
> trigger an scx error, since there are no system-wide cpumasks.
> 
> By default (when SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled), only the
> cpumask of node 0 is used as a single global flat CPU mask, maintaining
> the previous behavior.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

This is a rather big patch... Can you split it somehow? Maybe
introduce new functions in a separate patch, and use them in the
following patch(es)?

> ---
>  kernel/sched/ext.c      |   7 +-
>  kernel/sched/ext_idle.c | 258 +++++++++++++++++++++++++++++++---------
>  2 files changed, 208 insertions(+), 57 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 148ec04d4a0a..143938e935f1 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3228,7 +3228,7 @@ static void handle_hotplug(struct rq *rq, bool online)
>  	atomic_long_inc(&scx_hotplug_seq);
>  
>  	if (scx_enabled())
> -		update_selcpu_topology();
> +		update_selcpu_topology(&scx_ops);
>  
>  	if (online && SCX_HAS_OP(cpu_online))
>  		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
> @@ -5107,7 +5107,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  	check_hotplug_seq(ops);
>  #ifdef CONFIG_SMP
> -	update_selcpu_topology();
> +	update_selcpu_topology(ops);
>  #endif
>  	cpus_read_unlock();
>  
> @@ -5800,8 +5800,7 @@ void __init init_sched_ext_class(void)
>  
>  	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
>  #ifdef CONFIG_SMP
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
> +	idle_masks_init();
>  #endif
>  	scx_kick_cpus_pnt_seqs =
>  		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 4952e2793304..444f2a15f1d4 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -10,7 +10,14 @@
>   * Copyright (c) 2024 Andrea Righi <arighi@nvidia.com>
>   */
>  
> +/*
> + * If NUMA awareness is disabled consider only node 0 as a single global
> + * NUMA node.
> + */
> +#define NUMA_FLAT_NODE	0

If it's a global idle node maybe 

 #define GLOBAL_IDLE_NODE	0

This actually bypasses NUMA, so it's weird to mention NUMA here.

> +
>  static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
> +static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
>  
>  static bool check_builtin_idle_enabled(void)
>  {
> @@ -22,22 +29,82 @@ static bool check_builtin_idle_enabled(void)
>  }
>  
>  #ifdef CONFIG_SMP
> -#ifdef CONFIG_CPUMASK_OFFSTACK
> -#define CL_ALIGNED_IF_ONSTACK
> -#else
> -#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
> -#endif
> -
> -static struct {
> +struct idle_cpumask {
>  	cpumask_var_t cpu;
>  	cpumask_var_t smt;
> -} idle_masks CL_ALIGNED_IF_ONSTACK;
> +};

We already have struct cpumask, and this struct idle_cpumask may
mislead. Maybe struct idle_cpus or something?

> +
> +/*
> + * cpumasks to track idle CPUs within each NUMA node.
> + *
> + * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
> + * from node 0 is used to track all idle CPUs system-wide.
> + */
> +static struct idle_cpumask **scx_idle_masks;
> +
> +static struct idle_cpumask *get_idle_mask(int node)

Didn't we agree to drop this 'get' thing?

> +{
> +	if (node == NUMA_NO_NODE)
> +		node = numa_node_id();
> +	else if (WARN_ON_ONCE(node < 0 || node >= nr_node_ids))
> +		return NULL;

Kernel users always provide correct parameters. I don't even think you
need to check for NO_NODE, because if I as user of your API need to
provide current node, I can use numa_node_id() just as well.

If you drop all that sanity bloating, your function will be a
one-liner, and the question is: do you need it at all?

We usually need such wrappers to apply 'const' qualifier or do some
housekeeping before dereferencing. But in this case you just return
a pointer, and I don't understand why local users can't do it
themself.

The following idle_mask_init() happily ignores just added accessor...

> +	return scx_idle_masks[node];
> +}

> +
> +static struct cpumask *get_idle_cpumask(int node)
> +{
> +	struct idle_cpumask *mask = get_idle_mask(node);
> +
> +	return mask ? mask->cpu : cpu_none_mask;
> +}
> +
> +static struct cpumask *get_idle_smtmask(int node)
> +{
> +	struct idle_cpumask *mask = get_idle_mask(node);
> +
> +	return mask ? mask->smt : cpu_none_mask;
> +}

For those two guys... I think you agreed with Tejun that you don't
need them. To me the following is more verbose:
        
        idle_cpus(node)->smt;

> +
> +static void idle_masks_init(void)
> +{
> +	int node;
> +
> +	scx_idle_masks = kcalloc(num_possible_nodes(), sizeof(*scx_idle_masks), GFP_KERNEL);
> +	BUG_ON(!scx_idle_masks);
> +
> +	for_each_node_state(node, N_POSSIBLE) {
> +		scx_idle_masks[node] = kzalloc_node(sizeof(**scx_idle_masks), GFP_KERNEL, node);
> +		BUG_ON(!scx_idle_masks[node]);
> +
> +		BUG_ON(!alloc_cpumask_var_node(&scx_idle_masks[node]->cpu, GFP_KERNEL, node));
> +		BUG_ON(!alloc_cpumask_var_node(&scx_idle_masks[node]->smt, GFP_KERNEL, node));
> +	}
> +}
>  
>  static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
>  static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
>  
> +/*
> + * Return the node id associated to a target idle CPU (used to determine
> + * the proper idle cpumask).
> + */
> +static int idle_cpu_to_node(int cpu)
> +{
> +	int node;
> +
> +	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> +		node = cpu_to_node(cpu);

Nit: can you just return cpu_to_node(cpu). This will save 3 LOCs

> +	else
> +		node = NUMA_FLAT_NODE;
> +
> +	return node;
> +}
> +
>  static bool test_and_clear_cpu_idle(int cpu)
>  {
> +	int node = idle_cpu_to_node(cpu);
> +	struct cpumask *idle_cpus = get_idle_cpumask(node);
> +
>  #ifdef CONFIG_SCHED_SMT
>  	/*
>  	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
> @@ -46,33 +113,37 @@ static bool test_and_clear_cpu_idle(int cpu)
>  	 */
>  	if (sched_smt_active()) {
>  		const struct cpumask *smt = cpu_smt_mask(cpu);
> +		struct cpumask *idle_smts = get_idle_smtmask(node);
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
> +	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
>  }
>  
> -static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> +/*
> + * Pick an idle CPU in a specific NUMA node.
> + */
> +static s32 pick_idle_cpu_from_node(const struct cpumask *cpus_allowed, int node, u64 flags)
>  {
>  	int cpu;
>  
>  retry:
>  	if (sched_smt_active()) {
> -		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
> +		cpu = cpumask_any_and_distribute(get_idle_smtmask(node), cpus_allowed);
>  		if (cpu < nr_cpu_ids)
>  			goto found;
>  
> @@ -80,15 +151,57 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
>  			return -EBUSY;
>  	}
>  
> -	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
> +	cpu = cpumask_any_and_distribute(get_idle_cpumask(node), cpus_allowed);
>  	if (cpu >= nr_cpu_ids)
>  		return -EBUSY;
>  
>  found:
>  	if (test_and_clear_cpu_idle(cpu))
>  		return cpu;
> -	else
> -		goto retry;
> +	goto retry;
> +}

Yes, I see this too. But to me minimizing your patch and preserving as
much history as you can is more important.

After all, newcomers should have a room to practice :)

> +
> +/*
> + * Find the best idle CPU in the system, relative to @node.
> + *
> + * If @node is NUMA_NO_NODE, start from the current node.
> + */

And if you don't invent this rule for kernel users, you don't need to
explain it everywhere.

> +static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> +{
> +	nodemask_t hop_nodes = NODE_MASK_NONE;
> +	s32 cpu = -EBUSY;
> +
> +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> +		return pick_idle_cpu_from_node(cpus_allowed, NUMA_FLAT_NODE, flags);
> +
> +	/*
> +	 * If a NUMA node was not specified, start with the current one.
> +	 */
> +	if (node == NUMA_NO_NODE)
> +		node = numa_node_id();

And enforce too...

> +
> +	/*
> +	 * Traverse all nodes in order of increasing distance, starting
> +	 * from prev_cpu's node.
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
> +	for_each_numa_hop_node(n, node, hop_nodes, N_POSSIBLE) {
> +		cpu = pick_idle_cpu_from_node(cpus_allowed, n, flags);
> +		if (cpu >= 0)
> +			break;
> +	}
> +
> +	return cpu;
>  }
>  
>  /*
> @@ -208,7 +321,7 @@ static bool llc_numa_mismatch(void)
>   * CPU belongs to a single LLC domain, and that each LLC domain is entirely
>   * contained within a single NUMA node.
>   */
> -static void update_selcpu_topology(void)
> +static void update_selcpu_topology(struct sched_ext_ops *ops)
>  {
>  	bool enable_llc = false, enable_numa = false;
>  	unsigned int nr_cpus;
> @@ -298,6 +411,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  {
>  	const struct cpumask *llc_cpus = NULL;
>  	const struct cpumask *numa_cpus = NULL;
> +	int node = idle_cpu_to_node(prev_cpu);
>  	s32 cpu;
>  
>  	*found = false;
> @@ -355,9 +469,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		 * piled up on it even if there is an idle core elsewhere on
>  		 * the system.
>  		 */
> -		if (!cpumask_empty(idle_masks.cpu) &&
> -		    !(current->flags & PF_EXITING) &&
> -		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
> +		if (!(current->flags & PF_EXITING) &&
> +		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
> +		    !cpumask_empty(get_idle_cpumask(idle_cpu_to_node(cpu)))) {
>  			if (cpumask_test_cpu(cpu, p->cpus_ptr))
>  				goto cpu_found;
>  		}
> @@ -371,7 +485,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		/*
>  		 * Keep using @prev_cpu if it's part of a fully idle core.
>  		 */
> -		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
> +		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask(node)) &&
>  		    test_and_clear_cpu_idle(prev_cpu)) {
>  			cpu = prev_cpu;
>  			goto cpu_found;
> @@ -381,7 +495,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		 * Search for any fully idle core in the same LLC domain.
>  		 */
>  		if (llc_cpus) {
> -			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
> +			cpu = pick_idle_cpu_from_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
>  			if (cpu >= 0)
>  				goto cpu_found;
>  		}
> @@ -390,15 +504,19 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		 * Search for any fully idle core in the same NUMA node.
>  		 */
>  		if (numa_cpus) {
> -			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
> +			cpu = scx_pick_idle_cpu(numa_cpus, node, SCX_PICK_IDLE_CORE);
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
> @@ -415,7 +533,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	 * Search for any idle CPU in the same LLC domain.
>  	 */
>  	if (llc_cpus) {
> -		cpu = scx_pick_idle_cpu(llc_cpus, 0);
> +		cpu = pick_idle_cpu_from_node(llc_cpus, node, 0);
>  		if (cpu >= 0)
>  			goto cpu_found;
>  	}
> @@ -424,7 +542,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	 * Search for any idle CPU in the same NUMA node.
>  	 */
>  	if (numa_cpus) {
> -		cpu = scx_pick_idle_cpu(numa_cpus, 0);
> +		cpu = pick_idle_cpu_from_node(numa_cpus, node, 0);
>  		if (cpu >= 0)
>  			goto cpu_found;
>  	}
> @@ -432,7 +550,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	/*
>  	 * Search for any idle CPU usable by the task.
>  	 */
> -	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
> +	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
>  	if (cpu >= 0)
>  		goto cpu_found;
>  
> @@ -448,17 +566,33 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  
>  static void reset_idle_masks(void)
>  {
> +	int node;
> +
> +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
> +		cpumask_copy(get_idle_cpumask(NUMA_FLAT_NODE), cpu_online_mask);
> +		cpumask_copy(get_idle_smtmask(NUMA_FLAT_NODE), cpu_online_mask);
> +		return;
> +	}
> +
>  	/*
>  	 * Consider all online cpus idle. Should converge to the actual state
>  	 * quickly.
>  	 */
> -	cpumask_copy(idle_masks.cpu, cpu_online_mask);
> -	cpumask_copy(idle_masks.smt, cpu_online_mask);
> +	for_each_node_state(node, N_POSSIBLE) {
> +		const struct cpumask *node_mask = cpumask_of_node(node);
> +		struct cpumask *idle_cpu = get_idle_cpumask(node);
> +		struct cpumask *idle_smt = get_idle_smtmask(node);
> +
> +		cpumask_and(idle_cpu, cpu_online_mask, node_mask);
> +		cpumask_copy(idle_smt, idle_cpu);

Tejun asked you to use cpumask_and() in both cases, didn't he?

> +	}
>  }
>  
>  void __scx_update_idle(struct rq *rq, bool idle)
>  {
>  	int cpu = cpu_of(rq);
> +	int node = idle_cpu_to_node(cpu);
> +	struct cpumask *idle_cpu = get_idle_cpumask(node);
>  
>  	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
>  		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
> @@ -466,24 +600,25 @@ void __scx_update_idle(struct rq *rq, bool idle)
>  			return;
>  	}
>  
> -	assign_cpu(cpu, idle_masks.cpu, idle);
> +	assign_cpu(cpu, idle_cpu, idle);
>  
>  #ifdef CONFIG_SCHED_SMT
>  	if (sched_smt_active()) {
>  		const struct cpumask *smt = cpu_smt_mask(cpu);
> +		struct cpumask *idle_smt = get_idle_smtmask(node);
>  
>  		if (idle) {
>  			/*
> -			 * idle_masks.smt handling is racy but that's fine as
> -			 * it's only for optimization and self-correcting.
> +			 * idle_smt handling is racy but that's fine as it's
> +			 * only for optimization and self-correcting.
>  			 */
>  			for_each_cpu(cpu, smt) {
> -				if (!cpumask_test_cpu(cpu, idle_masks.cpu))
> +				if (!cpumask_test_cpu(cpu, idle_cpu))
>  					return;
>  			}
> -			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
> +			cpumask_or(idle_smt, idle_smt, smt);
>  		} else {
> -			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> +			cpumask_andnot(idle_smt, idle_smt, smt);
>  		}
>  	}
>  #endif
> @@ -491,8 +626,23 @@ void __scx_update_idle(struct rq *rq, bool idle)
>  
>  #else	/* !CONFIG_SMP */
>  
> +static struct cpumask *get_idle_cpumask(int node)
> +{
> +	return cpu_none_mask;
> +}
> +
> +static struct cpumask *get_idle_smtmask(int node)
> +{
> +	return cpu_none_mask;
> +}
> +
>  static bool test_and_clear_cpu_idle(int cpu) { return false; }
> -static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags) { return -EBUSY; }
> +
> +static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> +{
> +	return -EBUSY;
> +}
> +
>  static void reset_idle_masks(void) {}
>  
>  #endif	/* CONFIG_SMP */
> @@ -546,11 +696,12 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
>  	if (!check_builtin_idle_enabled())
>  		return cpu_none_mask;
>  
> -#ifdef CONFIG_SMP
> -	return idle_masks.cpu;
> -#else
> -	return cpu_none_mask;
> -#endif
> +	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
> +		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
> +		return cpu_none_mask;
> +	}
> +
> +	return get_idle_cpumask(NUMA_FLAT_NODE);
>  }
>  
>  /**
> @@ -565,14 +716,15 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
>  	if (!check_builtin_idle_enabled())
>  		return cpu_none_mask;
>  
> -#ifdef CONFIG_SMP
> +	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
> +		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
> +		return cpu_none_mask;
> +	}
> +
>  	if (sched_smt_active())
> -		return idle_masks.smt;
> +		return get_idle_smtmask(NUMA_FLAT_NODE);
>  	else
> -		return idle_masks.cpu;
> -#else
> -	return cpu_none_mask;
> -#endif
> +		return get_idle_cpumask(NUMA_FLAT_NODE);
>  }
>  
>  /**
> @@ -635,7 +787,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
>  	if (!check_builtin_idle_enabled())
>  		return -EBUSY;
>  
> -	return scx_pick_idle_cpu(cpus_allowed, flags);
> +	return scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
>  }
>  
>  /**
> @@ -658,7 +810,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
>  	s32 cpu;
>  
>  	if (static_branch_likely(&scx_builtin_idle_enabled)) {
> -		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
> +		cpu = scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
>  		if (cpu >= 0)
>  			return cpu;
>  	}
> -- 
> 2.47.1

