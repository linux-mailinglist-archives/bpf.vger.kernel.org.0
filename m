Return-Path: <bpf+bounces-63239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E7B0477E
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A50189F6C6
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664C01E7C03;
	Mon, 14 Jul 2025 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy7Xvg8S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014861CD1F
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752518792; cv=none; b=sqrAWFbZqlbjgUN6817P2O8zRWkgfOeVFvSwncWK6c+JAphCQ6FWL2MtA4mf2eOAomqB8zRVCIpIjRxRhQDlHHEnneyV4P4XW+eXGnIeIyUvcEgm4w62DbMVPFXiVRFpg+5uNwvw3XxKsN0Jr9i3dstjv47FOj48UGPhResDyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752518792; c=relaxed/simple;
	bh=XATRLAahby8N4OpDs0BuKX4kAITpK+F9rCNOTlH+tBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTudpUxQCA5hBRtYg4oqBHqVDtGJ94xf9wao6zSU2ink4y/MPRs1k9P9fzUl+AsgRI0bbDW3Qdgb8JlWCnzvmP2HJv8XPZfMfTjYwelTC71g1EADVLJNWgTzZMkTlFlm6DBDfwLFNErrRJ8tquAU8Xw6oLdBUTDxEgiklpjC+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy7Xvg8S; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso3755988f8f.1
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752518788; x=1753123588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE8CIuj1NSGIOmV+CFOurI1s5NLtbei1Sq1HYe0whhQ=;
        b=Yy7Xvg8ShvtoxMkCvymySUWY31lQsUa/U2RsV+2Ficeb0SnvbKgRE5kTQkJCAmIyxa
         NkZQniQI7UXlIYuK5wtx9w0f0/GGSuX/QOPAY9jgMBj1NwMd8VRM2/rKD5I5R6yVovr3
         7ttKh/fo6NMERoGcdo3wP7bni1dIB8RYp9qo/7c89QWCX3tpuYPWJcT9Y51aEVbiGIyL
         X1bKCGtBvyC8gC7yeM6K5AY4/VSpNzn16cOe1haSpcpszu9fwGLRtVx28WZkNPJE2lFO
         2tDQC75OW/IbpQ7gIwabnwn279o1td4w5gHJqWKy3iXS/pNT8elUJKdkF1YXPHsxTxEE
         Nqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752518788; x=1753123588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fE8CIuj1NSGIOmV+CFOurI1s5NLtbei1Sq1HYe0whhQ=;
        b=te9MYIBi9fEDffLL+h//tjPNhcsuEH/TcP2l8Tpp7NgVPLg2KEiDYO/C45yfumUIS8
         bkhJ347FLejgIormGq7dBy4XTO0u0x1Qbn6X+UgEHvsua/vzWXYp6Ai9kg78T7ZC7heP
         kkVSYxFFO7g5+kSUSvRRip+RbsZhmAURQq44W/co4v9covr7Ia30dgv5AlnDY/50QJ9B
         cL0OBvUpAvfPwUgarQvuXZ9yEk5Ko1XO71lFWMTgBs11Lwp6ycEqCGHKoCxH7kyhIcvZ
         8OkCvYpnz3LQvo60EjX2+De0xNtozCKlOYH5lANWLHVMm/FrA94zH3Fm+pQDn+tH1/jZ
         kj3w==
X-Forwarded-Encrypted: i=1; AJvYcCUYnG8OSyboPdbzWC/rUIl0UligFNjYNsiu+eJtwltO54imajqQ7oVbHGXrmvIqrdTCT60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0VsNRKgo1p1Wd4QMSKPIEc8sv8syX6vYRsK+PB55bGd4rObnc
	fcpMFT9BRXzgRD41Pb2LIHwDV5LgmB3mPdV2uXaxfApG5x/o9zJKJNV/YrgRISKBLPd6uViYvBQ
	zz3Ryy/ptawIy5gGReYT1MLdZjQ7IdZk=
