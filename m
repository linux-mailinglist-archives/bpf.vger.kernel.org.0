Return-Path: <bpf+bounces-47569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07BD9FB7E7
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 00:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F221884D4A
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 23:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A791D5ADD;
	Mon, 23 Dec 2024 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hivpoa0M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB601BEF8D;
	Mon, 23 Dec 2024 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734997200; cv=none; b=nhM1XvGxYBg12528SWrGtGTO2bMGJscBjYf2wnmBbcvtQYn2o8waB0Ds/p5ouZGW6Hwt0BXvOlId7l2PgDz+D427yW0Zp/TTum1Y17EtT2DzhgrBavHPoP/fnQMiVxMk32EVUD1O6nWAzxBvk93OeUNGmMiJivbFSiSkXMwVb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734997200; c=relaxed/simple;
	bh=BJJoB2GVr5/U6FOowmaWSxTOi5ulXf0Vvc1OAviWblM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdtpW/QP9Qwy8TsxBCa1R6xFjRm3ib36Wxjj4FbuCL76MBwmu+/qneYnK+j7x0PotHekyR8hhVZ+i+At5KU649hqFtJs5aDlONxIlfKCxYybdHcO8HenRgp2gZk1vFn7VdE1uhbHAjKUvPS/fx/nd83IApxstIa8Gs+HwADX56E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hivpoa0M; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso3447201276.2;
        Mon, 23 Dec 2024 15:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734997198; x=1735601998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gboCmrYc4y9C+m5UllNwthZJeltAhJlp6q/SUaUiyvE=;
        b=hivpoa0MiRS7kLTMS1KL/Aq3cD5RJtGT1Pah0XDXa/GKFaqGzhwlPB2aUciezC09dP
         Cra/5+r8QVPZPgb4lIKoxbnnc03pgEhPN53/SHAn9uNeeD66MYpOe+KCMokXdQTQTDJP
         Yh6fmzyxWlHyjgEEuTNONLW+nqDy0nP1RIg4m0d3v7LLyh9jYOgIqly2NUqW9wtZfyY2
         6NM1oVhrRs/e83XuPy8YIj/tk0FoRRfmN3ldKes4ystOujGuz54He3Xa9MoLpl7lZE2L
         QIATypm6WV9xD+ZcTDi5otVAZJcPaQnqtgDVfm7pGR0qKh62U/BWyK+773DkR2kTKSKX
         /R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734997198; x=1735601998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gboCmrYc4y9C+m5UllNwthZJeltAhJlp6q/SUaUiyvE=;
        b=fjIW32ntIpCROK+3EQmDCaV9cMbrQ/cmgFC8rK6h1lA4IG03p+xyrMkhPogPPsj51o
         IyhdKhv4ABjixgQNruts+8fAI5bd9Qjz9nCWcRY7c6pOM8TiD7Yqjbd2kXVwsX7TbkKv
         2xhDTw5PesNPSSUraW40AKe27ST3A42a6InmMzRllQkT5zs4VnFGMyGXfbMAONosAYZC
         pTI0JD90x6FpdRT1viY7MQPB63xRBOc9QZW9ulqhLbJMAHhPedKG5uJvb7QjXzMO21ji
         cg1qVkaXjQvUlpBBxb54545kxhrHAceP2iy9a6BRGxY8LeXUdzkNjp8uUmNhVxaUA0uO
         YdKA==
X-Forwarded-Encrypted: i=1; AJvYcCWwH+Nm7elfcct+lM94QoJknbDB3v+AYy4u1FKnKFBhNq61XG7wxA8ap7n8BY7AMNtzW60=@vger.kernel.org, AJvYcCXP2+Q8CtDzz356cJzBJ0O/P4gclP0G5EI0VD66/M5lj4uKaT3LULBmNp2aViDnDzCrsWAT4/Ee8DqaoYio@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9PRDUI/LsQPu7qDCgNqWbGrujA+d9sntVKmnyuE6jo+BE2K5S
	h0PWBBz2EeKoOTf8n8U2TVcmH10gBPHdKsvvYkGxL/r/cYgmea/Q
