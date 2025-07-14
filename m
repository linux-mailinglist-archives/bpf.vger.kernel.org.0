Return-Path: <bpf+bounces-63222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9240DB046E7
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 19:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B676E1A66D29
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C87265CB0;
	Mon, 14 Jul 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQIdkBYT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7A1F5433
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515549; cv=none; b=oGQrbNuYTLlZDY3hxPcQY9rG4yUwv4Vr1SLM7I+N7LBtcIpl9K8TmDdkQbfrUwmvhHrJ6FOyosa/ZUBkpeSiInII3pLZ+vSpLfZWpUd14+KxdnUQhUHPCNK9HZMriw7OHSv2gxTh+XJl8RZKMeMUJOQBYkOqDyFlsq7UZDX6xn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515549; c=relaxed/simple;
	bh=9J+acBa2hfwJUEqQA4ChSvh2W0jCKQS9G4+eJBp0ez0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mP/LEw0xZ81HqV+FlEl86VwMklBMKUzKhq9zzvWjQF4SIrofQacj7j1vL52TGgMVafjmgbbxDflnCRKVlp7JmRAGFdXtMLXITENoIt7M6BmCfW6rerZVb4Q79h2a8Zee9Dikwr/DRHG/PE3IEB7J3iSR5fonht84ql2iNQo9JBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQIdkBYT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so13311435e9.2
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752515546; x=1753120346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrXOR3em4+gjn8PtaxMxqX8DlqyBrsVytx3gz0g+Udg=;
        b=SQIdkBYT2ZTpfAKaFJWN5Hm/iZsCSvFvi2JX7IeOuKA+cTz2Lhmdr5SxhVOd4xB09/
         Vu9IwxSpKC4HzOeK8IEQlBhsJkSw7vA+Cljjh+eBBaGxYIGv2BUUgl9QKMnDqWpDFUjM
         nHxmbN657v9LHuOFyQdsWcfcbkm9BMs/oKQGAhh1kXzbg4T++9wU2DkhlwfXclFQ/mwc
         uwzm2j8FUoXGLTjqPAam9pGXBpAWB/wFEW3mQXwOlzpggU834S9mcgtz02vAurEy7TIj
         0h1/jAm5KW4hyYvUPy8QTtCzF382z8FS0+B6hr3N6cFVF6P8NS961fDF/yiUMD1yqJkt
         HH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752515546; x=1753120346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrXOR3em4+gjn8PtaxMxqX8DlqyBrsVytx3gz0g+Udg=;
        b=auKJioXAJ/lpeH6tzXVbdp43x/0+xD/6zGW8KkFxiNdpvB7O4DYgbAWC7fFNwIAIMh
         SKxvr1FL/xc7AlcoxPjwBuZqktoCJ8ZBtxkKJe7XJZIRgTe3a228XInI0JXHo3Mqf/4v
         tLGDii685hVuBKqIp9qMuOREvprHAahh+LTZdRuC+uuDb1MavoPvE087TzFHeRDGK1qS
         uAtcVEWNqybgxMmxGKEeNuTYqhmAET1TflNW1N0rraPPnGMlPjAwMtcVG0vKaXgL3etM
         M412ZRZV321L8rnRL2wkMwMovNaIiXWAjnmBvUKwzJRCnyNpNRQagjJjmhU619SyWiW4
         cxJw==
X-Forwarded-Encrypted: i=1; AJvYcCUYvzfDDOTkeCguh0vA725SAR+ZSLZhyXRwMh+4xS1ZXBXJJbH5QyF4YHxRTuqkIfPKv7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvUnm8OKjZJE6F83oWftaTAPZ12sXTVrfoEHA1xiUMtvhHpGIg
	YDbGKa7S4/OXqLmpbBBbUCDGZsjyISJhds+6Kv95sCdOC2m5Y8sLqGjYALvGl2h98nXLeOL8Uh6
	PoTMK+8pWGCU9dAxbkvFsYNmHtxE/P1k=
X-Gm-Gg: ASbGncsLut3FzOHSAY8NRd4e9igKvpvZmzyRxEq678rRBlAenCj4d31dGD/o+jhgf+o
	ApXbmZZgva2g46EoK/QM8DbUwUCrcZfhvryUDVCstfkNhtblPsd3N8alCTo6bEwFIEAyFbffRV+
	fAGNi10FFnZWd3n1laTFbtxD6guJindxPiIHd1g+lmZzdbg6zpR+/mASqn2XQZYLlis6fp+vc0a
	H+fySIqJgRHt5KF/GXlRCE=
