Return-Path: <bpf+bounces-49263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C6A15E63
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 18:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52581886918
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F5D1A2387;
	Sat, 18 Jan 2025 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa0Rr8I1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DC82913
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737222255; cv=none; b=jTp1rkFLfLYnGVjc0cL9gTp7Gw2rM2jtvdx45MKFjX1SDYTa/SscIVe+pdRdThJnW9VvxbGXT/VReI9Rt7NPt9Wr9o+eDfBwK+DPUdV1Vwj6SQ71pnV6fQcK5OjEsCO4CZwLbY8b4uJGUl3+uJOhQ5FHAO2EGEJ604lz9hRaxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737222255; c=relaxed/simple;
	bh=kXJw16u5rLnon8hgyqSrMFM7T8nY0YWa4pgdjXP48q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oF+t+uxoHbJpToCScgyoN6+9olVZU4aao7L8p/0ng1b7SymCPphGFSm2R+invljYqF+BrkfgrPk15z/IKwreDLDsIcbEyPzZjdbVjtTtrf4NqCdC/e1i/hwy8hRlxO7iKSqbZFoRHdVSbE7IUbe4QVltkkpfjGdkBQJ7ukcCa8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa0Rr8I1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38632b8ae71so2453780f8f.0
        for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737222251; x=1737827051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfUNEGoEWhJmcyiok2cMEPVHP5NXhXdaOo/NHniAEiI=;
        b=Pa0Rr8I1AaFgQoOf22LXhzvGK33VPJVcnsPNh+nGyoN3cO2+c+wZI1BsEbVcGciBlB
         Ctaa+jDzAvENo+ut53c5ZVtfSmKkSkFNCSKY1hFTf4sW8RdhMQl1diVxUKGTb8eQCos8
         HucdAQpL3GL0RBfJgNTWcIrD5bMPVv/SOwabMmLOGyWLy04oGr48ihQDzDyBhlQ0O+1G
         tulILbYUC6IUkD9XqGGAiaKEXh4JC9kaY6AoAnnKSNnKggdtrIOAvXRj4256zJkw4idj
         uxdw3d+2TmserRXvR1LNlH+UMMgi7xZO1/hEWH4XOZkG3SBGehJIT9sE6NEcXOd/faqO
         2YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737222251; x=1737827051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfUNEGoEWhJmcyiok2cMEPVHP5NXhXdaOo/NHniAEiI=;
        b=BPK2seIzwZ0+nf4hOT7onoWanr8+mFe+bCjeawGetp6P03UorEHDUJ0Ka7hEo1DeWi
         56ImAnLcbl8Oi3CgVbvBQvIi7mS9QD1K+T7jSXqUbLuEnVWiKZZdrUSPf3LDZv4fisVD
         BJkZcGmRVaYnk1O4JtDU0RnMg3joX0u3sf5P+AYzp2TeDFaJ/jMEsYwC7kw5P1rIWuN2
         IIzg0lEiJrOT2kX+hDl/EgEQIWLplGbloskmQ6oc3smASjmmVH6mcfyZubzhJKk6Wc53
         UeY+vtsyzoPn2UL/HImWQyHANH0tA4yoBZOU3mD3QSH8C/9qNNBPBVCoNb/CKMRoJFaa
         XkyA==
X-Gm-Message-State: AOJu0YwrxMGPeliSFgvcw4id9JrI+5j6sgfm9j/qMRQDZob09/9tFSa9
	XSGtRb4fllLdUtWVVTukl38EalwVUWkxS0bF4FpyMMgfTbrttJIxw5LS4FHBmYduxuwvrzRe3z8
	aA8ELLh77/kOuCHTPWbsZOpMwQHg=
X-Gm-Gg: ASbGncvVVoP8kmnxV/+8zUaZKteqkhJU0eudRpbTXsppiDpYSOtFnwzNCPlVedQuKcj
	kNQ7tgOIHmmcfUBwQGgRf1ar14gysxXoanTu5/KquiLxKu9zzxKlN
