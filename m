Return-Path: <bpf+bounces-78137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F97CFF426
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A831303929C
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABAF394499;
	Wed,  7 Jan 2026 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4/7u2Y4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004B3816E5
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808188; cv=none; b=pBRz7tZjwd5ZSHtkgiPsx++olZHohwyVpKqiv+ClTdz5KLmF0FG1h6mZ55m6UrUIba+aZXM4b6ObhE/TwBb+UYot1TysMyY+YcwGAAxgNQW4/9VcuBYCqh7xezcPjYyb58NRM17ujkYZMjLZlUkFfruhwixVRrTuRLYetwU7qvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808188; c=relaxed/simple;
	bh=xp54MwOtC5CKSVx5z12wkytIk4hNwHZF2zPjuqTm1ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAEaKYUYTUucwvLbPYVDP1UzMO+QLdHkAqqT0oq6Ky2oIVPmW0O3jL/64HA2uHzAZLRFFqToG82EkkWqCN2ndFpyIFlEIe+taJ9mL9f11HOvbqFKfxf9oS4dBdyibZYwUFWEhXAh5qMixH+hRdhblTgABhp+E0JUDtpyZLQ3BIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4/7u2Y4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2e77f519so1504158f8f.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 09:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808176; x=1768412976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTa//AwztEiHsI/IkTIrKPX2kY9vKjiRXhm7S9gbV1o=;
        b=H4/7u2Y4w9MYIbB33HQzFtdtq2/Ti3U7VXYq+EQmI7Wy4rpS1QL1eQ5Bvu/hS+4vJb
         RIC/kXPZBDTw7Esy3PchBAGK50TKJveB5UU1Oe5E13u1Dnhyp/XEfXpfQfRZVdwDVXMg
         L/xC5Y9B0PB7SNxkZK04cNDaRy+F2/zST084HASsJulrQ3thwod6uuecwduu18oaSwLi
         9Y/XD2VNpApXZ+eQDFy6HKj1j2WTXcDGbkwrZnyWA9HzA02a8dxi9swBTKH7uOZy2zqR
         GZbI/b7nBG8nmkGz8Wnybb9eOXn1nWzG5h+tZXT6sPHS47XchDINFZebuP6bl1cqERwN
         idPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808176; x=1768412976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mTa//AwztEiHsI/IkTIrKPX2kY9vKjiRXhm7S9gbV1o=;
        b=Nwy3juFbpzl/lmHi22b2bmXXy31OyDKWFkIYopmejSLs7U5OVWZxewmQY33s4MVoVP
         00G+M5gAR7Ybys2iRBCMhJxqUKRERdKMW1DINbecY9DN723AWTjW2CLBV1ZH9n6LsDAp
         0W+1nc3Lp1yGgoXDByKuCOrDWKRdMSI6CJZZiv9S8ZAzBpjFlSF5eXN6cqOIS3fnAedT
         um/xbG3Sk4kJ9LR1NNW1vn3Oiqs5yPJpc1HS7LeIU9fyVvOpAT9TUpVb2iQTiEpEn9Ng
         hSqlSjQ3iDd9UvnIUd1MgoZTj4+shMAHHytoFU7K/J3B5E/bOQaB7mUPJHLL0RF9Cct5
         dR4g==
X-Gm-Message-State: AOJu0YyB0P8WNY4zBu/HS8nOk8HE/l1PmXyW0ZXfh+kQ+t6fN6KqFDs5
	y2pMY17aDZSoKHzeudeshLVdTCo9Rdzh79YQcJvS2agMlS4MHYF2j4du
X-Gm-Gg: AY/fxX4g8VxHN1fEln6ZbpWa0dtA/oTkfd6QMLMGiQTAR3VHX3RRwCc8jGnvgVk3fci
	Q0lKRKf2VNH754YIqBT2FOyzC8DI6QPa4Z7xOtlAbfm6bZyEGSXJM9a13Y53hzJzrl9SOYIH+Z2
	TIR2u/4Y2jWO+lObXbvfplUvFTWYXGX5YpTy6WyY+0XB/30QofPHalQvkKrK5D4g0uG4vpiN4d6
	WrFtKPWlumL1Lk2GxX98CHoC3XYYcmwreApj+pgXl+Wymugz8YB1JaHuuwmF5dEJnzihm3ALPhJ
	u5uysR3Z9SzUQZqzAtHqrshwIxvaXptI1Ipueypt4QtQLK+EP0NJ68KoI1+BVxWiAECUdrZIR3i
	uyZNIFyz7xBnCELYMTUuhGXX81xX5IIQuIfeJk4odGNc2Mag/984fn0QbJrWoyXXYhus=
