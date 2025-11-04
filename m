Return-Path: <bpf+bounces-73469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80699C32547
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D14F4E91B2
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F1C33B970;
	Tue,  4 Nov 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlrWu9Zm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83802E6125
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277221; cv=none; b=RF1kqXyfHcfdQR4j2IUECTD/m5+9nK0HxVdl8a6v+xrL7mhr6J23oF9B6iSnKB92PCZdJZLHNHhtu3Jjkl1UmzKUGZ3IzpsdsIV4Gzn7vdmE//9lqGglQGwJRwd53YaZCtgx/xYMjaR99Vn4TFSIp9vEncdliLy1c0Yc+NrQyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277221; c=relaxed/simple;
	bh=Sb1n9eBjE7C7NI78TzaRp9G8krd2gaqMN4NpE9+L+Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMil//XEg2Z9rOzzrDvw9WfnGreQvcoRuT+67nkHfCNGdB3PjjrzBpYPSsBhrKHXmYazhKN9168tw/WifNLIWJFcU7ZMq/GJc4suUVP4LwNmda55LJNfCJXtSKJeGTzuj8MjQeaSDd7IZlkgPemUAESr6rOtwNUkHhnur6fLKH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlrWu9Zm; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3410c86070dso1933542a91.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 09:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762277219; x=1762882019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4Uc5L4K25U4aWGFCzkk/D/S4FdcsMKveT4vMk6tNKo=;
        b=LlrWu9ZmXyly0zPZTLH0kmUOoz0ZLvqLJQiE4c9p4VPaMcXEQBbrjVYMk0G1dm7q4H
         7YCyvJc7tylWnT10dtS93T4Es/stIl3QzbYDyAhQvPU2ABCgvb1X9l4j3FCR47/u33Kn
         2nOMpQtTb8Z3fVnJKmR1pQepKzUWDHpLAnoMx7t7sC9pMV7AixhDl3h7WHoW8y1GgQSh
         EAlXmrnOqt9Mx0MN6a+vTi3HMxD/YuOuJv7lglhV96T8akkpdUuY0RWwX6zSyRttjfZw
         e9WpHK6hHc52k2VVjIDP/671HwMK1xKZRmn2Ei6QpCcfNgdFVcuIaKLkqLyEg7CoFLaX
         thkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277219; x=1762882019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4Uc5L4K25U4aWGFCzkk/D/S4FdcsMKveT4vMk6tNKo=;
        b=pDFttbiTlEexEsgY7Bg0bgAs7CBjHZ2VCfQHuBlM4KTjz6XCdlkWq/vyrlLx0dqKg5
         55mIme2Key8ewWYP3jptTYQq0IcTQlWNSu8Yf5TD3LDXXp2Usq3Fr4HW3fRD79ztyJt7
         R6cE2lh2EC3NppgQ0zJfx4RBRRASffQ8/p2CpaZD4q73EmpEqpJgTEZ8GqDQwJ0SqcYh
         GyWXfmDHpQujlLffM4viyEOYHKzMQ2fKnuKqmB0z9qDKrsltIwgi+Ww+f4o9K/i8hCQa
         Ky9tP9uL7OYjeDO51YGlhGA243aQGbwOkwgGCnHZRutn0aErqhbWEc5YICZfo1w8amKF
         B6rQ==
X-Gm-Message-State: AOJu0YxjaCj6hI9bt/+yOk81agajgNGXKVQVeflvG+k8pKIVWtrj1o8F
	50QUD3S483fGCEN9U8Ak2pLeB18NExL+NTU3jkcRt1if7MRPlM2z066vr6BXQA==
X-Gm-Gg: ASbGncsWBVuKxqTI0mvLlCTw5hJNnEi2MWWKlYd1M64wIbbaZzv0EWzkxZwvqwxw3/f
	FDVYlKpApE51vmH1MrjVwU7pAfkizCrADvzLOQEHu7sBCIwbvSARGHsd+WNdQzG6oCG1NMaFrLV
	1aawleTdb3+kPNtG5bIg69foEfbwh0bUPpQdmE1rlDEWNZ1gKdsEtIjtpFMRaydhqqE8nBM9p7D
	A85Z20aDUZ3+RRcKWGlYnGtqfUH3IgPDgVuhC3eKCJlKfFVaPStWE1oiYOC5vlJRx3eZGXaxzgE
	WW8/uGNy94MVIYnwoYzBz94i6ytFSTOujPLrr/8tud5LPg2v78NMxhwD8t6aT+q7GZNlUCasW1n
	RJ8UbdGSt3NKv8eZwKQFOiMZLwaePZo/2/c6xltiGjjRq9w6HyZHxgAFXxauCCfyFRtw=
