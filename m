Return-Path: <bpf+bounces-79647-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIWyAg3Jb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79647-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:27:25 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CAC496F6
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C135D44C8A9
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EAA31D380;
	Tue, 20 Jan 2026 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndoM4c7I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8342441B8
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924772; cv=none; b=oWI6AX32RFrbvOACN8P9z9dD86euqWRgdKUJKkE/xLQMLurlqVCV0xQnWE8O/nuPizcYEVZMzVu7zfUje8fJY8MfapDnlglhcTt53MISexugklXIZqzFPZGTEk1eIy3N1uhpOk0lXU5JqF54uRsQrQLvGYzoGqTmUCMaZuUaDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924772; c=relaxed/simple;
	bh=ZooslowKi6x4mZv06xfDVngFiqxOvETF07kCop9/J8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eryIKUJ4rJ+rb8Gv722yoEoiOXrqAmGCtpX3eXBAOCA3Wyu4qaMxAYCZ3sEXf6QvumiQ8dZ/wuYUv8ItdqaEyl8w9hFMERTBb293qtdFTfYM0LqBLT/M7YMgmR5OAwV9JWYUZXG/xZYCraRLTcAPKnRxdVWpLNjGt/3ZmBMSnZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndoM4c7I; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801d98cf39so25580745e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924769; x=1769529569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqWnkOoO44IKpCaUvr7ON3fCpeIkWc3CtYtbJroXHg8=;
        b=ndoM4c7InpMHEFMlkDgmxn+q3+JOeP4bCHnD4HfMIz6p9Af4YytJGJIEoQfV9KZc1/
         b4vWqxGmEBvsaFzsBZu3N6pfjsSikAtHb0UvXZU3mzqE/fmqnkKCjWJxAxFIyuPxXwlo
         w0AZAPQ7iIowK1ww6MmaFS8kz7hfOVSzIO0e+jJldjvXQi0S10hb8jasuCrCBi5r5Uyl
         CUaq5UKu6xqXJCaZzh7X0jgdDyl8gX/Xnz52ZBBnyZiA4g0f9M2T40c1zhKhQGlRCnyk
         NhhHLIOyEr1zTonGo5f8CsSlp88pr2kOO1SHcUIRaKHeyAhIFmckFs1Hm4/462jfxHxo
         laEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924769; x=1769529569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uqWnkOoO44IKpCaUvr7ON3fCpeIkWc3CtYtbJroXHg8=;
        b=BkAuP1bwwLWRafvhGvR/d3T7Mam7ICSmh7mt2YW9YJTiLdGSxRFwsSrIWE8pnjBBPP
         n105haI5ImJqwI1QtrGPgDnWGz1fQ1j/lWYaVn/GypYPmu0XXvuFwQrJyNV7Agt6Onxy
         XTkhysOpfQg8MklTfKb9/eYFp2nq4efPJLr8AeNrWsu48PWK39scx1xHZ1DQ8ODamOhH
         z/9OCOtSRocePX0Xa737NbJ1ByNFMiBYMGVKFIz2sglgqZdm4An6eJu+U0VmbfJzHgGC
         1ZhNPYs5Z8LGIZ25zQt1keYgURkERsoHgUHw4Qh5AivXGUGYHvd6tbThN1tdEFEWMARH
         ZQhQ==
X-Gm-Message-State: AOJu0YwOIbWZCQsnpBZr0zrHTGP1BoGt5Bs135HdxEV99ztUoVrQrOxv
	Ak+09Lb6MDH2jCh96aEd/zdlQ+xwYFBTSNvGfGQQ8IVj5UIxMT8JSxC3
X-Gm-Gg: AY/fxX5nrK30212Xg5I7vl+sLHx8Yu2yliEKXi/gp/TU2ScaB+ZHHxA/LRJyzD3WzwB
	RYNIfdfBP8fJIXRQxQPOS0tPmJJY3R/CWrXKkdxV0JrZ0mjsEViBhFkZJbuoR50Zzs0V8tQkFTJ
	wirfq3URST/jXYIQwKSxPfqNt+47gDDiOB2G35UrAtpjdzRtGs6A5hHgCFrTl2JIdw0K3dIrmpI
	PUt4N3tui9f/3P4C3+cKIRtw/F3RDQrlFZFSYqAj6C4iWLXFAjHOUDV+Qzy/yxw4z92GUahBUQl
	WuDLTcyVtK9tqXBKxdubhTDUlWipMe16/By5IXeotCnM80kSJybELOR2v7eDtE4a9GJjP0XxPrR
	sFtxFrYWI5F+KmAiq3kMwlmD+8WrRjPjQxtbGL4Non4TA/h64o8Lba+sWS+CSgtwqLPmJeKTqZk
	5TAwTxs+TFoK1/bVKUJyWesIGv
