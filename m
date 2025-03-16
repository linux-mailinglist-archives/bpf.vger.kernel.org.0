Return-Path: <bpf+bounces-54125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1667BA63392
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925BE7A3A47
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1DE18FC65;
	Sun, 16 Mar 2025 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk6GSHlv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F718B492;
	Sun, 16 Mar 2025 04:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097960; cv=none; b=RKVmg6ZB1JSWcNojYvEF3gzHVvQo7hnMvbLhanmICm5+C5n7JzW1VjNhT+y8FrA/So/kvlYroGjzCR+VJTCCckz6CRweHlIF3O/lQKg68LzNX6bf9ouwkIAJlfIR/B1lD1bA9RuntfEJtPmnhgtofMdffjnsGPno1tRDEVFjOg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097960; c=relaxed/simple;
	bh=vVjQGLLHhTQCMBetlOFIdU+ojPl1vLkRKHm30dVzCfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZXJbbx42dMxZFQ1zM3WH9SqUDy6mON+sH6Lmg+uGoqqmHb0K7UZmeOrXp9cZjhxnP98yMW6KDjiCRYONg+XzXTXShA/xMGLIE9uh0osq161JSfuOlD9oc00sf8poIByjLBn7UjZa+Pwuc8wdhT1px7v64f3UOhwQmtKKz0upts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nk6GSHlv; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so11226175e9.2;
        Sat, 15 Mar 2025 21:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097956; x=1742702756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9oRTQ+VV5E61dUbGRZRpYYl6d2ZXF0CN+Od4Rtwxwc=;
        b=nk6GSHlvKbWwVx1zEuQA5zZ2u8ephBBJwdkVl1UWkmR9DTRaOMOL1jnW14OdLVLc0g
         391p5IwwNd8EvvgJ8PVsihAynq+C5potCepvnS0KqmWPueTOpwfWBP/GHJaCrp8y/rko
         rh+pylqbk2B+EEFF0p5snCqBY0g2D4vVePlDsLaVIXi5uwZPUfIKMBRHto5Lo5ECnzbz
         wdwtbMpC6U/8O7lZQmF2vYgvwDvpgXw1pD7WlXvXCzgExa/S7LZpUoHzzV6Jogx7Jt8a
         dNegHP8q+58wUyb6yaVUcAW8lN+EirygTqCiOK0DZ3ckkQH9oju67DsPGwoKmDGkfxXp
         rObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097956; x=1742702756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9oRTQ+VV5E61dUbGRZRpYYl6d2ZXF0CN+Od4Rtwxwc=;
        b=IAPSZi0V5yZCqH7u4wG1hqBjHUNpDZjvuylZVjgmQIeW4TGcxFhpZdg5I7KvR6iwcx
         XHDoo/ZySbAigvXTT+MctlbLarZXkeEtBEwx3YKCKKXmN0S2wkFMEA/mU42VljcxieD4
         XVdRXXSlyDPhcspnA7Zsv5iVxEMr/9LzDRBFFf2vO+A/LOEKRLpNijxDOb5vtX+bzxxu
         TpHAG5zPtCcOWfPgneva6pGdhRXh9e7+hm/ptYXdXclNrmejDIkwE3D3xMCHvFINk1Mr
         ///xykqyVimCjjOfBzVApPpCFCyRV31z2m3luDHlU+U3bU9Jl2Rpg36hYpgjDh/b41I0
         q02A==
X-Forwarded-Encrypted: i=1; AJvYcCXrq+/TrUgbEPOj8i96LGY/cRkpCQJ0LDWAj7rGgxp8jx2Mbo3QIQ+vbyBQpndEqLZZSG6hUedatfCPJ8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEB9jdtJXMMI9B7VsASohbVITaxp/3Mt0r+t+zQWCmOWTtDhSJ
	P63XuIEfOyKOTV+Axh0SDVKZ64oFdXEcyYtbGwX2Aeq4AdyV7M60NhCgBCyBFrA=
X-Gm-Gg: ASbGncug3ZGk0FYr3rFF7Dc/izXHrpn44T6KoMHjqiQpPfFNsPjK7Vnunh3REa03Jvz
	mbAb8tCx7puz+lDYB3P7blV3en7Co9hfcdNKDv/KrX5Y6oY2SRuOCAuW23vz3hP90K4LQSwSwRq
	3Zj3QHwU0SVsfgIMiZkDAr/TFAhxaMDLyOtSYjm3+AuitrowOaBaD09h+tqouU6uikgSmbeW9+Z
	QkTHZTJq4u+rSdCEltC7xnxnOcJpchsLnUg4w2f/3Y+ZOBJWdVlUP4n1zUcKZE5IqrpAzNP3X+f
	qRwRDR6OsJPs9teBKEI3tzWlLTOtLIsLNJQ=
