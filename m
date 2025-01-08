Return-Path: <bpf+bounces-48297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24471A065F4
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226977A16CD
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EE2202C55;
	Wed,  8 Jan 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyXFwWv7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9202010F6;
	Wed,  8 Jan 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367636; cv=none; b=R5Pebjk1C8iDAftoLCW2TU1AMnlFgPK3kv9SbPKghm/KIBW/Gl5tcoS1y2he8HwB5o/YCm8dXwKagEOOrpApV4Tcxv6nhjTgvSJpT6RfBG87OIUl8/Qk5fUBD/xyA4441gL5k7o6vCVZcQQQb1S4qHp31lBF3tPNJ5ObtE5ROYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367636; c=relaxed/simple;
	bh=LoWQASbMQG4BrTCodfixhnsIYEaW6G+SrXUuEjR9Qfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofLqxPCOVDVcAvVxuwnEMU6cuBCtPWdBT/KRCteTuRReZkY40wV3sg1crECzhcQYRXB0umWvuBRbyRuUl6T5vGeI9mAF27Agd4Gjkntmqm6owtzoiGxXdAlfWJOX42Ni3EspJIz7Vqjwpy0x59E58QILSGjScZNh9elQLjJ6rgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyXFwWv7; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso200777a12.0;
        Wed, 08 Jan 2025 12:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736367632; x=1736972432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LvPv1CADs+WA8sDcr9hqssOluirA/qoXdYshw0Gxsbo=;
        b=GyXFwWv7jFaGuSyocPx7UUxc43IGIgOeWsRy7leRW7b9cIKy51aHhvY15i2Raoo9XV
         t+0xwUjVzsQ73N0G7MSt8m+dYCEn84S0o7xzHHTUdifNLEtUgwCfFA8SJqbTHxerfMkY
         8KWmj07kQVYviQLtO7cr0aBBPwg5ZHagj+qrYtZVYbz3duJ8nLdmVt0qnkq9qpmaNyuL
         9B+a1vcHQnXrRxLYRoDhOctH6pdul8Np8tQsx94OnE/ctQTm38Litd4A/gTO2RMM4Pec
         2h1lj+0GhwUDMRwygeXWVeKBHCbKdPjx7jEPhdWQK1lUXe2Wbf4v1nt4lPuXo3AUqfqY
         DxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736367632; x=1736972432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvPv1CADs+WA8sDcr9hqssOluirA/qoXdYshw0Gxsbo=;
        b=kvrf4DjLQ2NPeEiNoeadvLBbMfX5fiDpdLAoJy7eBIMNpHZ07C2uTzEyhzbLi5016z
         g4YkA3D3bwKYUMHNVnPjrkICJgVKQpoGL8s4DDpnVHlndz22ezVxGxc234jTPUDp1GxJ
         u7JNreuOayPaDjkNG8RYKsHTE64KQ//BTkx0uqFM0coy6SpOMBWpmyGtTLYILknPdn4O
         8ZLVHLNVeBE21Et+s14BmoH7FoGSrYgODsrc+OUoVudpsMAIll1BSFZN+q/CUkANH/UM
         eh4LcKVu/TTQ7J/Z/eRgWvwBDrQEN8h2H7QwPx5lXNEfdgfbA6A2jVWHa/b0GuQu++E5
         PTBg==
X-Forwarded-Encrypted: i=1; AJvYcCVVIkbjbpchEh7wOSAfzLRLTpLtLu5Xj9sUhdwifnB4QUnWu/CNytIq1N/luJDIyu5A9N0V7XP0H+Rg/do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxdBYYom/dHu2hrIjfFyXxJtFSpfzGuriy788dIKeuHRHKxTq8
	HNb+zNCU3CowMHDuKaG7EoPlGAl+MF+K7vfFKshf48WqjULDJPU/GZsZi8uTrAg3mEdUz0BKxCg
	b6sKjcm9rbvWu+kEWdVBu69ayr95eeqzpYjc=
X-Gm-Gg: ASbGnct7m4oxX5lwyk2GmqRu+lYKfZ2IMHq7vKXohS7j8BDjZRlXMQK0xoPRA8Y48fC
	/UPVyH2gKxjtNlOUvEFDuG8O7u+bxvVaJam7N4pyIPdlIql4d1r3ZkRM2XxCxf2+eV1ff
