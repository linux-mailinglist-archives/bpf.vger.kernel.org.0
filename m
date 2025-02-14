Return-Path: <bpf+bounces-51584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCDAA365C1
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7237A3D37
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5C918952C;
	Fri, 14 Feb 2025 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtOeKKZd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C212CD88
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557963; cv=none; b=cCOzRzBS75p6CILSX+hFItsziLNYIzvlwDxDnkT/pme9ztu42R4UcWWRhtv1NcDHfy8x8wK9uhQPqwIimH8jk8LrnN7+BMJhTuBGMEmLM70sBVwqWIanJbehZjKp3NLRGS9gcu+947VeV8Hvk1IzPR+lzcLcHg8OuZciZN0aq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557963; c=relaxed/simple;
	bh=eX2CVl3fUq3WRMMGqOFdMI1yyztGU0tsFj3VBDcW7N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neejgplwD4K+FPkjqXA+b8OYLH2K73DjFdsUG58aNf4ykldpi23Uw7hCLfjg+aF1TogKRHvcxMcwTicQu3EDEfEM5aE0BauicN117KPVON9LVmdSw1UYxnVMURPyRi58hcJLI7uS23izvuYt2MMTdEcpAYzE8ulBKwETpodunJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtOeKKZd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43956fcd608so15148045e9.3
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 10:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739557960; x=1740162760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpZ8JqCVaUpY1jftjFnQv28Czby8LZCGYhxlTXN4kDE=;
        b=NtOeKKZdGM7MwgE3dxpkAiz76CA6mhsmAiE2FjNm4jGt+wOxGKewMaFvzKjuawX1i7
         Ut8pzHl0eyLe5fk/V5nmC5r5/32IQt5bhPWCaoImgqt8dlwc2/1kRj3FJgxaYMcW6tAn
         BTjCDncXmTQW7l4IDSpW/t14NjMC1nRWTL9d3BaNCL9bcBfzGrqTmTNhBDRbze9Tl3VK
         1g7ag3H3pXOqvB7IRxCwdu6WyrQ7Wr1Cij36Wep096LHF37aVBjIfxifaAIGJbwMharz
         dMUTGMh6OIXidia1RtfFRh8a8YaCEXldloVZKWtxS3PTeKu05XJjpD1vblND4/LqgxTl
         i43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739557960; x=1740162760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpZ8JqCVaUpY1jftjFnQv28Czby8LZCGYhxlTXN4kDE=;
        b=mQEw6EmpKKJT0Fy13d+8gX7HBkdVXlYcool41Bw/ICbQxccVyylN2CNIuTmyKmVHA1
         ipWlgEO9Cl3Grp81/W9aNmZfN/1VyvttPbDQXvEcD73PKJfkfmyle3WPpPzgs2O/3ff2
         ADvj03GSEwabJUgudLRaV5yWl+jQ12Xsy/hMSq+HKUH3/AIk68KsRielyZP72clqkBsi
         bGKDvM8Iyde4u/WB9j5C570ZMnebHzSBcQTk8lemYe2G2W/vWn+j2hxGY6dE1Z/cM0Jq
         k1TkFaFrLXKsfrTcQym+/aL2a9+p+f9we/4NGeVpyIt2nopm6EXY8th/U5ScwXWe6rJp
         7Dow==
X-Gm-Message-State: AOJu0YwyniPrlPR/5U3H/uqNwuGqiJ5+MmdNmEV/nWiKN24qBNJLTI31
	xrtotFbN7r+2+8epGr+escHZ0vKoFLkui34QwnyTNyXquvBtoZXo3pH8o/1IdD2j125yJ2sbaG2
	FaqVzTgpJS5j5FygoHhNKB9+UFnE=
