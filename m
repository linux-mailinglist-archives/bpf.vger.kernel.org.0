Return-Path: <bpf+bounces-62290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B1AF770E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26646161284
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB62E92BA;
	Thu,  3 Jul 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbpvtkVz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E42E8E0B;
	Thu,  3 Jul 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552246; cv=none; b=MCIVmLJAdCmRf7CN+RxaR3omHBasT/QDexxh2mXEaJFzV2Q/UR4xw+RR+Efr3P51z/oyqOYNGUeIjQG240PNv8qt60RBQHh0zUiKsCuIYLbLLIgMvx8kw5EGx6XdGf04oy64j/bNdSjWLYVK1uxzUSFWFJ4GA03WVIxCNi3Ui3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552246; c=relaxed/simple;
	bh=MmaffAujB1oT7vN9b0j8wxcdRNfdPtH7IW08WN8C4r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvrEHRbPrwq/bHMjPwlYhqQfks0TdB94CmXIpnFrHHNz/wYma4L5fDqMrYuPf3/2UaHbz8p7RSoFj84F+t3Ps+ctDHmh6Tx/Bl0RUtdp3bK5pIdA8S/WN4jqUBxAhWsKNccFN3j2QAHc1k1twrIcQmyc7r/jJOPqcBWEH9X8B60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbpvtkVz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167afeso54427495ad.3;
        Thu, 03 Jul 2025 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751552244; x=1752157044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPMmGGLaoZ6XvoK3BwJSfWobcPCxRHx9Nw+p7equBlU=;
        b=AbpvtkVzDYggzUiPqY0q8vA6uTt+b1DhSa1esM5sbohwH4o6j/iV0JBp/ACaksf3y0
         /sIEZqTmv4Mlfzmde5DJE1KMCGwFaLFH4VTFhBZWl3sh482tvzuSY5p9yuRqX7HvgFj/
         sbCqwlC6xQav3a50ymiqokhyAjPvl19Q3ZnZszNGxGWydcKpVOZ7kTV0oS1+PrQ2C5m9
         IlMiMi5xdKKcfV/snmWoE5i4y+Ctn3t9gii3wRw3A7znIu6Se233EhUj4m8nnGi97gGa
         Vbz48E8xi45TPCVJzPqMmRxtQun+wdJ+1JoN+e/DTBi+osb78X/AYebz5DGUwwX6ep9q
         kTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552244; x=1752157044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPMmGGLaoZ6XvoK3BwJSfWobcPCxRHx9Nw+p7equBlU=;
        b=dUWxvdz34ryWa0ypG2G5+kop6YPQVWVHBraX0s6uHoZ9GjVqIE2Ejpp1pN4tDLyK/x
         FuVapqgW77Lt+cFPTYQgSW0ySelQCjSaVZ7hv7mqoJGK89r05tQmsPeo2CCQwqVysxOB
         kcLbMhRumoDIE9wGga7MKcWagpGja9Tn4VgfdJRaZQxnED4Wc5pp9JjaiC8YY6MkUC7l
         KGrfXRxPr6+SuW9QdpaECBWkx2i3QYzihKUrGMoRRJblATNsN0M/IFGf4+Et9twNSvnb
         4PYwrrKzpM9DxjxWQEFz+iMpz8uiT70EvjgE9jMnmlYahyrMdMaEk/4zdSaKZfhDnRIu
         E6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCW20xYfL0xqa/Zb2y+n0IQ0GoQEimm/h/oBrf/FXnche7OqZ0Rf96kkaWjPowr83IdIHCpMwm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaDlsJ5A3HztW0Rf51c4jK6hNnGdn90wQByST+FJ6CGoAOvKiQ
	yQgzarPjJRi153TbWK/D15RlWkjfuVbu4q8Z5JOcCMVQmlSbB8sHE+PxQdsmptq57+E=
X-Gm-Gg: ASbGncv7s0hz5fU9tcAczx8VDfo1u8shebYaXNqV/TovLJlp4nmuPS/FPfcprFbFHko
	TM4MfDtgv3FUOCFGwpZcPnR8wXIosnUYgb9QL5eAH9Y+dsDVd2iJBKZbR670BWcGd2CladNegX4
	Dghdn7b82gEtqNdqpjCHcGL5Ezz6Zsa5xHm+KTMbqKQdRRx8obIuBqgFmdUUniS7KchFDiOk21u
	Ru0VlL+JLqa4Ez7ij0LpCoXIgngFnGy32qdFEW35siBZMlzGN0v09EsXDy8H8nw4Rs166suZfLU
	Lm0PCkpv0Usv5t6uDQaAMhqPWVIS4V6IPTf1HPwKm1Nnaf+cz9ubBSYUOogx234SQ6kMY7OJwph
	3yrz8zsWidEp9/rC/+XtJWw==
