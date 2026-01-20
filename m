Return-Path: <bpf+bounces-79648-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMIeCtnIb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79648-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:26:33 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638F496CA
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D79392528D
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1636331E0EF;
	Tue, 20 Jan 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmUMXchq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4922D592C
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924773; cv=none; b=oTjxZ+x5JPhD3bpT5xjwEi2drDgyuZuMlxc7tugJK/hy7TwVCaboXsBQ9n+Zi9ZguVDsJZ/9VH7c4oB+FCjdJ+1bcnzuBLXXcb5o5iR9fQsbBVX6vZCltRjjjiaYbAGHDW9M4w0n/OuBYQ5zGJqAlmGE/SDn7eVQLRnfSR3gZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924773; c=relaxed/simple;
	bh=012+ueB/iclDmDJcMymqlS+jdL8afl2YsV2KTrsJL8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/X3zQPHkGiS++p87Jd7LUXmdJDO0lcvlNAy1Kgg27TyfrcfRlHHlFLmBSIbiF/0g8fTbBmslFlIXOLj6iabdtah7egsaj2D+T0Sp0zRXoOAQ84MZ2jTqd8qOZXcznj9lUw/38l1JlD+zmhoAGuD/bBayGESNPt3OMhhp8nZrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmUMXchq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so35471205e9.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924770; x=1769529570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nN8lueH9pAB22PYLps4QKe2d7qkMtYJ8w5ylcyUCTdo=;
        b=bmUMXchq1sjjw2SFi+AX7GB6k4254DhDZ6eRf9m1OFSky4SzfeaDfng+9a+h+XRyFh
         Mj8fs9nmtuCeZral87KsIQCRAkWR5jeuXLGD+zkIxgN087f+eDNoTfkgwJEOqy1Qldk7
         s1WMv6/JOlofgMOnrCaxRrW+o0wCZmCLW6VbdVPdwtjkXJiS3AefNNDtOrUOcffE7yzU
         /E4d+vUblQQgHGLoryoz83xgBngtmnnVhwKWnywmJPyCd+pW4t+7xH4uES+QdQTeX5TP
         QbvQ8uI2AQklxzWV52hxgZT+nZYoi9NkTgAA0C40NKvRyBpRH/YIP3001+MPnidNrPMK
         mLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924770; x=1769529570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nN8lueH9pAB22PYLps4QKe2d7qkMtYJ8w5ylcyUCTdo=;
        b=tSALycn/gQSjfD/zPOeFr/JyDGrgt6syeuoN8O4E9KX191tA6rBHZQ/zLMSnND9ep9
         zgvjbKkrHm1zTpUFgDTuuDYHU109nl0/vepLluq0HGCPoQmWpsl8/MfJ+JlidWcYdnM1
         lY7d1iUkMNBJ9qz/SZuF+z3lwoh3S90ITdxQvpMYPZDytq3SClAUeufN7AumCWjOoem6
         2eTAZUeX/XVdVI4+rp3MKGBQlNkoynqYsvJqj0wJyZ/Q+nFwpdJYe0FNfWa6O9dNubCB
         5iU4Y9EtAWi/0Xmfri+eADy3HGPbxUMjlD2CNJxorl6ngPTIZRLOa89YB4HTUMfQy1kY
         Nf4w==
X-Gm-Message-State: AOJu0YwyHITNbMrGk46ZTb43I+zHpNYUTatwJTwQKTUt0d2N2MjKLj68
	eVj9mRiMOzY9g+jekRnDhePO3H5Cr8+VqREDwmy1IXAB6GnvXMNiZy7eiN0YCQ==
X-Gm-Gg: AY/fxX6X0+xOVKNfU7mDMFDD9hAKSV3utxjBtbOv5zLIJa+hmcXX56+7yRxeRZPJTKq
	5J/gavxwcX/UXP7AJdxQyAjxUN/QuJwFp0wR+RLu/NIeCpfYBa/K7AvUqYVeamaXaI3nKrzpOvL
	Lq4xmsQGV/WyK+IiUM3Kc779PvxIlghwEx+rfUaJdhYgi2rvrUQk89JG7TMtWUk80xRbodU/P0W
	B1jE1bv72mNgmuNU9ur2WGonsTG5+5hvAcvkAcOwjPY/BzfSOrRZo4HnV/ZpVwkMEeXGRTE3Ach
	eLsDKryAEb/JVu+Aa8BrksvF/NpQHGVSb/bOYNKcdJRr2funVZ/y9NHt55gl51MgKmT1kpNkgJb
	mVj+QYiu38suJaUMlp0/skXRzz56ljruXyvvaXBd0ExtiDDdUYR+Ir1FkOsDb4+tTE/zi+8IguC
	2XFyidB1YNos/8ww==
X-Received: by 2002:a05:600c:870c:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-4801eb092demr205716065e9.17.1768924770201;
        Tue, 20 Jan 2026 07:59:30 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43596090493sm1680900f8f.25.2026.01.20.07.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:59:29 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 20 Jan 2026 15:59:13 +0000
Subject: [PATCH bpf-next v6 04/10] bpf: Simplify bpf_timer_cancel()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-timer_nolock-v6-4-670ffdd787b4@meta.com>
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768924764; l=2468;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=sHjASPbAi3T0MA8tzx5FFZpgqxkihSgoySoW9kJ17iM=;
 b=cI10tviwkfNw02P7fHv6w2/hwccHtdZnx5PuWLHslRyItTGfuy42EMRI7wzOq2hNWTGB+j68K
 9K37hSuxAbmBm3w+aL8iGgNXx4r7ZnzHj2A6t7IGpCvO4fm2NT/9orl
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79648-lists,bpf=lfdr.de];
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
X-Rspamd-Queue-Id: 9638F496CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove lock from the bpf_timer_cancel() helper. The lock does not
protect from concurrent modification of the bpf_async_cb data fields as
those are modified in the callback without locking.

Use guard(rcu)() instead of pair of explicit lock()/unlock().

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
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


