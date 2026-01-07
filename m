Return-Path: <bpf+bounces-78136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A96ACCFF8C9
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6C0632CA1E7
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5A395272;
	Wed,  7 Jan 2026 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caqrqUU3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45442357A21
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808185; cv=none; b=CfRYlgzp9blK/k3Ymakqg/6YjkP7RRDt5j8LZCyPCYX/GhQtyiLh72qY5XJfJiFnqMG2mjf79ya7TPv9ubdMoeC2M/z6O9GRfBnbCtvOPXKKpGsCEGtm9m+YmWLq6bA/l0i2Jqw/h92yaYjLgYvWIdTknuKot21Hi1S/cxGy0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808185; c=relaxed/simple;
	bh=oFLwVIP8XtsCU1gyH6SjVw9Dv4BY3OIWoiFkpyThdaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M86IDk9n7VizAOg98AA2YRcUIxpNKdvnUCjubfMrpaWqLegi4b8UqU3CJ5S5fw2xMKOIsKmrAR9MYh0F6Vfk/W1sqUE6iY0ZDiYm3E6Bti/bHwOUWzD78/9zVlOHMeBiGKHgrzxtDzOmjcHgO5AYgbx5mEOGaqrdMfYG48d/XYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caqrqUU3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47796a837c7so17753135e9.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 09:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808178; x=1768412978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnxvieoj09zg/dR6YhxM559+fdWTWBDpA8dBXOJOK7g=;
        b=caqrqUU3+tUOTtgBaMRGt2bAKWAhA7rry0NkO9qBOEcJydt8kwQcf1XiWZItvFAoLk
         CUuhT8RhF15efIX28YGSYc8LYDsPp2O2TA1jro+xAYjB2vKKoGTpIIiCUwYZhjaFrTIy
         teFA532h1Jr/rHBrXC6pnX52okDJ5s15SNollrbQThaVh3tcnhE2YJjshaxLkhkp3oWi
         CYTW3QJpdKzQq+sxd8gVBUcE2aJpng/lPIbsbE0gNFhtS4yd2nyqFss63lTNsQSUc7Qb
         R4GSR6NSfQDzbJ5liogVqrUytsVc2dWVJTn7FM8+POmY6ddlqeTgaukBSKIvkObsSPwF
         tgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808178; x=1768412978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vnxvieoj09zg/dR6YhxM559+fdWTWBDpA8dBXOJOK7g=;
        b=CvawEtQpcqiR1x8vnq7kpad+KeCiLffC+71LTxMqsKhb5JaxPKypz8ZYMFJqrXlxnJ
         NloIBnhngA7+6D9JVOWJFfDLkaDxLpnOFxWO5NJvNAQ+IZM5T/6w/mxtPw73Y0ZpSug6
         Lw8h2hcAJ9ZiWeQ6fJUgniPCvUbkF+OoxcxcI39kNm+/SlKFW8A83eNEkdDWmS8U1f3Y
         vpzDcy47CWjRwlotELbhN852k7mygXpnOxJ/68aX3IFUXJ7yC4O+PAxy8uxXae7Xzph0
         9LxCbcGUDNcUDk8MDl64PQh4XIVS1bo650sDynTlTJzXuxDcBFuTB4qkSyAof6t4n2s3
         4vuQ==
X-Gm-Message-State: AOJu0Yywp7YCz4GiQPfJj6BEXq6XyhwKUOm3tKUt5gmK1UBf0tOGJR2g
	iUSiDQdSCnWn4Pks+NgKamvSAchsmGgA2+PFHu+gKhtvWaVlCi8eXCn2