X-Google-Smtp-Source: AGHT+IHWmiqJBbMokGn8zUY2KmaeNgkHUPkipLFgxfMgWuq9CGr+xTLfszlYislSMgXB/YEayfNfJuaziDHgLoTdXfY=
X-Received: by 2002:a5d:4312:0:b0:388:e377:8a1b with SMTP id
 ffacd0b85a97d-38bf57950eemr5104170f8f.28.1737222250943; Sat, 18 Jan 2025
 09:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118162238.2621311-1-memxor@gmail.com> <20250118162238.2621311-2-memxor@gmail.com>
In-Reply-To: <20250118162238.2621311-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 18 Jan 2025 09:43:59 -0800
X-Gm-Features: AbW1kva3Ze2S4g57eozrVVbNyIP8vHejQGu44jAasV7CSvpmQyMmhfdeM6guApA
Message-ID: <CAADnVQLjr3FG4Gk9gGgn8k5kmJJSRi-xDMm2Y8LbZwhDVnk=7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Introduce qspinlock for
 BPF arena
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 8:22=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Implement queued spin lock algorithm as BPF program for lock words
> living in BPF arena.
>
> The algorithm is copied from kernel/locking/qspinlock.c and adapted for
> BPF use.
>
> We first implement abstract helpers for portable atomics and
> acquire/release load instructions, by relying on X86_64 presence to
> elide expensive barriers and rely on implementation details of the JIT,
> and fall back to slow but correct implementations elsewhere. When
> support for acquire/release load/stores lands, we can improve this
> state.
>
> Then, the qspinlock algorithm is adapted to remove dependence on
> multi-word atomics due to lack of support in BPF ISA. For instance,
> xchg_tail cannot use 16-bit xchg, and needs to be a implemented as a
> 32-bit try_cmpxchg loop.
>
> Loops which are seemingly infinite from verifier PoV are annotated with
> cond_break.
>
> No feedback is given when loops containing cond_break break due to
> stalling, the arena will basically be corrupt if a deadlock is
> triggered. This can be changed in the future with a better cancellation
> primitive for stuck programs, or integrating resilient spin lock
> support.
>
> Only 1024 NR_CPUs are supported.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/bpf_arena_qspinlock.h       | 441 ++++++++++++++++++
>  tools/testing/selftests/bpf/bpf_atomic.h      | 121 +++++
>  2 files changed, 562 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/bpf_arena_qspinlock.h
>  create mode 100644 tools/testing/selftests/bpf/bpf_atomic.h
>
> diff --git a/tools/testing/selftests/bpf/bpf_arena_qspinlock.h b/tools/te=
sting/selftests/bpf/bpf_arena_qspinlock.h
> new file mode 100644
> index 000000000000..cf8c5b1eced9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_arena_qspinlock.h
> @@ -0,0 +1,441 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#ifndef BPF_ARENA_QSPINLOCK_H
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_atomic.h"
> +
> +#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CA=
ST)
> +
> +#ifndef __arena
> +#define __arena __attribute__((address_space(1)))
> +#endif
> +
> +extern unsigned long CONFIG_NR_CPUS __kconfig;
> +
> +struct arena_mcs_spinlock {
> +       struct arena_mcs_spinlock __arena *next;
> +       int locked;
> +       int count;
> +};
> +
> +struct arena_qnode {
> +       struct arena_mcs_spinlock mcs;
> +};
> +
> +#define _Q_MAX_NODES           4
> +#define _Q_PENDING_LOOPS       1
> +
> +/*
> + * Bitfields in the atomic value:
> + *
> + *  0- 7: locked byte
> + *     8: pending
> + *  9-15: not used
> + * 16-17: tail index
> + * 18-31: tail cpu (+1)
> + */
> +#define _Q_MAX_CPUS            1024
> +
> +#define        _Q_SET_MASK(type)       (((1U << _Q_ ## type ## _BITS) - =
1)\
> +                                     << _Q_ ## type ## _OFFSET)
> +#define _Q_LOCKED_OFFSET       0
> +#define _Q_LOCKED_BITS         8
> +#define _Q_LOCKED_MASK         _Q_SET_MASK(LOCKED)
> +
> +#define _Q_PENDING_OFFSET      (_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
> +#define _Q_PENDING_BITS                8
> +#define _Q_PENDING_MASK                _Q_SET_MASK(PENDING)
> +
> +#define _Q_TAIL_IDX_OFFSET     (_Q_PENDING_OFFSET + _Q_PENDING_BITS)
> +#define _Q_TAIL_IDX_BITS       2
> +#define _Q_TAIL_IDX_MASK       _Q_SET_MASK(TAIL_IDX)
> +
> +#define _Q_TAIL_CPU_OFFSET     (_Q_TAIL_IDX_OFFSET + _Q_TAIL_IDX_BITS)
> +#define _Q_TAIL_CPU_BITS       (32 - _Q_TAIL_CPU_OFFSET)
> +#define _Q_TAIL_CPU_MASK       _Q_SET_MASK(TAIL_CPU)
> +
> +#define _Q_TAIL_OFFSET         _Q_TAIL_IDX_OFFSET
> +#define _Q_TAIL_MASK           (_Q_TAIL_IDX_MASK | _Q_TAIL_CPU_MASK)
> +
> +#define _Q_LOCKED_VAL          (1U << _Q_LOCKED_OFFSET)
> +#define _Q_PENDING_VAL         (1U << _Q_PENDING_OFFSET)
> +
> +#define __pure __attribute__((pure))
> +#define likely(x) __builtin_expect(!!(x), 1)
> +#define unlikely(x) __builtin_expect(!!(x), 0)
> +
> +static struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
> +
> +static inline __pure u32 encode_tail(int cpu, int idx)