X-Received: by 2002:a05:600c:a03:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-4803d88aa32mr40824965e9.10.1768924769270;
        Tue, 20 Jan 2026 07:59:29 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fdefed9sm112555125e9.3.2026.01.20.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:59:28 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 20 Jan 2026 15:59:12 +0000
Subject: [PATCH bpf-next v6 03/10] bpf: Introduce lock-free
 bpf_async_update_prog_callback()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-timer_nolock-v6-3-670ffdd787b4@meta.com>
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768924764; l=4511;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=tI7n3QcFiwHXXuifwwcBy5vBESZa6o7uQHNNXQReUZc=;
 b=q4Aaq9KUDEG8z8/8WamevWrZ/u14KzIzZ6Zl+riX0Ab1GXwnzbiZE6a6wRoyWL0LNgizuABXV
 8Dcb5ubkEzkAFCRnzhP90aQc6kDLtRNHDzJ+2wZ83n4UJNDmTcmbHRJ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79647-lists,bpf=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: 56CAC496F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce bpf_async_update_prog_callback(): lock-free update of cb->prog
and cb->callback_fn. This function allows updating prog and callback_fn
fields of the struct bpf_async_cb without holding lock.
For now use it under the lock from __bpf_async_set_callback(), in the
next patches that lock will be removed.

Lock-free algorithm:
 * Acquire a guard reference on prog to prevent it from being freed
   during the retry loop.
 * Retry loop:
    1. Each iteration acquires a new prog reference and stores it
       in cb->prog via xchg. The previous prog is released.
    2. The loop condition checks if both cb->prog and cb->callback_fn
       match what we just wrote. If either differs, a concurrent writer
       overwrote our value, and we must retry.
    3. When we retry, our previously-stored prog was already released by
       the concurrent writer or will be released by us after
       overwriting.
 * Release guard reference.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 67 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 962b7f1b81b05d663b79218d9d7eaa73679ce94f..66424bc5b86137599990957ad2300110b4977df9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1354,10 +1354,43 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+static int bpf_async_update_prog_callback(struct bpf_async_cb *cb, void *callback_fn,
+					  struct bpf_prog *prog)
+{
+	struct bpf_prog *prev;
+
+	/* Acquire a guard reference on prog to prevent it from being freed during the loop */
+	if (prog) {
+		prog = bpf_prog_inc_not_zero(prog);
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+	}
+
+	do {
+		if (prog)
+			prog = bpf_prog_inc_not_zero(prog);
+		prev = xchg(&cb->prog, prog);
+		rcu_assign_pointer(cb->callback_fn, callback_fn);
+
+		/*
+		 * Release previous prog, make sure that if other CPU is contending,
+		 * to set bpf_prog, references are not leaked as each iteration acquires and
+		 * releases one reference.
+		 */
+		if (prev)
+			bpf_prog_put(prev);
+
+	} while (READ_ONCE(cb->prog) != prog || READ_ONCE(cb->callback_fn) != callback_fn);
+
+	if (prog)
+		bpf_prog_put(prog);
+
+	return 0;
+}
+
 static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
 				    struct bpf_prog *prog)
 {
-	struct bpf_prog *prev;
 	struct bpf_async_cb *cb;
 	int ret = 0;
 
@@ -1378,22 +1411,7 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 		ret = -EPERM;
 		goto out;
 	}
-	prev = cb->prog;
-	if (prev != prog) {
-		/* Bump prog refcnt once. Every bpf_timer_set_callback()
-		 * can pick different callback_fn-s within the same prog.
-		 */
-		prog = bpf_prog_inc_not_zero(prog);
-		if (IS_ERR(prog)) {
-			ret = PTR_ERR(prog);
-			goto out;
-		}
-		if (prev)
-			/* Drop prev prog refcnt when swapping with new prog */
-			bpf_prog_put(prev);
-		cb->prog = prog;
-	}
-	rcu_assign_pointer(cb->callback_fn, callback_fn);
+	ret = bpf_async_update_prog_callback(cb, callback_fn, prog);
 out:
 	__bpf_spin_unlock_irqrestore(&async->lock);
 	return ret;
@@ -1453,17 +1471,6 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
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
 BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 {
 	struct bpf_hrtimer *t, *cur_t;
@@ -1514,7 +1521,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 		goto out;
 	}
 drop:
-	drop_prog_refcnt(&t->cb);
+	bpf_async_update_prog_callback(&t->cb, NULL, NULL);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	/* Cancel the timer and wait for associated callback to finish
@@ -1547,7 +1554,7 @@ static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *a
 	cb = async->cb;
 	if (!cb)
 		goto out;
-	drop_prog_refcnt(cb);
+	bpf_async_update_prog_callback(cb, NULL, NULL);
 	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
 	 * this timer, since it won't be initialized.
 	 */

-- 
2.52.0


