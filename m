Return-Path: <bpf+bounces-66393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A66B34283
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1A3163371
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6392ED15A;
	Mon, 25 Aug 2025 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEdQbXfZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD92F6175;
	Mon, 25 Aug 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130077; cv=none; b=qJglJT0nf71iwn1tik0iReL53NGda+Op6MRc0tkzkzEf6rLDUNww9pZS+o9FZDB7l0pegRbelhbsIqly3jOpMsROWLJVTJwcgqLKcYKKciFRnhUU9iQz32GcME5RGIGJW4/xf5HqQAdg82PFCbxh3dUn6gLBKxN1aaIGq4YM2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130077; c=relaxed/simple;
	bh=r/CnjyK6JcjnzXT6Er6xjcWR9Eg3aplP19hMPGnsYlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdNFtDp+U5LAtRX8pyF913pjFJJ9STP2BqF+PCNgF2+FMJaF4D1uChwfJF72Q86tmcPqQ1yUU5d4a7rNBSgAQ6jtXXzia0xFmZeJxo4dkhPmGvn3jC4HwBhY7FAuwtTq+MutcsGwMXRaJ1VYiJ+p582BUoJzs0fYEw0k+96oCio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEdQbXfZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77031d4638bso2414903b3a.1;
        Mon, 25 Aug 2025 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756130071; x=1756734871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9sEJl8/V+2EB7tvnEAILgSgzPFoLkgVuF6utZLbXHg=;
        b=JEdQbXfZjXaslPwQdMYidfFwmUCC+uH8mBNhh2eItC++pMuO4dntQ6kJ9qZITAoYoY
         H4kmNzl11BWnDLMhTWGAFYdAgTfbzqEMAaG0AVYAwr2NfeyEltIZcmHfFI2XKfNJGbzb
         TS1d22oP8PyvXFoULu/6ks+Iretw662kDdFYYMDHvU83n/IXZZ/tD3vM2p8t+DPXQ1Wi
         /YfjX3ZSCWNnMSAiCLtWpPXYhS3gx7ZMB+DS17kZz7sYQxowudoBdXy8rsckRPz+3XjZ
         chV/25+SNnYrbDnNBLSeDMJrNtFbRVJLpgYUxI0zIxA7dzMB+t3RuZrzaJ0RKEC/cg8T
         Q5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130071; x=1756734871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9sEJl8/V+2EB7tvnEAILgSgzPFoLkgVuF6utZLbXHg=;
        b=wxVNVPaMcyEcsq184lbBdUJjLCxSd0/UlDjzD88LtSHmYjjkNt3ZEHE6tbnm11OQdm
         KpyxmuH7UkbNQgxr6TsSB+zS/s+vt99rQSd/yvskYyTkJfaV/Fi575c58esUkGE1vIN+
         nlru1mrxjAM6ZqJXmYKD60CuM040e47BHyKlKRh9D8/smI93/JJ3IL1jKvb3zWSbuVOM
         L0wToHH1IVJLlUjsedQDyAuSjollNwYqDZNZyP94sMfG42FqgdFa97F66wgJaDWpXdLu
         cHDs4qFHu25APdVUcwwwe27MdckA7f9ZxPPJdsVKMEtkpuHPbddSKFyMazkyMrioZSc1
         YcBA==
X-Forwarded-Encrypted: i=1; AJvYcCXEaYbHF39iXmA4abwuc3c8JmtYbsZ8ZSNZSoPt1ksPzzBzhGGQ5+Tz4fVd3fwrr14APqrlbQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fJZ97cn0/RAcn3EXi9fQgR9SwjoStTOc/G0CCI9clXmg56bD
	ANhiKRa4w+6NXGrJVq2PXt/UFRPJriB+cEhLcqLuLiXZ9uNKm4cQxAFd
X-Gm-Gg: ASbGncui7Vgmb0agpdPFwCWJ+CLNnl9MHwO1Ene4fSqthvUTKxgLxK23Q7r5Dgfp4PP
	gfdfOvf4dWmmM3eFCGbE23k+kdD+FiiIjRf3PpXYd0qhNWW06SxyvSPoRsq2nJd3mU0xQSiJjY8
	9ZxjXyIUNnBFbjh9LaGtJqNfaL1MopbrsK0MVA8ChHzdtlSqP2tMiW9+ZHhDFw3miiA8nylvQrB
	MpSqjDdtNg3cOnyzSPxXQBfXLwITNnFcYjFhpJ8OzDG+7E9kZWlWbjenUm2rDaDwuNi/XsBUErZ
	fqOR2jT0CyaukXe/W0gydlern/IoFpAwHwOGmZ+OWmS1L4M4B6PfVhWEx9hHCC3G6xW9A9Er/Ay
	FJ8f1H0tfb7z3N16i4reSMZvwLujOLg7xH87UJNMrcRU2eFwnW7OXNFkKGZI=
