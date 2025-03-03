Return-Path: <bpf+bounces-53079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE464A4C500
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58408167FEF
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A3022ACC6;
	Mon,  3 Mar 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFavoeNh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFAF222561;
	Mon,  3 Mar 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015407; cv=none; b=bNOz72qgHO0tGr9LCQVcC5arudiuWlO4kof0aD1WzhZgyMFmVb6G48GlDpY7k+OYBVqY1/T2Ypr8k/CH56BhKmiKBsSxdTat1OAzZRtq3z7Py0QdbjDO6h6lXmZBmevWekAuYp9gYXjn0KLqgrxLNbca0hDKC4frVzoW0TPkU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015407; c=relaxed/simple;
	bh=/tO7WsHRnQ1y7o7jGLLRZ75jx2rvQksn4PRPhYxulGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk+bIZwCgE9cx/eIHy/CywQridyM3XpCeuqlSJaAr6pH/gguLuzepxJ5CfJyvHFAJ2f9RTaBk09RX8Ib4sk+R53LnZA0BtB6XajDuyAwqWqA8GjOX+8FHLPNArm92uuPq/7+OGACcIrm6lTwuKoH7cfAN++Uq4Lw2CXTnmWstXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFavoeNh; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so13968525e9.0;
        Mon, 03 Mar 2025 07:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015403; x=1741620203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdqbAA6BbOHNHxPeedO3e4MUz1jdw47Vp3CnPvreE48=;
        b=OFavoeNhctuNGFXzajlY/KtkiyyVB9NuSUcqtDkD6x/eS0XEWHjU9L1md4qwSYtlCE
         da7jDjhEQdFewBosMApe8VsmWp3SrPLHzN2LPJHO/4UAiua/+F3BHlAi3aSL49jBfc5O
         8YA+DnQCyquEBJlOfN6bhO/SZFurLherMLuihbJHZDgclYLJAc4rNoEPn+JQgQy0/D6G
         gS1s0DDw1+F6i2CuhbEKeQPxJ3NZpbDDzxHpjaNYr1SZEHJCwSuYIEMN3J24XEK89s78
         3/9HT/06G8RrfJ6yHveyQmrLHoIq46R0mGFj8p2jPXrovptNWYmreP0F9NfacFQuAr5e
         yKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015403; x=1741620203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdqbAA6BbOHNHxPeedO3e4MUz1jdw47Vp3CnPvreE48=;
        b=wTrXta+lFhMBBOXV/yLErsSBkh6sG4WJVUcESHk61auQI3/n292XD4R1pNkqFmVNAj
         mJGNXOVWTDKZMC55YMj6PYPsw47OaVFG/xLoi1Xvie7nSqvBg+NlMHPpOLyUD/9F9yGU
         D9Vrl1APZWh1UKlKJ8qjr9mMU2RMcAUDm9M+bJdImjKP6TdSAZ/msc0VDIekEoVKU96b
         H7exP2StUS3UxhA/YTon1nkAHN+wAvqUVuNCoCDWvqhodzH7hrteSdF77HVOtDRV/D3W
         7ZYvlhsNiaKrnL7MrvNlTlxR2yDXWAmbIXDg23ZrqxhXXqvefOrlmTLKvAo5nMofhl9g
         AICQ==
X-Forwarded-Encrypted: i=1; AJvYcCURYOT6mD+idXOSffOJ/8AIDqY/Llew4Anes9l5SL2pFGauvM0Nc+6jXu+AUgqQ985dmb0FUNPd/ZqqG0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB2lwA/VLoark8hWP/iG01KEp7Ho4BGCK97+zlpHwJ/JRDBcs7
	kS1qEuj0B9YBqt681HrinBOCY75pCGys4ViYl/jBaYjjqh5lZFB3hJKTFQrL1Ls=
X-Gm-Gg: ASbGncvFgySIeoR2GEzTaZu+efUizK9O3Ver08ZyxHXlIqiOBHWSPQxyIvqtntIVOw+
	g1TteDRxTWVL5qaNSjw+5eTf4pYMEq+mc7XyqAw1ucUGslS+6Q3g2+rX4gQzx+7pPB+h9obv5jM
	qeq1aNHnO1AQDsS8wBbOlRDeRrIS8o2XtVb5T9M9mtfMx3ZPkxYZDaM55FbnyFJ2Rp/MZNnI3yk
	sIV12JhPxgKPoVxa/K7ZUhsgxiSU44Ws+f8pfrdzeH1EWG0AoWBN708xuZXSRAaTJoMvUKPkYsU
	6uymBa4SOt7ZUdepJbL+ibwzK6+4F/irvc8=
