Return-Path: <bpf+bounces-79111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E8D27B37
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9312E30899E4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36733C1FFD;
	Thu, 15 Jan 2026 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwBW0L+r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B13C1FCB
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501751; cv=none; b=GEHG6cdfexKNvvxbG3iS4VKEnYbaEEW3XqiLKZoTl7YbV896bHW8kroWlgRc/o5k0tNONs6AklbBJC4nqls8NdOAsk1YC30hupqhCKFhWT3G/D9f9AIbSjSCGTCDecAu7m1ChgptqE0HyyxyIFIDR02tJM+Zp3xemrnhlKZiVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501751; c=relaxed/simple;
	bh=HQAtN9lGAATmkanirfbtuCIB7Exvb+ys/rOiiZ8iuWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2HYU+I/A94yUR+fmwM+uWM1y+IxgPrHQX0Rj6aL6VzedAh1500J5Z0qm8sJ2DbJr/VtD3sOW3lcQZi3wCdmK3DdZx5mukzZ6UN9e+oQOZn9KMkhCdsr3EnsDqKO0VZ6AvYcPqXVEpX6V8FivcQFMpmcuV6g0bfTvs07lYMoV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwBW0L+r; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so642223f8f.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501748; x=1769106548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H22CYadfa4Yy1/j2GhCnEt0wPc2MNkMnbP7PRB3kysQ=;
        b=JwBW0L+rVnOsxmOKo2PHIPYpff1lQhIAvEKOFSeSPQ7/yOlu1AUi0s9rdRxAvXqG5/
         RdEQ+9oVcp7WRCvR9op8nMnpshzqCeU8WnJ4vXu5ktN/DmfWeY2D0aVF4IjLq3Z+T/Hj
         +eLEWZeLD2EcUJvUAuATci2Rb2pFko+AdVkktSppKrH3wZe7g5VtSHJywVxrG+4YrQyg
         ZSAaAx+sX+/mrK2VQIC3yalOj3KXLpKDvc0Wu3NEQlLO54lnosGOpas9/cqsCi2PKhZk
         4SB02565f3liZgJmOFlNTLcUbBGuYQ3nvveaiaDc2pysQxc80gdzULzvkgSvMQEBVe9d
         vhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501748; x=1769106548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H22CYadfa4Yy1/j2GhCnEt0wPc2MNkMnbP7PRB3kysQ=;
        b=fPKncKtAprl2FAwE4nADzhwEC4kR5BdlmuisH9BrzKosIuwUICNtbHaNJCIC3e1qYd
         YjCyX27ORM9E7updL7suT/txUNuElxBBtR0hgVOe66rSfNdjnRDi8P1NNDI35ik71v5J
         0sG2Y1JrZ0DpsRlBXVV/O+8wwrrsDINSZd5/RPNcOL0QrRfjx6OyoasN7Nn92g4a25Pa
         3pdxi8GOzOw4oxJOSAM4Ix3QvMvIqbbUO65s8CHavUCn7eI1uNeeBitUXQRB3+XrOJeG
         f2jz3RwHXcsrUJYwNtbQ3au5eHeWbK+4ubRKd0a4FtrXXz90tzfkLC1O700S55mmW1Lt
         s/hQ==
X-Gm-Message-State: AOJu0Yz9ZcVDue9Qb+jxz9TfUhVxjEUjrJ7kFVFQdSQm1mxTJJCxh1oJ
	s/bjnXxfA750+jyRm/8OOHjSneLXvkQ+kN0BwvGcqf61kGoy9ZRWxR8tS59/Ng==
X-Gm-Gg: AY/fxX7nwZYatN4bVBwqJCFSUpVk070PtOfUXmQt4NshFctUX2GktnFzDPpKhuRGigC
	Kd6eNTXa4dek33CgqZaJHwb2vSStPUz3JwCKRPiOsDqXs7EahvSr5UEe9JPr9Kjg2O/JsjwXO8X
	X2cPv1aTD3T6kmTP8HSvsPW8mDDZbEsFuky90Bb7ayrV/YcjsdMBmtE3HtIza4m0S4kXov+dzp1
	qWl9gTOpWj2XPKQqRflNC3U5SbHV+sh8cfRNtuAw5/A7kUnvBzSYLbX1RMDexEtMVqL69pCcKWZ
	+JKh0pgUmmWZG9EMmirqtY88/HPY7PfrnAsQIYVOaYs6SnC1J/FUGW6diySfQOX78PNsYFz9n2M
	grG9w3SiNbcmEu8a55bgCzTjBZs0MfK9NQZUgc3MeGrltwq1sKQQdLstNMEKOTGsVniEG3maask
	h4
X-Received: by 2002:a5d:5f88:0:b0:432:8585:3416 with SMTP id ffacd0b85a97d-4356a05c154mr309599f8f.45.1768501747962;
        Thu, 15 Jan 2026 10:29:07 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996e2d8sm455104f8f.28.2026.01.15.10.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:29:07 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 15 Jan 2026 18:27:50 +0000
Subject: [PATCH RFC v5 03/10] bpf: Introduce lock-free
 bpf_async_update_prog_callback()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-timer_nolock-v5-3-15e3aef2703d@meta.com>
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768501743; l=4464;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=IHxH7lS8Wgt54HmcOnHqw7DwEaf14Zyy4kqHH9pDxX8=;
 b=eOTSSuSIHRV9JpK3/Xgb6GbFHB2wNo81YIroS0b2UOc8O6yzItF7deOYSOapHdlciPq+P14aV
 vt/xMx7sj+CCsxHoIPvZNXtJb05XPMDvMZrKE+fzFuCVdhxxaHGdVKZ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

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


