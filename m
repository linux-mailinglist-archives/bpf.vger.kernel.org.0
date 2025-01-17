Return-Path: <bpf+bounces-49237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F77A1598D
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 23:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2901660EA
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 22:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2CA1DC9BF;
	Fri, 17 Jan 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHa6PpeC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD41ABED9
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153481; cv=none; b=NEmi6ixozBkw/NYOaqS1Yh/8fNl+hSSfzCV/R5JBRqteR6SwquvxbViv8/YAgcBKdwNz4XMPuVs4EfMWTYqiwHMAENyplxAXcNWsL5kTL4ywojDnnZoQvS3PCNHQCb135RQEhXqUb38C77u0K2fHzMw2QtefhUdajBrc+YBcrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153481; c=relaxed/simple;
	bh=Qc2Pdg5OJyxzvTceIq/fsLQdwKiQW+TjVrgyaQbXE7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUSdqFiWKg93V2o8fH+U+U5OH2elKAp1aFVSmBHNFJvi+KsuE7LfZgAko7+eWWth6D5ckrf+DfdMJh7IYrdM40inzmMShqTE8USm9i+fFD9oddYgUcfCEBoI9DFK8LeRp4pxrSehFJwSQg4FioxGlrmsKM2gS32ECvm1RwtnvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHa6PpeC; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43623f0c574so17750605e9.2
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 14:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737153477; x=1737758277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C63upTUcDIZJY5z5DwnHciAZDaxN4NkQdAqhw5SQ6pI=;
        b=QHa6PpeCnCqHPUhguFJbw6J9PG489ZH33qZg9Ngj7J08O+rkTGttgrsFjqdGMLt113
         YwDnBW8xoMankvZ604LsDIvlRHm0DG0mFpdGeVb7dBf2+rhhBuxMRPbguup/vnna5aOz
         r6YGDggwJczWUcae7Opdka3HftPDkwnJu4nOstTeM/Rk1ThN4SQFsEJvw/ReIQhEvyFj
         Lb/JKUOekkV6gFzTMxcs9xx/OrB/MnmZvAVvYR/ZMSJ6zejRpPrzoTtd+esSRPhIv8Ci
         EuKZgfL+Hzig/EAPdlw018Noc3aPhlsf2MaCJUfktwWKcRn/KGVH+VlNCNAUC3evKuvJ
         BnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737153477; x=1737758277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C63upTUcDIZJY5z5DwnHciAZDaxN4NkQdAqhw5SQ6pI=;
        b=odHXur+Mll8SbtwqwSuOeDfjFY6KhZFPbGXLnxrfArjikeJ3ZL5J82tR2O0X3tSJ27
         SZQ3dGkRd7eG4fOUDls0+3ORRGmUkHymvcaV7fRYArquGqoXxB7S3VZk54Rf0z1QO0yj
         3LD9pxuwhhwFJDxpLEKhulNwElD8Nb4M5oyH/UQPMOVANKX/SbK12xxMNJU+d5TJkYMb
         2v/tj+Isk77u1cdtJtMs4gStqEavw8tHCHpfFJ8Q5hsPbtURcjf2SwwZjjZ697RhoJnh
         PwVZABqY0xg7BoC36j/yhhFxBs2Pz99J2c+X4srs+RB+tqR70UjmfuIRAW3TkeMjuAYW
         ODnQ==
X-Gm-Message-State: AOJu0YwECjUZDsaJh8uUMZZJ07bKEck/pcj/GybydQpqNTkQHxDvD/+X
	UXelp/3XqwVGAPdTCry5kVDpOIgxk5bZ5jeoQ9IcYqITuFJTbi++PC+T/ROTIfI=
X-Gm-Gg: ASbGncvae4iKTkqCEfypgpzLFTDiSkiwO02DZQfaJ555T1iySJ/RBp96YIeYHJri0mt
	tCAnhO5h0ir1u/cjjvNkcIBtny9q0rC7yEoZn6/M98k7W5K0MdnqmGeKCHEchwAQF6L9wQZg/sG
	8Ara5nLJ6IevzHp0otY7dz9NPWIqNsar9Z1wdgpbDBBgBFuPvhCEGsgBu/su+5H/PPd6kxVdDvW
	/bcfXu/dLlLToShQRM3zd0SiIqyLaXL641lWKXOoJ5STrblkDzRRl7BFnx8
