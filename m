Return-Path: <bpf+bounces-78946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7CFD20D2B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48CAB30FA430
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B852336EC0;
	Wed, 14 Jan 2026 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBCto/Bt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8053358DA
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414991; cv=none; b=mreqHXUJW2XZ/mJq8eog+yPytS4VNbqkauaHb3OjUbMe+plvJH7ACf0xRoilxlGPZOkr3a6EEWl049aElRLYNzH4Yw/CgfYop4HER3VbiYhVp3Ov79ffq+RDXpKZALhRXco9GOT7ijTt8Cobc0rZrUvV4OyLh5nyHF/7nyqT4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414991; c=relaxed/simple;
	bh=QCQq9BpicGmvZEnoeIJy72rzd9o2PVfEgCd5rKTHkbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tgqgmacza0MFRIhzaTUy+HQRu0HoFpwxu0okySojM/sqTlT0khbKM9Nmyiuaq0fpbdJdVIXSOuQaHWB7SCmIzeY/3sGiHlMG0ozgizkjf0KQY+P8H7d5A10+2HAsQzd55JW70tMouVo4iDSXXlhLjOlDgifyRMXx6jmVZZpM4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBCto/Bt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee07570deso1030755e9.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768414988; x=1769019788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxCbmjYbACAmuH6cfPfSs0M0/EBA4KjCpbocIAIYXxE=;
        b=fBCto/Btrv4eKcKkGjOwvPM3KKd3zT3NXOte6UENEXlIOVJilQNEp4svl6RnOqV5vY
         9tfPmOLE2mMUVlzvC8YS6/brqdhLJPjT7A5df0TGYnx5HEhV+2suxFpwSTeP59LrKQkV
         BMOUiUQls08c1z7GaD7QTiLfLjnWxx6OMFD4zti0ps3DUAI73IxTfJDtTe5Q6wDgbu6L
         ru7d26iXdbzJHPCNdb+wKrJXVB2kdExk2fuWORv3jCOp/Oi1s7d80Oba3lRQBBG9I/47
         NmVRIY7hIbfJwTZ8Dap6QbjhP41JmPGeEAHcJQkAf1tA9cW3VBavL4H/0o7lW6M8WEz2
         X2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414988; x=1769019788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VxCbmjYbACAmuH6cfPfSs0M0/EBA4KjCpbocIAIYXxE=;
        b=rDGBRSkt3382yy8lwHAv5RIgw+Z84k+3cFXRLJco2tT50+PJrWv3yBB/6LB2N64dWV
         dinOweI0gMKXXYbtRtwof+A3TtVCSVRstZDh5sQgojxOMG2CiH4s+41dzVVQYvVHZ4qK
         0ju9hr19d4kW5nq1PjEI0TTiuY7Nzx9lCy9qjXIrkBY+zrgbJqCYhT7Stq107lPgC8vg
         djhqdr3I1ugrju7f+CR/koycyie633Rw7I4AUSOalKOH3a7rQNKVmFGeDurcm3/AEaez
         6RNk5nThllf6VZ95xuP5534P4Qa/kDhN2mwJZl0hnBVCvav8m1wLkttsc9YhIYPSNC/c
         3LEw==
X-Gm-Message-State: AOJu0YzuIb/Lq5oaQdHqa4skdKzi6Ip/4ZNKAJef59Px7r+TjKhEtoIR
	6aFtxSDMFY1J7sac/UTZd4kWb0evG/ceuU7zyPxR/aeOeXwEB5utcMxw
X-Gm-Gg: AY/fxX6HF3K6pSqK/oOszmJH6Pi1hVsBfZ1gT2ZruBZjJxXJgsS15YxVu3hIEFCpc2M
	zNviIZG5S20SqrbGaUBb3FXZZjrqT54i4qGXK0J00uebMiH3Y7pMbsIDH5JCOaEUkQedVNMbM/6
	tVAHn7CJFQH+c521QnK+Yb5S1upiRUW8ab+arXi5zhTUdHItMs92/MH0YmUK1wvxQFD/NhSGC04
	zOpl2En84tl3b8Cu3BwAC97HV/KCaWTXcAQTFcefF6uzyx0BNR+2QjFEkHYjP2r28x00CiRFGuz
	4rMguJzovlvEWetAGKRDxii8gOEGpk61+dVr3VwWxkTE4bd1VLPcvc+XXVIJ66r8S+Elpg5KAry
	/Zlzw+uyzm3bYvcBiX9deWBAZlwU+UGCTCzDgQMRJeFWVCCZzxk69coNLrdpXdxawQKv0mH7Y4+
	fs6k+HDrjttQ==
