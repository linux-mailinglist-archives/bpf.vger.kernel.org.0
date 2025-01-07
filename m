Return-Path: <bpf+bounces-48103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A25FA0416C
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218CE3A591C
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3091F37A4;
	Tue,  7 Jan 2025 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTc+7xnx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C701F2394;
	Tue,  7 Jan 2025 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258424; cv=none; b=aFiXhuwFrjVPt2AmjzWH15lj+82Y4bBB7YcqBucPXXs1u440/q9UolmM1351F5soMRsx9dauF7212+2EB/jmkASeBTXX3I3taGNQy7GuoBipypytjLPGQnpQNTeOVwjpkq1+4RPAD3YtfHiQ/+Uzwyry7osgBHy7fx8bRA9xmvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258424; c=relaxed/simple;
	bh=FYMfmdHhZVrUK2nS5jUp23jzoKxyU5CBSvGylajqNkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfEXWq3IT3CBYOeekHkLuTj/SE34GO262VbKir707yT+k+VnZr9okMurfSUSwreS4PwnM3zbIglp/OLoXsRU7nwLWJ24peVXeAUWNIBGEvcOSxllJNLeHWf+2MPLBdE1jp3jB0hF55w5KIidmD+F9c1JV7aGB7/p+bV53cB+Ia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTc+7xnx; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-436345cc17bso112745995e9.0;
        Tue, 07 Jan 2025 06:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258418; x=1736863218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/G/O/Zyw1wKL+61ZIf71iZUhSIiLpUYSgFpa1qeafC4=;
        b=KTc+7xnx7oNKlGPGbSlx7UIhFoMO3CvhsnLW90/gi6lhdthwfp1Y/qTwUqeOb8Qh1A
         NDW5zRj7YeZhlNZG4STPaXorNhG9QVRECW/wZRHRAzo9SKkvIVE7gX/iwnq+eTGa2MPV
         76FSvoVw1huLU7L6Ama7Kq2rHRF7Da/aTXeb4o8nqX2UQi9q9srmnWCEAUWEROLNYRzM
         PfyGjUfXreNFaW7/0DCXNYCVlvkHqnZXRwaJLKZFDbYIZG2ierE+YU72lNpmS2FTCNoL
         Zi0/ifNMrhj0bbZC/EDiryVOKZS8g1o/tJC/kwdOQQHGmZ+9VtFuat5mALPczTwrvZUs
         OVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258418; x=1736863218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/G/O/Zyw1wKL+61ZIf71iZUhSIiLpUYSgFpa1qeafC4=;
        b=dJQNmX2K4F+B5YA6K4KnPrUnOXkLEguNKycQEhSCF4SY543qQr3gSMRRSKPoIqgVAz
         ZWXCI2HvueWCrZ0fRcNw6Ym4OXZVZBQBYZtKZUuj1LFLwg/w0Y4D6pl/CnQSApw80dlR
         r3XczvjvZzQphhqKPMjujQb/VbFOSlvpxhM0PQ0lNkggBCd2wXXVq1q2Dr/dzIVhPP0E
         /xVA/i+w1B3jA563Bjc7ecCUs1GRA8WN1N6YoAs3I+AEhNpdxsEzW5JAPRdEzF1vRVXh
         FYam30Tg2t/Km4K1YQySI7C/sImbhsKs1tNP9GHnD9RJcfUji4uCbraAJXCzNr7RFtWD
         eyUg==
X-Forwarded-Encrypted: i=1; AJvYcCUWm3KH/YC6mg0D+t+dhSUyP2qPfQYP6p98zEs9Q7FqgYLB9T0Tzxwx7XEjTZd7aH8IBlh4hHGjH9iGVHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHpnxMejWhGNgRwufM1paoEv6g7ok4KRAFIAJQimw45vapgh6o
	qS5rDNnN4CfnF5ckQ5mpmndp6ya2XPMeX4shTQM56fW4hvvI+eiRY3rjMfiNKs0PtA==