X-Gm-Gg: ASbGncs3KqEwP1va9tIamji6NNyQ/hyq4p7G0/75dK4fFmhRyiNlXAmbR4iq4bIzcYT
	An+o+O2MjG4hXeO33U1YEBf2GYxUhU2igU6wXyLFV0H86h39jgRAnkTc4fifJ2+TF8BuLcunMet
	5BOSKE0/pzwspFA+WLVFKesLQdhq4vjQnCuUkLu3fzcGt5FXKUb49axs4W3KIIO2kCtYa9GuVdz
	NCoBBOq6dFmJ7zrv3shsOwk54KUxJu6r+7eRoGC/qYK1jFxHFMZmgJPoQNGEVqFXPLvwP2l9W8A
	CPx14x8lKuhSHVjS
X-Google-Smtp-Source: AGHT+IHWzo/nD4jGKcj64he7ETneiRLQO3vMPLLxAPVYJTRwjb1JnwQLQVG3rma/LrAfvXsRfor+Sg==
X-Received: by 2002:a05:690c:6088:b0:6ef:641a:2a7b with SMTP id 00721157ae682-6f3f80d908fmr122443077b3.2.1734997198079;
        Mon, 23 Dec 2024 15:39:58 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e77ed139sm26056157b3.85.2024.12.23.15.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 15:39:57 -0800 (PST)
Date: Mon, 23 Dec 2024 15:39:56 -0800
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
Subject: Re: [PATCH 09/10] sched_ext: idle: Get rid of the
 scx_selcpu_topo_numa logic
Message-ID: <Z2n0xDaP7Ulq1DSg@yury-ThinkPad>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-10-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154107.287478-10-arighi@nvidia.com>

On Fri, Dec 20, 2024 at 04:11:41PM +0100, Andrea Righi wrote:
> With the introduction of separate per-NUMA node cpumasks, we
> automatically track idle CPUs within each NUMA node.
> 
> This makes the special logic for determining idle CPUs in each NUMA node
> redundant and unnecessary, so we can get rid of it.

But it looks like you do more than that... 

> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext_idle.c | 93 ++++++++++-------------------------------
>  1 file changed, 23 insertions(+), 70 deletions(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 013deaa08f12..b36e93da1b75 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -82,7 +82,6 @@ static void idle_masks_init(void)
>  }
>  
>  static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
> -static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
>  
>  /*
>   * Return the node id associated to a target idle CPU (used to determine
> @@ -259,25 +258,6 @@ static unsigned int numa_weight(s32 cpu)
>  	return sg->group_weight;
>  }
>  
> -/*
> - * Return the cpumask representing the NUMA domain of @cpu (or NULL if the NUMA
> - * domain is not defined).
> - */
> -static struct cpumask *numa_span(s32 cpu)
> -{
> -	struct sched_domain *sd;
> -	struct sched_group *sg;
> -
> -	sd = rcu_dereference(per_cpu(sd_numa, cpu));
> -	if (!sd)
> -		return NULL;
> -	sg = sd->groups;
> -	if (!sg)
> -		return NULL;
> -
> -	return sched_group_span(sg);

I didn't find llc_span() and node_span() in vanilla kernel. Does this series
have prerequisites?

> -}
> -
>  /*
>   * Return true if the LLC domains do not perfectly overlap with the NUMA
>   * domains, false otherwise.
> @@ -329,7 +309,7 @@ static bool llc_numa_mismatch(void)
>   */
>  static void update_selcpu_topology(struct sched_ext_ops *ops)
>  {
> -	bool enable_llc = false, enable_numa = false;
> +	bool enable_llc = false;
>  	unsigned int nr_cpus;
>  	s32 cpu = cpumask_first(cpu_online_mask);
>  
> @@ -348,41 +328,34 @@ static void update_selcpu_topology(struct sched_ext_ops *ops)
>  	if (nr_cpus > 0) {
>  		if (nr_cpus < num_online_cpus())
>  			enable_llc = true;
> +		/*
> +		 * No need to enable LLC optimization if the LLC domains are
> +		 * perfectly overlapping with the NUMA domains when per-node
> +		 * cpumasks are enabled.
> +		 */
> +		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
> +		    !llc_numa_mismatch())
> +			enable_llc = false;

This doesn't sound like redundancy removal. I may be wrong, but this
looks like a sort of optimization. If so, it deserves to be a separate
patch.

>  		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
>  			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
>  	}
> -
> -	/*
> -	 * Enable NUMA optimization only when there are multiple NUMA domains
> -	 * among the online CPUs and the NUMA domains don't perfectly overlaps
> -	 * with the LLC domains.
> -	 *
> -	 * If all CPUs belong to the same NUMA node and the same LLC domain,
> -	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
> -	 * for an idle CPU in the same domain twice is redundant.
> -	 */
> -	nr_cpus = numa_weight(cpu);

