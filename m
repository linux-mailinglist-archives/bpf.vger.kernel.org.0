Return-Path: <bpf+bounces-49233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA5DA158A4
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 21:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D6B7A2BEA
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 20:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD071A9B23;
	Fri, 17 Jan 2025 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CEXwiZ+8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0TJ2bZ+2"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E913C9D4
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737146003; cv=none; b=c2tZpMApGTaXsPmk3iWw0Pk8lk3ticXgG5JfwyIl/3v27iW1B19KB+js7EmqSsfO3Qxb6h35dpDpEj+25oxeemXaClNwW73obQWhyR1NNOqNOadi7qI2ENwMsON4W6i9m6ySj+KGeWDiAPhbdSreojWe6slTbjyFaEhCbMAOkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737146003; c=relaxed/simple;
	bh=gqKmkNDVVX0OkQIrFs+CTparWEKqKNGHblvoMdEzpYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY+KIdsJSf+Pq2bYPHEGPS1QgQnFEfACYBUGdtn6eJMq4epSbUP2nW2bRjCAsYDIvrix0mE/mHd16Hfn0W9Q0gGrVVYThQUpxSFBOOGMTqZ4JFtGeBx+5j8VxlPWLyVTXaVymmBBnyniAcdEvrSOnY5RG7Pp73E1kTNnycVRlpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CEXwiZ+8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0TJ2bZ+2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 Jan 2025 21:33:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737145999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUnn4a6TOcC3AYdUHDTHSjARpGbkZffL9aT0zMI8qvk=;
	b=CEXwiZ+87YqwxQboXiZxrOPj6d6AB9vUMc+IRIbFAIuXeWhcjIkkccGZ6nIoueWW7gRIL/
	voH1hFcZqpU0qpT1HgJ5KB4i2QVPjKOnSkT8pvMyoceuyblormyiOb1AduPDlHHRo7UHN+
	hShbvF2mD3zRQU3zAYJGI3vlzh62W4aguVlTS6K1t/iWcM3j/4fGdMSG9iQe3YtUDJNW3C
	/9HB67cdBbhMoXdAauiX3NjCflB6x0DaQoQcWMeGVI+yEh7x0cKudMto7DkF8n+c35SQtT
	R+V4ZLdZUv4cp+md1J+S+MI0TOGpS1rH4dEgfMiU7bFwFeYmjgZz0mNP6EziYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737145999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUnn4a6TOcC3AYdUHDTHSjARpGbkZffL9aT0zMI8qvk=;
	b=0TJ2bZ+2Pq42hCHjRAlcHn9kZISOsCnqGZdxki+8oXMU3uYSKk0CqoxQsAc8bsR2gGZNLl
	b5G5pZaa/7jTQ8Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, mhocko@suse.com, willy@infradead.org,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v5 3/7] locking/local_lock: Introduce
 local_trylock_irqsave()
Message-ID: <20250117203315.FWviQT38@linutronix.de>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-4-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250115021746.34691-4-alexei.starovoitov@gmail.com>

On 2025-01-14 18:17:42 [-0800], Alexei Starovoitov wrote:
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lo=
ck_internal.h
> index 8dd71fbbb6d2..93672127c73d 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -75,37 +85,73 @@ do {								\
> =20
>  #define __local_lock(lock)					\
>  	do {							\
> +		local_lock_t *l;				\
>  		preempt_disable();				\
> -		local_lock_acquire(this_cpu_ptr(lock));		\
> +		l =3D this_cpu_ptr(lock);				\
> +		lockdep_assert(l->active =3D=3D 0);			\
> +		WRITE_ONCE(l->active, 1);			\
> +		local_lock_acquire(l);				\
>  	} while (0)

=E2=80=A6

> +#define __local_trylock_irqsave(lock, flags)			\
> +	({							\
> +		local_lock_t *l;				\
> +		local_irq_save(flags);				\
> +		l =3D this_cpu_ptr(lock);				\
> +		if (READ_ONCE(l->active) =3D=3D 1) {		\
> +			local_irq_restore(flags);		\
> +			l =3D NULL;				\
> +		} else {					\
> +			WRITE_ONCE(l->active, 1);		\
> +			local_trylock_acquire(l);		\
> +		}						\
> +		!!l;						\
> +	})
> +

Part of the selling for local_lock_t was that it does not affect
!PREEMPT_RT builds. By adding `active' you extend every data structure
and you have an extra write on every local_lock(). It was meant to
replace preempt_disable()/ local_irq_save() based locking with something
that actually does locking on PREEMPT_RT without risking my life once
people with pitchforks come talk about the new locking :)

I admire that you try to make PREEMPT_RT and !PREEMPT_RT similar in a
way that both detect recursive locking which not meant to be supported.=20

Realistically speaking as of today we don't have any recursive lock
detection other than lockdep. So it should be enough given that the bots
use it often and hopefully local testing.
Your assert in local_lock() does not work without lockdep. It will only
make local_trylock_irqsave() detect recursion and lead to two splats
with lockdep enabled in local_lock() (one from the assert and the second
=66rom lockdep).

I would say you could get rid of the `active' field and solely rely on
lockdep and the owner field. So __local_trylock_irqsave() could maybe
use local_trylock_acquire() to conditionally acquire the lock if `owner'
is NULL.

This makes it possible to have recursive code without lockdep, but with
lockdep enabled the testcase should fail if it relies on recursion.
Other than that, I don't see any advantage. Would that work?

Sebastian