Pls remove __pure. The compiler is smart enough
without this aid.

> +{
> +       u32 tail;
> +
> +       tail  =3D (cpu + 1) << _Q_TAIL_CPU_OFFSET;
> +       tail |=3D idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */
> +
> +       return tail;
> +}
> +
> +static inline __pure struct arena_mcs_spinlock __arena *
> +decode_tail(u32 tail, struct arena_qnode (__arena *qnodes)[_Q_MAX_CPUS][=
_Q_MAX_NODES])
> +{
> +       int cpu =3D (tail >> _Q_TAIL_CPU_OFFSET) - 1;
> +       int idx =3D (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;
> +       struct arena_qnode __arena (*qnode)[_Q_MAX_NODES] =3D qnodes[cpu]=
;
> +
> +       return &qnode[idx]->mcs;
> +}
> +
> +static inline __pure
> +struct arena_mcs_spinlock __arena *grab_mcs_node(struct arena_mcs_spinlo=
ck __arena *base, int idx)
> +{
> +       return &((struct arena_qnode __arena *)base + idx)->mcs;
> +}
> +
> +#define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
> +
> +/**
> + * xchg_tail - Put in the new queue tail code word & retrieve previous o=
ne
> + * @lock : Pointer to queued spinlock structure
> + * @tail : The new queue tail code word
> + * Return: The previous queue tail code word
> + *
> + * xchg(lock, tail)
> + *
> + * p,*,* -> n,*,* ; prev =3D xchg(lock, node)
> + */
> +static __always_inline u32 xchg_tail(struct qspinlock __arena *lock, u32=
 tail)
> +{
> +       u32 old, new;
> +
> +       old =3D atomic_read(&lock->val);
> +       do {
> +               new =3D (old & _Q_LOCKED_PENDING_MASK) | tail;
> +               /*
> +                * We can use relaxed semantics since the caller ensures =
that
> +                * the MCS node is properly initialized before updating t=
he
> +                * tail.
> +                */
> +               cond_break;
> +       } while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
> +
> +       return old;
> +}
> +
> +/**
> + * clear_pending - clear the pending bit.
> + * @lock: Pointer to queued spinlock structure
> + *
> + * *,1,* -> *,0,*
> + */
> +static __always_inline void clear_pending(struct qspinlock __arena *lock=
)
> +{
> +       WRITE_ONCE(lock->pending, 0);
> +}
> +
> +/**
> + * clear_pending_set_locked - take ownership and clear the pending bit.
> + * @lock: Pointer to queued spinlock structure
> + *
> + * *,1,0 -> *,0,1
> + *
> + * Lock stealing is not allowed if this function is used.
> + */
> +static __always_inline void clear_pending_set_locked(struct qspinlock __=
arena *lock)
> +{
> +       WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
> +}
> +
> +/**
> + * set_locked - Set the lock bit and own the lock
> + * @lock: Pointer to queued spinlock structure
> + *
> + * *,*,0 -> *,0,1
> + */
> +static __always_inline void set_locked(struct qspinlock __arena *lock)
> +{
> +       WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
> +}
> +
> +static __always_inline
> +u32 queued_fetch_set_pending_acquire(struct qspinlock __arena *lock)
> +{
> +       u32 old, new;
> +
> +       old =3D atomic_read(&lock->val);
> +       do {
> +               new =3D old | _Q_PENDING_VAL;
> +               cond_break;
> +       } while (!atomic_try_cmpxchg_acquire(&lock->val, &old, new));
> +
> +       return old;
> +}
> +
> +/**
> + * queued_spin_trylock - try to acquire the queued spinlock
> + * @lock : Pointer to queued spinlock structure
> + * Return: 1 if lock acquired, 0 if failed
> + */
> +static __always_inline int queued_spin_trylock(struct qspinlock __arena =
*lock)
> +{
> +       int val =3D atomic_read(&lock->val);
> +
> +       if (unlikely(val))
> +               return 0;
> +
> +       return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOC=
KED_VAL));
> +}
> +
> +static void queued_spin_lock_slowpath(struct qspinlock __arena *lock, u3=
2 val);
> +
> +#define EOPNOTSUPP     95
> +
> +/**
> + * queued_spin_lock - acquire a queued spinlock
> + * @lock: Pointer to queued spinlock structure
> + */
> +static __always_inline int queued_spin_lock(struct qspinlock __arena *lo=
ck)
> +{
> +       int val =3D 0;
> +
> +       if (CONFIG_NR_CPUS > 1024)
> +               return -EOPNOTSUPP;
> +
> +       if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED=
_VAL)))
> +               return 0;
> +
> +       queued_spin_lock_slowpath(lock, val);
> +       return 0;

