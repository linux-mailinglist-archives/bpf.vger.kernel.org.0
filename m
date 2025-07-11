Return-Path: <bpf+bounces-63006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0780B0152D
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 09:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C73E580A9A
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 07:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0F1E32DB;
	Fri, 11 Jul 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BGO+uaN6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xkBTp0EP"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C861F4285
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220206; cv=none; b=fNjY1AtFZ35ICr3fx9x1ya1Imkn74Y5pUblIUITHZIygTSJXnn1qgXM4qLFrYaKV3swq6gJH9x9NJ5LOnNm+6ppsVzCKvlYzjWMhO2NIR4BBW6W8cOKfSr5BrQTYlU2zvFfmNRYVWXDe1sCdsC0KphgutDVb8NC8RXhLjTXPccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220206; c=relaxed/simple;
	bh=8L4G42pODPFPvKvm9sg8Ron9dQK45H/XGVFzsSGinK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW11xH0foBFmbijAMyMCFPXCYOUU3s4wt3tlkXSHcKbymh7GBAJLAZY2RLzzjoo15HrUzV8mhTZSuXwHbRJtRQApcI3h4+1O3q3xp2SZ/AN4Yui9eU0i76qlZLoOrU+7a4buLw5/rNARmfgnBi+slArCpqmKd3rROklYYkFapqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BGO+uaN6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xkBTp0EP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 09:50:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752220203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWmcqnqQiP73QueAamvmhp37bREYRA3PPlsr8h+HG9M=;
	b=BGO+uaN6v9U78D4jLYkL1b6K/YM4EYheWYduTcvCdEOqcCN8k69V5u4Bpn+o7zvX7pqkJa
	Hb695E4tnE+7OxchTA01hCFO27v7/LR1Hq2jLN/h850Towpyhc4r3vXPBbZ/hYwKcEg166
	ep0qdzyrvvnl70ukjlG720tQSOdr0EX8G0J1CT80OgwBFS/AeYsdaujhfWFAAHmczTwWEj
	h+5UKtuwWrnw8IJOWfkujS1Kex2zcfcPWjeZemd6Ky4NfNuE1pDMGn741MnrW8wXeF2w6m
	9xiOzEL7QsqRIM2bpw5zweDUf2W1wE7AMJosOt+TnEPiF6Q6ez/6bj/HYiNg6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752220203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWmcqnqQiP73QueAamvmhp37bREYRA3PPlsr8h+HG9M=;
	b=xkBTp0EPRnFjtdrp8yJuOnzYORJr9SPd9dmOZb8yac08oSoLtKZMaBehkCV16TgLDLcpV5
	6UK8bKLfuf+EVKBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce
 local_lock_lockdep_start/end()
Message-ID: <20250711075001.fnlMZfk6@linutronix.de>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-4-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250709015303.8107-4-alexei.starovoitov@gmail.com>

On 2025-07-08 18:53:00 [-0700], Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Introduce local_lock_lockdep_start/end() pair to teach lockdep
> about a region of execution where per-cpu local_lock is not taken
> and lockdep should consider such local_lock() as "trylock" to
> avoid multiple false-positives:
> - lockdep doesn't like when the same lock is taken in normal and
>   in NMI context
> - lockdep cannot recognize that local_locks that protect kmalloc
>   buckets are different local_locks and not taken together
>=20
> This pair of lockdep aid is used by slab in the following way:
>=20
> if (local_lock_is_locked(&s->cpu_slab->lock))
> 	goto out;
> local_lock_lockdep_start(&s->cpu_slab->lock);
> p =3D ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> local_lock_lockdep_end(&s->cpu_slab->lock);
>=20
> Where ___slab_alloc() is calling
> local_lock_irqsave(&s->cpu_slab->lock, ...) many times,
> and all of them will not deadlock since this lock is not taken.

So you prefer this instead of using a trylock variant in ___slab_alloc()
which would simply return in case the trylock fails?
Having the local_lock_is_locked() is still good to avoid the lock
failure if it can be detected early. I am just not sure if the extra
lockdep override is really needed.

=E2=80=A6
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -81,6 +81,21 @@
>  #define local_trylock_irqsave(lock, flags)			\
>  	__local_trylock_irqsave(lock, flags)
> =20
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +#define local_lock_lockdep_start(lock)					\
> +	do {								\
> +		lockdep_assert(!__local_lock_is_locked(lock));		\
> +		this_cpu_ptr(lock)->dep_map.flags =3D LOCAL_LOCK_UNLOCKED;\
> +	} while (0)
> +
> +#define local_lock_lockdep_end(lock)					\
> +	do { this_cpu_ptr(lock)->dep_map.flags =3D 0; } while (0)
> +
> +#else
> +#define local_lock_lockdep_start(lock) /**/
> +#define local_lock_lockdep_end(lock) /**/

Why the /**/?

=E2=80=A6
> index 9f361d3ab9d9..6c580081ace3 100644
> --- a/include/linux/lockdep_types.h
> +++ b/include/linux/lockdep_types.h
> @@ -190,13 +190,15 @@ struct lockdep_map {
>  	u8				wait_type_outer; /* can be taken in this context */
>  	u8				wait_type_inner; /* presents this context */
>  	u8				lock_type;
> -	/* u8				hole; */
> +	u8				flags;
>  #ifdef CONFIG_LOCK_STAT
>  	int				cpu;
>  	unsigned long			ip;
>  #endif
>  };
> =20
> +#define LOCAL_LOCK_UNLOCKED		1

Maybe DEPMAP_FLAG_LL_UNLOCKED so it is kind of obvious where it belongs
to. Maybe use "u8 local_lock_unlocked:1;" instead the flags + define. It
is even used for held_lock below so it is not a new concept with
lockdep. It would narrow down the usage.

>  struct pin_cookie { unsigned int val; };
> =20

Sebastian

