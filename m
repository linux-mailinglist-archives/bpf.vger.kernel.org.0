Return-Path: <bpf+bounces-48107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C7A04173
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10793A5753
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060761F3D21;
	Tue,  7 Jan 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6BbV/rT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCFE1F1937;
	Tue,  7 Jan 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258431; cv=none; b=Sm8v70eIh7JYy8JaZYR3Hb3+lh9tQ5Swo5FSwtDaCqQni91plnXNgQBXfuVYp5v5S+ELJcp1hnmHyLNL6Y8/XSnMZP2Y+IPeizKa/X1mTj1j2pl0MExCxLr3BhvJsEQU5fwHasKF3V6OrBoL5+J12XUBTooplyD/NFkOyXiJYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258431; c=relaxed/simple;
	bh=IgfYm2OWQRpCBxLPzMhHBs/ZxVNXd/QFwTtPV8nytDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMlccoljnAoqgX9iwm+D8bkey7YnZJAZzVON4ZgR82t3MJiKYkXo+++So2imUO/eUX9jKcvpDtTzThXlre3ad0lacHHZ0nom9OQvJ0bAhzYE1tsXKrOUuSDqDpmKn8A2Scp6QQT9dSPtrXK5yHPYBTZBQL4HH9BF7J1lb+k6bbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6BbV/rT; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4361c705434so112615825e9.3;
        Tue, 07 Jan 2025 06:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258423; x=1736863223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbshwL8dJ3BJ5N3j5Um9HMMlyp+LQfdllk6w8wYTP3Y=;
        b=Y6BbV/rTWjULJjxt7NmJSAHZHn0I3ktBxpcYXlBIxbmrksMaeR0dy90w5h1BgIUKEP
         zqjivcrglnuO41SWxEBkId6uAM2G0vxPZpWGGlYOtWmDzwRwTbNIBUkQmwgKFk6H6CHt
         DtO8jv94dLFsuYbcAxE+xmzcrPxzJn2ItFOHK5j4ZVsEnSO0tYR8o7G+6tOPibwz8MsA
         j2Vhb/uN0dF1hJK9DXLV4zJ5e5EKOfXr6+8WOfKKEycoOR6TQsBoSsLCpDAnyCxCGxCL
         SCxpklVBNS/NWb/rwPTwaq4+oJXOHMKxwYBsDrODeg2xgBVTPo2nikyQ60+JtNxjG/HZ
         0KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258423; x=1736863223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbshwL8dJ3BJ5N3j5Um9HMMlyp+LQfdllk6w8wYTP3Y=;
        b=UUX95Xa9XB/saqk4a1nmUFf+Q530SZv+bnHu66lWCJL+zaE0w0ig1Q7e4bk4nkSwhd
         G3aO3o4gEG80kS8Mv/moTG6NDVuqeB7ln9fVvisTUr1nX+3wHNj26sWfX7E5bNbkzTvp
         PXRNy4w94Fwf/VaHe8Ki2UVQcbawM3Vr0WNf115b35Djwdblp2ajJ3A8IK6ZJoffZxi4
         eel39nn4OXJdKQWOxmaFrKLVi5duOagGTjnVR41Au5Hk3P8D68jjGtH5zWG8TI27aH8p
         yVq7Y6KGt3JegBGC3RLybtyWD7EIg83xQofaEx8HiEURqt9u73+65vcx8K1HXjbeBZ9t
         OGpw==
X-Forwarded-Encrypted: i=1; AJvYcCXrQJsM1Mhaz4l3QoBZnWKWmmTe577q6r/3eP0QKMAqquRKHBcFHuzZKY/ZDVKrA7+s4O4gUId8j5I+stg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJG4LFKSYnMB65/XzYFmOcRBKIvWDLHYkpfFTJMn52OgmeOcww
	mx66yFJeRpZhb6px43610xWxay3bhaub0gChVj6ccqJwA7075O7r7qeFdmUIiC30kg==
X-Gm-Gg: ASbGncuejaTgcosGjT0U0HyEc8DRzR5rmiyyGye4Ij6Befbc9qxdbMYzr0sX94OZq2C
	Ec1dCUihOO/qKuGmJQa2qDOty0ubd6+zHL8p+B19LXPkDPToVSiMZuQ3CZlMbx8B03gYgER8Tyn
	4jBIPiS8ZHjGXP+HtMmY38sgOL9pB55VdqniekQcu0uQT+kBIimYllPusRPU7+X8xP6kfHCK8FG
	a4HcEmERFJk6w6wOjhJJH7m8wAKz/u5jns+Ohf6lZrgKQ==
