Return-Path: <bpf+bounces-49008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54778A12F7B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 01:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8F93A55AF
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8C31372;
	Thu, 16 Jan 2025 00:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LHeS/34a"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216B360
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736986353; cv=none; b=F5+0hBOOiGaAEEQXdpr6WnM0pWcG9uoptDX+rtYbZzAVrjNmqjhW3LyL8ZI54+TrHZ0L81dVcRpfbs5j9ATrGmZjw9ckJOY25PgnNGhJ5zr71XSWYRLOjkjfwIRgkXg0CATqNvlR7CSCPNb/8gM1A9YilgjyUQ/Q6QD/rciR+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736986353; c=relaxed/simple;
	bh=sdUn3gZIDLWHBmMlnbkTnWYWr6s/2Kn4XrCDou8Kfxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBrmwGYRNSla1Fdz0HndSUKO2J8fqI54tneoA0vu60NXJqsXW5LNYXBWW2SVnzO8vu7wenBcks2KvdU10UVyT4CEqZqlA5I0gzA6Bg4eG7AT5KcTOdElSPFt0S0TZpiYmyfCleU5wDZmkry2coVmdUKieef2hKOQh+Yzxm5CSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LHeS/34a; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Jan 2025 16:12:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736986344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZT7ZTLPy9olOlHT7k674kvBfCCcnDoRNMOmEIKf7aU=;
	b=LHeS/34alX8N+ql0rNABKuVHVvaRpou1bvgLZq83X+QZ6uGZVZ8S2BoY8OaPW98xH8aJtr
	9862X8eMGLweezwibi8SiEg7tPWowpvM7/k+LzwQ3Qzr4Qg5g8Q2cXhb0nGYHlO8mnxhvZ
	kBIKcuOKp7bZS0Msf0I2XpcXN+oNIxU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com, 
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de, 
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org, mhocko@suse.com, 
	willy@infradead.org, tglx@linutronix.de, jannh@google.com, tj@kernel.org, 
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v5 4/7] memcg: Use trylock to access memcg
 stock_lock.
Message-ID: <svm77mp6vx5uui7zzzvfo27oijq6nh3ceqfdc676to6oruidaq@p7ddlyjwwwrw>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-5-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115021746.34691-5-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 14, 2025 at 06:17:43PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Teach memcg to operate under trylock conditions when spinning locks
> cannot be used.
> 
> local_trylock might fail and this would lead to charge cache bypass if
> the calling context doesn't allow spinning (gfpflags_allow_spinning).
> In those cases charge the memcg counter directly and fail early if
> that is not possible. This might cause a pre-mature charge failing
> but it will allow an opportunistic charging that is safe from
> try_alloc_pages path.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

> @@ -1851,7 +1856,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	unsigned long flags;
>  
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> +		/*
> +		 * In case of unlikely failure to lock percpu stock_lock
> +		 * uncharge memcg directly.
> +		 */
> +		mem_cgroup_cancel_charge(memcg, nr_pages);

mem_cgroup_cancel_charge() has been removed by a patch in mm-tree. Maybe
we can either revive mem_cgroup_cancel_charge() or simply inline it
here.

> +		return;
> +	}
>  	__refill_stock(memcg, nr_pages);
>  	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
>  }

