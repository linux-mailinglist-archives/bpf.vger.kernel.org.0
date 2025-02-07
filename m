Return-Path: <bpf+bounces-50740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D50A2B9F5
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 04:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005A23A77AC
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFCE1DE3D7;
	Fri,  7 Feb 2025 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmWapoMy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473691DE2AE;
	Fri,  7 Feb 2025 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738900646; cv=none; b=kXK7DQGUFI66TkneiACZvfqGkvwdjkWIhtGRIy9aFYOlE+zR3fZIw9HpwCzW55U6lEh+SN9XQ9dhzeptjstlaulrqvM/4DDqM/puz/3XVDCjRZdwZecLJHkrAggoNUsA7nNfKYg8LK+fL+wh3Tdk6nFIYaYIoSfN/3xdZ/sUu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738900646; c=relaxed/simple;
	bh=7byxT3hMLxM0t251F+9XNtF+LTV8OotZeQURjdgop9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH6iYUO/d9SCsnPtsy5E6qQVOwhuLB6LiRIp+C3DoGa8OHo4WbK7a2NSdg7i0wp2XGAe09jPQvombgKXkXLIB2ATWMoSwt6YtDdXFXu+B+WqC7cyMmx8kWaQfLTkaSrmPdiYko6I2g3miqrYMDIH4zahXRh3iLN4ZiDaxEeiNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmWapoMy; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so1476993276.3;
        Thu, 06 Feb 2025 19:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738900643; x=1739505443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=prIFvmcnu9z5rmpK6FPGeBCvYZycqDBMKauv6QTJl5s=;
        b=nmWapoMyx3XF2c8hp4QISlP4VhmorhBmQI493TTJPVCGQDXoRZHxr6cdOA1wMmAaIp
         Yzpkkc+wr8+qf1ouphye5EIg1we2+HSHeo2FB63iv3xxcjDokA4AvO7jb8maxnoKzk1d
         aEXpjXMFYw/5yzXtcFB0wp70uBdxm999JE1U54SyB0Z94ZDNj7+96FoIaveGkRcf7txV
         +DC5YH5axawitX0C63PFJ5BkHUG7x0xrxk60yOiMQUJ53xI1w6PkjBRz2vd+maAJ/UrQ
         3FFX84QSuRG+Y5M8NK0BQ3b9PmWUfNgvQ5FqdFbxq5ajnN45TkZIa+kHbMhBF+oydTMl
         2jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738900643; x=1739505443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prIFvmcnu9z5rmpK6FPGeBCvYZycqDBMKauv6QTJl5s=;
        b=vyaFoEP+zAQzuke3k/8nBdwNNpCkDjt7WdoyJhmKA/x1BnGY5sq+CXmTGG+01fEJmF
         X58UcTMRHVsoAssCjBLYwrameGkMF2r1Qjii8xhWkCE+v6nnnYdVQOAothD+VCR+ghsv
         TIE+LRzELtmoRFDJYzGCl9UcKcZ41b60hOzM7D6bYiLmaTYC0wO1eYabvyhDI0fxxSY6
         g6lIucPIW/+Bo/tNf430MqGjT5q4CBNxrDIMskrFjSnjqTqc/HykT2ZenHK5qsTobgsO
         Z+4Jwj91dRnHT7wpVBMA/EALbNsKr5HEALDtOUj1yTrI5eiYEYEpl6MiCZHx4hi3rfiI
         X6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvoONLYCxllwd/f+2eA77809gqK3gnw449GXCXAVJqL7TaXyKp3T7NbzQ6TOGOhvepOFFPpbpUBtXwbfHm@vger.kernel.org, AJvYcCWwbaJFH0AvNvOBcLCPvjya3ajz3/ygAspw1BUch4vDQe5GluVxVz6LwoZs+GWFxJ2t6GA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54yPoINo58Ou0h596N7jybcsgVFdKbR+/oooFK3O3bY6PVWK8
	qtAfj4xrtuTqQgtsj34ErCVEMzRNnKYYIOEj1zFbYXmtcpJvhV1jrp9W0bbj
X-Gm-Gg: ASbGncv84xi+NOAo5UFpyUqnwe3TveUP8M3lcf1oymT1ha0zWS4fwaRnlFlOREBk3Ue
	TzT3AxB7edQXA1nmfvRg9zPJ4HNzG7KHcD++WHWb6AeXuHpIlndZE/DQ4V06OlWhj3Gf0aX/Q9r
	GduVoK/SncVxuays1opwoJ8Ox/Kx6jJyIHSQBErs4NlyLw2sQB44khslDWCGO/czsyAbxX9GBX6
	Mlu72UZYwI6CJswab7BYpl6ux51SCTnnr+FxCO9vyrAH7Myh3m4SsPZKkoBSILU+6eWudy0FuHA
	0kcVRvZEY+DTFSr7I/ygd2jIZ+ChHu3pCZDvYnOqjOVuJ4B8SXE=
