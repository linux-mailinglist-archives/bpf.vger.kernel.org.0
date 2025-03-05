Return-Path: <bpf+bounces-53280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D229EA4F4B1
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE63E16E419
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE7156C5E;
	Wed,  5 Mar 2025 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjfVH05l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC88136988
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 02:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141641; cv=none; b=D1A/D3fV964thKjWWMnypAbM4yLfvAe8+iPS2XxSnVRSk9ZPVOrKxEIakKgOlXYZ/VU4d1wGaPyRz9+kEJaFb2/lXgBJHyPM0J5k0knsMHC9mIvoX+JsIeb0hgfSoOUISqL+8dU6lZlRLQPSeNcmJX3eaUVgElLhYd3Avj4hEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141641; c=relaxed/simple;
	bh=YgMkcJqzx4JFZ91xs4H7Xmzum5f6TldfXyI4y83pD8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RczVKQlm7JKrixek/FnO9egc9BDl88HUNqJncj1bymOXFWwkHXAEGq06TZVI2eQdRE0kNbuwWa9KnWCOElc97qOhi+wSUw+v6Fp+EZRWgV1a04UkKkIego4jpPqEU5Pe/7YXMkE4CKlfvZ88PyxgA9cyUSai4MaXrTwSKe+c1bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjfVH05l; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390fb1b987fso4298394f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 18:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741141636; x=1741746436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twEwuP6bSbzNR2YNVCfsKSIH+Sypi+dtPAoEEXx7qhQ=;
        b=gjfVH05lpXw3g3trvU9fdnNejITFgj7tYJil3Pd1Aoq6EC9SoG7wBlIKGNpb0TgqmY
         3izJStMKg1hSMQhZ/QQSJjzEMXmI73jiZttIUmWdkrcLAhYwyr+12PbI5g1Dz0Ddqxqj
         qP9lQkouxOQJ4D8MAzCxaA0caw66Y0kh86oe9I/7Yf2ptBuEGHFFfGx/dO17jmpZQOHG
         90huyFIk9Q1VxpAVyDGvbVS8OfoEBvUfztS0lRl8NhmW40PKpsGUU5vxjj/p9sNivtlP
         LJAliFB5wpvFrXP0Np2KOaubSiPZxUTqmrpWjkk8nh4eEP4JgOwcjJuDUA/clvc9JljI
         h6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141636; x=1741746436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twEwuP6bSbzNR2YNVCfsKSIH+Sypi+dtPAoEEXx7qhQ=;
        b=dq4lGitZPEkwc3N3mBMys1D8i+9T/Dj/2vnFDq7UGQQ5tsUddOiV4bMuANShbB9Rak
         RpPnF82YL97fnIjB6DpfUpHJB3udvupB4deFM2BqjeM1sy4TcTjTUqN3575xpxjJ2QKM
         bCpDbQ+yRRI4oTsL1r+Lz4GIn3G/PgRRhZEYcCVVicqVKDfxBOhYw4bBoKClGrXeb/KT
         RAYeg4b+1dl61WylQ3zcpxFEMV5C8ZmIJyEzljRXI58haM9v93xmHXtkfcFqd68vqDLw
         99Nu6tR2GXvy83fkkIdWmhNXAB8bhBhKc8BRiRz3xenGTh7jmwFJs9cuCXXwF1axxr+B
         WWPg==
X-Gm-Message-State: AOJu0YzxzALkmKzekyeFuoyda5CHfwv1NrzXGtNaur8ryDSCni1rLPDx
	FEWIRJvIq2psM1wwuaZm5oC/YdZClX7lePZk6Nds2w99IfxLrGymqZx5ObVI5iC6zPdUyV1tts5
	klloUIj+rjSVyV4BYzBxoa4YOU+Y=
X-Gm-Gg: ASbGncsHOvLwlPa8hXX0s+PKc/qnJcFjf3ZBmV0idqhEETGk5cmnu1vNhUqBPHbgP2m
	rcFCiKn+RIG4wHwiza3F72Zj2VpnAmfkw1H9nuoxTZULSTp62jQLnHDCIvmw+xI81Mdman/5PKd
	0Pib3BlR86H6BpSPvrHTm1Y/BSHhs0kBzK/GT/N+Hy2A==