X-Google-Smtp-Source: AGHT+IFZbGnpm4zdTThNCggA0L0SDyOr4lozumP8221krnBZPNvnLilM1OaX434dAdRcMasImoXmEPPlV7ghwmS6slE=
X-Received: by 2002:a05:6402:3202:b0:5d3:ce7f:abee with SMTP id
 4fb4d7f45d1cf-5d972e4ca2amr3948990a12.25.1736367632397; Wed, 08 Jan 2025
 12:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-12-memxor@gmail.com>
 <2402fa3e-bd43-47a5-ab8c-bd05877831ff@redhat.com>
In-Reply-To: <2402fa3e-bd43-47a5-ab8c-bd05877831ff@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 9 Jan 2025 01:49:54 +0530
X-Gm-Features: AbW1kvYJm8VPRtPfqI85uRQOdAAOpf5kcLGgdV3NcDGr71mwgPJippiWXEJK_kQ
Message-ID: <CAP01T77FDwOs8wP2UvUNHC=oRE-ivUA5Ay04o0rnSc-M1NLmHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 11/22] rqspinlock: Add deadlock detection and recovery
To: Waiman Long <llong@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 21:36, Waiman Long <llong@redhat.com> wrote:
>
>
> On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
> > While the timeout logic provides guarantees for the waiter's forward
> > progress, the time until a stalling waiter unblocks can still be long.
> > The default timeout of 1/2 sec can be excessively long for some use
> > cases.  Additionally, custom timeouts may exacerbate recovery time.
> >
> > Introduce logic to detect common cases of deadlocks and perform quicker
> > recovery. This is done by dividing the time from entry into the locking
> > slow path until the timeout into intervals of 1 ms. Then, after each
> > interval elapses, deadlock detection is performed, while also polling
> > the lock word to ensure we can quickly break out of the detection logic
> > and proceed with lock acquisition.
> >
> > A 'held_locks' table is maintained per-CPU where the entry at the bottom
> > denotes a lock being waited for or already taken. Entries coming before
> > it denote locks that are already held. The current CPU's table can thus
> > be looked at to detect AA deadlocks. The tables from other CPUs can be
> > looked at to discover ABBA situations. Finally, when a matching entry
> > for the lock being taken on the current CPU is found on some other CPU,
> > a deadlock situation is detected. This function can take a long time,
> > therefore the lock word is constantly polled in each loop iteration to
> > ensure we can preempt detection and proceed with lock acquisition, using
> > the is_lock_released check.
> >
> > We set 'spin' member of rqspinlock_timeout struct to 0 to trigger
> > deadlock checks immediately to perform faster recovery.
> >
> > Note: Extending lock word size by 4 bytes to record owner CPU can allow
> > faster detection for ABBA. It is typically the owner which participates
> > in a ABBA situation. However, to keep compatibility with existing lock
> > words in the kernel (struct qspinlock), and given deadlocks are a rare
> > event triggered by bugs, we choose to favor compatibility over faster
> > detection.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   include/asm-generic/rqspinlock.h |  56 +++++++++-
> >   kernel/locking/rqspinlock.c      | 178 ++++++++++++++++++++++++++++---
> >   2 files changed, 220 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
> > index 5c996a82e75f..c7e33ccc57a6 100644
> > --- a/include/asm-generic/rqspinlock.h
> > +++ b/include/asm-generic/rqspinlock.h
> > @@ -11,14 +11,68 @@
> >
> >   #include <linux/types.h>
> >   #include <vdso/time64.h>
> > +#include <linux/percpu.h>
> >
> >   struct qspinlock;
> >
> > +extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
> > +
> >   /*
> >    * Default timeout for waiting loops is 0.5 seconds
> >    */
> >   #define RES_DEF_TIMEOUT (NSEC_PER_SEC / 2)
> >
> > -extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
> > +#define RES_NR_HELD 32
> > +
> > +struct rqspinlock_held {
> > +     int cnt;
> > +     void *locks[RES_NR_HELD];
> > +};
> > +
> > +DECLARE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
> > +
> > +static __always_inline void grab_held_lock_entry(void *lock)
> > +{
> > +     int cnt = this_cpu_inc_return(rqspinlock_held_locks.cnt);
> > +
> > +     if (unlikely(cnt > RES_NR_HELD)) {
> > +             /* Still keep the inc so we decrement later. */
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * Implied compiler barrier in per-CPU operations; otherwise we can have
> > +      * the compiler reorder inc with write to table, allowing interrupts to
> > +      * overwrite and erase our write to the table (as on interrupt exit it
> > +      * will be reset to NULL).
> > +      */
> > +     this_cpu_write(rqspinlock_held_locks.locks[cnt - 1], lock);
> > +}
> > +
> > +/*
> > + * It is possible to run into misdetection scenarios of AA deadlocks on the same
> > + * CPU, and missed ABBA deadlocks on remote CPUs when this function pops entries
> > + * out of order (due to lock A, lock B, unlock A, unlock B) pattern. The correct
> > + * logic to preserve right entries in the table would be to walk the array of
> > + * held locks and swap and clear out-of-order entries, but that's too
> > + * complicated and we don't have a compelling use case for out of order unlocking.
> Maybe we can pass in the lock and print a warning if out-of-order unlock
> is being done.

I think alternatively, I will constrain the verifier in v2 to require
lock release to be in-order, which would obviate the need to warn at
runtime and reject programs potentially doing out-of-order unlocks.
This doesn't cover in-kernel users though, but we're not doing
out-of-order unlocks with this lock there, and it would be yet another
branch in the unlock function with little benefit.

> > + *
> > + * Therefore, we simply don't support such cases and keep the logic simple here.
> > + */
> > +static __always_inline void release_held_lock_entry(void)
> > +{
> > +     struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
> > +
> > +     if (unlikely(rqh->cnt > RES_NR_HELD))
> > +             goto dec;
> > +     smp_store_release(&rqh->locks[rqh->cnt - 1], NULL);
> > +     /*
> > +      * Overwrite of NULL should appear before our decrement of the count to
> > +      * other CPUs, otherwise we have the issue of a stale non-NULL entry being
> > +      * visible in the array, leading to misdetection during deadlock detection.
> > +      */
> > +dec:
> > +     this_cpu_dec(rqspinlock_held_locks.cnt);
> AFAIU, smp_store_release() only guarantees memory ordering before it,
> not after. That shouldn't be a problem if the decrement is observed
> before clearing the entry as that non-NULL entry won't be checked anyway.

Ack, I will improve the comment, it's a bit misleading right now.

> > +}
> >
> >   #endif /* __ASM_GENERIC_RQSPINLOCK_H */
> > diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
> > index b63f92bd43b1..b7c86127d288 100644
> > --- a/kernel/locking/rqspinlock.c
> > +++ b/kernel/locking/rqspinlock.c
> > @@ -30,6 +30,7 @@
> >    * Include queued spinlock definitions and statistics code
> >    */
> >   #include "qspinlock.h"
> > +#include "rqspinlock.h"
> >   #include "qspinlock_stat.h"
> >
> >   /*
> > @@ -74,16 +75,141 @@
> >   struct rqspinlock_timeout {
> >       u64 timeout_end;
> >       u64 duration;
> > +     u64 cur;
> >       u16 spin;
> >   };
> >
> >   #define RES_TIMEOUT_VAL     2
> >
> > -static noinline int check_timeout(struct rqspinlock_timeout *ts)
> > +DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
> > +
> > +static bool is_lock_released(struct qspinlock *lock, u32 mask, struct rqspinlock_timeout *ts)
> > +{
> > +     if (!(atomic_read_acquire(&lock->val) & (mask)))
> > +             return true;
> > +     return false;
> > +}
> > +
> > +static noinline int check_deadlock_AA(struct qspinlock *lock, u32 mask,
> > +                                   struct rqspinlock_timeout *ts)
> > +{
> > +     struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
> > +     int cnt = min(RES_NR_HELD, rqh->cnt);
> > +
> > +     /*
> > +      * Return an error if we hold the lock we are attempting to acquire.
> > +      * We'll iterate over max 32 locks; no need to do is_lock_released.
> > +      */
> > +     for (int i = 0; i < cnt - 1; i++) {
> > +             if (rqh->locks[i] == lock)
> > +                     return -EDEADLK;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static noinline int check_deadlock_ABBA(struct qspinlock *lock, u32 mask,
> > +                                     struct rqspinlock_timeout *ts)
> > +{
>
> I think you should note that the ABBA check here is not exhaustive. It
> is just the most common case and there are corner cases that will be missed.

Ack, will add a comment.

>
> Cheers,
> Longman
>

