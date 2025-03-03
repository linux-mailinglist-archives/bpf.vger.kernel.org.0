Return-Path: <bpf+bounces-53071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8625EA4C50E
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9527AB173
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B2215160;
	Mon,  3 Mar 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiI5Fwmv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C472144B8;
	Mon,  3 Mar 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015397; cv=none; b=Z4WRHfkPFT3/oFVXT6rj+CArfhTj+JTzBcbOMEx88CD4e1pAyuDPMeRmFu7/b0OY7Gf39Mzq4WaaS4ktCK7VHzE55eLq/FfJSYBgqkd8uiZAJ2loThqJh6JxlbfngxKc2AwsE5rn2U6mrkXXg+RLzl4r0ThXDK/87cuNgfpGI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015397; c=relaxed/simple;
	bh=eKJ3qxGBtRJg8l1rvSHjaQtIHqaeLQcTbgGFSWnocak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzdtEkxaQbKvj4HmUSt24ItguLENV6gVtBU0hzIV6NA4xRHuifKk+9hlq891vUWkFl9KW0m1inF/hVk4F1PTUrBjs6DxCq93/KUulbvTtHDFBoYZza+agV1xWFoYfNzI11shN7rD7DUbrfhcAKeOmlqkdkNxanBmXCLHioZIH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiI5Fwmv; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2800697f8f.0;
        Mon, 03 Mar 2025 07:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015393; x=1741620193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgmvOyDRE/uHdGDx6ezBHiwZ8Zmst4a3Z/7igl9yl54=;
        b=ZiI5FwmvmJlS7OLfuaAkvdSj9VJomiPAso2WUwHXGLZIkgfXxDUI+E4hINbsMyiXy2
         NO10lb2PnqVcmmM6WdBWCbZycRwgr+Y1CZ5ecsKscmumYdyBEK6naUi+Rvijs4928WWv
         ak8z35fHd+IpITa3z+4pjctQ/Tbs8ExARrFHpEH6yLniHiw6f9tFVEUyMu1fCkkrvbEV
         657v8+wVL9D6pCngryTNKTAAm4kud4mw455KGcqDBr0DWsCtM0rtU+T9+3GB9YV5+kHk
         AzrC3RVoWdU0lXG5BC/PtS6spTH1iaQ04hL1C8aMcIIib+9rP5rCMwMfFD15fzOXMA7x
         nS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015393; x=1741620193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgmvOyDRE/uHdGDx6ezBHiwZ8Zmst4a3Z/7igl9yl54=;
        b=pG1BOb0V6zEFAWtfoK4UdUM9zWcvSIUN/3AQhgxKp9TDPTg5u8pV3aqyT5VHGzJ0Tx
         CLD7KcVGckeM05bRDxBXoSRMeHtIlys++IFeu58blj7+qmECzn6RC8TgPU4Nw7x2t0qe
         Fd++54iha21zbQabqQJM2fAAesBE3lZfo+s72G48oZ2vG5YqJxqg37b+29uijH44+vK9
         XQZxgNS62qrWjuetpP48nYfH/aVKeM7WfWEQNsKzTQ1nmp9NBLIKsA0/RCMsVlUmaM8d
         vnIaYir0+q226rAYPqcnk/08qD9lkCL/UoIY7vX7wYyjlHSoCdLKIeFzmPZXwy2McRxy
         uOwg==
X-Forwarded-Encrypted: i=1; AJvYcCV8UMZbhIH6frs2xiSona1bh6Rc4B8Gv7lp80EArOTZHIhmWXZjRGAS5gqFWsWiLPsRBVZa7qU+d6LaaTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHdWzhjqo5/OQvpeslVcijTwDKTqNR71ZNRcKxmQ46BgzEz5iA
	QMX7mdwtwWqZf8qRuD59CJnR3BZxQdi2Ct17BbOJz/0UVQDJIXpC2GHkPxyIZ3Y=
X-Gm-Gg: ASbGncvfNB29LGj7+UmIlZH3DdwkNCmOqK6Rg9sIzM1l2Yrge88lVn0TqSVWfvkb0L2
	5uyxY/2s8on8XPU4XClA3nA1mHms7/dHpksaSpBYIS78qx+XKP1UHNRXIV5LLfhjTDDr6kblmsj
	hc+24ZVBx+ncXIQO0fuOhXMVogfoZrmk+NPUmiWRhIQaFf99uqVEjKm/+UpCnVJDH/OEL29TU5I
	70SycISns9C8ZRCCpIyZvjkW+nWd3aXGR0jifba6RFXHtfKaklOJgsZUupBZVq79YPVquibZalN
	dT0KiySS6RiUNI2mt0nysT7bqjU8cCD6R5U=
X-Google-Smtp-Source: AGHT+IEZmbL4kTVe2++oKcRU5JQYI+CySPZk9bC17VESbEqwwtp816GvVhoQy61ssaTtOJsaTHaHDQ==
X-Received: by 2002:a5d:64a5:0:b0:391:b23:b318 with SMTP id ffacd0b85a97d-3910b23b573mr3648211f8f.41.1741015392642;
        Mon, 03 Mar 2025 07:23:12 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e486eea3sm14548017f8f.101.2025.03.03.07.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:12 -0800 (PST)
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
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 02/25] locking: Move common qspinlock helpers to a private header
Date: Mon,  3 Mar 2025 07:22:42 -0800
Message-ID: <20250303152305.3195648-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13562; h=from:subject; bh=eKJ3qxGBtRJg8l1rvSHjaQtIHqaeLQcTbgGFSWnocak=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWVkVfZqT1tCitfFNFTby5Hz/Q0Ls5KtoFEDTCL cZHH7UOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlQAKCRBM4MiGSL8RypysEA C3leDFcx+MonrV13UNP/a1KQjzZBifx/rS8N1isQIHzlulO71sBTAbTJDuZM6yq/0bU/qUs8hwXLq/ w8imvbbOhV0sg2v0XcsUu+Qqaji1dlaEl8+Yzo1SsBEL0NAFxDJtE2OgpBRNEITRSoUsbzwYGVJItt ptZni9OCm9cqgf2GOBiN2XXULRyhnYmdK/eUHMcHrEQvOy2rOdJNpf2dSxW8CcYd49oZaMAqF319OI 19D1ra8czLwFo1Y3MCrEQuT73bn0YZIwfZYdmwgoihZWMjvvZ6rNwRLzpDN5XJLhZLUZEK6pUn5Xpe GcTDtEFLciWRXU6QhN2gu0ZAm9XKtRaR4Hp5yOy3qf2tkMxt5L5ad1BnhyPm8drcY8LQPc/zB5fuIX t029FoAw1yTCn//bVcO6KrFEyGMCMgZ8/UtZpPrcIB70+R1GFk0CB/u0iyKykO1ee5ke5aVFFPZMsb KGBfAxmEcDwbj/LlC/q7xnfODH0cObC073WRxVzQMIOOBYdONvuAD5d1+YlWUOSAUNWrB8olMJS67I sIUraNIODLQ7Rw8YCl2Ekg1SRQA0pvBono+BLof7ZvXRM/L1GUVhc8kNk6XpOToWnQf5XX5OU35vVG 7APJ8S46OuAh06qCXM9teIlkPaNqlA0TdWqHhyfcftt9TvzHsXib5eD7UN6A==
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


