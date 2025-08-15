Return-Path: <bpf+bounces-65787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5426BB2864A
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 21:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD1A5C62FC
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 19:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF97529993B;
	Fri, 15 Aug 2025 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF59+DFT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8327AC5A
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285730; cv=none; b=RsrxI+OWIGfTV8rmXOGbCFuDRHU8NBq+M3VQwganBrSKJLTxtYmmw2PMv8iBFhT8tKV1apiBgxVyDGzeUYYy26YylxzwfKZZYsiOb0zvF2AQQ6sZWZ4Q89CXnHCJBgGWyT/gwxoyQcw2SJafGbeG5NRB/U/vKrhvwzEgt+78mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285730; c=relaxed/simple;
	bh=ieHu3ZW7T2M6RsWeV9FbYLc7yMVZMf39IOM8ppiPVSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKf/Y25D+kX0Y9z1v9SuxK7s1GGt9tVkhfwMeCQbaI5upHyl4LqJWJ2D7dgc+D9sDpyyUNuRqTYiiuo3mUDIahenTCrsYzaHdiyzwDfGzUqFnLqDdBVXtxSlufaS5ckzVy2cqX04sG+AVvCUP7T3RCC7g7Fc83CoXTLCggh50dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iF59+DFT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so1210549f8f.0
        for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755285727; x=1755890527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOJHTn8qtz9tiaYL/ppkpH4lUrFjFw6+nXq9qcEDAas=;
        b=iF59+DFTWSxVhgcxaF9K01Yhab6Jh9CIPhxYUgzbVeOjyjMjDh3iCWJNpPLwb9qFQy
         IICisOPQanQkGYI9ZSQrlclI6sVfD+Wah0RDpQ6KpF8sbdoybcXAsjn8IBkapNoAbkjw
         h8aZczThxWijg7XrhtDrAQ9/n4ZfTn1RY2287xEbY9QeRoCYh1RA7Oss+/5W42BfPaUZ
         /ZccfEEs1Qg/UfzrRMkE7pcQsLsPoXGJNbk1f5F5k2qq/qjD386JHVp+Ux8oXDnfoZCD
         eBdpwMjJR6xRXKk0uw+aAYikgHwnNJhN3XhWCVFd3k2gf8ed+Q58AKwwx7vKIMUu8yn3
         X+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755285727; x=1755890527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOJHTn8qtz9tiaYL/ppkpH4lUrFjFw6+nXq9qcEDAas=;
        b=YKd6FUbjtO/ScMQfmwgOUoyWU4LvnZeG1Qyy6I46Nhmpd703XlfZzSlZc4kOnk6avD
         92R68guy69T+HSPQ2XstxQ4GEvjMfFigUlLqs9cv2dgacfC+4rC34/nOP0bfiycsr9Ch
         34atDFRnzyQ9PNcA1a1RqHxRX9LGQ+LeaDGxIs1XjfWEcLg5heNXbIb/Rp+fUs1OrbUZ
         CHxAMiGM7NfwTjus2TO4ENQgSmOQiRq3PEtYx6l/18EL1frku1DvpvaI+xufpAmjDhG/
         TkbW8PcmoXSnUg+KSxASEHgvhVKmGY/yVTQEQUq2zCyJEQtiNWL3lIiEj/B4E3TXcxp4
         wzcg==
X-Gm-Message-State: AOJu0YzZ+K+YubJN3c5cqjDi2XUr2DXr0mawgoXaLsvijGt1OIkzjQEK
	WgfXd3YF3hpSEYS5UGfVsn3gP/+ZKc3QDzxLvBxt1+pEDKSebMYSByBLuOJWOQ==