X-Google-Smtp-Source: AGHT+IEtKq7Qz5hqX1FPtta9IDZflFT7fm47jpXDXnHZOP0hdG7znDsxEdENzBmjlvO2S/LmyfpTaw==
X-Received: by 2002:adf:f788:0:b0:38a:41c9:8544 with SMTP id ffacd0b85a97d-38bf57a2838mr3339137f8f.37.1737153476777;
        Fri, 17 Jan 2025 14:37:56 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:21::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74abb27sm105679385e9.9.2025.01.17.14.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:37:56 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] selftests/bpf: Introduce qspinlock for BPF arena
Date: Fri, 17 Jan 2025 14:37:53 -0800
Message-ID: <20250117223754.1020174-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250117223754.1020174-1-memxor@gmail.com>
References: <20250117223754.1020174-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18530; h=from:subject; bh=Qc2Pdg5OJyxzvTceIq/fsLQdwKiQW+TjVrgyaQbXE7s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnituwZ+Q7VeMxwzP3FE1Q27W6rO1IwoTPM22l9QLR 4gyQBweJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ4rbsAAKCRBM4MiGSL8Ryg9sD/ 9vsAtWYiS027svIS3nDdcI4apegfKvQ83aVjLo1DE//b8MgUvPXDZON5TtMjcCU6grx8hOeN9HvAK7 pVwD/LI4K3BjyMNJ5nqXbv9Ep3Yn0jYnO/ntoC35efPryxbjwx6L0dxnWJBUr6C+gXsUhbc2M5fTXg KI+80uOVYDLxNoq2/JU4DkwinKteCyn8LHtQpKudhOpgyePjC0xLKQ32p33nwZdgZE6mSjS5OWzZWO Kn3c2AoRJgoY9BIQjBwZ0B9sQIzVjC/nDJbbHK/5uco6rkQBkISVf7hhATGU11g/W1c7XeCDMb62iB MJTf4k5e+39y/BwxrvK9Ik39mZMywaDReQBX2SLtFMnasNpuyXsDua3Iw0JU1Wxm04+EQOvt9jKuR7 ZmnX8kjCyGxE4gikVtGrESC5pDT0sN+fmyZrmje665EVZUP/g98ch/AxbkEtNv1L+0qAAKofNjs0Hw r5qGfLLWP8TySBxLg32XnS4rLdVVIDlnFToS84ZT/iZcTIjI9RF8VJOfM0A9FJhe+0o8iMuZq8+l8Z YEZoTuFF+wwXR82WfYKsPxvLpgx7e0f4lPPzGa0QWsWGNDV90DIXDRpA7A8/sT9XZOLvo1AsCPwZ3s R2fCdNL6x2xA+ODxJQesysTamq4ChRCBnwTsEhaK0HYAr2ZgPGErT7uTXgZw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Implement queued spin lock algorithm as BPF program for lock words
living in BPF arena.

The algorithm is copied from kernel/locking/qspinlock.c and adapted for
BPF use.

We first implement abstract helpers for portable atomics and
acquire/release load instructions, by relying on X86_64 presence to
elide expensive barriers and rely on implementation details of the JIT,
and fall back to slow but correct implementations elsewhere. When
support for acquire/release load/stores lands, we can improve this
state.

Then, the qspinlock algorithm is adapted to remove dependence on
multi-word atomics due to lack of support in BPF ISA. For instance,
xchg_tail cannot use 16-bit xchg, and needs to be a implemented as a
32-bit try_cmpxchg loop.

Loops which are seemingly infinite from verifier PoV are annotated with
cond_break.

No feedback is given when loops containing cond_break break due to
stalling, the arena will basically be corrupt if a deadlock is
triggered. This can be changed in the future with a better cancellation
primitive for stuck programs, or integrating resilient spin lock
support.

Only 1024 NR_CPUs are supported.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/bpf_arena_qspinlock.h       | 441 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_atomic.h      | 121 +++++
 2 files changed, 562 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_qspinlock.h
 create mode 100644 tools/testing/selftests/bpf/bpf_atomic.h