X-Google-Smtp-Source: AGHT+IE1al+jIsZrJQ/vq2ihp/r3Cubj8u2XjYRj1g417v6iTT1Xjdep4fvSlmcTelgCGBK89T3xHJf4McsR8GJmPMU=
X-Received: by 2002:a05:6000:2a3:b0:390:f641:53f2 with SMTP id
 ffacd0b85a97d-3911f727717mr881829f8f.10.1741141635495; Tue, 04 Mar 2025
 18:27:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305011849.1168917-1-memxor@gmail.com> <20250305011849.1168917-3-memxor@gmail.com>
In-Reply-To: <20250305011849.1168917-3-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Mar 2025 18:27:03 -0800
X-Gm-Features: AQ5f1JrzEtvydaseN2xwmK-OHIy4c6WOz5VwDHdKzyB4BjZ6DUL1HRL_8wCnaHY
Message-ID: <CAADnVQJQd9Lof1Qj4DWn0aFdY079gjcOsKo6XBBMKwnjXdw7eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Introduce arena spin lock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:19=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
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
> cond_break_label macro to return an error. Only 1024 NR_CPUs are
> supported.
>
> We need to allocate 1025 qnodes, one more than NR_CPUs, since if libbpf
> maps the qnode global variable starting at the first page of the arena,
> and the lower 32-bits are zeroed for the base address, the first node
> for CPU 0 will become indistinguishable from a NULL pointer, leading to
> spurious timeouts and failures.
>
> Note that the slow path is a global function, hence the verifier doesn't
> know the return value's precision. The recommended way of usage is to
> always test against zero for success, and not ret < 0 for error, as the
> verifier would assume ret > 0 has not been accounted for.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/bpf_arena_spin_lock.h       | 505 ++++++++++++++++++
>  tools/testing/selftests/bpf/bpf_atomic.h      | 132 +++++
>  2 files changed, 637 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/bpf_arena_spin_lock.h
>  create mode 100644 tools/testing/selftests/bpf/bpf_atomic.h
>
> diff --git a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h b/tools/te=
sting/selftests/bpf/bpf_arena_spin_lock.h
> new file mode 100644
> index 000000000000..cc7de78e0373
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
> @@ -0,0 +1,505 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#ifndef BPF_ARENA_SPIN_LOCK_H
> +#define BPF_ARENA_SPIN_LOCK_H
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_atomic.h"
> +
> +#define arch_mcs_spin_lock_contended_label(l, label) smp_cond_load_acqui=
re_label(l, VAL, label)
> +#define arch_mcs_spin_unlock_contended(l) smp_store_release((l), 1)
> +
> +#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CA=
ST)
> +
> +#define EBUSY 16
> +#define EOPNOTSUPP 95
> +#define ETIMEDOUT 110
> +
> +#ifndef __arena
> +#define __arena __attribute__((address_space(1)))
> +#endif
> +
> +extern unsigned long CONFIG_NR_CPUS __kconfig;
> +
> +#define arena_spinlock_t struct qspinlock
> +/* FIXME: Using typedef causes CO-RE relocation error */
> +/* typedef struct qspinlock arena_spinlock_t; */
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
> +#define likely(x) __builtin_expect(!!(x), 1)
> +#define unlikely(x) __builtin_expect(!!(x), 0)
> +
> +/*
> + * We always index with + 1, in case we unfortunately place the qnodes a=
t
> + * pg_offset=3D0 and then CPU 0's qnodes is indistinguishable from NULL =
if lower
> + * 32-bits of the node pointer are 0.
> + */
> +struct arena_qnode __arena qnodes[_Q_MAX_CPUS + 1][_Q_MAX_NODES];
> +
> +static inline u32 encode_tail(int cpu, int idx)
> +{
> +       u32 tail;
> +
> +       tail  =3D (cpu + 1) << _Q_TAIL_CPU_OFFSET;
> +       tail |=3D idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */
> +
> +       return tail;
> +}
> +
> +static inline struct arena_mcs_spinlock __arena *decode_tail(u32 tail)
> +{
> +       u32 cpu =3D (tail >> _Q_TAIL_CPU_OFFSET) - 1;
> +       u32 idx =3D (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;
> +
> +       /* See comments over definition of qnodes for the + 1. */
> +       if (likely(idx < _Q_MAX_NODES && cpu < _Q_MAX_CPUS))
> +               return &qnodes[cpu + 1][idx].mcs;
> +       bpf_printk("RUNTIME ERROR: %s idx=3D%u and cpu=3D%u are out-of-bo=
unds!!!", __func__, idx, cpu);

Is it really possible? 1024 check is done early and
idx cannot be out of bounds.
So only to detect corruption?

> +       return NULL;
> +}
> +
> +static inline
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
> +static __always_inline u32 xchg_tail(arena_spinlock_t __arena *lock, u32=
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
> +               /* These loops are not expected to stall, but we still ne=
ed to
> +                * prove to the verifier they will terminate eventually.
> +                */
> +               cond_break_label(out);
> +       } while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
> +
> +       return old;
> +out:
> +       bpf_printk("RUNTIME ERROR: %s unexpected cond_break exit!!!", __f=
unc__);
> +       return old;
> +}
> +
> +/**
> + * clear_pending - clear the pending bit.
> + * @lock: Pointer to queued spinlock structure
> + *
> + * *,1,* -> *,0,*
> + */
> +static __always_inline void clear_pending(arena_spinlock_t __arena *lock=
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
> +static __always_inline void clear_pending_set_locked(arena_spinlock_t __=
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
> +static __always_inline void set_locked(arena_spinlock_t __arena *lock)
> +{
> +       WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
> +}
> +
> +static __always_inline
> +u32 arena_fetch_set_pending_acquire(arena_spinlock_t __arena *lock)
> +{
> +       u32 old, new;
> +
> +       old =3D atomic_read(&lock->val);
> +       do {
> +               new =3D old | _Q_PENDING_VAL;
> +               /*
> +                * These loops are not expected to stall, but we still ne=
ed to
> +                * prove to the verifier they will terminate eventually.
> +                */
> +               cond_break_label(out);
> +       } while (!atomic_try_cmpxchg_acquire(&lock->val, &old, new));
> +
> +       return old;
> +out:
> +       bpf_printk("RUNTIME ERROR: %s unexpected cond_break exit!!!", __f=
unc__);
> +       return old;
> +}
> +
> +/**
> + * arena_spin_trylock - try to acquire the queued spinlock
> + * @lock : Pointer to queued spinlock structure
> + * Return: 1 if lock acquired, 0 if failed
> + */
> +static __always_inline int arena_spin_trylock(arena_spinlock_t __arena *=
lock)
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
> +__noinline
> +int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock,=
 u32 val)
> +{
> +       struct arena_mcs_spinlock __arena *prev, *next, *node0, *node;
> +       int ret =3D -ETIMEDOUT;
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
> +               val =3D atomic_cond_read_relaxed_label(&lock->val,
> +                                                    (VAL !=3D _Q_PENDING=
_VAL) || !cnt--,
> +                                                    release_err);
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
> +       val =3D arena_fetch_set_pending_acquire(lock);
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
> +               smp_cond_load_acquire_label(&lock->locked, !VAL, release_=
err);
> +
> +       /*
> +        * take ownership and clear the pending bit.
> +        *
> +        * 0,1,0 -> 0,0,1
> +        */
> +       clear_pending_set_locked(lock);
> +       return 0;
> +
> +       /*
> +        * End of pending bit optimistic spinning and beginning of MCS
> +        * queuing.
> +        */
> +queue:
> +       /* See comments over definition of qnodes for the + 1. */
> +       node0 =3D &(qnodes[bpf_get_smp_processor_id() + 1])[0].mcs;
> +       idx =3D node0->count++;
> +       tail =3D encode_tail(bpf_get_smp_processor_id(), idx);
> +
> +       /*
> +        * 4 nodes are allocated based on the assumption that there will =
not be
> +        * nested NMIs taking spinlocks. That may not be true in some
> +        * architectures even though the chance of needing more than 4 no=
des
> +        * will still be extremely unlikely. When that happens, we simply=
 return
> +        * an error. Original qspinlock has a trylock fallback in this ca=
se.
> +        */
> +       if (unlikely(idx >=3D _Q_MAX_NODES)) {
> +               ret =3D -EBUSY;
> +               goto release_node_err;
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
> +       if (arena_spin_trylock(lock))
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
> +               prev =3D decode_tail(old);
> +
> +               /* Link @node into the waitqueue. */
> +               WRITE_ONCE(prev->next, node);
> +
> +               arch_mcs_spin_lock_contended_label(&node->locked, release=
_node_err);
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
> +       val =3D atomic_cond_read_acquire_label(&lock->val, !(VAL & _Q_LOC=
KED_PENDING_MASK),
> +                                            release_node_err);
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
> +               next =3D smp_cond_load_relaxed_label(&node->next, (VAL), =
release_node_err);
> +
> +       arch_mcs_spin_unlock_contended(&next->locked);
> +
> +release:;
> +       /*
> +        * release the node
> +        *
> +        * Doing a normal dec vs this_cpu_dec is fine. An upper context a=
lways
> +        * decrements count it incremented before returning, thus we're f=
ine.
> +        * For contexts interrupting us, they either observe our dec or n=
ot.
> +        * Just ensure the compiler doesn't reorder this statement, as a
> +        * this_cpu_dec implicitly implied that.
> +        */
> +       barrier();
> +       node0->count--;
> +       return 0;
> +release_node_err:
> +       barrier();
> +       node0->count--;
> +       goto release_err;
> +release_err:
> +       return ret;
> +}
> +
> +/**
> + * arena_spin_lock - acquire a queued spinlock
> + * @lock: Pointer to queued spinlock structure
> + *
> + * The return value _must_ be tested against zero for success.
> + * On error, returned value will be negative.
> + */
> +static __always_inline int arena_spin_lock(arena_spinlock_t __arena *loc=
k)
> +{
> +       int val =3D 0;
> +
> +       if (CONFIG_NR_CPUS > 1024)
> +               return -EOPNOTSUPP;
> +
> +       bpf_preempt_disable();
> +       if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED=
_VAL)))
> +               return 0;
> +
> +       val =3D arena_spin_lock_slowpath(lock, val);
> +       /* FIXME: bpf_assert_range(-MAX_ERRNO, 0) once we have it working=
 for all cases. */
> +       if (val)
> +               bpf_preempt_enable();
> +       return val;
> +}
> +
> +/**
> + * arena_spin_unlock - release a queued spinlock
> + * @lock : Pointer to queued spinlock structure
> + */
> +static __always_inline void arena_spin_unlock(arena_spinlock_t __arena *=
lock)
> +{
> +       /*
> +        * unlock() needs release semantics:
> +        */
> +       smp_store_release(&lock->locked, 0);
> +       bpf_preempt_enable();
> +}
> +
> +#define arena_spin_lock_irqsave(lock, flags)             \
> +       ({                                               \
> +               int __ret;                               \
> +               bpf_local_irq_save(&(flags));            \
> +               __ret =3D arena_spin_lock((lock));         \
> +               if (__ret)                               \
> +                       bpf_local_irq_restore(&(flags)); \
> +               (__ret);                                 \
> +       })
> +
> +#define arena_spin_unlock_irqrestore(lock, flags) \
> +       ({                                        \
> +               arena_spin_unlock((lock));        \
> +               bpf_local_irq_restore(&(flags));  \
> +       })
> +
> +#endif
> +
> +#endif /* BPF_ARENA_SPIN_LOCK_H */
> diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/sel=
ftests/bpf/bpf_atomic.h
> new file mode 100644
> index 000000000000..06defb9e050d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_atomic.h
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#ifndef BPF_ATOMIC_H
> +#define BPF_ATOMIC_H
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_experimental.h"
> +
> +extern bool CONFIG_X86_64 __kconfig __weak;
> +
> +#define __scalar_type_to_expr_cases(type) \
> +       unsigned type : (unsigned type)0, signed type : (signed type)0
> +/*
> + * This is lifted from __unqual_scalar_typeof in the kernel (which is us=
ed to
> + * lose const qualifier etc.), but adapted to also cover pointers. It is
> + * necessary because we ascertain type to create local variables in macr=
os
> + * below, but for pointers with __arena tag, we'll ascertain the underly=
ing type
> + * with the tag, causing a compilation error (as local variables that ar=
e not
> + * pointers may not have __arena tag). This trick allows losing the qual=
ifier.
> + */

