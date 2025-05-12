Return-Path: <bpf+bounces-58023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D4AB3BF2
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E054613F8
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24C22FDE6;
	Mon, 12 May 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tTUJ2Bsb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="axeR6NrI"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BFA19ABD4
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063418; cv=none; b=R1E+P3jtD/ULPXM0mkvUCc7XWU8GIW3shtU0FU2EqEaTVIlGvdtgK3exffgDanHDSWyjuV+aoMPoojB1P8K8DR1FLxpCbWLkAk4Bf7aWGf5v2HTPNROkuNrTeTA3wkKstdGHn8rqIiLFaSOKe6b3SYPjLNAGOgauQegmJdi3LDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063418; c=relaxed/simple;
	bh=QAOOPAIC7tx7no6JJlc2BfkhIvbLnN8cnYg7L+erzEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nse4/vP3e9zW/VQexUKmxqhgkoVr7h6V478iLgryWUvjfE1NTIsZnHzmjZJCZKOXbE76twYGW8d96BKgRV1+mO4dWlMm9Kp51G+KO8UmpO9fxSLuQKrRjzC4ic01p/RNvQ9qUmxNR0eRRiH4rV1YedcJPa7MhbgxID0n0T5Hj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tTUJ2Bsb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=axeR6NrI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 May 2025 17:23:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747063414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GzgD7yyKYi1dp3jkZ8Ijca5sabBJXlM7g63MwZ1HIyQ=;
	b=tTUJ2Bsbs1u1iudvU6Z4Q1XZw39SlWtOdTZlzb1577faCWjRpxx39QHIDjEzcAlD/tmlA3
	jSB7ml1yjhDnJaSb68gLq4JfW+epTaQ36/C/ZhdgDgMaNurzMNcUYPz4+zudpv1RDEubeO
	cbzsC8vHzgdlMjwPlrEqN/NI6sfspjbEDExnGyG+kyEs/mPuZGIQUh7i9umGdY5upGGpdn
	ofOjlrnLIUQQXGpXov7nKtarHJZmvvGseFUPnEF8ShErFwJpxbHio4IvkdIp9QBME7+yDC
	n0n2UGVzXl4lHff2V/Y5qsr4WyfcK8rVIT0jF/+WhYM9vgNnp2+qsrq1cPuaQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747063414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GzgD7yyKYi1dp3jkZ8Ijca5sabBJXlM7g63MwZ1HIyQ=;
	b=axeR6NrI1MLAA8YAmlpCgbOIvkpmAeMOJ7a141r1yFqeV3BwUjxarmwdM5PiDItgmtUxOv
	q0LKLUbN4OcuscDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, harry.yoo@oracle.com, shakeel.butt@linux.dev,
	mhocko@suse.com, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org,
	rostedt@goodmis.org, hannes@cmpxchg.org, willy@infradead.org
Subject: Re: [PATCH 3/6] locking/local_lock: Introduce local_lock_is_locked().
Message-ID: <20250512152333.Di9sTun1@linutronix.de>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-4-alexei.starovoitov@gmail.com>
 <20250512145613.eD3DUEa8@linutronix.de>
 <1c9bbd31-10f1-41b6-b2b9-745ab4e9e2ad@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c9bbd31-10f1-41b6-b2b9-745ab4e9e2ad@suse.cz>

On 2025-05-12 17:01:55 [+0200], Vlastimil Babka wrote:
> On 5/12/25 16:56, Sebastian Andrzej Siewior wrote:
> > On 2025-04-30 20:27:15 [-0700], Alexei Starovoitov wrote:
> >> --- a/include/linux/local_lock_internal.h
> >> +++ b/include/linux/local_lock_internal.h
> >> @@ -285,4 +288,9 @@ do {								\
> >>  		__local_trylock(lock);				\
> >>  	})
> >>  
> >> +/* migration must be disabled before calling __local_lock_is_locked */
> >> +#include "../../kernel/locking/rtmutex_common.h"
> >> +#define __local_lock_is_locked(__lock)					\
> >> +	(rt_mutex_owner(&this_cpu_ptr(__lock)->lock) == current)
> > 
> > So I've been looking if we really need rt_mutex_owner() or if
> > rt_mutex_base_is_locked() could do the job. Judging from the slub-free
> > case, the rt_mutex_base_is_locked() would be just fine. The alloc case
> > on the other hand probably not so much. On the other hand since we don't
> > accept allocations from hardirq or NMI the "caller == owner" case should
> > never be observed. Unless buggy & debugging and this should then also be
> > observed by lockdep. Right?
> 
> AFAIU my same line of thought was debunked by Alexei here:
> 
> https://lore.kernel.org/all/CAADnVQLO9YX2_0wEZshHbwXoJY2-wv3OgVGvN-hgf6mK0_ipxw@mail.gmail.com/
> 
> e.g. you could have the lock and then due to kprobe or tracing in the slab
> allocator code re-enter it.

Okay. So I assumed that re-entrace is not a thing here on PREEMPT_RT but
thank you correcting.
There is a difference if the lock is locked and you try a different one
if it is possible just to avoid the contention. Otherwise fallback to
the contention case if there is no other way. The other case is to avoid
recursive locking.

> > If there is another case where recursion can be observed and need to be
> > addressed I would prefer to move the function (+define) to
> > include/linux/rtmutex.h. instead of doing this "../../ include".
> > 
> >>  #endif /* CONFIG_PREEMPT_RT */

Sebastian

