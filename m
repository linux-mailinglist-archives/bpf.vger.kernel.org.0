Return-Path: <bpf+bounces-51004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0654FA2F462
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A2318828AE
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F714256C95;
	Mon, 10 Feb 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pat8wR7T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F7256C61;
	Mon, 10 Feb 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206667; cv=none; b=uTMCXgmrwBQK89kgQIZARnC/7BW/dpNHnKW2qMqFLQXPFXllHNeUzjS5iFUale+ZxaJnImwRyYPYqQwMVLRKYPkajQrk6xPJPI2HSHsTV8r1bWqmkEjuUYkAvaTjzRgYWQ8Y/dYp5zOiPj6Gz2uJOevodZrDGTihDkCtUmY+mFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206667; c=relaxed/simple;
	bh=XfYeMRrae+Q8wnLu94tqacjYLy8fUfYlgHk2r3fqu30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPf7D5bxSm1eh3Z6FEmrIRBpAzltRQ7kGsvuzgT6RTFUVWgM2K5PO4tl/hUDl3KdRAYmx3z7q11GqXAa6i+8neNw6eNxXyssK9aIyasyOYyepCM2cYnQTC3ESr/JtzbJm5PUdqcg5HIEVIxjfUj/4DOC6RunmfuOtfMHofEUF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pat8wR7T; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f3c119fe6so102704005ad.0;
        Mon, 10 Feb 2025 08:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739206665; x=1739811465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Db6pXDKLLvwLw7HfWDefzY1+cycooLCFX8aZ6bd8UMs=;
        b=Pat8wR7ThzBq2lZkRQ86UYYtI6nIdBiZl8fBw/6M8nHFuCDRONUOb8ciGmFkbcxpAX
         xJTAB4ezmHaAt6RepqyYBIrbMF/6EeNJHyFrsSgXoboppdVMgreIQW5fUk0LAFU1LwEf
         G7MCoSfvuh/mS+xJ90aYb795AGs18zwGUejZN7TugVLn9IGMrPbH8opWUB+gQ+rLqiaV
         6Os5aPGiCcyExcElt0LFUWTPTCw/jIAcmXFVBGWkoTwXaomCqtfT7vV41cW5wkx0MghH
         pLVX099iGOS7G7MFAIjsHbnSItKDuByJ0TBuSYyi6jrQBK9ZjY1AglZBGg9l1flLJd+i
         N1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739206665; x=1739811465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db6pXDKLLvwLw7HfWDefzY1+cycooLCFX8aZ6bd8UMs=;
        b=jyKNVy4Sahlr2oH6XSYQdCr/4U9rf4nSOjR8gk/VuB9IZyR9ZqWqcPnpF/chLE1TW3
         Eb5VWHK7UyI7A9GAx5ScRdjZw8Fv3XIt8R7o5tGQGfslSOgmAGO4cib/nv0bCeOl5HN8
         PyUpIMowx7xqAx4uC1ognZKsPeCX3cxU8qsA2LsOJBlHnHN51bucfzgldu6EWkq8TeIL
         9MlYJ5/sG24du5VwRGFbTpqPWX/k4eYZMdVmoWVJBPX8KMtq1Iu1+H202lIY6BAxtpar
         p90WfFVwVlt+A9vO645aLXEP3Lo9Yo5ef2ptgbPChLKj0wd264oDitQWqFbGfXf1KdPh
         laOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRBBFvHl/Jknztjlq8r1rmeC+uWv0H4rkD/nKXHORMR52VNB67tG7jpoSbd0hLu2Z2FeE=@vger.kernel.org, AJvYcCXZLRT6uH/T7ymjwYsfVRRm0cKLdeY6ixq77aKAH8kXD/NmENnfiqZgSHHvv7DMVIggV06bC9r+7gCx9xeU@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVWJtzDFsByG7Haw4JcXfeBlUsDXSd6LW7PUskh7JMCQc/7SA
	9Kz3WYOiZgwBbfeMxv1EHEGhDuzs+/0vmEYV3RYY85I6C2x8t+VA
