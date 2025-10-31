Return-Path: <bpf+bounces-73210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96998C27183
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 23:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6EF3B5F4E
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418FD329E6E;
	Fri, 31 Oct 2025 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdG1Nw2B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA932ABE0
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947946; cv=none; b=bpK56kcZXLfjBl1k/ti9ocRJa2I7xxI5BLVYfActLbHo771rwK4+tJ8uA5aLZlCkVqU0q52BNznIfB8tGaup7tZId4iYkaZm8/8/iDPTbn6i/VGbai9twGxQwGkDSQ422ikxoW2uiNmrpE4W91q7duOMJe/SQvK+NT3JlSzzaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947946; c=relaxed/simple;
	bh=navg83KBUL2709Hfky7gAzBdw5RS4UsBcBQqGg82Cek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxyyKSmQzTgEhBFy6gXPPL7ha1bpq08TZs8EsNzHXQuQuYr1iHGbiNjbrU1dUQU3hVhiasUbKxlwN25pqZXx4Ip0ZzWn+suvhFLyfhqYz3gMd0k58vTSRPBoPxtvSNuZlHQn/zfW5GT1nDTUjDPNxIutVbV6IK6L0aPY+rIO38I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdG1Nw2B; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so26008685e9.1
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 14:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761947943; x=1762552743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIVEtI3d+1lAQLb6CbLYCFZ0qnCZr5TerWPq7Bo8Sao=;
        b=FdG1Nw2B7wsszPXBmZkwmOZYPtaG+xXp8q19TWrXMErdJTVehSwfeGQ9F+8KZjkgyZ
         MCRCm7Q+T4UZT2EFG4u2wRVfVh/khfiMxrdUE9ThERjnHBcxoETZiQlfBlN7m7bVUW75
         67wK11TQks0jyb8ClhRcSTUGrC+M5ioz9LtywfddqNbr5tvS803HaZJIER9lMPHYSq9g
         OOd0jQuHUS9z8rECcGwU5ROl0fSOrQunVMpVqGIRN/4RFLYpTOepsAZ7j+/qwWbldpBS
         6jGIm9dpWYrfT8d2r4m/S7viJYKMt4USxdn6mLfbRMp5LYqvHFCzXW0T8SE06aB51/Eb
         75ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761947943; x=1762552743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIVEtI3d+1lAQLb6CbLYCFZ0qnCZr5TerWPq7Bo8Sao=;
        b=Pj7IRDqNSDpDGpW+YEmT+AKMbNwfwrRcxci1dET7SesI6Zrg1rpk3HajC7bycAUvHn
         kMv+FBHCogj7HHSzb6VAiIeQCiEA8YpWpS4pcrVflEnyzLBWdpgtlE295fnwg6+noNVP
         oCfQ3r4/wgvvsFN1AO1FbRhm8ODAj26KJL1UYE2hdiIc2vGIS0I16Xnz7IxhJbetkGQa
         lUILNchbdr6EBRMBn3gConXVi/ZDtxNDA9zX/DzvkLq8n8u5Hkmq37QzJcXqHZAmbbVv
         1xF2QtyhiuHs32g3ugKBblY7ZFY+I0Rt5eiAWVuVhqjE/8w41Mnxb6WDYiGWj/pHolC2
         4+rg==
X-Gm-Message-State: AOJu0YyBAgXS61RMxdJplLFOUd+UlzcGQMe4b12A4oQm+JG7d7skHwJT
	arEZaubw5wIoG2eoiDbOPyR58Qug4bvafy3idQponEXrF4PnGSbEWs6+S9y67A==
