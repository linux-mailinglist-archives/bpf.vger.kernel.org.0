Return-Path: <bpf+bounces-54087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E35A6241F
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 02:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76280422981
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 01:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89A0158520;
	Sat, 15 Mar 2025 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="J7GsQtMe"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80006B666;
	Sat, 15 Mar 2025 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742002530; cv=none; b=RnVoFmUn4/DnG8uNASnghWV7wmQ75iAWLf/x+xXMYPN5yRNhcKVi5COqf491Ablc+2CRj6ZXvbAut9tBNaFjJ3n4/VVbmJqRjuWKleeh94cQFB6uk/stSbGYicZuTEau5VgsrFGftltggGiejzzf/Z2jIW6ZxJ91GU64WgpT7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742002530; c=relaxed/simple;
	bh=OSyCfk62Q/Tt8SviwkVOUVxjviFBPntvvrxDDA/hZbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccf3GNbrDUEyDsnj1AqJpb7Bxac/8eQspRW+qO8SIcdJlv7ktsnhKDWbw5R00pHnIz3yTTNQcDUhaBsvtqWhQEUrrFZQ8+5XypW2T7G4hbv3S3LQehsoDdhtzM/qwHRn0vbdKrm1Br9y+Ry972m3cp86GSaZZzRCd1DgAda+dFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=J7GsQtMe; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nx9gejWr4WDG8cfylnB9SzitCw/zhVSBrt3k6GSezok=; b=J7GsQtMedzUPTbtM3or32iQTZe
	g8K8xl2K5Y5FL1IKdfNJnGTQO6GgGMHg8gGOD3jqD5jzo/Sdci50/IBeOoEcDiMVPgKeWbR1nfkaq
	pPIbA0p09Y9hv7fihGGvPlGEdS8l3p2GIxQ6ttdHCgoQlLJyiZc07y1LA6w8QRVwaKlilcUbTqkee
	RkhcJAIch9gUGaB57AlBv2tc0nTisPTQ5Joqj3JsgkisCOoOKcy3d0QxSXIu7iW+a7Lf49rVo0bsI
	yCbvUT5+HXqOtI4BHiowyjAvi9BjtR6KfyNyE6HlmN76PygW/clcUlyLKz9TfH7RJURfHgo3/Pmzj
	GvBcxcFg==;
Received: from [116.84.110.107] (helo=[10.56.180.219])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ttGQg-000JCb-JG; Sat, 15 Mar 2025 02:35:10 +0100
Message-ID: <b350d05c-3279-4d62-86fe-555ef0985f03@igalia.com>
Date: Sat, 15 Mar 2025 10:35:03 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] sched_ext: idle: Introduce scx_bpf_select_cpu_and()
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250314094827.167563-1-arighi@nvidia.com>
 <20250314094827.167563-7-arighi@nvidia.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20250314094827.167563-7-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrea,

Thank you for the great work! I like it.

On 3/14/25 18:45, Andrea Righi wrote:
> Provide a new kfunc, scx_bpf_select_cpu_and(), that can be used to apply
> the built-in idle CPU selection policy to a subset of allowed CPU.
> 
> This new helper is basically an extension of scx_bpf_select_cpu_dfl().
> However, when an idle CPU can't be found, it returns a negative value
> instead of @prev_cpu, aligning its behavior more closely with
> scx_bpf_pick_idle_cpu().
> 
> It also accepts %SCX_PICK_IDLE_* flags, which can be used to enforce
> strict selection to @prev_cpu's node (%SCX_PICK_IDLE_IN_NODE), or to
> request only a full-idle SMT core (%SCX_PICK_IDLE_CORE), while applying
> the built-in selection logic.
> 
> With this helper, BPF schedulers can apply the built-in idle CPU
> selection policy restricted to any arbitrary subset of CPUs.
> 
> Example usage
> =============
> 
> Possible usage in ops.select_cpu():
> 
> s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
> 		   s32 prev_cpu, u64 wake_flags)
> {
> 	const struct cpumask *cpus = task_allowed_cpus(p) ?: p->cpus_ptr;
> 	s32 cpu;
> 
> 	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, cpus, 0);
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
> Load distribution on a 4 sockets, 4 cores per socket system, simulated
> using virtme-ng, running a modified version of scx_bpfland that uses
> scx_bpf_select_cpu_and() with 0xff00 as the allowed subset of CPUs:
> 
>   $ vng --cpu 16,sockets=4,cores=4,threads=1
>   ...
>   $ stress-ng -c 16
>   ...
>   $ htop
>   ...
>     0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
>     1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
>     2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
>     3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
>     4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
>     5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
>     6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
>     7[                         0.0%]  15[||||||||||||||||||||||||100.0%]
> 
> With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across
> all the available CPUs.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>   kernel/sched/ext.c                       |  1 +
>   kernel/sched/ext_idle.c                  | 41 ++++++++++++++++++++++++
>   tools/sched_ext/include/scx/common.bpf.h |  2 ++
>   3 files changed, 44 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f42352e8d889e..343f066c1185d 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -465,6 +465,7 @@ struct sched_ext_ops {
>   	 * idle CPU tracking and the following helpers become unavailable:
>   	 *
>   	 * - scx_bpf_select_cpu_dfl()
> +	 * - scx_bpf_select_cpu_and()
>   	 * - scx_bpf_test_and_clear_cpu_idle()
>   	 * - scx_bpf_pick_idle_cpu()
>   	 *
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 549551bc97a7b..c0de7b64771d4 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -914,6 +914,46 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>   	return prev_cpu;
>   }
>   
> +/**
> + * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p,
> + *			    prioritizing those in @cpus_allowed
> + * @p: task_struct to select a CPU for
> + * @prev_cpu: CPU @p was on previously
> + * @wake_flags: %SCX_WAKE_* flags
> + * @cpus_allowed: cpumask of allowed CPUs
> + * @flags: %SCX_PICK_IDLE* flags
> + *
> + * Can only be called from ops.select_cpu() if the built-in CPU selection is
> + * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
> + * @p, @prev_cpu and @wake_flags match ops.select_cpu().

I think that scx_bpf_select_cpu_and () needs to be allowed to
call from ops.enqueue(). That is because many scx schedulers have
some logic similar to scx_bpf_select_cpu_dfl() to kick an idle
CPU proactively.

> + *
> + * Returns the selected idle CPU, which will be automatically awakened upon
> + * returning from ops.select_cpu() and can be used for direct dispatch, or
> + * a negative value if no idle CPU is available.
> + */
> +__bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
> +				       const struct cpumask *cpus_allowed, u64 flags)
> +{
> +	s32 cpu;
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
> +	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, cpus_allowed, flags);
> +#else
> +	cpu = -EBUSY;
> +#endif
> +
> +	return cpu;
> +}
> +
>   /**
>    * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
>    * idle-tracking per-CPU cpumask of a target NUMA node.
> @@ -1222,6 +1262,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
>   
>   BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
>   BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
>   BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
>   
>   static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index dc4333d23189f..6f1da61cf7f17 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -48,6 +48,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
>   
>   s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
>   s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
> +s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
> +			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
>   void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
>   void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
>   u32 scx_bpf_dispatch_nr_slots(void) __ksym;

Regards,
Changwoo Min

