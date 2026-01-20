Return-Path: <bpf+bounces-79650-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLG/HeXDb2lsMQAAu9opvQ
	(envelope-from <bpf+bounces-79650-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:05:25 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D779E49142
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A8E88C928F
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE36320A2E;
	Tue, 20 Jan 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meN69Uij"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926431DDB8
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924776; cv=none; b=ZG4MqikzAXV6ZwFUZD8snv37OkQA7RbS6PZnCx5uwYl4MCzL+I6OZzlqDTQhrQZrMVXreAIUe/QcaC7fV0Qncdhh1jdhBtZZPdc96bj6dk2AoJi11E03+VfCf6bCfaPj6Sh1wSCRFwzYjvJ6KT15W86hDr5bcqEHqcwoBdNS5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924776; c=relaxed/simple;
	bh=odi1lWhlP51E+KWwMhaHpC/WE2rZtxzNnwA1PMcIXrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnASTjH93TON/hrKMcoUVfD8vwR0zPaYB2G9OvjJod2yJ0sfwBERzwKeCYUiIAouII0DtYzTKoLo7hACmHc45bhUld/j9PrG+5375yHGB9F7xNxOAfnaF5wOYsxFvHpqEv5balSyqsbVGOgmf7nvca4BNPGKZWn6xftMz+isXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meN69Uij; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbc305552so4032115f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924771; x=1769529571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6Mw3asNf7XkgPzaPIFEg4yFMN4OEthPlXQODcWEq+Y=;
        b=meN69UijpbhEpLF65PMPnc0nBXNzOXPTV8fXqjNezTXtmFlM7PCfEY229aSLbNgNHs
         FpbGSKyviVYiXZ0e2wmM0feRhUUi4FBWGMtyT8dqvGM8CV6S5jDxQFGJAN+i63QsNobY
         CUd8fuCxEtglLtFYHjdpulXsU+O9x7tKPB+phXhIZskIVoV9USvsU/tLqh+Kku3IaHq8
         Xy+zAfKQSd5DmMSn1EiNRPuIftA9uz+yE7relHrlKAb4S/zBgA+XHQ4YF08nK8CaGB4N
         +JKRLG3sB4ymJMfolguPKI5xqu2DlhQcry1OUSnm+WNLsaoGcMBcQM0JpTa02uE/wk9g
         XrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924771; x=1769529571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a6Mw3asNf7XkgPzaPIFEg4yFMN4OEthPlXQODcWEq+Y=;
        b=W9JzBL5iJwtD+l4HdNOSYqWF7auFYXdDbBjgCAUAABY5LJjj3d3bCM028baTBv4JaA
         ylUwPRerC+AHy2HkTpm2LRWGK30WIdL8SIZLnh9b6PqS7JBKkjTYbYGyDkRApm8I+etc
         eLu9udBjLHF4eOJ0wWqHadd0ZkU0kEpQywcprqBTiK7tVYxlMrHTwZJHSfyKfOBog+0c
         T6cSIYFADhDibbUpbC1j3B3A/CgPurhm1wShgLZeaGpJa29icWU24wSI150knyf9WoBq
         eurR3GxRTsEikE+GeHilVsR/NY8/ZFQPVUUyATb22zB2x19U0QKieRdFKJBBX/Fc4t6x
         usbw==
X-Gm-Message-State: AOJu0YzPxbZgJuqjG19JpswyjYDt40N8QuSDHKu1cXWBJX59cVfUrlhl
	qug392cvaRo9VmgNiLRVuqAOAC/Esi6xG3i5hg/OeqUYwryAMEAfvY85dw8c1w==
X-Gm-Gg: AZuq6aLkSDs5aEiBp3OVKIcKkeefOwhHcReqKuJBb2e3aTtVTyduqoPXNVtT1qJoluM
	GHiVZJj6U3GrL3NHVDcpW7Z92DZR3gxXvzMxGy7HVR6eL+To9mk4QuxbE7y2XfnNN5pg7Ca3mAV
	m+cw+8VK1+ykpePvQFUnUrmDUuOw0wRwhA0mGRwySPjm+mixdlD5EAO3P9QNUbbhIzVEfUilW7s
	Vog0e7zxFj7GEW0SecCEVVVN7zV9D1yQumzn9wrUfWZ13kAst9TS1zIchLk12RlH7liuONAnn9c
	uEXlWDAw4E4htUYGBBVsV/3x5O0btpmBS9ShrDX2pd6+v79GwNA7q9i4oiLWi/E+PaFPyFSwzAn
	TjhmuE9ni3wzmnFYhxQWNTkwBBwQi0n2UGv/EBlQrChBY6s4Sf1k95sDd9jtahj6WkhntP24oZq
	NZaGXpKsq/N5YQvA==
X-Received: by 2002:a05:6000:1861:b0:432:dd71:8f2c with SMTP id ffacd0b85a97d-4356a03321dmr21166692f8f.10.1768924771118;
        Tue, 20 Jan 2026 07:59:31 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb2asm30384912f8f.37.2026.01.20.07.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:59:30 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 20 Jan 2026 15:59:14 +0000
Subject: [PATCH bpf-next v6 05/10] bpf: Enable bpf timer and workqueue use
 in NMI
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-timer_nolock-v6-5-670ffdd787b4@meta.com>
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768924764; l=20109;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=vmtpjNvQrC6orlcitD6yYw/xATvdC0mhrhv4NlpvS6g=;
 b=lHg3ifK0GfwqmmopNznWBeNGoJCScZCXV8UcEsf5jGF88AEwa9QI5w83aNiXQgktMl1LINP8A
 fJVcwo7I4poBjnSk05m8xN8SJRGEaVr3OqfIIQ9sYZz8NG1JHNk6dH9
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79650-lists,bpf=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,iogearbox.net,meta.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,bpf@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[bpf];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: D779E49142
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor bpf timer and workqueue helpers to allow calling them from NMI
context by making all operations lock-free and deferring NMI-unsafe
work to irq_work.

Previously, bpf_timer_start(), and bpf_wq_start()
could not be called from NMI context because they acquired
bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
patch removes these limitations.

Key changes:
 * Remove bpf_spin_lock from struct bpf_async_kern.
 * Initialize/Destroy via setting/unsetting bpf_async_cb pointer
   atomically.
 * Add per-bpf_async_cb irq_work to defer NMI-unsafe
   operations (hrtimer_start, hrtimer_try_to_cancel, schedule_work) from
   NMI to softirq context.
 * Use the lock-free seqcount_latch_t to pass operation
   commands (start/cancel/free) and parameters
   from NMI-safe callers to the irq_work handler.
 * Add reference counting to bpf_async_cb to ensure the object stays
   alive until all scheduled irq_work completes.
 * Move bpf_prog_put() to RCU callback to handle races between
   set_callback() and cancel_and_free().
 * Modify cancel_and_free() path:
   * Detach bpf_async_cb.
   * Signal destruction to irq_work side via setting last_seq to
     BPF_ASYNC_DESTROY.
   * On receiving BPF_ASYNC_DESTROY, cancel timer/wq.
 * Free bpf_async_cb on refcnt reaching 0, wait for both rcu and rcu
   task trace grace periods before freeing the bpf_async_cb. Removed
   unnecessary rcu locks, as kfunc/helper allways assumes rcu or rcu
   task trace lock.

This enables BPF programs attached to NMI-context hooks (perf
events) to use timers and workqueues for deferred processing.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 423 +++++++++++++++++++++++++++++----------------------
 1 file changed, 240 insertions(+), 183 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 61ba4f6b741cc05b4a7a73a0322a23874bfd8e83..297723d3f146a6e2f2e3e2dbf249506ae35bf3a2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,6 +29,7 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <linux/seqlock.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -1095,16 +1096,42 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
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
+enum bpf_async_seq_state {
+	BPF_ASYNC_DESTROY = (u64)U32_MAX + 1,
+	BPF_ASYNC_DESTROYED = (u64)U32_MAX + 2,
+};
+
+struct bpf_async_cmd {
+	u64 nsec;
+	u32 mode;
+	enum bpf_async_op op;
+};
+
 struct bpf_async_cb {
 	struct bpf_map *map;
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
 	void *value;
-	union {
-		struct rcu_head rcu;
-		struct work_struct delete_work;
-	};
+	struct rcu_head rcu;
 	u64 flags;
+	struct irq_work worker;
+	atomic_t writer;
+	seqcount_latch_t latch;
+	struct bpf_async_cmd cmd[2];
+	atomic64_t last_seq;
+	refcount_t refcnt;
+	enum bpf_async_type type;
 };
 
 /* BPF map elements can contain 'struct bpf_timer'.
@@ -1132,7 +1159,6 @@ struct bpf_hrtimer {
 struct bpf_work {
 	struct bpf_async_cb cb;
 	struct work_struct work;
-	struct work_struct delete_work;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer and bpf_wq */
@@ -1142,18 +1168,9 @@ struct bpf_async_kern {
 		struct bpf_hrtimer *timer;
 		struct bpf_work *work;
 	};
-	/* bpf_spin_lock is used here instead of spinlock_t to make
-	 * sure that it always fits into space reserved by struct bpf_timer
-	 * regardless of LOCKDEP and spinlock debug flags.
-	 */
-	struct bpf_spin_lock lock;
+	u32 __pad; /* Left for binary compatibility, previously stored spinlock */
 } __attribute__((aligned(8)));
 
