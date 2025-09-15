Return-Path: <bpf+bounces-68433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33DB585F2
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4361AA7ECE
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C56E298CAF;
	Mon, 15 Sep 2025 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxdQefsu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18628E5F3
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967515; cv=none; b=Kl29QG7RDd0XsgZMYy2Sl22c7g6wQ696kT8uApyptcy5UC0btRCjKpz4b/qgsh0FZ04wKzr96UVQUXBcnT3seRH9CTZuVC/vV4EnuC+fPl/UDoYznd+K8Lq6jHLWHg5akaUEXbfkJKMIXwJxSaGGUfmaEYDMGcbGUHVTPgm5LW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967515; c=relaxed/simple;
	bh=RR10A3uAtVZSwFvDt1Mr3xDdkY4/yua8h+DMkikIHwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qz6dY7uRwQJNTcanNyHRvW1IDNR1pWGW4xly6W51+Unv+EItl8B8cyZTY5xiizBlWAZ1EGiL1r89MaCC2p5i8gah5ismEWQFyN6imO5kN2Dbflqe3bcEExeeMO3tAUtRYOy9juwcQlNIsBtqSrO/wFdZ8HVGJuh5hMd5iN3yvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxdQefsu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3dae49b117bso3580699f8f.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967512; x=1758572312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYQrZUBHPw00HwzytMRrBX2BNwuBmJj2KnpuVT6fAEA=;
        b=AxdQefsu29802mbqWIH84/lr2jJc1Uzf6iCO06ZMYeUssKz2BsTFXeDt6kkfwLgliC
         pChiTbBJOmzYAtsapACBkZ3EQBNM/owg9TRjum3YRemcZnRj/RiFbh8IMEDCpYZ69bRN
         iBQDK1QdxdsWXEjR83EbCWZSC4BhFjjgcVWFdCojxnCp+s9WIXb+ZkuwTK4MuoHRntai
         z60L80wZWke/3M17N1nn9rRbKy9gsj1OUBSVw8LPizy2EGACKXjGPXRKqxpIk3/krpQX
         WjNWbqB9t2LqOdJqCrq31YqJri4tYZZn/Hjyl/F3C2LWBOXyI/V3liE75sCXq+MzGXGT
         k0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967512; x=1758572312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYQrZUBHPw00HwzytMRrBX2BNwuBmJj2KnpuVT6fAEA=;
        b=V1aLjzKpR4Hu6DfsuCyaZQggogP8HylBapO8H6UqpYOKF5PkmUXBcBJZWrFw3nI6w1
         jZpP2C1moscQxBVCKVUI4Hxwlej44AnWHx5L3mtNt8pdrgOybhj6U/hQr4lOhghAdRSm
         9ZNCs2318UXxF8apdjozr1CS+dnFL5kQIaANbxgMMqaAWqtiQU39i/QgUaNCdQITRpov
         izLRKoE7VyPwenVU9Chm8HvGx61TlzQHgHlBgysTjwOmPoWY7g2VT/pxWVlOtn+PIGwc
         8a+GPuvGbIR5uzn6WgI40xgSwOxmfPW1Mp9akHUqeWkXXKxIl6Hj/YP2wahtsbyktt6B
         VFiA==
X-Gm-Message-State: AOJu0YySoGtXTCGaDp1Js2OuF5kM88my5GeCCKrp6vOfGDSuOOvYZn3K
	I3vgXucDMG+UT/F9tGMhgsovoCSa86dTM/DbWN77IjFSIho04ShxS65HSl/xUQ==
X-Gm-Gg: ASbGncuE6+IglMskRsRrJdSJSZvSdY8Yb5DrTOFRXN1nwwvemY0M2h4Nn+M7s7JuBnt
	slMGda1/AMhtJW47GOKZqePkJzeAt86rez/4ZC7XJsR9AVRaPlbEVUSC6x8KjsDVe2TZb70iptV
	wdfANmD5NPm71R2i9dM6ej3iLopNwda0mrtNhmmzmlCUAQgogTl1nukbNCLZCFY90dvlJ7H1IYB
	8z7iK8shexR7uA+qZrRIN2dZLbpQKOBut/XkboxgI0Lx6fDKpdVVtp4yytCXJqnaZf+aU5f8t2T
	s9wepACaZyr3BEsOsthzVxa7ymV5STAmcqs47r4JZ8Pfg1twfsxTv9T4HMFGzy/pAlgF3v67Dyr
	0ogo=
X-Google-Smtp-Source: AGHT+IERz6y4Xba+hAucdT7Xe0l/E59KoFa1sLT2lFTt75YckHqkRnpBLwBWfSnsL6rWB7EU+uGpYA==
X-Received: by 2002:a05:6000:2410:b0:3e7:5f26:f1d6 with SMTP id ffacd0b85a97d-3e765790821mr14038863f8f.13.1757967511959;
        Mon, 15 Sep 2025 13:18:31 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:388e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea103f90e4sm7159194f8f.53.2025.09.15.13.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:18:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 7/8] bpf: task work scheduling kfuncs
Date: Mon, 15 Sep 2025 21:18:15 +0100
Message-ID: <20250915201820.248977-8-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
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
 4) Transition state from PENDING to SCHEDULING.
 5) bpf_task_work_irq() attempts task_work_add(). If successful, state
 transitions to SCHEDULED.
 6) Task work calls bpf_task_work_callback(), which transition state to
 RUNNING.
 7) BPF callback is executed
 8) Context is cleaned up, refcounts released, context state set back to
 STANDBY.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/helpers.c | 311 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 309 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5ea18509bc37..15ef52379c28 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -25,6 +25,8 @@
 #include <linux/kasan.h>
 #include <linux/bpf_verifier.h>
 #include <linux/uaccess.h>
+#include <linux/task_work.h>
+#include <linux/irq_work.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3737,6 +3739,284 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
 
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
+static void bpf_task_work_ctx_free_rcu_gp(struct rcu_head *rcu)
+{
+	struct bpf_task_work_ctx *ctx = container_of(rcu, struct bpf_task_work_ctx, rcu);
+
+	/* bpf_mem_free expects migration to be disabled */
+	migrate_disable();
+	bpf_mem_free(&bpf_global_ma, ctx);
+	migrate_enable();
+}
+
+static void bpf_task_work_ctx_free_mult_rcu_gp(struct rcu_head *rcu)
+{
+	if (rcu_trace_implies_rcu_gp())
+		bpf_task_work_ctx_free_rcu_gp(rcu);
+	else
+		call_rcu(rcu, bpf_task_work_ctx_free_rcu_gp);
+}
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
+	call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_ctx_free_mult_rcu_gp);
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
+	/* early check to avoid any work, we'll double check at the end again */
+	if (!atomic64_read(&map->usercnt))
+		return ERR_PTR(-EBUSY);
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
+	 * Double check that map->usercnt wasn't dropped while we were
+	 * preparing context, and if it was, we need to clean up as if
+	 * map_release_uref() was called; bpf_task_work_cancel_and_free()
+	 * is safe to be called twice on the same task work
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
@@ -3751,7 +4031,7 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
 					      void *map__map, bpf_task_work_callback_t callback,
 					      void *aux__prog)
 {
-	return 0;
+	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_SIGNAL);
 }
 
 /**
@@ -3768,13 +4048,38 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
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
@@ -3911,6 +4216,8 @@ BTF_ID_FLAGS(func, bpf_strnstr);
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.51.0


