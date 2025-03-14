Return-Path: <bpf+bounces-54064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB18A6194E
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 19:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02EA173F59
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB82046A3;
	Fri, 14 Mar 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9CVUA8X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757913BBE5;
	Fri, 14 Mar 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976511; cv=none; b=RJMGjThdNmrmxpeeFLzzSuFT17uSYMAWR1Tx/eBW5VLunTDNFzVXHlrghm6Hx0ISjN1h/77eqO/wtfQngw4M0e1NANIMdGSOmqq7ocsNBZp8SBxZoVLgjzEeYWfdR06PLb48ZaNz4SIlpkUA4ZLXeu58/WcrlqqfMmoKPF+PARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976511; c=relaxed/simple;
	bh=H7dzxQ95mwD3YuD9klsGDXzXj1c49uPvr7AyIRkLjeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDgYHlxmCMwitn/YHrfuAdxrQ3izEUEj3dry3ske1gwwp6uahK6Z1FdDx823KzzTn0e3axWUprzhbSq75NrpjIeuPhkTHMps0veCpIzC4Pis95pmtEohQwQny7JdOyrgO7qt2Fi3Iq4ttX0g7YaVJ5b5G0us3zwu5XI1wZRsrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9CVUA8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DA8C4CEE3;
	Fri, 14 Mar 2025 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741976511;
	bh=H7dzxQ95mwD3YuD9klsGDXzXj1c49uPvr7AyIRkLjeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9CVUA8XcPHIIGlzzlKt45lLtPd07364wBfGl+jh4ir+HQ4p5ghdrfkWz19Y6Uhg3
	 ECu98fJ/bkcEqK7W4Lfn6FK93OKOdDOO1lF7/anOPWfR8WYvLrmZXrXhgY/fHV5dWM
	 QBA/QVqkM8acNQrL+v/gOu6PMVID1TnSBEkc0FMyLV5/hwGE2dbvmd1UrTRhkweg42
	 gg7KNKhHVO9QLJtU/2HL+xs5M7cjykNWtZHtuMOo6lIsZ/Kfq4O7p6X4J+ajrbOjJp
	 Lj3WM3+1lWO6WFVGNs9iKkBRx7kj7OjQ9q272Shaxw+CjqKa0YljcHfDmiRwJoBfWB
	 uA+aqJI5IPzYA==
Date: Fri, 14 Mar 2025 08:21:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] sched_ext: idle: Extend topology optimizations to
 all tasks
Message-ID: <Z9RzvWMiHWqiO2v7@slm.duckdns.org>
References: <20250314094827.167563-1-arighi@nvidia.com>
 <20250314094827.167563-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314094827.167563-4-arighi@nvidia.com>

Hello,

On Fri, Mar 14, 2025 at 10:45:35AM +0100, Andrea Righi wrote:
...
> -	if (p->nr_cpus_allowed >= num_possible_cpus()) {
> -		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
> -			numa_cpus = numa_span(prev_cpu);
> -
> -		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
> -			llc_cpus = llc_span(prev_cpu);
> +	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
> +		struct cpumask *cpus = numa_span(prev_cpu);
> +
> +		if (cpus && !cpumask_equal(cpus, p->cpus_ptr)) {
> +			if (cpumask_subset(cpus, p->cpus_ptr)) {
> +				numa_cpus = cpus;
> +			} else {
> +				numa_cpus = this_cpu_cpumask_var_ptr(local_numa_idle_cpumask);
> +				if (!cpumask_and(numa_cpus, cpus, p->cpus_ptr))
> +					numa_cpus = NULL;
> +			}
> +		}
> +	}
> +	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
> +		struct cpumask *cpus = llc_span(prev_cpu);
> +
> +		if (cpus && !cpumask_equal(cpus, p->cpus_ptr)) {
> +			if (cpumask_subset(cpus, p->cpus_ptr)) {
> +				llc_cpus = cpus;
> +			} else {
> +				llc_cpus = this_cpu_cpumask_var_ptr(local_llc_idle_cpumask);
> +				if (!cpumask_and(llc_cpus, cpus, p->cpus_ptr))
> +					llc_cpus = NULL;
> +			}
> +		}
> 

Wouldn't it still make sense to special case p->nr_cpus_allowed >=
num_possible_cpus()? That'd be vast majority of cases and we can skip all
the cpumask comparisons for them.

Thanks.

-- 
tejun

