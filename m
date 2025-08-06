Return-Path: <bpf+bounces-65131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B74B1C7D8
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E66A18A332A
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0707818B47D;
	Wed,  6 Aug 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQQhl8tA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058E1C1F13
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491581; cv=none; b=rhBMlSTU74oo+Rkkdq6T+thJ8xQqINZDysOwsDibSg9/xLSE+p3yy5je+SZDTYvRXi8CtZj6DaN3a6p5EtWY0MxKsLf1wJR0ou7tj+9JimjEwfsjIMYPOwXNgGGgE1enXt48oMXSTg47Vi+ENdYsYXMARbTqZet6CTjjRwnNvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491581; c=relaxed/simple;
	bh=y7bt2yCtY640im8oHkIgrJS6TQ62WKrykOi9lN8+8/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cA1TCetd5Pw0/A+Do9+levLenP22aDdrw5Rv6dEoTVnHiYixV8aTwPFEOyS4ufRPXznq5/reZZCbSeOf9gkgds8VzxlbcMZJGdAj1DsCDgSZqFm/vHN3eLnBUj1H6ck30m4j9d4a3gIXlYJtgOTXCf63C3YnA7b2SXVO+97Y3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQQhl8tA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso27828345e9.3
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754491578; x=1755096378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNTmGOhVK3rp+v56zh3wmj2F3aq3rpTHY6GpCbqlZ7M=;
        b=cQQhl8tAW8r1fVp8uGxIGcPC3wDMohyJl7uiCXX8uc/tt19Gc9bYsO+uG4eZArZRMt
         RjvF4LfB2ibroUNLZ7e0/B1C99kXjXgFyqvJmntRvW3ArxNyHTCrkpPn3WFuVdEDa/jg
         gu6WVOfnBiAs3qU42wXjN/3vunWolbR5xUhuaRsyRvo1QaBrZYgaogs6IVG5WDSJ2dl6
         CqTlhHX3lQLfu2QNptLfATHS03PpwD0bsmFooLRNsoAvhn8FdQkpcM7+YgXo2zYa8yB8
         KWFOg5vr/Z7NAVg9g3aPD4MEFNNqnFArve34jUuLjaE/5ysfFX5dYSmV2FqYBhVq72Y3
         vv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754491578; x=1755096378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNTmGOhVK3rp+v56zh3wmj2F3aq3rpTHY6GpCbqlZ7M=;
        b=g89ilR5j0ma9L4Xk8ahKw4MYxph8AxqSQ581b8S8z4NNnp8crcN6/n/sHXoLoh1wyY
         dFchj0+XF17Mk9ORwsXDbeWgWgX9PhtBH5sHu1lUZyb4BKiielr0wSPGir/K14QlErqz
         3H1CNIPU17SXlqlUPykecQaG7wh6ipvVdgv1rHjeHFrc2MkusqGOBLW6sNCTaCCDmyzN
         WqG8Nv+23DYP1cWbSUzR1fulTA7syn58KKXUWTEkUEY+bn0TrL2DAMEgZFRHg1rOI+Jh
         9Goz8rd298RmCTHLbKW1dvicKHIq27h/sXjMGDJs8xdTvbQoAc9iEU9hmD6ITIdcW8Qo
         Gt+g==
X-Gm-Message-State: AOJu0Ywcg95ZM8A+9DtCJeu97MoHZ/bpGu4kKpUzVs1RCIe1n0jrRpyT
	31V7bgq7yxGGOkjeG1GPVnky+e0z9ECv14s92cr2Y3+d6r7ed8nyvCn75h4xsw==
X-Gm-Gg: ASbGncvc3xQ6aJ46tEqo8lbAhXVjR3pW9jnTVONMwO07cM5F6lpRCVIcp3Bx+OGTZ0O
	kDrQlCHJZFlSJNh5dneZdjv+S46vm+pMBsD7tWOrKm2812anH9JB40NWYBpyLeDGhJbycwNWOPy
	ZkHQ77LJkPxITfPXhGUGsjW+bKO5ApPQ6ir7LOQZcaN9yl7saVIkA977FiDrIR5Rwi1xEXfw1UZ
	r8CERk2PHY9U7B+/WwqrNN2Jh1E3Goyh0uFkNWEWtovLsFTm4/oZwIHwK3J4s+TLF0XBZ5bCQYX
	yKDDTsMyBTIA9xxe1aCyCji9n05QIE3aBS2GK/qEviQDbx/aM7h+eviAynKyYXUQiB1QBZlrKhn
	V
