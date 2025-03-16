Return-Path: <bpf+bounces-54117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D4BA63380
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176F93B2630
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935C6150997;
	Sun, 16 Mar 2025 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Puvy+a4x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EFB78F59;
	Sun, 16 Mar 2025 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097950; cv=none; b=fAMEUbi18tkaDxQYnaiCMhZswTC5ih361s5PNYF4yDZCjcvOlrCcpYn8vLxniAxlg8nM7mD2MSGZzt+zau13yjr8GR3yCEYCP4uHpe4SQqaSmyJHvvjhMKp/fAR/oIG19kpRMk2skcW/1L0c6Ys7F1gLCAXntd1/6iYzP5Wvt/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097950; c=relaxed/simple;
	bh=P6WGJXH3MTYAaWinW8eboOniR3lR+VqqyTTeTx9qsto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGCjwD72LORamIN2l/6tOEyl1KgyK9TU4yMmiNSD5VsXXNy5lKxzVsEikW9eveukQOr+0I4GgPZVsfnYvssdm+BxdI9IklPeV615ooUyv9ETFKB6WboRJfZSW7A78jZrkt6fsDJMiQjD6kU65e82WaCGHjGjSq8bE+eNJwUjNrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Puvy+a4x; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43d0618746bso7043075e9.2;
        Sat, 15 Mar 2025 21:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097946; x=1742702746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZDPUUfPIPI1I/a7znm6GXK798ScLYPYP7jBEkUfqo8=;
        b=Puvy+a4xQGqWSPyEV8f4lTBn0a0VNlW82JRkquVIMhEyZs3Mx40eFSGFhRkp/993Eu
         H553ETIx6NyUhyF7msov91teQq2RPUo7kiCekyHAseU8+fGiccQT83KuAU72eBeWqQJk
         njmjP9tvEU4ez6ATkHbZqwiWlafyb/BWFkxCtZe6Dn1JKB7t9HFckiq7WJrmf/EiEKNG
         ck6MH3H1jCga6A6B14qZRjKB2VYZpsGzhxv1L9TUYGm/K2j5HKNVepjNjEzGN5dSGenh
         aqwio8epSh/LaM6hpRDjVpu0P04oA7DtUbJB2sgqjiFe3hnPJlsyxidArgG9/yg5lVio
         qjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097946; x=1742702746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZDPUUfPIPI1I/a7znm6GXK798ScLYPYP7jBEkUfqo8=;
        b=srwCWJ6wGUz2q+OVOAS9RTE9MOjHQTz/5vbooLdi5iV7lZ+dn9gQY4chP6Vlq/t/dN
         GIrvTfmRFp7L+E3datQjM13fU4MM9zSi+JYR2ywwnLBd7zqqT8CAx9p+HGckvxS5asyo
         Fm9VEhiUQPLOfODOZdVVoN9Wrfoq7SvrzgWOEFK5FXFgfUoReo5HPFsIw2SkfCJWlD/9
         cqx5+PPio/kigvpSaE4G+Bk3hUuwGEI8S9k11MK0U9pZ1CWkx3G5XGk1cMK1QO9XYTJ5
         VaEX4kN7D9yTFVEDgQS/vYf/DchAOceByD+YivCW6YtNWhcku8uvUj0xmV2jr40KPFzp
         MhGA==
X-Forwarded-Encrypted: i=1; AJvYcCWMFyL+pxJj64GeXPbLuphlCnNeMjAKHY97axKNDhunW+hkp9E/X4i2dpWRtyFBISRcYaWC11r342dhJUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwodjvUhtQpHbD41UvaZ7q+aUQqKM+pcckSq7b1lzebDG5FOPO4
	EKdWWYsy6Acl23aSY+F9X78GmxgLmDCT0ZzT2rG2pd8EkBbICm2nYq4OlqswN9U=
X-Gm-Gg: ASbGncvYwGHCzP2JXJyO/gN+JEPMfU/e9ysW+WkkPRCoyzjNbv2upXFMeG+Y0RcyxrJ
	fc3SJVnQXGzFXyq0bsKVYEKHlRD8k/4y0Vt1gPwhWCbCnmYof/5lZa0hv/w+LfV5B1zZ9aAaNQV
	B/VRKi2sm0hCG88QjkdpKxvFeaJCcTz1fmnADsglT+uJy4I1DVYwqQfmLo3BpVmFjWOkEmeYs5l
	pG+/FQptPkzIlvDD55iksT0Ao+J5KTKmavxpuoYn57h9D5drt85WLg8ELgnuHkl8ULq2bBNgJ0D
	CEnFjfKNWEFDI8Dmj4PA4qbtZrAVCHT4RQ==
X-Google-Smtp-Source: AGHT+IGQENkXPWklAfMwa5tz+DJLXBtrNTvE3SYBajxXKIcQybZMggtMRpVOuyPRCt7uZr8imHSk7A==
X-Received: by 2002:adf:b511:0:b0:391:2bab:d2fd with SMTP id ffacd0b85a97d-3972086e264mr8092081f8f.37.1742097945494;
        Sat, 15 Mar 2025 21:05:45 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc4173sm67180505e9.20.2025.03.15.21.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 02/25] locking: Move common qspinlock helpers to a private header
Date: Sat, 15 Mar 2025 21:05:18 -0700
Message-ID: <20250316040541.108729-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13562; h=from:subject; bh=P6WGJXH3MTYAaWinW8eboOniR3lR+VqqyTTeTx9qsto=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3bMavRJM1KjtMppAwdQp0y3W5tnfeN56xhPQqP M1qWb9WJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN2wAKCRBM4MiGSL8RyreTD/ 4hVzlupZxK+mXnZN8k0vM3l0bfdhXAjegYO6MB4u/i91194228LN6CqHYReD3NrKgIY7Ue/lOtB5I8 pe6xiAeiXsjhwaxVw+eERShrPtXscrLjqVkPbhYaUpztghP5FcpkEiHrtf0Ovl1mV3AioL8+6Yud4a 855N6w8ocvsmrAjpnk7ZG3LlTm2/sqyQ/oSATI/ru4AY+Npf46eYKJPRQgZmUCHnTHycySFMZ/0O9y 4sZpNEcRRxc5gekVdr1W5QxoZ8exvppkXShi14L8nOQtu07c7MIvXstpHDOjpgBiUp2S2lEaoSxwuJ e3PMjaLA59vDdLR+cjJ0ONxQDARw/hXHz0hJZ0Y6KtzdJ6YHyQrMQyboYuuk68RN9xyKHCziUOmdLw 3QB7tcInWuPYX0gO9t5CjDcd5uYjUE+jBNb5ZVL3I9eLcaDXPaydxo37NnezFHGPOAKrgVt2OpwekQ 3Ydi+cTB2XWKxI8kABZ6BZPbW2LrCGMQbmad22jcHBlWed26N8fAYEIehmtbwSCE1AlSuX+jTR0jLw wIWBpXB9Tsrio20/PuUDpgbem6EDL2zHfZhFYrLtNTtbLpI8ttEz/hBqaeOveace8E/95yjGlAzosm me8B3MJ2NYiphGOt8QwTmzvU3+qxGbwXERjjtIv0R2DUcIe8gjvYD7V85LEg==
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
2.47.1


