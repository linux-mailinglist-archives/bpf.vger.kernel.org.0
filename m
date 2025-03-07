Return-Path: <bpf+bounces-53625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C20A574D0
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 23:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D81189139C
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A267207DF0;
	Fri,  7 Mar 2025 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ3InEQ9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA118BC36;
	Fri,  7 Mar 2025 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385845; cv=none; b=OklIv9+U6lV+FMIa41ls8tj71WPsFc00rPmcyznB3ZHhnPgwrkMf2NelY4q5FOw4XWaOrxg77xkbji6YfzvJlpvhr9FFyK0ySK710Icgzx0HSl6BbQowHi+qRLydwdaARdOkXrO/IdbS+Y3yKgWXjI/clR0PagB2ZQ7ZOXyXAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385845; c=relaxed/simple;
	bh=xZncabeg2pY81ef2kTNH2Siipl1hUkdDVBAPW8PZo5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvRg0qJnp9tZCJVQtUP20aqzC7rb77a5kZjOKwoiWuwbBtCMMKfaayC5hcLrYKztPVEH+TyDlhhNdY925eycYxfKHaLMp8u7m49WxO6rfyD+e0jDuzLAkM7igFLXdqIUWN05adl4WISjoja80Ol/mx/lNyCdZUGTtudBT5WzlN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ3InEQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3189FC4CED1;
	Fri,  7 Mar 2025 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741385845;
	bh=xZncabeg2pY81ef2kTNH2Siipl1hUkdDVBAPW8PZo5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZ3InEQ9MIoNhoJhCb4AJTZ+z7X4MEVbVNiCUoS7xcLeJ5IJ7+SEtOTeUMF6MZHDw
	 +gQSW/Sx7cW4cWBYODO/uOHhLUHIUgp9DIe70QiqHrsQLnu4HZSe2qREJci10yKcUb
	 GwiFRr6Oqwqe0+KnZiHpwt6Xjp4M6hmjbJQAe1986PnJSRfM6oo1xQwKmSlbUDvetr
	 2m7rTy2db50v8z7C1ASy817Fa+MzipcOj6+pMOoTehe5TfbFZqBKYDgeBaS1ahtCOt
	 Mq+pf8knHmOzxbO2Qrs5hdRyAxRgQlH30TWVqrdShUZyQHg+n4o5Y0BYU0eLskfVgE
	 dGYFrL+03rq+g==
Date: Fri, 7 Mar 2025 12:17:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] sched_ext: idle: Introduce the concept of allowed
 CPUs
Message-ID: <Z8twc3pc7I9SyIMC@slm.duckdns.org>
References: <20250307200502.253867-1-arighi@nvidia.com>
 <20250307200502.253867-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307200502.253867-4-arighi@nvidia.com>

Hello,

On Fri, Mar 07, 2025 at 09:01:05PM +0100, Andrea Righi wrote:
> Many scx schedulers define their own concept of scheduling domains to
> represent topology characteristics, such as heterogeneous architectures

I'm not sure "domain" is a good choice given that sched_domain is already an
established construct in kernel and means something specific.

> (e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
> specific properties (e.g., setting the soft-affinity of certain tasks to
> a subset of CPUs).
> 
> Currently, there is no mechanism to share these domains with the
> built-in idle CPU selection policy. As a result, schedulers often
> implement their own idle CPU selection policies, which are typically
> similar to one another, leading to a lot of code duplication.
> 
> To address this, introduce the concept of allowed domain (represented as
> a cpumask) that can be used by the BPF schedulers to apply the built-in
> idle CPU selection policy to a subset of preferred CPUs.

We don't need a new term here, do we? All that's being added is an extra
mask when picking CPUs.

> With this concept the idle CPU selection policy becomes the following:
>  - always prioritize CPUs from fully idle SMT cores (if SMT is enabled),
>  - select the same CPU if it's idle and in the allowed domain,
>  - select an idle CPU within the same LLC domain, if the LLC domain is a
>    subset of the allowed domain,

Why not select from the intersection of the same LLC domain and the cpumask?

>  - select an idle CPU within the same node, if the node domain is a
>    subset of the allowed domain,

Ditto.

>  - select an idle CPU within the allowed domain.
> 
> If the allowed domain is empty or NULL, the behavior of the built-in
> idle CPU selection policy remains unchanged.
> 
> This only introduces the core concept of allowed domain. This
> functionality will be exposed through a dedicated kfunc in a separate
> patch.
...
> -s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
> +s32 scx_select_cpu_dfl(struct task_struct *p, const struct cpumask *cpus_allowed,
> +		       s32 prev_cpu, u64 wake_flags, u64 flags)

Maybe rearrange them (p, prev_cpu, wake_flags, and_cpumask, pick_idle_flags)
so that the first three args align with select_task_rq() and we don't have
three consecutive integer arguments? Two back-to-back flag args increase the
chance of subtle bugs.

Thanks.

-- 
tejun