X-Gm-Gg: ASbGncvrsyTq9kMcv1DSYJ0k0tTXsYLBkem49+H2gcmrIO7QD5jnFFVayMm6W5Hciss
	+3uDhfl1RnvRGHUqtGLNIBGh/TrO/sRjs3F7SRq61yE9RXs1g1o1zaLaZrwHoMP+Hg+SvobelAD
	0OvygN+2pc8ScTWajRVhI6xGAoHqmu4ICaWpHvVmDwwwZj9bow0H/98iSfU8s67m/oKJfrcSx1D
	BKakmeK3L4Z7qb8B1wVsagxAePQnna913P5HhrH5HYNK2e+lEGTXOArpP+6td0OvTrjE3H7f4NV
	plyztu5D4OApF3h4HbqC3EIFxmxlQNo5NNBZndqZkz6CpivCSsr78P6vt5M2MiPR12LASPOAO/B
	NdHm+5SeLW2t8tgRPfoPolNbKhxSzKO26sx7g7AxKZ+xBe0SX6LqGXiT1c/FcWOeHPhSvQfgNS2
	CR2gdbOKPOOTVXCQ==
X-Google-Smtp-Source: AGHT+IGrL+POutZ2H5Fdk8PNGlsqao2mRcOwG8y5E/+KCYHOftf2iiJXy34KmXNNfPboFowmLeBAPQ==
X-Received: by 2002:a05:600c:5307:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-47730890cd5mr53891875e9.31.1761947942563;
        Fri, 31 Oct 2025 14:59:02 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c55dc6fsm14840275e9.14.2025.10.31.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 14:59:01 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH RFC v1 5/5] bpf: remove lock from bpf_async_cb
Date: Fri, 31 Oct 2025 21:58:35 +0000
Message-ID: <20251031-timer_nolock-v1-5-bf8266d2fb20@meta.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
References: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove lock from bpf_async_cb, refactor bpf_timer and bpf_wq kfuncs and
helpers to run without it.
bpf_async_cb lifetime is managed by the refcnt and RCU, so every
function that uses it has to apply RCU guard.
cancel_and_free() path detaches bpf_async_cb from the map value (struct
bpf_async_kern) and sets the state to the terminal BPF_ASYNC_FREED
atomically, concurrent readers may operate on detached bpf_async_cb
safely under RCU read lock.

Guarantee safe bpf_prog drop from the bpf_async_cb by handling
BPF_ASYNC_FREED state in bpf_async_update_callback().

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 201 +++++++++++++++++++++++++++------------------------
 1 file changed, 106 insertions(+), 95 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3d9b370e47a1528e75cade3fe4a43c946200e63a..75834338558929cbd0b02a9823629d8be946fb18 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1092,6 +1092,12 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
 	return (void *)value - round_up(map->key_size, 8);
 }
 
+enum bpf_async_state {
+	BPF_ASYNC_READY,
+	BPF_ASYNC_BUSY,
+	BPF_ASYNC_FREED,
+};
+
 struct bpf_async_cb {
 	struct bpf_map *map;
 	struct bpf_prog *prog;
@@ -1103,6 +1109,7 @@ struct bpf_async_cb {
 	};
 	u64 flags;
 	refcount_t refcnt;
+	enum bpf_async_state state;
 };
 
 /* BPF map elements can contain 'struct bpf_timer'.
@@ -1140,11 +1147,6 @@ struct bpf_async_kern {
 		struct bpf_hrtimer *timer;
 		struct bpf_work *work;
 	};
-	/* bpf_spin_lock is used here instead of spinlock_t to make
-	 * sure that it always fits into space reserved by struct bpf_timer
-	 * regardless of LOCKDEP and spinlock debug flags.
-	 */
-	struct bpf_spin_lock lock;
 } __attribute__((aligned(8)));
 
 enum bpf_async_type {
@@ -1276,7 +1278,7 @@ static void bpf_timer_delete_work(struct work_struct *work)
 static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
 			    enum bpf_async_type type)
 {
-	struct bpf_async_cb *cb;
+	struct bpf_async_cb *cb, *old_cb;
 	struct bpf_hrtimer *t;
 	struct bpf_work *w;
 	clockid_t clockid;
@@ -1297,18 +1299,13 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		return -EINVAL;
 	}
 
-	__bpf_spin_lock_irqsave(&async->lock);
-	t = async->timer;
-	if (t) {
-		ret = -EBUSY;
-		goto out;
-	}
+	cb = READ_ONCE(async->cb);
+	if (cb)
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
@@ -1331,9 +1328,16 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 	cb->map = map;
 	cb->prog = NULL;
 	cb->flags = flags;
