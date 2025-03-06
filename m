Return-Path: <bpf+bounces-53449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F11DA54177
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 04:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534603AD985
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 03:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3ED199238;
	Thu,  6 Mar 2025 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePxt6uO5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A57EF09
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741233283; cv=none; b=Msd2fuzjyVGo/ZXJpKva6+7fxfqEqYYArR9uUbJb5Q+2PHtA4R6tktpTPc8n0bP2dgo9LlPGVPMZILWTjJ9SqqrOwvKMd45d10eH6U/lO5plt7i333upZFisapdGH/zfH4Mr+I3J1B4hIfvYALHZ+PdmoaVEtILSJVnPxtVPJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741233283; c=relaxed/simple;
	bh=7y3bziEk5aW4TVrKavcou1NKdDmw5vmUMlc/qgN/Tzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc0fPj3/gLNyoiWEZ1VaNCzkiqjFXGvwPmcJnc49xxWVjsVkfGFLcTD9Zs15k86uaJ7KhfFBR2uB9bPfQu3Gpu60XbMYAsA0NGsZ45ir8on/kAGEkv1eAgmC2Rlo/v3kwWeZbY0fgwR1t4W/KhL3KhBd5sA/TDg5bXEwSShhQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePxt6uO5; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-390e88caa4dso84120f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 19:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741233279; x=1741838079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvnBKYQ34nCkzRQCRLtGQvVyWjBivJj3FY7JzmBgYeg=;
        b=ePxt6uO5wMFAdKKMuwkW5SntJBhbKOv/1xrs5oGWWcPClE4r13F3W6S0Xuis8LSF3l
         pvBlG0mxk9SBBgdC0uW6yyP3XUGGzpYOzwvW3J5p3ANulun2FaRnP1VXhuLkdmiQ1h3i
         /xQdiYSYeApmaeYLaQkELa65N38zZ8yE3phvZTswRPmVm1EULFR/b2UDSbDtqBHzUpgf
         llSqOegy7nUoKGYQv7V5ilgJ4jTG9vITzVL0tWXSa4Nq0JF3J4NzTMWQdU+LyiNeMrRR
         13Prxu6gKow7r2nldgnA87/laUiLGFh48oaROy0NNLarrKDFkNmUuK6bt7fLW4cA9Eqe
         kRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741233279; x=1741838079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvnBKYQ34nCkzRQCRLtGQvVyWjBivJj3FY7JzmBgYeg=;
        b=hYvs9mDG4u+o4NdvKEVY9mtgGE5wBeY2HH1wsV6h/PG8QHunOpDDmj/BI1+las5BuW
         imvOHeHhzhWiWeuJURrCX7APsZDTLeaxdjidIv0os4sb3YF9Vsx+C/U18ONA5woTsAEN
         lrIDQTn0sOiEbF6Do1OTLWTe9rDWGIt7D525dfL+0/+EsCdblVAKLtUhQdGWaMyaapIT
         PPLer9+wLu7Phg/jsqEmJyFfVpDX+ivJxgcFxiZNUGdJuCG+zcIL3UAzgO8Tb8ImI57r
         PsGNqV9qBIyT+l+wn5Vj1GWYvfcUGVQC9P2sJHxghvHzFycwi2e2k7yqaHJy0w1/tAvT
         C6Jw==
X-Gm-Message-State: AOJu0YxdKddLEh3jduOzG0gqdN9Dua4XFvOWqX9DMM5/reYgY4FAfiJs
	tqARsGcgH+CLqI/c47anQMWihyBXIwpA8lXO/xv625W5ca7zpN5hdMD/pX/Nxco=
X-Gm-Gg: ASbGnctMnhIjtDBxLPM6741k8mVcj6h9jx7vAzX5Y7vXB/gKCtEvn1npZbSx8Ezk8o9
	oAmJFojBpC6g9/4pvkYkoJ9yYBo1gp5bXjsUy8CWSGVsMMMEWyGBWcbfmSmPyquIyzeAD5bHsst
	kV+RnWcTJsZIXgidWrBiQSFZ/DbpQI5sA6Uh+zIfRBjSYQ8GBm38xD3mRzj654s4K0/yKDN6a79
	ZYZ/5nr64kAItbmctWtTsaevDlK9CNR9X5zdPxqlgP3zPs8eq/RL3Tl5kEuXfGR9o4G2RuiAEmw
	pJPhFo0MW4pY5YhGjHxuYgSrsRf+dcySxQ==
