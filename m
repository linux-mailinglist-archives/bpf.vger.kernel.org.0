Return-Path: <bpf+bounces-58019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68520AB3B6D
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9B417E5E6
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281EB22A1CA;
	Mon, 12 May 2025 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QMNdUY3P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yzNzejnq"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715C149C4A
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061777; cv=none; b=DffBWn/65+lOkaB+V6bS1b106sIdYEQ18d0lKaciQgbsoSInhiW5tyQf3aPmMy16RK8SdM+d5dYGlDEVoBTQ96P8Zp5QGk1bLz3wHoBE8CvriaZjj7jo1w3sc+1VjxywJN1H6hgXXtx2MnFa6ZaI8TRUKzYkuZvhHfxyK2Pqsg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061777; c=relaxed/simple;
	bh=jkGDDGyG/7jlP1QBNmMsmZEOHLFjCcsJMwE/9M3qwZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoS9dFp1nDvNENfRs2qA5W0rZf8tclKnr3VDIJDDlEqhKaxEPD6PowTjIj3izSF+sjPPjjD7AwXdESRZ+eN/tXSru0NNuAXhYwG2qoT9b9xqTl593PaN1lY9WP2zTwQu0pJIqXJbs1t8QVlMk/hi9yQ3Vx9W9U/vttSFFyr24aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QMNdUY3P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yzNzejnq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 May 2025 16:56:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747061774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qjY2w8WD0lirPnPLepdJVbgylh00yGbRS9fYHe7HBm0=;
	b=QMNdUY3PalH6311j+j79ZTJldoZyOeL/diTgxKbtOuR7V1jkR4wS4iehBwDZ6V6m6xCa5Y
	TLYOx+Bx5HeXTwVMvGg9qVADb6kmFXvMWTevpkL6mPqA4s1kUny5y50qloCXkFpCVRSawz
	/3OkVdrnqW5RbnglRO4kyHK9OvTh3TN53Z27zLExkI9nqIN2mVNQihh7180JMP7ZKAy4KL
	UBdWAAZ7fcG8pzUi4t6A9HV+W+i8i97aAYApFIbbxSaS2EBrCH93/bXTysKt93MJExj9Yf
	BMHVsUokjbj57FeUSAyjhZ2kd6mtlZzDW7c6zEtsYdoAc7IblUWM3cJXvzig1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747061774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qjY2w8WD0lirPnPLepdJVbgylh00yGbRS9fYHe7HBm0=;
	b=yzNzejnqudFuMK/0JXG6BuOWeOuQpZQURgb7PiWyw3NJYyrLHg3Fp9a9xUksyAtXzTVBZJ
	0OZ/DmaFb+jOQwDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org,
	willy@infradead.org
Subject: Re: [PATCH 3/6] locking/local_lock: Introduce local_lock_is_locked().
Message-ID: <20250512145613.eD3DUEa8@linutronix.de>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-4-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250501032718.65476-4-alexei.starovoitov@gmail.com>

On 2025-04-30 20:27:15 [-0700], Alexei Starovoitov wrote:
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -285,4 +288,9 @@ do {								\
>  		__local_trylock(lock);				\
>  	})
>  
> +/* migration must be disabled before calling __local_lock_is_locked */
> +#include "../../kernel/locking/rtmutex_common.h"
> +#define __local_lock_is_locked(__lock)					\
> +	(rt_mutex_owner(&this_cpu_ptr(__lock)->lock) == current)

So I've been looking if we really need rt_mutex_owner() or if
rt_mutex_base_is_locked() could do the job. Judging from the slub-free
case, the rt_mutex_base_is_locked() would be just fine. The alloc case
on the other hand probably not so much. On the other hand since we don't
accept allocations from hardirq or NMI the "caller == owner" case should
never be observed. Unless buggy & debugging and this should then also be
observed by lockdep. Right?

If there is another case where recursion can be observed and need to be
addressed I would prefer to move the function (+define) to
include/linux/rtmutex.h. instead of doing this "../../ include".

>  #endif /* CONFIG_PREEMPT_RT */

Sebastian