-enum bpf_async_type {
-	BPF_ASYNC_TYPE_TIMER = 0,
-	BPF_ASYNC_TYPE_WQ,
-};
-
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
@@ -1219,45 +1236,53 @@ static void bpf_async_cb_rcu_free(struct rcu_head *rcu)
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
 
-static void bpf_wq_delete_work(struct work_struct *work)
+/* Callback from call_rcu_tasks_trace, chains to call_rcu for final free */
+static void bpf_async_cb_rcu_tasks_trace_free(struct rcu_head *rcu)
 {
-	struct bpf_work *w = container_of(work, struct bpf_work, delete_work);
-
-	cancel_work_sync(&w->work);
-
-	call_rcu(&w->cb.rcu, bpf_async_cb_rcu_free);
+	/*
+	 * If RCU Tasks Trace grace period implies RCU grace period,
+	 * there is no need to invoke call_rcu().
+	 */
+	if (rcu_trace_implies_rcu_gp())
+		bpf_async_cb_rcu_free(rcu);
+	else
+		call_rcu(rcu, bpf_async_cb_rcu_free);
 }
 
-static void bpf_timer_delete_work(struct work_struct *work)
+/*
+ * Decrement refcount and if it reaches zero, schedule deferred cleanup
+ * through call_rcu_tasks_trace() -> call_rcu() -> bpf_prog_put()/kfree()
+ */
+static void bpf_async_refcount_put(struct bpf_async_cb *cb)
 {
-	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, cb.delete_work);
+	if (!refcount_dec_and_test(&cb->refcnt))
+		return;
 
