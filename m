Return-Path: <bpf+bounces-46496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969629EAB37
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 10:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5630028402A
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 09:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18172230992;
	Tue, 10 Dec 2024 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NiIsVxpu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="37vZR01z"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3322CBE9
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821301; cv=none; b=sbMS4MMqMk+ucGZrk7+QAkfwb0iNDzD17aIPRycnmsa4UyYuxcwL8bPE8KY8lAvc+T6DIiHJgrRL6cc8i4oEkZGJBNA8L1M8c5fEenz+GXsepISBBW7jTQDq+Hi3tYdJTUxQI0oALFnDvTciqC6++0Q7ozXYh/6R3LoHu7aIfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821301; c=relaxed/simple;
	bh=J7rtqy8MhH1GN5WMq3a7jxjD9FQoGI0+jbsZ21UaT68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzQgvt3V5ljqX/hY7tiHmHjko+MNB8X7yPcymM8PI6gS1p0ubHm8V+QbDUKJVfots1GYUiWbIUGRPhGI/JFrURGT64FTfkW/RjIpRxsqAAYDCweJ2IQxBeSMvkjG4luGazjJrejK0ogddaA/OB4g2NoaQThfa3bHzrrOY6qGyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NiIsVxpu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=37vZR01z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Dec 2024 10:01:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733821297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLPVydrjgFcQUrebQfUKKXc+oRg9J32yus5NohbqKBs=;
	b=NiIsVxpu+5F5PPtQgrjLxOvj1jQQkcwGc5U9F9oZdzJTlVDLv7TWMHSDKpgCaRSZK+Oz9g
	x/0bPvpoFnMEb2jzzdrkmB9SgZYce9On5w5VWDnggeGJo936l1SWKClaO0DQjCyoKWRCWv
	wq/5Um0xx6zL7bZgMkUVNdKvrWUpgX/L6GqUrsL/JO9+1mAm/ekTgTZEfo5iQ+pzl4BPTV
	shABUZJIvcABKBMDZPu6DIhmvJoV4M08ghcVZsqstCWEg6vCCuOEI1qFispvHpRvyFYFSQ
	Z6GzIt3/bcba34Ze6ILFb8GS5bMhv8/HGECbOgtL8B8Fgt3vUlhfoWtQZCKVag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733821297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLPVydrjgFcQUrebQfUKKXc+oRg9J32yus5NohbqKBs=;
	b=37vZR01z16pE4mZreHJSA6yrQeO3CNMPYyG07J0koMKzR3tH3/opzQrzFQnGO6brJoTfVG
	691zdhvOYHFj9eDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, mhocko@suse.com, willy@infradead.org,
	tglx@linutronix.de, tj@kernel.org, linux-mm@kvack.org,
	kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <20241210090136.DGfYLmeo@linutronix.de>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210023936.46871-2-alexei.starovoitov@gmail.com>

On 2024-12-09 18:39:31 [-0800], Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Tracing BPF programs execute from tracepoints and kprobes where running
> context is unknown, but they need to request additional memory.
> The prior workarounds were using pre-allocated memory and BPF specific
> freelists to satisfy such allocation requests. Instead, introduce
> __GFP_TRYLOCK flag that makes page allocator accessible from any context.
> It relies on percpu free list of pages that rmqueue_pcplist() should be
> able to pop the page from. If it fails (due to IRQ re-entrancy or list
> being empty) then try_alloc_pages() attempts to spin_trylock zone->lock
> and refill percpu freelist as normal.
> BPF program may execute with IRQs disabled and zone->lock is sleeping in RT,
> so trylock is the only option.

The __GFP_TRYLOCK flag looks reasonable given the challenges for BPF
where it is not known how much memory will be needed and what the
calling context is. I hope it does not spread across the kernel where
people do ATOMIC in preempt/ IRQ-off on PREEMPT_RT and then once they
learn that this does not work, add this flag to the mix to make it work
without spending some time on reworking it.

Side note: I am in the process of hopefully getting rid of the
preempt_disable() from trace points. What remains then is attaching BPF
programs to any code/ function with a raw_spinlock_t and I am not yet
sure what to do here.

Sebastian

