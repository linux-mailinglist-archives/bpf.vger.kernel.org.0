Return-Path: <bpf+bounces-58032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5CDAB3ECD
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 19:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025FE460FA9
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB4D296D09;
	Mon, 12 May 2025 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq8ADZNL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7D295DAB
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070206; cv=none; b=C6GFSkPl0K7oCF3XF2R3qmWIO0pk6kumPmyxeU+5xbYsDZ4hQSlNuO8/ZyeJZhfysUToomoPkqcB6kKtAPwbd2Zww/uMypLqRI4prWvF8bJbvKvJp0l4GqR9H0VpQaC7UeXDtFqYUCfC+CklQzlOV0D8AWw4nJdvyAUB4QF92gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070206; c=relaxed/simple;
	bh=Xf+NB0D6ZgafnFHDPpdRqKgYnE4OKbB3w8djOwHyYjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mkf3jebpBboxK8JFufGYy8I+8uy8xc9gK8Nj3NowgMIu3Pu94NueNVQyQ6zcY6R2Qv8E8S7IzlK0YpZGn/acKrxYZJ5Z3fn9XJijEWGdln9DeGg2hMOZLls3S6DJrXBOGpt3yBVua+SXl72VB2//Nm0jhRO4w3sAGwwcNufvM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq8ADZNL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a0b9303998so2409360f8f.0
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747070202; x=1747675002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9Ugkb47FGB9bw6za0PrdUHlAQDy5Ir+PZ8NxZxiXL4=;
        b=mq8ADZNLQrXZpB5SyD9h+rPvMeaUNQrjrvhQVzGzVG/s3zt3RHhHf5rmsbZEJ8ch50
         2kU0xjmlHPB+0TD2lfHMBls8m3eq/kYD3MJsevZAuXVxAms4+y9NYgdIAFQ6A379K/io
         yxAw/JMZapuu10JAAGC9MSG63ku4boqCOffKO5Lpcq6qz44XZuwxoDDPKIq8oVTQqmBj
         bQeeQCDWntZrqtW3zgHPGzOaEbuFYz0c3Z/sf4oDorCEPZ87YtMfYYRmfeIEPqjmbQQJ
         DfRk9XPjdJ6L03PNJwDHqVgowEnMNxcYRPl0xXyiZqKoWLiChvUpjpQEWXZI0dSm6VPO
         tGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747070202; x=1747675002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9Ugkb47FGB9bw6za0PrdUHlAQDy5Ir+PZ8NxZxiXL4=;
        b=o26Az4l8r+c22GrzqxX8K6zNfTpG4TwT9SLk9VvH/rsXH8HVfdMW+N0kVEIrgTl6Hd
         6rdSCz+b/51L1rrgwEx0iSzT0lLGQGCmLPspy9yXNROGSFlFhjDzbjVxCjU/1+4sd1NZ
         X1GG0bmTelkvqrJ2zCQd6WoFFLRxJTFK+z8Z6Wgo+a63dw25kybnx5AAFBBLvv1YI+fs
         ksswmhuZQTiTsPf2ANzX97D/shB44XoougKVHDwLyeuWT4v5a40hzm7t1wmkSw/Jx5lL
         gsaErEATEC0/60dFLAoC8InoVMU7u9iPBrmiWPcBrHUANiutKU28NFGS2xGzAk/hshuP
         CNZw==
X-Gm-Message-State: AOJu0Yz6GkC8GdBgq77em8VsgIpv6kiG0ihq4iKYzn8i3XnSkcmAUa8J
	Cz7EjmIFviWPCwO78NNfSId+73FDCqJ3ywmHemONL3c08Cnj68hSfCCmocT4tOIbZu1qxM93cJk
	e+JfwzykHFjpEPI3xezVD4oiy4iU=
X-Gm-Gg: ASbGncujFpD55W2pqjSy5CxW3HRbWtcDpj2NgT7AfAcmVsTT8rPlZ4qb9WSHbAgo0bY
	ZrgQ0Gw22n4Kw02ErNX1Q0ebHdA3pBaWRngdL+N+GwaxXVAoksClnh27vhNAuaLg2If3r/m9OGr
	r90l8MKDmTtRGHdrKGA50w4NxlU0YX1WjGxNrjRrWDGf5N5ZXtSfVkcum924E=
X-Google-Smtp-Source: AGHT+IEFO81VYZtZULAu4VLScRjm7TCA581BtFO8mErq1xKitjODBjz5vRMDv2OewxxhQ263vCRx1tOAMJZGhpX5Yy0=
X-Received: by 2002:a05:6000:420a:b0:39f:c05:c220 with SMTP id
 ffacd0b85a97d-3a340d2d334mr236282f8f.22.1747070202244; Mon, 12 May 2025
 10:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-5-alexei.starovoitov@gmail.com> <20250512140359.CDEasCj3@linutronix.de>