diff --git a/tools/testing/selftests/bpf/bpf_arena_qspinlock.h b/tools/testing/selftests/bpf/bpf_arena_qspinlock.h
new file mode 100644
index 000000000000..cf8c5b1eced9
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_qspinlock.h
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#ifndef BPF_ARENA_QSPINLOCK_H
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_atomic.h"
+
+#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+
+#ifndef __arena
+#define __arena __attribute__((address_space(1)))
+#endif
+
+extern unsigned long CONFIG_NR_CPUS __kconfig;
+
+struct arena_mcs_spinlock {
+	struct arena_mcs_spinlock __arena *next;
+	int locked;
+	int count;
+};
+
+struct arena_qnode {
+	struct arena_mcs_spinlock mcs;
+};
+
+#define _Q_MAX_NODES		4
+#define _Q_PENDING_LOOPS	1
+
+/*
+ * Bitfields in the atomic value:
+ *
+ *  0- 7: locked byte
+ *     8: pending
+ *  9-15: not used
+ * 16-17: tail index
+ * 18-31: tail cpu (+1)
+ */
+#define _Q_MAX_CPUS		1024
+
+#define	_Q_SET_MASK(type)	(((1U << _Q_ ## type ## _BITS) - 1)\
+				      << _Q_ ## type ## _OFFSET)
+#define _Q_LOCKED_OFFSET	0
+#define _Q_LOCKED_BITS		8
+#define _Q_LOCKED_MASK		_Q_SET_MASK(LOCKED)
+
+#define _Q_PENDING_OFFSET	(_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
+#define _Q_PENDING_BITS		8
+#define _Q_PENDING_MASK		_Q_SET_MASK(PENDING)
+
+#define _Q_TAIL_IDX_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
+#define _Q_TAIL_IDX_BITS	2
+#define _Q_TAIL_IDX_MASK	_Q_SET_MASK(TAIL_IDX)
+
+#define _Q_TAIL_CPU_OFFSET	(_Q_TAIL_IDX_OFFSET + _Q_TAIL_IDX_BITS)
+#define _Q_TAIL_CPU_BITS	(32 - _Q_TAIL_CPU_OFFSET)
+#define _Q_TAIL_CPU_MASK	_Q_SET_MASK(TAIL_CPU)
+
+#define _Q_TAIL_OFFSET		_Q_TAIL_IDX_OFFSET
+#define _Q_TAIL_MASK		(_Q_TAIL_IDX_MASK | _Q_TAIL_CPU_MASK)
+
+#define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
+#define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
+
+#define __pure __attribute__((pure))
+#define likely(x) __builtin_expect(!!(x), 1)
+#define unlikely(x) __builtin_expect(!!(x), 0)
+
+static struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
+
+static inline __pure u32 encode_tail(int cpu, int idx)
+{
+	u32 tail;
+
+	tail  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
+	tail |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */
+
+	return tail;
+}
+
+static inline __pure struct arena_mcs_spinlock __arena *
+decode_tail(u32 tail, struct arena_qnode (__arena *qnodes)[_Q_MAX_CPUS][_Q_MAX_NODES])
+{
+	int cpu = (tail >> _Q_TAIL_CPU_OFFSET) - 1;
+	int idx = (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;
+	struct arena_qnode __arena (*qnode)[_Q_MAX_NODES] = qnodes[cpu];
+
+	return &qnode[idx]->mcs;
+}
+
+static inline __pure
+struct arena_mcs_spinlock __arena *grab_mcs_node(struct arena_mcs_spinlock __arena *base, int idx)
+{
+	return &((struct arena_qnode __arena *)base + idx)->mcs;
+}
+
+#define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
+
+/**
+ * xchg_tail - Put in the new queue tail code word & retrieve previous one
+ * @lock : Pointer to queued spinlock structure
+ * @tail : The new queue tail code word
+ * Return: The previous queue tail code word
+ *
+ * xchg(lock, tail)
+ *
+ * p,*,* -> n,*,* ; prev = xchg(lock, node)
+ */
+static __always_inline u32 xchg_tail(struct qspinlock __arena *lock, u32 tail)
+{
+	u32 old, new;
+
+	old = atomic_read(&lock->val);
+	do {
+		new = (old & _Q_LOCKED_PENDING_MASK) | tail;
+		/*
+		 * We can use relaxed semantics since the caller ensures that
+		 * the MCS node is properly initialized before updating the
+		 * tail.
+		 */
+		cond_break;
+	} while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
+
+	return old;
+}
+
+/**
+ * clear_pending - clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,* -> *,0,*
+ */
+static __always_inline void clear_pending(struct qspinlock __arena *lock)
+{
+	WRITE_ONCE(lock->pending, 0);
+}
+
+/**
+ * clear_pending_set_locked - take ownership and clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,0 -> *,0,1
+ *
+ * Lock stealing is not allowed if this function is used.
+ */
+static __always_inline void clear_pending_set_locked(struct qspinlock __arena *lock)
+{
+	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
+}
+
+/**
+ * set_locked - Set the lock bit and own the lock
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,*,0 -> *,0,1
+ */
+static __always_inline void set_locked(struct qspinlock __arena *lock)
+{
+	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+}
+
+static __always_inline
+u32 queued_fetch_set_pending_acquire(struct qspinlock __arena *lock)
+{
+	u32 old, new;
+
+	old = atomic_read(&lock->val);
+	do {
+		new = old | _Q_PENDING_VAL;
+		cond_break;
+	} while (!atomic_try_cmpxchg_acquire(&lock->val, &old, new));
+
+	return old;
+}
+
+/**
+ * queued_spin_trylock - try to acquire the queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ * Return: 1 if lock acquired, 0 if failed
+ */
+static __always_inline int queued_spin_trylock(struct qspinlock __arena *lock)
+{
+	int val = atomic_read(&lock->val);
+
+	if (unlikely(val))
+		return 0;
+
+	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
+}
+
+static void queued_spin_lock_slowpath(struct qspinlock __arena *lock, u32 val);
+
+#define EOPNOTSUPP	95
+
+/**
+ * queued_spin_lock - acquire a queued spinlock
+ * @lock: Pointer to queued spinlock structure
+ */
+static __always_inline int queued_spin_lock(struct qspinlock __arena *lock)
+{
+	int val = 0;
+
+	if (CONFIG_NR_CPUS > 1024)
+		return -EOPNOTSUPP;
+
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
+		return 0;
+
+	queued_spin_lock_slowpath(lock, val);
+	return 0;
+}
+
+/**
+ * queued_spin_unlock - release a queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ */
+static __always_inline void queued_spin_unlock(struct qspinlock __arena *lock)
+{
+	/*
+	 * unlock() needs release semantics:
+	 */
+	smp_store_release(&lock->locked, 0);
+}
+
+static void queued_spin_lock_slowpath(struct qspinlock __arena *lock, u32 val)
+{
+	struct arena_mcs_spinlock __arena *prev, *next, *node0, *node;
+	u32 old, tail;
+	int idx;
+
+	/*
+	 * Wait for in-progress pending->locked hand-overs with a bounded
+	 * number of spins so that we guarantee forward progress.
+	 *
+	 * 0,1,0 -> 0,0,1
+	 */
+	if (val == _Q_PENDING_VAL) {
+		int cnt = _Q_PENDING_LOOPS;
+		val = atomic_cond_read_relaxed(&lock->val,
+					       (VAL != _Q_PENDING_VAL) || !cnt--);
+	}
+
+	/*
+	 * If we observe any contention; queue.
+	 */
+	if (val & ~_Q_LOCKED_MASK)
+		goto queue;
+
+	/*
+	 * trylock || pending
+	 *
+	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
+	 */
+	val = queued_fetch_set_pending_acquire(lock);
+
+	/*
+	 * If we observe contention, there is a concurrent locker.
+	 *
+	 * Undo and queue; our setting of PENDING might have made the
+	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
+	 * on @next to become !NULL.
+	 */
+	if (unlikely(val & ~_Q_LOCKED_MASK)) {
+
+		/* Undo PENDING if we set it. */
+		if (!(val & _Q_PENDING_MASK))
+			clear_pending(lock);
+
+		goto queue;
+	}
+
+	/*
+	 * We're pending, wait for the owner to go away.
+	 *
+	 * 0,1,1 -> *,1,0
+	 *
+	 * this wait loop must be a load-acquire such that we match the
+	 * store-release that clears the locked bit and create lock
+	 * sequentiality; this is because not all
+	 * clear_pending_set_locked() implementations imply full
+	 * barriers.
+	 */
+	if (val & _Q_LOCKED_MASK)
+		smp_cond_load_acquire(&lock->locked, !VAL);
+
+	/*
+	 * take ownership and clear the pending bit.
+	 *
+	 * 0,1,0 -> 0,0,1
+	 */
+	clear_pending_set_locked(lock);
+	return;
+
+	/*
+	 * End of pending bit optimistic spinning and beginning of MCS
+	 * queuing.
+	 */
+queue:
+	node0 = &(qnodes[bpf_get_smp_processor_id()])[0].mcs;
+	idx = node0->count++;
+	tail = encode_tail(bpf_get_smp_processor_id(), idx);
+
+	/*
+	 * 4 nodes are allocated based on the assumption that there will
+	 * not be nested NMIs taking spinlocks. That may not be true in
+	 * some architectures even though the chance of needing more than
+	 * 4 nodes will still be extremely unlikely. When that happens,
+	 * we fall back to spinning on the lock directly without using
+	 * any MCS node. This is not the most elegant solution, but is
+	 * simple enough.
+	 */
+	if (unlikely(idx >= _Q_MAX_NODES)) {
+		while (!queued_spin_trylock(lock)) {
+			cpu_relax();
+			cond_break;
+		}
+		goto release;
+	}
+
+	node = grab_mcs_node(node0, idx);
+
+	/*
+	 * Ensure that we increment the head node->count before initialising
+	 * the actual node. If the compiler is kind enough to reorder these
+	 * stores, then an IRQ could overwrite our assignments.
+	 */
+	barrier();
+
+	node->locked = 0;
+	node->next = NULL;
+
+	/*
+	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
+	 * attempt the trylock once more in the hope someone let go while we
+	 * weren't watching.
+	 */
+	if (queued_spin_trylock(lock))
+		goto release;
+
+	/*
+	 * Ensure that the initialisation of @node is complete before we
+	 * publish the updated tail via xchg_tail() and potentially link
+	 * @node into the waitqueue via WRITE_ONCE(prev->next, node) below.
+	 */
+	smp_wmb();
+
+	/*
+	 * Publish the updated tail.
+	 * We have already touched the queueing cacheline; don't bother with
+	 * pending stuff.
+	 *
+	 * p,*,* -> n,*,*
+	 */
+	old = xchg_tail(lock, tail);
+	next = NULL;
+
+	/*
+	 * if there was a previous node; link it and wait until reaching the
+	 * head of the waitqueue.
+	 */
+	if (old & _Q_TAIL_MASK) {
+		prev = decode_tail(old, &qnodes);
+
+		/* Link @node into the waitqueue. */
+		WRITE_ONCE(prev->next, node);
+
+		arch_mcs_spin_lock_contended(&node->locked);
+
+		/*
+		 * While waiting for the MCS lock, the next pointer may have
+		 * been set by another lock waiter. We cannot prefetch here
+		 * due to lack of equivalent instruction in BPF ISA.
+		 */
+		next = READ_ONCE(node->next);
+	}
+
+	/*
+	 * we're at the head of the waitqueue, wait for the owner & pending to
+	 * go away.
+	 *
+	 * *,x,y -> *,0,0
+	 *
+	 * this wait loop must use a load-acquire such that we match the
+	 * store-release that clears the locked bit and create lock
+	 * sequentiality; this is because the set_locked() function below
+	 * does not imply a full barrier.
+	 */
+	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+
+	/*
+	 * claim the lock:
+	 *
+	 * n,0,0 -> 0,0,1 : lock, uncontended
+	 * *,*,0 -> *,*,1 : lock, contended
+	 *
+	 * If the queue head is the only one in the queue (lock value == tail)
+	 * and nobody is pending, clear the tail code and grab the lock.
+	 * Otherwise, we only need to grab the lock.
+	 */
+
+	/*
+	 * In the PV case we might already have _Q_LOCKED_VAL set, because
+	 * of lock stealing; therefore we must also allow:
+	 *
+	 * n,0,1 -> 0,0,1
+	 *
+	 * Note: at this point: (val & _Q_PENDING_MASK) == 0, because of the
+	 *       above wait condition, therefore any concurrent setting of
+	 *       PENDING will make the uncontended transition fail.
+	 */
+	if ((val & _Q_TAIL_MASK) == tail) {
+		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+			goto release; /* No contention */
+	}
+
+	/*
+	 * Either somebody is queued behind us or _Q_PENDING_VAL got set
+	 * which will then detect the remaining tail and queue behind us
+	 * ensuring we'll see a @next.
+	 */
+	set_locked(lock);
+
+	/*
+	 * contended path; wait for next if not observed yet, release.
+	 */
+	if (!next)
+		next = smp_cond_load_relaxed(&node->next, (VAL));
+
+	arch_mcs_spin_unlock_contended(&next->locked);
+
+release:;
+	/*
+	 * release the node
+	 */
+	/* TODO(kkd): Is replacing __this_cpu_dec with this ok? */
+	node0->count--;
+}
+
+#endif
+
+#endif
diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
new file mode 100644
index 000000000000..d9a8b9cd27b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_atomic.h
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+
+extern bool CONFIG_X86_64 __kconfig __weak;
+
+#define __scalar_type_to_expr_cases(type) \
+	unsigned type : (unsigned type)0, signed type : (signed type)0
+
+#define __unqual_typeof(x)                              \
+	typeof(_Generic((x),                            \
+		char: (char)0,                          \
+		__scalar_type_to_expr_cases(char),      \
+		__scalar_type_to_expr_cases(short),     \
+		__scalar_type_to_expr_cases(int),       \
+		__scalar_type_to_expr_cases(long),      \
+		__scalar_type_to_expr_cases(long long), \
+		default: (void *)0))
+
+#define cpu_relax() ({})
+
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
+
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
+
+#define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
+
+#define try_cmpxchg(p, pold, new)                                       \
+	({                                                              \
+		__unqual_typeof(*(p)) __old = cmpxchg(p, *(pold), new); \
+		*(pold) = __old;                                        \
+		*(pold) == __old;                                       \
+	})
+
+#define try_cmpxchg_relaxed(p, pold, new) try_cmpxchg(p, pold, new)
+
+#define try_cmpxchg_acquire(p, pold, new) try_cmpxchg(p, pold, new)
+
+#define smp_mb()                                 \
+	({                                       \
+		unsigned long __val;             \
+		__sync_fetch_and_add(&__val, 0); \
+	})
+
+#define smp_rmb()                   \
+	({                          \
+		if (!CONFIG_X86_64) \
+			smp_mb();   \
+		else                \
+			barrier();  \
+	})
+
+#define smp_wmb()                   \
+	({                          \
+		if (!CONFIG_X86_64) \
+			smp_mb();   \
+		else                \
+			barrier();  \
+	})
+
+/* Control dependency provides LOAD->STORE, provide LOAD->LOAD */
+#define smp_acquire__after_ctrl_dep() ({ smp_rmb(); })
+
+#define smp_load_acquire(p)                                  \
+	({                                                   \
+		__unqual_typeof(*(p)) __v = READ_ONCE(*(p)); \
+		if (!CONFIG_X86_64)                          \
+			smp_mb();                            \
+		barrier();                                   \
+		__v;                                         \
+	})
+
+#define smp_store_release(p, val)      \
+	({                             \
+		if (!CONFIG_X86_64)    \
+			smp_mb();      \
+		barrier();             \
+		WRITE_ONCE(*(p), val); \
+	})
+
+#define smp_cond_load_relaxed(p, cond_expr)                             \
+	({                                                              \
+		typeof(p) __ptr = (p);                                  \
+		__unqual_typeof(*(p)) VAL;                              \
+		for (;;) {                                              \
+			VAL = (__unqual_typeof(*(p)))READ_ONCE(*__ptr); \
+			if (cond_expr)                                  \
+				break;                                  \
+			cpu_relax();                                    \
+			cond_break;                                     \
+		}                                                       \
+		(typeof(*(p)))VAL;                                      \
+	})
+
+#define smp_cond_load_acquire(p, cond_expr)                          \
+	({                                                           \
+		__unqual_typeof(*p)                                  \
+			__val = smp_cond_load_relaxed(p, cond_expr); \
+		smp_acquire__after_ctrl_dep();                       \
+		(typeof(*(p)))__val;                                 \
+	})
+
+#define atomic_read(p) READ_ONCE((p)->counter)
+
+#define atomic_cond_read_relaxed(p, cond_expr) \
+	smp_cond_load_relaxed(&(p)->counter, cond_expr)
+
+#define atomic_cond_read_acquire(p, cond_expr) \
+	smp_cond_load_acquire(&(p)->counter, cond_expr)
+
+#define atomic_try_cmpxchg_relaxed(p, pold, new) \
+	try_cmpxchg_relaxed(&(p)->counter, pold, new)
+
+#define atomic_try_cmpxchg_acquire(p, pold, new) \
+	try_cmpxchg_acquire(&(p)->counter, pold, new)
+
+#define arch_mcs_spin_lock_contended(l) smp_cond_load_acquire(l, VAL)
+#define arch_mcs_spin_unlock_contended(l) smp_store_release((l), 1)
-- 
2.43.5


