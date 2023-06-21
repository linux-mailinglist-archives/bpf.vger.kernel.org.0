Return-Path: <bpf+bounces-3050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102BE738C8A
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 19:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4174A1C20E85
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B719E4E;
	Wed, 21 Jun 2023 17:02:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA819E4B
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 17:02:53 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9491510D
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:02:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bfe702f99b8so1416581276.1
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366972; x=1689958972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmMMVFKL+uO4vUmhJXphZq0hHrHUgs2Y3e/LjEOYX1E=;
        b=GTXdXkLOwfBndj/ey9c5yVQ3uqcPYCXQjlas28xoEM4O/ozfC3qYpeukFNNyMm+kDN
         TY1WznK1/pr3ZiK4FyUswGrHOA3zcJGvqs1SjmhxLJ/WZIIycxvqMob29mUGZ1tHCf6h
         Fy9Uqgmj4WZuTp1QJATRm1g5ZcOIHkn49McBamdhAz9amRRT+pyF/fVRFnp63TMNqoNk
         kSPkq+2mNyqnKyF3OTflrGOkQNBhlyjQdt97gBZD8jgyrq19xQhncfRZ4yWHI4b/D1Pq
         pQM1RJ/RUnkzl3Khxo0sVZf6u2et17QrKTAPHQYdB1EyO+x3B953aRyCM5u/pjChGNbj
         JsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366972; x=1689958972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmMMVFKL+uO4vUmhJXphZq0hHrHUgs2Y3e/LjEOYX1E=;
        b=EsTS8JZu9I9QOaA/V2AN+gKgVB1t4MDup33gbc1SjMNyhfSlkcUGHJOlOsFuT75Gke
         wU18JDQYijyTzrxBzwXyS/oylvchcFgcQ7aqz/zssYL7K8laJ+kFcR3/erHaqTK/bGD3
         oAfOPi6GfhUFR4pkQYUpT/Wl/+nwjKHUEFCz+Oz8z6A67Pu43bKs0wI5ILI6ywlyWHsh
         lxkCMzAeYR6q/STypjpmIRHANuY8wwHhKU3VQFwZZicfwuq5hF5C0uw1M4DjRYodtj0e
         mKrdqJEWFEqAqppZ5gdQLuV2u0bcxUwA9d1GAd33+3dBBtxRRwtMJV9rIquW9VNLW8QE
         sxIQ==
X-Gm-Message-State: AC+VfDzj8A5Ia9UqylG9QsHZOmIFo2CgcQTij+ybuNl0zU6vIZoOhN4C
	gUmgeEpfoJ430b09gd6+gRPp0+pAXOFuRjq+NENu1+Yy8OwAjOghLtRt74RNpmFO0bmToH75l5P
	yZ/7ACp9bxUbg2WmcY/sW5j2ykQkYQXrDobpcdRPLHfwJNOunWg==
