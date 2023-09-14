Return-Path: <bpf+bounces-10078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B59557A0F79
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DF11C20BA2
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E726E32;
	Thu, 14 Sep 2023 21:05:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23226E0F
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:04:59 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8722708
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:04:58 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5703b4e92b7so1110253a12.2
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694725498; x=1695330298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FxanLnun3CciTJ7wLoHWhdiCGX4GL5EEolw+Oe4EYgA=;
        b=3+E261VSNHagC5bcBQhGWfrZli5JCXgQlF8FKK4H9gbEKuKrPuHNU984jPssjCMYzM
         rJbbSI/kwU3sujLpcokehgbk9kNddG2w3s/uS4Y4uZcvZ2DGACraon62sjObobuR6YGh
         EH2coFAlZDI/iEHRr5+wp/vHyaI+vJhaQ9OarOJoLpCFyzyTsYGwMoEDeaWXYX6HlJPU
         ACFgoA1/g675Ekf/uClH+dJS1UBpi9Rqkf32XKo1kAyx61xOM2R1nP2B4Ewl/WeGvelM
         4m56+iNNei/eAkMlmn0Ai2aWS1B13FMDWskVwjjT3CHLxh204u65SDa0UyTBvOPOiHKP
         ejDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725498; x=1695330298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxanLnun3CciTJ7wLoHWhdiCGX4GL5EEolw+Oe4EYgA=;
        b=DDUHueo5cbW8xpHfFObgVZObc6DmYSbiJp7xtCdSfHPGcvogWr/umQVlyYJru0dOWl
         vXa0X6wmiLOuW7X6h/XxyXr7HII4NDMSrNdz6l3RJv3OfZtm5ipfZycyIEV794bKfVJK
         uJQEdCkSn4i6JwQTmlNFzlr5CG7CIe+BEhfkHC1RPAA6G6k89r+YOT9Is7Ws6P0I6M6r
         2qzgjRtUrAoG7tPa+5LlRkyVxR848nsI3FSPanMABiYVtPVXIcrlGmhETZs/FygSlfBC
         3kjERFgiqLwxMb0EOX8VWmGGYUpwA7qOt8DYXTvSpl5by/PrtnbaAfq8h68+QdElxCty
         v5AA==
X-Gm-Message-State: AOJu0YzFtRZpRuMriukYyzL6/FwGoB6DtV8AK7w66jOuPFHAsWZVwzbk
	4YWObdwr02BZx9VNXrk+6XtehW4RPrEeF6IAMaAyQ993tCqfaQiBzUh6kymfryn4mi6On0+x24t
	jYyNgmHWMA77oA3rM488GKQHvM/7vUhpWYqB0k8XoIzluGiXNcQ==
X-Google-Smtp-Source: AGHT+IH57MuHcDHv+x5UAqmellOHF8tbCFZy/cwz2QUNWqRkpzHVrkhYN52+AKI+q4qbxLf8Ieq3NJw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:db0b:b0:1b7:c803:4818 with SMTP id
 m11-20020a170902db0b00b001b7c8034818mr263502plx.0.1694725496654; Thu, 14 Sep
 2023 14:04:56 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:04:44 -0700
In-Reply-To: <20230914210452.2588884-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914210452.2588884-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914210452.2588884-2-sdf@google.com>
Subject: [PATCH bpf-next v2 1/9] xsk: Support tx_metadata_len
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

For zerocopy mode, tx_desc->addr can point to the arbitrary offset
and carry some TX metadata in the headroom. For copy mode, there
is no way currently to populate skb metadata.

Introduce new tx_metadata_len umem config option that indicates how many
bytes to treat as metadata. Metadata bytes come prior to tx_desc address
(same as in RX case).

The size of the metadata has the same constraints as XDP:
- less than 256 bytes
- 4-byte aligned
- non-zero

This data is not interpreted in any way right now.

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
index 1617af380162..10993a05d220 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -28,6 +28,7 @@ struct xdp_umem {
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
index 06cead2b8e34..333f3d53aad4 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -199,6 +199,9 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (headroom >= chunk_size - XDP_PACKET_HEADROOM)
 		return -EINVAL;
 
+	if (mr->tx_metadata_len > 256 || mr->tx_metadata_len % 4)
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
index 55f8b9b0e06d..5e479869ede1 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1255,6 +1255,14 @@ struct xdp_umem_reg_v1 {
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
@@ -1298,8 +1306,10 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 
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
index b3f7b310811e..57c8d7100de8 100644
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
2.42.0.459.ge4e396fd5e-goog


