Return-Path: <bpf+bounces-71691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD11BFAC4E
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 10:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165DB482834
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA626F443;
	Wed, 22 Oct 2025 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NK/cz02i"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658742FD7CE;
	Wed, 22 Oct 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120241; cv=none; b=TrMWepljGo/h/wvVtk4m3P9+CVYWPpKafsw4kk9oN70WqB8EhXAsztfZoiyZhAjqDL0LQmbh1XuPzO2UrqnCNVXnWF8MBuNA9SsuWpVKtx0DtyTwxmJozef2PKWtssB98vkSjC6fR+MMF6mSaYab11sf3oylgjerrR48Kq4CH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120241; c=relaxed/simple;
	bh=bfUMbPerq+fEDvB+LROzdmC3jXGd1Q9n6GZWvJZ87sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W35w4+lR11avXb2ZqDwSO4miKHPpj+g+D2E6iESAYtFQSoivQxMiIG6AXXLNpMxgn47ANQ3rj81pd1OxI1uQBsFrzOYZPvh6D1NyMbYbY9bjkUK2p/XE2L/jiew5QvXbJS09RkhTycpjAP0QsS7MJiZvuy2D2YDRVkPhLrMxSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NK/cz02i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=roqNU6kD3/csn+XxCTM9mwsRN24d/+pKYNj4gPjrxlI=; b=NK/cz02ixmd4tD6eYchUeu7VIl
	BfH9xW8inuL+5ePuN5iKfiquWdW4TYFRBVZJ8q6fcb7xDP6DYog9S3+vXqGLoWHfkVLjpVWEwC3cB
	qd8eo1/CsEahjs97xlllH0RKVsk6iMSKMJrHtDLM1POxxIxjx+EIkUrTAPrRYE+xqd35Il+lMMJKR
	LrEWJZyZdTppg5CYb6uHEta+OgqTQ8LbHKsfxWqldtd9iGKxma9iO7OMUrctngywfG7zzs0BsVXQ/
	RaGkExrZDvy29sVk4D2giYNrjk0yTKGGarxFvA76qOy3/OwrWBZVP9tjhnLxamafZmllX7CeYhir6
	pbbfINjQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBTow-00000000DYC-1Ee7;
	Wed, 22 Oct 2025 08:03:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6FF9C3003C4; Wed, 22 Oct 2025 10:03:46 +0200 (CEST)
Date: Wed, 22 Oct 2025 10:03:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: sched_ext: Fix SCX_KICK_WAIT to work reliably
Message-ID: <20251022080346.GH4067720@noisy.programming.kicks-ass.net>
References: <20251021210354.89570-1-tj@kernel.org>
 <20251021210354.89570-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021210354.89570-3-tj@kernel.org>

On Tue, Oct 21, 2025 at 11:03:54AM -1000, Tejun Heo wrote:

> @@ -5208,12 +5214,11 @@ static void kick_cpus_irq_workfn(struct
>  
>  		if (cpu != cpu_of(this_rq)) {
>  			/*
> -			 * Pairs with smp_store_release() issued by this CPU in
> -			 * switch_class() on the resched path.
> +			 * Pairs with store_release in put_prev_task_scx().
>  			 *
> -			 * We busy-wait here to guarantee that no other task can
> -			 * be scheduled on our core before the target CPU has
> -			 * entered the resched path.
> +			 * We busy-wait here to guarantee that the task running
> +			 * at the time of kicking is no longer running. This can
> +			 * be used to implement e.g. core scheduling.
>  			 */
>  			while (smp_load_acquire(wait_pnt_seq) == pseqs[cpu])
>  				cpu_relax();

You could consider using:

			smp_cond_load_acquire(wait_pnt_seq, VAL !+ pseqs[cpu]);

that's the fancy way of doing a spin wait and allows architectures to
optimize (mostly arm64 at this point).