X-Google-Smtp-Source: AGHT+IHhOunxcNVlf8826+TF/FEjT6inJ76eb4gYGegqYS9g7gzaqgkP+qpQDVDavubV/1JdkOAjSA==
X-Received: by 2002:a05:6000:1547:b0:391:22e2:cd21 with SMTP id ffacd0b85a97d-39122e2cfbamr4787463f8f.36.1741233278889;
        Wed, 05 Mar 2025 19:54:38 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102e01sm554426f8f.93.2025.03.05.19.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 19:54:38 -0800 (PST)
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
Subject: [PATCH bpf-next v5 2/3] selftests/bpf: Introduce arena spin lock
Date: Wed,  5 Mar 2025 19:54:30 -0800
Message-ID: <20250306035431.2186189-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306035431.2186189-1-memxor@gmail.com>
References: <20250306035431.2186189-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21948; h=from:subject; bh=7y3bziEk5aW4TVrKavcou1NKdDmw5vmUMlc/qgN/Tzs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnyRK/ltJunBtE3OeGUDHRHaqqeXim21sl282IAH2a 6TaU4YSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8kSvwAKCRBM4MiGSL8RyorxD/ 4uiVFn+zuantKoqmeFjhBT6Giw4CwC/utN/c/ZB55zzzMBhg+TLXoMQTjYB2S4FgZV5efbsCdzL3Qb 2o7P9rOPkb9M22sgsWJGe0C42ISl7JGs+8vrMmT/F8hKZ2/rswClF7Ud3b132EhVHboUxO07k8tYY6 ftnF+6mQ+IWtU6s8qn0n1+QaP81CBWUMOjh5sYCLHSA+PEzGDVyuELiz4vkS4EYpRHA9MdhJ9rilMl NaLmLc0/ExU9pPU8pqD9pjkgkvT4zajo0eLnOXErb7HC18h0WBh+bu8pY6J4bQTOtBC+pUTeEpj7KE OkU2tmjyWfz7jQ1dLhe8bjofEk6ix9AKnm7XgNmRioXGeT9hYN+6SJ7z1dJFFg6XwRkDpIjyKdKZO2 uwMB1FzpEoLgCHzUIpuUQEJ+20WFgCK/51Cf4F0gWB6QxFxjyA7dGHTc1IACMoZJ2KiAEdeZEZOXof XdBoy8gfQwV5ArzEZOwqUSlwzZhc7G+9loRPcegZneF6H6BhYMuH/weq5ccGw/cgIz2m0f83N0B2l7 4Jd1ohx+qrHVF0T5KAWz/nH+PbQeGmBUT+XVih6Gg/kYZj/JSnNYmfDJs2bktGRcjyo1xzTQMncn8F 4NYHSnJzLQIIem+bwn7Cqk2pjjnFQ+i2swm+naUITGA+nLzv1m8A25ViY2sQ==
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

Note that the slow path is a global function, hence the verifier doesn't
know the return value's precision. The recommended way of usage is to
always test against zero for success, and not ret < 0 for error, as the
verifier would assume ret > 0 has not been accounted for. Add comments
in the function documentation about this quirk.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/bpf_arena_spin_lock.h       | 512 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_atomic.h      | 140 +++++
 2 files changed, 652 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_spin_lock.h
 create mode 100644 tools/testing/selftests/bpf/bpf_atomic.h

diff --git a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
new file mode 100644
index 000000000000..3aca389ce424
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
@@ -0,0 +1,512 @@
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
+struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
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
+	return &qnodes[cpu][idx].mcs;
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
+	node0 = &(qnodes[bpf_get_smp_processor_id()])[0].mcs;
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
+ * On error, returned value will be negative.
+ * On success, zero is returned.
+ *
+ * The return value _must_ be tested against zero for success,
+ * instead of checking it against negative, for passing the
+ * BPF verifier.
+ *
+ * The user should do:
+ *	if (arena_spin_lock(...) != 0) // failure
+ *		or
+ *	if (arena_spin_lock(...) == 0) // success
+ *		or
+ *	if (arena_spin_lock(...)) // failure
+ *		or
+ *	if (!arena_spin_lock(...)) // success
+ * instead of:
+ *	if (arena_spin_lock(...) < 0) // failure
+ *
+ * The return value can still be inspected later.
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
index 000000000000..a9674e544322
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_atomic.h
@@ -0,0 +1,140 @@
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
+/*
+ * __unqual_typeof(x) - Declare an unqualified scalar type, leaving
+ *			non-scalar types unchanged,
+ *
+ * Prefer C11 _Generic for better compile-times and simpler code. Note: 'char'
+ * is not type-compatible with 'signed char', and we define a separate case.
+ *
+ * This is copied verbatim from kernel's include/linux/compiler_types.h, but
+ * with default expression (for pointers) changed from (x) to (typeof(x)0).
+ *
+ * This is because LLVM has a bug where for lvalue (x), it does not get rid of
+ * an extra address_space qualifier, but does in case of rvalue (typeof(x)0).
+ * Hence, for pointers, we need to create an rvalue expression to get the
+ * desired type. See https://github.com/llvm/llvm-project/issues/53400.
+ */
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
+		default: (typeof(x))0))
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
+			cond_break_label(label);                        \
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