X-Google-Smtp-Source: AGHT+IGFxxitWQfJahw973p0I2xV7/kZwy8gicFDigUlKkHKzWL+qRQIH+fD/xVRKEKwh58Qm9F6xw==
X-Received: by 2002:a05:600c:5014:b0:439:89d1:30dc with SMTP id 5b1f17b1804b1-43ba730d5b6mr142469095e9.10.1741015402850;
        Mon, 03 Mar 2025 07:23:22 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:54::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc6a8ff01sm23489995e9.39.2025.03.03.07.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:22 -0800 (PST)
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
Subject: [PATCH bpf-next v3 10/25] rqspinlock: Protect waiters in queue from stalls
Date: Mon,  3 Mar 2025 07:22:50 -0800
Message-ID: <20250303152305.3195648-11-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8548; h=from:subject; bh=/tO7WsHRnQ1y7o7jGLLRZ75jx2rvQksn4PRPhYxulGw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWXBmmTn9Q/JpHcUWagL6D0LQj7D9XnazfmRv20 F3ZP162JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlwAKCRBM4MiGSL8RyoaOD/ 9RNH1I8JHE99sQbIlMiKmtHTFHuJCcV0nvMTdA9wCT6zW9DamNJ7yjyl81IYTGgDbSp7m2QaZu788r wMj5fcd2iwhWcBBc3PlDuAKaTQwSz8B5BN1i6UV7vcK1E/AtpCEpvKXpqZH1SSiPx2YkgVYq8KmZxt Z/dIeZESDo9b9d1uSbJmJosgaNhZz1AbbuYEp6kniedp3jozmo3YFBcOue3YFKPe2Kg4NTJhwyRrXv tULCtm9RRxbu6QxV+kLPyqhYo74CyHJaolrRbLzf8we5rzaMwdJnBzFvKd7i2ZpNaoWQxykdCanhPC kPtXLBOdzzqKzwxaC1t4g3BJ7UIeouteWNdMi5qZqLhvMLByPg/i0nacGi4CD64Lriiq0FL+AMSlTM GZPhan3dSlPjsN45LIuBIPnN5XtrmgKV629AYm01KKITf7cSzqgl2iJ3dpqSasXs//53rgJxbnJaVq VOv1pbHmn+VLbJiV2X88Q43nhN1CwA5HGLBirqzzZ4K0hRzxuo9oGT6S2r76PZFDucgeMDRJB9c7Mm GUAgAQ0RCNDP+ehlhqzyWE0+v7m1qVYImUE0vh4QbgRxK8wEBGaupTPCZ0wHn0ruv4PtHa7PABtP+B PRV0YKX9hGtJ//vt5pVqTc7HjT1GByFMSa0MhSbB3s6F+v0Qkm6vjB3b7DBQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Implement the wait queue cleanup algorithm for rqspinlock. There are
three forms of waiters in the original queued spin lock algorithm. The
first is the waiter which acquires the pending bit and spins on the lock
word without forming a wait queue. The second is the head waiter that is
the first waiter heading the wait queue. The third form is of all the
non-head waiters queued behind the head, waiting to be signalled through
their MCS node to overtake the responsibility of the head.

In this commit, we are concerned with the second and third kind. First,
we augment the waiting loop of the head of the wait queue with a
timeout. When this timeout happens, all waiters part of the wait queue
will abort their lock acquisition attempts. This happens in three steps.
First, the head breaks out of its loop waiting for pending and locked
bits to turn to 0, and non-head waiters break out of their MCS node spin
(more on that later). Next, every waiter (head or non-head) attempts to
check whether they are also the tail waiter, in such a case they attempt
to zero out the tail word and allow a new queue to be built up for this
lock. If they succeed, they have no one to signal next in the queue to
stop spinning. Otherwise, they signal the MCS node of the next waiter to
break out of its spin and try resetting the tail word back to 0. This
goes on until the tail waiter is found. In case of races, the new tail
will be responsible for performing the same task, as the old tail will
then fail to reset the tail word and wait for its next pointer to be
updated before it signals the new tail to do the same.

We terminate the whole wait queue because of two main reasons. Firstly,
we eschew per-waiter timeouts with one applied at the head of the wait
queue.  This allows everyone to break out faster once we've seen the
owner / pending waiter not responding for the timeout duration from the
head.  Secondly, it avoids complicated synchronization, because when not
leaving in FIFO order, prev's next pointer needs to be fixed up etc.

Lastly, all of these waiters release the rqnode and return to the
caller. This patch underscores the point that rqspinlock's timeout does
not apply to each waiter individually, and cannot be relied upon as an
upper bound. It is possible for the rqspinlock waiters to return early
from a failed lock acquisition attempt as soon as stalls are detected.

The head waiter cannot directly WRITE_ONCE the tail to zero, as it may
race with a concurrent xchg and a non-head waiter linking its MCS node
to the head's MCS node through 'prev->next' assignment.

One notable thing is that we must use RES_DEF_TIMEOUT * 2 as our maximum
duration for the waiting loop (for the wait queue head), since we may
have both the owner and pending bit waiter ahead of us, and in the worst
case, need to span their maximum permitted critical section lengths.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/rqspinlock.c | 55 +++++++++++++++++++++++++++++++++++--
 kernel/locking/rqspinlock.h | 48 ++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 3 deletions(-)
 create mode 100644 kernel/locking/rqspinlock.h

diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 6be36798ded9..9ad18b3c46f7 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -77,6 +77,8 @@ struct rqspinlock_timeout {
 	u16 spin;
 };
 
