Return-Path: <bpf+bounces-55181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A506A796EB
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 22:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889AB3B324B
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 20:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE97B1F4181;
	Wed,  2 Apr 2025 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s77R92D0"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38E1F30BE
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627390; cv=none; b=jeUUkmcdl/6JHfte+/ZSZNbKa/nSTh6zB4Z5CvDoEmFOoHiPiS9BFxrZmMTeuJAohHt1JXPnFAvdX2cRNL4W8g+PdWFdfXo2AEPc+EDH+kvAYArcxk3gnhZLeEam1Z3ptMD7mNoE7C9wszgdw4ViW8p+Y/VOEqIzc1igPbUUsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627390; c=relaxed/simple;
	bh=Ea6X89pYj/k3fVNoM2A0I92xYqPOC+A0sTg3PrPImqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFcbh3bdLn9zV9V7VoB5WKXiCA6895ssuh2B43WhHt3lcHP9ebpdHoJopAvvvC9MwQGmdi1m9Pvbby0VKJ2D9b2/RWvYnAZOMpAZ8fB5qNtmwPH6QlkRAI7+bd72lawKogX8W79FmgkFlhmfY3KBT4Px6aR4fhScrOjX3VCUyyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s77R92D0; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Apr 2025 13:56:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743627373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENBk6Zps1y3iJcNgBI6UVcMLN7HDztYsknTvn4weW9I=;
	b=s77R92D0wcOyKFh37BYitJugHAsVroC1aW2Rud2sNsta6FEInOiH7BlCpz5fbVHrJI+7Sk
	tvRwMrSkPMB9lZSmNXSX0rt9PhoEyGYDingWiM0o9KgOqHfoxtwa1ZjFtlN4wyTsFdRrJ6
	EdaLC8bZvzXVYyL0LkHXyvXvY0PuO2s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de, 
	rostedt@goodmis.org, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/local_lock, mm: Replace localtry_ helpers
 with local_trylock_t type
Message-ID: <umfukiohyxcxxw5g6ca5g7stq7oonnr3sbvjyjshnbqalzffeq@2nrwqsmwcrug>
References: <20250401205245.70838-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401205245.70838-1-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 01, 2025 at 01:52:45PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t").
> Remove localtry_*() helpers, since localtry_lock() name might
> be misinterpreted as "try lock".
> 
> Introduce local_trylock[_irqsave]() helpers that only work
> with newly introduced local_trylock_t type.
> Note that attempt to use local_trylock[_irqsave]() with local_lock_t
> will cause compilation failure.
> 
> Usage and behavior in !PREEMPT_RT:
> 
> local_lock_t lock;                     // sizeof(lock) == 0
> local_lock(&lock);                     // preempt disable
> local_lock_irqsave(&lock, ...);        // irq save
> if (local_trylock_irqsave(&lock, ...)) // compilation error
> 
> local_trylock_t lock;                  // sizeof(lock) == 4

Is there a reason for this 'acquired' to be int? Can it be uint8_t? No
need to change anything here but I plan to change it later to compact as
much as possible within one (or two) cachline for memcg stocks.

> local_lock(&lock);                     // preempt disable, acquired = 1
> local_lock_irqsave(&lock, ...);        // irq save, acquired = 1
> if (local_trylock(&lock))              // if (!acquired) preempt disable
> if (local_trylock_irqsave(&lock, ...)) // if (!acquired) irq save

For above two ", acquired = 1" as well.

> 
> The existing local_lock_*() macros can be used either with
> local_lock_t or local_trylock_t.
> With local_trylock_t they set acquired = 1 while local_unlock_*() clears it.
> 
> In !PREEMPT_RT local_lock_irqsave(local_lock_t *) disables interrupts
> to protect critical section, but it doesn't prevent NMI, so the fully
> reentrant code cannot use local_lock_irqsave(local_lock_t *) for
> exclusive access.
> 
> The local_lock_irqsave(local_trylock_t *) helper disables interrupts
> and sets acquired=1, so local_trylock_irqsave(local_trylock_t *) from
> NMI attempting to acquire the same lock will return false.
> 
> In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
> Map local_trylock_irqsave() to preemptible spin_trylock().
> When in hard IRQ or NMI return false right away, since
> spin_trylock() is not safe due to explicit locking in the underneath
> rt_spin_trylock() implementation. Removing this explicit locking and
> attempting only "trylock" is undesired due to PI implications.
> 
> The local_trylock() without _irqsave can be used to avoid the cost of
> disabling/enabling interrupts by only disabling preemption, so
> local_trylock() in an interrupt attempting to acquire the same
> lock will return false.
> 
> Note there is no need to use local_inc for acquired variable,
> since it's a percpu variable with strict nesting scopes.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

