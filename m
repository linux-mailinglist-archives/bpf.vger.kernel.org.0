Return-Path: <bpf+bounces-73147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA16C242CF
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 10:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2711A6788C
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0232E13F;
	Fri, 31 Oct 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUN0V69P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979D304963
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903166; cv=none; b=TcqwPpJWv9QRgXTbv8zxZX1vuynJzNdyEOa0UEKdBzr/+qqVf9fB1V4ALra/GBy0V4Lz56cBBAyErM6gaXGLvDIiQ0IZ4YDnqeoy0wKAnNc0hJwynb0rs3XHhig4W8gLGS6dg+NJaClz5SnGc1/z/f/iLtM8eKzcYV7sJs4gXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903166; c=relaxed/simple;
	bh=BdTgIvhhJ1gdkz6/xzN41yqXEpOmx1lIpUPGLntv/rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESxDY/s3URWfHTbiVxzsPK2lR6HWDiTciU+8x8LaEcx9tciPUQlz+VtbHvtlrqd6kr3YdEzTNkODeA/M145x+E3jtTxIXsk7kjDXmI/1aBkwWEqp9RQF+A1nIMXupsizfQj52SZtrB66FpnbWoawjV2Ycq/yLVTQuELEJEGESSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUN0V69P; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a27053843bso3100634b3a.1
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761903164; x=1762507964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pugc7wyIx+RDl0/kBR0IGU74QHBwinHXf7G2PpgFYYA=;
        b=lUN0V69PA/TcmsQ65tiBkUr5gWs/4OoLT86m1LOdHg+3Sg5OvMfsy6afKPKlHKUplN
         DibWDOmo043CMau+iKVCAnXC+hsqz0KFYZMSKiPzWli8o50wxUKGIIwbVqKlpRcu2orz
         4LRSdz9R8qLbnN3BGTOV4KGd3ZEskQ0MlglIwD0a+0d0ngPsXtctPi+Lc8FvAB7t/Y88
         4OPijCicREk6Yh6eYfPurjCoA9wVMFBfONTCjN6XYXRtj1014o67qTGIOURpa8ogLyXa
         73IeYuUHnSF7AcSAhkK1yKO2GP0gqyVGUwBoxxiLB2D/lqvA38drVY5jrLnu9nayDabj
         0b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903164; x=1762507964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pugc7wyIx+RDl0/kBR0IGU74QHBwinHXf7G2PpgFYYA=;
        b=suRz9mI9D2AJgdyi92dEpIDlo5eNeOmaR1/g7Q80uWx+f2orq3gKJuyNut0pJaAiaM
         XcD07UNZT5MMo8Gs/JvklmQGyKJ0uvi4HkTTucwMaSsmx3sFnp/AdEc6wptqj0eo/LS7
         PxtcGVrPxiuqfitAUaLvM4iPlifwtXUXmCvdI2yAfyVFJwFZ2OGrXhwn2do+Y0l7XzdO
         GODKDz3F3nf6bBrxt59khvBAAbgqEqSk1WVr7IDqhla+zquyfIRNuoV67iCBxIj9jgW1
         1tVMVUoPBdvy1koSZaIMkBaOhNdwZYuv0hBNBhZRlRV/pRMEmtg92ig4JswTkiXwvwYp
         VTGg==
X-Gm-Message-State: AOJu0YyAmGBWqWhSFjQ4OG4l3z5kN/h40wETu3EsnNyeokQlmmdBM4eI
	ZJGtZzDZ6mM4msNKc/qLgoqVbHQe9fAcsacPDDcC0YI0N4lx9mfLwY3t