X-Gm-Gg: ASbGncty3C2SY2eJRi0ruX5YEo+XKD2d3FhT+JxXicqG5r3VLM+4bhT1MHDZTZkW22v
	5dLul2ywSiPYwmfcGrh2eyMW+MNNJvsa0AvcH6r93GigF1AIiIRej8tf6AQzHvGKROv9rriH/KD
	RhJ3HhER4sWZyBjuiZ9iH7ix5aeXuateXqgKcQTW01VgWbc1ZBWfngcRM8GAYPJiYF05hQkznS5
	DGxfeqcq4yywS1QzE63DCT3l2nMmZLPZfQRwaSFitQZhYdZczSHOAwud2/HXB7G/5ekwm6LJw9M
	XOvYEG3T4awCzNo=
X-Google-Smtp-Source: AGHT+IEkuUq+yvBOS2lUZdVNzuAlP5PM2oUDqtoLPse40klbCiZm9IcUlKpqmfZuJkwiaFid0ZRzHg==
X-Received: by 2002:a17:902:d4c1:b0:21f:9736:ba5f with SMTP id d9443c01a7336-21f9736bd9amr64767085ad.23.1739206665194;
        Mon, 10 Feb 2025 08:57:45 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36548e5fsm81193225ad.83.2025.02.10.08.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:57:44 -0800 (PST)
Date: Mon, 10 Feb 2025 11:57:42 -0500
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
Message-ID: <Z6owBvYiArjXvIGC@thinkpad>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-6-arighi@nvidia.com>
 <Z6ju7vFK5TpJamn5@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ju7vFK5TpJamn5@thinkpad>

