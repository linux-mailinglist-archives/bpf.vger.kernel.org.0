Return-Path: <bpf+bounces-53267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA6A4F35C
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F8A16F52D
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9F713BC02;
	Wed,  5 Mar 2025 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l13yKmsS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3013A244
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137541; cv=none; b=gEzG/Y0Bg6aHBvyfuvTLY6t36ATzcmk4T26n4VKawxWI4vM6u15oPyzB4ggtV5fstriRTkx9A7JfbvVBwl+Kf2l1GVnMG9qFmcWuO/0pznPno+oIYfcSdcqsBxLVGqeIYOs0unAhIeGHt3mY0ANxVzykm0sT9NJ14IbIEXl+Rmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137541; c=relaxed/simple;
	bh=fuRAPXXWNXY9P79EZsVYgtdQRcsCPkjZ2HuppsyrE+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmNaNamibrQQKtmph2J3czCPGoLpe5lEDjsXB6SZaeOkuUDynrDx7CUWErsRFr0pIqVeptZHkRzvDsrxKZuEC44+lUjTitqtLZyNvDnjyqhx/r/F0cRjUzsDJDHiGBgl3EyVB8FwtAMOri5OK1qU2+UwFSTU2Jor2vCYjdYMMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l13yKmsS; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43bcb1a9890so1898715e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 17:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741137535; x=1741742335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wP1lc6rees1v2rT2245Jyl5J9y/lNQ0xlPc5qIGeP0=;
        b=l13yKmsS8ubau4S6X2ig4wyRkNjvEgMPe6+0Gvxc+xYlUpnK63+6wWpOfSDvAEu+TT
         vQHjJf85GdyZ9v120+hfGEBU63w9InVcVpiyLhLHA2yYErds/snRLtZRJ3Vn+KMe+lY9
         mAJnKxigimbDW0HOm4twhQelr4zQ1qXYpN0C3fx0Dgi3HL1BBipDhZM1fhe0QqGBAcvO
         rG5UoiXXUMNanD09+7Q8ZzXq17+K7FbHtrAVcOGpXTlwvGN1eWbEz2rGHxvS+Ug9EO+J
         0jJh5vn12sKizDCuRXwjGoQv024YRRzSBNuF0fnfs2lpZdlPvQHYoPEF9JuepWAQk5Yi
         6U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741137535; x=1741742335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wP1lc6rees1v2rT2245Jyl5J9y/lNQ0xlPc5qIGeP0=;
        b=JZLfCkNyMnoYpyav5tovegPbCmDuCUNRNcYkBd/en9bXa39PCGHKNGDp1TaCmzp5JD
         5EkjqvtVcSodJ4gSA9FgfNdQHDNa4ewaGZGSS8lcHEFD2SWynSEkCU6DuHB4Y906vljz
         UERuk6e6IJXkqef8EUdLs2AP1v+/v9aBsZ8CYumFZ1p2IBJzFSkPJZXFi2qcSH0jFFAN
         BioIvQmaXYZvodNTPQKivDsBFvzGty3J8uvzufBlqbDMHUcEG18ao8AixPao5dyls/Vd
         agT6aPWRJmtaiUVB8vIReINubWK+a5G79FSz7S3cea7fhoSZsrvDNb/5ppkS7xeNj1O3
         xBuQ==
X-Gm-Message-State: AOJu0YxZKQ/Q3E0IeuNWFA5oytKvFJt8A7JAitgbduLoHDa4sCAftR+R
	5DsSxDm/LuAbycD3Q8tnVpPRo/N5jzPsv+e5NBIYt7NSn/ECd5/CKQYM7fx41LA=