X-Google-Smtp-Source: AGHT+IFGi92lBsh87aJz49O+mmMzB4Gd8fU8Sgrjshh2/Xe+561APymcmRoqJhYHZ3BR9wBtLfv3QA==
X-Received: by 2002:a05:6000:2084:b0:430:f742:fbb8 with SMTP id ffacd0b85a97d-432c3775ad0mr4437934f8f.21.1767808175685;
        Wed, 07 Jan 2026 09:49:35 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:d4be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacdcsm11439966f8f.1.2026.01.07.09.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:49:35 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 07 Jan 2026 17:49:03 +0000
Subject: [PATCH RFC v3 01/10] bpf: Refactor __bpf_async_set_callback()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-timer_nolock-v3-1-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767808173; l=3413;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=+DoOffv1z0pvktJsjn7CB3ZWgt+I0JjussgHvRgxxEY=;
 b=pHkOodG05VWPjvoGom2DBGFdjhQOnHwJWD30a5YRN3SS7LUm9pnrpmwVXozRPWuF14km/irAz
 3okeWYEh+jeBVXgn62wmSTcskj6ql+jJK1zUncLsl86HYouziZDLOge
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor __bpf_async_set_callback() getting rid of locks. The idea of the
algorithm is to store both callback_fn and prog in struct bpf_async_cb
and verify that both pointers are stored, if any pointer does not
match (because of the concurrent update), retry until complete match.
On each iteration, increment refcnt of the prog that is going to
be set and decrement the one that is evicted, ensuring that get/put are
balanced, as each iteration has both inc/dec.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 61 ++++++++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9eaa4185e0a79b903c6fc2ccb310f521a4b14a1d..954bd61310a6ad3a0d540c1b1ebe8c35a9c0119c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1355,55 +1355,36 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 };
 
 static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
-				    struct bpf_prog_aux *aux, unsigned int flags,
-				    enum bpf_async_type type)
+				    struct bpf_prog *prog)
 {
-	struct bpf_prog *prev, *prog = aux->prog;
-	struct bpf_async_cb *cb;
-	int ret = 0;
+	struct bpf_prog *prev;
+	struct bpf_async_cb *cb = async->cb;
 
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
-	prev = cb->prog;
-	if (prev != prog) {
-		/* Bump prog refcnt once. Every bpf_timer_set_callback()
-		 * can pick different callback_fn-s within the same prog.
-		 */
-		prog = bpf_prog_inc_not_zero(prog);
-		if (IS_ERR(prog)) {
-			ret = PTR_ERR(prog);
-			goto out;
+	if (!cb)
+		return -EPERM;
+
+	do {
+		if (prog) {
+			prog = bpf_prog_inc_not_zero(prog);
+			if (IS_ERR(prog))
+				return PTR_ERR(prog);
 		}
+
+		prev = xchg(&cb->prog, prog);
+		rcu_assign_pointer(cb->callback_fn, callback_fn);
+
 		if (prev)
-			/* Drop prev prog refcnt when swapping with new prog */
 			bpf_prog_put(prev);
-		cb->prog = prog;
-	}
-	rcu_assign_pointer(cb->callback_fn, callback_fn);
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
-	return ret;
+
+	} while (READ_ONCE(cb->prog) != prog || READ_ONCE(cb->callback_fn) != callback_fn);
+
+	return 0;
 }
 
 BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
 	   struct bpf_prog_aux *, aux)
 {
-	return __bpf_async_set_callback(timer, callback_fn, aux, 0, BPF_ASYNC_TYPE_TIMER);
+	return __bpf_async_set_callback(timer, callback_fn, aux->prog);
 }
 
 static const struct bpf_func_proto bpf_timer_set_callback_proto = {
@@ -3131,7 +3112,7 @@ __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 	if (flags)
 		return -EINVAL;
 
-	return __bpf_async_set_callback(async, callback_fn, aux, flags, BPF_ASYNC_TYPE_WQ);
+	return __bpf_async_set_callback(async, callback_fn, aux->prog);
 }
 
 __bpf_kfunc void bpf_preempt_disable(void)

-- 
2.52.0