X-Google-Smtp-Source: AGHT+IHqaRXNO9rDFEgp2CWR8dh+6PR+bjLMq0NCM9k9c4eGuIQnblKhdRiK+i8Ps7kKi17zYVMiOQ==
X-Received: by 2002:a05:6902:2602:b0:e57:f841:949f with SMTP id 3f1490d57ef6-e5b461e10e2mr1454221276.19.1738900642827;
        Thu, 06 Feb 2025 19:57:22 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5b3a45d7f1sm643323276.40.2025.02.06.19.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 19:57:21 -0800 (PST)
Date: Thu, 6 Feb 2025 22:57:19 -0500
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
Subject: Re: [PATCH 1/5] sched/topology: Introduce for_each_numa_node()
 iterator
Message-ID: <Z6WEllH4yvzkWCYG@thinkpad>
References: <20250206202109.384179-1-arighi@nvidia.com>
 <20250206202109.384179-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206202109.384179-2-arighi@nvidia.com>

On Thu, Feb 06, 2025 at 09:15:31PM +0100, Andrea Righi wrote:
> Introduce for_each_numa_node() and sched_numa_node() helpers to iterate
> over node IDs in order of increasing NUMA distance from a given starting
> node.
> 
> These iterator functions are similar to for_each_numa_hop_mask() and
> sched_numa_hop_mask(), but instead of providing a cpumask at each
> iteration, they provide a node ID.
> 
> Example usage:
> 
>   nodemask_t visited = NODE_MASK_NONE;
>   int start = cpu_to_node(smp_processor_id());
> 
>   for_each_numa_node(node, start, visited, N_ONLINE)
>   	pr_info("node (%d, %d) -> %d\n",
>   		 start, node, node_distance(start, node));
> 
> On a system with equidistant nodes:
> 
>  $ numactl -H
>  ...
>  node distances:
>  node     0    1    2    3
>     0:   10   20   20   20
>     1:   20   10   20   20
>     2:   20   20   10   20
>     3:   20   20   20   10
> 
> Output of the example above (on node 0):
> 
> [    7.367022] node (0, 0) -> 10
> [    7.367151] node (0, 1) -> 20
> [    7.367186] node (0, 2) -> 20
> [    7.367247] node (0, 3) -> 20
> 
> On a system with non-equidistant nodes (simulated using virtme-ng):
> 
>  $ numactl -H
>  ...
>  node distances:
>  node     0    1    2    3
>     0:   10   51   31   41
>     1:   51   10   21   61
>     2:   31   21   10   11
>     3:   41   61   11   10
> 
> Output of the example above (on node 0):
> 
>  [    8.953644] node (0, 0) -> 10
>  [    8.953712] node (0, 2) -> 31
>  [    8.953764] node (0, 3) -> 41
>  [    8.953817] node (0, 1) -> 51
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Please keep me posted for the whole series.

> ---
>  include/linux/topology.h | 31 ++++++++++++++++++++++++++++-
>  kernel/sched/topology.c  | 42 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 52f5850730b3e..0c82b913a8814 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -248,12 +248,18 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
>  #ifdef CONFIG_NUMA
>  int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node);
>  extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops);
> -#else
> +extern int sched_numa_node(nodemask_t *visited, int start, unsigned int state);
> +#else /* !CONFIG_NUMA */
>  static __always_inline int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
>  {
>  	return cpumask_nth_and(cpu, cpus, cpu_online_mask);
>  }
>  
> +static inline int sched_numa_node(nodemask_t *visited, int start, unsigned int state)
> +{
> +	return MAX_NUMNODES;
> +}
> +
>  static inline const struct cpumask *
>  sched_numa_hop_mask(unsigned int node, unsigned int hops)
>  {
> @@ -261,6 +267,29 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
>  }
>  #endif	/* CONFIG_NUMA */
>  
> +/**
> + * for_each_numa_node - iterate over NUMA nodes at increasing hop distances
> + *                      from a given starting node.
> + * @node: the iteration variable, representing the current NUMA node.
> + * @start: the NUMA node to start the iteration from.
> + * @visited: a nodemask_t to track the visited nodes.

nit: s/nodemask_t/nodemask

> + * @state: state of NUMA nodes to iterate.
> + *
> + * This macro iterates over NUMA nodes in increasing distance from
> + * @start_node and yields MAX_NUMNODES when all the nodes have been
> + * visited.
> + *
> + * The difference between for_each_node() and for_each_numa_node() is that
> + * the former allows to iterate over nodes in no particular order, whereas
> + * the latter iterates over nodes in increasing order of distance.

for_each_node iterates them in numerical order. 

> + *
> + * Requires rcu_lock to be held.
> + */

Please mention complexity here, which is O(N^2). 