I bet that's what causing llvm to miss the cases where it needs
to emit cast_user() or more likely it forces llvm to emit cast_kern()
where it shouldn't be doing it.
Not sure which pointer you saw as indistinguishable from NULL.
I suspect it's smp_cond_load_relaxed_label(&node->next, ..
which is doing:
__unqual_typeof(*(p)) VAL;
(__unqual_typeof(*(p)))READ_ONCE(*__ptr);

and llvm will insert cast_kern() there,
so if (VAL) always sees upper 32-bit as zero.

So I suspect it's not a zero page issue.

> +#define __unqual_typeof(x)                              \
> +       typeof(_Generic((x),                            \
> +               char: (char)0,                          \
> +               __scalar_type_to_expr_cases(char),      \
> +               __scalar_type_to_expr_cases(short),     \
> +               __scalar_type_to_expr_cases(int),       \
> +               __scalar_type_to_expr_cases(long),      \
> +               __scalar_type_to_expr_cases(long long), \
> +               default: (void *)0))
> +
> +/* No-op for BPF */
> +#define cpu_relax() ({})
> +
> +#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> +
> +#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) =3D (val))
> +
> +#define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
> +
> +#define try_cmpxchg(p, pold, new)                                 \
> +       ({                                                        \
> +               __unqual_typeof(*(pold)) __o =3D *(pold);           \
> +               __unqual_typeof(*(p)) __r =3D cmpxchg(p, __o, new); \
> +               if (__r !=3D __o)                                   \
> +                       *(pold) =3D __r;                            \
> +               __r =3D=3D __o;                                       \
> +       })
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
> +#define smp_cond_load_relaxed_label(p, cond_expr, label)                =
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
> +                       cond_break_label(label);                        \
> +                       cpu_relax();                                    \
> +               }                                                       \
> +               (typeof(*(p)))VAL;                                      \
> +       })
> +
> +#define smp_cond_load_acquire_label(p, cond_expr, label)                =
  \
> +       ({                                                               =
 \
> +               __unqual_typeof(*p) __val =3D                            =
   \
> +                       smp_cond_load_relaxed_label(p, cond_expr, label);=
 \
> +               smp_acquire__after_ctrl_dep();                           =
 \
> +               (typeof(*(p)))__val;                                     =
 \
> +       })
> +
> +#define atomic_read(p) READ_ONCE((p)->counter)
> +
> +#define atomic_cond_read_relaxed_label(p, cond_expr, label) \
> +       smp_cond_load_relaxed_label(&(p)->counter, cond_expr, label)
> +
> +#define atomic_cond_read_acquire_label(p, cond_expr, label) \
> +       smp_cond_load_acquire_label(&(p)->counter, cond_expr, label)
> +
> +#define atomic_try_cmpxchg_relaxed(p, pold, new) \
> +       try_cmpxchg_relaxed(&(p)->counter, pold, new)
> +
> +#define atomic_try_cmpxchg_acquire(p, pold, new) \
> +       try_cmpxchg_acquire(&(p)->counter, pold, new)
> +
> +#endif /* BPF_ATOMIC_H */
> --
> 2.47.1
>