X-Google-Smtp-Source: AGHT+IED2iAv87Zk0XYvQpPdJ3QzUb0gE5SKXmv6qorbvqEmasTm92j6yi0iRO+B3PsQC2YQ79HrNw==
X-Received: by 2002:a17:902:f70d:b0:26c:e270:6dad with SMTP id d9443c01a7336-2962ade80c3mr3611225ad.60.1762277218768;
        Tue, 04 Nov 2025 09:26:58 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019729b5sm32922795ad.10.2025.11.04.09.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:26:58 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 3/7] bpf: Pin associated struct_ops when registering async callback
Date: Tue,  4 Nov 2025 09:26:48 -0800
Message-ID: <20251104172652.1746988-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104172652.1746988-1-ameryhung@gmail.com>
References: <20251104172652.1746988-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take a refcount of the associated struct_ops map to prevent the map from
being freed when an async callback scheduled from a struct_ops program
runs.

Since struct_ops programs do not take refcounts on the struct_ops map,
it is possible for a struct_ops map to be freed when an async callback
scheduled from it runs. To prevent this, take a refcount on prog->aux->
st_ops_assoc and save it in a newly created struct bpf_async_res for
every async mechanism. The reference needs to be preserved in
bpf_async_res since prog->aux->st_ops_assoc can be poisoned anytime
and reference leak could happen.

bpf_async_res will contain a async callback's BPF program and resources
related to the BPF program. The resources will be acquired when
registering a callback and released when cancelled or when the map
associated with the callback is freed.

Also rename drop_prog_refcnt to bpf_async_cb_reset to better reflect
what it now does.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/helpers.c | 105 +++++++++++++++++++++++++++++--------------
 1 file changed, 72 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 930e132f440f..5c081cd604d5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1092,9 +1092,14 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
 	return (void *)value - round_up(map->key_size, 8);
 }
 
+struct bpf_async_res {
+	struct bpf_prog *prog;
+	struct bpf_map *st_ops_assoc;
+};
+
 struct bpf_async_cb {
 	struct bpf_map *map;
-	struct bpf_prog *prog;
+	struct bpf_async_res res;
 	void __rcu *callback_fn;
 	void *value;
 	union {
@@ -1299,8 +1304,8 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		break;
 	}
 	cb->map = map;
-	cb->prog = NULL;
 	cb->flags = flags;
+	memset(&cb->res, 0, sizeof(cb->res));
 	rcu_assign_pointer(cb->callback_fn, NULL);
 
 	WRITE_ONCE(async->cb, cb);
@@ -1351,11 +1356,47 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+static void bpf_async_res_put(struct bpf_async_res *res)
+{
+	bpf_prog_put(res->prog);
+
+	if (res->st_ops_assoc)
+		bpf_map_put(res->st_ops_assoc);
+}
+
+static int bpf_async_res_get(struct bpf_async_res *res, struct bpf_prog *prog)
+{
+	struct bpf_map *st_ops_assoc = NULL;
+	int err;
+
+	prog = bpf_prog_inc_not_zero(prog);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	st_ops_assoc = READ_ONCE(prog->aux->st_ops_assoc);
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	    st_ops_assoc && st_ops_assoc != BPF_PTR_POISON) {
+		st_ops_assoc = bpf_map_inc_not_zero(st_ops_assoc);
+		if (IS_ERR(st_ops_assoc)) {
+			err = PTR_ERR(st_ops_assoc);
+			goto put_prog;
+		}
+	}
+
+	res->prog = prog;
+	res->st_ops_assoc = st_ops_assoc;
+	return 0;
+put_prog:
+	bpf_prog_put(prog);
+	return err;
+}
+
 static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
 				    struct bpf_prog_aux *aux, unsigned int flags,
 				    enum bpf_async_type type)
 {
 	struct bpf_prog *prev, *prog = aux->prog;
+	struct bpf_async_res res;
 	struct bpf_async_cb *cb;
 	int ret = 0;
 
@@ -1376,20 +1417,18 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 		ret = -EPERM;
 		goto out;
 	}
-	prev = cb->prog;
+	prev = cb->res.prog;
 	if (prev != prog) {
-		/* Bump prog refcnt once. Every bpf_timer_set_callback()
+		/* Get prog and related resources once. Every bpf_timer_set_callback()
 		 * can pick different callback_fn-s within the same prog.
 		 */
-		prog = bpf_prog_inc_not_zero(prog);
-		if (IS_ERR(prog)) {
-			ret = PTR_ERR(prog);
+		ret = bpf_async_res_get(&res, prog);
+		if (ret)
 			goto out;
-		}
 		if (prev)
-			/* Drop prev prog refcnt when swapping with new prog */
-			bpf_prog_put(prev);
-		cb->prog = prog;
+			/* Put prev prog and related resources when swapping with new prog */
+			bpf_async_res_put(&cb->res);
+		cb->res = res;
 	}
 	rcu_assign_pointer(cb->callback_fn, callback_fn);
 out:
