Return-Path: <bpf+bounces-51700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF8A37618
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 17:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B78F3AD4EF
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11819D07A;
	Sun, 16 Feb 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzNnuw+e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF5450FE;
	Sun, 16 Feb 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739725026; cv=none; b=uVA54P4qAwxWr4rt1mWcrgm0Ynol9doUAwkXes0wemBbBdLr7eOcaIw9fP9qtATc6XxlenIEr+R8/xECr0pE/nPRTS/pdMkNft6bqTt1krfplcm/h5BiPvMfozUB9IAHMN2NT8doSvTgzIk77gUVRyDTClI1yxqmjNdFAvBhMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739725026; c=relaxed/simple;
	bh=vFZ0bIZ4JUsP4R5cEsTCRCJCscbl/sGPQwm3H8zHCr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgbRP4H8oJkfploHCIfSHnBljuMTZlWybu1r0hWDAlH1X8EILJDagv6Zb4/KtKehdzdsytKiq6daZ5uNVxYdjILAaOJ9a6cLd+1V+VIhA0j5vd/KhEymIAqrMwCGXjETY+SKkxUgIecr7EZDANeXSCRBHyJpsnwPRjlCGVyw+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzNnuw+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F28BC4CEDD;
	Sun, 16 Feb 2025 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739725024;
	bh=vFZ0bIZ4JUsP4R5cEsTCRCJCscbl/sGPQwm3H8zHCr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzNnuw+e+QUfckWuIq9Mft4taJNR/pvCCuBiDe+lxRT2GXPivlx1NYUVtO2wqyJuU
	 xyvG6xrymf3Ymaka2+B4A6D+Aef/Qa+kaDZpZhhuNX4z51W2GiyKvp4bSgq7BSz15N
	 hYk9iqHgjb+rI4IfXxMlHpmdgrR/XZmaqIXtz4WWN9/pnHwhVKe/OUGkhpVG4jrFVy
	 C/BHAjRtxpAw8Y6plebt9z0nVqsygaVcxkm2URVHNzxSFQcs4csvHA5pmDTicDMnwW
	 MPzEXeWRZj2c8B1XwG7h89mba6Hm20FKpG0S2SWtIXCBUiQdjNWp0/Zra2Telz2Wid
	 vOYuh6VLqkmow==
Date: Sun, 16 Feb 2025 06:57:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <Z7IY3yr1VErsryqw@slm.duckdns.org>
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

Hello,

On Fri, Feb 14, 2025 at 08:40:07PM +0100, Andrea Righi wrote:
...
>  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
>  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
>  s32 scx_bpf_pick_idle_cpu_in_node(const cpumask_t *cpus_allowed,
>  				   int node, u64 flags)

All other functions have just _node as the suffix. Might as well do the same
here?

>  s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed,
>  			       int node, u64 flags)

...
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

Shouldn't the UP case forwarded to scx_bpf_get_idle_cpumask()? Wouldn't a
NUMA aware scheduler running on a UP kernel end up specifying 0 to these
calls?

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

Ditto here.

Thanks.

-- 
tejun

