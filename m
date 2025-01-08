Return-Path: <bpf+bounces-48301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C124DA0667B
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31611677DE
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3E204F81;
	Wed,  8 Jan 2025 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBHOmXeY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5720469D;
	Wed,  8 Jan 2025 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368904; cv=none; b=Qhw5Qhy0bLLiPg0jEoMlF7TXgGvH4TzOWO8jx3xcLNoUQro+v81qU9xwIKRypvT5qiqV2+MlpWUB2WHDNQq/oNZZqG8QxJ5xQxsKpPYvuxah6xXpp0BMginhETtd/NVzfgLO5201b/XNc29okLgbRR2UJDux/vO/TboaFyL7WHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368904; c=relaxed/simple;
	bh=ZJ3eletHfAcCmxci7XtD9JswbdYmErQY1oxZVCma/QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgX90pFKBPLYPch59kTAaSsUDt2/vD8kfWMGwhly3fXSX2tP/5Ep4yd68yylmZcY5dkjTvGw5th6iI6tMIkGy5dwgo/1VnyAoSsYm1MZO9mR7Ys8ULNS0dHab6YIze2rWGq93MYXEVqxMdD+18UxX0C6py4L+prjAOOl2C7Sc40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBHOmXeY; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso258297a12.0;
        Wed, 08 Jan 2025 12:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736368901; x=1736973701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/2rzoag2Q4N/loanCjTIUZmTFnLSJCjF7Ak1Q2DjERE=;
        b=DBHOmXeYbHriOl/2nt0xxF/TyzZrLMbiTQ4ipnGV8e6ugX80HvwP5FWKGTZeaupExb
         YbIIt+E/wmNPwLPOhN3Hp6KpRH5YfiWbX1chags6h4H2Yol+WKw0wgiK3u9NevgkGkrF
         tcdDma1Icub6LgUir1p4RAidR9u+ReMvxQ/Y968xCqJd14v3OK0IVLoMZf9hQJRlxwju
         YTaO3QW7eBNZBWsKJcwd2/VjuCRlBtSxUgGgyGncudYhyjASvn5eo9pUwEC6dAQzq2Ui
         rNYQ7ZmKXp7Ej+wtl0e2Eq7qmdLJz5vCNGfcoQC4DdNZN6LB/fmh8KCRnQmyFFndbcTt
         1ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736368901; x=1736973701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2rzoag2Q4N/loanCjTIUZmTFnLSJCjF7Ak1Q2DjERE=;
        b=LfcWcV1K4z/oqLFTSyuH+dDmDbZjqoJdT7d9ZPUXzF0E/dKkVwQJ+nX8/EiBwL7Aqt
         724ARI3LiIVgyBO4OTsyxGYJF0IrOYzATxt2+tTP0CEt6/2C9/uCyZ++TDMhg10z1s4i
         N9pOSvcsibhw1sRW8iu2iVWDyMiWojKqxKc/unBvUbms8lsBA7YkjH71C1prPfoMyepy
         +D6fXBhBN6uOijxhTIYe3ASs6+Woef2I4glEe8JL9og6Y7rZh7r3SylKLlXDVgTHSPe7
         rl+AVz4aGgeIVgVMlhAvjkxVlq6oj7abZO7zwksxHgYAiMjiyAqGqLXTtnACeCGBZ0h9
         5aNg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Kfqd+VeCag+hv6z8AuNEduhxCNBAqBuSMp6cqtBNOYlUIXsx974EKt0yJLKTRWZm56Cr7U+Uzzb+MIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtH0fPdPwW7S21V/L+0jzZ3H7zniUzbLkYCvdiPVU8h84ITRzz
	Xaq5G+NX9RTP6+dx4FFrBisT606CHAk/qe7wZ8GgJoe1D4cRUJZer/vX7UGOQJeZBA7wfjR6weZ
	UquISRx5V+q1W2F2YnY6rZbZLuV4=
X-Gm-Gg: ASbGncsY3opZ/3pBAwgWUI91Q466bw3Q49RltItCQM8PyMyfnNlru1xrH8j9alTpt2E
	cE/sAXMGV5d56ASLhHf2ehOA8CW4rqlI7k8PGTFTFhF49BAAoT7k3ved34deZWx4MJwD9
X-Google-Smtp-Source: AGHT+IFRXmJQT3/+6UTHq8CPThsmSlLmsA+UztxC3ewcHLHR8CuW9qPaRBWXzAXX/0qExH4S2OebxyJD7ZkCtzyqz7k=
X-Received: by 2002:a05:6402:2711:b0:5d0:d1e0:8fb2 with SMTP id
 4fb4d7f45d1cf-5d972e0870fmr3116443a12.11.1736368900703; Wed, 08 Jan 2025
 12:41:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-15-memxor@gmail.com>
 <62c08854-04cb-4e45-a9e1-e6200cb787fd@redhat.com>