> +#define for_each_numa_node(node, start, visited, state)				\
> +	for (node = start;							\
> +	     node != MAX_NUMNODES;						\
> +	     node = sched_numa_node(&(visited), start, state))

Please braces around parameters.

'node < MAX_NUMNODES' is better. It will cost you nothing but will give
some guarantee that if user passes broken start value, we don't call
sched_numa_node().

What about:
        start = -EINVAL;
        foe_each_numa_node(node, start, visited, N_ONLINE)
                do_something(node);

Whatever garbage user puts in 'start', at the very first iteration,
do_something() will be executed against it. Offline node, -EINVAL or
NUMA_NO_NODE are the examples.

> +
>  /**
>   * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
>   *                          from a given node.
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index da33ec9e94ab2..e1d0a33415fb5 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2183,6 +2183,48 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
>  }
>  EXPORT_SYMBOL_GPL(sched_numa_find_nth_cpu);
>  
> +/**
> + * sched_numa_node - Find the NUMA node at the closest distance from
> + *		     node @start.
> + *
> + * @visited: a pointer to a nodemask_t representing the visited nodes.
> + * @start: the node to start the search from.

Maybe just 'node' The 'start' is only meaningful in the caller. Here
we don't start, we just look for a node that is the most nearest to a
given one.

What if NOMA_NO_NODE is passed?

> + * @state: the node state to filter nodes by.
> + *
> + * This function iterates over all nodes in the given state and calculates
> + * the distance to the starting node. It returns the node that is the
> + * closest in terms of distance that has not already been considered (not
> + * set in @visited and not the starting node). If the node is found, it is
> + * marked as visited in the @visited node mask.
> + *
> + * Returns the node ID closest in terms of hop distance from the @start
> + * node, or MAX_NUMNODES if no node is found (or all nodes have been
> + * visited).
> + */
> +int sched_numa_node(nodemask_t *visited, int start, unsigned int state)

The name is somewhat confusing. Sched_numa_node what? If you're looking
for a closest node, call your function find_closest_node().

We already have numa_nearest_node(). The difference between this one
and what you're implementing here is that you add an additional mask.
So, I'd suggest something like

 int numa_nearest_node_andnot(int node, unsigned int state, nodemask_t *mask)

Also, there's about scheduler her, so I'd suggest to place it next to
numa_nearest_node() in mm/mempolicy.c.

> +{
> +	int dist, n, min_node, min_dist;
> +
> +	min_node = MAX_NUMNODES;
> +	min_dist = INT_MAX;
> +
> +	/* Find the nearest unvisted node */

If you name it properly, you don't need to explain your intentions in
the code. Also, at this level of abstraction, the 'visited' name may
be too specific. Let's refer to it as just a mask containing nodes
that user wants to skip for whatever reason. 


> +	for_each_node_state(n, state) {
> +		if (n == start || node_isset(n, *visited))
> +			continue;

Nah.

1. Skipping start node is wrong. The very first call should return
'start' exactly. Then it will be masked out, so the traversing will
move forward. 
2. This should be for_each_node_state_andnot(n, state, mask).

This way you'll be able to drop the above condition entirely.

> +		dist = node_distance(start, n);
> +		if (dist < min_dist) {
> +			min_dist = dist;
> +			min_node = n;
> +		}
> +	}
> +	if (min_node != MAX_NUMNODES)
> +		node_set(min_node, *visited);

Is it possible to set the 'visited' bit in caller code? This way we'll
make the function pure, like other bitmap search functions.

Would something like this work? 

int numa_nearest_node_andnot(int node, unsigned int state, const nodemask_t *mask);
#define for_each_numa_node(node, visited, state)			                      \
	for (int start = (node), n = numa_nearest_node_andnot(start, (state), &(visited));    \
	     n < MAX_NUMNODES;					                      \
             node_set(n, (visited)), n = numa_nearest_node_andnot(start, (state), &(visited)))

One other option to think about is that we can introduce numa_nearest_nodemask()
and use it like this

  nodemask_t nodes;

  nodes_complement(nodes, node_states[N_ONLINE];
  for_each_numa_node(node, unvisited)
        do_something();

Where:

int numa_nearest_nodemask(int node, const nodemask_t *mask);
#define for_each_numa_node(node, unvisited)			                      \
	for (int start = (node), n = numa_nearest_nodemask(start, &(unvisited));    \
	     n < MAX_NUMNODES;					                      \
             node_clear(n, (visited)), n = numa_nearest_nodemask(start, &(visited)))

Thanks,
Yury

> +
> +	return min_node;
> +}
> +EXPORT_SYMBOL_GPL(sched_numa_node);
> +
>  /**
>   * sched_numa_hop_mask() - Get the cpumask of CPUs at most @hops hops away from
>   *                         @node
> -- 
> 2.48.1

