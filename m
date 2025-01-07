Return-Path: <bpf+bounces-48106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD41A04174
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475F63A5E5D
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0007B1F37B7;
	Tue,  7 Jan 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJn1bUJp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDBE1F2C3A;
	Tue,  7 Jan 2025 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258429; cv=none; b=lOxIs6bg9rKuusVvtn2VwfoTs/aQKArZIvqYy9q+C0SfXA9DqOb/JhkVMtkYoLoIxool18pViGosGBxUZ6z2KJequszMF3SMM3c8ZYurjGjO53c2X1+rPa4Q2i3RF23Y5e24aaPmpTzqyJ1eujWlbjAG/CZA+/7vilUjwMvPOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258429; c=relaxed/simple;
	bh=XaKniQP0fw8FDghElxeAS1LeTyDHcHP8/ZPBUoYiI+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifowmIS0Ly8DOBy9buAvN0LkQAOWSr1Q+MWte/jiEZjtVAhAQrBXpuyYZpO7JCmSn1ogkIzInxudk9+xd+wJbCp6oespbofQw3UNQkcl7g+gKzj0HsDrdMu7RVBH/3uAxqB8C+3yAtHwsazYVHle1eQImvGYkkSgf713jwxtcrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJn1bUJp; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4361815b96cso103946135e9.1;
        Tue, 07 Jan 2025 06:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258420; x=1736863220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HM88fWKQU5di/19zVZDgTLqXttcx9EvEIcaqgBIOKg=;
        b=AJn1bUJpxEai3DH9N3gK6FHKglsPXELQS7adnBUtLdd7eAJcuy8SqskV0hLtjKXcT8
         EWM2NiTXZtJ5fhmtD4YXHjEofCNIq8s1i1DR7JwB0LMow+jsuVruwQEkKRSb8Tm+3Bm6
         9nHNR7EZkckpc5J2eJzs2M94oJOz9j2bFoYznDvWhNJxb2VrR+4sq6Jlc480xvOxUEy9
         KP3n44DutBDR0aJ5M779utCshxOJSK/wVzjPvOvGuNUtmgZtJJRTRoa8IMAhJhSOoWDC
         4hKt8Db1LaggWcdJZTMg0oKQ135ITvjJkLOTGRE1DxqNWQBT1qJcbkkJTQhwP8AwiU+g
         d4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258420; x=1736863220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HM88fWKQU5di/19zVZDgTLqXttcx9EvEIcaqgBIOKg=;
        b=ALMVEVEnLB5df4RT3J1ahoYI4Az4yUGDY6AZ3AObRhySoDagriBVWCytEW2II55WoZ
         MuhRiCejgF/c8QmMF5JEDa0Niv1Jh2A2vFotDrg1/shDIn5WCriYKBk9tvYRuzmOeAmv
         I9FfxWAq9Sk4HyZSMqCEcuWVe9boAMHSzu/ku5JMgz5JYYlFQviQOfMK6YnRgWlDuBQJ
         dJLvMzascb4KhcyCxJCR5gjPm+G/P9MO8atk6BsnDQylUpMS0q8EtBgCNKu0W0VW0c+Y
         XR0rf17fzFl0SjQ3Eb80wbFleX6r2qNtXOr8tbl3pxkWGVQn4MFEHan/aHUygx/gpEkM
         hngA==
X-Forwarded-Encrypted: i=1; AJvYcCWR6QxcaqIaQ7ItmS53fqUAX84pt8LWLreQoBZv7vjzDsLxGUevpfBJiWFP5U2N4019OYxTPBqfWqKBpRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVEZVk+scqHR4osluhd1dNLD3Iy+cAjAMbOoxcNCetOVz13pRo
	Oo770BjbLLkAsUuBXHYIJO0QHLg+nJeTJTPJTYcTCDqpqVTPCoyofCxMrb5NBiTTgA==
X-Gm-Gg: ASbGnctkPpLr/9Ca3ER0xjHdYAn+dKnrJHgQsdWRG5gepwP2/ep9akU5Iyclhs/IaK4
	lLiCLedMgxQPUjrRr6KgRU9C5MgSD44sKG8HES7tBOWXY2tHff/E6z1Xx4d1FlGzmKAWpPaV/45
	1RcH2X/WqvI25pwJI/bUUsTPH5Vg7tm5zFAr7CYZH1gJp0h2FPzaiVEb3vP+B2PKBW0HjFsF0Qm
	jNu6eXH+1Gm07IHJxTUKFhljkKqzqhJVU/BJm9T56+Nq+g=
