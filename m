Return-Path: <bpf+bounces-47561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA489FB606
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 22:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2EA1883B73
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 21:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633F01C4A34;
	Mon, 23 Dec 2024 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIIwzfzz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A25618052;
	Mon, 23 Dec 2024 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734988694; cv=none; b=TMsMb8qBfxpvc5dtw4alLl9ha0SmyWWEDBPKD+PHmNyZnCXuwWEERyuPBj0O6CYORgbGc9w5aE5b1WRKvE9Yc0ibpTwonHoQvrUDmVabQkQ2Bf80jMQ23alCnuTk4hUmZiJ2n8HRAvzlZXGzZToqWm0fsn0FV3/DVrOLYKAJYRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734988694; c=relaxed/simple;
	bh=Xav0ANLA2yG+Cap1+l6oAj5RdzSyhp39IAZxPjplMqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgKL8jCoLjtAb053W8B3RaUV7WYW4xmXJUYJgHd5jBh1bzpNipfG6nNX2XSrYmv+ZadCsuJ/tTR+d6AlaS/EeyLxS9eLueqZ+2LAptlUCWys2Fp68v3M8hAwvVN9e0z54P1YECaW8a+3rRDiiH3/URtl6J6LMfvNj8z4eQsxvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIIwzfzz; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e39841c8fd6so3837918276.3;
        Mon, 23 Dec 2024 13:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734988692; x=1735593492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rfFbqN6OtOK7OBXsV0haxH3mriwJYX3JJ+GkEIWy5eQ=;
        b=JIIwzfzzu2BrVUP4iZCiwUghANfwtVUSZaDhitmWo7kdqlLMoSuT/HacmAja96rrNF
         7PAvF/qS2iyJ7oqgCDfwj4WLdmOc1MYX1OzZSex4PWlRNRzkLTaz5Qj1qcSYj+NA5R3x
         +MSrGIavFwnQtpWN7IqNCykBeRARTUtSalZ2ZqEf0Huvh1wsQs6RNSjmZxEM+kXiP/1E
         +9RdbgVPGDuDPpk3vkrpopdmG9+6QvLcQol9+qZt1tV53PGeAEIuoVgK0c5D4suAa3Rx
         QZ8ar3WMQlvuFnhReVKMuneVsG1YmNEytDo/nd7HdzuPjPwQZa1yujoqCOqzUkrKVDeP
         RIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734988692; x=1735593492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfFbqN6OtOK7OBXsV0haxH3mriwJYX3JJ+GkEIWy5eQ=;
        b=kjXhVx0twuKzOzPG1T3R332DjHp/9Mvk49Sp+k4l/vv898NpXZyUBilauYTgIATIAM
         a+AGREmORy6kjZRXOWzN++LnWV8o9ItavP0cDadc5Qp/URl5f1rVBmj7K5rJLY4BIeXv
         FVCePf7Z+Z5ecqkF6eZ5WE/SM7rpIWQRmyxLbleHC55Gbr54kl6aijAeqyxxNC0Ysxap
         r6ag+2VPUkC4MCLZIKS0w5SgItKLIMsgvpumHyi46Zma9sluIKndwZOI2PcBO3FR6j2a
         YI7Fsc7xjr64ug5ub3dBRPEk7Aq4EkNmiuiP/ungCtmRGj2+U/QZ3j7NloEzg3w9Zenq
         8TZw==
X-Forwarded-Encrypted: i=1; AJvYcCWpvSMk36dLENuORYJW/MP9ldrv24LEKlViIezFVz6Q4uzALLDx9UCA2cxGzr6doNX9NW5PwSPU2antvEZ5@vger.kernel.org, AJvYcCXkszA0JtrHJMeGkOgEoKdWhxjJ/tcwkyzOMAuQfd0jHo1/JdiAlJog7qc9c2Ew8P2ZwTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGWQWyxhAePnmXnTT1hDQFuAfVpZZYS6L9cHfmrFh1GIV75Gva
	XQGGwAiGR7rp5SuvkTFQ1vMKDWXJqGTlQ8tXF6LOgeUwV3oDgzlGYmxDy0mm
