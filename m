Return-Path: <bpf+bounces-53527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61804A55E1D
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 04:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 668317A8E8D
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 03:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B0618D626;
	Fri,  7 Mar 2025 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pFpK/hE+"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F46DDD2;
	Fri,  7 Mar 2025 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317319; cv=none; b=rueWSJ8UqRMyMWRrYTj5vF0WM4mCjNJrMb+T1012D8EFUZ8mJ7LeGS4xxp/guNMaz70bB3sJpqgx49jURK8GA7Nvkt0ejg2WmoSCbBuB9Ky3Tj4DbiY9gD9V71H1BkMFeDkkPpnRhh8l4nGPAaN7AneUBUxuhIGUq+WDADiaZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317319; c=relaxed/simple;
	bh=6kt5e0QfZ+niXPGr1l1JO4Xd1vBLqcj7FFj4iHCUzBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzUXVK2zOYsGhGGAhB+oA6SbPtj7zOxh8Z0DpChn04dtxlQTq3Oi+aI8Zp412MMFA+D+WOLteqt+zt9CMq2vJSDWtQI2Tr+DP2vLDrHsFgtqvekhuedEw8SKpqcxnxeKHOan64KzfkB989WOKmTjV9Y8mEJY72e+peOmvqk4yYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pFpK/hE+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bzpffp4ORHKW73893aQBl30ul0UyBNoiL3zOZRdfMB8=; b=pFpK/hE+QJmp3pYIDZoOzQId2C
	p2uGVei60grFeKS7Enq4PMgKj+ycd7Negz/984zJjGTfoKk5tRIiGpcbMjvVA11RZ5v0ej1k3NDSU
	fbyrF1sb9urLEiGUpBBEVRWLBPejEychdbPv0SWMozVxF27eEeBZj8LF4QFc0SgcZ2Jl2Grh0xP7O
	Hs52uwbD6UZqd1Df5PzAegx3KlfXqqtaFuJHj7WVYE9uHLhgZv8j1efMb7B5t4Y4YpBMVjBSTVgRv
	rwai4T+Vzw82KPfjrglwm8s2VxHK26KQeRYlQF0RH9r9oYYPVb/da98OalbMtMEmSt2tyHBSZ+Dmr
	LT4h1HbA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tqOAx-005ANC-1Z; Fri, 07 Mar 2025 04:15:09 +0100
Message-ID: <e3d578fe-5be5-4db7-8621-798468faee03@igalia.com>
Date: Fri, 7 Mar 2025 12:15:04 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] sched_ext: idle: Introduce scx_bpf_select_cpu_pref()
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306182544.128649-1-arighi@nvidia.com>
 <20250306182544.128649-4-arighi@nvidia.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20250306182544.128649-4-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25. 3. 7. 03:18, Andrea Righi wrote:
