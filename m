Return-Path: <bpf+bounces-50817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDBA2D0D0
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 23:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7313A5ED1
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC111C701B;
	Fri,  7 Feb 2025 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Buo4wBT7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45F1B040E;
	Fri,  7 Feb 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967999; cv=none; b=YWdqnv/B48IED7Y5JLsEHhUtB9qJA6g9dToOXa2QpjaB9uIuq/86UyaEY5rEqZfxiuKfJZIroUJhojBU1lxtfJ34CEBsh5H4zwrCn3aPAsnXb/kNTKJZSI+zzWE2L4dlanKpsu664Ko457FjJMY8M6WkmNb9yoQOnn3myqI/GPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967999; c=relaxed/simple;
	bh=CkqyHQsJo+5JgwcQ+3Aney3H89UG2dd28pIxPBnkThc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOoX6/fhlggfAkcp1ypbb3vCLAGBjvOndxreFdCm8i1CZgf6f+JFKXzNxI63f2Sz8cWfgEcWKq7zBsaotsKCEnIuoZydMvUkWkgRSoVOZ+l2+3eD+3LhbwDhs85xehz3ndUufJ744QFQGme8LFZ4pTrRmgEv8HFIGWHfsh7zpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Buo4wBT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F1CC4CEE2;
	Fri,  7 Feb 2025 22:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738967998;
	bh=CkqyHQsJo+5JgwcQ+3Aney3H89UG2dd28pIxPBnkThc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Buo4wBT7WySW/cbrPBP+wB3qhkBQ8zFJhNDXrpHD67VpuPSgCDGgU43I2ExBeJV1I
	 w3KEytqAB16A6TgmE/CTJGj1UiiRERNRb6h+CinduxI0njnEbr1BSdLNGGvzEJ9p82
	 xkYjKhTn6PvmmI0MdPjEEEiKWMsprsc0IcB8jkbjck/W53T/dvgCJ5yvBfhXOU4una
	 Q2cT9vI5pxXWYmV8+F/pNzT/Vvtr4hUynBhoEPHek6BOqKCJGDgzdBmIUE7G5M3B5N
	 +ewgiIMbsG4h5Iga3CGWAbBjCmJ6/82gilSELUs8/jlvRFRPVW3ce/01j5aDt6uLmf
	 tdC1DLNZ7Q4RQ==
Date: Fri, 7 Feb 2025 12:39:57 -1000
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
Subject: Re: [PATCH 6/6] sched_ext: idle: Introduce node-aware idle cpu kfunc
 helpers
Message-ID: <Z6aLvYaYlQ3KRZQM@slm.duckdns.org>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207211104.30009-7-arighi@nvidia.com>

Hello,

On Fri, Feb 07, 2025 at 09:40:53PM +0100, Andrea Righi wrote:
> +/**
> + * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
> + */
> +__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)

Maybe scx_bpf_cpu_node() to be in line with scx_bpf_task_cpu/cgroup()?

> +{
> +#ifdef CONFIG_NUMA
> +	if (cpu < 0 || cpu >= nr_cpu_ids)
> +		return -EINVAL;

Use ops_cpu_valid()? Otherwise, we can end up calling cpu_to_node() with an
impossible CPU. Also, I don't think CPU -> node mapping function should be
able to return an error value. It should just trigger ops error.

> +
> +	return idle_cpu_to_node(cpu);

This is contingent on scx_builtin_idle_per_node, right? It's confusing for
CPU -> node mapping function to return NUMA_NO_NODE depending on an ops
flag. Shouldn't this be a generic mapping function?

> index 50e1499ae0935..caa1a80f9a60c 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -130,6 +130,25 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
>  	 scx_bpf_now() :							\
>  	 bpf_ktime_get_ns())
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

Can you please document when these compat macros can be dropped? Also,
shouldn't it also provide a compat macro for the new ops flag using
__COMPAT_ENUM_OR_ZERO()? Otherwise, trying to load new binary using the new
flag on an older kernel will fail, right?

Thanks.

-- 
tejun