-	/* Cancel the timer and wait for callback to complete if it was running.
-	 * If hrtimer_cancel() can be safely called it's safe to call
-	 * call_rcu() right after for both preallocated and non-preallocated
-	 * maps.  The async->cb = NULL was already done and no code path can see
-	 * address 't' anymore. Timer if armed for existing bpf_hrtimer before
-	 * bpf_timer_cancel_and_free will have been cancelled.
-	 */
-	hrtimer_cancel(&t->timer);
-	call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free);
+	/* Both timer and wq callbacks run under RCU lock, UAF should not be possible there */
+	call_rcu_tasks_trace(&cb->rcu, bpf_async_cb_rcu_tasks_trace_free);
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
@@ -1270,18 +1295,13 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
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
@@ -1289,7 +1309,6 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		t = (struct bpf_hrtimer *)cb;
 
 		atomic_set(&t->cancelling, 0);
-		INIT_WORK(&t->cb.delete_work, bpf_timer_delete_work);
 		hrtimer_setup(&t->timer, bpf_timer_cb, clockid, HRTIMER_MODE_REL_SOFT);
 		cb->value = (void *)async - map->record->timer_off;
 		break;
@@ -1297,16 +1316,26 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		w = (struct bpf_work *)cb;
 
 		INIT_WORK(&w->work, bpf_wq_work);
-		INIT_WORK(&w->delete_work, bpf_wq_delete_work);
 		cb->value = (void *)async - map->record->wq_off;
 		break;
 	}
 	cb->map = map;
 	cb->prog = NULL;
 	cb->flags = flags;
