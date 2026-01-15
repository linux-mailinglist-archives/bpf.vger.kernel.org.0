Return-Path: <bpf+bounces-79112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 306DDD27AA7
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8904D30D4D43
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E193D1CAF;
	Thu, 15 Jan 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRspD/sL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D43C1FD5
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501752; cv=none; b=EVoLr1KDRTIArVfUViOnXHms9ne6F0DFOPHMJ2k4Cvfqh+i/79JNquyWQ3aZEAqDYgxiDs6aCXmJmyG/GI2uVPyUHbZbekCAEvlmtUPpWFAkoH+qMDYJCl4x4pQ7T7+kNNtTjCcUVNxp2e4JXBph9GOhX7CxDpGjWMW19ohh5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501752; c=relaxed/simple;
	bh=ZBA6S6F1AZS2w7DD5XddrR3Y3D8je7n2LhtwEqBkrgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fw1Suas4zGJrD5skKZkxwA5QO9lu3szrNN//BFbdmDBfSIta6vRES75WNRbW/uZZCBcFY3os0BV2rYQgdL4TD7j7snJp5uMfh3Tw8v7czj9ZBuuLDfDLu1t/8vpFMXHXWJ+iwAQi30MMlAE2j5/IBV8P4rtyZcwoqpi7IihFw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRspD/sL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432755545fcso771890f8f.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501749; x=1769106549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxpyMbO67NTKz5xtp7C67bXthpsyzXGenQLTtjBgDj4=;
        b=SRspD/sLiCygR5yVZMPsEz1O/Obn5/9oqFgqZIADyXossaJuDs6QcX1s5SGyv6cqlS
         mIkvBva2E/okLYflwCaHvwmavHqN8Z50FP1YGr1dT5qn+9tXqk7ecsDuV3k7/peAXLVS
         96vqqhkKO5t/L0YLX6EfiRtV9VsIrnQaDavqsiM78Pn/XoqXI81Tu4+O/dO4jclgqUHt
         O/3Z8w3rdlHAUB1LAI5uzkAuJrJ8PTqcRLVUyyLNMr5Rue38tAYXlfBfdb6UMPr6PBiZ
         UvsL37LtGWQuSvyr1iplyS8VVwgFaqthgiVs1IOSEnv2BYwzUkCcTWfatCSVmjHLGGSC
         zEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501749; x=1769106549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OxpyMbO67NTKz5xtp7C67bXthpsyzXGenQLTtjBgDj4=;
        b=VwMyB98feewEb8LR08GuHXLJd6TuguK8MNH8jMYQcmAGQNeSei/zAUYHaAPJgpzLRp
         fW8XIGeE0YAKz2f3nZk5RzrgTLXXWV1tKSCaJV8dcPf+Kgic/Jh/0vAXCtTwDKCB3HV5
         sM+gw0MpeM7gc1yKp7jVjzKJm6OGU6EVEy1J3McjuCMZWIkOHwiBZPodQhRweewb9AaP
         NVJxdjjUq77p7+sNkJIuNirJMMczuttg44rEKkIoflTGcoNKe4QCNdgkPRiCk8FFY4Z9
         DycMCpYqbCRLjG4cxrAED5bz1F/7viQC4il7iK0aCjg7cPvbDVwRRXwXAjXAcGNyAWdE
         6yAg==
X-Gm-Message-State: AOJu0YyAFMB4dJ758GI86B+lHTXE5W2NtV4GWDQpeR+aVix3tV6SsvIm
	7E8f0RU/uMTLDtmS4FEhodXPv2Y0tRQTsFPsRG7G9/jH/6wphPFd/eu7jQQ5kA==
X-Gm-Gg: AY/fxX6Cgem27z0yz6NFO6F/h91VSQSRGF5iUQ8zp6cKQS5G3ewME4tYz68e57qldZQ
	6aj03GmaH609lYft5E0DmLEEcDWVUAk8h8LMa7H3z+Lp0pSSufjl2oYXKGB4oBrDPErjJxyYL5e
	yfgCMIdXvQlzWLJtn4zdNxsG4XCn5Y8+6gHrJ04gflf0vZ3GF62URAEcFoJnUr8HBmLBfSiKeCD
	BS4YnKRus7NS22T8jEwO4dyu2t3RdJPZbUsz8EltHJztozWQOwy4D71UPKalk3UDpBEONMlqIJd
	Km4bSq/tmKGVTaMDMAQHD+k4zQBgnzauBA/9KZOXFfvuwb+0dYOlQKqZXyVNwQhpxhEtzRvNk3z
	SoT9M6kgcaTrnilzOQZaBTxj0MZJ2ux61Ao9dcikpeYIzbmGTArE89unV+cLRdYZdeA==
X-Received: by 2002:a05:6000:2584:b0:431:b1e:7ff9 with SMTP id ffacd0b85a97d-43569bd2ab0mr301362f8f.59.1768501748816;
        Thu, 15 Jan 2026 10:29:08 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb1fsm424502f8f.35.2026.01.15.10.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:29:08 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 15 Jan 2026 18:27:51 +0000
Subject: [PATCH RFC v5 04/10] bpf: Simplify bpf_timer_cancel()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-timer_nolock-v5-4-15e3aef2703d@meta.com>
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768501743; l=2421;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=jzcQlAr6tN6zGAt0bwAqmKDWA6yW1+whgThFER8BgVg=;
 b=iKr0iwlc388c7MJQqQFxZhi9INYk3S3hC3tgvk1VTKffsSd9PxcRWABg+V8KXfRu1LpgojQhr
 YHodzu5Q1vhBo/gR4TFMN4cwjEr8mEuFNGwJ2IjldcH4tnjNLsQXRaT
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove lock from the bpf_timer_cancel() helper. The lock does not
protect from concurrent modification of the bpf_async_cb data fields as
those are modified in the callback without locking.

Use guard(rcu)() instead of pair of explicit lock()/unlock().

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 66424bc5b86137599990957ad2300110b4977df9..61ba4f6b741cc05b4a7a73a0322a23874bfd8e83 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1471,7 +1471,7 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
+BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 {
 	struct bpf_hrtimer *t, *cur_t;
 	bool inc = false;
@@ -1479,13 +1479,12 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 
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
+	t = READ_ONCE(async->timer);
+	if (!t)
+		return -EINVAL;
 
 	cur_t = this_cpu_read(hrtimer_running);
 	if (cur_t == t) {
@@ -1493,8 +1492,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 		 * its own timer the hrtimer_cancel() will deadlock
 		 * since it waits for callback_fn to finish.
 		 */
-		ret = -EDEADLK;
-		goto out;
+		return -EDEADLK;
 	}
 
 	/* Only account in-flight cancellations when invoked from a timer
@@ -1517,20 +1515,17 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 		 * cancelling and waiting for it synchronously, since it might
 		 * do the same. Bail!
 		 */
-		ret = -EDEADLK;
-		goto out;
+		atomic_dec(&t->cancelling);
+		return -EDEADLK;
 	}
 drop:
 	bpf_async_update_prog_callback(&t->cb, NULL, NULL);
-out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
 	/* Cancel the timer and wait for associated callback to finish
 	 * if it was running.
 	 */
-	ret = ret ?: hrtimer_cancel(&t->timer);
+	ret = hrtimer_cancel(&t->timer);
 	if (inc)
 		atomic_dec(&t->cancelling);
-	rcu_read_unlock();
 	return ret;
 }
 

-- 
2.52.0