+#define RES_TIMEOUT_VAL	2
+
 static noinline int check_timeout(struct rqspinlock_timeout *ts)
 {
 	u64 time = ktime_get_mono_fast_ns();
@@ -321,12 +323,18 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * head of the waitqueue.
 	 */
 	if (old & _Q_TAIL_MASK) {
+		int val;
+
 		prev = decode_tail(old, rqnodes);
 
 		/* Link @node into the waitqueue. */
 		WRITE_ONCE(prev->next, node);
 
-		arch_mcs_spin_lock_contended(&node->locked);
+		val = arch_mcs_spin_lock_contended(&node->locked);
+		if (val == RES_TIMEOUT_VAL) {
+			ret = -EDEADLK;
+			goto waitq_timeout;
+		}
 
 		/*
 		 * While waiting for the MCS lock, the next pointer may have
@@ -349,8 +357,49 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * store-release that clears the locked bit and create lock
 	 * sequentiality; this is because the set_locked() function below
 	 * does not imply a full barrier.
+	 *
+	 * We use RES_DEF_TIMEOUT * 2 as the duration, as RES_DEF_TIMEOUT is
+	 * meant to span maximum allowed time per critical section, and we may
+	 * have both the owner of the lock and the pending bit waiter ahead of
+	 * us.
 	 */
-	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
+	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
+					   RES_CHECK_TIMEOUT(ts, ret));
+
+waitq_timeout:
+	if (ret) {
+		/*
+		 * If the tail is still pointing to us, then we are the final waiter,
+		 * and are responsible for resetting the tail back to 0. Otherwise, if
+		 * the cmpxchg operation fails, we signal the next waiter to take exit
+		 * and try the same. For a waiter with tail node 'n':
+		 *
+		 * n,*,* -> 0,*,*
+		 *
+		 * When performing cmpxchg for the whole word (NR_CPUS > 16k), it is
+		 * possible locked/pending bits keep changing and we see failures even
+		 * when we remain the head of wait queue. However, eventually,
+		 * pending bit owner will unset the pending bit, and new waiters
+		 * will queue behind us. This will leave the lock owner in
+		 * charge, and it will eventually either set locked bit to 0, or
+		 * leave it as 1, allowing us to make progress.
+		 *
+		 * We terminate the whole wait queue for two reasons. Firstly,
+		 * we eschew per-waiter timeouts with one applied at the head of
+		 * the wait queue.  This allows everyone to break out faster
+		 * once we've seen the owner / pending waiter not responding for
+		 * the timeout duration from the head.  Secondly, it avoids
+		 * complicated synchronization, because when not leaving in FIFO
+		 * order, prev's next pointer needs to be fixed up etc.
+		 */
+		if (!try_cmpxchg_tail(lock, tail, 0)) {
+			next = smp_cond_load_relaxed(&node->next, VAL);
+			WRITE_ONCE(next->locked, RES_TIMEOUT_VAL);
+		}
+		lockevent_inc(rqspinlock_lock_timeout);
+		goto release;
+	}
 
 	/*
 	 * claim the lock:
@@ -395,6 +444,6 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * release the node
 	 */
 	__this_cpu_dec(rqnodes[0].mcs.count);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(resilient_queued_spin_lock_slowpath);
diff --git a/kernel/locking/rqspinlock.h b/kernel/locking/rqspinlock.h
new file mode 100644
index 000000000000..3cec3a0f2d7e
--- /dev/null
+++ b/kernel/locking/rqspinlock.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Resilient Queued Spin Lock defines
+ *
+ * (C) Copyright 2024 Meta Platforms, Inc. and affiliates.
+ *
+ * Authors: Kumar Kartikeya Dwivedi <memxor@gmail.com>
+ */
+#ifndef __LINUX_RQSPINLOCK_H
+#define __LINUX_RQSPINLOCK_H
+
+#include "qspinlock.h"
+
+/*
+ * try_cmpxchg_tail - Return result of cmpxchg of tail word with a new value
+ * @lock: Pointer to queued spinlock structure
+ * @tail: The tail to compare against
+ * @new_tail: The new queue tail code word
+ * Return: Bool to indicate whether the cmpxchg operation succeeded
+ *
+ * This is used by the head of the wait queue to clean up the queue.
+ * Provides relaxed ordering, since observers only rely on initialized
+ * state of the node which was made visible through the xchg_tail operation,
+ * i.e. through the smp_wmb preceding xchg_tail.
+ *
+ * We avoid using 16-bit cmpxchg, which is not available on all architectures.
+ */
+static __always_inline bool try_cmpxchg_tail(struct qspinlock *lock, u32 tail, u32 new_tail)
+{
+	u32 old, new;
+
+	old = atomic_read(&lock->val);
+	do {
+		/*
+		 * Is the tail part we compare to already stale? Fail.
+		 */
+		if ((old & _Q_TAIL_MASK) != tail)
+			return false;
+		/*
+		 * Encode latest locked/pending state for new tail.
+		 */
+		new = (old & _Q_LOCKED_PENDING_MASK) | new_tail;
+	} while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
+
+	return true;
+}
+
+#endif /* __LINUX_RQSPINLOCK_H */
-- 
2.43.5


