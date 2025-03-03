Return-Path: <bpf+bounces-53075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2463A4C4EA
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2B218871FE
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87058218ABA;
	Mon,  3 Mar 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAmJ6Ovl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F30215F47;
	Mon,  3 Mar 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015402; cv=none; b=PytKtH8+4l9R2MXyCJWoh9u1msihL13y1d/xhwfRZ9PlKC2uRhgdGuT7GMJKh5dhDdBtJT076AcYxSZqxR4S7CLqI1Ye3xxgO8TNNkAP81iqAix0tFc0rXK5Sn4q9l51ugJG36ggFXJS1r6kYlrrTUYOWhN1hsf9rvuGujZcQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015402; c=relaxed/simple;
	bh=x1Z+pB9xhs3i58kf9Kac9b92frWP4j0eHxNENfgFcNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJLlOZ8c1FffY9PW1elBlQxNvyY59jWu5jvf6VJ/OnCALkGIlUoo1KKjfVuqaPIeZwshIYrmQnlWBKAUNygKssaEkDy86S9vll9qATuq7Ax0VQlfQaEYMvc6ZQjb9+jIHao+1jv8Z5MYKGOCZxc0l7+WS2cd6tFxWgCC+KTfxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAmJ6Ovl; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-390eebcc331so1731940f8f.1;
        Mon, 03 Mar 2025 07:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015398; x=1741620198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWj7fRL2wjv9R4mziQW8bTTqGP2D1A3sv3W8wRB2IlU=;
        b=KAmJ6Ovlw8Jt9GHtuTHvPLmuzQDOPF+RqYkQY64cqbMXNpK2DlMu3jNeSUmdxI59Yk
         dPFzwVMKDm/qkkYtDSn6UHFAkl6B5S5UJlKupOj1C792RrJ8g21f8VhEbMi5BET+lhuk
         rkdq/uM06WZZWMTjhZoiyLfzqb9yb8V+ovRKXZ2fTzIMKLOZxK0y9dK2EvG9QLY/ZbIL
         MIAfPSIFdaCe57Cz4/A5fvikEQG03FTZ8JxMDLBeEF9Qd7iQvJ98aiwmyOtrbA1x539X
         6bMk7OCHij3C4wymzEwcxCWZJgkXKORwEVTdg77WS5rpfzwXThbFWoPJzhe30kNMQFoo
         GdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015398; x=1741620198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWj7fRL2wjv9R4mziQW8bTTqGP2D1A3sv3W8wRB2IlU=;
        b=Z1qn92tpH1LDlXSIyGrV5JxrYVbHX3EC1iWGAUQjrHHgyZWVvLmv0HOK0Ynl5qct3a
         /HlD8TigSnqmsIPVQD5GxB+0WfXKyqNLZOcywuDTv3ZKAzl1OWMt0eL4KaxJQ42XOvTq
         iu7YWXdnp4671S3cc9n/inf380ifmHDZulDaMCh/vrWgOYqqrKKkLLkLABcqKTicAIiq
         piZHf/BvEycjBfe3ksDebFR2bd3nkApzlH1+Xn4oqNesCFB9D8SdlrzLXzfyMSBFte5T
         7Rjwu6ZRIrR9AXfONd3g5NPoJwgKAO4IG/0BX+VYXXScrNsOByjhKdNL7In7JGJs39pl
         k1nw==
X-Forwarded-Encrypted: i=1; AJvYcCV6L/TU9/KIj7ELbNAC2V0/hx3ZsrYgWoFCSANWsWZoy7Dnpyg2Qhr2CnW/NBKtpeLheX1ZTLw/fGCi558=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMN+CUP30Z10lZddrnkbNOnZtiiFxowgYBXeBFWoD2lXHd/8Nk
	6q/4gJxznRE69nnW/clJq1QvkBhew8+3ArLht8OdapaRBjglRja6m0nGePCUCG4=
