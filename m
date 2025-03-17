Return-Path: <bpf+bounces-54233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A20A65C6D
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 19:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE9B3B0CE8
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D17B1CDFD5;
	Mon, 17 Mar 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQekr6SP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95E1A7AF7;
	Mon, 17 Mar 2025 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235757; cv=none; b=mW+uyFBgceOdki7852okH0X7RY9N/h4Y4ATTc8PTdwi0Pv/tyLIkwjF/8TJmnuay61jOS+jIcuGY4aC19RFLfU6Pl6O99e6Pz9H8uf8/mCm8JgOFM5VHfZIGl5vBfhNsC0LgQoiFR6MIFLHRt/mzriKj3cTGN8blT9UYSe5OGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235757; c=relaxed/simple;
	bh=vL0Yz5Gj9JrIxchjuiU0zpCpzXorHmb3XwynihBlk+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na4bLUlxMhvBYw9WgEoIt10+gSyM9FOUEYDrwhefgKHxByz7cGuw4M2RwzyUyd5QJ1JzgXednFcrR6J45dqbCZWYJ012y1nAXDV0DJqxyL1cAo6N0Id2vOyvDUZasHnp65DM5WkMRNr5IGhROSGUq1gMADu0NnmjBdLSRFAyknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQekr6SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514B8C4CEE3;
	Mon, 17 Mar 2025 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742235756;
	bh=vL0Yz5Gj9JrIxchjuiU0zpCpzXorHmb3XwynihBlk+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQekr6SPa2rA4sseDKaGEga2v9M95Oh3R/Dofhm08uprqACliA2jzQpwxUQSI4gLh
	 oJY3fAeOUzEDcdZvQa4NNlq/GikSk8aRVLxtKCPxZu4tsaYTjgvcXspmyeVSXDanuB
	 ATFOjsDjCre4z/7pp5jYfJqYDfmIcBjco2UCqaxeeiwhWalQjMZ5xocSYVZi6uS66P
	 Omi6+KE2aoE9twC4SpB8SS1Ezoi2j5rhg+SLOP3jByybtpoiU2L2y113gftHotVnJn
	 M/qMZCKwbC0tPkleDkm9zZi85bfCjdpvUlWWdIR2zPrb+LlHnoziMSIuhnfYV0LCoF
	 dPNohXfPdp2lg==
Date: Mon, 17 Mar 2025 08:22:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sched_ext: idle: Extend topology optimizations to
 all tasks
Message-ID: <Z9hoa5iPpDEOnXKt@slm.duckdns.org>
References: <20250317175717.163267-1-arighi@nvidia.com>
 <20250317175717.163267-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317175717.163267-2-arighi@nvidia.com>

Hello,

On Mon, Mar 17, 2025 at 06:53:24PM +0100, Andrea Righi wrote:
> +/*
> + * Return the subset of @cpus that task @p can use or NULL if none of the
> + * CPUs in the @cpus cpumask can be used.
> + */
> +static const struct cpumask *task_cpumask(const struct task_struct *p, const struct cpumask *cpus,
> +					  struct cpumask *local_cpus)

task_cpus_allowed_and()? It also would help to add comment explaining the
parameters as the function is a bit unusual.

> +{
> +	/*
> +	 * If the task is allowed to run on all CPUs, simply use the
> +	 * architecture's cpumask directly. Otherwise, compute the
> +	 * intersection of the architecture's cpumask and the task's
> +	 * allowed cpumask.
> +	 */
> +	if (!cpus || p->nr_cpus_allowed >= num_possible_cpus() ||
> +	    cpumask_subset(cpus, p->cpus_ptr))
> +		return cpus;
> +
> +	if (!cpumask_equal(cpus, p->cpus_ptr) &&

Hmm... isn't this covered by the preceding cpumask_subset() test? Here, cpus
is not a subset of p->cpus_ptr, so how can it be the same as p->cpus_ptr?

> +	    cpumask_and(local_cpus, cpus, p->cpus_ptr))
> +		return local_cpus;
> +
> +	return NULL;

and return values need some explanation too.

Thanks.

-- 
tejun