> Provide a new kfunc that can be used to apply the built-in idle CPU
> selection policy to a subset of preferred CPU:
> 
> s32 scx_bpf_select_cpu_pref(struct task_struct *p,
> 			    const struct cpumask *preferred_cpus,
> 			    s32 prev_cpu, u64 wake_flags, u64 flags);
> 
> This new helper is basically an extension of scx_bpf_select_cpu_dfl().
> However, when an idle CPU can't be found, it returns a negative value
> instead of @prev_cpu, aligning its behavior more closely with
> scx_bpf_pick_idle_cpu().
> 
> It also accepts %SCX_PICK_IDLE_* flags, which can be used to enforce
> strict selection to the preferred CPUs (%SCX_PICK_IDLE_IN_PREF) or to
> @prev_cpu's node (%SCX_PICK_IDLE_IN_NODE), or to request only a
> full-idle SMT core (%SCX_PICK_IDLE_CORE), while applying the built-in
> selection logic.
> 
> With this helper, BPF schedulers can apply the built-in idle CPU
> selection policy to a generic CPU domain, with strict or soft selection
> requirements.
> 
> In the future we can also consider to deprecate scx_bpf_select_cpu_dfl()
> and replace it with scx_bpf_select_cpu_pref(), as the latter provides
> the same functionality, with the addition of the preferred domain logic.
> 
> Example usage
> =============
> 
> Possible usage in ops.select_cpu():
> 
> s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
> 		  s32 prev_cpu, u64 wake_flags)
> {
> 	const struct cpumask *dom = task_domain(p) ?: p->cpus_ptr;
> 	s32 cpu;
> 
> 	/*
> 	 * Pick an idle CPU in the task's domain. If no CPU is found,
> 	 * extend the search outside the domain.
> 	 */
> 	cpu = scx_bpf_select_cpu_pref(p, dom, prev_cpu, wake_flags, 0);
> 	if (cpu >= 0) {
> 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> 		return cpu;
> 	}
> 
> 	return prev_cpu;
> }
> 
> Results
> =======
> 
> Load distribution on a 4 sockets / 4 cores per socket system, simulated
> using virtme-ng, running a modified version of scx_bpfland that uses the
> new helper scx_bpf_select_cpu_pref() and 0xff00 as preferred domain:
> 
>   $ vng --cpu 16,sockets=4,cores=4,threads=1
> 
> Starting 12 CPU hogs to fill the preferred domain:
> 
>   $ stress-ng -c 12
>   ...
>      0[|||||||||||||||||||||||100.0%]   8[||||||||||||||||||||||||100.0%]
>      1[|                        1.3%]   9[||||||||||||||||||||||||100.0%]
>      2[|||||||||||||||||||||||100.0%]  10[||||||||||||||||||||||||100.0%]
>      3[|||||||||||||||||||||||100.0%]  11[||||||||||||||||||||||||100.0%]
>      4[|||||||||||||||||||||||100.0%]  12[||||||||||||||||||||||||100.0%]
>      5[||                       2.6%]  13[||||||||||||||||||||||||100.0%]
>      6[|                        0.6%]  14[||||||||||||||||||||||||100.0%]
>      7|                         0.0%]  15[||||||||||||||||||||||||100.0%]
> 
> Passing %SCX_PICK_IDLE_IN_PREF to scx_bpf_select_cpu_pref() to enforce
> strict selection on the preferred CPUs (with the same workload):
> 
>      0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
>      1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
>      2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
>      3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
>      4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
>      5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
>      6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
>      7[                         0.0%]  15[||||||||||||||||||||||||100.0%]
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>   kernel/sched/ext.c                       |  1 +
>   kernel/sched/ext_idle.c                  | 60 ++++++++++++++++++++++++
>   tools/sched_ext/include/scx/common.bpf.h |  2 +
>   3 files changed, 63 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index a28ddd7655ba8..8ee4818de908b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -465,6 +465,7 @@ struct sched_ext_ops {
>   	 * idle CPU tracking and the following helpers become unavailable:
>   	 *
>   	 * - scx_bpf_select_cpu_dfl()
> +	 * - scx_bpf_select_cpu_pref()
>   	 * - scx_bpf_test_and_clear_cpu_idle()
>   	 * - scx_bpf_pick_idle_cpu()
>   	 *
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 9b002e109404b..24cba7ddceec4 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -907,6 +907,65 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>   	return prev_cpu;
>   }
>   
> +/**
> + * scx_bpf_select_cpu_pref - Pick an idle CPU usable by task @p,
> + *			     prioritizing those in @preferred_cpus
> + * @p: task_struct to select a CPU for
> + * @preferred_cpus: cpumask of preferred CPUs
> + * @prev_cpu: CPU @p was on previously
> + * @wake_flags: %SCX_WAKE_* flags
> + * @flags: %SCX_PICK_IDLE* flags
> + *
> + * Can only be called from ops.select_cpu() if the built-in CPU selection is
> + * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
> + * @p, @prev_cpu and @wake_flags match ops.select_cpu().
> + *
> + * Returns the selected idle CPU, which will be automatically awakened upon
> + * returning from ops.select_cpu() and can be used for direct dispatch, or
> + * a negative value if no idle CPU is available.
> + */
> +__bpf_kfunc s32 scx_bpf_select_cpu_pref(struct task_struct *p,
> +					const struct cpumask *preferred_cpus,
> +					s32 prev_cpu, u64 wake_flags, u64 flags)
> +{
> +#ifdef CONFIG_SMP
> +	struct cpumask *preferred = NULL;
> +	bool is_idle = false;
> +#endif
> +
> +	if (!ops_cpu_valid(prev_cpu, NULL))
> +		return -EINVAL;
> +
> +	if (!check_builtin_idle_enabled())
> +		return -EBUSY;
> +
> +	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
> +		return -EPERM;
> +
> +#ifdef CONFIG_SMP
> +	preempt_disable();
> +
> +	/*
> +	 * As an optimization, do not update the local idle mask when
> +	 * p->cpus_ptr is passed directly in @preferred_cpus.
> +	 */
> +	if (preferred_cpus != p->cpus_ptr) {
> +		preferred = this_cpu_cpumask_var_ptr(local_idle_cpumask);
> +		if (!cpumask_and(preferred, p->cpus_ptr, preferred_cpus))
> +			preferred = NULL;

I think it would be better to move cpumask_and() inside
scx_select_cpu_dfl() because scx_select_cpu_dfl() assumes that
anyway. That will make the code easier to read and avoid
potential mistakes when extending scx_select_cpu_dfl() in the
future.

> +	}
> +	prev_cpu = scx_select_cpu_dfl(p, preferred, prev_cpu, wake_flags, flags, &is_idle);
> +	if (!is_idle)
> +		prev_cpu = -EBUSY;
> +
> +	preempt_enable();
> +#else
> +	prev_cpu = -EBUSY;
> +#endif
> +
> +	return prev_cpu;
> +}
> +
>   /**
>    * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
>    * idle-tracking per-CPU cpumask of a target NUMA node.
> @@ -1215,6 +1274,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
>   
>   BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
>   BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_pref, KF_RCU)
>   BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
>   
>   static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index dc4333d23189f..a33e709ec12ab 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -47,6 +47,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
>   }
>   
>   s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
> +s32 scx_bpf_select_cpu_pref(struct task_struct *p, const struct cpumask *preferred_cpus,
> +			    s32 prev_cpu, u64 wake_flags, u64 flags) __ksym __weak;
>   s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
>   void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
>   void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;

