Return-Path: <bpf+bounces-50636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2919A2A660
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69248167F3E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85853228CA9;
	Thu,  6 Feb 2025 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8aUoMTM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA7227B87;
	Thu,  6 Feb 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839284; cv=none; b=U23WkA0zalzEGbXI6aw4NXTdZ5a6BVZ05OOxo/g56jl+UX+DmPP55zUHIw5vYCA9vKM+HxL/w12pNFOln7SBwinby9JA12K4VK+38C3Cnbuy0zfLJI7QvAZIMDNewYazhkl1zhhR3Nu7xV2LjRKvzZMil9ejmL2ji9nA6eMNkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839284; c=relaxed/simple;
	bh=eKJ3qxGBtRJg8l1rvSHjaQtIHqaeLQcTbgGFSWnocak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKqUxPlXO3u71nrRChPSDywIcX+MKSFtsi56OmyENAdvlVJD8B1fHFjLT8ypCD0KV4SoAB7tN/XvtV9D5tls9Wc2JwV1a2V02vZbzF44rDK6yutBJTrsYu67wa5ezkwhdBanntq/2eV0KoX7QtQqzzDRBz/oY5jGMbd1qtFFvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8aUoMTM; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4363ae65100so8236495e9.0;
        Thu, 06 Feb 2025 02:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839280; x=1739444080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgmvOyDRE/uHdGDx6ezBHiwZ8Zmst4a3Z/7igl9yl54=;
        b=i8aUoMTMKRszuPUKf+cRTT3Mk0WCcwI6ZBkM8LMlXWUkPmnq3Z7mVZf1bJGMQ7DGzU
         gYEINJDCi+gqLVWtMplnGt9SVb/n2/r2Ye8IIK5UOBVAWpuB12yCRiDxCmmqrtB1+Zrz
         DCeG9xEXcJZAX2fn7u82cnopiDajWJv/FmPdZpwMrDg7/9ZtYSWS0KNqR8VnXumZiLin
         SJwGP7oQP5E7hK8Ta+6gPccb4srleANU+wAiCex2zt63oT9G3QCcMeh2TVjzBxNZHuno
         ZGLlkjHz6KQq4xcVZ8pWdc39KN3KAMx39XlL95FjImQzpBrGjBxKeLW6OGGJZhC4cmVy
         op1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839280; x=1739444080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgmvOyDRE/uHdGDx6ezBHiwZ8Zmst4a3Z/7igl9yl54=;
        b=HmhCqKSuQA7I/HkotO15bDh7qASL99cEeAGaO0TdPsufWo9dKEtCJKcsuxETRjR5y4
         5M0nmHoH74w9DPY+0SGEsv72OUeUp2wne2Uf8PIyKCDecUMW/IAY/42pKlOmm4rLOEb8
         OyeuMx8cl8MDjQBVHWOixqpXLP+jLcVkUDV4Zub4OYo9Nn3jFybk/k6s+th/rgctU5Nh
         N+oxlbMzLSogMdLiXy89rmEZiJG7hQknVEGrEhPhun5cpLLeXxFSBKXIPf/RrGhURabf
         bi92TK7OydzdAd3kGmHhDoOYur3kjMSU3B3Z/i4RB8Ujj/OCAFuQg1A9vOa4s3JUhYGy
         E0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUuDzJSBGlJBl0sbpzdgIWeQ88MzabQPCj0FsgNzzOzMdcmi5D1E02U/egTYxEwju5x/ndA6cwHCb6EeoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKxoQ26QU6h8gf/NKbMM3tgDWBxZIeuoSc5pXpmsoWhsiTAvgE
	mBcZURVTu4hLsacYKLZRtLcbsEnJ5knMtKwr451nCC1Ktx7x4+crkjPzuIfcKGA=
X-Gm-Gg: ASbGnctUMur35U/pQD48Th95k5thm43GiZ3tL3FmZhB/vnHxpVYumVsv8187JySfppB
	6Ak61HogfZ77xuaWjcfJt2td4V8/xw/SjkvG25tVOfFMAHWSkkAhb9bU/cmb1TwddORG9+tXfXs
	642MEhDFKd5h6/LPhsId4U/kVuXqG2loBnaYfQAfJMp+LNwPzPFNre2cC990d7nFa1ELunoXlUO
	N+IOAMJeS8c/R1GndRQpXT0TSGcYsBCW7hX5uqVNpJV8OLGznr0EVRTY7K4n8GjT+yMWYkBds8B
	4kM37A==
