Return-Path: <bpf+bounces-15966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 261867FA986
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1D4B20E52
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1143DBB3;
	Mon, 27 Nov 2023 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuvHXQ8y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DC2D5D
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:23 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5bddc607b45so5895015a12.0
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111803; x=1701716603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=psXeWSFV9jNwPqAMO4arGwTup4UEtWfZR60Db4FTCc0=;
        b=CuvHXQ8ymbSGyZryLG59MFyO7EvhS5h83X1IgkZ6ZPlCTnBBm+MJGQKCGDI2/dd1id
         nArconxY2fVSmNPjnp2tQTBCvoHYTU8gltzv9YoNoROVlvG2hUfNBtM4EJ4cPZlrP6Qr
         46KWaV62kwp6uoDO2Ni88bbGvD0Rv6u4PxBX30BYKkyjNwhzdn2LXtrB3NfxkbEmPBgy
         RgjXPGkYRge8DUt91YcpmWGsIufupyutIBEEMgN2UUpbC1d6lC6Z/AfiiB6szcQAVF9q
         TbxLA8O5En2Szxq1Q5hOIWvwXRCOEEg2UQ2Z9H1lENLWkFBMDln1H+3/4nRvzc6eyVDV
         nZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111803; x=1701716603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psXeWSFV9jNwPqAMO4arGwTup4UEtWfZR60Db4FTCc0=;
        b=WjZ0YFHrbXAvJSuWwFQqD0sc9GaHMj/aTL4c2fopu9dOo9eoHlKxL2tk3tDQ+W8mXk
         OMC1RPYghteaK9tABFeJdBJvVAs+dpwqvc2Oj+IZlPOwe00UudrYReY5A5e2fwMVMEZ/
         QTtjfIaFacqUt3aOyaipDY8//XzaR2wYbFrziINUYfMvoVeDYomh2OdO9YyTokCBLyQq
         OqnDxiTfFEse43mcDYXZPvnPhioq54hBH9NN3inEkTpDzIGhLRhiFmAxHCd2d0WQ4Dl9
         ZJs//8BiSXayb9S93ckir28cQFpRcW8WI6pgYpySbmdn8Bp/JeNZW+o/XLjAkRV8VYSK
         3wxw==
X-Gm-Message-State: AOJu0Yyh9yI+Cexrew8iwAOkMCNUVv+qfezH8SgZngLMxImg+zt6bnM4
	DCHQcT0e/YxTHD6C2ssuoO6B/J+rCvguPIrB0jPFlDI2XI4/ygRDdDjuxTNbYt7pbu9mZ4BhNKN
	9vsWXRddAe/g6T97DKSJjn3H4NohYsiVsvp58kZax0+k52fTaJw==
X-Google-Smtp-Source: AGHT+IGmlmDeKoqQIpCdZIz5m+tgvYQiWdhiP3RR3TZ9IiHLEWD4GuSk6K4vRAEBjui7lE/Ujmo5mQ8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:d209:0:b0:5be:1194:9c0b with SMTP id
 a9-20020a63d209000000b005be11949c0bmr2068487pgg.3.1701111802937; Mon, 27 Nov
 2023 11:03:22 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:07 -0800
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-2-sdf@google.com>
Subject: [PATCH bpf-next v6 01/13] xsk: Support tx_metadata_len
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

For zerocopy mode, tx_desc->addr can point to an arbitrary offset
and carry some TX metadata in the headroom. For copy mode, there
is no way currently to populate skb metadata.

Introduce new tx_metadata_len umem config option that indicates how many
bytes to treat as metadata. Metadata bytes come prior to tx_desc address
(same as in RX case).

The size of the metadata has mostly the same constraints as XDP:
- less than 256 bytes
- 8-byte aligned (compared to 4-byte alignment on xdp, due to 8-byte
  timestamp in the completion)
- non-zero

This data is not interpreted in any way right now.