Since bpf prog has to do:
if (queued_spin_lock(&lock))...

Let's do
return queued_spin_lock_slowpath(...);

right away.

> +}
> +
> +/**
> + * queued_spin_unlock - release a queued spinlock
> + * @lock : Pointer to queued spinlock structure
> + */
> +static __always_inline void queued_spin_unlock(struct qspinlock __arena =
*lock)
> +{
> +       /*
> +        * unlock() needs release semantics:
> +        */
> +       smp_store_release(&lock->locked, 0);
> +}
> +
> +static void queued_spin_lock_slowpath(struct qspinlock __arena *lock, u3=
2 val)
> +{
> +       struct arena_mcs_spinlock __arena *prev, *next, *node0, *node;
> +       u32 old, tail;
> +       int idx;
> +
> +       /*
> +        * Wait for in-progress pending->locked hand-overs with a bounded
> +        * number of spins so that we guarantee forward progress.
> +        *
> +        * 0,1,0 -> 0,0,1
> +        */
> +       if (val =3D=3D _Q_PENDING_VAL) {
> +               int cnt =3D _Q_PENDING_LOOPS;
> +               val =3D atomic_cond_read_relaxed(&lock->val,
> +                                              (VAL !=3D _Q_PENDING_VAL) =
|| !cnt--);
> +       }
> +
> +       /*
> +        * If we observe any contention; queue.
> +        */
> +       if (val & ~_Q_LOCKED_MASK)
> +               goto queue;
> +
> +       /*
> +        * trylock || pending
> +        *
> +        * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
> +        */
> +       val =3D queued_fetch_set_pending_acquire(lock);
> +
> +       /*
> +        * If we observe contention, there is a concurrent locker.
> +        *
> +        * Undo and queue; our setting of PENDING might have made the
> +        * n,0,0 -> 0,0,0 transition fail and it will now be waiting
> +        * on @next to become !NULL.
> +        */
> +       if (unlikely(val & ~_Q_LOCKED_MASK)) {
> +
> +               /* Undo PENDING if we set it. */
> +               if (!(val & _Q_PENDING_MASK))
> +                       clear_pending(lock);
> +
> +               goto queue;
> +       }
> +
> +       /*
> +        * We're pending, wait for the owner to go away.
> +        *
> +        * 0,1,1 -> *,1,0
> +        *
> +        * this wait loop must be a load-acquire such that we match the
> +        * store-release that clears the locked bit and create lock
> +        * sequentiality; this is because not all
> +        * clear_pending_set_locked() implementations imply full
> +        * barriers.
> +        */
> +       if (val & _Q_LOCKED_MASK)
> +               smp_cond_load_acquire(&lock->locked, !VAL);
> +
> +       /*
> +        * take ownership and clear the pending bit.
> +        *
> +        * 0,1,0 -> 0,0,1
> +        */
> +       clear_pending_set_locked(lock);
> +       return;
> +
> +       /*
> +        * End of pending bit optimistic spinning and beginning of MCS
> +        * queuing.
> +        */
> +queue:
> +       node0 =3D &(qnodes[bpf_get_smp_processor_id()])[0].mcs;
> +       idx =3D node0->count++;
> +       tail =3D encode_tail(bpf_get_smp_processor_id(), idx);
> +
> +       /*
> +        * 4 nodes are allocated based on the assumption that there will
> +        * not be nested NMIs taking spinlocks. That may not be true in
> +        * some architectures even though the chance of needing more than
> +        * 4 nodes will still be extremely unlikely. When that happens,
> +        * we fall back to spinning on the lock directly without using
> +        * any MCS node. This is not the most elegant solution, but is
> +        * simple enough.
> +        */
> +       if (unlikely(idx >=3D _Q_MAX_NODES)) {
> +               while (!queued_spin_trylock(lock)) {
> +                       cpu_relax();
> +                       cond_break;
> +               }
> +               goto release;
> +       }
> +
> +       node =3D grab_mcs_node(node0, idx);
> +
> +       /*
> +        * Ensure that we increment the head node->count before initialis=
ing
> +        * the actual node. If the compiler is kind enough to reorder the=
se
> +        * stores, then an IRQ could overwrite our assignments.
> +        */
> +       barrier();
> +
> +       node->locked =3D 0;
> +       node->next =3D NULL;
> +
> +       /*
> +        * We touched a (possibly) cold cacheline in the per-cpu queue no=
de;
> +        * attempt the trylock once more in the hope someone let go while=
 we
> +        * weren't watching.
> +        */
> +       if (queued_spin_trylock(lock))
> +               goto release;
> +
> +       /*
> +        * Ensure that the initialisation of @node is complete before we
> +        * publish the updated tail via xchg_tail() and potentially link
> +        * @node into the waitqueue via WRITE_ONCE(prev->next, node) belo=
w.
> +        */
> +       smp_wmb();
> +
> +       /*
> +        * Publish the updated tail.
> +        * We have already touched the queueing cacheline; don't bother w=
ith
> +        * pending stuff.
> +        *
> +        * p,*,* -> n,*,*
> +        */
> +       old =3D xchg_tail(lock, tail);
> +       next =3D NULL;
> +
> +       /*
> +        * if there was a previous node; link it and wait until reaching =
the
> +        * head of the waitqueue.
> +        */
> +       if (old & _Q_TAIL_MASK) {
> +               prev =3D decode_tail(old, &qnodes);
> +
> +               /* Link @node into the waitqueue. */
> +               WRITE_ONCE(prev->next, node);
> +
> +               arch_mcs_spin_lock_contended(&node->locked);
> +
> +               /*
> +                * While waiting for the MCS lock, the next pointer may h=
ave
> +                * been set by another lock waiter. We cannot prefetch he=
re
> +                * due to lack of equivalent instruction in BPF ISA.
> +                */
> +               next =3D READ_ONCE(node->next);
> +       }
> +
> +       /*
> +        * we're at the head of the waitqueue, wait for the owner & pendi=
ng to
> +        * go away.
> +        *
> +        * *,x,y -> *,0,0
> +        *
> +        * this wait loop must use a load-acquire such that we match the
> +        * store-release that clears the locked bit and create lock
> +        * sequentiality; this is because the set_locked() function below
> +        * does not imply a full barrier.
> +        */
> +       val =3D atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PE=
NDING_MASK));

