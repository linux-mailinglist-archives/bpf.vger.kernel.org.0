Return-Path: <bpf+bounces-50881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6813A2DB54
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 07:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22923A6E13
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 06:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D64E4315E;
	Sun,  9 Feb 2025 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyvDw5Ki"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29F4C9F;
	Sun,  9 Feb 2025 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739082689; cv=none; b=QkcF2+fWljTGZWuty7bVJtsQY80akvJZuvy83EWiug8Og9cf7pmslJIBeu+o8e0+XcS24OwRw8N5wMNwRhdYaFvQMXwaP6Trj3VS0YbSmbmf+N9wxPAvGjTjxe85OUZG1OPAteHj5lNzmjpS8Em5ZLpvA+/p4nyvY5Lz+vkfNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739082689; c=relaxed/simple;
	bh=qt1Pyzky27XsEZLTSgS5j4UdVBYposknEM02Y+btvnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhnil7l/44HJR8iW9roNdwiQF0O2fKpIyL6SNBV6AsaHk4YU92ByINVpWYWoj/XpaHEFl6j5dPKWojoknrGHDaku9qGdDhU1a5A8zZct92KWAM8i2K7T87KRn8TcUVxBDRg0ZE46Al03znXxnaKWuot9pSWUsor/zTZi2h6zAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyvDw5Ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64030C4CEDD;
	Sun,  9 Feb 2025 06:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739082688;
	bh=qt1Pyzky27XsEZLTSgS5j4UdVBYposknEM02Y+btvnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyvDw5KitVsshZJB62iHnvfi9JUm2aEUeLGFKgntgAYlVKhbbGPma5kyhFe0d+/sL
	 YxQ0vUGfv55qFFuKPySVjJMAP/2j7fcDI+aq/mFzPfzAOsn3crhar879F7amaBje5v
	 yiNBbm4Uht0DDrN2RfcYuFnPybaLFEuMTmOv7ipEzaEfAzSe35w5ZieVryeO3OAL0N
	 NAcU60b8qqAWN7Cyy8l+snCG8YmjMVfsa1dW4Jl3L9Q81DsQIMmx9YaYySl6T1E9Rg
	 HahGZhiZQ0BZ32chsxOViANaaCyxTr255Aj3s7rWPe25LpnFXRPD3A2U66UuYJB3Ib
	 JDdi2hwBy0JJw==
Date: Sat, 8 Feb 2025 20:31:27 -1000
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
Message-ID: <Z6hLvxEKFlgmIeOQ@slm.duckdns.org>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-7-arighi@nvidia.com>
 <Z6aLvYaYlQ3KRZQM@slm.duckdns.org>
 <Z6chqn0Xf6xhL5gA@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6chqn0Xf6xhL5gA@gpd3>

Hello,

On Sat, Feb 08, 2025 at 10:19:38AM +0100, Andrea Righi wrote:
...
> > This is contingent on scx_builtin_idle_per_node, right? It's confusing for
> > CPU -> node mapping function to return NUMA_NO_NODE depending on an ops
> > flag. Shouldn't this be a generic mapping function?
> 
> The idea is that BPF schedulers can use this kfunc to determine the right
> idle cpumask to use, for example a typical usage could be:
> 
>   int node = scx_bpf_cpu_node(prev_cpu);
>   s32 cpu = scx_bpf_pick_idle_cpu_in_node(p->cpus_ptr, node, SCX_PICK_IDLE_IN_NODE);
> 
> Or:
> 
>   int node = scx_bpf_cpu_node(prev_cpu);
>   const struct cpumask *idle_cpumask = scx_bpf_get_idle_cpumask_node(node);
> 
> When SCX_OPS_BUILTIN_IDLE_PER_NODE is disabled, we need to point to the
> global idle cpumask, that is identified by NUMA_NO_NODE, so this is why we
> can return NUMA_NO_NODE fro scx_bpf_cpu_node().
> 
> Do you think we should make this more clear / document this better. Or do
> you think we should use a different API?

I think this is too error-prone. It'd be really easy for users to assume
that scx_bpf_cpu_node() always returns the NUMA node for the given CPU which
can lead to really subtle surprises. Why even allow e.g.
scx_bpf_get_idle_cpumask_node() if IDLE_PER_NODE is not enabled?

Thanks.

-- 
tejun

