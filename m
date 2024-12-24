Return-Path: <bpf+bounces-47573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 639E29FB814
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 01:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3FF163C00
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 00:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0855A8F7D;
	Tue, 24 Dec 2024 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBTzBofC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DA442C;
	Tue, 24 Dec 2024 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735001861; cv=none; b=lA8CFpMZ2b+ajSSWqx/x2YnvUGpRo9PW/vo3Se+iTbXQ3qEBVExyW0NByoDYhbuXyGK/ppp3KEXKWdLAQ6z/V8+OvEDIC6GEXw9FEEGvKGsGh7UY/j9atU4oxuA9AB/YEmkx1U/aQj2dGgwwIgUM6Z1cFKetCzT4ZhqBW2GNdaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735001861; c=relaxed/simple;
	bh=kYBbvlAM5QWiNJzToAZ9F+PpghCb3AqpcW+QQDYq5cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdvtMfDu3+l9Nv2R89Bc+JrjmCi3DCaGt2TtAZPow5jAdM9ilHEKR/T0DWmFCP16ZbpWsDvHy6yYq3/kY+Rpz+zbHAQm01elViPysO7b+EXU9aB3aXrVUUxz3zn63Rmnjd4/GTtbKDpHAeO35tlKO7LFHt3Nf5DjG6SQTXP5SOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBTzBofC; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so3606464276.0;
        Mon, 23 Dec 2024 16:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735001858; x=1735606658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JcXJza/Tqu87TFyPkg8KhbXfSncTEaaxWJq8CyEFReE=;
        b=EBTzBofCGEO2HCjMyDJMZR9yGVn+A2y7vbFMp0AmEOm3S4Nkv2lRpAvKTCCqGvzNQ8
         sbnyG1oULl33WvDbG4DLAL+mldjRvw4ck3xV4UK2vbv9YrOInkoNJbt3KPnjrEiyjm8w
         OS7kmS2tYakI3/k2fs/ixNyryEFEExogoveYpPIlHP+FYqZLOujhnAWfaJ1ecul42dLV
         qO9qbiigxM1JT1sBQYmUh3PCSEiBYeCbYH3oL+Ziz24o7R6g0LDvvUh2kAGUVf91zW8k
         fKv4ashEKrcd8CYcTnzvsd422oaFtdnlUniBaL7v9QLmqUPOrlizHzEulDjgO8MEImW9
         TyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735001858; x=1735606658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcXJza/Tqu87TFyPkg8KhbXfSncTEaaxWJq8CyEFReE=;
        b=rnxEwC4RCycA6ZMukQVOrRsvr3aBzwjyHbydnvyvCD4O1hzkB80wOrQOPdQ5xMsRlS
         dZWX9ns+OrBk2nYzW93Eey3JVLopbHmKwNYTbqjNPGxHiOrEKpyql4P0lv/RieB9kFCS
         uUoQXc3zEjcp52BE4dW6izbqdaVCWYIrnsTs9ZUdACGUdrSKSfrXIyT1YhJLYQCZSuoB
         vemgxvPcWIGvyVccWaZY5EVCqhsmKDcvQnG8WUWf4jYhjsyiJuafXEvTyOiJV0r9jLXg
         QiaJpsMROXmgavWXz7UUo1yTtHIalMx4TgIflt1ac57GBCCaA/LgfT25skDDo57D13Cn
         Smcw==
X-Forwarded-Encrypted: i=1; AJvYcCV8c56ftk+pCAtXB9mB7MHGIfWMsKIpbrTwxBcMCk9Ez6uzJJAT3Vb/ZeZo8xFTXU34kyE=@vger.kernel.org, AJvYcCWGeZ5K+c4eS6jwULPUIxnNq/Brpf7Hei3ZiStepQ36rRGqbqffP7SFtHWelVpZDms3KDLpb1QvYrEjNkX5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4x7DTU2/0lmKhdyalSR0b3oiw2lwmZZ55lOXgPuPHD7MNjf8e
	/DHfi+WcO5iiyaEXLjknb2d/00M2xbwqH6n5ODqMtRtYsHXkl2Yg
X-Gm-Gg: ASbGncsLtMPdz9Exu8XE2XZ8fmo4cIwW90IGa9KXo+1i676Xf3JrUYsWCZdAJs7y9WF
	W3WB0woylwzUD+XhZTzB9u2SadmNWQ00QYVQY39ayE64zjSW5LXe4+1nI05t/5CWUcHjRvYcMjR
	NSOL/CITR8IOWQmF7YoJOBNSv1FYKd6EBJvSvVgtTZtWV2wyP2J2XyhYE+T64AxktVaT9SPUcwd
	EVRzHmi0qdKODkK6tc4QcK3gbK6oYBoV0m3iYY8gXY5JQgGFfGlzcVWzMafIu4w1TxfG5XD2Obn
	tAvmjMmwkRkvVaG6