X-Gm-Gg: ASbGncvWxGjY/HGdYLSZtZidpYoCbTJcu4rIDinWqNJHOoNhoq9xk6j5OepRUwsMrQF
	9aDqnFAO2ETvF+V6+9yRinX/oTA8JnCQgcQBwbUgWWrH7F9Cj9rIdcBPbYPx9ZtRHNx0ks8aYHR
	aRx9BY6YRyDzVPEGMePyecvK9jQKVERqYtUUUBlg9R3IJTLUEXeUsNaeA9BaVrpc/Bovz8IRMsB
	H3VAxES21wKUh7UXa9docIBDE99uXukNUQSZWIk+h9NV+VgnuE/yd581W671SBDDfbb77/G7HuN
	1BSTS9MJZRt2X7gfkSi2dULp6umTRaelNA==
X-Google-Smtp-Source: AGHT+IFjm+ROX4Lt+V90Jn3TMk492UXdruKl3KBdRoIEAwuyla143y7WSrkvsYEZT3Xx7lgzY1sCvw==
X-Received: by 2002:a05:6000:1787:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-390e15da77amr15041952f8f.0.1741015397860;
        Mon, 03 Mar 2025 07:23:17 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f8034sm169770555e9.4.2025.03.03.07.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:17 -0800 (PST)
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
Subject: [PATCH bpf-next v3 06/25] rqspinlock: Drop PV and virtualization support
Date: Mon,  3 Mar 2025 07:22:46 -0800
Message-ID: <20250303152305.3195648-7-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6795; h=from:subject; bh=x1Z+pB9xhs3i58kf9Kac9b92frWP4j0eHxNENfgFcNU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWWAhlIoArRUBi9+QCUAqMzXrVAKF0JtHZdQgoX fPFJU92JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlgAKCRBM4MiGSL8RygwXEA DAmIu9BajEdITHz1mKPuYwgeMXa7iRtPHxfqCpPmzf/TH+bsToJCV02MBZgALM6kWCm/5rAUSraLhw BnMrlVK/RcAw8Kxjwu1xmv4nZtV3SYbVUGx9WVMII5Oeyew86x2PDffmVG2n1obhHHjW3irYV8YsdE Yp1hHfinMz7/BSq/yV3BC5t/Xnfyeqm/J8YZY2QWNJBC4EKexPFCjmswgCSAaSFCcxhApWXXJzknMU MFRWSRvdZ44k9m+DhbcggcjpFSytSET3RxyTw4yuiGnXVqdQBBg0JBdMGJz/TatR2aEVIb7cJrYFAg j53Yifny9409xdRc2gl46en9AmpDm3/WgCsa0MG4u2UZyRfxyJFucVeD8D37S0ybhHJqnoRd8Idhi7 QmQz4h/wP2rzNMb9gJ5XgohE5pZ2V72I2JHpPuL7p4uQ5QTqHm+xQyirFjDGGmfxNDIuH/1w//0thM DL6ypO4I4NPgIyNpKI0IVWdOcJ4sbxDX2seupxCRksDYYMwlRTYnEPgbMhqobCiAvBuEuRRvINLHkc gdFHigGRIq+ZNPJc74y2xJvhNd4dehMSg8IlVcZDLDmYHHHUCDiHbmlnJLWJ+hw/5iLNlSJtmRadiM JCiKxpddvVm6tqQTMDIdqvcgLcDn7u2gAg21mmdVh/8SvCqLxQsKxzk73jWA==
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
 kernel/locking/rqspinlock.c | 91 +------------------------------------
 1 file changed, 1 insertion(+), 90 deletions(-)

diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 414a3ec8cf70..98cdcc5f1784 100644
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
@@ -29,7 +27,7 @@
  * Include queued spinlock definitions and statistics code
  */
 #include "qspinlock.h"
-#include "qspinlock_stat.h"
+#include "lock_events.h"
 
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


