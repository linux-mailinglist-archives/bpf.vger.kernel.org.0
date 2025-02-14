Return-Path: <bpf+bounces-51614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CD3A36786
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 22:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0DE1896964
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523081D9A79;
	Fri, 14 Feb 2025 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcKWxoJg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBACC17E;
	Fri, 14 Feb 2025 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568541; cv=none; b=eGp/l9ycpsgDHOti8/zrcuNirk69z3dFak34moNEmpxMXFRKFDFpWvelZJAm5PrkOGmyWmBS0qB01ImvkxT07goqZKtLLOcRej7PJ5RJu9WdzObvkI6u14KRuNQJO41FRgGe3CCb/v4iKhCfprDdsJeiLuHZePVWREMum307b/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568541; c=relaxed/simple;
	bh=cePNID4+wzPwOrlABMOrXg3j0I/ppihEDtZOgce7tQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvsQwJxYaJ3Yk47R3ouhmHWizOm7esmCaM30rZZyOGNrxEMTy+YI/6aZM3phOrtI9Ps5p4U2DP3oNrkHwBKhjNa8IlhpG5Rgos+yrlSQmd9uhJar/oIdvBmuXzMaVC/vkCX7wq4FS9wBx5ax9qA6S3Hjv0vonrrJHQ1wdVJk2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcKWxoJg; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso2095572276.3;
        Fri, 14 Feb 2025 13:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739568539; x=1740173339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flnzfKdPgifv+D69x269wXkDyJ9U8HNDq/YBvv4nSbg=;
        b=jcKWxoJgM1V9pD5/2nwpJRcPSC83MvCdyXNPBeEcFDLN1l+6/t9JYFgYGT4MQBiHe0
         wDLoxPgX2rEVZP9gleiJysUYCL+sM/PJU9TwSW2v5GBohI5m5gYlhZWE8SM8j6e6SYF4
         8Lmh0zKTS9ZO/UfzAKo6aG9tJAz39OMZmGBpxTb8FyNZAEOxEVjmi+z7OeFdHNajRnih
         dBvB5U3+xoooU4P+JL69OzGIt63VJzbuhhq4sV1gJgrjdXdVaUg99pneooIirr7IGw3g
         gMUUlQfMezuqVRCQtl0X756pUrRGrF8YyJ0qmDJCosACA6FbDG8Rv4McqE5tW1Qmt+bM
         bROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739568539; x=1740173339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flnzfKdPgifv+D69x269wXkDyJ9U8HNDq/YBvv4nSbg=;
        b=dCBtoE+Zrss8PTWVkuaY3iK0+ozxo1K+Zrtiub+BXLhGr5RuMu+OkXx04lF4oH09I0
         oSibfLy7Fd+ZEyZegs8N0ret5X6y6wgwg0PZDA2kjLzLRMjfGfhK+OAgHJUCD0DcJ+i8
         5e3MHKcgYH8RaAi9gxa3hbO8RogMrIiDj3OL2HTfoRetPktogl4A2rV78dy758vaFVd+
         RE7LhOFqHF1JRN1Oiq94rPLR5O4APuhwzKL1OgmcuF+hvvLemsKPBzVbWY/K8OIvs8Mx
         PcLWypr2y25MRlh+3w9mJUWpJn6KMbI3bk/Co7k3UYz8IJqhFRcudkEJeNz6Ron8b5MK
         d4gw==
X-Forwarded-Encrypted: i=1; AJvYcCVC4PrEY6up9khUCoKkOtt024lAxlgrYcIukunXR5XwFAda2XRrA5CGwtvR/DC2vKTVEvE=@vger.kernel.org, AJvYcCWA8HAQQSAG9psWxXkpC9pVHxV42UJ3LrVW/dF968PniNJazcfYivM5M3kstK4Qy+PzlE50EWRAdcphFVaE@vger.kernel.org
X-Gm-Message-State: AOJu0YyniUOnrz5YkIfYs17JQA9r5uKiCEJuXrkDnVszXY/AN5hIoX5+
	LL2UnLZ+DBvIfI+LuTt2yOIIXhBgJ81d/TsiGwZXgjXGoKz2VSce
