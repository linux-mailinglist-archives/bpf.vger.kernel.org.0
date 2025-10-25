Return-Path: <bpf+bounces-72182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4CC08C75
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 08:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0103BF454
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 06:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DAE2DA74D;
	Sat, 25 Oct 2025 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRWMEWZB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DAC2D73B1
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375212; cv=none; b=kOSRFTT5d+5KoMXBBMhe6btoSOs1LKbTY2PvYuEznNkxQpEo2hnr85lbhVnlS7G0I0fMe5ktWQCWmk3tj/4WhnPdSefPyVOm3pjxU9Cf49R5rWet/Bz+I9yvFnOltKLALM/iMSXcagdBSNLPVOQ0eYUK1vjupeuqZSQgshnx55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375212; c=relaxed/simple;
	bh=yHJYa/oZkkM7yeGsNEwd046BjncIvs81WsKweJrwmD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSUgaofUBK2UKmyV8zzmxH3UnlKtstWRuj7LEmW+y0Uy/7kiknx2dth1u87s7/6UkBotdzZrVo89GL0NnRhCnu3LnKeLnxCwIeTaTIBMDjp5nPjrpLIIM7uU6ln8MGsdkSJ/7CsqqKO+Py8niNgv6ag7AETSmpUGNwsXPL4xkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRWMEWZB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a226a0798cso2406676b3a.2
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 23:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761375211; x=1761980011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Wd7ZIr1XdhvuS6zESZUWRW9MBlaYzkG5tNVq4WgCIo=;
        b=MRWMEWZBs3vRSjsCFWvYnXZWPylnfheX60eI9NkYxL8HRfieKzKevfZlFU61Hr0Fxp
         mb7Zwek6DhhvZr780IT3ELE4kHW6ClYFZPH63ML90DASWgvOPVysLprBZcTPwctUoNsJ
         q5KWnFd63hsmk2do2i4yEtmBZgb5q3iZ7JtdkTT4F9DRbVsU/Rb7C61Y3jc4/MHnt1wr
         dSporMtPnWx00UWArLWL0A02K0f0Z91a0IThMPka8urxxDmWlfbT5iJFW+oZ4njRpgcW
         TIdQyYJJoDIwzdWjKdVw2occqXpOl3li7k+Dk6srq4jap2ojxlghquWLpwrq8NRI6JQa
         4H3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761375211; x=1761980011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Wd7ZIr1XdhvuS6zESZUWRW9MBlaYzkG5tNVq4WgCIo=;
        b=jEUH0TqXZ3BVtOyJgfa6d11XFrbdQal0iwK6aep8PI++uFxyh8tvN5OmwXTElzddbP
         R8FNixI89Wg3iPrdviQoYE1Q52jJOJgbfPDomGgQ8YnRJvM71kII+6Kqf0hg12cfbuSC
         O3LJrlB/nGS0w8os/n1geaNoJ0tcfOVujfuUx6kwXe+wTgQPNwi9FmU3WV+0bz6/0Yx/
         zxuOmG4giKJ1BUi2eGrjxhqlYRPfSWawBzrtDomn3SMThilRfMhRU7YnGylVDBjY4mLj
         xFzQaJmuicPCf2Yp5K1PvDpk8FHVa2LwgHjJF54toIcuNgSul/+PO231TFEfbtXuUwDc
         2DZA==
X-Gm-Message-State: AOJu0YyTnbi5OlqR7uORiLXx9xsa2BfyyGGKAK4ELPgl3lUQR5aekeEg
	sSGY/sRPxaHGLzrPuRCM+NGDvY0z3ekg62AF6isP8T4l2aoL/QRpkd/j
X-Gm-Gg: ASbGnctaURDwq+WfDE3YOgfB9mOp6AbbnF7secHmgVSXmoaJGP0E7Zvqzf3p6cNPHRH
	S+fVT8+q4HLNXZ4jdYqaLMonS2DPaOGqU8I24IERS/g/FdGX8zBk2/o8iFTtMTKQYkKS8gTEWS2
	ycp4aN1iAuUNq3LQghH1B/MzOy5VJr/MxfS9L5yu6n6Hl3Tyd4SbRUMWJVUa3cfEAOxfRJX9f4R
	UD2WWneyTxHePp02JfKT5nVVYPtUmzTnnjM11gZugYO6571RR9h8rucB55iKQdFdjamtTtRc4rm
	yJ8gWnftl+iXXyTK7SQvlJn7/BBlbc5Jwmz0Si6Bl9J7xQIjidZt65osIRSnwAR+NniS1zAS/2F
	EN0VeoQGT/Ar8rDc2r4hUOtv6bfy01zVilrGfKTL+DntV5Z0rGTSUBDXCN49srjz+ykhWwpkUkj
	neUjMGllZLlq7eK2YJ8d5lsaWFt1gGMqyuj4Le2WL8qA==
