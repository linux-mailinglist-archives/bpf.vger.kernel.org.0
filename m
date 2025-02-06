Return-Path: <bpf+bounces-50640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C0A2A66A
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8EB7A2487
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C37922DF8D;
	Thu,  6 Feb 2025 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEwP2l9P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CFA229B0F;
	Thu,  6 Feb 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839289; cv=none; b=W6DDvZ5umehLa+U8DX2FwS/4HGQZhNfFTFkSAeGC8vs+kYGjZMsgsQ4hmk5GqR5kwDhcHxeT4IW4mUALRkpkWLCcURc85/R+W13advrbuRbALLEItZ4fBa0rPmlOcWT9+k5SC/YPFOhxQ4qIfXv4fpxjKrQgHFhbjviFuvefQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839289; c=relaxed/simple;
	bh=r7k8qGdKN/3/qwxHoOfh+ZQmucFzyerAvWUxzRBa3Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGcDIVTCZaXmMWzH+ID5pC0KbLrZKX3jdC4tRheFiPakFGyCa9z76JM3+HY6BXqZLoGpVpxuEm1pNUPKYHazrQbyUosubtGVMzGtqndbyFkQIh4yLziLd06DZ35SVQ+tKL4/3rg/FamRow2m9ekgO0SZjhoEKwSo/QGUS4w7DC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEwP2l9P; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4361815b96cso4768575e9.1;
        Thu, 06 Feb 2025 02:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839285; x=1739444085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FML/jIvPcAoxlA62EsuMUSBptbx5cKUmte0tA2musTk=;
        b=gEwP2l9P7GKiGA5//AffMt8z4ionJ+pnOF6hktdb2ho5yxXB9qGNAJmDQjvczn8lhT
         Foqogue+a5VcVSaOaUICnlpQ4kMguNR4akiW6KPf2vvsss6q6fLgVFBBMF3ViFdqp4VW
         r5qZ89k5TcQA36NmYpJgpbAw6w7TH5yi91e3N6quI+VpOao6jYOXYHyJBui17ageYGkE
         FJiw43Et/m+LCEkoDIraRMcQzYvq+FgALM8smkry5/+OXyHodunWcQqJqMRHy76Z4Gcx
         jwc1otatVcnLTR36Osw6c9ew3XLTG6IgJu660eHnm9bkE4kuYK0FMurrQCscv0osfbwe
         LZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839285; x=1739444085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FML/jIvPcAoxlA62EsuMUSBptbx5cKUmte0tA2musTk=;
        b=XKxtVDd/1STs9UlpvP4CYUtglFsyp5Dc5SSn8LCNFp4ii0TsYZBURqMoUntk1RsWpY
         TybMGeyiYMjPU9zUJiIF+F8bfWhCFtodDvdU2T3tfWIHxUZ3pKxWrV1BtHzb66d9YuaS
         FWyPIhG03nAwmcqNL0ggVSAuexSGzGsHtvdTkGuMU4ulwyVponjoQ673ENbNE5q9hsJb
         44FM3/V3GCaHG0Co3MNSxKrDYjDjISptSpv9T9eqqzxHb1EleQeSLGQ3q4yYJQ8rOCHo
         b/QGYbnj09CeyfHPRrowkUlPqkYfwknegEP4qWEiU1oj+Km3BGh4h3bazhUtJ2/rHz/W
         XAdA==
X-Forwarded-Encrypted: i=1; AJvYcCWxSprz6xZQiXlSqFsB0eQjbeH5m37G9XAUDWvarOD62fCtFMoJk3ZbmhsYSRT1XesE/7HrU76n5CPKCoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4rB6TBF084XVTG3m3cbJqQONe9OjiZBgHpPGWtUBtliKU4zv
	FN4oQ6yYVBEGkiwf5rP6jD7A/KAsOhamSwiTi8knT1kcf1qVLNvOmnXRbsXXdE8=
X-Gm-Gg: ASbGncu4qvsQDj1niVmjqKvcRSlO2DK37kffuXkMPEswTr2YhqtqX2lbBZbGZiYuZGn
	aNhvKluyLnrtoLKEaDNsBo4A3NRPAG/68JYkPI0kN+rbUGsCd/5JEJERiVF/h69CMppRSHG1BUy
	+dUmld2DC6siAzqb6YAmRifIYGUGOJ5K7mAyW9FJAtBhxokiAGse5/43cmrKerezRfVDfO3Kkr/
	3C+do0WlbDaFEFLi+j4dE2q71jGB00D3Q+1Zf1KugRAv41rxXc5w3D3MUYsNkMFE29s/EneGyF8
	XODrgA==
X-Google-Smtp-Source: AGHT+IEOmTjECXHJOHu9cs/SJ+6ticeS7+QaeLa0eVa8SFVT2qBWkqUoeVUR/OVwzkrcdhv+Xm5HzQ==
X-Received: by 2002:a05:600c:1c90:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4390d56e3admr51732625e9.29.1738839284871;
        Thu, 06 Feb 2025 02:54:44 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:17::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43907f6741esm44971815e9.3.2025.02.06.02.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:44 -0800 (PST)
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
Subject: [PATCH bpf-next v2 06/26] rqspinlock: Drop PV and virtualization support
Date: Thu,  6 Feb 2025 02:54:14 -0800
Message-ID: <20250206105435.2159977-7-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6325; h=from:subject; bh=r7k8qGdKN/3/qwxHoOfh+ZQmucFzyerAvWUxzRBa3Nw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRkILe/Rfrs9nCkS/jAFdrxKRcYv7G3/iAaCR9O 5XUAiaGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZAAKCRBM4MiGSL8Ryt6cD/ 9T4mqw3kZqs2TP+tHKQuzgqUq8fvSH8yl7t36bQGme497vOAOYDUHMeNE4NNyj7xPtcdwP+75JT6jQ wb7DTCpWkXZuXyGsVYOqkRCTrIpl86UhY4KJl7kpw0Fu/l4dVh2eGgHzXhYTOAo3UfEW3sblt0q+J+ HtBSelQEJJ2OiEIXdozIXjKe1DouxA6jfr9ixQF5KRP3O4K0H2jeTFQw6ruH2RXH0V+42ZwyL/q4Sb j0fby9n8kP9ZDxMNUNWPVhnFWuMwb3b9rwsQZME31GLbIEi/IEz54iXXAjlwVeS8CtY3ZuiDqfn4LC 8vkJ/5biap6lg9ReRc9H8WCmVZuC1O18jeYfRVCk9BRgjFDmynobDC5PWqUEaxs/4weWUTipElhtHA 7rTqLuMsOilmIdBqGSY9cpHXiMj/9tfMraqZKztusV0dkACiFyAXpSgpqErFXM4z8J7b6tx0wu+gza wtTNXet8pwRgRUHVnbyGX81YgMCL5AQXwiOot10sXBM00IBvoKOrdjO2422YWhUOHy6sF6R5id4V9D gM4HflpQhz5PAIg3z56BGX8bWfOlfbWkA6/HEA5p+yyTD21iW/w4wyZuPUEWaHIhxlVrp81m7Ajv+d 8KZJHw5wvIc5BbaAV1NGrm4shlGp+OwQG7OPQO17A7Vq6h8oz8Q8NJUJBu4w==
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
index 18eb9ef3e908..52db60cd9691 100644
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
 	node = this_cpu_ptr(&qnodes[0].mcs);
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