X-Gm-Gg: ASbGncuZZC+lZua5PiCCMY7sMacGqzlHKWbW4s1krSNyj+VY/hUBDcbFWnhT1f5kQNi
	FpPv8wxSpu16t9rTCZANtv2GLQGkFAtBLr5LVglqs8e/pAZaGVv6Osc54YMP6MeeBTep6Tv4GAA
	HQCW80CLHPx1YwMB9z8LsnDlhZlkHNgEAlQuhMz7fud390uGswWKWiLInWDb+19lY0Pu6l13NFZ
	+wC6EduWheQf+fMEYyJdrrZ14bdVJxev22n7Hen8nz1PKToE5cUNHxVdYxRC2FE0hYsUugLDHPN
	9hB10Is/hMnFNvBCTBRbfoYfAKSTsgMFmmRxT4X4hzxbSTp+gmSCyllb5xOtwUcb2Itu2IpcgZb
	+UQhLoe5m0E9YF7BnwHjoqq3hDznIQAPgXFtW5s5Gv1I9mwG9lOOKYWIeUPi8yKlbqDXsT8e0CN
	scOK50MG7L/MJWfWyON/HNaqBQwKJgQRMU62QVAFPjFJJUN+Axgkemg1RShw==
X-Google-Smtp-Source: AGHT+IFX7NCkIpwZNqyb3gbIIZwlZ6SRN1v+hQVu3ncWqAzhjoTLpg3TnGWD2EpfGETTzUaerToPPw==
X-Received: by 2002:a05:6a00:a24:b0:77f:50df:df36 with SMTP id d2e1a72fcca58-7a778af1ea0mr3544075b3a.18.1761903163999;
        Fri, 31 Oct 2025 02:32:43 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm1544422b3a.60.2025.10.31.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:32:43 -0700 (PDT)
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
	willemdebruijn.kernel@gmail.com,
	fmancera@suse.de,
	csmate@nop.hu
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next 1/2] Revert "xsk: Fix immature cq descriptor production"
Date: Fri, 31 Oct 2025 17:32:29 +0800
Message-Id: <20251031093230.82386-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251031093230.82386-1-kerneljasonxing@gmail.com>
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch was made manually to revert previous fix, in order to
easily implement a new logic based on the previous code base.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c       | 118 ++++++++------------------------------------
 net/xdp/xsk_queue.h |  12 -----
 2 files changed, 20 insertions(+), 110 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..05010c1bbfbd 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -36,20 +36,6 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET 32
 
-struct xsk_addr_node {
-	u64 addr;
-	struct list_head addr_node;
-};
-
-struct xsk_addr_head {
-	u32 num_descs;
-	struct list_head addrs_list;
-};
-
-static struct kmem_cache *xsk_tx_generic_cache;
-
-#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
-
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -546,43 +532,24 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
+static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
 {
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	ret = xskq_prod_reserve(pool->cq);
+	ret = xskq_prod_reserve_addr(pool->cq, addr);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 
 	return ret;
 }
 
-static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
-				      struct sk_buff *skb)
+static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
 {
-	struct xsk_addr_node *pos, *tmp;
-	u32 descs_processed = 0;
 	unsigned long flags;
-	u32 idx;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	idx = xskq_get_prod(pool->cq);
-
-	xskq_prod_write_addr(pool->cq, idx,
-			     (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
-	descs_processed++;
-
-	if (unlikely(XSKCB(skb)->num_descs > 1)) {
-		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
-			xskq_prod_write_addr(pool->cq, idx + descs_processed,
-					     pos->addr);
-			descs_processed++;
-			list_del(&pos->addr_node);
-			kmem_cache_free(xsk_tx_generic_cache, pos);
-		}
-	}
-	xskq_prod_submit_n(pool->cq, descs_processed);
+	xskq_prod_submit_n(pool->cq, n);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
@@ -595,14 +562,9 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
-static void xsk_inc_num_desc(struct sk_buff *skb)
-{
-	XSKCB(skb)->num_descs++;
-}
-
 static u32 xsk_get_num_desc(struct sk_buff *skb)
 {
-	return XSKCB(skb)->num_descs;
+	return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
 }
 
 static void xsk_destruct_skb(struct sk_buff *skb)
@@ -614,38 +576,31 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
 	}
 
-	xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
+	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
 	sock_wfree(skb);
 }
 
