Return-Path: <bpf+bounces-50815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9E6A2D080
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 23:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C16A1888F43
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F541B0409;
	Fri,  7 Feb 2025 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKxJkumQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1239502BE;
	Fri,  7 Feb 2025 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967438; cv=none; b=bgXcqW60EV05oBCCRz9zrNO/YbLPNhfIH9V9vS/eYxx9BIVl60vLln2dxQTYxqbnmJ/0hfZcpNtKzLZb2cfJBpQvqSLJv6nWXblI5MjBMdeJtkveJcLJbrFkW1bYODIbRGHL5tsdkWWpiX6BtdDa+0s50lKjV1O6Tuu8J6/UPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967438; c=relaxed/simple;
	bh=QWhAu2OFt+EcyVIJFJNCIRag3WhrVrPecqNWFTdZByw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc5+T/hlVwDlwhFqXbS/1scSppHoxA/U7R5muEyMdOx2Oyga9P3nG3VG8eX56uYZAaBJtRfFyOtLOOFETIf91p6Ry0ompT46fBde1HDrMmn2MDVAyf84SeDVN7pjHiSuCLYigPS5Y4Y1iRrMzY5l2qW1WCU0GhAuxPVztcjFl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKxJkumQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271F5C4CED1;
	Fri,  7 Feb 2025 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738967438;
	bh=QWhAu2OFt+EcyVIJFJNCIRag3WhrVrPecqNWFTdZByw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKxJkumQhUPgGWAsqWW2kTJ27fp/W+zPCJeVYydLPw9ikhWoEtUHEYp9DznKWRQtC
	 WWixNS13A5/Eg03mx4GriQ5fCkjMVxqkfs0FvReMn+DP9EDW0wIaKIfTLuHk2n3HI8
	 PTL/U7V1HEMzoZ2SUSDh0jBuA2Y0egnfuqS0QKqt/VpAYSpzWHCuc+TWc2CBzKdNes
	 gjYHOBAH28dTWYg6VuBms3HWgaARd9ZKwyZqSHXv9XrTD+3SCAqH6KKa5FeTIiycRc
	 bBOYgxiyMo+CMVYfVE2GLhLScU6IyWd52+hjTx4E50QxqRsZYPPlAYQfYLstUoH7JE
	 mF8xbAOUylJSA==
Date: Fri, 7 Feb 2025 12:30:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: idle: Per-node idle cpumasks
Message-ID: <Z6aJjTFNJKjDfG77@slm.duckdns.org>
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

Hello,

On Fri, Feb 07, 2025 at 09:40:52PM +0100, Andrea Righi wrote:
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

Can you prefix the type name with scx_?

Unrelated to this series but I wonder whether we can replace "smt" with
"core" in the future to become more consistent with how the terms are used
in the kernel:

  struct scx_idle_masks {
          cpumask_var_t   cpus;
          cpumask_var_t   cores;
  };

We expose "smt" name through kfuncs but we can rename that to "core" through
compat macros later too.

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

Maybe rename pick_idle_cpu_in_node() to stay in sync with
SCX_PICK_IDLE_IN_NODE? It's not like pick_idle_cpu_from_node() walks from
the node, right? It just picks within the node.

> @@ -460,38 +582,50 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
>  
>  void scx_idle_reset_masks(void)
>  {
> +	int node;
> +
> +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
> +		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->cpu, cpu_online_mask);
> +		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->smt, cpu_online_mask);
> +		return;
> +	}
> +
>  	/*
>  	 * Consider all online cpus idle. Should converge to the actual state
>  	 * quickly.
>  	 */
> -	cpumask_copy(idle_masks.cpu, cpu_online_mask);
> -	cpumask_copy(idle_masks.smt, cpu_online_mask);
> -}
> +	for_each_node(node) {
> +		const struct cpumask *node_mask = cpumask_of_node(node);
> +		struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
> +		struct cpumask *idle_smts = idle_cpumask(node)->smt;
> -void scx_idle_init_masks(void)
> -{
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
> +		cpumask_and(idle_cpus, cpu_online_mask, node_mask);
> +		cpumask_copy(idle_smts, idle_cpus);
> +	}

nitpick: Maybe something like the following is more symmetric with the
global case and easier to read?

  for_each_node(node) {
        const struct cpumask *node_mask = cpumask_of_node(node);
        cpumask_and(idle_cpumask(node)->cpu, cpu_online_mask, node_mask);
        cpumask_and(idle_cpumask(node)->smt, cpu_online_mask, node_mask);
  }

>  }
>  
>  static void update_builtin_idle(int cpu, bool idle)
>  {
> -	assign_cpu(cpu, idle_masks.cpu, idle);
> +	int node = idle_cpu_to_node(cpu);

minor: I wonder whether idle_cpu_to_node() name is a bit confusing - why
does a CPU being idle have anything to do with its node mapping? If there is
a better naming convention, great. If not, it is what it is.

Thanks.

-- 
tejun