X-Gm-Gg: ASbGncuRfnp+8erXkjcLWQHFgPIlmg0P9/ebduqixPCYN3RuXoP5CzgXiaYrtKzClaA
	7/pXZ4t8UMwhLduqqjaeMIZEDDl3FGaCYCkdqV5hQeHMdqMwDFvWrHvJLNon3wVGPK8G+12O0Qq
	Wxqp0TONlOaNTOxkIzAN6sSF63y2lgeTxccEk3IsCwTCS7ikKPMP/tLypehbpMAnu/yCrSkJMAJ
	Qov+Db16wVtgIqO13Nn/nrUCmozkx2mu0YCH4C5dZdNQ4UbJ3qVtePBi78cjAJdIk9OkDvM2zsN
	z5UEI767V7PGoASh
X-Google-Smtp-Source: AGHT+IHcABlPWa6lmSkR0V1I2RR9tHzTYq3rm+DP8viVQ+0uLCrZVY8+NFtwMbkFU5wEe4xvs1F14w==
X-Received: by 2002:a05:690c:f8d:b0:6ef:4ed2:7dfe with SMTP id 00721157ae682-6f3f820129emr103988557b3.31.1734988691550;
        Mon, 23 Dec 2024 13:18:11 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e783b174sm25124937b3.123.2024.12.23.13.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 13:18:11 -0800 (PST)
Date: Mon, 23 Dec 2024 13:18:10 -0800
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
Subject: Re: [PATCH 01/10] sched/topology: introduce for_each_numa_hop_node()
 / sched_numa_hop_node()
Message-ID: <Z2nTkshW2sUmNLVA@yury-ThinkPad>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154107.287478-2-arighi@nvidia.com>

On Fri, Dec 20, 2024 at 04:11:33PM +0100, Andrea Righi wrote:
> Introduce for_each_numa_hop_node() and sched_numa_hop_node() to iterate
> over node IDs in order of increasing NUMA distance from a given starting
> node.
> 
> These iterator functions are similar to for_each_numa_hop_mask() and
> sched_numa_hop_mask(), but instead of providing a cpumask at each
> iteration, they provide a node ID.
> 
> Example usage:
> 
>   nodemask_t hop_nodes = NODE_MASK_NONE;
>   int start = cpu_to_node(smp_processor_id());
> 
>   for_each_numa_hop_node(node, start, hop_nodes, N_ONLINE)
>   	pr_info("node (%d, %d) -> \n",
>   		 start, node, node_distance(start, node);

This iterates nodes, not hops. The hop is a set of equidistant nodes,
and the iterator (the first argument) should be a nodemask. I'm OK with
that as soon as you find it practical. But then you shouldn't mention
hops in the patch.

Also, can you check that it works correctly against a configuration with
equidistant nodes?

> Simulating the following NUMA topology in virtme-ng:
> 
>  $ numactl -H
>  available: 4 nodes (0-3)
>  node 0 cpus: 0 1
>  node 0 size: 1006 MB
>  node 0 free: 928 MB
>  node 1 cpus: 2 3
>  node 1 size: 1007 MB
>  node 1 free: 986 MB
>  node 2 cpus: 4 5
>  node 2 size: 889 MB
>  node 2 free: 862 MB
>  node 3 cpus: 6 7
>  node 3 size: 1006 MB
>  node 3 free: 983 MB
>  node distances:
>  node     0    1    2    3
>     0:   10   51   31   41
>     1:   51   10   21   61
>     2:   31   21   10   11
>     3:   41   61   11   10
> 
> The output of the example above (on node 0) is the following:
> 
>  [   84.953644] node (0, 0) -> 10
>  [   84.953712] node (0, 2) -> 31
>  [   84.953764] node (0, 3) -> 41
>  [   84.953817] node (0, 1) -> 51
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  include/linux/topology.h | 28 ++++++++++++++++++++++-
>  kernel/sched/topology.c  | 49 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 52f5850730b3..d9014d90580d 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -248,12 +248,18 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
>  #ifdef CONFIG_NUMA
>  int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node);
>  extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops);
> -#else
> +extern int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state);
> +#else /* !CONFIG_NUMA */
>  static __always_inline int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
>  {
>  	return cpumask_nth_and(cpu, cpus, cpu_online_mask);
>  }
>  
> +static inline int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state)
> +{
> +	return NUMA_NO_NODE;
> +}
> +
>  static inline const struct cpumask *
>  sched_numa_hop_mask(unsigned int node, unsigned int hops)
>  {
> @@ -261,6 +267,26 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
>  }
>  #endif	/* CONFIG_NUMA */
>  
> +/**
> + * for_each_numa_hop_node - iterate over NUMA nodes at increasing hop distances
> + *                          from a given starting node.
> + * @__node: the iteration variable, representing the current NUMA node.
> + * @__start: the NUMA node to start the iteration from.
> + * @__hop_nodes: a nodemask_t to track the visited nodes.
> + * @__state: state of NUMA nodes to iterate.
> + *
> + * Requires rcu_lock to be held.
> + *
> + * This macro iterates over NUMA nodes in increasing distance from
> + * @start_node.
> + *
> + * Yields NUMA_NO_NODE when all the nodes have been visited.
> + */
> +#define for_each_numa_hop_node(__node, __start, __hop_nodes, __state)		\