X-Google-Smtp-Source: AGHT+IG+hHRb47WYnzbA+zvjAtopAH2+TuOZ00bIWmSuuatVt3XGRGJ1JYUm4f0jbTLJVdmXoWz8yQ==
X-Received: by 2002:a05:600c:3b02:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-43668547462mr522010605e9.4.1736258423307;
        Tue, 07 Jan 2025 06:00:23 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:c::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b00cf6sm640982555e9.10.2025.01.07.06.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:22 -0800 (PST)
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
Subject: [PATCH bpf-next v1 09/22] rqspinlock: Protect waiters in queue from stalls
Date: Tue,  7 Jan 2025 05:59:51 -0800
Message-ID: <20250107140004.2732830-10-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7065; h=from:subject; bh=IgfYm2OWQRpCBxLPzMhHBs/ZxVNXd/QFwTtPV8nytDU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCdQj2N8RblN49pYrsiE/JahnFXNkv8S5Ij976P XZAaDJKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnQAKCRBM4MiGSL8RynOcD/ 9zeuGBQEedmUGc8xb41HwiTv8aPA9iiWIgPc+Jv7Dxoi2Aqw4t+E80VgXw3+4TR8Hg3lozrKaxwBpb LnVOC3YceN0QluQP0yK3/e3c+FDdrm0/5/LJsxD+Yx9+mDRf2aYyl77JqntmU5qNRpOW1uwrc38y2f qC2cLzCSvBZmw6uoELukyLoxW7mXenJuDOhhSfFl4oAgcjHNWushiPfNPKal0OasnkZu2hwZqssPL0 4IBSaT4/l5UuCw/DLr+sBHQCazF0fDFrZnrqpCyTgu3hhbk99pokdUTC90lM/g9Vs52YZUWi+U/GrR 9CcrRwYhbjeirYBbBa3ARvBCXD866XXznTgKETqk7EVzj7zbv4HS5TPl5c85q5BGhSyd5JGtDTellw GXhfkdg1zBYhh70ydFJP5kI8UEFu7F7aAFs4YzlYkjerwO+lr6ChLZfjOJ5PvQYlENcqWQbtrYMyA0 FCUml0pNtQzOjt0quTEOQ4/2/GJ6a1ykn64o4S5+eTrhBlcGgf5XAybvUNTfg4XOon+bfyihQsXcbV bTQjL8edL9qW8VVWrBAX3/dEUB/6pQ5+a9+e2N56B5b75QlPF9clziZ6K9RLXWH+h1yGFa4WFqoBlC ibmPyapzTg05xIeL5LaikxaadOQBF8lW07JyBh4pTGM6VPP6uWoGYeV06TvQ==
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

Lastly, all of these waiters release the rqnode and return to the
caller. This patch underscores the point that rqspinlock's timeout does
not apply to each waiter individually, and cannot be relied upon as an
upper bound. It is possible for the rqspinlock waiters to return early
from a failed lock acquisition attempt as soon as stalls are detected.

The head waiter cannot directly WRITE_ONCE the tail to zero, as it may
race with a concurrent xchg and a non-head waiter linking its MCS node
to the head's MCS node through 'prev->next' assignment.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/rqspinlock.c | 42 +++++++++++++++++++++++++++++---
 kernel/locking/rqspinlock.h | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 3 deletions(-)
 create mode 100644 kernel/locking/rqspinlock.h

diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index dd305573db13..f712fe4b1f38 100644
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
@@ -305,12 +307,18 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
 	 * head of the waitqueue.
 	 */
 	if (old & _Q_TAIL_MASK) {
+		int val;
+
 		prev = decode_tail(old, qnodes);
 
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
@@ -334,7 +342,35 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
 	 * sequentiality; this is because the set_locked() function below
 	 * does not imply a full barrier.
 	 */
-	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+	RES_RESET_TIMEOUT(ts);
+	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
+				       RES_CHECK_TIMEOUT(ts, ret));
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
+		 * when we remain the head of wait queue. However, eventually, for the
+		 * case without corruption, pending bit owner will unset the pending
+		 * bit, and new waiters will queue behind us. This will leave the lock
+		 * owner in charge, and it will eventually either set locked bit to 0,
+		 * or leave it as 1, allowing us to make progress.
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
@@ -379,6 +415,6 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
 	 * release the node
 	 */
 	__this_cpu_dec(qnodes[0].mcs.count);
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


