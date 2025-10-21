Return-Path: <bpf+bounces-71567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F98BF6B0B
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D49D19A5534
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC39E336EF3;
	Tue, 21 Oct 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6KzmLHy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F0334C28
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052353; cv=none; b=Y7EYoGTMDcQyAkye19sRD781uHRHRtUrkJY26AqDwsITUjKQLmyzmlnL3FE9+aVAtZmPYoY3o/Uj6UGs3sgf2/ujnnn4Eew9KFP5hKzK4Ya2FyPboboOehShsNE2vnU99EitwGHXblKrVj9Ye8+bVNEBsrRyQur0NjjQaxG9Lmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052353; c=relaxed/simple;
	bh=x416DJPTmQXTm8XE6ZkVhfdHai2ADq7eJGifrFrmn14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PkaUuBz8+a/MizGVr9pBPgUs7/HBp9lCk9z/x2JVcyj2Cu0D9B2Bh7z/91c2qinmqHSBiplXNzLM8R2J8VO0LGgf58ff+B2uISB29+xXuO5Ys2UFPOZYHaWMKuXwqq8ybeucMezHJUs23qJbPffd+F1Y4bMOACNAMyhHAWDTFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6KzmLHy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-273a0aeed57so81764175ad.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052351; x=1761657151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1r4hJXktqrgi/xhdNR7M1d2EmSJ0O1fWXeaj+3yGzA=;
        b=H6KzmLHyE4m3bkZZm2v4jzK8ZP72nwGwlIBL+Ixgxu3BcgC6Gj/ERNoGqvm2Pt6n4p
         o7zHyhUQjN1obU79xjjPzvsiACz0UF4ypLpW29NoiRINrlG1YFHWJZAXRHHTNPRPGLIp
         2+Ikmk22WiPws8CRhYwtW66dbi23O6sol3ZPc8Sen9fAtY6af3Vy78bODSuyj8hmsJ2y
         OqgyU2YtBV78UF+xjebTXZ/98Oc/cFbx5iFrtzGs9rnPYTYvFTF3W6OW4YcCtRLhBIvd
         AsFU+G1jpvJ0i2BbKrzJZnCQjfEpw1RA7UIFQXqsIF9bDyNWcphjehzX4H2aSX7t0TdK
         wnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052351; x=1761657151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1r4hJXktqrgi/xhdNR7M1d2EmSJ0O1fWXeaj+3yGzA=;
        b=FK/2n0Dp8hGJRbmRQih1n7b0FDuYigwtyvsEeiZMsJFGY6olpf7ZvrSLsxRIkW0eql
         HClc7cYkHMHsAKd3rS4qjNRpCmPP2JLO1i8bwrbZBGNH9qYJwep9xHsI3LhV0brXwCH1
         2ylpd180BY5Xyuj9lApFrW8GQtmj1dXvJ2GImGJmLt+pggkVB+nGeiNXxJiR9jsqnSz8
         FEx/ej3caBY3dAmeXPVgrG1rme5L/PBJsSGdUQxr1OPFl0+QKEx5wGiX7p2QKiHkj6Lz
         kMgD6vsLR7HLebp+Jf89f+zpB5mfF9j4sgcUkcF4unhH/ZoT3eozM63XhBy8PZpd4zdG
         iQUg==
X-Gm-Message-State: AOJu0YzBUhoFo48ThdQHDR5CizQ7bZLekU/CCHt08atECjaC8bM2DY2M
	cN0gcguGIA9qGdoTJgnHWWnFyhHvy0u9UsrmRI01vjBd2CYbWx3hqgFP
X-Gm-Gg: ASbGncsR019vPpR71/nYh/DGPlBZnPtzzu2rWsfL8wCJgu64t3xu+YmpxTnFAijCDDW
	EuIChELeolv7hNGIbSHHpr3fvBFTE8daIMDdWCldAPyiGfGj3q0ZuFyX8tLYDn9JFvVxn+rbkLO
	RuHpDlduqw1i9Ul4dprkxL2/Qu7sU0FJMjzjQWBcVEp6kis3wMcyz/cA6OJMVx7fLVLbO636rX7
	9ryDz1uHtZPQ+n9NxlqujxqWSFKm7dCa7akzWur7PdZwodV1GEYT4qzr5VN6zKslNVVRFaU7eu0
	ki46EAUaO+yCclgLx5fihApJQ/DLD+z3utMAC7E/uzRcGc6gguOwVEaUwIU8o1fXLGiQ+pT8qXx
	OdEzhb3sltsHy5tydcVYEJXJx5IKSSS/XdxrZnszIU4IpvfsWtzncp5Sbn9VvVXzB4xi3N6UZxC
	dfj86B43y69uaqWAj8sJ1QiUPyiPnQrZbN3i7amd/nxkHHCKUOPeJNWdqLZg==
X-Google-Smtp-Source: AGHT+IHYFGhUmZxyysQHFil1L0K9sDArAoc0iH+PkiIhYFFUVEN7aFnAht9Gz/xLbgin2jX4tsmrbw==
X-Received: by 2002:a17:902:f541:b0:292:9ac7:2608 with SMTP id d9443c01a7336-2929ac72697mr101761965ad.8.1761052350711;
        Tue, 21 Oct 2025 06:12:30 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:30 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/9] xsk: add xsk_alloc_batch_skb() to build skbs in batch
Date: Tue, 21 Oct 2025 21:12:03 +0800
Message-Id: <20251021131209.41491-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251021131209.41491-1-kerneljasonxing@gmail.com>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Support allocating and building skbs in batch.

This patch uses kmem_cache_alloc_bulk() to complete the batch allocation
which relies on the global common cache 'net_hotdata.skbuff_cache'. Use
a xsk standalone skb cache (namely, xs->skb_cache) to store allocated
skbs instead of resorting to napi_alloc_cache that was designed for
softirq condition.

