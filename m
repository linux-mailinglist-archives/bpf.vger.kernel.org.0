Return-Path: <bpf+bounces-58013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB6EAB39F8
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 16:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E5A168E6F
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D331DF72C;
	Mon, 12 May 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gX1kpk/O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WqDC6E+p"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A21DC1A7
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058645; cv=none; b=EiufeoZqcFYm5LJjsRDE9GM+EanKsVNBfvkO/CTpCIvXjw8oh2DK5x0k1kg3XvxygZmFV7MwWLFlSJhXm573ixpih1zn9E+KTh5H7wkxpEZz4ZLG2bbedhsWtp/1pe+a2A/5dqPQP6JbyvaK1vc43inajH1NAJMFOdxlzxR8RpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058645; c=relaxed/simple;
	bh=fflCw+J3avP7UdzL6YIk0Ir9WULJ99NyQ8/1hC/nPFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5notXVnqdXGXglHYVx3qf7bPa0h92IiLJMv6OoWOCvZBxpxrr4NkvRPBeVNDlOAf/S0IA6o9COW0W7YvcYgTcnkKegojARbDHkceoxc0+ZCbhUOcV/Xm+62kuqTJnx0L5x8F7DrMkljKhHqkXWmPRc/JRvl8FBMPI7rDleRwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gX1kpk/O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WqDC6E+p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 May 2025 16:03:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747058641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmMAbGSzMPoi/yrVNLZojsOJT87/A8we2IirP3fKdC4=;
	b=gX1kpk/OUGarG2wpwKpK0LVUVFaT+rWyDNbwuBqv+bMhEaBsvQOBrvPno9vtzIHHXGGqa1
	vUyIUY1RhlV8TomdkGXzY20i2Xt0HTN6GgPrg7xR5gYUzBJjlyaWp1hmJpcQ4t7t3r3U1Q
	AHJ15GVMBhO2/dhTrRSyiuwj725L/a3VFKTQ78DyxPR+JsXiO1a0jVupTwNVsITwYxThmf
	Z7taya+TSLq8f4NWuUVRKaQodtX/h4n/0P/FyODTdX0h180qYwneYa3KvvQrnXmgd8vjjF
	S78Uo319YgASpmsukBmtNxWvkZeyYr22w5c6Q/4COGbZtETlfl09j2RzxRpxDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747058641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmMAbGSzMPoi/yrVNLZojsOJT87/A8we2IirP3fKdC4=;
	b=WqDC6E+pwICdOIUhoy6gsg249fKFw2Y1mo2s5TCM7OwpuzJ+jg4FXu3/U8zoGMJpLfTbDe
	chJvi7odiAjskpBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org,
	willy@infradead.org
Subject: Re: [PATCH 4/6] locking/local_lock: Introduce
 local_lock_irqsave_check()
Message-ID: <20250512140359.CDEasCj3@linutronix.de>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-5-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250501032718.65476-5-alexei.starovoitov@gmail.com>

On 2025-04-30 20:27:16 [-0700], Alexei Starovoitov wrote:
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -168,6 +168,15 @@ do {								\
>  /* preemption or migration must be disabled before calling __local_lock_is_locked */
>  #define __local_lock_is_locked(lock) READ_ONCE(this_cpu_ptr(lock)->acquired)
>  
> +#define __local_lock_irqsave_check(lock, flags)					\
> +	do {									\
> +		if (IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&			\
> +		    (!__local_lock_is_locked(lock) || in_nmi()))		\
> +			WARN_ON_ONCE(!__local_trylock_irqsave(lock, flags));	\
> +		else								\
> +			__local_lock_irqsave(lock, flags);			\
> +	} while (0)
> +

Hmm. If I see this right in SLUB then this is called from preemptible
context. Therefore the this_cpu_ptr() from __local_lock_is_locked()
should trigger a warning here.

This check variant provides only additional debugging and otherwise
behaves as local_lock_irqsave(). Therefore the in_nmi() should return
immediately with a WARN_ON() regardless if the lock is available or not
because the non-try variant should never be invoked from an NMI. 

This looks like additional debug infrastructure that should be part of
local_lock_irqsave() itself, maybe hidden behind a debug switch which is
forced now from one of the current user. I don't think we need an extra
interface for this. It might be restricted to the trylock_test variant
if it makes sense but I wouldn't introduce an extra function for that.

>  #define __local_lock_release(lock)					\
>  	do {								\
>  		local_trylock_t *tl;					\

Sebastian