+	cb->worker = IRQ_WORK_INIT(bpf_async_irq_worker);
+	seqcount_latch_init(&cb->latch);
+	atomic_set(&cb->writer, 0);
+	refcount_set(&cb->refcnt, 1); /* map's reference */
+	atomic64_set(&cb->last_seq, 0);
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
@@ -1317,13 +1346,11 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
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
@@ -1388,33 +1415,97 @@ static int bpf_async_update_prog_callback(struct bpf_async_cb *cb, void *callbac
 	return 0;
 }
 
+static int bpf_async_schedule_op(struct bpf_async_cb *cb, enum bpf_async_op op,
+				 u64 nsec, u32 timer_mode)
+{
+	/* Acquire active writer */
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
+
+	atomic_set_release(&cb->writer, 0);
+
+	if (!refcount_inc_not_zero(&cb->refcnt))
+		return -EBUSY;
+
+	if (!in_nmi()) {
+		bpf_async_irq_worker(&cb->worker);
+		return 0;
+	}
+
+	if (!irq_work_queue(&cb->worker))
+		bpf_async_refcount_put(cb);
+
+	return 0;
+}
+
+static int bpf_async_handle_terminal_seq(struct bpf_async_cb *cb, s64 last_seq,
+					 enum bpf_async_op *op)
+{
+	s64 expected = BPF_ASYNC_DESTROY;
+
+	if (last_seq != BPF_ASYNC_DESTROY)
+		return -EBUSY;
+
+	if (!atomic64_try_cmpxchg_release(&cb->last_seq, &expected, BPF_ASYNC_DESTROYED))
+		return -EBUSY; /* Someone else set it to DESTROYED, bail */
+
+	*op = BPF_ASYNC_CANCEL;
+	return 0;
+}
+
+static int bpf_async_read_op(struct bpf_async_cb *cb, enum bpf_async_op *op,
+			     u64 *nsec, u32 *flags)
+{
+	u32 seq, idx;
+	s64 last_seq;
+
+	while (true) {
+		last_seq = atomic64_read_acquire(&cb->last_seq);
+		if (last_seq > U32_MAX) /* Check if terminal seq num has been set */
+			return bpf_async_handle_terminal_seq(cb, last_seq, op);
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
+
+		/* Commit read sequence number, own snapshot exclusively */
+		if (atomic64_try_cmpxchg_release(&cb->last_seq, &last_seq, seq))
+			break;
+	}
+
+	return 0;
+}
+
 static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
 				    struct bpf_prog *prog)
 {
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
-	ret = bpf_async_update_prog_callback(cb, callback_fn, prog);
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
-	return ret;
+	cb = READ_ONCE(async->cb);
+	if (!cb)
+		return -EINVAL;
+
+	return bpf_async_update_prog_callback(cb, callback_fn, prog);
 }
 
 BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
@@ -1431,22 +1522,17 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
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
+	t = READ_ONCE(async->timer);
+	if (!t || !READ_ONCE(t->cb.prog))
+		return -EINVAL;
 
 	if (flags & BPF_F_TIMER_ABS)
 		mode = HRTIMER_MODE_ABS_SOFT;
@@ -1456,10 +1542,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
 	if (flags & BPF_F_TIMER_CPU_PIN)
 		mode |= HRTIMER_MODE_PINNED;
 
