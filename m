Return-Path: <bpf+bounces-50643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F4A2A670
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB6B188857D
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594D822F177;
	Thu,  6 Feb 2025 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqRXKBxh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92C22E400;
	Thu,  6 Feb 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839294; cv=none; b=AfXl1s64yyGaxbotGuZ88wfDSIZUpGFbFL3BtkYA1NQwXyZH4NRiGwKAZSOP5Lph/akYlcBrRxkuqr0AUu1wJLNZgGuUjrvLwmX9NU9Hw6oUSNAwU4ZCL8qzOwvhhUkrbkRWJ6tbSOvmM1LqPbyswrxKn2QUcQFRUi5GzM0vcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839294; c=relaxed/simple;
	bh=Xa/jCeO/bNAS2DABSLS2XeyE6NH1yv2QeubXVXtSfFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDov2RN8BNGXChjiKVo4lYi+cM8DJThOb/xG/8fpazh61LbdPFaihPH9Fzrc0mSeuCe6aiCAkjwI0GbWVgK8Zhj1Ca1a9bqXHF6nfCkyWcF6wSUzCszdMDmm85wJVupP+aT1d1V3ufksYpJI4bUgZFpFsIoLTjPD2eih1y9Kbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqRXKBxh; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43635796b48so4157305e9.0;
        Thu, 06 Feb 2025 02:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839289; x=1739444089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYidbmwxCEV+eSEjHIGui462v/Vxn8uyk3zJ0J48/Wg=;
        b=MqRXKBxhCkdnpp9DLKsTQVYPTCaGmSe6LwvI7z32hKZFbB5mY50tbWz2LzBGDEpjXh
         nDO0Iva3925X/DQrE0jWgO8j6obQWAYGBTvfuZQ07v3fDRCcaANULlot9/WTh0XdTtib
         sOTggTy0BGiUquHPnk5ceOyZaDLpvwBO4SWhtgb9R8FgJLiia3x8TaFJZ44v0u4QMOAY
         34q5HYkwIlB/4okZ0ElyKalO67GGT19/oe56EIER/KakL673CAC4x2jcmrMH1Zauync2
         vjWNpWbDro9R8fNe5dLGeiVWU3e8fPbQtojobnWbhhz01NBsxs2n5ikAOd+lHNmH+fUs
         BeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839289; x=1739444089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYidbmwxCEV+eSEjHIGui462v/Vxn8uyk3zJ0J48/Wg=;
        b=A8c7oW68M9YB/1vuwwQCmVAVAreKDjK83WAtdL1WdKXT7TUEY0QB4s0j2CbGiYsV1O
         fvAGnlyT0QYDhheKF9T85+iQOQH5c+atOTyh72UHz8QdeBuMre29KivYHTE5+GXJ7Anv
         NxaHpmer3tDhhfzUbxj43ON457OLZQET6qHaeUoDG5EZmZkAX2srrAdHnRSi4xef9vxl
         28Lmhri2zLd9ddAxmfzd4x+LL3ZBYdIY/fpAWKBr6Gt13fO0T07YU+XRAlNQNudNnVcP
         jHDCJoKd4NpsYI3e6RkfkBuhMhcWfYUaTiCvpzc6c07Rnll5mS1ZsahLc2iuYx2793Fp
         pgXw==
X-Forwarded-Encrypted: i=1; AJvYcCUj4mtgvVCbBD5B9Rb+ywxlbPxGFap+UC8E0RdMJBp7qvnXWEIBOJ1wTCHdTn9UXcdLA5Guc0k1uVWhnUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxFxZqMpfk4urWmoJ7xznaYq6tbgwYJ7vVQFRz3R8v0ieZ+W9
	x01PLovTi26ce6JxNm5DUeOL1ntK6tUX8m4PrPu5Ox8GfAIgz80ULQAwEfLxCJc=