cond_break in xchg loops is not a concern,
but this one can spin for long time.
Have you tried
asm ("may_goto out");
out:
  return -ETIMEDOUT;

as suggested earlier?

I think it should work already and will give a clear
signal instead of silent corruption.

> +
> +       /*
> +        * claim the lock:
> +        *
> +        * n,0,0 -> 0,0,1 : lock, uncontended
> +        * *,*,0 -> *,*,1 : lock, contended
> +        *
> +        * If the queue head is the only one in the queue (lock value =3D=
=3D tail)
> +        * and nobody is pending, clear the tail code and grab the lock.
> +        * Otherwise, we only need to grab the lock.
> +        */
> +
> +       /*
> +        * In the PV case we might already have _Q_LOCKED_VAL set, becaus=
e
> +        * of lock stealing; therefore we must also allow:
> +        *
> +        * n,0,1 -> 0,0,1
> +        *
> +        * Note: at this point: (val & _Q_PENDING_MASK) =3D=3D 0, because=
 of the
> +        *       above wait condition, therefore any concurrent setting o=
f
> +        *       PENDING will make the uncontended transition fail.
> +        */
> +       if ((val & _Q_TAIL_MASK) =3D=3D tail) {
> +               if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKE=
D_VAL))
> +                       goto release; /* No contention */
> +       }
> +
> +       /*
> +        * Either somebody is queued behind us or _Q_PENDING_VAL got set
> +        * which will then detect the remaining tail and queue behind us
> +        * ensuring we'll see a @next.
> +        */
> +       set_locked(lock);
> +
> +       /*
> +        * contended path; wait for next if not observed yet, release.
> +        */
> +       if (!next)
> +               next =3D smp_cond_load_relaxed(&node->next, (VAL));

