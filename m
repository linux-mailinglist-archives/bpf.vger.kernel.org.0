Return-Path: <bpf+bounces-54122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2EBA6338B
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C053B27FA
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3F2189B94;
	Sun, 16 Mar 2025 04:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pie7eVnQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFFA17BB35;
	Sun, 16 Mar 2025 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097957; cv=none; b=AWviEIbGRlfvxCN9Hs7HoIjVfa7XrSSSb3WrIT92R2Jiha2HBhT+SiGWAlC+4EzqVpOCrHdf+00i00hrZow/gw2xQmcs16ChWshSh54C0vj4FlucqBZRweHEbdiOcnosKOfzxnUHPxbo6FpX1JuuSYmIWJLqts/gnw4OX2gJY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097957; c=relaxed/simple;
	bh=UZ8naMS1hT+7LGCLfEmfT5uEbBX3f9Jyevr2RnHN8ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdAOZ8rdNJlcwZHU0fw1PWYFvYcmMcxzgF0GzyC5BY6xk0FNpoT8lV2p1VtwdzanIUSIhT/WG8IGfImKmBq7xExPk3TmamKqHtH+Fkp2jnuyB4p60GnERbvJGJYDFfMjQZMDaVDUaT0CBSB131HUEIfGdnfSMq7YeNZVMiRPBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pie7eVnQ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43cfe574976so5640855e9.1;
        Sat, 15 Mar 2025 21:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097951; x=1742702751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh+KgT9rgROAc0Y/x+RNT9BL+c7q6+gqaABwWSSeoyU=;
        b=Pie7eVnQFhzNoNfUUN3r9rH/0kdu/cO5NjkwQN88icdGQMn+VrNA6/Ot7d1U7Lfuo0
         50ZC/4DpWuRi6K/0SknNrbd02C7RSxlaAQVqdChI+4dBccT48/AI5OF/ydgveNKSnTQS
         qak85lYMDSgirqnjsUmq15agYlfSUbb/hxCLUKRRDqU2Kw1AwZT165WsX0W8LknCVFKw
         dAisKSszXHfscCXVhgnvtxWwFZ/3wSMYhAU5agSclC50lh9A09opH0hlA9rBzlaJ/ySE
         KdJZsBY/1XE5Omfa03N/nDT2AkagypCJvEV/fHAj/iVEhKnKCQRYDORK/IVKAyCmW/Ag
         8ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097951; x=1742702751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fh+KgT9rgROAc0Y/x+RNT9BL+c7q6+gqaABwWSSeoyU=;
        b=K1MzxvHkp3LGzN+8WGa9LXp5GehqRE3D0IG80FIQdHVM9bIvA9sawG+BauPL8vJnhw
         rC9xda+yI5Z5JLkyRCRqOeUy+a8vNJ1bu+VU9t5TEDZUodJz/k7hky61xadXyGxknuyc
         wexC+3KkGtYbBfDr5A16GLH5k7rBzHTDynnMssgx/ijqBXrPFKCbIZViMcANM9pLxYd8
         y+4YFWvN4MChEeoMjnWTW/dTgkEai3jwMwJT6wVcbtwM0QeAK6j7HXtiw3ReWQ1tFm5t
         pTc37SljgYzx1D2DJEavSu951YCiazpoxp8+PwoW0I6BAg6VPZ2KCJvS6aPYhzDdVIzK
         z7ig==
X-Forwarded-Encrypted: i=1; AJvYcCVEovq9FhB+WEA8abMMR8wSKdvCWEL1mqREKaCtCJDyNjmUmkgLJsNF/JASksJ6tm7MLUW7jjxjWjyGIPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjd5U9oivGLfCVH9LWrV2vwGiLbenqPSkZvSEA9z6wJloCBStO
	5otAwgQUi1qU4km/F3UjjLdoxky5CCjitgXjHvRQfomPaCGRlvWjiGWBnG64pfg=
X-Gm-Gg: ASbGncuaaoE7T/Qb7I53gYDrfjor1a3xgv6z98ZFtXmbskIYxgaThoipAKMSiVj6gpz
	fzKkbWvR7aTryFPmW90uKAE+nYfT8iRGOQZq6V0ePZyJqiNo/oMrxcF51pKG2ENzuprOv/31TpY
	Hz+puvWUVkz+Km6srKDp54B1iDFJk6cBU55CAkE5Qyy6Df163Eg5vNJDqsol8XInxCs6dJ8K3tq
	eYNPKiO5HtJPgT6iU6ImEsjWnEChtb4pMacp1RRjd6O979NpILVH99mkVLBQPSSBt2iKUaONA3v
	ZLxmTLLu8qFxDbGhQrwBkp+yKUipP2HQAQ==