X-Google-Smtp-Source: AGHT+IEE+DWCX5z1DVUUmJ9gqFwqQJvKF3u1tL+V/Ke4xDlxzD8IBkbFEQcWpFd/wQFw9LwtQHXsLg==
X-Received: by 2002:a05:600c:3c98:b0:431:6083:cd38 with SMTP id 5b1f17b1804b1-4366854889amr493588315e9.6.1736258419687;
        Tue, 07 Jan 2025 06:00:19 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:17::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436d8115be5sm55713735e9.28.2025.01.07.06.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:18 -0800 (PST)
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
Subject: [PATCH bpf-next v1 06/22] rqspinlock: Drop PV and virtualization support
Date: Tue,  7 Jan 2025 05:59:48 -0800
Message-ID: <20250107140004.2732830-7-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6317; h=from:subject; bh=XaKniQP0fw8FDghElxeAS1LeTyDHcHP8/ZPBUoYiI+A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCc6R78TqsJfI8yJUzr01q0pRzkirUx2mFuAw33 qR72e+uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnAAKCRBM4MiGSL8RypbnEA CMLjwl4NzwBc1YJuNWhjtAF2LgWx+YBHdKjlohsfgdU3W2ih7PbOD/BqOTN0CZsMY0ohW74bWincwc 2uaARzCW3YWDDLLwZZKcRd9DMrahLLu1f1WU3+pS010cvo+xL7MQHTeu9JvWqy21Vho/GkZa4NKx+T nGjaVDdVhRaNaHnCuwchoTs8QCY64P4dpldT+6jPVPuEUOrwBBX7TP4wmwciqa4IKbV23YBx3+UhTR fwVnGvotabQkjOeM77PpBNfoLveHirx229Jma+t5GDe1lW57SlHzPS7UJkHrf+u/fRY9fAOyInFlhu yJ2LYKeARi7JJQwH57qKghL6No2HsRZkjMq6NGUhEZ21MdWmfRqH0c+N+UzZj6XFRmJC8CO6pET0XV Vq2rCoHCHWKYN5p6uer7mrLclliVZQC2OexmFoI+hQnwgsJzngYtia1ZzSWXdXsCturNfFu5JjmoDf lMkSWzIzAQpp8sDIjCo5DL7i3Mpt6PbEvGqkM+CRVn/IwiLY0kz+FqbFOUquDBRfRuOK6usQwc8/JN B5kx80cUJxBlP1p8PUrh89iJuKF+ZKqE+VJFd9Zfdibe0UsOoDQVkAWLWK3ulwEp/2VFGeT5oAXIKc t4o/sWiKoqXyv3i6KkZ1asVtqgHkWEb5sLnfQ9T7b17QDHeIirKMT9+53PQw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Changes to rqspinlock in subsequent commits will be algorithmic
modifications, which won't remain in agreement with the implementations
of paravirt spin lock and virt_spin_lock support. These future changes
include measures for terminating waiting loops in slow path after a
certain point. While using a fair lock like qspinlock directly inside
virtual machines leads to suboptimal performance under certain
conditions, we cannot use the existing virtualization support before we
make it resilient as well.  Therefore, drop it for now.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/rqspinlock.c | 89 -------------------------------------
 1 file changed, 89 deletions(-)

diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index b7920ae79410..fada0dca6f3b 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -11,8 +11,6 @@
  *          Peter Zijlstra <peterz@infradead.org>
  */
 
-#ifndef _GEN_PV_LOCK_SLOWPATH
-
 #include <linux/smp.h>
 #include <linux/bug.h>
 #include <linux/cpumask.h>
@@ -75,38 +73,9 @@
  * contexts: task, softirq, hardirq, nmi.
  *
  * Exactly fits one 64-byte cacheline on a 64-bit architecture.
- *
- * PV doubles the storage and uses the second cacheline for PV state.
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[_Q_MAX_NODES]);
 