X-Gm-Gg: ASbGnct/7n0g8Qy7s7XaiRoQdrBu0mAHElu5LdlcYfqaiY8gbGMwbQFb7AtQclNNkkp
	8MtHHgoXa7CcdGndtiMiMY+0qHQ4hOebhRCrv2LF2g0IlQZLzbFYmHVIkNaw21p3Qig/O2X8O7o
	yxl24yd9aqDUoAH7Xg7hBwE2oQQV7e
X-Google-Smtp-Source: AGHT+IFGSulxP+ugw9v6TrfjkXjxqBsRlMpwY9qFnLx8vj9C6w8q1nPy4Nemg3EGo81az9+s3VKOIY8yqkzIRDduidM=
X-Received: by 2002:a5d:6d0c:0:b0:38d:d613:9b91 with SMTP id
 ffacd0b85a97d-38f33f68441mr29914f8f.51.1739557959753; Fri, 14 Feb 2025
 10:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
 <20250213033556.9534-4-alexei.starovoitov@gmail.com> <efc30cf9-8351-4889-8245-cc4a6893ebf4@suse.cz>
In-Reply-To: <efc30cf9-8351-4889-8245-cc4a6893ebf4@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Feb 2025 10:32:28 -0800
X-Gm-Features: AWEUYZluxyTyvAmzzHjcuxvZU_sp1z5SUjfbWsaYlyStddj5n9HS94Bpf_X82K8
Message-ID: <CAADnVQKaTg1zxCbX9Kum4ZmcvLkxQJOyDLV8zdUcQWUyOb4Q4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/6] locking/local_lock: Introduce localtry_lock_t
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 4:11=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/13/25 04:35, Alexei Starovoitov wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >
> > In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
> > critical section, but it doesn't prevent NMI, so the fully reentrant
> > code cannot use local_lock_irqsave() for exclusive access.
> >
> > Introduce localtry_lock_t and localtry_lock_irqsave() that
> > disables interrupts and sets acquired=3D1, so localtry_lock_irqsave()
> > from NMI attempting to acquire the same lock will return false.
> >
> > In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
> > Map localtry_lock_irqsave() to preemptible spin_trylock().
> > When in hard IRQ or NMI return false right away, since
> > spin_trylock() is not safe due to PI issues.
> >
> > Note there is no need to use local_inc for acquired variable,
> > since it's a percpu variable with strict nesting scopes.
> >
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> ...
>
> >
> > +/* localtry_lock_t variants */
> > +
> > +#define __localtry_lock_init(lock)                           \
> > +do {                                                         \
> > +     __local_lock_init(&(lock)->llock);                      \
> > +     WRITE_ONCE(&(lock)->acquired, 0);                       \
>
> This needs to be WRITE_ONCE((lock)->acquired, 0);

Thanks. Good catch.

> I'm adopting this implementation for my next slab sheaves RFC. But I'll w=
ant
> localtry_trylock() without _irqsave too, so I've added it locally. Postin=
g
> below with the init fix and making the PREEMPT_RT comment clear. Feel fre=
e
> to fold everything, it would make it easier for me. Or just the fixes, if
> you don't want code you don't use yourself.

+1

> ----8<----
> From c4f47afa3d06367d8d54662d6c3a76d3ab6e349d Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 13 Feb 2025 19:38:31 +0100
> Subject: [PATCH] locking/local_lock: add localtry_trylock()
>
> Add a localtry_trylock() variant without _irqsave that will be used in
> slab sheaves implementation. Thanks to only disabling preemption and not
> irqs, it has a lower overhead. It's not necessary to disable irqs to
> avoid a deadlock if the irq context uses trylock and can handle
> failures.
>
> Also make the comment of localtry_trylock_irqsave() more clear, and fix a
> compilation failure in localtry_lock_init().
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/local_lock.h          | 13 +++++++++++-
>  include/linux/local_lock_internal.h | 31 +++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index 05c254a5d7d3..1a0bc35839e3 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -77,6 +77,16 @@
>  #define localtry_lock_irqsave(lock, flags)                             \
>         __localtry_lock_irqsave(lock, flags)
>
> +/**
> + * localtry_trylock - Try to acquire a per CPU local lock.
> + * @lock:      The lock variable
> + *
> + * The function can be used in any context such as NMI or HARDIRQ. Due t=
o
> + * locking constrains it will _always_ fail to acquire the lock in NMI o=
r
> + * HARDIRQ context on PREEMPT_RT.
> + */
> +#define localtry_trylock(lock)         __localtry_trylock(lock)
> +
>  /**
>   * localtry_trylock_irqsave - Try to acquire a per CPU local lock, save =
and disable
>   *                           interrupts if acquired
> @@ -84,7 +94,8 @@
>   * @flags:     Storage for interrupt flags
>   *
>   * The function can be used in any context such as NMI or HARDIRQ. Due t=
o
> - * locking constrains it will _always_ fail to acquire the lock on PREEM=
PT_RT.
> + * locking constrains it will _always_ fail to acquire the lock in NMI o=
r
> + * HARDIRQ context on PREEMPT_RT.

+1 as well.

>   */
>  #define localtry_trylock_irqsave(lock, flags)                          \
>         __localtry_trylock_irqsave(lock, flags)
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lo=
ck_internal.h
> index c1369b300777..67bd13d142fa 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -137,7 +137,7 @@ do {                                                 =
               \
>  #define __localtry_lock_init(lock)                             \
>  do {                                                           \
>         __local_lock_init(&(lock)->llock);                      \
> -       WRITE_ONCE(&(lock)->acquired, 0);                       \
> +       WRITE_ONCE((lock)->acquired, 0);                        \
>  } while (0)
>
>  #define __localtry_lock(lock)                                  \
> @@ -167,6 +167,24 @@ do {                                                =
               \
>                 WRITE_ONCE(lt->acquired, 1);                    \
>         } while (0)
>
> +#define __localtry_trylock(lock)                               \
> +       ({                                                      \
> +               localtry_lock_t *lt;                            \
> +               bool _ret;                                      \
> +                                                               \
> +               preempt_disable();                              \
> +               lt =3D this_cpu_ptr(lock);                        \
> +               if (!READ_ONCE(lt->acquired)) {                 \
> +                       WRITE_ONCE(lt->acquired, 1);            \
> +                       local_trylock_acquire(&lt->llock);      \
> +                       _ret =3D true;                            \
> +               } else {                                        \
> +                       _ret =3D false;                           \
> +                       preempt_enable();                       \
> +               }                                               \
> +               _ret;                                           \
> +       })
> +
>  #define __localtry_trylock_irqsave(lock, flags)                        \
>         ({                                                      \
>                 localtry_lock_t *lt;                            \
> @@ -275,12 +293,10 @@ do {                                               =
               \
>  #define __localtry_unlock_irq(lock)                    __local_unlock(lo=
ck)
>  #define __localtry_unlock_irqrestore(lock, flags)      __local_unlock_ir=
qrestore(lock, flags)
>
> -#define __localtry_trylock_irqsave(lock, flags)                        \
> +#define __localtry_trylock(lock)                               \
>         ({                                                      \
>                 int __locked;                                   \
>                                                                 \
> -               typecheck(unsigned long, flags);                \
> -               flags =3D 0;                                      \
>                 if (in_nmi() | in_hardirq()) {                  \
>                         __locked =3D 0;                           \
>                 } else {                                        \
> @@ -292,4 +308,11 @@ do {                                                =
               \
>                 __locked;                                       \
>         })
>
> +#define __localtry_trylock_irqsave(lock, flags)                        \
> +       ({                                                      \
> +               typecheck(unsigned long, flags);                \
> +               flags =3D 0;                                      \
> +               __localtry_trylock(lock);                       \
> +       })
> +

All makes sense to me.

Since respin is needed, I can fold the above fix/feature and
push it into a branch with stable sha-s that we both can
use as a base ?

Or you can push just this one patch into a stable branch and I can pull it
and apply the rest on top.