X-Received: by 2002:a05:600c:444a:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-47ee32fd1a9mr46283125e9.10.1768414987466;
        Wed, 14 Jan 2026 10:23:07 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee6f59cf4sm13709915e9.12.2026.01.14.10.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:23:07 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 14 Jan 2026 18:22:47 +0000
Subject: [PATCH RFC v4 3/8] bpf: Enable bpf timer and workqueue use in NMI
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-timer_nolock-v4-3-fa6355f51fa7@meta.com>
References: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
In-Reply-To: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768414982; l=17628;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=hyOicM7deD468/0tl8wymZciYueZzln5pPiJ6JgUkrA=;
 b=RgBoXY1KH8EHrMD9H9XUzKNic7X5omscO1tKCI9Y8y1Q5WnclJZBQmCbbPQYRfCrHeVoKdPnB
 3CErm0Js9VcCASBirWzeFQ8+afjZ+WXD74no9JGaKjTxzTZvs0qj2vZ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor bpf timer and workqueue helpers to allow calling them from NMI
context by making all operations lock-free and deferring NMI-unsafe
work to irq_work.

Previously, bpf_timer_start(), and bpf_wq_start()
could not be called from NMI context because they acquired
bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
patch removes these limitations.

Key changes:
 * Remove bpf_spin_lock from struct bpf_async_kern. Replace locked
   operations with atomic cmpxchg() for initialization and xchg() for
   cancel and free.
 * Add per-async irq_work to defer NMI-unsafe operations (hrtimer_start,
   hrtimer_try_to_cancel, schedule_work) from NMI to softirq context.
 * Use the lock-free seqcount_latch_t to pass operation
   commands (start/cancel/free) along with their parameters
   (nsec, mode) from NMI-safe callers to the irq_work handler.
 * Add reference counting to bpf_async_cb to ensure the object stays
   alive until all scheduled irq_work completes and the timer/work
   callback finishes.
 * Move bpf_prog_put() to RCU callback to handle races between
   set_callback() and cancel_and_free().
 * Refactor __bpf_async_set_callback() getting rid of locks. The idea of
   the algorithm is to store both callback_fn and prog in struct
   bpf_async_cb and verify that both pointers are stored, if any pointer
   does not match (because of the concurrent update), retry until
   complete match.
   On each iteration, increment refcnt of the prog that is going to
   be set and decrement the one that is evicted, ensuring that get/put are
   balanced, as each iteration has both inc/dec.

This enables BPF programs attached to NMI-context hooks (perf
events) to use timers and workqueues for deferred processing.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 381 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 243 insertions(+), 138 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 19ca6e772165dd5f0015ada560acd97b2ad2c24c..b5d6938d23829b01aaa6b22ac0e2905319eb7f22 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,6 +29,7 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <linux/seqlock.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -1095,6 +1096,23 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
 	return (void *)value - round_up(map->key_size, 8);
 }
 
+enum bpf_async_type {
+	BPF_ASYNC_TYPE_TIMER = 0,
+	BPF_ASYNC_TYPE_WQ,
+};
+
+enum bpf_async_op {
+	BPF_ASYNC_START,
+	BPF_ASYNC_CANCEL,
+	BPF_ASYNC_CANCEL_AND_FREE,
+};
+
+struct bpf_async_cmd {
+	u64 nsec;
+	u32 mode;
+	u32 op;
+};
+
 struct bpf_async_cb {
 	struct bpf_map *map;
 	struct bpf_prog *prog;
@@ -1105,6 +1123,13 @@ struct bpf_async_cb {
 		struct work_struct delete_work;
 	};
 	u64 flags;
+	struct irq_work worker;
+	atomic_t writer;
+	seqcount_latch_t latch;
+	struct bpf_async_cmd cmd[2];
+	atomic_t last_seq;
+	refcount_t refcnt;
+	enum bpf_async_type type;
 };
 
 /* BPF map elements can contain 'struct bpf_timer'.
@@ -1142,18 +1167,9 @@ struct bpf_async_kern {
 		struct bpf_hrtimer *timer;
 		struct bpf_work *work;
 	};
-	/* bpf_spin_lock is used here instead of spinlock_t to make
-	 * sure that it always fits into space reserved by struct bpf_timer
-	 * regardless of LOCKDEP and spinlock debug flags.
-	 */
-	struct bpf_spin_lock lock;
+	u32 __opaque;
 } __attribute__((aligned(8)));
 