X-Google-Smtp-Source: AGHT+IGX1x/rLh6T62gvVj2EWhzF8UHfmjEJsyqMGiPwxRo/2hggBPZEdkSV/4xL+6Tf1c2M/aWyB9xO7EGuKGSK52A=
X-Received: by 2002:adf:e186:0:b0:3a5:2653:7308 with SMTP id
 ffacd0b85a97d-3b5f18debd5mr13480127f8f.57.1752515545708; Mon, 14 Jul 2025
 10:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-4-alexei.starovoitov@gmail.com> <20250711075001.fnlMZfk6@linutronix.de>
 <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz> <20250711151730.rz_TY1Qq@linutronix.de>
 <CAADnVQKF=U+Go44fpDYOoZp+3e0xrLYXE4yYLm82H819WqnpnA@mail.gmail.com> <20250714110639.uOaKJEfL@linutronix.de>
In-Reply-To: <20250714110639.uOaKJEfL@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Jul 2025 10:52:10 -0700
X-Gm-Features: Ac12FXzoWo31JpXtCiKZcrl4QbhAUBZ3qtzSYF9FUHB5ZK9i7dwpYq3d49cxqVQ
Message-ID: <CAADnVQLORq64ezK+gaU=Q2F2KyCYOBZiVE0aaJuqK=xfUwMFiw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce local_lock_lockdep_start/end()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 4:06=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-07-11 19:19:26 [-0700], Alexei Starovoitov wrote:
> > > If there is no parent check then we could do "normal lock" on both
> > > sides.
> >
> > How would ___slab_alloc() know whether there was a parent check or not?
> >
> > imo keeping local_lock_irqsave() as-is is cleaner,
> > since if there is no parent check lockdep will rightfully complain.
>
> what about this:
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 7e2ffe1d46c6c..3520d1c25c205 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3693,6 +3693,34 @@ static inline void *freeze_slab(struct kmem_cache =
*s, struct slab *slab)
>         return freelist;
>  }
>
> +static void local_lock_cpu_slab(struct kmem_cache *s, const gfp_t gfp_fl=
ags,
> +                               unsigned long *flags)
> +{
> +       bool allow_spin =3D gfpflags_allow_spinning(gfp_flags);
> +
> +       /*
> +        * ___slab_alloc()'s caller is supposed to check if kmem_cache::k=
mem_cache_cpu::lock
> +        * can be acquired without a deadlock before invoking the functio=
n.
> +        *
> +        * On PREEMPT_RT an invocation is not possible from IRQ-off or pr=
eempt
> +        * disabled context. The lock will always be acquired and if need=
ed it
> +        * block and sleep until the lock is available.
> +        *
> +        * On !PREEMPT_RT allocations from any context but NMI are safe. =
The lock
> +        * is always acquired with disabled interrupts meaning it is alwa=
ys
> +        * possible to it.
> +        * In NMI context it is needed to check if the lock is acquired. =
If it is not,
> +        * it is safe to acquire it. The trylock semantic is used to tell=
 lockdep
> +        * that we don't spin. The BUG_ON() will not trigger if it is saf=
e to acquire
> +        * the lock.
> +        *
> +        */
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !allow_spin)
> +               BUG_ON(!local_trylock_irqsave(&s->cpu_slab->lock, *flags)=
);
> +       else
> +               local_lock_irqsave(&s->cpu_slab->lock, *flags);
> +}

the patch misses these two:

diff --git a/mm/slub.c b/mm/slub.c
index 36779519b02c..2f30b85fbf68 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3260,7 +3260,7 @@ static void put_cpu_partial(struct kmem_cache
*s, struct slab *slab, int drain)
        unsigned long flags;
        int slabs =3D 0;

-       local_lock_irqsave(&s->cpu_slab->lock, flags);
+       local_lock_cpu_slab(s, 0, &flags);

        oldslab =3D this_cpu_read(s->cpu_slab->partial);

