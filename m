Return-Path: <bpf+bounces-51611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33B4A36766
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 22:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39218188F0D6
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B586A1C84D3;
	Fri, 14 Feb 2025 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsqobFvN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161C158870;
	Fri, 14 Feb 2025 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567908; cv=none; b=TgdD1FlwZRvVJnS0Yhl+HlBwXm+sTQ9NRFdg+Vyc9NMz7n5mbRNmyQqGZXgHX3+UFE37wKiZO4DJCVbpfSgJw/tnfibwMCfeVIvhKdAfrm78OUSZV3+NOI9vFaVMQ0Cw0K7ekn7+SijiT61gHrCxxpT3+z48pv7WGvRgQ/CkZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567908; c=relaxed/simple;
	bh=sNU2XAhIKuEEpgkr7Xm6asbxDr/4+bo2Np9K6hb4foM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFLSl0TdrKLf/a1p4iSxUxT/9XjdtTShCq6E2DKN2mmPMWR0aYH0lVwtLDgPxiBUxPtoGM0xa2TL116/3f9U+va88HNS7xkzoK9iHwmJKDKm7fqe/kj8+FxwGb/MkhMjJmMbgqxez3YZtZQrUVCIgOZntwHe9NAEqacchLahBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsqobFvN; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f666c94285so22859147b3.3;
        Fri, 14 Feb 2025 13:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739567905; x=1740172705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/PYvExTKYV7QNek37Q/9DbyXfxEkliKEbaqlBR21U4=;
        b=AsqobFvN+BDxakJNGnezwgsmpbQq5p5l1cxs1nAVO/6sAz2oFNM67Rl1LoM+7BDNV4
         yqiUmgBa4PkmE3YJACXBeBpEqeNYSc8CQibwNpWnPtc2sc3h8mVVV5CwN4ToPT0pwlxq
         2cLXTVi6+G6r/Wy+fOrSpVOLDHm4UPFoHBy4sr7DAOnQnlYGFGUZRjBWYZ1uRTqrQ7+F
         /QGssg77pxcpirnSWvuuIEXA+1MdEKiK4VOPTANjP9ZazOd6h6zk3dkTryKsEsn2JL2Q
         Sbkeuf6nqjE4CMJAjdP1i18T0RwHNlX6er8jbTQozs0Riu3E5tp5rgxLC1I3n86AHNK0
         hX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567905; x=1740172705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/PYvExTKYV7QNek37Q/9DbyXfxEkliKEbaqlBR21U4=;
        b=FxMxUTgB+LiXfROpq29GdZBH5nIlUgnY2DsQI4FF4Pu0ewNpAk+kaNwPKdLMqtvrKD
         2RDH07Cf+RhullM50cvz2s0cy4I0Ow8pgyYLmP1DB37QKjP47RSqCcL4xmHghZ6IxW8O
         cLA25LstFE8RKc0g1e4M3jS4bjUrGYDvcKPEHakTFAhF61/h7SmNzjBPjowspfRGZdLZ
         pJUqw2XyQCmXbY8m5nops9DwCqZP1tU38S+IPoY8GkgPoHbu1VToRQXgJ/91Ovq59blT
         i6g2udEwkp+YotD5kam76SfCM7wJDhgyM8yPd9KHU62Cw6fLAYiwbFidb33aTyhFqIe0
         NqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB7gpypJ1AsYk1QW1lU9PPNMGuSne6VnPFyOgDSG1dTU+13CX1fvInvDwhfTDuA98aNrg=@vger.kernel.org, AJvYcCWxFF+LyR5FpYWXXxwu01o5fMcshd6JsrfzFTv3rfK7FV/MeReFVfoJxNZ0Jr3xs81vRtdTOGYnfIZx7vix@vger.kernel.org
X-Gm-Message-State: AOJu0YwhT2lBCuAjbGLLmcVahxLySljbK/xUD9YrelRMQNfarOMLEETq
	kdENjuF3ScSA4pu8e6ge2ZJdXvJpSDkKn/W3Q9/80tI1NVOO4B7e