-	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
-out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
-	return ret;
+	return bpf_async_schedule_op(&t->cb, BPF_ASYNC_START, nsecs, mode);
 }
 
 static const struct bpf_func_proto bpf_timer_start_proto = {
@@ -1480,8 +1563,6 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 	if (in_nmi())
 		return -EOPNOTSUPP;
 
-	guard(rcu)();
-
 	t = READ_ONCE(async->timer);
 	if (!t)
 		return -EINVAL;
@@ -1536,79 +1617,75 @@ static const struct bpf_func_proto bpf_timer_cancel_proto = {
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
-	bpf_async_update_prog_callback(cb, NULL, NULL);
-	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
-	 * this timer, since it won't be initialized.
-	 */
-	WRITE_ONCE(async->cb, NULL);
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
-	return cb;
+		return;
+
+	atomic64_set(&cb->last_seq, BPF_ASYNC_DESTROY);
+	/* Pass map's reference to irq_work callback */
+	if (!irq_work_queue(&cb->worker))
+		bpf_async_refcount_put(cb);
 }
 
-static void bpf_timer_delete(struct bpf_hrtimer *t)
+static void bpf_async_process_op(struct bpf_async_cb *cb, u32 op,
+				 u64 timer_nsec, u32 timer_mode)
 {
-	/*
-	 * We check that bpf_map_delete/update_elem() was called from timer
-	 * callback_fn. In such case we don't call hrtimer_cancel() (since it
-	 * will deadlock) and don't call hrtimer_try_to_cancel() (since it will
-	 * just return -1). Though callback_fn is still running on this cpu it's
-	 * safe to do kfree(t) because bpf_timer_cb() read everything it needed
-	 * from 't'. The bpf subprog callback_fn won't be able to access 't',
-	 * since async->cb = NULL was already done. The timer will be
-	 * effectively cancelled because bpf_timer_cb() will return
-	 * HRTIMER_NORESTART.
-	 *
-	 * However, it is possible the timer callback_fn calling us armed the
-	 * timer _before_ calling us, such that failing to cancel it here will
-	 * cause it to possibly use struct hrtimer after freeing bpf_hrtimer.
-	 * Therefore, we _need_ to cancel any outstanding timers before we do
-	 * call_rcu, even though no more timers can be armed.
-	 *
-	 * Moreover, we need to schedule work even if timer does not belong to
-	 * the calling callback_fn, as on two different CPUs, we can end up in a
-	 * situation where both sides run in parallel, try to cancel one
-	 * another, and we end up waiting on both sides in hrtimer_cancel
-	 * without making forward progress, since timer1 depends on time2
-	 * callback to finish, and vice versa.
-	 *
-	 *  CPU 1 (timer1_cb)			CPU 2 (timer2_cb)
-	 *  bpf_timer_cancel_and_free(timer2)	bpf_timer_cancel_and_free(timer1)
-	 *
-	 * To avoid these issues, punt to workqueue context when we are in a
-	 * timer callback.
-	 */
-	if (this_cpu_read(hrtimer_running)) {
-		queue_work(system_dfl_wq, &t->cb.delete_work);
-		return;
-	}
+	switch (cb->type) {
+	case BPF_ASYNC_TYPE_TIMER: {
+		struct bpf_hrtimer *t = container_of(cb, struct bpf_hrtimer, cb);
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		/* If the timer is running on other CPU, also use a kworker to
-		 * wait for the completion of the timer instead of trying to
-		 * acquire a sleepable lock in hrtimer_cancel() to wait for its
-		 * completion.
-		 */
-		if (hrtimer_try_to_cancel(&t->timer) >= 0)
-			call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free);
-		else
-			queue_work(system_dfl_wq, &t->cb.delete_work);
-	} else {
-		bpf_timer_delete_work(&t->cb.delete_work);
+		switch (op) {
+		case BPF_ASYNC_START:
+			hrtimer_start(&t->timer, ns_to_ktime(timer_nsec), timer_mode);
+			break;
+		case BPF_ASYNC_CANCEL:
+			hrtimer_try_to_cancel(&t->timer);
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
+		case BPF_ASYNC_CANCEL:
+			/* Use non-blocking cancel, safe in irq_work context.
+			 * RCU grace period ensures callback completes before free.
+			 */
+			cancel_work(&w->work);
+			break;
+		default:
+			break;
+		}
+		break;
 	}
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
+	bpf_async_refcount_put(cb);
 }
 
 /*
@@ -1617,13 +1694,7 @@ static void bpf_timer_delete(struct bpf_hrtimer *t)
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
@@ -1631,19 +1702,7 @@ void bpf_timer_cancel_and_free(void *val)
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
@@ -3116,16 +3175,14 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
 	struct bpf_work *w;
 
-	if (in_nmi())
-		return -EOPNOTSUPP;
 	if (flags)
 		return -EINVAL;
+
 	w = READ_ONCE(async->work);
 	if (!w || !READ_ONCE(w->cb.prog))
 		return -EINVAL;
 
-	schedule_work(&w->work);
-	return 0;
+	return bpf_async_schedule_op(&w->cb, BPF_ASYNC_START, 0, 0);
 }
 
 __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,

-- 
2.52.0