X-Google-Smtp-Source: AGHT+IHzQuqWCQcYRFu+U0l6j9WPow5BG3/fLKT5syvwgj2QS6unu4OTMYwom2NbnxvyXS8VNENPuw==
X-Received: by 2002:a5d:6d02:0:b0:391:2b04:73d9 with SMTP id ffacd0b85a97d-3971f511669mr9037415f8f.49.1742097950669;
        Sat, 15 Mar 2025 21:05:50 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35f7sm10982359f8f.13.2025.03.15.21.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 06/25] rqspinlock: Drop PV and virtualization support
Date: Sat, 15 Mar 2025 21:05:22 -0700
Message-ID: <20250316040541.108729-7-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6827; h=from:subject; bh=UZ8naMS1hT+7LGCLfEmfT5uEbBX3f9Jyevr2RnHN8ec=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3cNxB8Y7ML8wYp3OrW2rUAHgS5cApFt293sVR+ FUNcGiOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3AAKCRBM4MiGSL8Ryo0MD/ 97ReRi3PswH9DGAYd8NdunrsJZxOckjHjAmgCpfUiaRZykVSnDzlH/qc51eaWr0NnIeisWZ8UIFUkI jzIM3cz8kFKlXhwFkC5OIr8zKUy1nLd1KZ2VvWvTGtfiNK7FcKf4UnaPtm2h7FR7ymOEqkfRwa6Sv4 KDpMy2fYSfBwlS2zzE8lvtID6NrSQMO0nG9hZI5Vlq1gZCjr6wPcg1I4W8Yg2A3HVdq9TJesAs459g +kngV/eR+MZhuO1EKoqAhoyCPZCd04dcd4H0/wCcPMCioozsjnZ0Pa/DN9InNXE1fB2owf7rCR5D5e IDZglzG1xyPXgfH8+VJFxlCX5hKTz84v/Ew/3CT6rx8xeARZY2r2Jf9awUQd+pYCqBL8Ugzs+zgQI8 AuUcemjQLAR/CPa+I8ZnSbCaZMFh10dPUjejN/Iy/kmM0UrW++NXO3QeJwX9dDQBlV/O4GVAYCmH0V QmKi1sVhk4Ai7I32j5292bI9eoweCYwn57ZCmo/xRT/DXKexPr/MiFRPmqpaEWk4UY9ls3MvPYS9mZ Nj1/QhALuONxN9ys6+jE6eMSXgQ6Bly0zRkRx4vhY/FbDWv43MLGyjayc7Mf/dHyABAf66kMw1z4wM PNcxJIsebXTOhOAMPJvATfcKgOhdcWe0Hs5dZLIc37/5kP9BpbmTuPiGZdvg==
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

Note that we need to drop qspinlock_stat.h, as it's only relevant in
case of CONFIG_PARAVIRT_SPINLOCKS=y, but we need to keep lock_events.h
in the includes, which was indirectly pulled in before.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 91 +----------------------------------------
 1 file changed, 1 insertion(+), 90 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 93e31633c2aa..c2646cffc59e 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -11,8 +11,6 @@
  *          Peter Zijlstra <peterz@infradead.org>
  */
 
-#ifndef _GEN_PV_LOCK_SLOWPATH
-
 #include <linux/smp.h>
 #include <linux/bug.h>
 #include <linux/cpumask.h>
@@ -29,7 +27,7 @@
  * Include queued spinlock definitions and statistics code
  */
 #include "../locking/qspinlock.h"
-#include "../locking/qspinlock_stat.h"
+#include "../locking/lock_events.h"
 
 /*
  * The basic principle of a queue-based spinlock can best be understood
@@ -75,38 +73,9 @@
  * contexts: task, softirq, hardirq, nmi.
  *
  * Exactly fits one 64-byte cacheline on a 64-bit architecture.
- *
- * PV doubles the storage and uses the second cacheline for PV state.
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
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
@@ -136,12 +105,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 
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
@@ -212,7 +175,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 queue:
 	lockevent_inc(lock_slowpath);
-pv_queue:
 	node = this_cpu_ptr(&rqnodes[0].mcs);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
@@ -251,7 +213,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 
 	node->locked = 0;
 	node->next = NULL;
-	pv_init_node(node);
 
 	/*
 	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
@@ -288,7 +249,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 		/* Link @node into the waitqueue. */
 		WRITE_ONCE(prev->next, node);
 
-		pv_wait_node(node, prev);
 		arch_mcs_spin_lock_contended(&node->locked);
 
 		/*
@@ -312,23 +272,9 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
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
@@ -341,11 +287,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
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
@@ -369,7 +310,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
 	arch_mcs_spin_unlock_contended(&next->locked);
-	pv_kick_node(lock, next);
 
 release:
 	trace_contention_end(lock, 0);
@@ -380,32 +320,3 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	__this_cpu_dec(rqnodes[0].mcs.count);
 }
 EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowpath);
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
-#include "../locking/qspinlock_paravirt.h"
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
2.47.1