X-Gm-Gg: ASbGncuL3UOAbZEHGWh7hmPPtfiRCLi+mVRygIp2wLixgqL9FMVJyhMTkWqo/H7ZqqR
	OHXgivhWcfwUJybiqUAXEujDWIHWnvmKohT2q6xrpSrS+B2P5tQH01x7yp4rkuYx7MhmLYU/t2v
	CkmlHw+2YheDdYp7tU2qfqu/Ee7O6uWfjSQb49F5miAU0AtDZ+2E9rCMbttD7z7D9fz8iIfSuAK
	kqJHz5UJENwfqwgyQwLucs4WJkbPpVJJe28bEjQgNed1VXtrHCMzSkcOrSSzpbZK/E2KX5/0wzH
	5CLPb7Agf3ZgbHbucHemtVe8hEaY9jIB6yIhFjr5JBFVHu9HwNqDetJ6+xTDlJIi612YKHGf/+g
	m2a2kuHgMlVHIgARiwSpz
X-Google-Smtp-Source: AGHT+IFLoDiySi66lp0U6PWKBxqB4qk6tblHKsA0t/BOPtnxI0V1VvmRxm47ocrNjeKq4XhwJYZPHw==
X-Received: by 2002:a5d:5850:0:b0:3aa:34f4:d437 with SMTP id ffacd0b85a97d-3bb68a17ae8mr2514384f8f.37.1755285726350;
        Fri, 15 Aug 2025 12:22:06 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bc5aba02e2sm406074f8f.3.2025.08.15.12.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 12:22:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
Date: Fri, 15 Aug 2025 20:21:55 +0100
Message-ID: <20250815192156.272445-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Implementation of the bpf_task_work_schedule kfuncs.

Main components:
 * struct bpf_task_work_context – Metadata and state management per task
work.
 * enum bpf_task_work_state – A state machine to serialize work
 scheduling and execution.
 * bpf_task_work_schedule() – The central helper that initiates
scheduling.
 * bpf_task_work_acquire() - Attempts to take ownership of the context,
 pointed by passed struct bpf_task_work, allocates new context if none
 exists yet.
 * bpf_task_work_callback() – Invoked when the actual task_work runs.
 * bpf_task_work_irq() – An intermediate step (runs in softirq context)
to enqueue task work.
 * bpf_task_work_cancel_and_free() – Cleanup for deleted BPF map entries.

Flow of successful task work scheduling
 1) bpf_task_work_schedule_* is called from BPF code.
 2) Transition state from STANDBY to PENDING, marks context is owned by
 this task work scheduler
 3) irq_work_queue() schedules bpf_task_work_irq().
 4) Transition state from PENDING to SCHEDULING.
 4) bpf_task_work_irq() attempts task_work_add(). If successful, state
 transitions to SCHEDULED.
 5) Task work calls bpf_task_work_callback(), which transition state to
 RUNNING.
 6) BPF callback is executed
 7) Context is cleaned up, refcounts released, context state set back to
 STANDBY.

bpf_task_work_context handling
The context pointer is stored in bpf_task_work ctx field (u64) but
treated as an __rcu pointer via casts.
bpf_task_work_acquire() publishes new bpf_task_work_context by cmpxchg
with RCU initializer.
Read under the RCU lock only in bpf_task_work_acquire() when ownership
is contended.
Upon deleting map value, bpf_task_work_cancel_and_free() is detaching
context pointer from struct bpf_task_work and releases resources
if scheduler does not own the context or can be canceled (state ==
STANDBY or state == SCHEDULED and callback canceled). If task work
scheduler owns the context, its state is set to FREED and scheduler is
expected to cleanup on the next state transition.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 270 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 260 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d2f88a9bc47b..346ae8fd3ada 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -25,6 +25,8 @@
 #include <linux/kasan.h>
 #include <linux/bpf_verifier.h>
 #include <linux/uaccess.h>