In-Reply-To: <62c08854-04cb-4e45-a9e1-e6200cb787fd@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 9 Jan 2025 02:11:04 +0530
X-Gm-Features: AbW1kvZ1m4ayu7eRHRL8pmAjLKvgWOnjolFzmFFA9oPnr8LiyfRcmz4h5_xbpHA
Message-ID: <CAP01T77QD_pYBVS4PfG3jDeXObKHZJkV2nQX+0njv11oKTEqRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 14/22] rqspinlock: Add macros for rqspinlock usage
To: Waiman Long <llong@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 22:26, Waiman Long <llong@redhat.com> wrote:
>
> On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
> > Introduce helper macros that wrap around the rqspinlock slow path and
> > provide an interface analogous to the raw_spin_lock API. Note that
> > in case of error conditions, preemption and IRQ disabling is
> > automatically unrolled before returning the error back to the caller.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   include/asm-generic/rqspinlock.h | 58 ++++++++++++++++++++++++++++++++
> >   1 file changed, 58 insertions(+)
> >
> > diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
> > index dc436ab01471..53be8426373c 100644
> > --- a/include/asm-generic/rqspinlock.h
> > +++ b/include/asm-generic/rqspinlock.h
> > @@ -12,8 +12,10 @@
> >   #include <linux/types.h>
> >   #include <vdso/time64.h>
> >   #include <linux/percpu.h>
> > +#include <asm/qspinlock.h>
> >
> >   struct qspinlock;
> > +typedef struct qspinlock rqspinlock_t;
> >
> >   extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
> >
> > @@ -82,4 +84,60 @@ static __always_inline void release_held_lock_entry(void)
> >       this_cpu_dec(rqspinlock_held_locks.cnt);
> >   }
> >
> > +/**
> > + * res_spin_lock - acquire a queued spinlock
> > + * @lock: Pointer to queued spinlock structure
> > + */
> > +static __always_inline int res_spin_lock(rqspinlock_t *lock)
> > +{
> > +     int val = 0;
> > +
> > +     if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL))) {
> > +             grab_held_lock_entry(lock);
> > +             return 0;
> > +     }
> > +     return resilient_queued_spin_lock_slowpath(lock, val, RES_DEF_TIMEOUT);
> > +}
> > +
> > +static __always_inline void res_spin_unlock(rqspinlock_t *lock)
> > +{
> > +     struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
> > +
> > +     if (unlikely(rqh->cnt > RES_NR_HELD))
> > +             goto unlock;
> > +     WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
> > +     /*
> > +      * Release barrier, ensuring ordering. See release_held_lock_entry.
> > +      */
> > +unlock:
> > +     queued_spin_unlock(lock);
> > +     this_cpu_dec(rqspinlock_held_locks.cnt);
> > +}
> > +
> > +#define raw_res_spin_lock_init(lock) ({ *(lock) = (struct qspinlock)__ARCH_SPIN_LOCK_UNLOCKED; })
> > +
> > +#define raw_res_spin_lock(lock)                    \
> > +     ({                                         \
> > +             int __ret;                         \
> > +             preempt_disable();                 \
> > +             __ret = res_spin_lock(lock);       \
> > +             if (__ret)                         \
> > +                     preempt_enable();          \
> > +             __ret;                             \
> > +     })
> > +
> > +#define raw_res_spin_unlock(lock) ({ res_spin_unlock(lock); preempt_enable(); })
> > +
> > +#define raw_res_spin_lock_irqsave(lock, flags)    \
> > +     ({                                        \
> > +             int __ret;                        \
> > +             local_irq_save(flags);            \
> > +             __ret = raw_res_spin_lock(lock);  \
> > +             if (__ret)                        \
> > +                     local_irq_restore(flags); \
> > +             __ret;                            \
> > +     })
> > +
> > +#define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
> > +
> >   #endif /* __ASM_GENERIC_RQSPINLOCK_H */
>
> Lockdep calls aren't included in the helper functions. That means all
> the *res_spin_lock*() calls will be outside the purview of lockdep. That
> also means a multi-CPU circular locking dependency involving a mixture
> of qspinlocks and rqspinlocks may not be detectable.

Yes, this is true, but I am not sure whether lockdep fits well in this
case, or how to map its semantics.
Some BPF users (e.g. in patch 17) expect and rely on rqspinlock to
return errors on AA deadlocks, as nesting is possible, so we'll get
false alarms with it. Lockdep also needs to treat rqspinlock as a
trylock, since it's essentially fallible, and IIUC it skips diagnosing
in those cases.
Most of the users use rqspinlock because it is expected a deadlock may
be constructed at runtime (either due to BPF programs or by attaching
programs to the kernel), so lockdep splats will not be helpful on
debug kernels.

Say if a mix of both qspinlock and rqspinlock were involved in an ABBA
situation, as long as rqspinlock is being acquired on one of the
threads, it will still timeout even if check_deadlock fails to
establish presence of a deadlock. This will mean the qspinlock call on
the other side will make progress as long as the kernel unwinds locks
correctly on failures (by handling rqspinlock errors and releasing
held locks on the way out).

>
> Cheers,
> Longman
>