-enum bpf_async_type {
-	BPF_ASYNC_TYPE_TIMER = 0,
-	BPF_ASYNC_TYPE_WQ,
-};
-
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
@@ -1219,6 +1235,13 @@ static void bpf_async_cb_rcu_free(struct rcu_head *rcu)
 {
 	struct bpf_async_cb *cb = container_of(rcu, struct bpf_async_cb, rcu);
 
+	/*
+	 * Drop the last reference to prog only after RCU GP, as set_callback()
+	 * may race with cancel_and_free()
+	 */
+	if (cb->prog)
+		bpf_prog_put(cb->prog);
+
 	kfree_nolock(cb);
 }
 
@@ -1246,18 +1269,17 @@ static void bpf_timer_delete_work(struct work_struct *work)
 	call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free);
 }
 
+static void __bpf_async_cancel_and_free(struct bpf_async_kern *async);
+static void bpf_async_irq_worker(struct irq_work *work);
+
 static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
 			    enum bpf_async_type type)
 {
-	struct bpf_async_cb *cb;
+	struct bpf_async_cb *cb, *old_cb;
 	struct bpf_hrtimer *t;
 	struct bpf_work *w;
 	clockid_t clockid;
 	size_t size;
-	int ret = 0;
-
-	if (in_nmi())
-		return -EOPNOTSUPP;
 
 	switch (type) {
 	case BPF_ASYNC_TYPE_TIMER:
@@ -1270,18 +1292,13 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		return -EINVAL;
 	}
 
-	__bpf_spin_lock_irqsave(&async->lock);
-	t = async->timer;
-	if (t) {
-		ret = -EBUSY;
-		goto out;
-	}
+	old_cb = READ_ONCE(async->cb);
+	if (old_cb)
+		return -EBUSY;
 
 	cb = bpf_map_kmalloc_nolock(map, size, 0, map->numa_node);
-	if (!cb) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!cb)
+		return -ENOMEM;
 
 	switch (type) {
 	case BPF_ASYNC_TYPE_TIMER:
@@ -1304,9 +1321,20 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 	cb->map = map;
 	cb->prog = NULL;
 	cb->flags = flags;
+	cb->worker = IRQ_WORK_INIT(bpf_async_irq_worker);
+	seqcount_latch_init(&cb->latch);
+	atomic_set(&cb->writer, 0);
+	refcount_set(&cb->refcnt, 1); /* map's reference */
+	atomic_set(&cb->last_seq, 0);
+	cb->type = type;
 	rcu_assign_pointer(cb->callback_fn, NULL);
 
-	WRITE_ONCE(async->cb, cb);
+	old_cb = cmpxchg(&async->cb, NULL, cb);
+	if (old_cb) {
+		/* Lost the race to initialize this bpf_async_kern, drop the allocated object */
+		kfree_nolock(cb);
+		return -EBUSY;
+	}
 	/* Guarantee the order between async->cb and map->usercnt. So
 	 * when there are concurrent uref release and bpf timer init, either
 	 * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
@@ -1317,13 +1345,11 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs.
 		 */
-		WRITE_ONCE(async->cb, NULL);
-		kfree_nolock(cb);
-		ret = -EPERM;
+		__bpf_async_cancel_and_free(async);
+		return -EPERM;
 	}
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
-	return ret;
+
+	return 0;
 }
 
 BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map,