X-Google-Smtp-Source: AGHT+IHP05yM46Nx5E6GSCjGNdOH41cXv0vvQ9crGzjV8uNAFzPtkP1RNRjkm8PKPwf2T80/TSmI+w==
X-Received: by 2002:a05:6a20:5483:b0:23d:ac50:3342 with SMTP id adf61e73a8af0-24340d7bf8emr17932964637.38.1756130070686;
        Mon, 25 Aug 2025 06:54:30 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm3374073a12.35.2025.08.25.06.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:54:30 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/9] xsk: add xsk_alloc_batch_skb() to build skbs in batch
Date: Mon, 25 Aug 2025 21:53:38 +0800
Message-Id: <20250825135342.53110-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250825135342.53110-1-kerneljasonxing@gmail.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
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
a xsk standalone skb cache (namely, xs->skb_cache) to store skbs instead
of resorting to napi_alloc_cache that was designed for softirq condition.
In case that memory shortage occurs, to avoid frequently allocating
skbs and then freeing part of them, using the allocated skbs from cache
in a reversed order (like from 10, 9, ..., 2, 1, 0) solves the issue.

After allocating memory for each of skbs, in a 'for' loop, the patch
borrows part of __allocate_skb() to initializing skb and then calls
xsk_build_skb() to complete the rest of whole process, like copying data
and stuff.

Considering passing no fclone flag during allocation period, in terms of
freeing process, napi_consume_skb() in the tx completion would put the
skb into different and global cache 'net_hotdata.skbuff_cache' that
implements the deferred freeing skb feature to avoid freeing skb one
by one.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |   3 ++
 net/core/skbuff.c      | 103 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index cbba880c27c3..b533317409df 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -92,6 +92,7 @@ struct xdp_sock {
 	struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
 	struct sk_buff **skb_cache;
 	struct xdp_desc *desc_batch;
+	unsigned int skb_count;
 };
 
 /*
@@ -127,6 +128,8 @@ struct xsk_tx_metadata_ops {
 struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			      struct sk_buff *allocated_skb,
 			      struct xdp_desc *desc);
+int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs,
+			int *consumed, int *start, int *end);
 #ifdef CONFIG_XDP_SOCKETS
 
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..c9071e56d133 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -80,6 +80,8 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/xdp_sock.h>
+#include <net/xsk_buff_pool.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -614,6 +616,107 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	return obj;
 }
 
+int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs,
+			int *consumed, int *start, int *end)
+{
+	struct xdp_desc *descs = xs->desc_batch;
+	struct sk_buff **skbs = xs->skb_cache;
+	gfp_t gfp_mask = xs->sk.sk_allocation;
+	struct net_device *dev = xs->dev;
+	int node = NUMA_NO_NODE;
+	struct sk_buff *skb;
+	u32 i = 0, j = 0;
+	bool pfmemalloc;
+	u32 base_len;
+	int err = 0;
+	u8 *data;
+
+	base_len = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
+	if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
+		base_len += dev->needed_tailroom;
+
+	if (xs->skb_count >= nb_pkts)
+		goto build;
+
+	if (xs->skb) {
+		i = 1;
+		xs->skb_count++;
+	}
+
+	xs->skb_count += kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
+					       gfp_mask, nb_pkts - xs->skb_count,
+					       (void **)&skbs[xs->skb_count]);
+	if (xs->skb_count < nb_pkts)
+		nb_pkts = xs->skb_count;
+
+build:
+	for (i = 0, j = 0; j < nb_descs; j++) {
+		if (!xs->skb) {
+			u32 size = base_len + descs[j].len;
+
+			/* In case we don't have enough allocated skbs */
+			if (i >= nb_pkts) {
+				err = -EAGAIN;
+				break;
+			}
+
+			if (sk_wmem_alloc_get(&xs->sk) > READ_ONCE(xs->sk.sk_sndbuf)) {
+				err = -EAGAIN;
+				break;
+			}
+
+			skb = skbs[xs->skb_count - 1 - i];
+
+			prefetchw(skb);
+			/* We do our best to align skb_shared_info on a separate cache
+			 * line. It usually works because kmalloc(X > SMP_CACHE_BYTES) gives
+			 * aligned memory blocks, unless SLUB/SLAB debug is enabled.
+			 * Both skb->head and skb_shared_info are cache line aligned.
+			 */
+			data = kmalloc_reserve(&size, gfp_mask, node, &pfmemalloc);
+			if (unlikely(!data)) {
+				err = -ENOBUFS;
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
+			kmem_cache_free(net_hotdata.skbuff_cache, skbs[xs->skb_count - 1]);
+			skbs[xs->skb_count - 1] = xs->skb;
+		}
+
+		skb = xsk_build_skb(xs, skb, &descs[j]);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
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
+	}
+
+	*consumed = j;
+	*start = xs->skb_count - 1;
+	*end = xs->skb_count - i;
+	xs->skb_count -= i;
+
+	return err;
+}
+
 /* 	Allocate a new skbuff. We do this ourselves so we can fill in a few
  *	'private' fields and also do memory statistics to find all the
  *	[BEEP] leaks.
-- 
2.41.3


