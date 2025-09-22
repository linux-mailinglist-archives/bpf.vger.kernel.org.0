Return-Path: <bpf+bounces-69285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBF7B93937
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6674D190748E
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D6E3164D0;
	Mon, 22 Sep 2025 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2KOtjC4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74132FB09F
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583590; cv=none; b=Kz970QxifYML41AbQqyuUyYGbrbx6pODzEmqgfrMZ/p8qwAopAA2LDlJ+LVu+plxkzd77zOaBoLW+dwoliqcjopLisTOnZaLboFEW0IQWf4iP4f0RyhGSUJPfdfH2vZPwep4nO2Y1mTh0/FdOEZkXy+EhI4/KRn4UrOIqwxW9FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583590; c=relaxed/simple;
	bh=RHU9ccplZRNP4z1DGuiAdGdOgZaHfN9svQ11WE7AcQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvBCGUU6xgPUfqL1lwYYXZwhjP3dqNGdDosJnNKBkStjKOfZZxABYYFPDPwOwA3EwjMnLkdKUlxdmRW6GtaqhYpmn+af0gA+VTokQJ+tW1+omSiBSJTjTqd/ICJB1468opdnMeWTHx3gMHeF6Y5uA+IwWH//AyBNczLwvX7Pa/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2KOtjC4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so4393374a12.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583587; x=1759188387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyTbvr4Prd4mSlXpfHKJbO2MVsB+d/QX+Mw458FrTr8=;
        b=j2KOtjC4l6wn99xQj3mHCOlIWnwggHt5qeYQWjvzyeiLTs9WCYd7PNxgWzL1jvSxlZ
         n5Kbt1KbgOxbMIeOMnWDMt7pRyKjGJSMzdhT2zhfD+xECb0/G19W7i9wmH+Ee6nZYiwI
         rkl5aOUCngyeXJQa5Cch7y9+kZhWBsm1pdXJTeyFWBEQzNStmhFeO5GMhB/hzoI64yKC
         hay/ZP+bJtuEr/JUrTpm7HngXE9EWRVYzVrqrWyfJyk00RtQlpVp7waiTx6r3EkMK53J
         4B8UEQoPVO+qv17x7EVDtHGimi+mSSD+tmyLjDI+Uw5yVJFYXXTSCU9dv+qgVBdTWFru
         dLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583587; x=1759188387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyTbvr4Prd4mSlXpfHKJbO2MVsB+d/QX+Mw458FrTr8=;
        b=o3+0Jt8cWLOB6TcYOJ5FU0H0FLP7OCAvC4uIel8Mf/Axh/9vYTH+Xx7ZfLAY/5h8Q4
         hJEsvMeIJiW3cSOTOiewfeICo4dWY3a2kv/2cy/eZeYyxRb8nFScZdEh6Y4cIesBF3Hb
         WL3nmK7pzUIpTBzuuFh2vDNqnJdpKS6ifHsKXJeMGGHbz4tXebF2jRnpg76xQ0b2UdTX
         b6v0khg3BUZzkhWNccBEcW1D/HYlWHWVzb93QPEoka0UyXD0PNQh+c+lVNvyd1GnxmLY
         rGPpfNKf4IVovGIp/aVGi16n6XowqDckUgwbKDqcX6wpgc9e1yLWk1qqhFj5hDdU+b/S
         ddTQ==
X-Gm-Message-State: AOJu0Yy6HzSfBqoCknQj2WVYoKn9RXLhhmQ/f20j1OgmXTr6hvxHWFeu
	J3dNVd9jaAoSd+ZWV+yDlUc4USuGiqGwHDccZdirjxt3ihiZlMjSow3qTd+89Q==
X-Gm-Gg: ASbGnctcanrOcp+eD6l0fcFKFhyopGjEsFdPtktWYlThFTfaCQMtHR5uQcrs/Kh6anD
	xPr2/RHxo+btfu2D1HaMc7H/jLjWbX8ZhX7qcebhstBAQs60jIowknx9+FUTp3bTZHqTgVGuvbK
	jQE5EG7csti+jhcV02lOK7dJnH2Z8UiCYvrKeaWMl8M2isAufTr1pbBvz5IKGJD/cv+AjoiX76Z
	lEnq/58IzoMLMCypYittL5DVEiulAwDuQXR6xTykRyLVT5MHE9OAWl5Ck8noGsuyozvQATNsisF
	F6pDkQxg+WabznQYQQyMv+mS8BM5eIeZCwD5cRGmi9o6xJJpoNjLtNvGMFxZn3g5W6jB14mbzoh
	A7mN9BcRoqIkbqPD4ibMT