X-Google-Smtp-Source: AGHT+IF1hZ55ZKEmZbHQNGXyiYoDPMlox9UmZgyqxngQZXN7S30+s90XqckuzAJRPYyrF/nS9ZBfHw==
X-Received: by 2002:a05:600c:b8d:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-459e70d9910mr26862635e9.19.1754491577486;
        Wed, 06 Aug 2025 07:46:17 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:ba0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e79ef4c8sm35445085e9.6.2025.08.06.07.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:46:17 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 3/4] bpf: task work scheduling kfuncs
Date: Wed,  6 Aug 2025 15:45:23 +0100
Message-ID: <20250806144554.576706-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
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
 * bpf_task_work_callback() – Invoked when the actual task_work runs.
 * bpf_task_work_irq() – An intermediate step (runs in softirq context)
to enqueue task work.
 * bpf_task_work_cancel_and_free() – Cleanup for deleted BPF map entries.

Flow of task work scheduling
 1) bpf_task_work_schedule_* is called from BPF code.
 2) Transition state from STANDBY to PENDING.
 3) irq_work_queue() schedules bpf_task_work_irq().
 4) Transition state from PENDING to SCHEDULING.
 4) bpf_task_work_irq() attempts task_work_add(). If successful, state
 transitions to SCHEDULED.
 5) Task work calls bpf_task_work_callback(), which transition state to
 RUNNING.
 6) BPF callback is executed
 7) Context is cleaned up, refcounts released, state set back to
 STANDBY.

Map value deletion
If map value that contains bpf_task_work_context is deleted, BPF map
implementation calls bpf_task_work_cancel_and_free().
Deletion is handled by atomically setting state to FREED and
releasing references or letting scheduler do that, depending on the
last state before the deletion:
 * SCHEDULING: release references in bpf_task_work_cancel_and_free(),
 expect bpf_task_work_irq() to cancel task work.
 * SCHEDULED: release references and try to cancel task work in
 bpf_task_work_cancel_and_free().
  * other states: one of bpf_task_work_irq(), bpf_task_work_schedule(),
  bpf_task_work_callback() should cleanup upon detecting the state
  switching to FREED.

The state transitions are controlled with atomic_cmpxchg, ensuring:
 * Only one thread can successfully enqueue work.
 * Proper handling of concurrent deletes (BPF_TW_FREED).
 * Safe rollback if task_work_add() fails.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 188 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 186 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 516286f67f0d..4c8b1c9be7aa 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -25,6 +25,8 @@
 #include <linux/kasan.h>
 #include <linux/bpf_verifier.h>
 #include <linux/uaccess.h>
+#include <linux/task_work.h>
+#include <linux/irq_work.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3702,6 +3704,160 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
 
 typedef void (*bpf_task_work_callback_t)(struct bpf_map *, void *, void *);
 