In-Reply-To: <20250512140359.CDEasCj3@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 10:16:30 -0700
X-Gm-Features: AX0GCFsvjB7lchg81Xd9PQcdE0jHyptHMqB4ExvIEn_FR6Cg1YPKRo3RlQ9kpSg
Message-ID: <CAADnVQLs009ZgcwHfo77zHA_NiGqsBpwvdG1kqc0cW6b02tXXw@mail.gmail.com>
Subject: Re: [PATCH 4/6] locking/local_lock: Introduce local_lock_irqsave_check()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 7:04=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-04-30 20:27:16 [-0700], Alexei Starovoitov wrote:
> > --- a/include/linux/local_lock_internal.h
> > +++ b/include/linux/local_lock_internal.h
> > @@ -168,6 +168,15 @@ do {                                              =
               \
> >  /* preemption or migration must be disabled before calling __local_loc=
k_is_locked */
> >  #define __local_lock_is_locked(lock) READ_ONCE(this_cpu_ptr(lock)->acq=
uired)
> >
> > +#define __local_lock_irqsave_check(lock, flags)                       =
               \
> > +     do {                                                             =
       \
> > +             if (IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&               =
       \
> > +                 (!__local_lock_is_locked(lock) || in_nmi()))         =
       \
> > +                     WARN_ON_ONCE(!__local_trylock_irqsave(lock, flags=
));    \
> > +             else                                                     =
       \
> > +                     __local_lock_irqsave(lock, flags);               =
       \
> > +     } while (0)
> > +
>
> Hmm. If I see this right in SLUB then this is called from preemptible
> context. Therefore the this_cpu_ptr() from __local_lock_is_locked()
> should trigger a warning here.

When preemptible the migration is disabled. So no warning.

> This check variant provides only additional debugging and otherwise
> behaves as local_lock_irqsave(). Therefore the in_nmi() should return
> immediately with a WARN_ON() regardless if the lock is available or not
> because the non-try variant should never be invoked from an NMI.

non-try variant can be invoked from NMI, because the earlier
__local_lock_is_locked() check tells us that the lock is not locked.
And it's safe to do.
And that's the main challenge here.
local_lock_irqsave_check() macro fights lockdep here.

> This looks like additional debug infrastructure that should be part of
> local_lock_irqsave() itself,

The pattern of

if (!__local_lock_is_locked(lock)) {
   .. lots of code..
   local_lock_irqsave(lock);

is foreign to lockdep.

Since it can be called from NMI the lockdep just hates it:

[ 1021.956825] inconsistent {INITIAL USE} -> {IN-NMI} usage.
...
[ 1021.956888]   lock(per_cpu_ptr(&lock));
[ 1021.956890]   <Interrupt>
[ 1021.956891]     lock(per_cpu_ptr(&lock));
..

and technically lockdep is correct.
For any normal lock it's a deadlock waiting to happen,
but not here.

Even without NMI the lockdep doesn't like it:
[   14.627331] page_alloc_kthr/1965 is trying to acquire lock:
[   14.627331] ffff8881f6ebe0f0 ((local_lock_t
*)&c->lock){-.-.}-{3:3}, at: ___slab_alloc+0x9a9/0x1ab0
[   14.627331]
[   14.627331] but task is already holding lock:
[   14.627331] ffff8881f6ebd490 ((local_lock_t
*)&c->lock){-.-.}-{3:3}, at: ___slab_alloc+0xc7/0x1ab0
[   14.627331]
[   14.627331] other info that might help us debug this:
[   14.627331]  Possible unsafe locking scenario:
[   14.627331]
[   14.627331]        CPU0
[   14.627331]        ----
[   14.627331]   lock((local_lock_t *)&c->lock);
[   14.627331]   lock((local_lock_t *)&c->lock);

When slub is holding lock ...bd490 we detect it with
__local_lock_is_locked(),
then we check that lock ..be0f0 is not locked,
and proceed to acquire it, but
lockdep will show the above splat.

So local_lock_irqsave_check() is a workaround to avoid
these two false positives from lockdep.

Yours and Vlastimil's observation is correct, that ideally
local_lock_irqsave() should just handle it,
but I don't see how to do it.
How can lockdep understand the if (!locked()) lock() pattern ?
Such usage is correct only for per-cpu local lock when migration
is disabled from check to acquire.

Hence the macro is doing:
if (IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&
   (!__local_lock_is_locked(lock) || in_nmi()))
         WARN_ON_ONCE(!__local_trylock_irqsave(lock, flags));

in_nmi() part is a workaround for the first lockdep splat
and __local_lock_is_locked() is a workaround for 2nd lockdep splat,
though the code did __local_lock_is_locked() check already.

In your other email you wonder whether
rt_mutex_base_is_locked() should be enough.
It's not.
We need to check:
__local_lock_is_locked(__lock) \
rt_mutex_owner(&this_cpu_ptr(__lock)->lock) =3D=3D current

Because the following sequence is normal in PREEMP_RT:
kmalloc
  local_lock_irqsave(lock_A)
     preemption
        kmalloc_nolock
           if (is_locked(lock_A) =3D=3D true)
               retry:  is_locked(lock_B) =3D=3D false
                         local_lock_irqsave_check(lock_B)

while lock_B could be locked on another CPU by a different task.
So we cannot trylock(lock_B) here.
Hence in PREEMPT_RT
__local_lock_irqsave_check() is doing:
WARN_ON_ONCE(__local_lock_is_locked(lock));
spin_lock(this_cpu_ptr((lock)));