@@ -1354,56 +1380,119 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+/* Decrements bpf_async_cb refcnt, if it becomes 0 schedule cleanup irq_work */
+static void bpf_async_refcnt_dec_cleanup(struct bpf_async_cb *cb)
+{
+	if (!refcount_dec_and_test(&cb->refcnt))
+		return;
+
+	/*
+	 * At this point we took the last reference
+	 * Try to schedule cleanup, either:
+	 *  - Set ref to 1 and succeed irq_work_queue
+	 *  - See non-zero refcnt after decrement - other irq_work is going to cleanup
+	 */
+	do {
+		refcount_set(&cb->refcnt, 1);
+		if (irq_work_queue(&cb->worker))
+			break;
+	} while (refcount_dec_and_test(&cb->refcnt));
+}
+
+static int bpf_async_schedule_op(struct bpf_async_cb *cb, u32 op, u64 nsec, u32 timer_mode)
+{
+	/* Acquire active writer atomic*/
+	if (atomic_cmpxchg_acquire(&cb->writer, 0, 1))
+		return -EBUSY;
+
+	write_seqcount_latch_begin(&cb->latch);
+	cb->cmd[0].nsec = nsec;
+	cb->cmd[0].mode = timer_mode;
+	cb->cmd[0].op = op;
+	write_seqcount_latch(&cb->latch);
+	cb->cmd[1].nsec = nsec;
+	cb->cmd[1].mode = timer_mode;
+	cb->cmd[1].op = op;
+	write_seqcount_latch_end(&cb->latch);
+	atomic_set(&cb->writer, 0);
+
+	if (!refcount_inc_not_zero(&cb->refcnt))
+		return -EBUSY;
+
+	/* TODO: Run operation without irq_work if not in NMI */
+	if (!irq_work_queue(&cb->worker))
+		/* irq_work is already scheduled on this CPU */
+		bpf_async_refcnt_dec_cleanup(cb);
+
+	return 0;
+}
+
+static int bpf_async_read_op(struct bpf_async_cb *cb, enum bpf_async_op *op,
+			     u64 *nsec, u32 *flags)
+{
+	u32 seq, last_seq, idx;
+
+	while (true) {
+		last_seq = atomic_read_acquire(&cb->last_seq);
+
+		seq = raw_read_seqcount_latch(&cb->latch);
+
+		/* Return -EBUSY if current seq is consumed by another reader */
+		if (seq == last_seq)
+			return -EBUSY;
+
+		idx = seq & 1;
+		*nsec = cb->cmd[idx].nsec;
+		*flags = cb->cmd[idx].mode;
+		*op = cb->cmd[idx].op;
+
+		if (raw_read_seqcount_latch_retry(&cb->latch, seq))
+			continue;
+		/* Commit read sequence number, own snapshot exclusively */
+		if (atomic_cmpxchg_release(&cb->last_seq, last_seq, seq) == last_seq)
+			break;
+	}
+
+	return 0;
+}
+
 static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
-				    struct bpf_prog_aux *aux, unsigned int flags,
-				    enum bpf_async_type type)
+				    struct bpf_prog *prog)
 {
-	struct bpf_prog *prev, *prog = aux->prog;
+	struct bpf_prog *prev;
 	struct bpf_async_cb *cb;
-	int ret = 0;
 
-	if (in_nmi())
-		return -EOPNOTSUPP;
-	__bpf_spin_lock_irqsave(&async->lock);
-	cb = async->cb;
-	if (!cb) {
-		ret = -EINVAL;
-		goto out;
-	}
-	if (!atomic64_read(&cb->map->usercnt)) {
-		/* maps with timers must be either held by user space
-		 * or pinned in bpffs. Otherwise timer might still be
-		 * running even when bpf prog is detached and user space
-		 * is gone, since map_release_uref won't ever be called.
-		 */
-		ret = -EPERM;
-		goto out;
-	}
-	prev = cb->prog;
-	if (prev != prog) {
-		/* Bump prog refcnt once. Every bpf_timer_set_callback()
-		 * can pick different callback_fn-s within the same prog.
-		 */
+	/* Make sure bpf_async_cb_rcu_free() is not called while here */
+	guard(rcu)();
+
+	cb = READ_ONCE(async->cb);
+	if (!cb || !prog)
+		return -EINVAL;
+
+	/* Additional prog's refcnt to make sure it is not dropped to 0 in the loop */
+	prog = bpf_prog_inc_not_zero(prog);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	do {
 		prog = bpf_prog_inc_not_zero(prog);
-		if (IS_ERR(prog)) {
-			ret = PTR_ERR(prog);
-			goto out;
-		}
+		prev = xchg(&cb->prog, prog);
+		rcu_assign_pointer(cb->callback_fn, callback_fn);
+
 		if (prev)
-			/* Drop prev prog refcnt when swapping with new prog */
 			bpf_prog_put(prev);
-		cb->prog = prog;
-	}
-	rcu_assign_pointer(cb->callback_fn, callback_fn);
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
-	return ret;
+
+	} while (READ_ONCE(cb->prog) != prog || READ_ONCE(cb->callback_fn) != callback_fn);
+
+	bpf_prog_put(prog);
+
+	return 0;
 }
 
 BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
 	   struct bpf_prog_aux *, aux)
 {
-	return __bpf_async_set_callback(timer, callback_fn, aux, 0, BPF_ASYNC_TYPE_TIMER);
+	return __bpf_async_set_callback(timer, callback_fn, aux->prog);
 }
 
 static const struct bpf_func_proto bpf_timer_set_callback_proto = {
@@ -1414,22 +1503,19 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.arg2_type	= ARG_PTR_TO_FUNC,
 };
 
-BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, flags)
+BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, flags)
 {
 	struct bpf_hrtimer *t;
-	int ret = 0;
-	enum hrtimer_mode mode;
+	u32 mode;
 
-	if (in_nmi())
-		return -EOPNOTSUPP;
 	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
 		return -EINVAL;
-	__bpf_spin_lock_irqsave(&timer->lock);
-	t = timer->timer;
-	if (!t || !t->cb.prog) {
-		ret = -EINVAL;
-		goto out;
-	}
+
+	guard(rcu)();
+
+	t = READ_ONCE(async->timer);
+	if (!t || !READ_ONCE(t->cb.prog))
+		return -EINVAL;
 
 	if (flags & BPF_F_TIMER_ABS)
 		mode = HRTIMER_MODE_ABS_SOFT;
@@ -1439,10 +1525,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
 	if (flags & BPF_F_TIMER_CPU_PIN)
 		mode |= HRTIMER_MODE_PINNED;
 
-	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
-out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
-	return ret;
+	return bpf_async_schedule_op(&t->cb, BPF_ASYNC_START, nsecs, mode);
 }
 
 static const struct bpf_func_proto bpf_timer_start_proto = {
@@ -1454,17 +1537,6 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static void drop_prog_refcnt(struct bpf_async_cb *async)
-{
-	struct bpf_prog *prog = async->prog;
-
-	if (prog) {
-		bpf_prog_put(prog);
-		async->prog = NULL;
-		rcu_assign_pointer(async->callback_fn, NULL);
-	}
-}
-
 BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 {
 	struct bpf_hrtimer *t, *cur_t;
@@ -1532,27 +1604,16 @@ static const struct bpf_func_proto bpf_timer_cancel_proto = {
 	.arg1_type	= ARG_PTR_TO_TIMER,
 };
 
-static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *async)
+static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
 {
 	struct bpf_async_cb *cb;
 
-	/* Performance optimization: read async->cb without lock first. */
-	if (!READ_ONCE(async->cb))
-		return NULL;
-
-	__bpf_spin_lock_irqsave(&async->lock);
-	/* re-read it under lock */
-	cb = async->cb;
+	cb = xchg(&async->cb, NULL);
 	if (!cb)
-		goto out;
-	drop_prog_refcnt(cb);
-	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
-	 * this timer, since it won't be initialized.
-	 */
-	WRITE_ONCE(async->cb, NULL);
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
-	return cb;
+		return;
+
+	/* Consume map's own refcnt, schedule cleanup irq_work if this is the last ref */
+	bpf_async_refcnt_dec_cleanup(cb);
 }
 
 static void bpf_timer_delete(struct bpf_hrtimer *t)
@@ -1607,19 +1668,76 @@ static void bpf_timer_delete(struct bpf_hrtimer *t)
 	}
 }
 