X-Gm-Gg: ASbGncv4kvS24VMgoEYKlYpPNd9Ua8pIHCT4q8jUxXXhBDkdDh0CEABaA0mjrQ7uvi3
	EBXA/eGBp0qaJgM3GYTSuUNkDJ/XkuBvgdHwOZIdOKOcbohg56mgTx9/9AW3aN11+NTPPqKBCdh
	HsIInEPL29U5Ox9Wv6m3Cwu5kSaM1mxzaIPhUwRtEbVsqChbPUAkmT+DfIY29nAmq2Ajm5fiEel
	zMz2f2DV2cuDsVY8eNnvek=
X-Google-Smtp-Source: AGHT+IEoGMs2VNK9KodUHhx9kWA0nxw7EEC51nbhdajDCX1VdU45zhDhU6YG+APa7TdwC1UiaxKoceBTzt5B+dU47Xo=
X-Received: by 2002:a05:6000:26c3:b0:3a4:f7e3:c63c with SMTP id
 ffacd0b85a97d-3b5f2d2c149mr11595283f8f.0.1752518787823; Mon, 14 Jul 2025
 11:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-4-alexei.starovoitov@gmail.com> <20250711075001.fnlMZfk6@linutronix.de>
 <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz> <20250711151730.rz_TY1Qq@linutronix.de>
 <CAADnVQKF=U+Go44fpDYOoZp+3e0xrLYXE4yYLm82H819WqnpnA@mail.gmail.com>
 <20250714110639.uOaKJEfL@linutronix.de> <CAADnVQLORq64ezK+gaU=Q2F2KyCYOBZiVE0aaJuqK=xfUwMFiw@mail.gmail.com>
 <d556c4fb-ddc2-4bf0-9510-5c682cd717f5@suse.cz>
