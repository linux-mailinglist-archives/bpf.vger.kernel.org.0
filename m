Return-Path: <bpf+bounces-51429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A512FA34916
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E03D1648BC
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43558200120;
	Thu, 13 Feb 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izoI+zQF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185A1E7C3A;
	Thu, 13 Feb 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462885; cv=none; b=YnGrttXAJixHaRRbwk/EKBiP0CdoatVsMGj/nc/V99VQH5NC7d0kQywNLsC+h1nEn9xVWJk69kqMfHyreI1mMVQyjhUJNdWB/uVCZUWPbLdAF/jgv/9fdX17ZuXBXHo0vCeAoJAssn4Y87SDBYCPZGbiugGkNcTmbouPIBtdW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462885; c=relaxed/simple;
	bh=XKnMV4c/9lW8YrGisKWsH7fkuPUrHaUQfWvYgOK2Q/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2ynbhcZMf1hs0adMVoE9iyurXxvsAQIfSmcDvV+bs8mEEt20Yik82Vxvpc0qnnyxlbSI6cAj9yRNNuJrqng/ao7p3Jk/Xyd7kaFCBdpzfQvx6sQC01trZU/N8JMHqZbVAsBPZdbK/hMwf2z8Ic8lAS+KjznkK+Ia4llPaE/Lsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izoI+zQF; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so813211276.3;
        Thu, 13 Feb 2025 08:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739462883; x=1740067683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZAo1TJDZkLDk+fZA+GiHiHJ4yB+DY564t+IadhdUJI=;
        b=izoI+zQFOLc1i7HsT3Oa4HmYSdkstsUE1RR7o0swmwsx870Ves4gkubfrkaW2SzDVg
         iScSVaG7JBSHg7HA5Z6yqCTo+QZEzJK7uS+cvqH3e2rlwfh5p2PyP8eBlaDJXwhyIUvl
         1q7Eu0KWblqDhla332H9tSToVXOLRl9WvTQe/aGBuIs8vX5rjjFe533l0ExOVxs3X3Tz
         5f3gohQUCEgefluix3P2LlLgVygyuAIV6Lw7XYFuCmeYm8KTBx4JJ4hDJcLBaqvbdIyD
         9JQOwLbodQjzwyB55R/CEFzKAP9OpaF19o7P0hhtbZzCBu/DB1yVACAECW226nK+KKm7
         6L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462883; x=1740067683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZAo1TJDZkLDk+fZA+GiHiHJ4yB+DY564t+IadhdUJI=;
        b=qHq613uKUFmKNJuoBXPF9dfgPkxzC471xngL31fEkQmmiGHe+VjsQY+LrpH82+hF/B
         SleGBQnbNfWb00E+slQkJ0MXyQffPLGbn+wTJfxLL9PvsYYgr+Lp6k3K5wo0ZbV7j01F
         IAbljCqlAQ58EyThA5SgHHu05zn9xjAwzvDQaO2ERJBPFKoYsoU4BUHmbtGP9NGXzI7k
         OQVQETyCXPNXP6va+WJreKx0SEXMGQkQAdsn/JB87VURloB/uHmKUaXRLGVyotjZ/VCS
         VsPUh0n9rvUZJXZnToReyZQxRci3r4rj1Uqtd4WilHgn9vfyqiH0Wsx99DnFT4pparhl
         GFXw==
X-Forwarded-Encrypted: i=1; AJvYcCWMeC/9AgwfhbbFfnAVCDXSq+6Uc9wEb6+Ni8K9qlNoXR+4NiBjCUHXOjq7L6c+SmkOQbMNQ6WjbgFKK1B8@vger.kernel.org, AJvYcCXJSkChyzItvuJ3kkMWNJCW3hkhhd2XILxBa3DFrc4HLVtKqWxbn91SZ25h7bdsTr0/lRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeEosAHVvOGOXXpB6oUQVK9P07IvYlW+GyfGJd/EX+VcvKF2Lp
	lkS48FksV3kaTWlBIkBhPjHto2J7ipwzZVOds/LcJwFYhTAYb+5n