X-Google-Smtp-Source: AGHT+IHBa+momIQyTXkNHIlOWsDFp7RZPxbUQyJ6+v8yE00i9NM0hFLjX6tWnFJPdTUJgzhiQW/dlQ==
X-Received: by 2002:a17:907:9703:b0:b07:c290:6ce7 with SMTP id a640c23a62f3a-b30263b2fd3mr28636966b.7.1758583586956;
        Mon, 22 Sep 2025 16:26:26 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm1173971666b.97.2025.09.22.16.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:26:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 7/9] bpf: task work scheduling kfuncs
Date: Tue, 23 Sep 2025 00:26:08 +0100
Message-ID: <20250922232611.614512-8-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
References: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Implementation of the new bpf_task_work_schedule kfuncs, that let a BPF
program schedule task_work callbacks for a target task:
 * bpf_task_work_schedule_signal() - schedules with TWA_SIGNAL
 * bpf_task_work_schedule_resume() - schedules with TWA_RESUME

Each map value should embed a struct bpf_task_work, which the kernel
side pairs with struct bpf_task_work_kern, containing a pointer to
struct bpf_task_work_ctx, that maintains metadata relevant for the
concrete callback scheduling.

A small state machine and refcounting scheme ensures safe reuse and
teardown. State transitions:
    _______________________________
    |                             |
    v                             |
[standby] ---> [pending] --> [scheduling] --> [scheduled]
    ^                             |________________|_________
    |                                                       |
    |                                                       v
    |                                                   [running]
    |_______________________________________________________|

All states may transition into FREED state:
[pending] [scheduling] [scheduled] [running] [standby] -> [freed]

A FREED terminal state coordinates with map-value
deletion (bpf_task_work_cancel_and_free()).

Scheduling itself is deferred via irq_work to keep the kfunc callable
from NMI context.

Lifetime is guarded with refcount_t + RCU Tasks Trace.

Main components:
 * struct bpf_task_work_context – Metadata and state management per task
work.
 * enum bpf_task_work_state – A state machine to serialize work
 scheduling and execution.
 * bpf_task_work_schedule() – The central helper that initiates
scheduling.
 * bpf_task_work_acquire_ctx() - Attempts to take ownership of the context,
 pointed by passed struct bpf_task_work, allocates new context if none
 exists yet.
 * bpf_task_work_callback() – Invoked when the actual task_work runs.
 * bpf_task_work_irq() – An intermediate step (runs in softirq context)
to enqueue task work.
 * bpf_task_work_cancel_and_free() – Cleanup for deleted BPF map entries.

Flow of successful task work scheduling
 1) bpf_task_work_schedule_* is called from BPF code.
 2) Transition state from STANDBY to PENDING, mark context as owned by
 this task work scheduler
 3) irq_work_queue() schedules bpf_task_work_irq().
 4) Transition state from PENDING to SCHEDULING (noop if transition
 successful)
 5) bpf_task_work_irq() attempts task_work_add(). If successful, state
 transitions to SCHEDULED.
 6) Task work calls bpf_task_work_callback(), which transition state to
 RUNNING.
 7) BPF callback is executed
 8) Context is cleaned up, refcounts released, context state set back to
 STANDBY.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 292 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 290 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6d072fffa89e..4c84297ba669 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -26,6 +26,8 @@
 #include <linux/bpf_verifier.h>
 #include <linux/uaccess.h>
 #include <linux/verification.h>
+#include <linux/task_work.h>
+#include <linux/irq_work.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3904,6 +3906,265 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
 
 typedef int (*bpf_task_work_callback_t)(struct bpf_map *map, void *key, void *value);
 