X-Google-Smtp-Source: AGHT+IF4f8Xm3MmGWzddNVFfOdt5/pxOK6cPOqeFWXHyrZxzL6gB3MirVU0RpJy3SYCQ5MPv9d7ldg==
X-Received: by 2002:a05:600c:3593:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-4390d42f849mr64907365e9.5.1738839279263;
        Thu, 06 Feb 2025 02:54:39 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:20::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd5c87csm1439525f8f.52.2025.02.06.02.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:38 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 02/26] locking: Move common qspinlock helpers to a private header
Date: Thu,  6 Feb 2025 02:54:10 -0800
Message-ID: <20250206105435.2159977-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13562; h=from:subject; bh=eKJ3qxGBtRJg8l1rvSHjaQtIHqaeLQcTbgGFSWnocak=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRkkVfZqT1tCitfFNFTby5Hz/Q0Ls5KtoFEDTCL cZHH7UOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZAAKCRBM4MiGSL8RylRQD/ 9ZckUJptWve6Ivsaj0tCRlXmeXvXakYFfReqoU4TTSiK5e60c9zMXr1PSHiloHlftlQqfuKi7ug6yx A0bUp3hubkSGlTfDSdMPwLh1AN2D0QpPIKuW9AIo5mw5fag+zRMjgwdjsh3o2biZZ4JsC36jA+tvRV OhywUPmmoZL/U7GKGzWmptqXq4iD7oAmPhyHSIyZ80efwrSDnwF8UIzoX8wR8vqgwUPSp3g3TAgdqS Wu+LKgl9hNtbykaP4Jj433O5chD603DDAL+C0COzSBRTNaFTRqqXx3o/3rvGoEDspvDUhm+uXtQJyl AHG62uLsNo3EyObbRiK6pLo/hjsdzLmLnWdfJb2NV9sJPp2VA5FxIiDCkL+P/08d6XoTHUePanJNRI p2OhTqrJFD4fN/JDiNEwhFAcdlvwcrSZV/qDLoUrrD0UYVuywjxrranVRZz6bQyIV9JZv/P8i0TkzE w1DQVyyoWScGq6wi5NLOun+C1IdPnB/k7AISjvxU+vTO7bhPWcKARMgbyFTCw+uBqNq614OwvBHiR1 SktvlKEmTFENUpURQ5Kkx8YOM8Bu1bLOunw6V1hyLl9WU5VH5WgZ2AhT3MLH8H1SixfIzevgMLkfIN BLB2b1rHlEnEgsNDOx3qTtgKlgKaHmaveMw+6M64H8QDFPh3iV10yEj7kN0A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Move qspinlock helper functions that encode, decode tail word, set and
clear the pending and locked bits, and other miscellaneous definitions
and macros to a private header. To this end, create a qspinlock.h header
file in kernel/locking. Subsequent commits will introduce a modified
qspinlock slow path function, thus moving shared code to a private
header will help minimize unnecessary code duplication.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/qspinlock.c | 193 +----------------------------------
 kernel/locking/qspinlock.h | 200 +++++++++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+), 188 deletions(-)
 create mode 100644 kernel/locking/qspinlock.h

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 7d96bed718e4..af8d122bb649 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -25,8 +25,9 @@
 #include <trace/events/lock.h>
 
 /*
- * Include queued spinlock statistics code
+ * Include queued spinlock definitions and statistics code
  */
+#include "qspinlock.h"
 #include "qspinlock_stat.h"
 
 /*
@@ -67,36 +68,6 @@
  */
 
 #include "mcs_spinlock.h"