X-Gm-Gg: ASbGncvoizOPBswutJimo/vaC1d897BNNs3BmZLso/UD5gSVG/eJ8d2ax81q7eZb0d0
	Hlf+IyCn5/15CPciHD7jDo/qJSxIy5VtswnKXFeZwV3rh6JX8ikzwj25bSCOaoUWMLPC1OhGWpp
	FZhkD5H8ad1Li20Zxwgt0MZGth9y+jf79D+9pKgGsEa8zO8h1O86qA/7GcQhF0C6G83yirwcgx+
	ydCZ3ti8WiO6aOOpq2LjLdTR508mToAPmohuFVOzQWvKw==
X-Google-Smtp-Source: AGHT+IFfNmCa4q1Cw/Nabmeuezx046sbsXS1QBQb4Zs8VpgAPwOpC7bZPZlcMjmk3wxOENIhaGFtSg==
X-Received: by 2002:a05:600c:4a83:b0:436:1aa6:b8ee with SMTP id 5b1f17b1804b1-4366d356735mr468444215e9.2.1736258416617;
        Tue, 07 Jan 2025 06:00:16 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436724169afsm547781515e9.25.2025.01.07.06.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:15 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 04/22] locking: Copy out qspinlock.c to rqspinlock.c
Date: Tue,  7 Jan 2025 05:59:46 -0800
Message-ID: <20250107140004.2732830-5-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14101; h=from:subject; bh=FYMfmdHhZVrUK2nS5jUp23jzoKxyU5CBSvGylajqNkU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCcgODNr0FrQcgKvek25PD/Kof6Fg8QSVqhrY4b ll0Vr4eJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnAAKCRBM4MiGSL8Ryv5DEA DAIXSccB3X4AanDh+WRHz1P5PHMtOszKz0APTb3q4iMSQL6TnfjO+QS46sr9Gwtgl/dRE44uFZDf81 79urGKxi8elUzCRUwVDrqpomlnhRvMYxkHunvLspKzCjh0XOUqkc2H9QYyJq33iomF62Uc9QqdN5So jTczCIf2YyxsithCzWT82EuuR+FyxvS/U9D4yxBRy3467IjlerK+Jwz1AoZ2xL6+QnLBU26pd7vFH4 7HSEKLQcuiXnnJ/vIBkSQsKIuxCrGBHDYa8MIbgOvVqthSZAUOtjUY81y9e5ZOn6WqQ+aprKaxCVep XGzPKVDoJiRWT5rnzHG4ZKCOEdge2qbMnUpyMZrKx6j2yw8ccatx8AKddw6zSVoVG8c8EDRS40tOzu LKoJOxNDqMf/ylWGsM73tF+GCQtOU4sc3JzWnWivFWeuvBq9+SCwsOubA7SffwLeSHzkXijIPqezBM FoHX3zIvZKO/eCBIkjTyQmR8WfG/TUK1Lzi1Ox6yNMABG7oul1MkG4/7G3C8yn8+KpNQHs2OURAULi 8tdWt1znwRu2phLKHHHKy4Go4+hNPSRLSRcP/gOTi2CuYo+s9+hnfZW7nQ04gnW3tVy4ySlEydwnP7 szOfiKUUmDi1j+lRWvilSlK/s+t3d4YK2Mztc3mTkfujHssSxIbzxjvWA8JA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

In preparation for introducing a new lock implementation, Resilient
Queued Spin Lock, or rqspinlock, we first begin our modifications by
using the existing qspinlock.c code as the base. Simply copy the code to
a new file and rename functions and variables from 'queued' to
'resilient_queued'.

This helps each subsequent commit in clearly showing how and where the
code is being changed. The only change after a literal copy in this
commit is renaming the functions where necessary.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/rqspinlock.c | 410 ++++++++++++++++++++++++++++++++++++
 1 file changed, 410 insertions(+)
 create mode 100644 kernel/locking/rqspinlock.c

diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
new file mode 100644
index 000000000000..caaa7c9bbc79
--- /dev/null
+++ b/kernel/locking/rqspinlock.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Resilient Queued Spin Lock
+ *
+ * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
+ * (C) Copyright 2013-2014,2018 Red Hat, Inc.
+ * (C) Copyright 2015 Intel Corp.
+ * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
+ *
+ * Authors: Waiman Long <longman@redhat.com>
+ *          Peter Zijlstra <peterz@infradead.org>
+ */
+
+#ifndef _GEN_PV_LOCK_SLOWPATH
+
+#include <linux/smp.h>
+#include <linux/bug.h>
+#include <linux/cpumask.h>
+#include <linux/percpu.h>
+#include <linux/hardirq.h>
+#include <linux/mutex.h>
+#include <linux/prefetch.h>
+#include <asm/byteorder.h>
+#include <asm/qspinlock.h>
+#include <trace/events/lock.h>
+
+/*
+ * Include queued spinlock definitions and statistics code
+ */
+#include "qspinlock.h"
+#include "qspinlock_stat.h"
+
+/*
+ * The basic principle of a queue-based spinlock can best be understood
+ * by studying a classic queue-based spinlock implementation called the
+ * MCS lock. A copy of the original MCS lock paper ("Algorithms for Scalable
+ * Synchronization on Shared-Memory Multiprocessors by Mellor-Crummey and
+ * Scott") is available at
+ *
+ * https://bugzilla.kernel.org/show_bug.cgi?id=206115
+ *
+ * This queued spinlock implementation is based on the MCS lock, however to
+ * make it fit the 4 bytes we assume spinlock_t to be, and preserve its
+ * existing API, we must modify it somehow.
+ *
+ * In particular; where the traditional MCS lock consists of a tail pointer
+ * (8 bytes) and needs the next pointer (another 8 bytes) of its own node to
+ * unlock the next pending (next->locked), we compress both these: {tail,
+ * next->locked} into a single u32 value.
+ *
+ * Since a spinlock disables recursion of its own context and there is a limit
+ * to the contexts that can nest; namely: task, softirq, hardirq, nmi. As there
+ * are at most 4 nesting levels, it can be encoded by a 2-bit number. Now
+ * we can encode the tail by combining the 2-bit nesting level with the cpu
+ * number. With one byte for the lock value and 3 bytes for the tail, only a
+ * 32-bit word is now needed. Even though we only need 1 bit for the lock,
+ * we extend it to a full byte to achieve better performance for architectures
+ * that support atomic byte write.
+ *
+ * We also change the first spinner to spin on the lock bit instead of its
+ * node; whereby avoiding the need to carry a node from lock to unlock, and
+ * preserving existing lock API. This also makes the unlock code simpler and
+ * faster.
+ *
+ * N.B. The current implementation only supports architectures that allow
+ *      atomic operations on smaller 8-bit and 16-bit data types.
+ *
+ */
+
+#include "mcs_spinlock.h"
+
+/*
+ * Per-CPU queue node structures; we can never have more than 4 nested
+ * contexts: task, softirq, hardirq, nmi.
+ *
+ * Exactly fits one 64-byte cacheline on a 64-bit architecture.
+ *
+ * PV doubles the storage and uses the second cacheline for PV state.
+ */
+static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[_Q_MAX_NODES]);
+
+/*
+ * Generate the native code for resilient_queued_spin_unlock_slowpath(); provide NOPs
+ * for all the PV callbacks.
+ */
+
+static __always_inline void __pv_init_node(struct mcs_spinlock *node) { }
+static __always_inline void __pv_wait_node(struct mcs_spinlock *node,
+					   struct mcs_spinlock *prev) { }
+static __always_inline void __pv_kick_node(struct qspinlock *lock,
+					   struct mcs_spinlock *node) { }
+static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
+						   struct mcs_spinlock *node)
+						   { return 0; }
+
+#define pv_enabled()		false
+
+#define pv_init_node		__pv_init_node
+#define pv_wait_node		__pv_wait_node
+#define pv_kick_node		__pv_kick_node
+#define pv_wait_head_or_lock	__pv_wait_head_or_lock
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#define resilient_queued_spin_lock_slowpath	native_resilient_queued_spin_lock_slowpath
+#endif
+
+#endif /* _GEN_PV_LOCK_SLOWPATH */
+
+/**
+ * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
+ * @lock: Pointer to queued spinlock structure
+ * @val: Current value of the queued spinlock 32-bit word
+ *
+ * (queue tail, pending bit, lock value)
+ *
+ *              fast     :    slow                                  :    unlock
+ *                       :                                          :
+ * uncontended  (0,0,0) -:--> (0,0,1) ------------------------------:--> (*,*,0)
+ *                       :       | ^--------.------.             /  :
+ *                       :       v           \      \            |  :
+ * pending               :    (0,1,1) +--> (0,1,0)   \           |  :
+ *                       :       | ^--'              |           |  :
+ *                       :       v                   |           |  :
+ * uncontended           :    (n,x,y) +--> (n,0,0) --'           |  :
+ *   queue               :       | ^--'                          |  :
+ *                       :       v                               |  :
+ * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
+ *   queue               :         ^--'                             :
+ */
+void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	struct mcs_spinlock *prev, *next, *node;
+	u32 old, tail;
+	int idx;
+
+	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
+
+	if (pv_enabled())
+		goto pv_queue;
+
+	if (virt_spin_lock(lock))
+		return;
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
+	lockevent_inc(lock_pending);
+	return;
+
+	/*
+	 * End of pending bit optimistic spinning and beginning of MCS
+	 * queuing.
+	 */
+queue:
+	lockevent_inc(lock_slowpath);
+pv_queue:
+	node = this_cpu_ptr(&qnodes[0].mcs);
+	idx = node->count++;
+	tail = encode_tail(smp_processor_id(), idx);
+
+	trace_contention_begin(lock, LCB_F_SPIN);
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
+		lockevent_inc(lock_no_node);
+		while (!queued_spin_trylock(lock))
+			cpu_relax();
+		goto release;
+	}
+
+	node = grab_mcs_node(node, idx);
+
+	/*
+	 * Keep counts of non-zero index values:
+	 */
+	lockevent_cond_inc(lock_use_node2 + idx - 1, idx);
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
+	pv_init_node(node);
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
+		prev = decode_tail(old, qnodes);
+
+		/* Link @node into the waitqueue. */
+		WRITE_ONCE(prev->next, node);
+
+		pv_wait_node(node, prev);
+		arch_mcs_spin_lock_contended(&node->locked);
+
+		/*
+		 * While waiting for the MCS lock, the next pointer may have
+		 * been set by another lock waiter. We optimistically load
+		 * the next pointer & prefetch the cacheline for writing
+		 * to reduce latency in the upcoming MCS unlock operation.
+		 */
+		next = READ_ONCE(node->next);
+		if (next)
+			prefetchw(next);
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
+	 *
+	 * The PV pv_wait_head_or_lock function, if active, will acquire
+	 * the lock and return a non-zero value. So we have to skip the
+	 * atomic_cond_read_acquire() call. As the next PV queue head hasn't
+	 * been designated yet, there is no way for the locked value to become
+	 * _Q_SLOW_VAL. So both the set_locked() and the
+	 * atomic_cmpxchg_relaxed() calls will be safe.
+	 *
+	 * If PV isn't active, 0 will be returned instead.
+	 *
+	 */
+	if ((val = pv_wait_head_or_lock(lock, node)))
+		goto locked;
+
+	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+
+locked:
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
+	pv_kick_node(lock, next);
+
+release:
+	trace_contention_end(lock, 0);
+
+	/*
+	 * release the node
+	 */
+	__this_cpu_dec(qnodes[0].mcs.count);
+}
+EXPORT_SYMBOL(resilient_queued_spin_lock_slowpath);
+
+/*
+ * Generate the paravirt code for resilient_queued_spin_unlock_slowpath().
+ */
+#if !defined(_GEN_PV_LOCK_SLOWPATH) && defined(CONFIG_PARAVIRT_SPINLOCKS)
+#define _GEN_PV_LOCK_SLOWPATH
+
+#undef  pv_enabled
+#define pv_enabled()	true
+
+#undef pv_init_node
+#undef pv_wait_node
+#undef pv_kick_node
+#undef pv_wait_head_or_lock
+
+#undef  resilient_queued_spin_lock_slowpath
+#define resilient_queued_spin_lock_slowpath	__pv_resilient_queued_spin_lock_slowpath
+
+#include "qspinlock_paravirt.h"
+#include "rqspinlock.c"
+
+bool nopvspin;
+static __init int parse_nopvspin(char *arg)
+{
+	nopvspin = true;
+	return 0;
+}
+early_param("nopvspin", parse_nopvspin);
+#endif
-- 
2.43.5