+	cb->state = BPF_ASYNC_READY;
 	rcu_assign_pointer(cb->callback_fn, NULL);
+	refcount_set(&cb->refcnt, 1); /* map's own ref */
 
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
@@ -1344,12 +1348,17 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs.
 		 */
-		WRITE_ONCE(async->cb, NULL);
-		kfree_nolock(cb);
-		ret = -EPERM;
+		switch (type) {
+		case BPF_ASYNC_TYPE_TIMER:
+			bpf_timer_cancel_and_free(async);
+			break;
+		case BPF_ASYNC_TYPE_WQ:
+			bpf_wq_cancel_and_free(async);
+			break;
+		}
+		return -EPERM;
 	}
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
+
 	return ret;
 }
 
@@ -1398,41 +1407,42 @@ static int bpf_async_swap_prog(struct bpf_async_cb *cb, struct bpf_prog *prog)
 		if (IS_ERR(prog))
 			return PTR_ERR(prog);
 	}
+	/* Make sure only one thread runs bpf_prog_put() */
+	prev = xchg(&cb->prog, prog);
 	if (prev)
 		/* Drop prev prog refcnt when swapping with new prog */
 		bpf_prog_put(prev);
 
-	cb->prog = prog;
 	return 0;
 }
 
-static int bpf_async_update_callback(struct bpf_async_kern *async, void *callback_fn,
+static int bpf_async_update_callback(struct bpf_async_cb *cb, void *callback_fn,
 				     struct bpf_prog *prog)
 {
-	struct bpf_async_cb *cb;
+	enum bpf_async_state state;
 	int err = 0;
 
-	__bpf_spin_lock_irqsave(&async->lock);
-	cb = async->cb;
-	if (!cb) {
-		err = -EINVAL;
-		goto out;
-	}
-	if (!atomic64_read(&cb->map->usercnt)) {
-		/* maps with timers must be either held by user space
-		 * or pinned in bpffs. Otherwise timer might still be
-		 * running even when bpf prog is detached and user space
-		 * is gone, since map_release_uref won't ever be called.
-		 */
-		err = -EPERM;
-		goto out;
-	}
+	state = cmpxchg(&cb->state, BPF_ASYNC_READY, BPF_ASYNC_BUSY);
+	if (state == BPF_ASYNC_BUSY)
+		return -EBUSY;
+	if (state == BPF_ASYNC_FREED)
+		goto drop;
 
 	err = bpf_async_swap_prog(cb, prog);
 	if (!err)
 		rcu_assign_pointer(cb->callback_fn, callback_fn);
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
+
+	state = cmpxchg(&cb->state, BPF_ASYNC_BUSY, BPF_ASYNC_READY);
+	if (state == BPF_ASYNC_FREED) {
+		/*
+		 * cb is freed concurrently, we may have overwritten prog and callback,
+		 * make sure to drop them
+		 */
+drop:
+		bpf_async_swap_prog(cb, NULL);
+		rcu_assign_pointer(cb->callback_fn, NULL);
+		return -EPERM;
+	}
 	return err;
 }
 
@@ -1441,11 +1451,18 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 				    enum bpf_async_type type)
 {
 	struct bpf_prog *prog = aux->prog;
+	struct bpf_async_cb *cb;
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
 
-	return bpf_async_update_callback(async, callback_fn, prog);
+	guard(rcu)();
+
+	cb = READ_ONCE(async->cb);
+	if (!cb)
+		return -EINVAL;
+
+	return bpf_async_update_callback(cb, callback_fn, prog);
 }
 
 BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
@@ -1462,7 +1479,7 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.arg2_type	= ARG_PTR_TO_FUNC,
 };
 
-BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, flags)
+BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, flags)
 {
 	struct bpf_hrtimer *t;
 	int ret = 0;
@@ -1472,12 +1489,19 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
 		return -EOPNOTSUPP;
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
+	if (!t)
+		return -EINVAL;
+
+	/*
+	 * Hold ref while scheduling timer, to make sure, we only cancel and free after
+	 * hrtimer_start().
+	 */
+	if (!bpf_async_tryget(&t->cb))
+		return -EINVAL;
 
 	if (flags & BPF_F_TIMER_ABS)
 		mode = HRTIMER_MODE_ABS_SOFT;
@@ -1488,8 +1512,8 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
 		mode |= HRTIMER_MODE_PINNED;
 
 	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
-out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
+
+	bpf_async_put(&t->cb, BPF_ASYNC_TYPE_TIMER);
 	return ret;
 }
 