X-Google-Smtp-Source: AGHT+IHHrb3W2dmNrwpN8q+70druI815djOBZS/QaL/cAqCyiwwOUixy5UREkKu96h4vH+pybaUZWg==
X-Received: by 2002:a05:690c:9c0d:b0:6ef:81c0:5b61 with SMTP id 00721157ae682-6f3f8115166mr112874827b3.16.1735001858429;
        Mon, 23 Dec 2024 16:57:38 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e73e7773sm26102327b3.11.2024.12.23.16.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 16:57:38 -0800 (PST)
Date: Mon, 23 Dec 2024 16:57:36 -0800
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
Subject: Re: [PATCH 10/10] sched_ext: idle: Introduce NUMA aware idle cpu
 kfunc helpers
Message-ID: <Z2oG9-AS-2OwB7Ib@yury-ThinkPad>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-11-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154107.287478-11-arighi@nvidia.com>

On Fri, Dec 20, 2024 at 04:11:42PM +0100, Andrea Righi wrote:
> Add the following kfunc's to provide scx schedulers direct access to
> per-node idle cpumasks information:
> 
>  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
>  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
>  s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed,
> 				int node, u64 flags)
>  int scx_bpf_cpu_to_node(s32 cpu)
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext_idle.c                  | 163 ++++++++++++++++++++---
>  tools/sched_ext/include/scx/common.bpf.h |   4 +
>  tools/sched_ext/include/scx/compat.bpf.h |  19 +++
>  3 files changed, 170 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index b36e93da1b75..0f8ccc1e290e 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -28,6 +28,60 @@ static bool check_builtin_idle_enabled(void)
>  	return false;
>  }
>  
> +static bool check_builtin_idle_per_node_enabled(void)
> +{
> +	if (static_branch_likely(&scx_builtin_idle_per_node))
> +		return true;

return 0;

> +
> +	scx_ops_error("per-node idle tracking is disabled");
> +	return false;

return -ENOTSUP;

> +}
> +
> +/*
> + * Validate and resolve a NUMA node.
> + *
> + * Return the resolved node ID on success or a negative value otherwise.
> + */
> +static int validate_node(int node)
> +{
> +	if (!check_builtin_idle_per_node_enabled())
> +		return -EINVAL;

So the node may be valid, but this validator may fail. EINVAL is a
misleading error code for that. You need ENOTSUP.

> +
> +	/* If no node is specified, use the current one */
> +	if (node == NUMA_NO_NODE)
> +		return numa_node_id();
> +
> +	/* Make sure node is in a valid range */
> +	if (node < 0 || node >= nr_node_ids) {
> +		scx_ops_error("invalid node %d", node);
> +		return -ENOENT;

No such file or directory? Hmm...

This should be EINVAL. I would join this one with node_possible()
check. We probably need bpf_node_possible() or something...

> +	}
> +
> +	/* Make sure the node is part of the set of possible nodes */
> +	if (!node_possible(node)) {
> +		scx_ops_error("unavailable node %d", node);

Not that it's unavailable. It just doesn't exist... I'd say:

	scx_ops_error("Non-existing node %d. The existing nodes are: %pbl",
                      node, nodemask_pr_args(node_states[N_POSSIBLE]));

> +		return -EINVAL;
> +	}

What if user provides offline or cpu-less nodes? Is that a normal usage?
If not, it would be nice to print warning, or even return an error...

> +
> +	return node;
> +}
> +
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
> +	else
> +		node = NUMA_FLAT_NODE;
> +
> +	return node;
> +}
> +
>  #ifdef CONFIG_SMP
>  struct idle_cpumask {
>  	cpumask_var_t cpu;
> @@ -83,22 +137,6 @@ static void idle_masks_init(void)
>  
>  static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
>  
> -/*
> - * Return the node id associated to a target idle CPU (used to determine
> - * the proper idle cpumask).
> - */
> -static int idle_cpu_to_node(int cpu)
> -{
> -	int node;
> -
> -	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> -		node = cpu_to_node(cpu);
> -	else
> -		node = NUMA_FLAT_NODE;
> -
> -	return node;
> -}
> -
>  static bool test_and_clear_cpu_idle(int cpu)
>  {
>  	int node = idle_cpu_to_node(cpu);
> @@ -613,6 +651,17 @@ static void reset_idle_masks(void) {}
>   */
>  __bpf_kfunc_start_defs();
>  
> +/**
> + * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
> + */
> +__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)
> +{
> +	if (cpu < 0 || cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	return idle_cpu_to_node(cpu);
> +}
> +
>  /**
>   * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
>   * @p: task_struct to select a CPU for
> @@ -645,6 +694,28 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	return prev_cpu;
>  }
>  
> +/**
> + * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
> + * per-CPU cpumask of a target NUMA node.
> + *
> + * NUMA_NO_NODE is interpreted as the current node.
> + *
> + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> + * valid, or running on a UP kernel.
> + */
> +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> +{
> +	node = validate_node(node);
> +	if (node < 0)
> +		return cpu_none_mask;

I think I commented this in v7. This simply hides an error. You need to
return ERR_PTR(node). And your user should check it with IS_ERR_VALUE().

This should be consistent with scx_bpf_pick_idle_cpu_node(), where you
return an actual error.

> +
> +#ifdef CONFIG_SMP
> +	return get_idle_cpumask(node);
> +#else
> +	return cpu_none_mask;
> +#endif
> +}
> +
>  /**
>   * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
>   * per-CPU cpumask.
> @@ -664,6 +735,32 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
>  	return get_idle_cpumask(NUMA_FLAT_NODE);
>  }
>  
> +/**
> + * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
> + * per-physical-core cpumask of a target NUMA node. Can be used to determine
> + * if an entire physical core is free.

If it goes to DOCs, it should have parameters section.

> + *
> + * NUMA_NO_NODE is interpreted as the current node.
> + *
> + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> + * valid, or running on a UP kernel.
> + */
> +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> +{
> +	node = validate_node(node);
> +	if (node < 0)
> +		return cpu_none_mask;
> +
> +#ifdef CONFIG_SMP
> +	if (sched_smt_active())
> +		return get_idle_smtmask(node);
> +	else
> +		return get_idle_cpumask(node);
> +#else
> +	return cpu_none_mask;
> +#endif
> +}
> +
>  /**
>   * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
>   * per-physical-core cpumask. Can be used to determine if an entire physical
> @@ -722,6 +819,36 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
>  		return false;
>  }
>  
> +/**
> + * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
> + * @cpus_allowed: Allowed cpumask
> + * @node: target NUMA node
> + * @flags: %SCX_PICK_IDLE_CPU_* flags
> + *
> + * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
> + * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
> + * was found.

validate_node() returns more errors.

> + *
> + * If @node is NUMA_NO_NODE, the search is restricted to the current NUMA
> + * node. Otherwise, the search starts from @node and proceeds to other
> + * online NUMA nodes in order of increasing distance (unless
> + * SCX_PICK_IDLE_NODE is specified, in which case the search is limited to
> + * the target @node).

Can you reorder statements, like:

Restricted to current node if NUMA_NO_NODE.
Restricted to @node if SCX_PICK_IDLE_NODE is specified
Otherwise ...

What if NUMA_NO_NODE + SCX_PICK_IDLE_NODE? Seems to be OK, but looks
redundant and non-intuitive. Why not if NUMA_NO_NODE provided, start
from current node, but not restrict with it?

> + *
> + * Unavailable if ops.update_idle() is implemented and
> + * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
> + * not set.
> + */
> +__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
> +					   int node, u64 flags)
> +{
> +	node = validate_node(node);

Hold on! This validate_node() replaces NO_NODE with current node but
doesn't touch flags. It means that scx_pick_idle_cpu() will never see
NO_NODE, and will not be able to restrict to current node. The comment
above is incorrect, right?

> +	if (node < 0)
> +		return node;
> +
> +	return scx_pick_idle_cpu(cpus_allowed, node, flags);
> +}
> +
>  /**
>   * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
>   * @cpus_allowed: Allowed cpumask
> @@ -785,11 +912,15 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
> +BTF_ID_FLAGS(func, scx_bpf_cpu_to_node)
>  BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
>  BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
> +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 858ba1f438f6..fe0433f7c4d9 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -63,13 +63,17 @@ u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
>  u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
>  void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
>  u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
> +int scx_bpf_cpu_to_node(s32 cpu) __ksym __weak;
>  const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
>  const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
>  void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
> +const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __ksym __weak;
>  const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
> +const struct cpumask *scx_bpf_get_idle_smtmask_node(int node) __ksym __weak;
>  const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
>  void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
>  bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
> +s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
>  s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
>  s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
>  bool scx_bpf_task_running(const struct task_struct *p) __ksym;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index d56520100a26..dfc329d5a91e 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -125,6 +125,25 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
>  	false;									\
>  })
>  
> +#define __COMPAT_scx_bpf_cpu_to_node(cpu)					\
> +	(bpf_ksym_exists(scx_bpf_cpu_to_node) ?					\
> +	 scx_bpf_cpu_to_node(cpu) : 0)
> +
> +#define __COMPAT_scx_bpf_get_idle_cpumask_node(node)				\
> +	(bpf_ksym_exists(scx_bpf_get_idle_cpumask_node) ?			\
> +	 scx_bpf_get_idle_cpumask_node(node) :					\
> +	 scx_bpf_get_idle_cpumask())						\
> +
> +#define __COMPAT_scx_bpf_get_idle_smtmask_node(node)				\
> +	(bpf_ksym_exists(scx_bpf_get_idle_smtmask_node) ?			\
> +	 scx_bpf_get_idle_smtmask_node(node) :					\
> +	 scx_bpf_get_idle_smtmask())
> +
> +#define __COMPAT_scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags)		\
> +	(bpf_ksym_exists(scx_bpf_pick_idle_cpu_node) ?				\
> +	 scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags) :		\
> +	 scx_bpf_pick_idle_cpu(cpus_allowed, flags))
> +
>  /*
>   * Define sched_ext_ops. This may be expanded to define multiple variants for
>   * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
> -- 
> 2.47.1