X-Gm-Gg: AY/fxX4vNrA9xnKz2GcY0BA314HiT6Mp8/O/YCS2XuS/KljQOcspuqoALYoecIOJQCU
	mho/FHk+BH7JW1dzqxDa96dGI/93QRH1ARB7QYCO3T2ndXPVaeyH6mIJbcnYcbF19f/HeN7Ci+6
	02cTXT2EFRFSy2AflO3be+WCLYDvT0L2TFgPWNrC8KGzvfA3fQHW6aU/v7pdCT3e8VGPXVDuwqM
	arDlBmCFs0uD/otng6VwG25aeltyqbcSPGBMsN5YJzoScY9bAigGVs5VESvRvopxQUcKYlyBE9d
	q0AOcoi1w8VonQ9rHh0yZfE9LY95aDX3mPmnWl9ESR2o4Zeuwrf85Pw2I0+ZjJm+XvrAeKCebBe
	tCjAyuW9kZluNpzBfY+PZqi8xcrOTfgmcaYSHcgIQIfwsgwJecNe+jrV3dNibDO6fx88=
X-Google-Smtp-Source: AGHT+IEfoXG4v6VrnpddFa48gfP9tUV6eFsMIV8hZsWMDKLpIlxA/bo4ze9RIWzU+t4TlL7gjVupyA==
X-Received: by 2002:a05:600c:8b0a:b0:47d:264e:b435 with SMTP id 5b1f17b1804b1-47d84b54c62mr39984555e9.22.1767808177593;
        Wed, 07 Jan 2026 09:49:37 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:d4be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695956sm108749635e9.6.2026.01.07.09.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:49:37 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 07 Jan 2026 17:49:05 +0000
Subject: [PATCH RFC v3 03/10] bpf: Simplify bpf_timer_cancel()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-timer_nolock-v3-3-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767808173; l=2356;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=PP3XvQILcCH3YGKVYUkHG6nKQzBkRbHd72N8hbBClSY=;
 b=nmUTwJJEGnZcK9pH0O4yrqRb/gc9g9mAENvcn1PLIdY8TouDY5+HJq5hBoN7G3K1NiOJF3oww
 RZE+GZMKQkGD/zGEMfFjq5q4yotBA4uWT4OZiV8/SkOITpTXv8//TA3
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove lock from the bpf_timer_cancel() helper. The lock does not
protect from concurrent modification of the bpf_async_cb data fields as
those are modified in the callback without locking.
Use guard(rcu)() instead of pair of explicit lock()/unlock().

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ff3c1e1160db748991f2a71e6a44727fc29424d5..dc8ed948321e6c535d2cc2e8f9fbdd0636cdcabf 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1446,7 +1446,7 @@ static void drop_prog_refcnt(struct bpf_async_cb *async)
 	}
 }
 
-BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
+BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 {
 	struct bpf_hrtimer *t, *cur_t;
 	bool inc = false;
@@ -1454,13 +1454,12 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 
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
+	t = async->timer;
+	if (!t)
+		return -EINVAL;
 
 	cur_t = this_cpu_read(hrtimer_running);
 	if (cur_t == t) {
@@ -1468,8 +1467,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 		 * its own timer the hrtimer_cancel() will deadlock
 		 * since it waits for callback_fn to finish.
 		 */
-		ret = -EDEADLK;
-		goto out;
+		return -EDEADLK;
 	}
 
 	/* Only account in-flight cancellations when invoked from a timer
@@ -1492,20 +1490,19 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 		 * cancelling and waiting for it synchronously, since it might
 		 * do the same. Bail!
 		 */
-		ret = -EDEADLK;
-		goto out;
+		atomic_dec(&t->cancelling);
+		return -EDEADLK;
 	}
+
 drop:
-	drop_prog_refcnt(&t->cb);
-out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
+	__bpf_async_set_callback(async, NULL, NULL);
 	/* Cancel the timer and wait for associated callback to finish
 	 * if it was running.
 	 */
-	ret = ret ?: hrtimer_cancel(&t->timer);
+	ret = hrtimer_cancel(&t->timer);
+
 	if (inc)
 		atomic_dec(&t->cancelling);
-	rcu_read_unlock();
 	return ret;
 }
 

-- 
2.52.0