Neither I found numa_weight()...

> -	if (nr_cpus > 0) {
> -		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
> -			enable_numa = true;
> -		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
> -			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
> -	}

This calls numa_weight() twice. Get rid of it for good.

>  	rcu_read_unlock();
>  
>  	pr_debug("sched_ext: LLC idle selection %s\n",
>  		 enable_llc ? "enabled" : "disabled");
> -	pr_debug("sched_ext: NUMA idle selection %s\n",
> -		 enable_numa ? "enabled" : "disabled");
>  
>  	if (enable_llc)
>  		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
>  	else
>  		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
> -	if (enable_numa)
> -		static_branch_enable_cpuslocked(&scx_selcpu_topo_numa);
> +
> +	/*
> +	 * Check if we need to enable per-node cpumasks.
> +	 */
> +	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
> +		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);

This is the key from the whole series!

>  	else
> -		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
> +		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
>  }

This knob enables the whole new machinery, and it definitely deserves to
be a separate, very last patch. Now it looks like a sneaky replacement of
scx_selcpu_topo_numa with scx_builtin_idle_per_node, and this is wrong. 

Are you sure you need a comment on top of it? To me, the code is quite
self-explaining...

>  
>  /*
> @@ -405,9 +378,8 @@ static void update_selcpu_topology(struct sched_ext_ops *ops)
>   *
>   * 5. Pick any idle CPU usable by the task.
>   *
> - * Step 3 and 4 are performed only if the system has, respectively, multiple
> - * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
> - * scx_selcpu_topo_numa).
> + * Step 3 is performed only if the system has multiple LLC domains that are not
> + * perfectly overlapping with the NUMA domains (see scx_selcpu_topo_llc).
>   *
>   * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
>   * we never call ops.select_cpu() for them, see select_task_rq().
> @@ -416,7 +388,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  			      u64 wake_flags, bool *found)
>  {
>  	const struct cpumask *llc_cpus = NULL;
> -	const struct cpumask *numa_cpus = NULL;
>  	int node = idle_cpu_to_node(prev_cpu);
>  	s32 cpu;
>  
> @@ -438,13 +409,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	 * CPU affinity), the task will simply use the flat scheduling domain
>  	 * defined by user-space.
>  	 */
> -	if (p->nr_cpus_allowed >= num_possible_cpus()) {
> -		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
> -			numa_cpus = numa_span(prev_cpu);
> -
> +	if (p->nr_cpus_allowed >= num_possible_cpus())
>  		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
>  			llc_cpus = llc_span(prev_cpu);
> -	}

I'd keep the curve braces. That would minimize your patch and preserve
more history.

>  
>  	/*
>  	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
> @@ -507,15 +474,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  				goto cpu_found;
>  		}
>  
> -		/*
> -		 * Search for any fully idle core in the same NUMA node.
> -		 */
> -		if (numa_cpus) {
> -			cpu = scx_pick_idle_cpu(numa_cpus, node, SCX_PICK_IDLE_CORE);
> -			if (cpu >= 0)
> -				goto cpu_found;
> -		}
> -
>  		/*
>  		 * Search for any full idle core usable by the task.
>  		 *
> @@ -545,17 +503,12 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  			goto cpu_found;
>  	}
>  
> -	/*
> -	 * Search for any idle CPU in the same NUMA node.
> -	 */
> -	if (numa_cpus) {
> -		cpu = pick_idle_cpu_from_node(numa_cpus, node, 0);
> -		if (cpu >= 0)
> -			goto cpu_found;
> -	}
> -
>  	/*
>  	 * Search for any idle CPU usable by the task.
> +	 *
> +	 * If NUMA aware idle selection is enabled, the search will begin
> +	 * in prev_cpu's node and proceed to other nodes in order of
> +	 * increasing distance.

Again, this definitely not a redundancy removal. This is a description
of new behavior, and should go with the implementation of that
behavior.

>  	 */
>  	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
>  	if (cpu >= 0)
> -- 
> 2.47.1