+enum bpf_task_work_state {
+	/* bpf_task_work is ready to be used */
+	BPF_TW_STANDBY = 0,
+	/* bpf_task_work is getting scheduled into irq_work */
+	BPF_TW_PENDING,
+	/* bpf_task_work is in irq_work and getting scheduled into task_work */
+	BPF_TW_SCHEDULING,
+	/* bpf_task_work is scheduled into task_work successfully */
+	BPF_TW_SCHEDULED,
+	/* callback is running */
+	BPF_TW_RUNNING,
+	/* BPF map value storing this bpf_task_work is deleted */
+	BPF_TW_FREED,
+};
+
+struct bpf_task_work_context {
+	/* map that contains this structure in a value */
+	struct bpf_map *map;
+	/* bpf_task_work_state value, representing the state */
+	atomic_t state;
+	/* bpf_prog that schedules task work */
+	struct bpf_prog *prog;
+	/* task for which callback is scheduled */
+	struct task_struct *task;
+	/* notification mode for task work scheduling */
+	enum task_work_notify_mode mode;
+	/* callback to call from task work */
+	bpf_task_work_callback_t callback_fn;
+	struct callback_head work;
+	struct irq_work irq_work;
+} __aligned(8);
+
+static bool task_work_match(struct callback_head *head, void *data)
+{
+	struct bpf_task_work_context *ctx = container_of(head, struct bpf_task_work_context, work);
+
+	return ctx == data;
+}
+
+static void bpf_reset_task_work_context(struct bpf_task_work_context *ctx)
+{
+	bpf_prog_put(ctx->prog);
+	bpf_task_release(ctx->task);
+	rcu_assign_pointer(ctx->map, NULL);
+}
+
+static void bpf_task_work_callback(struct callback_head *cb)
+{
+	enum bpf_task_work_state state;
+	struct bpf_task_work_context *ctx;
+	struct bpf_map *map;
+	u32 idx;
+	void *key;
+	void *value;
+
+	rcu_read_lock_trace();
+	ctx = container_of(cb, struct bpf_task_work_context, work);
+
+	state = atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_RUNNING);
+	if (state == BPF_TW_SCHEDULED)
+		state = atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDULED, BPF_TW_RUNNING);
+	if (state == BPF_TW_FREED)
+		goto out;
+
+	map = rcu_dereference(ctx->map);
+	if (!map)
+		goto out;
+
+	value = (void *)ctx - map->record->task_work_off;
+	key = (void *)map_key_from_value(map, value, &idx);
+
+	migrate_disable();
+	ctx->callback_fn(map, key, value);
+	migrate_enable();
+
+	/* State is running or freed, either way reset. */
+	bpf_reset_task_work_context(ctx);
+	atomic_cmpxchg_release(&ctx->state, BPF_TW_RUNNING, BPF_TW_STANDBY);
+out:
+	rcu_read_unlock_trace();
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
+	rcu_read_lock_trace();
+	state = atomic_cmpxchg_release(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING);
+	if (state == BPF_TW_FREED) {
+		bpf_reset_task_work_context(ctx);
+		goto out;
+	}
+
+	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
+	if (err) {
+		state = atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_PENDING);
+		if (state == BPF_TW_SCHEDULING) {
+			bpf_reset_task_work_context(ctx);
+			atomic_cmpxchg_release(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
+		}
+		goto out;
+	}
+	state = atomic_cmpxchg_release(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
+	if (state == BPF_TW_FREED)
+		task_work_cancel_match(ctx->task, task_work_match, ctx);
+out:
+	rcu_read_unlock_trace();
+}
+
+static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work_context *ctx,
+				  struct bpf_map *map, bpf_task_work_callback_t callback_fn,
+				  struct bpf_prog_aux *aux, enum task_work_notify_mode mode)
+{
+	struct bpf_prog *prog;
+
+	BTF_TYPE_EMIT(struct bpf_task_work);
+
+	prog = bpf_prog_inc_not_zero(aux->prog);
+	if (IS_ERR(prog))
+		return -EPERM;
+
+	if (!atomic64_read(&map->usercnt)) {
+		bpf_prog_put(prog);
+		return -EPERM;
+	}
+	task = bpf_task_acquire(task);
+	if (!task) {
+		bpf_prog_put(prog);
+		return -EPERM;
+	}
+
+	if (atomic_cmpxchg_acquire(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) != BPF_TW_STANDBY) {
+		bpf_task_release(task);
+		bpf_prog_put(prog);
+		return -EBUSY;
+	}
+
+	ctx->task = task;
+	ctx->callback_fn = callback_fn;
+	ctx->prog = prog;
+	ctx->mode = mode;
+	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
+	init_task_work(&ctx->work, bpf_task_work_callback);
+	rcu_assign_pointer(ctx->map, map);
+
+	irq_work_queue(&ctx->irq_work);
+
+	return 0;
+}
+
 /**
  * bpf_task_work_schedule_signal - Schedule BPF callback using task_work_add with TWA_SIGNAL mode
  * @task: Task struct for which callback should be scheduled
@@ -3718,7 +3874,8 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task,
 					      bpf_task_work_callback_t callback,
 					      void *aux__prog)
 {
-	return 0;
+	return bpf_task_work_schedule(task, (struct bpf_task_work_context *)tw, map__map,
+				      callback, aux__prog, TWA_SIGNAL);
 }
 
 /**
@@ -3738,13 +3895,38 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task,
 					      bpf_task_work_callback_t callback,
 					      void *aux__prog)
 {
-	return 0;
+	enum task_work_notify_mode mode;
+
+	mode = task == current && in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
+	return bpf_task_work_schedule(task, (struct bpf_task_work_context *)tw, map__map,
+				      callback, aux__prog, mode);
 }
 
 __bpf_kfunc_end_defs();
 
 void bpf_task_work_cancel_and_free(void *val)
 {
+	struct bpf_task_work_context *ctx = val;
+	enum bpf_task_work_state state;
+
+	state = atomic_xchg(&ctx->state, BPF_TW_FREED);
+	switch (state) {
+	case BPF_TW_SCHEDULED:
+		task_work_cancel_match(ctx->task, task_work_match, ctx);
+		fallthrough;
+	/* Scheduling codepath is trying to schedule task work, reset context here. */
+	case BPF_TW_SCHEDULING:
+		bpf_reset_task_work_context(ctx);
+		break;
+	/* work is not initialized, mark as freed and exit */
+	case BPF_TW_STANDBY:
+	/* The context is in interim state, scheduling logic should cleanup. */
+	case BPF_TW_PENDING:
+	/* Callback is already running, it should reset context upon finishing. */
+	case BPF_TW_RUNNING:
+	default:
+		break;
+	}
 }
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3770,6 +3952,8 @@ BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
 
 #ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
-- 
2.50.1