X-Gm-Gg: ASbGncsZduZgNBwXEefo+30H9CRFJt79SPtrK1Tvo97+ArPD8llUWdtyg4i07ArJrqm
	PKk+CixAQQn4YRkmNNNtFPpCJt7aEx66isS1bxpleFCdSRg/on/2/iVkEA90NkPRGzrhCmsFoNs
	z+uoC4UAdZHI2/GAzZvLFTNFcRIx51i9/A5eyF8w/BjPtr6jDakSm0Lg4hez6ilpG4wGWPTTKEr
	Vovwv0/ypg8w9Y/cpcVcSYAWMzeT7z+jo+SUsd7foODM8790fwZg6yPErNikJtspO/F1v8juigV
	V0sgmpbPyNsup+aZ8cBhM13exuC90xaU9aK9d5swZl4iekFmSak=
X-Google-Smtp-Source: AGHT+IGtMbOpHKOqxb/CHWiMZbfhMskZ0iGzw1FODIXAfGnUqzKVIsCYZ1UVVJyI7zkp/BqDeWeqcA==
X-Received: by 2002:a05:690c:670a:b0:6ef:91a0:dd30 with SMTP id 00721157ae682-6fb58280a67mr10527287b3.12.1739567905454;
        Fri, 14 Feb 2025 13:18:25 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb3619bd9bsm9217667b3.78.2025.02.14.13.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:18:24 -0800 (PST)
Date: Fri, 14 Feb 2025 16:18:23 -0500
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
Subject: Re: [PATCH 6/8] sched_ext: idle: Introduce
 SCX_OPS_BUILTIN_IDLE_PER_NODE
Message-ID: <Z6-zH3Gh87KC0ykb@thinkpad>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214194134.658939-7-arighi@nvidia.com>

On Fri, Feb 14, 2025 at 08:40:05PM +0100, Andrea Righi wrote:
> Add the new scheduler flag SCX_OPS_BUILTIN_IDLE_PER_NODE, which allows
> BPF schedulers to select between using a global flat idle cpumask or
> multiple per-node cpumasks.
> 
> This only introduces the flag and the mechanism to enable/disable this
> feature without affecting any scheduling behavior.
> 
> Cc: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