X-Google-Smtp-Source: ACHHUZ4iiXFc+nsiyhcFiaYXPY5UyL0vT7S0GUIb9ABTvrq36uh9VhEiCvjuAJNTkG5wd3HDfKFZgR0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:addb:0:b0:be3:b9a6:a6b2 with SMTP id
 d27-20020a25addb000000b00be3b9a6a6b2mr2143660ybe.9.1687366971803; Wed, 21 Jun
 2023 10:02:51 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:36 -0700
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-4-sdf@google.com>
Subject: [RFC bpf-next v2 03/11] xsk: Support XDP_TX_METADATA_LEN
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For zerocopy mode, tx_desc->addr can point to the arbitrary offset
and carry some TX metadata in the headroom. For copy mode, there
is no way currently to populate skb metadata.

Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
to treat as metadata. Metadata bytes come prior to tx_desc address
(same as in RX case).

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/xdp_sock.h      |  1 +
 include/net/xsk_buff_pool.h |  1 +
 include/uapi/linux/if_xdp.h |  1 +
 net/xdp/xsk.c               | 31 ++++++++++++++++++++++++++++++-
 net/xdp/xsk_buff_pool.c     |  1 +
 net/xdp/xsk_queue.h         |  7 ++++---
 6 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index e96a1151ec75..30018b3b862d 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -51,6 +51,7 @@ struct xdp_sock {
 	struct list_head flush_node;
 	struct xsk_buff_pool *pool;
 	u16 queue_id;
+	u8 tx_metadata_len;
 	bool zc;
 	enum {
 		XSK_READY = 0,
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index a8d7b8a3688a..751fea51a6af 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -75,6 +75,7 @@ struct xsk_buff_pool {
 	u32 chunk_size;
 	u32 chunk_shift;
 	u32 frame_len;
+	u8 tx_metadata_len; /* inherited from xsk_sock */
 	u8 cached_need_wakeup;
 	bool uses_need_wakeup;
 	bool dma_need_sync;
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index a78a8096f4ce..2374eafff7db 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -63,6 +63,7 @@ struct xdp_mmap_offsets {
 #define XDP_UMEM_COMPLETION_RING	6
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
+#define XDP_TX_METADATA_LEN		9
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index cc1e7f15fa73..c9b2daba7b6d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -485,6 +485,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		int err;
 
 		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
+		hr = max(hr, L1_CACHE_ALIGN((u32)xs->tx_metadata_len));
 		tr = dev->needed_tailroom;
 		len = desc->len;
 
@@ -493,14 +494,21 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
-		skb_put(skb, len);
+		skb_put(skb, len + xs->tx_metadata_len);
 
 		buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
+		buffer -= xs->tx_metadata_len;
+
 		err = skb_store_bits(skb, 0, buffer, len);
 		if (unlikely(err)) {
 			kfree_skb(skb);
 			return ERR_PTR(err);
 		}
+
+		if (xs->tx_metadata_len) {
+			skb_metadata_set(skb, xs->tx_metadata_len);
+			__skb_pull(skb, xs->tx_metadata_len);
+		}
 	}
 
 	skb->dev = dev;
@@ -1137,6 +1145,27 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		mutex_unlock(&xs->mutex);
 		return err;
 	}
+	case XDP_TX_METADATA_LEN:
+	{
+		int val;
+
+		if (optlen < sizeof(val))
+			return -EINVAL;
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
+			return -EFAULT;
+
+		if (val >= 256)
+			return -EINVAL;
+
+		mutex_lock(&xs->mutex);
+		if (xs->state != XSK_READY) {
+			mutex_unlock(&xs->mutex);
+			return -EBUSY;
+		}
+		xs->tx_metadata_len = val;
+		mutex_unlock(&xs->mutex);
+		return err;
+	}
 	default:
 		break;
 	}
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 26f6d304451e..66ff9c345a67 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -85,6 +85,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 		XDP_PACKET_HEADROOM;
 	pool->umem = umem;
 	pool->addrs = umem->addrs;
+	pool->tx_metadata_len = xs->tx_metadata_len;
 	INIT_LIST_HEAD(&pool->free_list);
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
 	spin_lock_init(&pool->xsk_tx_list_lock);
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 6d40a77fccbe..c8d287c18d64 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -133,12 +133,13 @@ static inline bool xskq_cons_read_addr_unchecked(struct xsk_queue *q, u64 *addr)
 static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 					    struct xdp_desc *desc)
 {
-	u64 offset = desc->addr & (pool->chunk_size - 1);
+	u64 addr = desc->addr - pool->tx_metadata_len;
+	u64 offset = addr & (pool->chunk_size - 1);
 
 	if (offset + desc->len > pool->chunk_size)
 		return false;
 
-	if (desc->addr >= pool->addrs_cnt)
+	if (addr >= pool->addrs_cnt)
 		return false;
 
 	if (desc->options)
@@ -149,7 +150,7 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 					      struct xdp_desc *desc)
 {
-	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr);
+	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr) - pool->tx_metadata_len;
 
 	if (desc->len > pool->chunk_size)
 		return false;
-- 
2.41.0.162.gfafddb0af9-goog