After allocating memory for each of skbs, in a 'for' loop, the patch
borrows part of __allocate_skb() to initialize skb and then calls
xsk_build_skb() to complete the rest of initialization process, like
copying data and stuff.

Add batch.send_queue and use the skb->list to make skbs into one chain
so that they can be easily sent which is shown in the subsequent patches.

In terms of freeing skbs process, napi_consume_skb() in the tx completion
would put the skb into global cache 'net_hotdata.skbuff_cache' that
implements the deferred freeing skb feature to avoid freeing skb one
by one to improve the performance.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |   3 ++
 net/core/skbuff.c      | 101 +++++++++++++++++++++++++++++++++++++++++
 net/xdp/xsk.c          |   1 +
 3 files changed, 105 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 8944f4782eb6..cb5aa8a314fe 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -47,8 +47,10 @@ struct xsk_map {
 
 struct xsk_batch {
 	u32 generic_xmit_batch;
+	unsigned int skb_count;
 	struct sk_buff **skb_cache;
 	struct xdp_desc *desc_cache;
+	struct sk_buff_head send_queue;
 };
 
 struct xdp_sock {
@@ -130,6 +132,7 @@ struct xsk_tx_metadata_ops {
 struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			      struct sk_buff *allocated_skb,
 			      struct xdp_desc *desc);
+int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err);
 #ifdef CONFIG_XDP_SOCKETS
 
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bc12790017b0..5b6d3b4fa895 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -81,6 +81,8 @@
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
+#include <net/xdp_sock.h>
+#include <net/xsk_buff_pool.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -615,6 +617,105 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	return obj;
 }
 
+int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err)
+{
+	struct xsk_batch *batch = &xs->batch;
+	struct xdp_desc *descs = batch->desc_cache;
+	struct sk_buff **skbs = batch->skb_cache;
+	gfp_t gfp_mask = xs->sk.sk_allocation;
+	struct net_device *dev = xs->dev;
+	int node = NUMA_NO_NODE;
+	struct sk_buff *skb;
+	u32 i = 0, j = 0;
+	bool pfmemalloc;
+	u32 base_len;
+	u8 *data;
+
+	base_len = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
+	if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
+		base_len += dev->needed_tailroom;
+
+	if (batch->skb_count >= nb_pkts)
+		goto build;
+
+	if (xs->skb) {
+		i = 1;
+		batch->skb_count++;
+	}
+
+	batch->skb_count += kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
+						  gfp_mask, nb_pkts - batch->skb_count,
+						  (void **)&skbs[batch->skb_count]);
+	if (batch->skb_count < nb_pkts)
+		nb_pkts = batch->skb_count;
+
+build:
+	for (i = 0, j = 0; j < nb_descs; j++) {
+		if (!xs->skb) {
+			u32 size = base_len + descs[j].len;
+
+			/* In case we don't have enough allocated skbs */
+			if (i >= nb_pkts) {
+				*err = -EAGAIN;
+				break;
+			}
+
+			if (sk_wmem_alloc_get(&xs->sk) > READ_ONCE(xs->sk.sk_sndbuf)) {
+				*err = -EAGAIN;
+				break;
+			}
+
+			skb = skbs[batch->skb_count - 1 - i];
+
+			prefetchw(skb);
+			/* We do our best to align skb_shared_info on a separate cache
+			 * line. It usually works because kmalloc(X > SMP_CACHE_BYTES) gives
+			 * aligned memory blocks, unless SLUB/SLAB debug is enabled.
+			 * Both skb->head and skb_shared_info are cache line aligned.
+			 */
+			data = kmalloc_reserve(&size, gfp_mask, node, &pfmemalloc);
+			if (unlikely(!data)) {
+				*err = -ENOBUFS;
+				break;
+			}
+			/* kmalloc_size_roundup() might give us more room than requested.
+			 * Put skb_shared_info exactly at the end of allocated zone,
+			 * to allow max possible filling before reallocation.
+			 */
+			prefetchw(data + SKB_WITH_OVERHEAD(size));
+
+			memset(skb, 0, offsetof(struct sk_buff, tail));
+			__build_skb_around(skb, data, size);
+			skb->pfmemalloc = pfmemalloc;
+			skb_set_owner_w(skb, &xs->sk);
+		} else if (unlikely(i == 0)) {
+			/* We have a skb in cache that is left last time */
+			kmem_cache_free(net_hotdata.skbuff_cache,
+					skbs[batch->skb_count - 1]);
+			skbs[batch->skb_count - 1] = xs->skb;
+		}
+
+		skb = xsk_build_skb(xs, skb, &descs[j]);
+		if (IS_ERR(skb)) {
+			*err = PTR_ERR(skb);
+			break;
+		}
+
+		if (xp_mb_desc(&descs[j])) {
+			xs->skb = skb;
+			continue;
+		}
+
+		xs->skb = NULL;
+		i++;
+		__skb_queue_tail(&batch->send_queue, skb);
+	}
+
+	batch->skb_count -= i;
+
+	return j;
+}
+
 /* 	Allocate a new skbuff. We do this ourselves so we can fill in a few
  *	'private' fields and also do memory statistics to find all the
  *	[BEEP] leaks.
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f9458347ff7b..cf45c7545124 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1906,6 +1906,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	INIT_LIST_HEAD(&xs->map_list);
 	spin_lock_init(&xs->map_list_lock);
+	__skb_queue_head_init(&xs->batch.send_queue);
 
 	mutex_lock(&net->xdp.lock);
 	sk_add_node_rcu(sk, &net->xdp.list);
-- 
2.41.3


