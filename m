Return-Path: <bpf+bounces-63050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEA8B02042
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39B21C28349
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792FB18E750;
	Fri, 11 Jul 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXfg7je7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QxeiEQWa"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092B18DF8D
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247056; cv=none; b=kCFfwSG/08d5MT0qTyKSY2AUn5lgsF7/cENpTDqPu4Bl3Ojl/+vJQ4Ixn//vYn1c2wDfXvzoLMXQ8YO3qFG1aTpSwVim5qpEbOasZSts91I+xkfhVnqsm0xMnfR8tAgKekEl2P0zn64ypKAKcNbSDfQKtRqldsZz+RVefBfPh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247056; c=relaxed/simple;
	bh=Ptue6tmOjG3ZooF4AZl5c7bfBjefhQekoBlKAb9D7C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phy5A4J15k+JNdOCmIdHIB4GKR37lG5Hw6nCRGDwvv3wDimTsxsAAw0BBk6EMRMVJjrwHN4JMPAfhCTARW55iUox6utNCb4ny0kISCsMFFSmvMcmg317NGzFNp/Jem7sAMAuu8wL0TuGcu6T4Oz1UpEqmOyqOC1ghetw/xB+NYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aXfg7je7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QxeiEQWa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 17:17:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752247052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pOCqH/qLVEN97c3uEHQuTllvWCzoEwEQ2Lqk+DAzhqI=;
	b=aXfg7je7r4tU+Hbnm9yHX1TOsW12XtxZkqb3KygPeB460uaHaDSF6EiQgOHB0JOFJGNcLD
	aujJRxsZ/6lBZ2CkwCm2EIOnIVQcZXjlvikC/do11I8rSHPwl87MW3P0tiKfRoNciEMLfk
	bA6/EzQWMZzQHqcn//Aivdi3UmkKZxxDkeDrPjhYL3f64dQPFgy6eSdsy1PIeGTLMeeObp
	8Rk+j2JhVjE7d8neAnyY2kbUhUfJv2Ky8Eu+KC1KZk8UHr5w4TOSwDVXH4KFSPGLM1L+o+
	x8g9xzxL8A1fYpjPSjrIGFnjNgrkQ1SSQIFQoXWJRh2zcBdAiqFHPvwaIGLJeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752247052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pOCqH/qLVEN97c3uEHQuTllvWCzoEwEQ2Lqk+DAzhqI=;
	b=QxeiEQWaq98hgkJbdo1XXIkkn1sv4ugt+f/J3/lNGZi1TcecI218GT5JSBidQfHL6K26rd
	UkYu85eOpnBrt7AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, harry.yoo@oracle.com, shakeel.butt@linux.dev,
	mhocko@suse.com, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org,
	rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce
 local_lock_lockdep_start/end()
Message-ID: <20250711151730.rz_TY1Qq@linutronix.de>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-4-alexei.starovoitov@gmail.com>
 <20250711075001.fnlMZfk6@linutronix.de>
 <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz>

On 2025-07-11 11:55:22 [+0200], Vlastimil Babka wrote:
> On 7/11/25 09:50, Sebastian Andrzej Siewior wrote:
> > On 2025-07-08 18:53:00 [-0700], Alexei Starovoitov wrote:
> >> From: Alexei Starovoitov <ast@kernel.org>
> >> 
> >> Introduce local_lock_lockdep_start/end() pair to teach lockdep
> >> about a region of execution where per-cpu local_lock is not taken
> >> and lockdep should consider such local_lock() as "trylock" to
> >> avoid multiple false-positives:
> >> - lockdep doesn't like when the same lock is taken in normal and
> >>   in NMI context
> >> - lockdep cannot recognize that local_locks that protect kmalloc
> >>   buckets are different local_locks and not taken together
> >> 
> >> This pair of lockdep aid is used by slab in the following way:
> >> 
> >> if (local_lock_is_locked(&s->cpu_slab->lock))
> >> 	goto out;
> >> local_lock_lockdep_start(&s->cpu_slab->lock);
> >> p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> >> local_lock_lockdep_end(&s->cpu_slab->lock);
> >> 
> >> Where ___slab_alloc() is calling
> >> local_lock_irqsave(&s->cpu_slab->lock, ...) many times,
> >> and all of them will not deadlock since this lock is not taken.
> > 
> > So you prefer this instead of using a trylock variant in ___slab_alloc()
> > which would simply return in case the trylock fails?
> 
> The code isn't always in a position to "simply return". On !RT I think we
> can at least assume that if we succeeded once, it means we're not a irq/nmi
> interrupting a locked context so we'll succeed the following attempts too.
> On RT IIUC the lock might be taken by someone else, so a trylock might fail
> (even if it should also mean we're in a context that can do a non-try lock).

There is this parent check. If the parent check "allows" the allocation
then on !RT the trylock should always succeed. So the return "empty
handed" would be there but should not happen kind of thing.

On RT this is different so local_lock_is_locked() will return false but
the trylock might fail if the lock is acquired by another task.

But then with this change we do trylock from lockdep's point of view
while in reality we do the full locking including possible context
switch.

That is why I don't like the part where we trick lockdep.

If we the parent check we could trylock for !RT and normal lock for RT
what we actual do.
If there is no parent check then we could do "normal lock" on both
sides.

Sebastian