@@ -1423,7 +1462,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
 		return -EINVAL;
 	__bpf_spin_lock_irqsave(&timer->lock);
 	t = timer->timer;
-	if (!t || !t->cb.prog) {
+	if (!t || !t->cb.res.prog) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1451,14 +1490,14 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static void drop_prog_refcnt(struct bpf_async_cb *async)
+static void bpf_async_cb_reset(struct bpf_async_cb *cb)
 {
-	struct bpf_prog *prog = async->prog;
+	struct bpf_prog *prog = cb->res.prog;
 
 	if (prog) {
-		bpf_prog_put(prog);
-		async->prog = NULL;
-		rcu_assign_pointer(async->callback_fn, NULL);
+		bpf_async_res_put(&cb->res);
+		memset(&cb->res, 0, sizeof(cb->res));
+		rcu_assign_pointer(cb->callback_fn, NULL);
 	}
 }
 
@@ -1512,7 +1551,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 		goto out;
 	}
 drop:
-	drop_prog_refcnt(&t->cb);
+	bpf_async_cb_reset(&t->cb);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	/* Cancel the timer and wait for associated callback to finish
@@ -1545,7 +1584,7 @@ static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *a
 	cb = async->cb;
 	if (!cb)
 		goto out;
-	drop_prog_refcnt(cb);
+	bpf_async_cb_reset(cb);
 	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
 	 * this timer, since it won't be initialized.
 	 */
@@ -3112,7 +3151,7 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 	if (flags)
 		return -EINVAL;
 	w = READ_ONCE(async->work);
-	if (!w || !READ_ONCE(w->cb.prog))
+	if (!w || !READ_ONCE(w->cb.res.prog))
 		return -EINVAL;
 
 	schedule_work(&w->work);
@@ -4034,8 +4073,8 @@ struct bpf_task_work_ctx {
 	refcount_t refcnt;
 	struct callback_head work;
 	struct irq_work irq_work;
-	/* bpf_prog that schedules task work */
-	struct bpf_prog *prog;
+	/* bpf_prog that schedules task work and related resources */
+	struct bpf_async_res res;
 	/* task for which callback is scheduled */
 	struct task_struct *task;
 	/* the map and map value associated with this context */
@@ -4053,9 +4092,9 @@ struct bpf_task_work_kern {
 
 static void bpf_task_work_ctx_reset(struct bpf_task_work_ctx *ctx)
 {
-	if (ctx->prog) {
-		bpf_prog_put(ctx->prog);
-		ctx->prog = NULL;
+	if (ctx->res.prog) {
+		bpf_async_res_put(&ctx->res);
+		memset(&ctx->res, 0, sizeof(ctx->res));
 	}
 	if (ctx->task) {
 		bpf_task_release(ctx->task);
@@ -4233,19 +4272,19 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
 				  struct bpf_map *map, bpf_task_work_callback_t callback_fn,
 				  struct bpf_prog_aux *aux, enum task_work_notify_mode mode)
 {
-	struct bpf_prog *prog;
 	struct bpf_task_work_ctx *ctx;
+	struct bpf_async_res res;
 	int err;
 
 	BTF_TYPE_EMIT(struct bpf_task_work);
 
-	prog = bpf_prog_inc_not_zero(aux->prog);
-	if (IS_ERR(prog))
-		return -EBADF;
+	err = bpf_async_res_get(&res, aux->prog);
+	if (err)
+		return err;
 	task = bpf_task_acquire(task);
 	if (!task) {
 		err = -EBADF;
-		goto release_prog;
+		goto release_res;
 	}
 
 	ctx = bpf_task_work_acquire_ctx(tw, map);
@@ -4256,7 +4295,7 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
 
 	ctx->task = task;
 	ctx->callback_fn = callback_fn;
-	ctx->prog = prog;
+	ctx->res = res;
 	ctx->mode = mode;
 	ctx->map = map;
 	ctx->map_val = (void *)tw - map->record->task_work_off;
@@ -4268,8 +4307,8 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
 
 release_all:
 	bpf_task_release(task);
-release_prog:
-	bpf_prog_put(prog);
+release_res:
+	bpf_async_res_put(&res);
 	return err;
 }
 
-- 
2.47.3