As soon as this is not the hops iterator, the proper name would be just

        for_each_numa_node()

And because the 'numa' prefix here doesn't look like a prefix, I think
it would be nice to comment what this 'numa' means and what's the
difference between this and for_each_node() iterator, especially in
terms of complexity.

Also you don't need underscores in macro declarations unless
absolutely necessary.

> +	for (int __node = __start;						\

The __node declared in for() masks out the __node provided in the
macro.

> +	     __node != NUMA_NO_NODE;						\
> +	     __node = sched_numa_hop_node(&(__hop_nodes), __start, __state))
> +
>  /**
>   * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
>   *                          from a given node.
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..8e77c235ad9a 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2185,6 +2185,55 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
>  }
>  EXPORT_SYMBOL_GPL(sched_numa_find_nth_cpu);
>  
> +/**
> + * sched_numa_hop_node - Find the NUMA node at the closest hop distance
> + *                       from node @start.
> + *
> + * @hop_nodes: a pointer to a nodemask_t representing the visited nodes.
> + * @start: the NUMA node to start the hop search from.
> + * @state: the node state to filter nodes by.
> + *
> + * This function iterates over all NUMA nodes in the given state and
> + * calculates the hop distance to the starting node. It returns the NUMA
> + * node that is the closest in terms of hop distance
> + * that has not already been considered (not set in @hop_nodes). If the
> + * node is found, it is marked as considered in the @hop_nodes bitmask.
> + *
> + * The function checks if the node is not the start node and ensures it is
> + * not already part of the hop_nodes set. It then computes the distance to
> + * the start node using the node_distance() function. The closest node is
> + * chosen based on the minimum distance.
> + *
> + * Returns the NUMA node ID closest in terms of hop distance from the
> + * @start node, or NUMA_NO_NODE if no node is found (or all nodes have been
> + * visited).

for_each_node_state() returns MAX_NUMNODES when it finishes
traversing. I think you should do the same here. 

> + */
> +int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state)
> +{
> +	int dist, n, min_node, min_dist;
> +
> +	if (state >= NR_NODE_STATES)
> +		return NUMA_NO_NODE;

 -EINVAL. But, do we need to check the parameter at all?

> +
> +	min_node = NUMA_NO_NODE;
> +	min_dist = INT_MAX;
> +
> +	for_each_node_state(n, state) {
> +		if (n == start || node_isset(n, *hop_nodes))
> +			continue;
> +		dist = node_distance(start, n);
> +		if (dist < min_dist) {
> +			min_dist = dist;
> +			min_node = n;
> +		}
> +	}

This is a version of numa_nearest_node(). The only difference is that
you add 'hop_nodes' mask, which in fact is 'visited' nodes.

I think it should be like:

 int numa_nearest_unvisited_node(nodemask_t *visited, int start, unsigned int state)
 {
        for_each_node_andnot(node_states[state], visited) (
                ...
        }
 }

Thanks,
Yury

> +	if (min_node != NUMA_NO_NODE)
> +		node_set(min_node, *hop_nodes);
> +
> +	return min_node;
> +}
> +EXPORT_SYMBOL_GPL(sched_numa_hop_node);
> +
>  /**
>   * sched_numa_hop_mask() - Get the cpumask of CPUs at most @hops hops away from
>   *                         @node
> -- 
> 2.47.1