X-Gm-Gg: ASbGnctJvSbSMdrQpwRLUnt+xKg5vuC3IKs4XkRXCJMapG+Q11FhUDGffOLlnAQPS98
	idqGdJKlNYXMQrE3GN9RHejn62LK5Qmm4/ErYvE/7O2ctULv+3Y3ympJqtkIQ4h0em0TywR69hg
	8qB6UTkPIXljmlh5tfBMZv5tsgeVftP293akypCr2aP9G+5aS/iqi7XY7ZshOXV/Gwq3LYJK41u
	yLslXLcoxfyzCPLlck3KWU86Iqu8uN/HBd7NYgH0ow9BtRf7FcY7n3Kb04ATfWU/RQFV/CTKYGb
	Dc+MqDBjsnYL9yGzJi/dNIeSlE90PcCVpcZnA+7bE5adNbE6zD0=
X-Google-Smtp-Source: AGHT+IFPl4sN+zZyJhEtFn6XR4XBXEUjBE2D4X143TVLOxLAh9hJRDG1gfftBA5bj85dHB6SEfomPw==
X-Received: by 2002:a05:690c:19:b0:6f9:9e80:46bf with SMTP id 00721157ae682-6fb5831bd5emr10378457b3.29.1739568538775;
        Fri, 14 Feb 2025 13:28:58 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb360ae9f2sm9338507b3.68.2025.02.14.13.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:28:58 -0800 (PST)
Date: Fri, 14 Feb 2025 16:28:57 -0500
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
Subject: Re: [PATCH 8/8] sched_ext: idle: Introduce node-aware idle cpu kfunc
 helpers
Message-ID: <Z6-1mQMBhq4OOlvB@thinkpad>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-9-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214194134.658939-9-arighi@nvidia.com>

On Fri, Feb 14, 2025 at 08:40:07PM +0100, Andrea Righi wrote:
> Introduce a new kfunc to retrieve the node associated to a CPU:
> 
>  int scx_bpf_cpu_node(s32 cpu)
> 
> Add the following kfuncs to provide BPF schedulers direct access to
> per-node idle cpumasks information:
> 
>  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
>  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
>  s32 scx_bpf_pick_idle_cpu_in_node(const cpumask_t *cpus_allowed,
>  				   int node, u64 flags)
>  s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed,
>  			       int node, u64 flags)
> 
> Moreover, trigger an scx error when any of the non-node aware idle CPU
> kfuncs are used when SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled.
> 
> Cc: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

