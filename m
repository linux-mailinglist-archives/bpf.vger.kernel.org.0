Return-Path: <bpf+bounces-73669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC7CC369D8
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 17:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5909C662774
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622E3328E1;
	Wed,  5 Nov 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOxgaeym"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622DD3328F1
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358359; cv=none; b=aiXwhrnJL6MC/fOl5uehGVgs/wPvgEaC4cwwK4RU3RzmCgsIFFsjzPMqQdfipa2nYODY37oD3MXQ7mPXgE3P7Ca4HwNz8VrTzBJBjH5or0evDvtJ5TETq8ERk6ASyiEQIlkGo1cVQmkUbZaggcculud844ZJJUlKBoY53Ifwivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358359; c=relaxed/simple;
	bh=t3zRb3f/e2CK9xsKTWl9p3kmYPk4ngFmhm3RwfZxqNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YieK0nbl/pO4fIdWOF4MniQhMK5IQ9MdMEc7Yw80X/X4i2l2SO8gY8fQmhHqi29sJG/tnsbJPfWiL3qSPwOwnai9mAfVW/bR8h6Wooc0T319dVshOGpwc4sh3GShccEuqQLVi9Eb4w14wnfEQGhdY2us1bCsHmgWkSGGK5B0Dr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOxgaeym; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429b895458cso4674433f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 07:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358356; x=1762963156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHzRhCi/dDjKMqCfqrUpQgRO03jzLrilrpRO+/11gPE=;
        b=WOxgaeymD5Qj+f1NajLwx5mJ1Fg6/bORf8c/PA30yeWlGRHH8u3JCuhTEC+lNEEm37
         9CMSdIpyhoevNf0Fk6tm6oRwNRV7Kwslbhova0wum7X74V0B1D6/af9R34/ayCap1yS5
         ZvsTkLLVi5ahmvVAOOAWwFxpV3iypsW7Tm8pxT+2xznoD/ALl+ETeEmJE6pW9JRi8REr
         YoWRUN3PYM/VZuKz3KX6d65qoDkX5srd5saJsErNeJbVze8ixF2lk8NYOQ0k017xcESA
         dYTzxwzPwu2/iL6lBWTexfbmaUVdRyCN5anvfyUQgWOaETWpglrWH4xDTbtbtAHlSTd8
         yR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358356; x=1762963156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHzRhCi/dDjKMqCfqrUpQgRO03jzLrilrpRO+/11gPE=;
        b=n3WIts88bVzlKN1K2gSmH+1Wv5cZGwlJq2P7ZWJs69qno/nF7RamLEp91juUqbFKyn
         vP2q3zFqxgvsQvpZHZMI54QJbFlp1SzARrdN5/5fo/oF+bK8q0QeFxjQIemod1T/7jjN
         PruWWh1GfoDsS9rqnwhtsUc4tKLf22+PNhSh74COu7MBr+RefBM6N0Ssb5wEZ8kMoUiO
         u7xNQ+BXu4hXNMtzyXMRZxWSZmlD1tb9wiJ3q2S3v6pKGZGa/cuLowasCeMEJHUvxXy1
         NMJSPwHMHSc0bGDBwMEjs3RWNOpBVlWOA/nRzGBUVaGF8Lxcet/uSjYaTObgtkEVxE4I
         TY0g==
X-Gm-Message-State: AOJu0YzcnNUZbrRug5Dq0TmIU+DWeHfOO/h9Hk2Gt14LEAYlJOlD9kbP
	eXr3MA0MV+8v7WTKRyIGi7rn++KX1DeZvHAMSR84ndVtWKG063Hbg2em
X-Gm-Gg: ASbGncsjRlkwKyw1p+XXMaoxuFlI6cqGjqKRMfBkahjchjD+I5KQuy4Blch5xkcdEU1
	0RQLl8mTwoU4QHlO0vEhT98pF1KHjVLav/KFvwnJVg8kbi/B4lZwG0EZyF0u5wgZIsKbnEIeSyW
	YZLF0eHjwHVwbitWA0JMBONFKg5Az1aSUMSyhOptlJ/rH0QeeOJoOrG1VClOPay/znzRAqJO23s
	oARM+VomFArHEsUSKhSb3EqldlB40JjzpGMcU6uqZCcEWDn3gBYxysg6l1ras1qpXxTHLqBq1Jd
	YDnFi1vGxkzLV7+UUsppfWUorpMdaPXxozns3Xv6hS4kzm6iECxGmqJRHLfczK9H6BxVh1EXL4m
	Wm0i4D92cvuZZYtHT7N/dwh9UFY1bx8iBEUv5hM6wqTurpTbthp3luSexIZ7w
X-Google-Smtp-Source: AGHT+IGZAGfcr+wBTnAnsxnuAh7ErUxMGovMHoU5r3/d9i1KwSLRQOIILFIcJV5ZYuyOh2m8wgHMig==
X-Received: by 2002:a05:6000:2dc6:b0:429:dbed:28fb with SMTP id ffacd0b85a97d-429e32e46aamr3273979f8f.23.1762358354477;
        Wed, 05 Nov 2025 07:59:14 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:64d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc192a96sm11764098f8f.13.2025.11.05.07.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:59:14 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 05 Nov 2025 15:59:07 +0000
Subject: [PATCH RFC v2 5/5] bpf: remove lock from bpf_async_cb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-timer_nolock-v2-5-32698db08bfa@meta.com>
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
In-Reply-To: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762358348; l=10558;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=ew3A5d1714wrtdaWhTHLsU0tSTqd9UEWSY2Z/Rusukk=;
 b=7EdGSEzIBlxIz3cBgFYEh58ehM6PgNzs7rh8t/v1TJUcf073vwuy76xvYVwditiayneY9Z+Ce
 axk969Ib9NOBr0lp3Xm+KkLKJn2A1e+aR3psW/L/Jom6tb187nO9qxm
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

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
 kernel/bpf/helpers.c | 190 +++++++++++++++++++++++++++------------------------
 1 file changed, 102 insertions(+), 88 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1cd4011faca519809264b2152c7c446269bee5de..75834338558929cbd0b02a9823629d8be946fb18 100644
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
@@ -1331,10 +1328,16 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 	cb->map = map;
 	cb->prog = NULL;
 	cb->flags = flags;
+	cb->state = BPF_ASYNC_READY;
 	rcu_assign_pointer(cb->callback_fn, NULL);
 	refcount_set(&cb->refcnt, 1); /* map's own ref */
 
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
@@ -1345,12 +1348,17 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
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
 
@@ -1399,41 +1407,42 @@ static int bpf_async_swap_prog(struct bpf_async_cb *cb, struct bpf_prog *prog)
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
 
@@ -1442,11 +1451,18 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
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
@@ -1463,7 +1479,7 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.arg2_type	= ARG_PTR_TO_FUNC,
 };
 
-BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, flags)
+BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, flags)
 {
 	struct bpf_hrtimer *t;
 	int ret = 0;
@@ -1473,12 +1489,19 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
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
@@ -1489,8 +1512,8 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
 		mode |= HRTIMER_MODE_PINNED;
 
 	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
-out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
+
+	bpf_async_put(&t->cb, BPF_ASYNC_TYPE_TIMER);
 	return ret;
 }
 
@@ -1503,18 +1526,7 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
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
@@ -1522,13 +1534,12 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 
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
@@ -1564,16 +1575,15 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
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
 
@@ -1588,22 +1598,17 @@ static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *a
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
 
@@ -3166,11 +3171,20 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
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