X-Google-Smtp-Source: AGHT+IFkEauTHl/obyRmNhRmy/pJEBw/VAi/+QiZFNK10Y71rJhRLvMF1sFfj0C34r6TkaQ2AWy76g==
X-Received: by 2002:a05:600c:548e:b0:43d:b32:40aa with SMTP id 5b1f17b1804b1-43d1ec72a60mr95473375e9.3.1742097956021;
        Sat, 15 Mar 2025 21:05:56 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40fab8sm11240358f8f.63.2025.03.15.21.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 10/25] rqspinlock: Protect waiters in queue from stalls
Date: Sat, 15 Mar 2025 21:05:26 -0700
Message-ID: <20250316040541.108729-11-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8535; h=from:subject; bh=vVjQGLLHhTQCMBetlOFIdU+ojPl1vLkRKHm30dVzCfs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3cSLlo4tmtO0ItN2MrwskyKIwLLs6w+ebaLBXo 7AIxPteJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3AAKCRBM4MiGSL8RysmSD/ 4gAxpbVRAMKnrlkkFfN4Ga5MkaT9kFKIB75NzYnTksK7CH8hhGDYv+JLi+RdymiKCyY9nzzCusLCvH DgKiy8dOd7jd4kK2asNPQv83NeMlK0Y7ez2xIW0aheacqs2xHVRzHNpXJrhlXMFk9AOjed7lRqaZkk MHYjtNrFJYw2buxWBArDplbtplJ6ZFnH/R4X9150luydwS58JO6v1dpAXhDRtZug46Mf3bEhF2OxqC jOYtEwXKFE02GDoCLR+Ux1Tq9HAULxytmj+cG4B/5lN3ArOwmML81960DEOmDRtiBuM13th+wrnsBv j5ht8UeNorxeqAqlS0DKTVL5GwgKQ0J/gMt567PrzjsdttH9cQ2U+GS1RvleETvs2fRov1kvHQlCBh zWbay++IImUzfsbrUbJsWtbQz5zd7WoeMVXwycELimgnu6pMDDfOmXnPyktSfkP+Y2afRyImMjuGmz onfCAORf8i939MF0Z78DKXqnm5ooMaXPCja7iWalvBWDsRQVJXMA4eNMfbKC582zqFpuWWwa5V8NWm VhoIH2++de0gRcjcmh/Wg9q2PogVDyiUpdPW0390l2OIviAlmCmDbOMeMMvmSAOonJmYnfqgmklT82 erZE+jj8vv/93kMS/3ldvy0UA/t4FMfRnggOei1u5ghurEjEm+jmBceT6Qrg==
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
 kernel/bpf/rqspinlock.c | 55 ++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/rqspinlock.h | 48 +++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 3 deletions(-)
 create mode 100644 kernel/bpf/rqspinlock.h

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 262294cfd36f..65c2b41d8937 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -77,6 +77,8 @@ struct rqspinlock_timeout {
 	u16 spin;
 };
 
+#define RES_TIMEOUT_VAL	2
+
 static noinline int check_timeout(struct rqspinlock_timeout *ts)
 {
 	u64 time = ktime_get_mono_fast_ns();
@@ -325,12 +327,18 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
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
@@ -353,8 +361,49 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
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
@@ -399,6 +448,6 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * release the node
 	 */
 	__this_cpu_dec(rqnodes[0].mcs.count);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowpath);
diff --git a/kernel/bpf/rqspinlock.h b/kernel/bpf/rqspinlock.h
new file mode 100644
index 000000000000..5d8cb1b1aab4
--- /dev/null
+++ b/kernel/bpf/rqspinlock.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Resilient Queued Spin Lock defines
+ *
+ * (C) Copyright 2024-2025 Meta Platforms, Inc. and affiliates.
+ *
+ * Authors: Kumar Kartikeya Dwivedi <memxor@gmail.com>
+ */
+#ifndef __LINUX_RQSPINLOCK_H
+#define __LINUX_RQSPINLOCK_H
+
+#include "../locking/qspinlock.h"
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
2.47.1