@@ -4889,8 +4889,9 @@ static __always_inline void do_slab_free(struct
kmem_cache *s,
                        goto redo;
                }
        } else {
+               long flags;
                /* Update the free list under the local lock */
-               local_lock(&s->cpu_slab->lock);
+               local_lock_cpu_slab(s, 0, &flags);
                c =3D this_cpu_ptr(s->cpu_slab);
                if (unlikely(slab !=3D c->slab)) {
                        local_unlock(&s->cpu_slab->lock);

I realized that the latter one was missing local_lock_lockdep_start/end()
in my patch as well, but that's secondary.

So with above it works on !RT,
but on RT lockdep complains as I explained earlier.

With yours and above hunks applied here is full lockdep splat:

[   39.819636] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   39.819638] WARNING: possible recursive locking detected
[   39.819641] 6.16.0-rc5-00342-gc8aca7837440-dirty #54 Tainted: G         =
  O
[   39.819645] --------------------------------------------
[   39.819646] page_alloc_kthr/2306 is trying to acquire lock:
[   39.819650] ff110001f5cbea88 ((&c->lock)){+.+.}-{3:3}, at:
___slab_alloc+0xb7/0xec0
[   39.819667]
[   39.819667] but task is already holding lock:
[   39.819668] ff110001f5cbfe88 ((&c->lock)){+.+.}-{3:3}, at:
___slab_alloc+0xb7/0xec0
[   39.819677]
[   39.819677] other info that might help us debug this:
[   39.819678]  Possible unsafe locking scenario:
[   39.819678]
[   39.819679]        CPU0
[   39.819680]        ----
[   39.819681]   lock((&c->lock));
[   39.819684]   lock((&c->lock));
[   39.819687]
[   39.819687]  *** DEADLOCK ***
[   39.819687]
[   39.819687]  May be due to missing lock nesting notation
[   39.819687]
[   39.819689] 2 locks held by page_alloc_kthr/2306:
[   39.819691]  #0: ff110001f5cbfe88 ((&c->lock)){+.+.}-{3:3}, at:
___slab_alloc+0xb7/0xec0
[   39.819700]  #1: ffffffff8588f3a0 (rcu_read_lock){....}-{1:3}, at:
rt_spin_lock+0x197/0x250
[   39.819710]
[   39.819710] stack backtrace:
[   39.819714] CPU: 1 UID: 0 PID: 2306 Comm: page_alloc_kthr Tainted:
G           O        6.16.0-rc5-00342-gc8aca7837440-dirty #54
PREEMPT_RT
[   39.819721] Tainted: [O]=3DOOT_MODULE
[   39.819723] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   39.819726] Call Trace:
[   39.819729]  <TASK>
[   39.819734]  dump_stack_lvl+0x5b/0x80
[   39.819740]  print_deadlock_bug.cold+0xbd/0xca
[   39.819747]  __lock_acquire+0x12ad/0x2590
[   39.819753]  ? __lock_acquire+0x42b/0x2590
[   39.819758]  lock_acquire+0x133/0x2d0
[   39.819763]  ? ___slab_alloc+0xb7/0xec0
[   39.819769]  ? try_to_take_rt_mutex+0x624/0xfc0
[   39.819773]  ? __lock_acquire+0x42b/0x2590
[   39.819778]  rt_spin_lock+0x6f/0x250
[   39.819783]  ? ___slab_alloc+0xb7/0xec0
[   39.819788]  ? rtlock_slowlock_locked+0x5c60/0x5c60
[   39.819792]  ? rtlock_slowlock_locked+0xc3/0x5c60
[   39.819798]  ___slab_alloc+0xb7/0xec0
[   39.819803]  ? __lock_acquire+0x42b/0x2590
[   39.819809]  ? my_debug_callback+0x20e/0x390 [bpf_testmod]
[   39.819826]  ? __lock_acquire+0x42b/0x2590
[   39.819830]  ? rt_read_unlock+0x2f0/0x2f0
[   39.819835]  ? my_debug_callback+0x20e/0x390 [bpf_testmod]
[   39.819844]  ? kmalloc_nolock_noprof+0x15a/0x430
[   39.819849]  kmalloc_nolock_noprof+0x15a/0x430
[   39.819857]  my_debug_callback+0x20e/0x390 [bpf_testmod]
[   39.819867]  ? page_alloc_kthread+0x320/0x320 [bpf_testmod]
[   39.819875]  ? lock_is_held_type+0x85/0xe0
[   39.819881]  ___slab_alloc+0x256/0xec0
[   39.819898]  ? lock_acquire+0x133/0x2d0
[   39.819927]  ? __kmalloc_cache_noprof+0xd6/0x3b0
[   39.819932]  __kmalloc_cache_noprof+0xd6/0x3b0

As I said earlier lockdep _has_ to be tricked.
We cannot unconditionally call local_lock_irqsave() on RT.
lockdep doesn't understand per-cpu local_lock.
And it doesn't understand this "if !locked_by_current_task -> go and lock"
concept.
lockdep has to be taught about safe lock region (call it tricking
lockdep, but it has to be an external signal to lockdep).