X-Google-Smtp-Source: AGHT+IH1g6mLP57bXNwJV85r0pbZpYpDIDcFse8NWx56uJw5DKkNE1S+ZziJQrVxgpgzAI9XDGxKcg==
X-Received: by 2002:a05:6a20:258a:b0:340:cc06:94ee with SMTP id adf61e73a8af0-340cc069737mr3007713637.60.1761375210660;
        Fri, 24 Oct 2025 23:53:30 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140699basm1262820b3a.50.2025.10.24.23.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:53:30 -0700 (PDT)
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
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/2] xsk: use a smaller new lock for shared pool case
Date: Sat, 25 Oct 2025 14:53:10 +0800
Message-Id: <20251025065310.5676-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251025065310.5676-1-kerneljasonxing@gmail.com>
References: <20251025065310.5676-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

- Split cq_lock into two smaller locks: cq_prod_lock and
  cq_cached_prod_lock
- Avoid disabling/enabling interrupts in the hot xmit path

In either xsk_cq_cancel_locked() or xsk_cq_reserve_locked() function,
the race condition is only between multiple xsks sharing the same
pool. They are all in the process context rather than interrupt context,
so now the small lock named cq_cached_prod_lock can be used without
handling interrupts.

While cq_cached_prod_lock ensures the exclusive modification of
@cached_prod, cq_prod_lock in xsk_cq_submit_addr_locked() only cares
about @producer and corresponding @desc. Both of them don't necessarily
be consistent with @cached_prod protected by cq_cached_prod_lock.
That's the reason why the previous big lock can be split into two
smaller ones.

Frequently disabling and enabling interrupt are very time consuming
in some cases, especially in a per-descriptor granularity, which now
can be avoided after this optimization, even when the pool is shared by
multiple xsks.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xsk_buff_pool.h | 13 +++++++++----
 net/xdp/xsk.c               | 14 ++++++--------
 net/xdp/xsk_buff_pool.c     |  3 ++-
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index cac56e6b0869..92a2358c6ce3 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -85,11 +85,16 @@ struct xsk_buff_pool {
 	bool unaligned;
 	bool tx_sw_csum;
 	void *addrs;
-	/* Mutual exclusion of the completion ring in the SKB mode. Two cases to protect:
-	 * NAPI TX thread and sendmsg error paths in the SKB destructor callback and when
-	 * sockets share a single cq when the same netdev and queue id is shared.
+	/* Mutual exclusion of the completion ring in the SKB mode.
+	 * Protect: NAPI TX thread and sendmsg error paths in the SKB
+	 * destructor callback.
 	 */
-	spinlock_t cq_lock;
+	spinlock_t cq_prod_lock;
+	/* Mutual exclusion of the completion ring in the SKB mode.
+	 * Protect: when sockets share a single cq when the same netdev
+	 * and queue id is shared.
+	 */
+	spinlock_t cq_cached_prod_lock;
 	struct xdp_buff_xsk *free_heads[];
 };
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 76f797fcc49c..d254817b8a53 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -549,14 +549,13 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
 	bool lock = !list_is_singular(&pool->xsk_tx_list);
-	unsigned long flags;
 	int ret;
 
 	if (lock)
-		spin_lock_irqsave(&pool->cq_lock, flags);
+		spin_lock(&pool->cq_cached_prod_lock);
 	ret = xskq_prod_reserve(pool->cq);
 	if (lock)
-		spin_unlock_irqrestore(&pool->cq_lock, flags);
+		spin_unlock(&pool->cq_cached_prod_lock);
 
 	return ret;
 }
@@ -569,7 +568,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 	unsigned long flags;
 	u32 idx;
 
-	spin_lock_irqsave(&pool->cq_lock, flags);
+	spin_lock_irqsave(&pool->cq_prod_lock, flags);
 	idx = xskq_get_prod(pool->cq);
 
 	xskq_prod_write_addr(pool->cq, idx,
@@ -586,19 +585,18 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 		}
 	}
 	xskq_prod_submit_n(pool->cq, descs_processed);
-	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
 }
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	bool lock = !list_is_singular(&pool->xsk_tx_list);
-	unsigned long flags;
 
 	if (lock)
-		spin_lock_irqsave(&pool->cq_lock, flags);
+		spin_lock(&pool->cq_cached_prod_lock);
 	xskq_prod_cancel_n(pool->cq, n);
 	if (lock)
-		spin_unlock_irqrestore(&pool->cq_lock, flags);
+		spin_unlock(&pool->cq_cached_prod_lock);
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index aa9788f20d0d..add44bd09cae 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -94,7 +94,8 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	INIT_LIST_HEAD(&pool->xskb_list);
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
 	spin_lock_init(&pool->xsk_tx_list_lock);
-	spin_lock_init(&pool->cq_lock);
+	spin_lock_init(&pool->cq_prod_lock);
+	spin_lock_init(&pool->cq_cached_prod_lock);
 	refcount_set(&pool->users, 1);
 
 	pool->fq = xs->fq_tmp;
-- 
2.41.3