+static void bpf_async_process_op(struct bpf_async_cb *cb, u32 op,
+				 u64 timer_nsec, u32 timer_mode)
+{
+	switch (cb->type) {
+	case BPF_ASYNC_TYPE_TIMER: {
+		struct bpf_hrtimer *t = container_of(cb, struct bpf_hrtimer, cb);
+
+		switch (op) {
+		case BPF_ASYNC_START:
+			hrtimer_start(&t->timer, ns_to_ktime(timer_nsec), timer_mode);
+			break;
+		case BPF_ASYNC_CANCEL:
+			hrtimer_try_to_cancel(&t->timer);
+			break;
+		case BPF_ASYNC_CANCEL_AND_FREE:
+			bpf_timer_delete(t);
+			break;
+		default:
+			break;
+		}
+		break;
+	}
+	case BPF_ASYNC_TYPE_WQ: {
+		struct bpf_work *w = container_of(cb, struct bpf_work, cb);
+
+		switch (op) {
+		case BPF_ASYNC_START:
+			schedule_work(&w->work);
+			break;
+		case BPF_ASYNC_CANCEL_AND_FREE:
+			/*
+			 * Trigger cancel of the sleepable work, but *do not* wait for
+			 * it to finish.
+			 * kfree will be called once the work has finished.
+			 */
+			schedule_work(&w->delete_work);
+			break;
+		default:
+			break;
+		}
+		break;
+	}
+	}
+}
+
+static void bpf_async_irq_worker(struct irq_work *work)
+{
+	struct bpf_async_cb *cb = container_of(work, struct bpf_async_cb, worker);
+	u32 op, timer_mode;
+	u64 nsec;
+	int err;
+
+	err = bpf_async_read_op(cb, &op, &nsec, &timer_mode);
+	if (err)
+		goto out;
+
+	bpf_async_process_op(cb, op, nsec, timer_mode);
+
+out:
+	if (refcount_dec_and_test(&cb->refcnt))
+		bpf_async_process_op(cb, BPF_ASYNC_CANCEL_AND_FREE, 0, 0);
+}
+
 /*
  * This function is called by map_delete/update_elem for individual element and
  * by ops->map_release_uref when the user space reference to a map reaches zero.
  */
 void bpf_timer_cancel_and_free(void *val)
 {
-	struct bpf_hrtimer *t;
-
-	t = (struct bpf_hrtimer *)__bpf_async_cancel_and_free(val);
-	if (!t)
-		return;
-
-	bpf_timer_delete(t);
+	__bpf_async_cancel_and_free(val);
 }
 
 /* This function is called by map_delete/update_elem for individual element and
@@ -1627,19 +1745,7 @@ void bpf_timer_cancel_and_free(void *val)
  */
 void bpf_wq_cancel_and_free(void *val)
 {
-	struct bpf_work *work;
-
-	BTF_TYPE_EMIT(struct bpf_wq);
-
-	work = (struct bpf_work *)__bpf_async_cancel_and_free(val);
-	if (!work)
-		return;
-	/* Trigger cancel of the sleepable work, but *do not* wait for
-	 * it to finish if it was running as we might not be in a
-	 * sleepable context.
-	 * kfree will be called once the work has finished.
-	 */
-	schedule_work(&work->delete_work);
+	__bpf_async_cancel_and_free(val);
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
@@ -3112,16 +3218,15 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
 	struct bpf_work *w;
 
-	if (in_nmi())
-		return -EOPNOTSUPP;
 	if (flags)
 		return -EINVAL;
+
+	guard(rcu)();
 	w = READ_ONCE(async->work);
 	if (!w || !READ_ONCE(w->cb.prog))
 		return -EINVAL;
 
-	schedule_work(&w->work);
-	return 0;
+	return bpf_async_schedule_op(&w->cb, BPF_ASYNC_START, 0, 0);
 }
 
 __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
@@ -3135,7 +3240,7 @@ __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 	if (flags)
 		return -EINVAL;
 
-	return __bpf_async_set_callback(async, callback_fn, aux, flags, BPF_ASYNC_TYPE_WQ);
+	return __bpf_async_set_callback(async, callback_fn, aux->prog);
 }
 
 __bpf_kfunc void bpf_preempt_disable(void)

-- 
2.52.0