> ---
>  kernel/sched/ext.c                   | 21 ++++++++++++++++++--
>  kernel/sched/ext_idle.c              | 29 +++++++++++++++++++++-------
>  kernel/sched/ext_idle.h              |  4 ++--
>  tools/sched_ext/include/scx/compat.h |  3 +++
>  4 files changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 7c17e05ed15b1..330a359d79301 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -154,6 +154,12 @@ enum scx_ops_flags {
>  	 */
>  	SCX_OPS_ALLOW_QUEUED_WAKEUP	= 1LLU << 5,
>  
> +	/*
> +	 * If set, enable per-node idle cpumasks. If clear, use a single global
> +	 * flat idle cpumask.
> +	 */
> +	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
> +
>  	/*
>  	 * CPU cgroup support flags
>  	 */
> @@ -165,6 +171,7 @@ enum scx_ops_flags {
>  				  SCX_OPS_ENQ_MIGRATION_DISABLED |
>  				  SCX_OPS_ALLOW_QUEUED_WAKEUP |
>  				  SCX_OPS_SWITCH_PARTIAL |
> +				  SCX_OPS_BUILTIN_IDLE_PER_NODE |
>  				  SCX_OPS_HAS_CGROUP_WEIGHT,
>  };
>  
> @@ -3427,7 +3434,7 @@ static void handle_hotplug(struct rq *rq, bool online)
>  	atomic_long_inc(&scx_hotplug_seq);
>  
>  	if (scx_enabled())
> -		scx_idle_update_selcpu_topology();
> +		scx_idle_update_selcpu_topology(&scx_ops);
>  
>  	if (online && SCX_HAS_OP(cpu_online))
>  		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
> @@ -5228,6 +5235,16 @@ static int validate_ops(const struct sched_ext_ops *ops)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * SCX_OPS_BUILTIN_IDLE_PER_NODE requires built-in CPU idle
> +	 * selection policy to be enabled.
> +	 */
> +	if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
> +	    (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))) {
> +		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE requires CPU idle selection enabled");
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -5352,7 +5369,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  			static_branch_enable_cpuslocked(&scx_has_op[i]);
>  
>  	check_hotplug_seq(ops);
> -	scx_idle_update_selcpu_topology();
> +	scx_idle_update_selcpu_topology(ops);
>  
>  	cpus_read_unlock();
>  
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index ed1804506585b..0912f94b95cdc 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -14,6 +14,9 @@
>  /* Enable/disable built-in idle CPU selection policy */
>  static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
>  
> +/* Enable/disable per-node idle cpumasks */
> +static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
> +
>  #ifdef CONFIG_SMP
>  #ifdef CONFIG_CPUMASK_OFFSTACK
>  #define CL_ALIGNED_IF_ONSTACK
> @@ -204,7 +207,7 @@ static bool llc_numa_mismatch(void)
>   * CPU belongs to a single LLC domain, and that each LLC domain is entirely
>   * contained within a single NUMA node.
>   */
> -void scx_idle_update_selcpu_topology(void)
> +void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
>  {
>  	bool enable_llc = false, enable_numa = false;
>  	unsigned int nr_cpus;
> @@ -237,13 +240,19 @@ void scx_idle_update_selcpu_topology(void)
>  	 * If all CPUs belong to the same NUMA node and the same LLC domain,
>  	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
>  	 * for an idle CPU in the same domain twice is redundant.
> +	 *
> +	 * If SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled ignore the NUMA
> +	 * optimization, as we would naturally select idle CPUs within
> +	 * specific NUMA nodes querying the corresponding per-node cpumask.
>  	 */
> -	nr_cpus = numa_weight(cpu);
> -	if (nr_cpus > 0) {
> -		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
> -			enable_numa = true;
> -		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
> -			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
> +	if (!(ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)) {
> +		nr_cpus = numa_weight(cpu);
> +		if (nr_cpus > 0) {
> +			if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
> +				enable_numa = true;
> +			pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
> +				 cpumask_pr_args(numa_span(cpu)), nr_cpus);
> +		}
>  	}
>  	rcu_read_unlock();
>  
> @@ -530,6 +539,11 @@ void scx_idle_enable(struct sched_ext_ops *ops)
>  	}
>  	static_branch_enable(&scx_builtin_idle_enabled);
>  
> +	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
> +		static_branch_enable(&scx_builtin_idle_per_node);
> +	else
> +		static_branch_disable(&scx_builtin_idle_per_node);
> +
>  #ifdef CONFIG_SMP
>  	/*
>  	 * Consider all online cpus idle. Should converge to the actual state
> @@ -543,6 +557,7 @@ void scx_idle_enable(struct sched_ext_ops *ops)
>  void scx_idle_disable(void)
>  {
>  	static_branch_disable(&scx_builtin_idle_enabled);
> +	static_branch_disable(&scx_builtin_idle_per_node);
>  }
>  
>  /********************************************************************************
> diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
> index bbac0fd9a5ddd..339b6ec9c4cb7 100644
> --- a/kernel/sched/ext_idle.h
> +++ b/kernel/sched/ext_idle.h
> @@ -13,12 +13,12 @@
>  struct sched_ext_ops;
>  
>  #ifdef CONFIG_SMP
> -void scx_idle_update_selcpu_topology(void);
> +void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
>  void scx_idle_init_masks(void);
>  bool scx_idle_test_and_clear_cpu(int cpu);
>  s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
>  #else /* !CONFIG_SMP */
> -static inline void scx_idle_update_selcpu_topology(void) {}
> +static inline void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops) {}
>  static inline void scx_idle_init_masks(void) {}
>  static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
>  static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
> index b50280e2ba2ba..d63cf40be8eee 100644
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
> @@ -109,6 +109,9 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
>  #define SCX_OPS_SWITCH_PARTIAL							\
>  	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_SWITCH_PARTIAL")
>  
> +#define SCX_OPS_BUILTIN_IDLE_PER_NODE						\
> +	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE")
> +
>  static inline long scx_hotplug_seq(void)
>  {
>  	int fd;
> -- 
> 2.48.1