same here.
Doing may_goto out here is necessary.
Otherwise it's too much of a footgun.

> +       arch_mcs_spin_unlock_contended(&next->locked);
> +
> +release:;
> +       /*
> +        * release the node
> +        */
> +       /* TODO(kkd): Is replacing __this_cpu_dec with this ok? */
> +       node0->count--;
> +}
> +
> +#endif
> +
> +#endif
> diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/sel=
ftests/bpf/bpf_atomic.h
> new file mode 100644
> index 000000000000..d9a8b9cd27b4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_atomic.h
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_experimental.h"
> +
> +extern bool CONFIG_X86_64 __kconfig __weak;
> +
> +#define __scalar_type_to_expr_cases(type) \
> +       unsigned type : (unsigned type)0, signed type : (signed type)0
> +
> +#define __unqual_typeof(x)                              \
> +       typeof(_Generic((x),                            \
> +               char: (char)0,                          \
> +               __scalar_type_to_expr_cases(char),      \
> +               __scalar_type_to_expr_cases(short),     \
> +               __scalar_type_to_expr_cases(int),       \
> +               __scalar_type_to_expr_cases(long),      \
> +               __scalar_type_to_expr_cases(long long), \
> +               default: (void *)0))

I doubt all this magic makes any difference for generated code.
Could you try without it?