-static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
-			      u64 addr)
+static void xsk_set_destructor_arg(struct sk_buff *skb)
+{
+	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
+
+	skb_shinfo(skb)->destructor_arg = (void *)num;
+}
+
+static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs)
 {
-	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
-	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
 	skb->dev = xs->dev;
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
-	XSKCB(skb)->num_descs = 0;
 	skb->destructor = xsk_destruct_skb;
-	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
 {
 	struct xdp_sock *xs = xdp_sk(skb->sk);
-	u32 num_descs = xsk_get_num_desc(skb);
-	struct xsk_addr_node *pos, *tmp;
-
-	if (unlikely(num_descs > 1)) {
-		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
-			list_del(&pos->addr_node);
-			kmem_cache_free(xsk_tx_generic_cache, pos);
-		}
-	}
 
 	skb->destructor = sock_wfree;
-	xsk_cq_cancel_locked(xs->pool, num_descs);
+	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
 	/* Free skb without triggering the perf drop trace */
 	consume_skb(skb);
 	xs->skb = NULL;
@@ -701,7 +656,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 {
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
-	struct xsk_addr_node *xsk_addr;
 	struct sk_buff *skb = xs->skb;
 	struct page *page;
 	void *buffer;
@@ -720,23 +674,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 		skb_reserve(skb, hr);
 
-		xsk_skb_init_misc(skb, xs, desc->addr);
+		xsk_skb_init_misc(skb, xs);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
 				return ERR_PTR(err);
 		}
-	} else {
-		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
-		if (!xsk_addr)
-			return ERR_PTR(-ENOMEM);
-
-		/* in case of -EOVERFLOW that could happen below,
-		 * xsk_consume_skb() will release this node as whole skb
-		 * would be dropped, which implies freeing all list elements
-		 */
-		xsk_addr->addr = desc->addr;
-		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
 	}
 
 	len = desc->len;
@@ -804,7 +747,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
+			xsk_skb_init_misc(skb, xs);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -813,7 +756,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			}
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
-			struct xsk_addr_node *xsk_addr;
 			struct page *page;
 			u8 *vaddr;
 
@@ -828,26 +770,16 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 			}
 
-			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
-			if (!xsk_addr) {
-				__free_page(page);
-				err = -ENOMEM;
-				goto free_err;
-			}
-
 			vaddr = kmap_local_page(page);
 			memcpy(vaddr, buffer, len);
 			kunmap_local(vaddr);
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
-
-			xsk_addr->addr = desc->addr;
-			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
 		}
 	}
 
-	xsk_inc_num_desc(skb);
+	xsk_set_destructor_arg(skb);
 
 	return skb;
 
@@ -857,7 +789,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
-		xsk_inc_num_desc(xs->skb);
+		xsk_set_destructor_arg(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
 	} else {
@@ -900,7 +832,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_locked(xs->pool);
+		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
@@ -1903,18 +1835,8 @@ static int __init xsk_init(void)
 	if (err)
 		goto out_pernet;
 
-	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
-						 sizeof(struct xsk_addr_node),
-						 0, SLAB_HWCACHE_ALIGN, NULL);
-	if (!xsk_tx_generic_cache) {
-		err = -ENOMEM;
-		goto out_unreg_notif;
-	}
-
 	return 0;
 
-out_unreg_notif:
-	unregister_netdevice_notifier(&xsk_netdev_notifier);
 out_pernet:
 	unregister_pernet_subsys(&xsk_net_ops);
 out_sk:
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1eb8d9f8b104..23c02066caaf 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -369,11 +369,6 @@ static inline u32 xskq_cons_present_entries(struct xsk_queue *q)
 
 /* Functions for producers */
 
-static inline u32 xskq_get_prod(struct xsk_queue *q)
-{
-	return READ_ONCE(q->ring->producer);
-}
-
 static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max)
 {
 	u32 free_entries = q->nentries - (q->cached_prod - q->cached_cons);
@@ -420,13 +415,6 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
 	return 0;
 }
 
-static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx, u64 addr)
-{
-	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
-
-	ring->desc[idx & q->ring_mask] = addr;
-}
-
 static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
 					      u32 nb_entries)
 {
-- 
2.41.3