+#include <linux/task_work.h>
+#include <linux/irq_work.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3701,6 +3703,226 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
 
 typedef void (*bpf_task_work_callback_t)(struct bpf_map *map, void *key, void *value);
 
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
+struct bpf_task_work_context {
+	/* the map and map value associated with this context */
+	struct bpf_map *map;
+	void *map_val;
+	/* bpf_prog that schedules task work */
+	struct bpf_prog *prog;
+	/* task for which callback is scheduled */
+	struct task_struct *task;
+	enum task_work_notify_mode mode;
+	enum bpf_task_work_state state;
+	bpf_task_work_callback_t callback_fn;
+	struct callback_head work;
+	struct irq_work irq_work;
+	struct rcu_head rcu;
+} __aligned(8);
+
+static struct bpf_task_work_context *bpf_task_work_context_alloc(void)
+{
+	struct bpf_task_work_context *ctx;
+
+	ctx = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_task_work_context));
+	if (ctx)
+		memset(ctx, 0, sizeof(*ctx));
+	return ctx;
+}
+
+static void bpf_task_work_context_free(struct rcu_head *rcu)
+{
+	struct bpf_task_work_context *ctx = container_of(rcu, struct bpf_task_work_context, rcu);
+	/* bpf_mem_free expects migration to be disabled */
+	migrate_disable();
+	bpf_mem_free(&bpf_global_ma, ctx);
+	migrate_enable();
+}
+
+static bool task_work_match(struct callback_head *head, void *data)
+{
+	struct bpf_task_work_context *ctx = container_of(head, struct bpf_task_work_context, work);
+
+	return ctx == data;
+}
+
+static void bpf_task_work_context_reset(struct bpf_task_work_context *ctx)
+{
+	bpf_prog_put(ctx->prog);
+	bpf_task_release(ctx->task);
+}
+
+static void bpf_task_work_callback(struct callback_head *cb)
+{
+	enum bpf_task_work_state state;
+	struct bpf_task_work_context *ctx;
+	u32 idx;
+	void *key;
+
+	ctx = container_of(cb, struct bpf_task_work_context, work);
+
+	/*
+	 * Read lock is needed to protect map key and value access below, it has to be done before
+	 * the state transition
+	 */
+	rcu_read_lock_trace();
+	/*
+	 * This callback may start running before bpf_task_work_irq() switched the state to
+	 * SCHEDULED so handle both transition variants SCHEDULING|SCHEDULED -> RUNNING.
+	 */
+	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_RUNNING);
+	if (state == BPF_TW_SCHEDULED)
+		state = cmpxchg(&ctx->state, BPF_TW_SCHEDULED, BPF_TW_RUNNING);
+	if (state == BPF_TW_FREED) {
+		rcu_read_unlock_trace();
+		bpf_task_work_context_reset(ctx);
+		call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
+		return;
+	}
+
+	key = (void *)map_key_from_value(ctx->map, ctx->map_val, &idx);
+	migrate_disable();
+	ctx->callback_fn(ctx->map, key, ctx->map_val);
+	migrate_enable();
+	rcu_read_unlock_trace();
+	/* State is running or freed, either way reset. */
+	bpf_task_work_context_reset(ctx);
+	state = cmpxchg(&ctx->state, BPF_TW_RUNNING, BPF_TW_STANDBY);
+	if (state == BPF_TW_FREED)
+		call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
+}
+
+static void bpf_task_work_irq(struct irq_work *irq_work)
+{
+	struct bpf_task_work_context *ctx;
+	enum bpf_task_work_state state;
+	int err;
+
+	ctx = container_of(irq_work, struct bpf_task_work_context, irq_work);
+
+	state = cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING);
+	if (state == BPF_TW_FREED)
+		goto free_context;
+
+	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
+	if (err) {
+		bpf_task_work_context_reset(ctx);
+		state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
+		if (state == BPF_TW_FREED)
+			call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
+		return;
+	}
+	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
+	if (state == BPF_TW_FREED && task_work_cancel_match(ctx->task, task_work_match, ctx))
+		goto free_context; /* successful cancellation, release and free ctx */
+	return;
+
+free_context:
+	bpf_task_work_context_reset(ctx);
+	call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
+}
+
+static struct bpf_task_work_context *bpf_task_work_context_acquire(struct bpf_task_work *tw,
+								   struct bpf_map *map)
+{
+	struct bpf_task_work_context *ctx, *old_ctx;
+	enum bpf_task_work_state state;
+	struct bpf_task_work_context __force __rcu **ppc =
+		(struct bpf_task_work_context __force __rcu **)&tw->ctx;
+
+	/* ctx pointer is RCU protected */
+	rcu_read_lock_trace();
+	ctx = rcu_dereference(*ppc);
+	if (!ctx) {
+		ctx = bpf_task_work_context_alloc();
+		if (!ctx) {
+			rcu_read_unlock_trace();
+			return ERR_PTR(-ENOMEM);
+		}
+		old_ctx = unrcu_pointer(cmpxchg(ppc, NULL, RCU_INITIALIZER(ctx)));
+		/*
+		 * If ctx is set by another CPU, release allocated memory.
+		 * Do not fail, though, attempt stealing the work
+		 */
+		if (old_ctx) {
+			bpf_mem_free(&bpf_global_ma, ctx);
+			ctx = old_ctx;
+		}
+	}
+	state = cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING);
+	/*
+	 * We can unlock RCU, because task work scheduler (this codepath)
+	 * now owns the ctx or returning an error
+	 */
+	rcu_read_unlock_trace();
+	if (state != BPF_TW_STANDBY)
+		return ERR_PTR(-EBUSY);
+	return ctx;
+}
+
+static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work *tw,
+				  struct bpf_map *map, bpf_task_work_callback_t callback_fn,
+				  struct bpf_prog_aux *aux, enum task_work_notify_mode mode)
+{
+	struct bpf_prog *prog;
+	struct bpf_task_work_context *ctx = NULL;
+	int err;
+
+	BTF_TYPE_EMIT(struct bpf_task_work);
+
+	prog = bpf_prog_inc_not_zero(aux->prog);
+	if (IS_ERR(prog))
+		return -EBADF;
+
+	if (!atomic64_read(&map->usercnt)) {
+		err = -EBADF;
+		goto release_prog;
+	}
+	task = bpf_task_acquire(task);
+	if (!task) {
+		err = -EPERM;
+		goto release_prog;
+	}
+	ctx = bpf_task_work_context_acquire(tw, map);
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
+	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
+	init_task_work(&ctx->work, bpf_task_work_callback);
+
+	irq_work_queue(&ctx->irq_work);
+
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
@@ -3711,13 +3933,11 @@ typedef void (*bpf_task_work_callback_t)(struct bpf_map *map, void *key, void *v
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
-__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task,
-					      struct bpf_task_work *tw,
+__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
 					      struct bpf_map *map__map,
-					      bpf_task_work_callback_t callback,
-					      void *aux__prog)
+					      bpf_task_work_callback_t callback, void *aux__prog)
 {
-	return 0;
+	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_SIGNAL);
 }
 
 /**
@@ -3731,19 +3951,47 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task,
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
-__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task,
-					      struct bpf_task_work *tw,
+__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
 					      struct bpf_map *map__map,
-					      bpf_task_work_callback_t callback,
-					      void *aux__prog)
+					      bpf_task_work_callback_t callback, void *aux__prog)
 {
-	return 0;
+	enum task_work_notify_mode mode;
+
+	mode = task == current && in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
+	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, mode);
 }
 
 __bpf_kfunc_end_defs();
 
 void bpf_task_work_cancel_and_free(void *val)
 {
+	struct bpf_task_work *tw = val;
+	struct bpf_task_work_context *ctx;
+	enum bpf_task_work_state state;
+
+	/* No need do rcu_read_lock as no other codepath can reset this pointer */
+	ctx = unrcu_pointer(xchg((struct bpf_task_work_context __force __rcu **)&tw->ctx, NULL));
+	if (!ctx)
+		return;
+	state = xchg(&ctx->state, BPF_TW_FREED);
+
+	switch (state) {
+	case BPF_TW_SCHEDULED:
+		/* If we can't cancel task work, rely on task work callback to free the context */
+		if (!task_work_cancel_match(ctx->task, task_work_match, ctx))
+			break;
+		bpf_task_work_context_reset(ctx);
+		fallthrough;
+	case BPF_TW_STANDBY:
+		call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
+		break;
+	/* In all below cases scheduling logic should detect context state change and cleanup */
+	case BPF_TW_SCHEDULING:
+	case BPF_TW_PENDING:
+	case BPF_TW_RUNNING:
+	default:
+		break;
+	}
 }
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3769,6 +4017,8 @@ BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
 
 #ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
-- 
2.50.1