X-Gm-Gg: ASbGnctx/iflGWqp3zGcXbdC+eJzmHmF09ZVSuClMUfforsHyxzPZwAMu9SkJ2/iqG7
	B0K2paR4Z/bdXSlcp109+nLpGBBzAblKZBfrVgeaLTv9J3DqOUHNUPD7arq2TgFGqKDYcMgb70+
	+8aUvgZWZ0YsjlxDL55KtuapTmGWqkaXctzEfU//gAktit5tnR300LW/lZPnGfV+HcuPt3c9HqC
	kxIcO0gseCqD9FtXCyDPP+r1yhLcE9iqHFgwW05A8iOvF/QmcEoR5jM1glFcU+i3eX2537EYxQm
	sS5qaFs/DTcg5UGQPXv+r23uh/NCYpoVIoE=
X-Google-Smtp-Source: AGHT+IHtgCRg3cEC9ynCP8b9BrTpfWWisGdP5Lqy6poWA2choOHpYjzRsQlfJowyG+t+SfAeDFpVgw==
X-Received: by 2002:a05:600c:1d1d:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-43bd20b4d27mr7565305e9.6.1741137533781;
        Tue, 04 Mar 2025 17:18:53 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd435cd8csm1759255e9.40.2025.03.04.17.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 17:18:53 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Introduce arena spin lock
Date: Tue,  4 Mar 2025 17:18:48 -0800
Message-ID: <20250305011849.1168917-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305011849.1168917-1-memxor@gmail.com>
References: <20250305011849.1168917-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21945; h=from:subject; bh=fuRAPXXWNXY9P79EZsVYgtdQRcsCPkjZ2HuppsyrE+Y=; b=owEBbAKT/ZANAwAIAUzgyIZIvxHKAcsmYgBnx6ZyICAxR7bfpA8ilXpQBLN8bIaUsVtgEmJwvU8d pUDG0qOJAjIEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8emcgAKCRBM4MiGSL8RyjJpD/ jBJC1q979pCXF1SqVL6F34UZ9iOkL4msgZY0NDgsVylYPvtSYqxgSR9U3m3JfFiIfDCO0KuhP7GkIz OzED0mOfqDLs1afC+d+J7ClcidtzlDeSZisSoJrTIXX6j4M08gN/AWHtkB2bMu1eMI7Y16ZVAcs/Q+ ernSoqzJUYNkc4mBrBXq4/EtNE5s1Ez+ioqpzV69VsfLHpV+SQ6129l1GhvS0d4PIV6pD4gQl3FK3c mnQGkUcl/SC0okkQFczC9it0TMMz1xujy5YxvoW0ZcZHjOkp9DuYyqMLstfeiy3CCs8c8PYAFk2T1F ftLaMonhOh3oMTSwJzRUEW5xiLQOnLUT4NIgrBc4+7VsvypQSepL0U9vH9q372R7imgvh3uvyJhOIa UkrrfvmgSCwkzEUtZayGHuXFRdc25BG4xUt6bvTo6nBOhVfmGFBg+jupnsvIjhYlH54EDVUPcmgL48 5nO5MMse0/5KbtnQetPLZuJ4NWRepy3e3ock9qjzsESfRpbpdJQT85L1zYxUEbAxKDe3ciNpTpuLjD FmBRoztVk9J5Tq4P/LeM95+j7lxpeKWd9l6+16auvOEAM3QxpekDIaSDrgTEiUgDdriTvnxYWV8cK0 ahhTDBOZ+9XWY3RNeKcukFj6w81d+gnbMf/as3mefntPiGRtnSFemCn7IA
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
cond_break_label macro to return an error. Only 1024 NR_CPUs are
supported.

We need to allocate 1025 qnodes, one more than NR_CPUs, since if libbpf
maps the qnode global variable starting at the first page of the arena,
and the lower 32-bits are zeroed for the base address, the first node
for CPU 0 will become indistinguishable from a NULL pointer, leading to
spurious timeouts and failures.