X-Gm-Gg: ASbGncu5rsYMVdhrr3mdxv5QYoR5C6TkBqOQf6xIUwv5sCVdL19v4ac9NQ8GqYQtaOa
	TZh4MbqCp7cGEtVD0dHULhq/bPnlSOBxG7TQqpwvqFNti63MAJ1d8fjJ7JUPhmUqaOh6/ZzC0gN
	ASLOG0d+cnqbu2gIFm9uGbjKMF5b7o/tBj5jxDoT8Z6qivZcYt4CWlxb1C25x5d3fAtdrTHLi7q
	dxOoW1I6Pn7HvTWeczz3/Av0+y8n+QxUFoqpm2GPkywL7CBAaV51BXcQ4IKxDtNSIDGh09n4Zn2
	W5Zz0w==
X-Google-Smtp-Source: AGHT+IFphip47QJW2PrpFsbKi02KtCDzlFv4DF2sCZj2+AejG4aG7KuSt5Jt87tvagiOv6cvGdW9aA==
X-Received: by 2002:a05:600c:a47:b0:436:e3ea:64dd with SMTP id 5b1f17b1804b1-43912d3ef4bmr20857325e9.11.1738839289015;
        Thu, 06 Feb 2025 02:54:49 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd4df6bsm1429709f8f.39.2025.02.06.02.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:48 -0800 (PST)
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
Subject: [PATCH bpf-next v2 09/26] rqspinlock: Protect waiters in queue from stalls
Date: Thu,  6 Feb 2025 02:54:17 -0800
Message-ID: <20250206105435.2159977-10-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7029; h=from:subject; bh=Xa/jCeO/bNAS2DABSLS2XeyE6NH1yv2QeubXVXtSfFg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRl7An7/KiEUm98Ur9vnCib0zAC2FnG3ihYCJKd QcDong6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZQAKCRBM4MiGSL8RyrulD/ 0QF/IO1vH6JRLlfF5fdCoL2J3bq6TUizWVQKnJM58Ak3TLWy8SAYpkkznDpIqhFohSNctWXqvIZ+9p 16sVoQkzVrUVZ7oFbcrGdJRcSkqMQc1LJCTJG+1+S0O458BwdjYHBxyoigb2bJxJ1AqoTakaX6rOFp q41csSMJragiD4b837bqZkq6Kcnt5NFp7XO/6Ca4/ZgmqpXuFA/o2zmajpZUM8v+bjVz/X16xlcuV6 SBxSHt0aPLBsnLU1BoCQrQWdpFpl1mJe+oslsG53qb/RfuoKcTBhetjeceQB8Hit/6sBcswtT44WAR Cx69D/8D2KZO/Q4Lrg08OxeuZadzrtnc6jOHnXI5DGab+HO17FzujG+flkF5KdBYru82bFLsWr3W9W P6WH1ACcX5G6Ivg/ah/wpe8/6GW6+02j3XKd5r0tgiGp4JDq0CnMOs8Sfe+LmDPiEuo+1zg/17KnwP G2OnXHvHPsyjcj5T2kVQOok60uFZk2WMFKXgMR23OcgQ/3g4sugfLA3JBDlw+xL1XfUSYgGPaGyi7o YNfJ07vRVHBXylG06/Y/GytWzKZoeQxLMeb8CkChWXxgnS28C3OZY3G1thv2fdFQ1sG/nUDTHZxqbj n/6RKyGflImPIdWq7jQWqYNDTxpBkJyANG+96Y+NtplOkmtZPIZtX2ePJ0yQ==
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
index 8e512feb37ce..fdc20157d0c9 100644
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
@@ -305,12 +307,18 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
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
@@ -334,7 +342,35 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
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
+		 * when we remain the head of wait queue. However, eventually,
+		 * pending bit owner will unset the pending bit, and new waiters
+		 * will queue behind us. This will leave the lock owner in
+		 * charge, and it will eventually either set locked bit to 0, or
+		 * leave it as 1, allowing us to make progress.
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
@@ -379,6 +415,6 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
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