X-Google-Smtp-Source: AGHT+IFJa5WAt174h91GoF0Nvx5XZf5a4xyMUEWobEpqRRwhZLBlTXHlygDZByJQlD+JiHOgjG6F/A==
X-Received: by 2002:a17:903:2f8b:b0:234:98eb:8eda with SMTP id d9443c01a7336-23c6e58adbamr126311395ad.28.1751552244090;
        Thu, 03 Jul 2025 07:17:24 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.26.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31da818sm13800150a12.61.2025.07.03.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:17:23 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 1/2] net: xsk: update tx queue consumer immediately after transmission
Date: Thu,  3 Jul 2025 22:17:11 +0800
Message-Id: <20250703141712.33190-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250703141712.33190-1-kerneljasonxing@gmail.com>
References: <20250703141712.33190-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

For afxdp, the return value of sendto() syscall doesn't reflect how many
descs handled in the kernel. One of use cases is that when user-space
application tries to know the number of transmitted skbs and then decides
if it continues to send, say, is it stopped due to max tx budget?

The following formular can be used after sending to learn how many
skbs/descs the kernel takes care of:

  tx_queue.consumers_before - tx_queue.consumers_after

Prior to the current patch, in non-zc mode, the consumer of tx queue is
not immediately updated at the end of each sendto syscall when error
occurs, which leads to the consumer value out-of-dated from the perspective
of user space. So this patch requires store operation to pass the cached
value to the shared value to handle the problem.

More than those explicit errors appearing in the while() loop in
__xsk_generic_xmit(), there are a few possible error cases that might
be neglected in the following call trace:
__xsk_generic_xmit()
    xskq_cons_peek_desc()
        xskq_cons_read_desc()
	    xskq_cons_is_valid_desc()
It will also cause the premature exit in the while() loop even if not
all the descs are consumed.

Based on the above analysis, using @sent_frame could cover all the possible
cases where it might lead to out-of-dated global state of consumer after
finishing __xsk_generic_xmit().

The patch also adds a common helper __xsk_tx_release() to keep align
with the zc mode usage in xsk_tx_release().

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
v5
Link: https://lore.kernel.org/all/20250627085745.53173-1-kerneljasonxing@gmail.com/
1. add acked-by tags

v4
Link: https://lore.kernel.org/all/20250625101014.45066-1-kerneljasonxing@gmail.com/
1. use the common helper
2. keep align with the zc mode usage in xsk_tx_release()

v3
Link: https://lore.kernel.org/all/20250623073129.23290-1-kerneljasonxing@gmail.com/
1. use xskq_has_descs helper.
2. add selftest

V2
Link: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
1. filter out those good cases because only those that return error need
updates.
Side note:
1. in non-batched zero copy mode, at the end of every caller of
xsk_tx_peek_desc(), there is always a xsk_tx_release() function that used
to update the local consumer to the global state of consumer. So for the
zero copy mode, no need to change at all.
2. Actually I have no strong preference between v1 (see the above link)
and v2 because smp_store_release() shouldn't cause side effect.
Considering the exactitude of writing code, v2 is a more preferable
one.
---
 net/xdp/xsk.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..bd61b0bc9c24 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -300,6 +300,13 @@ static bool xsk_tx_writeable(struct xdp_sock *xs)
 	return true;
 }
 
+static void __xsk_tx_release(struct xdp_sock *xs)
+{
+	__xskq_cons_release(xs->tx);
+	if (xsk_tx_writeable(xs))
+		xs->sk.sk_write_space(&xs->sk);
+}
+
 static bool xsk_is_bound(struct xdp_sock *xs)
 {
 	if (READ_ONCE(xs->state) == XSK_BOUND) {
@@ -407,11 +414,8 @@ void xsk_tx_release(struct xsk_buff_pool *pool)
 	struct xdp_sock *xs;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
-		__xskq_cons_release(xs->tx);
-		if (xsk_tx_writeable(xs))
-			xs->sk.sk_write_space(&xs->sk);
-	}
+	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list)
+		__xsk_tx_release(xs);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(xsk_tx_release);
@@ -858,8 +862,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 
 out:
 	if (sent_frame)
-		if (xsk_tx_writeable(xs))
-			sk->sk_write_space(sk);
+		__xsk_tx_release(xs);
 
 	mutex_unlock(&xs->mutex);
 	return err;
-- 
2.41.3