Note that the slow path is a global function, hence the verifier doesn't
know the return value's precision. The recommended way of usage is to
always test against zero for success, and not ret < 0 for error, as the
verifier would assume ret > 0 has not been accounted for.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/bpf_arena_spin_lock.h       | 505 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_atomic.h      | 132 +++++
 2 files changed, 637 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_spin_lock.h
 create mode 100644 tools/testing/selftests/bpf/bpf_atomic.h

diff --git a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
new file mode 100644
index 000000000000..cc7de78e0373
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#ifndef BPF_ARENA_SPIN_LOCK_H
+#define BPF_ARENA_SPIN_LOCK_H
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_atomic.h"
+
+#define arch_mcs_spin_lock_contended_label(l, label) smp_cond_load_acquire_label(l, VAL, label)
+#define arch_mcs_spin_unlock_contended(l) smp_store_release((l), 1)
+
+#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+
+#define EBUSY 16
+#define EOPNOTSUPP 95
+#define ETIMEDOUT 110
+
+#ifndef __arena
+#define __arena __attribute__((address_space(1)))
+#endif
+
+extern unsigned long CONFIG_NR_CPUS __kconfig;
+
+#define arena_spinlock_t struct qspinlock
+/* FIXME: Using typedef causes CO-RE relocation error */
+/* typedef struct qspinlock arena_spinlock_t; */
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
+#define likely(x) __builtin_expect(!!(x), 1)
+#define unlikely(x) __builtin_expect(!!(x), 0)
+
+/*
+ * We always index with + 1, in case we unfortunately place the qnodes at
+ * pg_offset=0 and then CPU 0's qnodes is indistinguishable from NULL if lower
+ * 32-bits of the node pointer are 0.
+ */
+struct arena_qnode __arena qnodes[_Q_MAX_CPUS + 1][_Q_MAX_NODES];
+
+static inline u32 encode_tail(int cpu, int idx)
+{
+	u32 tail;
+
+	tail  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
+	tail |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */
+
+	return tail;
+}
+
+static inline struct arena_mcs_spinlock __arena *decode_tail(u32 tail)
+{
+	u32 cpu = (tail >> _Q_TAIL_CPU_OFFSET) - 1;
+	u32 idx = (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;
+
+	/* See comments over definition of qnodes for the + 1. */
+	if (likely(idx < _Q_MAX_NODES && cpu < _Q_MAX_CPUS))
+		return &qnodes[cpu + 1][idx].mcs;
+	bpf_printk("RUNTIME ERROR: %s idx=%u and cpu=%u are out-of-bounds!!!", __func__, idx, cpu);
+	return NULL;
+}
+
+static inline
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
+static __always_inline u32 xchg_tail(arena_spinlock_t __arena *lock, u32 tail)
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
+		/* These loops are not expected to stall, but we still need to
+		 * prove to the verifier they will terminate eventually.
+		 */
+		cond_break_label(out);
+	} while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
+
+	return old;
+out:
+	bpf_printk("RUNTIME ERROR: %s unexpected cond_break exit!!!", __func__);
+	return old;
+}
+
+/**
+ * clear_pending - clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,* -> *,0,*
+ */
+static __always_inline void clear_pending(arena_spinlock_t __arena *lock)
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
+static __always_inline void clear_pending_set_locked(arena_spinlock_t __arena *lock)
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
+static __always_inline void set_locked(arena_spinlock_t __arena *lock)
+{
+	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+}
+
+static __always_inline
+u32 arena_fetch_set_pending_acquire(arena_spinlock_t __arena *lock)
+{
+	u32 old, new;
+
+	old = atomic_read(&lock->val);
+	do {
+		new = old | _Q_PENDING_VAL;
+		/*
+		 * These loops are not expected to stall, but we still need to
+		 * prove to the verifier they will terminate eventually.
+		 */
+		cond_break_label(out);
+	} while (!atomic_try_cmpxchg_acquire(&lock->val, &old, new));
+
+	return old;
+out:
+	bpf_printk("RUNTIME ERROR: %s unexpected cond_break exit!!!", __func__);
+	return old;
+}
+
+/**
+ * arena_spin_trylock - try to acquire the queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ * Return: 1 if lock acquired, 0 if failed
+ */
+static __always_inline int arena_spin_trylock(arena_spinlock_t __arena *lock)
+{
+	int val = atomic_read(&lock->val);
+
+	if (unlikely(val))
+		return 0;
+
+	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
+}
+
+__noinline
+int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock, u32 val)
+{
+	struct arena_mcs_spinlock __arena *prev, *next, *node0, *node;
+	int ret = -ETIMEDOUT;
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
+		val = atomic_cond_read_relaxed_label(&lock->val,
+						     (VAL != _Q_PENDING_VAL) || !cnt--,
+						     release_err);
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
+	val = arena_fetch_set_pending_acquire(lock);
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
+		smp_cond_load_acquire_label(&lock->locked, !VAL, release_err);
+
+	/*
+	 * take ownership and clear the pending bit.
+	 *
+	 * 0,1,0 -> 0,0,1
+	 */
+	clear_pending_set_locked(lock);
+	return 0;
+
+	/*
+	 * End of pending bit optimistic spinning and beginning of MCS
+	 * queuing.
+	 */
+queue:
+	/* See comments over definition of qnodes for the + 1. */
+	node0 = &(qnodes[bpf_get_smp_processor_id() + 1])[0].mcs;
+	idx = node0->count++;
+	tail = encode_tail(bpf_get_smp_processor_id(), idx);
+
+	/*
+	 * 4 nodes are allocated based on the assumption that there will not be
+	 * nested NMIs taking spinlocks. That may not be true in some
+	 * architectures even though the chance of needing more than 4 nodes
+	 * will still be extremely unlikely. When that happens, we simply return
+	 * an error. Original qspinlock has a trylock fallback in this case.
+	 */
+	if (unlikely(idx >= _Q_MAX_NODES)) {
+		ret = -EBUSY;
+		goto release_node_err;
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
+	if (arena_spin_trylock(lock))
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
+		prev = decode_tail(old);
+
+		/* Link @node into the waitqueue. */
+		WRITE_ONCE(prev->next, node);
+
+		arch_mcs_spin_lock_contended_label(&node->locked, release_node_err);
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
+	val = atomic_cond_read_acquire_label(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					     release_node_err);
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
+		next = smp_cond_load_relaxed_label(&node->next, (VAL), release_node_err);
+
+	arch_mcs_spin_unlock_contended(&next->locked);
+
+release:;
+	/*
+	 * release the node
+	 *
+	 * Doing a normal dec vs this_cpu_dec is fine. An upper context always
+	 * decrements count it incremented before returning, thus we're fine.
+	 * For contexts interrupting us, they either observe our dec or not.
+	 * Just ensure the compiler doesn't reorder this statement, as a
+	 * this_cpu_dec implicitly implied that.
+	 */
+	barrier();
+	node0->count--;
+	return 0;
+release_node_err:
+	barrier();
+	node0->count--;
+	goto release_err;
+release_err:
+	return ret;
+}
+
+/**
+ * arena_spin_lock - acquire a queued spinlock
+ * @lock: Pointer to queued spinlock structure
+ *
+ * The return value _must_ be tested against zero for success.
+ * On error, returned value will be negative.
+ */
+static __always_inline int arena_spin_lock(arena_spinlock_t __arena *lock)
+{
+	int val = 0;
+
+	if (CONFIG_NR_CPUS > 1024)
+		return -EOPNOTSUPP;
+
+	bpf_preempt_disable();
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
+		return 0;
+
+	val = arena_spin_lock_slowpath(lock, val);
+	/* FIXME: bpf_assert_range(-MAX_ERRNO, 0) once we have it working for all cases. */
+	if (val)
+		bpf_preempt_enable();
+	return val;
+}
+
+/**
+ * arena_spin_unlock - release a queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ */
+static __always_inline void arena_spin_unlock(arena_spinlock_t __arena *lock)
+{
+	/*
+	 * unlock() needs release semantics:
+	 */
+	smp_store_release(&lock->locked, 0);
+	bpf_preempt_enable();
+}
+
+#define arena_spin_lock_irqsave(lock, flags)             \
+	({                                               \
+		int __ret;                               \
+		bpf_local_irq_save(&(flags));            \
+		__ret = arena_spin_lock((lock));         \
+		if (__ret)                               \
+			bpf_local_irq_restore(&(flags)); \
+		(__ret);                                 \
+	})
+
+#define arena_spin_unlock_irqrestore(lock, flags) \
+	({                                        \
+		arena_spin_unlock((lock));        \
+		bpf_local_irq_restore(&(flags));  \
+	})
+
+#endif
+
+#endif /* BPF_ARENA_SPIN_LOCK_H */
diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
new file mode 100644
index 000000000000..06defb9e050d
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_atomic.h
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#ifndef BPF_ATOMIC_H
+#define BPF_ATOMIC_H
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+
+extern bool CONFIG_X86_64 __kconfig __weak;
+
+#define __scalar_type_to_expr_cases(type) \
+	unsigned type : (unsigned type)0, signed type : (signed type)0
+/*
+ * This is lifted from __unqual_scalar_typeof in the kernel (which is used to
+ * lose const qualifier etc.), but adapted to also cover pointers. It is
+ * necessary because we ascertain type to create local variables in macros
+ * below, but for pointers with __arena tag, we'll ascertain the underlying type
+ * with the tag, causing a compilation error (as local variables that are not
+ * pointers may not have __arena tag). This trick allows losing the qualifier.
+ */
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
+/* No-op for BPF */
+#define cpu_relax() ({})
+
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
+
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
+
+#define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
+
+#define try_cmpxchg(p, pold, new)                                 \
+	({                                                        \
+		__unqual_typeof(*(pold)) __o = *(pold);           \
+		__unqual_typeof(*(p)) __r = cmpxchg(p, __o, new); \
+		if (__r != __o)                                   \
+			*(pold) = __r;                            \
+		__r == __o;                                       \
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
+#define smp_cond_load_relaxed_label(p, cond_expr, label)                \
+	({                                                              \
+		typeof(p) __ptr = (p);                                  \
+		__unqual_typeof(*(p)) VAL;                              \
+		for (;;) {                                              \
+			VAL = (__unqual_typeof(*(p)))READ_ONCE(*__ptr); \
+			if (cond_expr)                                  \
+				break;                                  \
+			cond_break_label(label);			\
+			cpu_relax();                                    \
+		}                                                       \
+		(typeof(*(p)))VAL;                                      \
+	})
+
+#define smp_cond_load_acquire_label(p, cond_expr, label)                  \
+	({                                                                \
+		__unqual_typeof(*p) __val =                               \
+			smp_cond_load_relaxed_label(p, cond_expr, label); \
+		smp_acquire__after_ctrl_dep();                            \
+		(typeof(*(p)))__val;                                      \
+	})
+
+#define atomic_read(p) READ_ONCE((p)->counter)
+
+#define atomic_cond_read_relaxed_label(p, cond_expr, label) \
+	smp_cond_load_relaxed_label(&(p)->counter, cond_expr, label)
+
+#define atomic_cond_read_acquire_label(p, cond_expr, label) \
+	smp_cond_load_acquire_label(&(p)->counter, cond_expr, label)
+
+#define atomic_try_cmpxchg_relaxed(p, pold, new) \
+	try_cmpxchg_relaxed(&(p)->counter, pold, new)
+
+#define atomic_try_cmpxchg_acquire(p, pold, new) \
+	try_cmpxchg_acquire(&(p)->counter, pold, new)
+
+#endif /* BPF_ATOMIC_H */
-- 
2.47.1


