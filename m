Return-Path: <bpf+bounces-51858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB54A3A6B5
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 20:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2818163E17
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F9A1E5210;
	Tue, 18 Feb 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvZ+9MbP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8A1E51FA;
	Tue, 18 Feb 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905316; cv=none; b=TsFjFbCoVc/XusuuIgVlJism0nqcn75E6pqSgQhrrkrR802t/6q1xdV3wEHYp66AawPH6kZ2m09M8ej8TZr6y9EGjYXvwJOH2cvGqnFflOkFYUgThv1uVTz4MnEtFEi9hjs3JzzCneU8UaeldVJgo0ij5y+PxRubE9KFKg4AJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905316; c=relaxed/simple;
	bh=Av3t9RgInU6NiGdNhbHWmJrvk9syT37gmBr7/gcU0Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSUvAzz+8+dR1Pdsutu8TkV0cEQNBYbTD/CEB98Xi+urhsiL/BftrrtVpqidYX4jwZ94JAQjRW06w0cB2r5u8cSckQEToRGjy6Zgiap+YTE/Qb7XJqUuUQI6NzYudN7qg1bO823XbBQutrluj4a7sec3jl1EIPyMO7gZLjg4Ess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvZ+9MbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFCDC4CEE2;
	Tue, 18 Feb 2025 19:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739905315;
	bh=Av3t9RgInU6NiGdNhbHWmJrvk9syT37gmBr7/gcU0Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvZ+9MbPUchd33XS1vDQUBEYIx9AbiypwEIbyBrL60Bl2dG/M6V8TqzeQEnNM1P0p
	 hWbLrBSgRAhcaYMtyZ/W9XBkk/jMYqK4Z4/gNk0A7h5MoNwflNHEPjU/AgbJwOUgv7
	 qpM8rc4mVH0v2ymjV/z/EDjmwrj7k07RhU43qYNGZXqoXN90REpFImRuO1/hmcW48U
	 uAmJPASE67B9M3b4AYBOyzKv1XtlGqPs/SPhmhPVlPpvhd4LpjT3Q9hN+9MSUasLRX
	 PRA4mSb057UP3XvwsHXPZGticNphEHG+vk0AdNCXaKS3IJX8qauq+ufBY4ooXcEud3
	 yQVjRoeDZG8Kw==
Date: Tue, 18 Feb 2025 09:01:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: idle: Introduce node-aware
 idle cpu kfunc helpers
Message-ID: <Z7TZIvaxzEDD2u9A@slm.duckdns.org>
References: <20250218180441.63349-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218180441.63349-1-arighi@nvidia.com>

On Tue, Feb 18, 2025 at 07:04:41PM +0100, Andrea Righi wrote:
> Introduce a new kfunc to retrieve the node associated to a CPU:
> 
>  int scx_bpf_cpu_node(s32 cpu)
> 
> Add the following kfuncs to provide BPF schedulers direct access to
> per-node idle cpumasks information:
> 
>  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
>  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
>  s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed,
>  				int node, u64 flags)
>  s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed,
>  			       int node, u64 flags)
> 
> Moreover, trigger an scx error when any of the non-node aware idle CPU
> kfuncs are used when SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled.
> 
> Cc: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.15.

Thanks.

-- 
tejun