> +#define cpu_relax() ({})
> +
> +#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> +
> +#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) =3D (val))
> +
> +#define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
> +
> +#define try_cmpxchg(p, pold, new)                                       =
\
> +       ({                                                              \
> +               __unqual_typeof(*(p)) __old =3D cmpxchg(p, *(pold), new);=
 \
> +               *(pold) =3D __old;                                       =
 \
> +               *(pold) =3D=3D __old;                                    =
   \
> +       })

This doesn't look right.
It will always succeed ?
Incorrect copy paste of __raw_try_cmpxchg ?

Patch 2 test probably needs to be stronger.

pw-bot: cr

> +
> +#define try_cmpxchg_relaxed(p, pold, new) try_cmpxchg(p, pold, new)
> +
> +#define try_cmpxchg_acquire(p, pold, new) try_cmpxchg(p, pold, new)
> +
> +#define smp_mb()                                 \
> +       ({                                       \
> +               unsigned long __val;             \
> +               __sync_fetch_and_add(&__val, 0); \
> +       })
> +
> +#define smp_rmb()                   \
> +       ({                          \
> +               if (!CONFIG_X86_64) \
> +                       smp_mb();   \
> +               else                \
> +                       barrier();  \
> +       })
> +
> +#define smp_wmb()                   \
> +       ({                          \
> +               if (!CONFIG_X86_64) \
> +                       smp_mb();   \
> +               else                \
> +                       barrier();  \
> +       })
> +
> +/* Control dependency provides LOAD->STORE, provide LOAD->LOAD */
> +#define smp_acquire__after_ctrl_dep() ({ smp_rmb(); })
> +
> +#define smp_load_acquire(p)                                  \
> +       ({                                                   \
> +               __unqual_typeof(*(p)) __v =3D READ_ONCE(*(p)); \
> +               if (!CONFIG_X86_64)                          \
> +                       smp_mb();                            \
> +               barrier();                                   \
> +               __v;                                         \
> +       })
> +
> +#define smp_store_release(p, val)      \
> +       ({                             \
> +               if (!CONFIG_X86_64)    \
> +                       smp_mb();      \
> +               barrier();             \
> +               WRITE_ONCE(*(p), val); \
> +       })
> +
> +#define smp_cond_load_relaxed(p, cond_expr)                             =
\
> +       ({                                                              \
> +               typeof(p) __ptr =3D (p);                                 =
 \
> +               __unqual_typeof(*(p)) VAL;                              \
> +               for (;;) {                                              \
> +                       VAL =3D (__unqual_typeof(*(p)))READ_ONCE(*__ptr);=
 \
> +                       if (cond_expr)                                  \
> +                               break;                                  \
> +                       cpu_relax();                                    \
> +                       cond_break;                                     \
> +               }                                                       \
> +               (typeof(*(p)))VAL;                                      \
> +       })
> +
> +#define smp_cond_load_acquire(p, cond_expr)                          \
> +       ({                                                           \
> +               __unqual_typeof(*p)                                  \
> +                       __val =3D smp_cond_load_relaxed(p, cond_expr); \
> +               smp_acquire__after_ctrl_dep();                       \
> +               (typeof(*(p)))__val;                                 \
> +       })
> +
> +#define atomic_read(p) READ_ONCE((p)->counter)
> +
> +#define atomic_cond_read_relaxed(p, cond_expr) \
> +       smp_cond_load_relaxed(&(p)->counter, cond_expr)
> +
> +#define atomic_cond_read_acquire(p, cond_expr) \
> +       smp_cond_load_acquire(&(p)->counter, cond_expr)
> +
> +#define atomic_try_cmpxchg_relaxed(p, pold, new) \
> +       try_cmpxchg_relaxed(&(p)->counter, pold, new)
> +
> +#define atomic_try_cmpxchg_acquire(p, pold, new) \
> +       try_cmpxchg_acquire(&(p)->counter, pold, new)
> +
> +#define arch_mcs_spin_lock_contended(l) smp_cond_load_acquire(l, VAL)
> +#define arch_mcs_spin_unlock_contended(l) smp_store_release((l), 1)
> --
> 2.43.5
>