-#define MAX_NODES	4
-
-/*
- * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
- * size and four of them will fit nicely in one 64-byte cacheline. For
- * pvqspinlock, however, we need more space for extra data. To accommodate
- * that, we insert two more long words to pad it up to 32 bytes. IOW, only
- * two of them can fit in a cacheline in this case. That is OK as it is rare
- * to have more than 2 levels of slowpath nesting in actual use. We don't
- * want to penalize pvqspinlocks to optimize for a rare case in native
- * qspinlocks.
- */
-struct qnode {
-	struct mcs_spinlock mcs;
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-	long reserved[2];
-#endif
-};
-
-/*
- * The pending bit spinning loop count.
- * This heuristic is used to limit the number of lockword accesses
- * made by atomic_cond_read_relaxed when waiting for the lock to
- * transition out of the "== _Q_PENDING_VAL" state. We don't spin
- * indefinitely because there's no guarantee that we'll make forward
- * progress.
- */
-#ifndef _Q_PENDING_LOOPS
-#define _Q_PENDING_LOOPS	1
-#endif
 
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
@@ -106,161 +77,7 @@ struct qnode {
  *
  * PV doubles the storage and uses the second cacheline for PV state.
  */
-static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
-
-/*
- * We must be able to distinguish between no-tail and the tail at 0:0,
- * therefore increment the cpu number by one.
- */
-
-static inline __pure u32 encode_tail(int cpu, int idx)
-{
-	u32 tail;
-
-	tail  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
-	tail |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */
-
-	return tail;
-}
-
-static inline __pure struct mcs_spinlock *decode_tail(u32 tail)
-{
-	int cpu = (tail >> _Q_TAIL_CPU_OFFSET) - 1;
-	int idx = (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;
-
-	return per_cpu_ptr(&qnodes[idx].mcs, cpu);
-}
-
-static inline __pure
-struct mcs_spinlock *grab_mcs_node(struct mcs_spinlock *base, int idx)
-{
-	return &((struct qnode *)base + idx)->mcs;
-}
-
-#define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
-
-#if _Q_PENDING_BITS == 8
-/**
- * clear_pending - clear the pending bit.
- * @lock: Pointer to queued spinlock structure
- *
- * *,1,* -> *,0,*
- */
-static __always_inline void clear_pending(struct qspinlock *lock)
-{
-	WRITE_ONCE(lock->pending, 0);
-}
-
-/**
- * clear_pending_set_locked - take ownership and clear the pending bit.
- * @lock: Pointer to queued spinlock structure
- *
- * *,1,0 -> *,0,1
- *
- * Lock stealing is not allowed if this function is used.
- */
-static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
-{
-	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
-}
-
-/*
- * xchg_tail - Put in the new queue tail code word & retrieve previous one
- * @lock : Pointer to queued spinlock structure
- * @tail : The new queue tail code word
- * Return: The previous queue tail code word
- *
- * xchg(lock, tail), which heads an address dependency
- *
- * p,*,* -> n,*,* ; prev = xchg(lock, node)
- */
-static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
-{
-	/*
-	 * We can use relaxed semantics since the caller ensures that the
-	 * MCS node is properly initialized before updating the tail.
-	 */
-	return (u32)xchg_relaxed(&lock->tail,
-				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
-}
-
-#else /* _Q_PENDING_BITS == 8 */
-
-/**
- * clear_pending - clear the pending bit.
- * @lock: Pointer to queued spinlock structure
- *
- * *,1,* -> *,0,*
- */
-static __always_inline void clear_pending(struct qspinlock *lock)
-{
-	atomic_andnot(_Q_PENDING_VAL, &lock->val);
-}
-
-/**
- * clear_pending_set_locked - take ownership and clear the pending bit.
- * @lock: Pointer to queued spinlock structure
- *
- * *,1,0 -> *,0,1
- */
-static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
-{
-	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
-}
-
-/**
- * xchg_tail - Put in the new queue tail code word & retrieve previous one
- * @lock : Pointer to queued spinlock structure
- * @tail : The new queue tail code word
- * Return: The previous queue tail code word
- *
- * xchg(lock, tail)
- *
- * p,*,* -> n,*,* ; prev = xchg(lock, node)
- */
-static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
-{
-	u32 old, new;
-
-	old = atomic_read(&lock->val);
-	do {
-		new = (old & _Q_LOCKED_PENDING_MASK) | tail;
-		/*
-		 * We can use relaxed semantics since the caller ensures that
-		 * the MCS node is properly initialized before updating the
-		 * tail.
-		 */
-	} while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
-
-	return old;
-}
-#endif /* _Q_PENDING_BITS == 8 */
-
-/**
- * queued_fetch_set_pending_acquire - fetch the whole lock value and set pending
- * @lock : Pointer to queued spinlock structure
- * Return: The previous lock value
- *
- * *,*,* -> *,1,*
- */
-#ifndef queued_fetch_set_pending_acquire
-static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
-{
-	return atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
-}
-#endif
-
-/**
- * set_locked - Set the lock bit and own the lock
- * @lock: Pointer to queued spinlock structure
- *
- * *,*,0 -> *,0,1
- */
-static __always_inline void set_locked(struct qspinlock *lock)
-{
-	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
-}
-
+static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[_Q_MAX_NODES]);
 
 /*
  * Generate the native code for queued_spin_unlock_slowpath(); provide NOPs for
@@ -410,7 +227,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * any MCS node. This is not the most elegant solution, but is
 	 * simple enough.
 	 */
-	if (unlikely(idx >= MAX_NODES)) {
+	if (unlikely(idx >= _Q_MAX_NODES)) {
 		lockevent_inc(lock_no_node);
 		while (!queued_spin_trylock(lock))
 			cpu_relax();
@@ -465,7 +282,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * head of the waitqueue.
 	 */
 	if (old & _Q_TAIL_MASK) {
-		prev = decode_tail(old);
+		prev = decode_tail(old, qnodes);
 
 		/* Link @node into the waitqueue. */
 		WRITE_ONCE(prev->next, node);
diff --git a/kernel/locking/qspinlock.h b/kernel/locking/qspinlock.h
new file mode 100644
index 000000000000..d4ceb9490365
--- /dev/null
+++ b/kernel/locking/qspinlock.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Queued spinlock defines
+ *
+ * This file contains macro definitions and functions shared between different
+ * qspinlock slow path implementations.
+ */
+#ifndef __LINUX_QSPINLOCK_H
+#define __LINUX_QSPINLOCK_H
+
+#include <asm-generic/percpu.h>
+#include <linux/percpu-defs.h>
+#include <asm-generic/qspinlock.h>
+#include <asm-generic/mcs_spinlock.h>
+
+#define _Q_MAX_NODES	4
+
+/*
+ * The pending bit spinning loop count.
+ * This heuristic is used to limit the number of lockword accesses
+ * made by atomic_cond_read_relaxed when waiting for the lock to
+ * transition out of the "== _Q_PENDING_VAL" state. We don't spin
+ * indefinitely because there's no guarantee that we'll make forward
+ * progress.
+ */
+#ifndef _Q_PENDING_LOOPS
+#define _Q_PENDING_LOOPS	1
+#endif
+
+/*
+ * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
+ * size and four of them will fit nicely in one 64-byte cacheline. For
+ * pvqspinlock, however, we need more space for extra data. To accommodate
+ * that, we insert two more long words to pad it up to 32 bytes. IOW, only
+ * two of them can fit in a cacheline in this case. That is OK as it is rare
+ * to have more than 2 levels of slowpath nesting in actual use. We don't
+ * want to penalize pvqspinlocks to optimize for a rare case in native
+ * qspinlocks.
+ */
+struct qnode {
+	struct mcs_spinlock mcs;
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+	long reserved[2];
+#endif
+};
+
+/*
+ * We must be able to distinguish between no-tail and the tail at 0:0,
+ * therefore increment the cpu number by one.
+ */
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
+static inline __pure struct mcs_spinlock *decode_tail(u32 tail, struct qnode *qnodes)
+{
+	int cpu = (tail >> _Q_TAIL_CPU_OFFSET) - 1;
+	int idx = (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;
+
+	return per_cpu_ptr(&qnodes[idx].mcs, cpu);
+}
+
+static inline __pure
+struct mcs_spinlock *grab_mcs_node(struct mcs_spinlock *base, int idx)
+{
+	return &((struct qnode *)base + idx)->mcs;
+}
+
+#define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
+
+#if _Q_PENDING_BITS == 8
+/**
+ * clear_pending - clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,* -> *,0,*
+ */
+static __always_inline void clear_pending(struct qspinlock *lock)
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
+static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
+{
+	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
+}
+
+/*
+ * xchg_tail - Put in the new queue tail code word & retrieve previous one
+ * @lock : Pointer to queued spinlock structure
+ * @tail : The new queue tail code word
+ * Return: The previous queue tail code word
+ *
+ * xchg(lock, tail), which heads an address dependency
+ *
+ * p,*,* -> n,*,* ; prev = xchg(lock, node)
+ */
+static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
+{
+	/*
+	 * We can use relaxed semantics since the caller ensures that the
+	 * MCS node is properly initialized before updating the tail.
+	 */
+	return (u32)xchg_relaxed(&lock->tail,
+				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
+}
+
+#else /* _Q_PENDING_BITS == 8 */
+
+/**
+ * clear_pending - clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,* -> *,0,*
+ */
+static __always_inline void clear_pending(struct qspinlock *lock)
+{
+	atomic_andnot(_Q_PENDING_VAL, &lock->val);
+}
+
+/**
+ * clear_pending_set_locked - take ownership and clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,0 -> *,0,1
+ */
+static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
+{
+	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
+}
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
+static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
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
+	} while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
+
+	return old;
+}
+#endif /* _Q_PENDING_BITS == 8 */
+
+/**
+ * queued_fetch_set_pending_acquire - fetch the whole lock value and set pending
+ * @lock : Pointer to queued spinlock structure
+ * Return: The previous lock value
+ *
+ * *,*,* -> *,1,*
+ */
+#ifndef queued_fetch_set_pending_acquire
+static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
+{
+	return atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+}
+#endif
+
+/**
+ * set_locked - Set the lock bit and own the lock
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,*,0 -> *,0,1
+ */
+static __always_inline void set_locked(struct qspinlock *lock)
+{
+	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+}
+
+#endif /* __LINUX_QSPINLOCK_H */
-- 
2.43.5