In-Reply-To: <d556c4fb-ddc2-4bf0-9510-5c682cd717f5@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Jul 2025 11:46:14 -0700
X-Gm-Features: Ac12FXxFbTAz4ruKThiiT7B_QMHMH6DNJ_14i4n0-hrL4qNhb-43Kz_IBgOWr-Q
Message-ID: <CAADnVQK3B4ToOOuWOWQdvHO-1as3X2YMGkj45vYQ0Nxoe55Nsw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce local_lock_lockdep_start/end()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Harry Yoo <harry.yoo@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 11:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/14/25 19:52, Alexei Starovoitov wrote:
> > On Mon, Jul 14, 2025 at 4:06=E2=80=AFAM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> >>
> >> On 2025-07-11 19:19:26 [-0700], Alexei Starovoitov wrote:
> >> > > If there is no parent check then we could do "normal lock" on both
> >> > > sides.
> >> >
> >> > How would ___slab_alloc() know whether there was a parent check or n=
ot?
> >> >
> >> > imo keeping local_lock_irqsave() as-is is cleaner,
> >> > since if there is no parent check lockdep will rightfully complain.
> >>
> >> what about this:
> >>
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 7e2ffe1d46c6c..3520d1c25c205 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -3693,6 +3693,34 @@ static inline void *freeze_slab(struct kmem_cac=
he *s, struct slab *slab)
> >>         return freelist;
> >>  }
> >>
> >> +static void local_lock_cpu_slab(struct kmem_cache *s, const gfp_t gfp=
_flags,
> >> +                               unsigned long *flags)
> >> +{
> >> +       bool allow_spin =3D gfpflags_allow_spinning(gfp_flags);
> >> +
> >> +       /*
> >> +        * ___slab_alloc()'s caller is supposed to check if kmem_cache=
::kmem_cache_cpu::lock
> >> +        * can be acquired without a deadlock before invoking the func=
tion.
> >> +        *
> >> +        * On PREEMPT_RT an invocation is not possible from IRQ-off or=
 preempt
> >> +        * disabled context. The lock will always be acquired and if n=
eeded it
> >> +        * block and sleep until the lock is available.
> >> +        *
> >> +        * On !PREEMPT_RT allocations from any context but NMI are saf=
e. The lock
> >> +        * is always acquired with disabled interrupts meaning it is a=
lways
> >> +        * possible to it.
> >> +        * In NMI context it is needed to check if the lock is acquire=
d. If it is not,
> >> +        * it is safe to acquire it. The trylock semantic is used to t=
ell lockdep
> >> +        * that we don't spin. The BUG_ON() will not trigger if it is =
safe to acquire
> >> +        * the lock.
> >> +        *
> >> +        */
> >> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !allow_spin)
> >> +               BUG_ON(!local_trylock_irqsave(&s->cpu_slab->lock, *fla=
gs));
> >> +       else
> >> +               local_lock_irqsave(&s->cpu_slab->lock, *flags);
> >> +}
> >
> > the patch misses these two:
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 36779519b02c..2f30b85fbf68 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3260,7 +3260,7 @@ static void put_cpu_partial(struct kmem_cache
> > *s, struct slab *slab, int drain)
> >         unsigned long flags;
> >         int slabs =3D 0;
> >
> > -       local_lock_irqsave(&s->cpu_slab->lock, flags);
> > +       local_lock_cpu_slab(s, 0, &flags);
> >
> >         oldslab =3D this_cpu_read(s->cpu_slab->partial);
> >
> > @@ -4889,8 +4889,9 @@ static __always_inline void do_slab_free(struct
> > kmem_cache *s,
> >                         goto redo;
> >                 }
> >         } else {
> > +               long flags;
> >                 /* Update the free list under the local lock */
> > -               local_lock(&s->cpu_slab->lock);
> > +               local_lock_cpu_slab(s, 0, &flags);
> >                 c =3D this_cpu_ptr(s->cpu_slab);
> >                 if (unlikely(slab !=3D c->slab)) {
> >                         local_unlock(&s->cpu_slab->lock);
> >
> > I realized that the latter one was missing local_lock_lockdep_start/end=
()
> > in my patch as well, but that's secondary.
> >
> > So with above it works on !RT,
> > but on RT lockdep complains as I explained earlier.
> >
> > With yours and above hunks applied here is full lockdep splat:
> >
> > [   39.819636] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > [   39.819638] WARNING: possible recursive locking detected
> > [   39.819641] 6.16.0-rc5-00342-gc8aca7837440-dirty #54 Tainted: G     =
      O
> > [   39.819645] --------------------------------------------
> > [   39.819646] page_alloc_kthr/2306 is trying to acquire lock:
> > [   39.819650] ff110001f5cbea88 ((&c->lock)){+.+.}-{3:3}, at:
> > ___slab_alloc+0xb7/0xec0
> > [   39.819667]
> > [   39.819667] but task is already holding lock:
> > [   39.819668] ff110001f5cbfe88 ((&c->lock)){+.+.}-{3:3}, at:
> > ___slab_alloc+0xb7/0xec0
> > [   39.819677]
> > [   39.819677] other info that might help us debug this:
> > [   39.819678]  Possible unsafe locking scenario:
> > [   39.819678]
> > [   39.819679]        CPU0
> > [   39.819680]        ----
> > [   39.819681]   lock((&c->lock));
> > [   39.819684]   lock((&c->lock));
> > [   39.819687]
> > [   39.819687]  *** DEADLOCK ***
> > [   39.819687]
> > [   39.819687]  May be due to missing lock nesting notation
> > [   39.819687]
> > [   39.819689] 2 locks held by page_alloc_kthr/2306:
> > [   39.819691]  #0: ff110001f5cbfe88 ((&c->lock)){+.+.}-{3:3}, at:
> > ___slab_alloc+0xb7/0xec0
> > [   39.819700]  #1: ffffffff8588f3a0 (rcu_read_lock){....}-{1:3}, at:
> > rt_spin_lock+0x197/0x250
> > [   39.819710]
> > [   39.819710] stack backtrace:
> > [   39.819714] CPU: 1 UID: 0 PID: 2306 Comm: page_alloc_kthr Tainted:
> > G           O        6.16.0-rc5-00342-gc8aca7837440-dirty #54
> > PREEMPT_RT
> > [   39.819721] Tainted: [O]=3DOOT_MODULE
> > [   39.819723] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   39.819726] Call Trace:
> > [   39.819729]  <TASK>
> > [   39.819734]  dump_stack_lvl+0x5b/0x80
> > [   39.819740]  print_deadlock_bug.cold+0xbd/0xca
> > [   39.819747]  __lock_acquire+0x12ad/0x2590
> > [   39.819753]  ? __lock_acquire+0x42b/0x2590
> > [   39.819758]  lock_acquire+0x133/0x2d0
> > [   39.819763]  ? ___slab_alloc+0xb7/0xec0
> > [   39.819769]  ? try_to_take_rt_mutex+0x624/0xfc0
> > [   39.819773]  ? __lock_acquire+0x42b/0x2590
> > [   39.819778]  rt_spin_lock+0x6f/0x250
>
> But why are we here in ___slab_alloc, trying to take the lock...
>
> > [   39.819783]  ? ___slab_alloc+0xb7/0xec0
> > [   39.819788]  ? rtlock_slowlock_locked+0x5c60/0x5c60
> > [   39.819792]  ? rtlock_slowlock_locked+0xc3/0x5c60
> > [   39.819798]  ___slab_alloc+0xb7/0xec0
> > [   39.819803]  ? __lock_acquire+0x42b/0x2590
> > [   39.819809]  ? my_debug_callback+0x20e/0x390 [bpf_testmod]
> > [   39.819826]  ? __lock_acquire+0x42b/0x2590
> > [   39.819830]  ? rt_read_unlock+0x2f0/0x2f0
> > [   39.819835]  ? my_debug_callback+0x20e/0x390 [bpf_testmod]
> > [   39.819844]  ? kmalloc_nolock_noprof+0x15a/0x430
> > [   39.819849]  kmalloc_nolock_noprof+0x15a/0x430
>
> When in patch 6/6 __slab_alloc() we should have bailed out via
>
>         if (unlikely(!gfpflags_allow_spinning(gfpflags))) {
> +               if (local_lock_is_locked(&s->cpu_slab->lock)) {
> +                       /*
> +                        * EBUSY is an internal signal to kmalloc_nolock(=
) to
> +                        * retry a different bucket. It's not propagated
> +                        * to the caller.
> +                        */
> +                       p =3D ERR_PTR(-EBUSY);
> +                       goto out;
> +               }
>
> So it doesn't seem to me as a lack of lockdep tricking, but we reached
> something we should not have because the avoidance based on
> local_lock_is_locked() above didn't work properly? At least if I read the
> splat and backtrace properly, it doesn't seem to suggest a theoretical
> scenario but that we really tried to lock something we already had locked=
.

It's not theoretical. Such slab re-entrance can happen with
a tracepoint:
slab -> some tracepoint -> bpf -> slab

I simulate it with a stress test:
+extern void (*debug_callback)(void);
+#define local_unlock_irqrestore(lock, flags)                   \
+       do {                    \
+               if (debug_callback) debug_callback(); \
+               __local_unlock_irqrestore(lock, flags); \
+       } while (0)

and debug_callback() calls kmalloc_nolock(random_size) without any bpf
to simplify testing.

> > [   39.819857]  my_debug_callback+0x20e/0x390 [bpf_testmod]
>
> What exactly did you instrument here?
>
> > [   39.819867]  ? page_alloc_kthread+0x320/0x320 [bpf_testmod]
> > [   39.819875]  ? lock_is_held_type+0x85/0xe0
> > [   39.819881]  ___slab_alloc+0x256/0xec0
>
> And here we took the lock originally?

yes, but they are truly different local_locks of different
kmalloc buckets, and local_lock_is_locked() is working.

See in the splat:

> > [   39.819646] page_alloc_kthr/2306 is trying to acquire lock:
> > [   39.819650] ff110001f5cbea88 ((&c->lock)){+.+.}-{3:3}, at:
> > ___slab_alloc+0xb7/0xec0
> > [   39.819667]
> > [   39.819667] but task is already holding lock:
> > [   39.819668] ff110001f5cbfe88 ((&c->lock)){+.+.}-{3:3}, at:
> > ___slab_alloc+0xb7/0xec0

the addresses of the locks are different and they're different
kmalloc buckets, but lockdep cannot understand this without
explicit local_lock_lockdep_start().
The same thing I'm trying to explain in the commit log.