+enum bpf_task_work_state {
+	/* bpf_task_work is ready to be used */
+	BPF_TW_STANDBY = 0,
+	/* irq work scheduling in progress */
+	BPF_TW_PENDING,
+	/* task work scheduling in progress */
+	BPF_TW_SCHEDULING,
+	/* task work is scheduled successfully */
+	BPF_TW_SCHEDULED,
+	/* callback is running */
+	BPF_TW_RUNNING,
+	/* associated BPF map value is deleted */
+	BPF_TW_FREED,
+};
+
+struct bpf_task_work_ctx {
+	enum bpf_task_work_state state;
+	refcount_t refcnt;
+	struct callback_head work;
+	struct irq_work irq_work;
+	/* bpf_prog that schedules task work */
+	struct bpf_prog *prog;
+	/* task for which callback is scheduled */
+	struct task_struct *task;
+	/* the map and map value associated with this context */
+	struct bpf_map *map;
+	void *map_val;
+	enum task_work_notify_mode mode;
+	bpf_task_work_callback_t callback_fn;
+	struct rcu_head rcu;
+} __aligned(8);
+
+/* Actual type for struct bpf_task_work */
+struct bpf_task_work_kern {
+	struct bpf_task_work_ctx *ctx;
+};
+
+static void bpf_task_work_ctx_reset(struct bpf_task_work_ctx *ctx)
+{
+	if (ctx->prog) {
+		bpf_prog_put(ctx->prog);
+		ctx->prog = NULL;
+	}
+	if (ctx->task) {
+		bpf_task_release(ctx->task);
+		ctx->task = NULL;
+	}
+}
+
+static bool bpf_task_work_ctx_tryget(struct bpf_task_work_ctx *ctx)
+{
+	return refcount_inc_not_zero(&ctx->refcnt);
+}
+
+static void bpf_task_work_ctx_put(struct bpf_task_work_ctx *ctx)
+{
+	if (!refcount_dec_and_test(&ctx->refcnt))
+		return;
+
+	bpf_task_work_ctx_reset(ctx);
+
+	/* bpf_mem_free expects migration to be disabled */
+	migrate_disable();
+	bpf_mem_free(&bpf_global_ma, ctx);
+	migrate_enable();
+}
+
+static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
+{
+	/*
+	 * Scheduled task_work callback holds ctx ref, so if we successfully
+	 * cancelled, we put that ref on callback's behalf. If we couldn't
+	 * cancel, callback will inevitably run or has already completed
+	 * running, and it would have taken care of its ctx ref itself.
+	 */
+	if (task_work_cancel(ctx->task, &ctx->work))
+		bpf_task_work_ctx_put(ctx);
+}
+
+static void bpf_task_work_callback(struct callback_head *cb)
+{
+	struct bpf_task_work_ctx *ctx = container_of(cb, struct bpf_task_work_ctx, work);
+	enum bpf_task_work_state state;
+	u32 idx;
+	void *key;
+
+	/* Read lock is needed to protect ctx and map key/value access */
+	guard(rcu_tasks_trace)();
+	/*
+	 * This callback may start running before bpf_task_work_irq() switched to
+	 * SCHEDULED state, so handle both transition variants SCHEDULING|SCHEDULED -> RUNNING.
+	 */
+	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_RUNNING);
+	if (state == BPF_TW_SCHEDULED)
+		state = cmpxchg(&ctx->state, BPF_TW_SCHEDULED, BPF_TW_RUNNING);
+	if (state == BPF_TW_FREED) {
+		bpf_task_work_ctx_put(ctx);
+		return;
+	}
+
+	key = (void *)map_key_from_value(ctx->map, ctx->map_val, &idx);
+
+	migrate_disable();
+	ctx->callback_fn(ctx->map, key, ctx->map_val);
+	migrate_enable();
+
+	bpf_task_work_ctx_reset(ctx);
+	(void)cmpxchg(&ctx->state, BPF_TW_RUNNING, BPF_TW_STANDBY);
+
+	bpf_task_work_ctx_put(ctx);
+}
+
+static void bpf_task_work_irq(struct irq_work *irq_work)
+{
+	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
+	enum bpf_task_work_state state;
+	int err;
+
+	guard(rcu_tasks_trace)();
+
+	if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) != BPF_TW_PENDING) {
+		bpf_task_work_ctx_put(ctx);
+		return;
+	}
+
+	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
+	if (err) {
+		bpf_task_work_ctx_reset(ctx);
+		/*
+		 * try to switch back to STANDBY for another task_work reuse, but we might have
+		 * gone to FREED already, which is fine as we already cleaned up after ourselves
+		 */
+		(void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
+		bpf_task_work_ctx_put(ctx);
+		return;
+	}
+
+	/*
+	 * It's technically possible for just scheduled task_work callback to
+	 * complete running by now, going SCHEDULING -> RUNNING and then
+	 * dropping its ctx refcount. Instead of capturing extra ref just to
+	 * protected below ctx->state access, we rely on RCU protection to
+	 * perform below SCHEDULING -> SCHEDULED attempt.
+	 */
+	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
+	if (state == BPF_TW_FREED)
+		bpf_task_work_cancel(ctx); /* clean up if we switched into FREED state */
+}
+
+static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *tw,
+							 struct bpf_map *map)
+{
+	struct bpf_task_work_kern *twk = (void *)tw;
+	struct bpf_task_work_ctx *ctx, *old_ctx;
+
+	ctx = READ_ONCE(twk->ctx);
+	if (ctx)
+		return ctx;
+
+	ctx = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_task_work_ctx));
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	memset(ctx, 0, sizeof(*ctx));
+	refcount_set(&ctx->refcnt, 1); /* map's own ref */
+	ctx->state = BPF_TW_STANDBY;
+
+	old_ctx = cmpxchg(&twk->ctx, NULL, ctx);
+	if (old_ctx) {
+		/*
+		 * tw->ctx is set by concurrent BPF program, release allocated
+		 * memory and try to reuse already set context.
+		 */
+		bpf_mem_free(&bpf_global_ma, ctx);
+		return old_ctx;
+	}
+
+	return ctx; /* Success */
+}
+
+static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work *tw,
+							   struct bpf_map *map)
+{
+	struct bpf_task_work_ctx *ctx;
+
+	ctx = bpf_task_work_fetch_ctx(tw, map);
+	if (IS_ERR(ctx))
+		return ctx;
+
+	/* try to get ref for task_work callback to hold */
+	if (!bpf_task_work_ctx_tryget(ctx))
+		return ERR_PTR(-EBUSY);
+
+	if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) != BPF_TW_STANDBY) {
+		/* lost acquiring race or map_release_uref() stole it from us, put ref and bail */
+		bpf_task_work_ctx_put(ctx);
+		return ERR_PTR(-EBUSY);
+	}
+
+	/*
+	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
+	 * scheduled. This does not address any race or correctness issue, but rather is a policy
+	 * choice: dropping user references should stop everything.
+	 */
+	if (!atomic64_read(&map->usercnt)) {
+		/* drop ref we just got for task_work callback itself */
+		bpf_task_work_ctx_put(ctx);
+		/* transfer map's ref into cancel_and_free() */
+		bpf_task_work_cancel_and_free(tw);
+		return ERR_PTR(-EBUSY);
+	}
+
+	return ctx;
+}
+
+static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work *tw,
+				  struct bpf_map *map, bpf_task_work_callback_t callback_fn,
+				  struct bpf_prog_aux *aux, enum task_work_notify_mode mode)
+{
+	struct bpf_prog *prog;
+	struct bpf_task_work_ctx *ctx;
+	int err;
+
+	BTF_TYPE_EMIT(struct bpf_task_work);
+
+	prog = bpf_prog_inc_not_zero(aux->prog);
+	if (IS_ERR(prog))
+		return -EBADF;
+	task = bpf_task_acquire(task);
+	if (!task) {
+		err = -EBADF;
+		goto release_prog;
+	}
+
+	ctx = bpf_task_work_acquire_ctx(tw, map);
+	if (IS_ERR(ctx)) {
+		err = PTR_ERR(ctx);
+		goto release_all;
+	}
+
+	ctx->task = task;
+	ctx->callback_fn = callback_fn;
+	ctx->prog = prog;
+	ctx->mode = mode;
+	ctx->map = map;
+	ctx->map_val = (void *)tw - map->record->task_work_off;
+	init_task_work(&ctx->work, bpf_task_work_callback);
+	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
+
+	irq_work_queue(&ctx->irq_work);
+	return 0;
+
+release_all:
+	bpf_task_release(task);
+release_prog:
+	bpf_prog_put(prog);
+	return err;
+}
+
 /**
  * bpf_task_work_schedule_signal - Schedule BPF callback using task_work_add with TWA_SIGNAL mode
  * @task: Task struct for which callback should be scheduled
@@ -3918,7 +4179,7 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
 					      void *map__map, bpf_task_work_callback_t callback,
 					      void *aux__prog)
 {
-	return 0;
+	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_SIGNAL);
 }
 
 /**
@@ -3935,13 +4196,38 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
 					      void *map__map, bpf_task_work_callback_t callback,
 					      void *aux__prog)
 {
-	return 0;
+	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_RESUME);
 }
 
 __bpf_kfunc_end_defs();
 
+static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
+{
+	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
+
+	bpf_task_work_cancel(ctx); /* this might put task_work callback's ref */
+	bpf_task_work_ctx_put(ctx); /* and here we put map's own ref that was transferred to us */
+}
+
 void bpf_task_work_cancel_and_free(void *val)
 {
+	struct bpf_task_work_kern *twk = val;
+	struct bpf_task_work_ctx *ctx;
+	enum bpf_task_work_state state;
+
+	ctx = xchg(&twk->ctx, NULL);
+	if (!ctx)
+		return;
+
+	state = xchg(&ctx->state, BPF_TW_FREED);
+	if (state == BPF_TW_SCHEDULED) {
+		/* run in irq_work to avoid locks in NMI */
+		init_irq_work(&ctx->irq_work, bpf_task_work_cancel_scheduled);
+		irq_work_queue(&ctx->irq_work);
+		return;
+	}
+
+	bpf_task_work_ctx_put(ctx); /* put bpf map's ref */
 }
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -4086,6 +4372,8 @@ BTF_ID_FLAGS(func, bpf_strnstr);
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.51.0