@@ -1502,18 +1526,7 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
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
-BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
+BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 {
 	struct bpf_hrtimer *t, *cur_t;
 	bool inc = false;
@@ -1521,13 +1534,12 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
-	rcu_read_lock();
-	__bpf_spin_lock_irqsave(&timer->lock);
-	t = timer->timer;
-	if (!t) {
-		ret = -EINVAL;
-		goto out;
-	}
+
+	guard(rcu)();
+
+	t = READ_ONCE(async->timer);
+	if (!t)
+		return -EINVAL;
 
 	cur_t = this_cpu_read(hrtimer_running);
 	if (cur_t == t) {
@@ -1563,16 +1575,15 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 		goto out;
 	}
 drop:
-	drop_prog_refcnt(&t->cb);
+	bpf_async_update_callback(&t->cb, NULL, NULL);
 out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
 	/* Cancel the timer and wait for associated callback to finish
 	 * if it was running.
 	 */
 	ret = ret ?: hrtimer_cancel(&t->timer);
 	if (inc)
 		atomic_dec(&t->cancelling);
-	rcu_read_unlock();
+
 	return ret;
 }
 
@@ -1587,22 +1598,17 @@ static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *a
 {
 	struct bpf_async_cb *cb;
 
-	/* Performance optimization: read async->cb without lock first. */
-	if (!READ_ONCE(async->cb))
-		return NULL;
-
-	__bpf_spin_lock_irqsave(&async->lock);
-	/* re-read it under lock */
-	cb = async->cb;
-	if (!cb)
-		goto out;
-	drop_prog_refcnt(cb);
-	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
+	/*
+	 * The subsequent bpf_timer_start/cancel() helpers won't be able to use
 	 * this timer, since it won't be initialized.
 	 */
-	WRITE_ONCE(async->cb, NULL);
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
+	cb = xchg(&async->cb, NULL);
+	if (!cb)
+		return NULL;
+
+	/* cb is detached, set state to FREED, so that concurrent users drop it */
+	xchg(&cb->state, BPF_ASYNC_FREED);
+	bpf_async_update_callback(cb, NULL, NULL);
 	return cb;
 }
 
@@ -1670,7 +1676,7 @@ void bpf_timer_cancel_and_free(void *val)
 	if (!t)
 		return;
 
-	bpf_timer_delete(t);
+	bpf_async_put(&t->cb, BPF_ASYNC_TYPE_TIMER); /* Put map's own reference */
 }
 
 /* This function is called by map_delete/update_elem for individual element and
@@ -1685,12 +1691,8 @@ void bpf_wq_cancel_and_free(void *val)
 	work = (struct bpf_work *)__bpf_async_cancel_and_free(val);
 	if (!work)
 		return;
-	/* Trigger cancel of the sleepable work, but *do not* wait for
-	 * it to finish if it was running as we might not be in a
-	 * sleepable context.
-	 * kfree will be called once the work has finished.
-	 */
-	schedule_work(&work->delete_work);
+
+	bpf_async_put(&work->cb, BPF_ASYNC_TYPE_WQ); /* Put map's own reference */
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
@@ -3169,11 +3171,20 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 		return -EOPNOTSUPP;
 	if (flags)
 		return -EINVAL;
+
+	guard(rcu)();
+
 	w = READ_ONCE(async->work);
 	if (!w || !READ_ONCE(w->cb.prog))
 		return -EINVAL;
 
+	if (!bpf_async_tryget(&w->cb))
+		return -EINVAL;
+
 	schedule_work(&w->work);
+
+	bpf_async_put(&w->cb, BPF_ASYNC_TYPE_WQ);
+
 	return 0;
 }
 

-- 
2.51.1