-/*
- * Generate the native code for resilient_queued_spin_unlock_slowpath(); provide NOPs
- * for all the PV callbacks.
- */
-
-static __always_inline void __pv_init_node(struct mcs_spinlock *node) { }
-static __always_inline void __pv_wait_node(struct mcs_spinlock *node,
-					   struct mcs_spinlock *prev) { }
-static __always_inline void __pv_kick_node(struct qspinlock *lock,
-					   struct mcs_spinlock *node) { }
-static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
-						   struct mcs_spinlock *node)
-						   { return 0; }
-
-#define pv_enabled()		false
-
-#define pv_init_node		__pv_init_node
-#define pv_wait_node		__pv_wait_node
-#define pv_kick_node		__pv_kick_node
-#define pv_wait_head_or_lock	__pv_wait_head_or_lock
-
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-#define resilient_queued_spin_lock_slowpath	native_resilient_queued_spin_lock_slowpath
-#endif
-
-#endif /* _GEN_PV_LOCK_SLOWPATH */
-
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -136,12 +105,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
-	if (pv_enabled())
-		goto pv_queue;
-
-	if (virt_spin_lock(lock))
-		return;
-
 	/*
 	 * Wait for in-progress pending->locked hand-overs with a bounded
 	 * number of spins so that we guarantee forward progress.
@@ -212,7 +175,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32
 	 */
 queue:
 	lockevent_inc(lock_slowpath);
-pv_queue:
 	node = this_cpu_ptr(&qnodes[0].mcs);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
@@ -251,7 +213,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32
 
 	node->locked = 0;
 	node->next = NULL;
-	pv_init_node(node);
 
 	/*
 	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
@@ -288,7 +249,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32
 		/* Link @node into the waitqueue. */
 		WRITE_ONCE(prev->next, node);
 
-		pv_wait_node(node, prev);
 		arch_mcs_spin_lock_contended(&node->locked);
 
 		/*
@@ -312,23 +272,9 @@ void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32
 	 * store-release that clears the locked bit and create lock
 	 * sequentiality; this is because the set_locked() function below
 	 * does not imply a full barrier.
-	 *
-	 * The PV pv_wait_head_or_lock function, if active, will acquire
-	 * the lock and return a non-zero value. So we have to skip the
-	 * atomic_cond_read_acquire() call. As the next PV queue head hasn't
-	 * been designated yet, there is no way for the locked value to become
-	 * _Q_SLOW_VAL. So both the set_locked() and the
-	 * atomic_cmpxchg_relaxed() calls will be safe.
-	 *
-	 * If PV isn't active, 0 will be returned instead.
-	 *
 	 */
-	if ((val = pv_wait_head_or_lock(lock, node)))
-		goto locked;
-
 	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
 
-locked:
 	/*
 	 * claim the lock:
 	 *
@@ -341,11 +287,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32
 	 */
 
 	/*
-	 * In the PV case we might already have _Q_LOCKED_VAL set, because
-	 * of lock stealing; therefore we must also allow:
-	 *
-	 * n,0,1 -> 0,0,1
-	 *
 	 * Note: at this point: (val & _Q_PENDING_MASK) == 0, because of the
 	 *       above wait condition, therefore any concurrent setting of
 	 *       PENDING will make the uncontended transition fail.
@@ -369,7 +310,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
 	arch_mcs_spin_unlock_contended(&next->locked);
-	pv_kick_node(lock, next);
 
 release:
 	trace_contention_end(lock, 0);
@@ -380,32 +320,3 @@ void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32
 	__this_cpu_dec(qnodes[0].mcs.count);
 }
 EXPORT_SYMBOL(resilient_queued_spin_lock_slowpath);
-
-/*
- * Generate the paravirt code for resilient_queued_spin_unlock_slowpath().
- */
-#if !defined(_GEN_PV_LOCK_SLOWPATH) && defined(CONFIG_PARAVIRT_SPINLOCKS)
-#define _GEN_PV_LOCK_SLOWPATH
-
-#undef  pv_enabled
-#define pv_enabled()	true
-
-#undef pv_init_node
-#undef pv_wait_node
-#undef pv_kick_node
-#undef pv_wait_head_or_lock
-
-#undef  resilient_queued_spin_lock_slowpath
-#define resilient_queued_spin_lock_slowpath	__pv_resilient_queued_spin_lock_slowpath
-
-#include "qspinlock_paravirt.h"
-#include "rqspinlock.c"
-
-bool nopvspin;
-static __init int parse_nopvspin(char *arg)
-{
-	nopvspin = true;
-	return 0;
-}
-early_param("nopvspin", parse_nopvspin);
-#endif
-- 
2.43.5