On Sun, Feb 09, 2025 at 01:07:44PM -0500, Yury Norov wrote:
> On Fri, Feb 07, 2025 at 09:40:52PM +0100, Andrea Righi wrote:
> > Using a single global idle mask can lead to inefficiencies and a lot of
> > stress on the cache coherency protocol on large systems with multiple
> > NUMA nodes, since all the CPUs can create a really intense read/write
> > activity on the single global cpumask.
> 
> Can you put your perf numbers here too?
>  
> > Therefore, split the global cpumask into multiple per-NUMA node cpumasks
> > to improve scalability and performance on large systems.
> > 
> > The concept is that each cpumask will track only the idle CPUs within
> > its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
> > In this way concurrent access to the idle cpumask will be restricted
> > within each NUMA node.
> > 
> > The split of multiple per-node idle cpumasks can be controlled using the
> > SCX_OPS_BUILTIN_IDLE_PER_NODE flag.
> > 
> > By default SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled and a global
> > host-wide idle cpumask is used, maintaining the previous behavior.
> > 
> > NOTE: if a scheduler explicitly enables the per-node idle cpumasks (via
> > SCX_OPS_BUILTIN_IDLE_PER_NODE), scx_bpf_get_idle_cpu/smtmask() will
> > trigger an scx error, since there are no system-wide cpumasks.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext_idle.c | 242 ++++++++++++++++++++++++++++++++--------
> >  kernel/sched/ext_idle.h |  11 +-
> >  2 files changed, 203 insertions(+), 50 deletions(-)
> > 
> > diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> > index a3f2b00903ac2..4b90ec9018c1a 100644
> > --- a/kernel/sched/ext_idle.c
> > +++ b/kernel/sched/ext_idle.c
> > @@ -18,25 +18,88 @@ DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
> >  DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
> >  
> >  #ifdef CONFIG_SMP
> > -#ifdef CONFIG_CPUMASK_OFFSTACK
> > -#define CL_ALIGNED_IF_ONSTACK
> > -#else
> > -#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
> > -#endif
> > -
> >  /* Enable/disable LLC aware optimizations */
> >  DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
> >  
> >  /* Enable/disable NUMA aware optimizations */
> >  DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
> >  
> > -static struct {
> > +/*
> > + * cpumasks to track idle CPUs within each NUMA node.
> > + *
> > + * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled, a single global cpumask
> > + * from is used to track all the idle CPUs in the system.
> > + */
> > +struct idle_cpus {
> >  	cpumask_var_t cpu;
> >  	cpumask_var_t smt;
> > -} idle_masks CL_ALIGNED_IF_ONSTACK;
> > +};
> > +
> > +/*
> > + * Global host-wide idle cpumasks (used when SCX_OPS_BUILTIN_IDLE_PER_NODE
> > + * is not enabled).
> > + */
> > +static struct idle_cpus scx_idle_global_masks;
> > +
> > +/*
> > + * Per-node idle cpumasks.
> > + */
> > +static struct idle_cpus **scx_idle_node_masks;
> > +
> > +/*
> > + * Initialize per-node idle cpumasks.
> > + *
> > + * In case of a single NUMA node or if NUMA support is disabled, only a
> > + * single global host-wide cpumask will be initialized.
> > + */
> > +void scx_idle_init_masks(void)
> > +{
> > +	int node;
> > +
> > +	/* Allocate global idle cpumasks */
> > +	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.cpu, GFP_KERNEL));
> > +	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.smt, GFP_KERNEL));
> > +
> > +	/* Allocate per-node idle cpumasks */
> > +	scx_idle_node_masks = kcalloc(num_possible_nodes(),
> > +				      sizeof(*scx_idle_node_masks), GFP_KERNEL);
> > +	BUG_ON(!scx_idle_node_masks);
> > +
> > +	for_each_node(node) {
> > +		scx_idle_node_masks[node] = kzalloc_node(sizeof(**scx_idle_node_masks),
> > +							 GFP_KERNEL, node);
> > +		BUG_ON(!scx_idle_node_masks[node]);
> > +
> > +		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->cpu, GFP_KERNEL, node));
> > +		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->smt, GFP_KERNEL, node));
> > +	}
> > +}
> > +
> > +/*
> > + * Return the idle masks associated to a target @node.
> > + */
> > +static struct idle_cpus *idle_cpumask(int node)
> > +{
> > +	return node == NUMA_NO_NODE ? &scx_idle_global_masks : scx_idle_node_masks[node];
> > +}
> > +
> > +/*
> > + * Return the node id associated to a target idle CPU (used to determine
> > + * the proper idle cpumask).
> > + */
> > +static int idle_cpu_to_node(int cpu)
> > +{
> > +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> > +		return NUMA_NO_NODE;
> > +
> > +	return cpu_to_node(cpu);
> > +}
> >  
> >  bool scx_idle_test_and_clear_cpu(int cpu)
> >  {
> > +	int node = idle_cpu_to_node(cpu);
> > +	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
> > +
> >  #ifdef CONFIG_SCHED_SMT
> >  	/*
> >  	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
> > @@ -45,33 +108,38 @@ bool scx_idle_test_and_clear_cpu(int cpu)
> >  	 */
> >  	if (sched_smt_active()) {
> >  		const struct cpumask *smt = cpu_smt_mask(cpu);
> > +		struct cpumask *idle_smts = idle_cpumask(node)->smt;
> >  
> >  		/*
> >  		 * If offline, @cpu is not its own sibling and
> >  		 * scx_pick_idle_cpu() can get caught in an infinite loop as
> > -		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
> > -		 * is eventually cleared.
> > +		 * @cpu is never cleared from the idle SMT mask. Ensure that
> > +		 * @cpu is eventually cleared.
> >  		 *
> >  		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
> >  		 * reduce memory writes, which may help alleviate cache
> >  		 * coherence pressure.
> >  		 */
> > -		if (cpumask_intersects(smt, idle_masks.smt))
> > -			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> > -		else if (cpumask_test_cpu(cpu, idle_masks.smt))
> > -			__cpumask_clear_cpu(cpu, idle_masks.smt);
> > +		if (cpumask_intersects(smt, idle_smts))
> > +			cpumask_andnot(idle_smts, idle_smts, smt);
> > +		else if (cpumask_test_cpu(cpu, idle_smts))
> > +			__cpumask_clear_cpu(cpu, idle_smts);
> >  	}
> >  #endif
> > -	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
> > +
> > +	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
> >  }
> >  
> > -s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> > +/*
> > + * Pick an idle CPU in a specific NUMA node.
> > + */
> > +s32 pick_idle_cpu_from_node(const struct cpumask *cpus_allowed, int node, u64 flags)
> >  {
> >  	int cpu;
> >  
> >  retry:
> >  	if (sched_smt_active()) {
> > -		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
> > +		cpu = cpumask_any_and_distribute(idle_cpumask(node)->smt, cpus_allowed);
> >  		if (cpu < nr_cpu_ids)
> >  			goto found;
> >  
> > @@ -79,7 +147,7 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> >  			return -EBUSY;
> >  	}
> >  
> > -	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
> > +	cpu = cpumask_any_and_distribute(idle_cpumask(node)->cpu, cpus_allowed);
> >  	if (cpu >= nr_cpu_ids)
> >  		return -EBUSY;
> >  
> > @@ -90,6 +158,55 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> >  		goto retry;
> >  }
> >  
> > +/*
> > + * Find the best idle CPU in the system, relative to @node.
> > + */
> > +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> > +{
> > +	nodemask_t unvisited = NODE_MASK_ALL;

This should be a NODEMASK_ALLOC(). We don't want to eat up too much of the
stack, right?

> > +	s32 cpu = -EBUSY;
> > +
> > +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> > +		return pick_idle_cpu_from_node(cpus_allowed, NUMA_NO_NODE, flags);
> > +
> > +	/*
> > +	 * If an initial node is not specified, start with the current
> > +	 * node.
> > +	 */
> > +	if (node == NUMA_NO_NODE)
> > +		node = numa_node_id();
> > +
> > +	/*
> > +	 * Traverse all nodes in order of increasing distance, starting
> > +	 * from @node.
> > +	 *
> > +	 * This loop is O(N^2), with N being the amount of NUMA nodes,
> > +	 * which might be quite expensive in large NUMA systems. However,
> > +	 * this complexity comes into play only when a scheduler enables
> > +	 * SCX_OPS_BUILTIN_IDLE_PER_NODE and it's requesting an idle CPU
> > +	 * without specifying a target NUMA node, so it shouldn't be a
> > +	 * bottleneck is most cases.
> > +	 *
> > +	 * As a future optimization we may want to cache the list of hop
> > +	 * nodes in a per-node array, instead of actually traversing them
> > +	 * every time.
> > +	 */
> > +	for_each_numa_node(node, unvisited, N_POSSIBLE) {
> > +		cpu = pick_idle_cpu_from_node(cpus_allowed, node, flags);
> > +		if (cpu >= 0)
> > +			break;
> > +
> > +		/*
> > +		 * Check if the search is restricted to the same core or
> > +		 * the same node.
> > +		 */
> > +		if (flags & SCX_PICK_IDLE_IN_NODE)
> > +			break;
> 
> If SCX_PICK_IDLE_IN_NODE is set, you can avoid the loop at all, right?
> Just:
> 	if (flags & SCX_PICK_IDLE_IN_NODE)
> 	        return pick_idle_cpu_from_node(cpus_allowed, node, flags);
> 
> 	for_each_numa_node(node, unvisited, N_POSSIBLE) {
> 		cpu = pick_idle_cpu_from_node(cpus_allowed, node, flags);
> 		if (cpu >= 0)
> 			return cpu;
>         }
> 
> Thanks,
> Yury