> ---
>  kernel/sched/ext_idle.c                  | 180 +++++++++++++++++++++++
>  tools/sched_ext/include/scx/common.bpf.h |   5 +
>  tools/sched_ext/include/scx/compat.bpf.h |  31 ++++
>  3 files changed, 216 insertions(+)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 8dacccc82ed63..5c062affd622c 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -728,6 +728,33 @@ void scx_idle_disable(void)
>  /********************************************************************************
>   * Helpers that can be called from the BPF scheduler.
>   */
> +
> +static int validate_node(int node)
> +{
> +	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
> +		scx_ops_error("per-node idle tracking is disabled");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Return no entry for NUMA_NO_NODE (not a critical scx error) */
> +	if (node == NUMA_NO_NODE)
> +		return -ENOENT;
> +
> +	/* Make sure node is in a valid range */
> +	if (node < 0 || node >= nr_node_ids) {
> +		scx_ops_error("invalid node %d", node);
> +		return -EINVAL;
> +	}
> +
> +	/* Make sure the node is part of the set of possible nodes */
> +	if (!node_possible(node)) {
> +		scx_ops_error("unavailable node %d", node);
> +		return -EINVAL;
> +	}
> +
> +	return node;
> +}
> +
>  __bpf_kfunc_start_defs();
>  
>  static bool check_builtin_idle_enabled(void)
> @@ -739,6 +766,23 @@ static bool check_builtin_idle_enabled(void)
>  	return false;
>  }
>  
> +/**
> + * scx_bpf_cpu_node - Return the NUMA node the given @cpu belongs to, or
> + *		      trigger an error if @cpu is invalid
> + * @cpu: target CPU
> + */
> +__bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
> +{
> +#ifdef CONFIG_NUMA
> +	if (!ops_cpu_valid(cpu, NULL))
> +		return NUMA_NO_NODE;
> +
> +	return cpu_to_node(cpu);
> +#else
> +	return 0;
> +#endif
> +}
> +
>  /**
>   * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
>   * @p: task_struct to select a CPU for
> @@ -771,6 +815,27 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	return prev_cpu;
>  }
>  
> +/**
> + * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
> + * idle-tracking per-CPU cpumask of a target NUMA node.
> + *
> + * Returns an empty cpumask if idle tracking is not enabled, if @node is
> + * not valid, or running on a UP kernel. In this case the actual error will
> + * be reported to the BPF scheduler via scx_ops_error().
> + */
> +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> +{
> +	node = validate_node(node);
> +	if (node < 0)
> +		return cpu_none_mask;
> +
> +#ifdef CONFIG_SMP
> +	return idle_cpumask(node)->cpu;
> +#else
> +	return cpu_none_mask;
> +#endif

Here you need to check for SMP at the beginning. That way you can
avoid calling validate_node() if SMP is disabled.

> +}
> +
>  /**
>   * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
>   * per-CPU cpumask.
> @@ -795,6 +860,31 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
>  #endif
>  }
>  
> +/**
> + * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the
> + * idle-tracking, per-physical-core cpumask of a target NUMA node. Can be
> + * used to determine if an entire physical core is free.
> + *
> + * Returns an empty cpumask if idle tracking is not enabled, if @node is
> + * not valid, or running on a UP kernel. In this case the actual error will
> + * be reported to the BPF scheduler via scx_ops_error().
> + */
> +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> +{
> +	node = validate_node(node);
> +	if (node < 0)
> +		return cpu_none_mask;
> +
> +#ifdef CONFIG_SMP
> +	if (sched_smt_active())
> +		return idle_cpumask(node)->smt;
> +	else
> +		return idle_cpumask(node)->cpu;
> +#else
> +	return cpu_none_mask;
> +#endif

Same here. It's minor. Don't thing it's worth another version.

Thanks,
Yury

> +}
> +
>  /**
>   * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
>   * per-physical-core cpumask. Can be used to determine if an entire physical
> @@ -859,6 +949,35 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
>  		return false;
>  }
>  
> +/**
> + * scx_bpf_pick_idle_cpu_in_node - Pick and claim an idle cpu from @node
> + * @cpus_allowed: Allowed cpumask
> + * @node: target NUMA node
> + * @flags: %SCX_PICK_IDLE_* flags
> + *
> + * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
> + *
> + * Returns the picked idle cpu number on success, or -%EBUSY if no matching
> + * cpu was found.
> + *
> + * The search starts from @node and proceeds to other online NUMA nodes in
> + * order of increasing distance (unless SCX_PICK_IDLE_IN_NODE is specified,
> + * in which case the search is limited to the target @node).
> + *
> + * Always returns an error if ops.update_idle() is implemented and
> + * %SCX_OPS_KEEP_BUILTIN_IDLE is not set, or if
> + * %SCX_OPS_BUILTIN_IDLE_PER_NODE is not set.
> + */
> +__bpf_kfunc s32 scx_bpf_pick_idle_cpu_in_node(const struct cpumask *cpus_allowed,
> +					      int node, u64 flags)
> +{
> +	node = validate_node(node);
> +	if (node < 0)
> +		return node;
> +
> +	return scx_pick_idle_cpu(cpus_allowed, node, flags);
> +}
> +
>  /**
>   * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
>   * @cpus_allowed: Allowed cpumask
> @@ -877,16 +996,64 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
>   *
>   * Unavailable if ops.update_idle() is implemented and
>   * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
> + *
> + * Always returns an error if %SCX_OPS_BUILTIN_IDLE_PER_NODE is set, use
> + * scx_bpf_pick_idle_cpu_in_node() instead.
>   */
>  __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
>  				      u64 flags)
>  {
> +	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
> +		scx_ops_error("per-node idle tracking is enabled");
> +		return -EBUSY;
> +	}
> +
>  	if (!check_builtin_idle_enabled())
>  		return -EBUSY;
>  
>  	return scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
>  }
>  
> +/**
> + * scx_bpf_pick_any_cpu_in_node - Pick and claim an idle cpu if available
> + *				  or pick any CPU from @node
> + * @cpus_allowed: Allowed cpumask
> + * @node: target NUMA node
> + * @flags: %SCX_PICK_IDLE_CPU_* flags
> + *
> + * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
> + * CPU in @cpus_allowed. Guaranteed to succeed and returns the picked idle cpu
> + * number if @cpus_allowed is not empty. -%EBUSY is returned if @cpus_allowed is
> + * empty.
> + *
> + * The search starts from @node and proceeds to other online NUMA nodes in
> + * order of increasing distance (unless SCX_PICK_IDLE_IN_NODE is specified,
> + * in which case the search is limited to the target @node).
> + *
> + * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
> + * set, this function can't tell which CPUs are idle and will always pick any
> + * CPU.
> + */
> +__bpf_kfunc s32 scx_bpf_pick_any_cpu_in_node(const struct cpumask *cpus_allowed,
> +				     int node, u64 flags)
> +{
> +	s32 cpu;
> +
> +	node = validate_node(node);
> +	if (node < 0)
> +		return node;
> +
> +	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
> +	if (cpu >= 0)
> +		return cpu;
> +
> +	cpu = cpumask_any_distribute(cpus_allowed);
> +	if (cpu < nr_cpu_ids)
> +		return cpu;
> +	else
> +		return -EBUSY;
> +}
> +
>  /**
>   * scx_bpf_pick_any_cpu - Pick and claim an idle cpu if available or pick any CPU
>   * @cpus_allowed: Allowed cpumask
> @@ -900,12 +1067,20 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
>   * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
>   * set, this function can't tell which CPUs are idle and will always pick any
>   * CPU.
> + *
> + * Always returns an error if %SCX_OPS_BUILTIN_IDLE_PER_NODE is set, use
> + * scx_bpf_pick_any_cpu_in_node() instead.
>   */
>  __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
>  				     u64 flags)
>  {
>  	s32 cpu;
>  
> +	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
> +		scx_ops_error("per-node idle tracking is enabled");
> +		return -EBUSY;
> +	}
> +
>  	if (static_branch_likely(&scx_builtin_idle_enabled)) {
>  		cpu = scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
>  		if (cpu >= 0)
> @@ -922,11 +1097,16 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_idle)
> +BTF_ID_FLAGS(func, scx_bpf_cpu_node)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
>  BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
> +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_in_node, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_in_node, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_idle)
>  
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 77bbe0199a32c..cd1659c5d3f46 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -71,14 +71,19 @@ u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
>  u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
>  void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
>  u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
> +int scx_bpf_cpu_node(s32 cpu) __ksym __weak;
>  const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
>  const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
>  void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
> +const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __ksym __weak;
>  const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
> +const struct cpumask *scx_bpf_get_idle_smtmask_node(int node) __ksym __weak;
>  const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
>  void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
>  bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
> +s32 scx_bpf_pick_idle_cpu_in_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
>  s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
> +s32 scx_bpf_pick_any_cpu_in_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
>  s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
>  bool scx_bpf_task_running(const struct task_struct *p) __ksym;
>  s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index e5fa72f9bf22b..617ed0ec85dc4 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -182,6 +182,37 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
>  	 scx_bpf_now() :							\
>  	 bpf_ktime_get_ns())
>  
> +/*
> + *
> + * v6.15: Introduce NUMA-aware kfuncs to operate with per-node idle
> + * cpumasks.
> + *
> + * Preserve the following __COMPAT_scx_*_node macros until v6.17.
> + */
> +#define __COMPAT_scx_bpf_cpu_node(cpu)						\
> +	(bpf_ksym_exists(scx_bpf_cpu_node) ?					\
> +	 scx_bpf_cpu_node(cpu) : 0)
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
> +#define __COMPAT_scx_bpf_pick_idle_cpu_in_node(cpus_allowed, node, flags)	\
> +	(bpf_ksym_exists(scx_bpf_pick_idle_cpu_in_node) ?			\
> +	 scx_bpf_pick_idle_cpu_in_node(cpus_allowed, node, flags) :		\
> +	 scx_bpf_pick_idle_cpu(cpus_allowed, flags))
> +
> +#define __COMPAT_scx_bpf_pick_any_cpu_in_node(cpus_allowed, node, flags)	\
> +	(bpf_ksym_exists(scx_bpf_pick_any_cpu_in_node) ?			\
> +	 scx_bpf_pick_any_cpu_in_node(cpus_allowed, node, flags) :		\
> +	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
> +
>  /*
>   * Define sched_ext_ops. This may be expanded to define multiple variants for
>   * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
> -- 
> 2.48.1