Reviewed-by: Song Yoong Siang <yoong.siang.song@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/xdp_sock.h            |  1 +
 include/net/xsk_buff_pool.h       |  1 +
 include/uapi/linux/if_xdp.h       |  1 +
 net/xdp/xdp_umem.c                |  4 ++++
 net/xdp/xsk.c                     | 12 +++++++++++-
 net/xdp/xsk_buff_pool.c           |  1 +
 net/xdp/xsk_queue.h               | 17 ++++++++++-------
 tools/include/uapi/linux/if_xdp.h |  1 +
 8 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index f83128007fb0..bcf765124f72 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -30,6 +30,7 @@ struct xdp_umem {
 	struct user_struct *user;
 	refcount_t users;
 	u8 flags;
+	u8 tx_metadata_len;
 	bool zc;
 	struct page **pgs;
 	int id;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index b0bdff26fc88..1985ffaf9b0c 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -77,6 +77,7 @@ struct xsk_buff_pool {
 	u32 chunk_size;
 	u32 chunk_shift;
 	u32 frame_len;
+	u8 tx_metadata_len; /* inherited from umem */
 	u8 cached_need_wakeup;
 	bool uses_need_wakeup;
 	bool dma_need_sync;
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 8d48863472b9..2ecf79282c26 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -76,6 +76,7 @@ struct xdp_umem_reg {
 	__u32 chunk_size;
 	__u32 headroom;
 	__u32 flags;
+	__u32 tx_metadata_len;
 };
 
 struct xdp_statistics {
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 06cead2b8e34..946a687fb8e8 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -199,6 +199,9 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (headroom >= chunk_size - XDP_PACKET_HEADROOM)
 		return -EINVAL;
 
+	if (mr->tx_metadata_len >= 256 || mr->tx_metadata_len % 8)
+		return -EINVAL;
+
 	umem->size = size;
 	umem->headroom = headroom;
 	umem->chunk_size = chunk_size;
@@ -207,6 +210,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	umem->pgs = NULL;
 	umem->user = NULL;
 	umem->flags = mr->flags;
+	umem->tx_metadata_len = mr->tx_metadata_len;
 
 	INIT_LIST_HEAD(&umem->xsk_dma_list);
 	refcount_set(&umem->users, 1);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ae9f8cb611f6..c904356e2800 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1283,6 +1283,14 @@ struct xdp_umem_reg_v1 {
 	__u32 headroom;
 };
 
+struct xdp_umem_reg_v2 {
+	__u64 addr; /* Start of packet data area */
+	__u64 len; /* Length of packet data area */
+	__u32 chunk_size;
+	__u32 headroom;
+	__u32 flags;
+};
+
 static int xsk_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
@@ -1326,8 +1334,10 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 
 		if (optlen < sizeof(struct xdp_umem_reg_v1))
 			return -EINVAL;
-		else if (optlen < sizeof(mr))
+		else if (optlen < sizeof(struct xdp_umem_reg_v2))
 			mr_size = sizeof(struct xdp_umem_reg_v1);
+		else if (optlen < sizeof(mr))
+			mr_size = sizeof(struct xdp_umem_reg_v2);
 
 		if (copy_from_sockptr(&mr, optval, mr_size))
 			return -EFAULT;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 49cb9f9a09be..386eddcdf837 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -85,6 +85,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 		XDP_PACKET_HEADROOM;
 	pool->umem = umem;
 	pool->addrs = umem->addrs;
+	pool->tx_metadata_len = umem->tx_metadata_len;
 	INIT_LIST_HEAD(&pool->free_list);
 	INIT_LIST_HEAD(&pool->xskb_list);
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 13354a1e4280..c74a1372bcb9 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -143,15 +143,17 @@ static inline bool xp_unused_options_set(u32 options)
 static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 					    struct xdp_desc *desc)
 {
-	u64 offset = desc->addr & (pool->chunk_size - 1);
+	u64 addr = desc->addr - pool->tx_metadata_len;
+	u64 len = desc->len + pool->tx_metadata_len;
+	u64 offset = addr & (pool->chunk_size - 1);
 
 	if (!desc->len)
 		return false;
 
-	if (offset + desc->len > pool->chunk_size)
+	if (offset + len > pool->chunk_size)
 		return false;
 
-	if (desc->addr >= pool->addrs_cnt)
+	if (addr >= pool->addrs_cnt)
 		return false;
 
 	if (xp_unused_options_set(desc->options))
@@ -162,16 +164,17 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 					      struct xdp_desc *desc)
 {
-	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr);
+	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr) - pool->tx_metadata_len;
+	u64 len = desc->len + pool->tx_metadata_len;
 
 	if (!desc->len)
 		return false;
 
-	if (desc->len > pool->chunk_size)
+	if (len > pool->chunk_size)
 		return false;
 
-	if (addr >= pool->addrs_cnt || addr + desc->len > pool->addrs_cnt ||
-	    xp_desc_crosses_non_contig_pg(pool, addr, desc->len))
+	if (addr >= pool->addrs_cnt || addr + len > pool->addrs_cnt ||
+	    xp_desc_crosses_non_contig_pg(pool, addr, len))
 		return false;
 
 	if (xp_unused_options_set(desc->options))
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 73a47da885dc..34411a2e5b6c 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -76,6 +76,7 @@ struct xdp_umem_reg {
 	__u32 chunk_size;
 	__u32 headroom;
 	__u32 flags;
+	__u32 tx_metadata_len;
 };
 
 struct xdp_statistics {
-- 
2.43.0.rc1.413.gea7ed67945-goog