X-Gm-Gg: ASbGncsAjOP6GoQuAKGOZk0ZIq8NGxV9M+Q9pnhgKfCF65NpF0DlSBeOJTSB54UEgpc
	UeQyykrrffyGl49j7r6wGtENBVDVtdPvzDQoWDK1rccdEiecdDti82SOJFTPMOPFVjH+mW93iEW
	ARe3oE6mO2SLQAE8SuSkMky14mNV7cJIzRpaPgqzbKPMZ64Fe15XOBHTzxarlwRqkhGZ4G3Awce
	nWbejqaWY/eIbI9L4vSF+WJ1otPcnwtWYDJVTypvXQuHsI9ZDzuLedYSvfJ10OI2o3Xxq342PKS
	SB6M3bs69hXOUMGkwXC2rZElIPV6u6N0AsfiPBe2tu5Lh925EZ0=
X-Google-Smtp-Source: AGHT+IHY7R/MPd94BBAIfl5uhtJQLrDW0UnuZiS0Kb5oIDwCzdWLf/xTHTpqV+MzXChqkdMGUGZSOg==
X-Received: by 2002:a05:6902:2383:b0:e5b:1389:bbd4 with SMTP id 3f1490d57ef6-e5d9f0e9a25mr7190665276.17.1739462882693;
        Thu, 13 Feb 2025 08:08:02 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dadea936dsm465928276.17.2025.02.13.08.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:08:02 -0800 (PST)
Date: Thu, 13 Feb 2025 11:08:01 -0500
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
Subject: Re: [PATCH 5/7] sched_ext: idle: Introduce
 SCX_OPS_BUILTIN_IDLE_PER_NODE
Message-ID: <Z64Y4Sgw30Pdj81J@thinkpad>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212165006.490130-6-arighi@nvidia.com>

On Wed, Feb 12, 2025 at 05:48:12PM +0100, Andrea Righi wrote:
> Add the new scheduler flag SCX_OPS_BUILTIN_IDLE_PER_NODE, which allows
> BPF schedulers to select between using a global flat idle cpumask or
> multiple per-node cpumasks.
> 
> This only introduces the flag and the mechanism to enable/disable this
> feature without affecting any scheduling behavior.
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c                   | 21 ++++++++++++++++++--
>  kernel/sched/ext_idle.c              | 29 +++++++++++++++++++++-------
>  kernel/sched/ext_idle.h              |  4 ++--
>  tools/sched_ext/include/scx/compat.h |  3 +++
>  4 files changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c47e7e2024a94..c3e154f0e8188 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -138,6 +138,12 @@ enum scx_ops_flags {
>  	 */
>  	SCX_OPS_ENQ_MIGRATION_DISABLED = 1LLU << 4,
>  
> +	/*
> +	 * If set, enable per-node idle cpumasks. If clear, use a single global
> +	 * flat idle cpumask.
> +	 */
> +	SCX_OPS_BUILTIN_IDLE_PER_NODE = 1LLU << 5,
> +
>  	/*
>  	 * CPU cgroup support flags
>  	 */
> @@ -148,6 +154,7 @@ enum scx_ops_flags {
>  				  SCX_OPS_ENQ_EXITING |
>  				  SCX_OPS_ENQ_MIGRATION_DISABLED |
>  				  SCX_OPS_SWITCH_PARTIAL |
> +				  SCX_OPS_BUILTIN_IDLE_PER_NODE |
>  				  SCX_OPS_HAS_CGROUP_WEIGHT,
>  };
>  
> @@ -3409,7 +3416,7 @@ static void handle_hotplug(struct rq *rq, bool online)
>  	atomic_long_inc(&scx_hotplug_seq);
>  
>  	if (scx_enabled())
> -		scx_idle_update_selcpu_topology();
> +		scx_idle_update_selcpu_topology(&scx_ops);
>  
>  	if (online && SCX_HAS_OP(cpu_online))
>  		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
> @@ -5184,6 +5191,16 @@ static int validate_ops(const struct sched_ext_ops *ops)
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
> @@ -5308,7 +5325,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  			static_branch_enable_cpuslocked(&scx_has_op[i]);
>  
>  	check_hotplug_seq(ops);
> -	scx_idle_update_selcpu_topology();
> +	scx_idle_update_selcpu_topology(ops);
>  
>  	cpus_read_unlock();
>  
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index ed1804506585b..59b9e95238e97 100644
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
> +				 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));

No need to call numa_weight(cpu) for the 2nd time, right?

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

