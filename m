Return-Path: <bpf+bounces-12711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476C97D00E1
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2984282234
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 17:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A96E374D4;
	Thu, 19 Oct 2023 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHSdItuE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5C3551F
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 17:49:50 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D59119
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:49:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a541b720aso10984011276.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737788; x=1698342588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWYjupHTrsybIbC+cKMPWbdoetkKkvlDaYZOGGNOxAI=;
        b=kHSdItuE8R+irgHSQPdOb1Q3Si/Kt0SYGgy58gaiNjiNZXx4ypCTDwIFaxV7iw+KZh
         45nek7sjJtFCk3l2p5bxArbolGXn0zQp/1ihBjT0OrzBjkOivGTgqwScSP55jXxkFoxJ
         lvaKIldfjLFskDe+XBxw2KP9SoW8wuHsmi4C1gb7r4CEhlUg0QCUAzgZhbbDthZNF+Ei
         /4H4cr++6TAggO6c1iFevSAZguBXHeUisuBxCvj308QybQrKVPsgk23fUys6dLATw59G
         SQjBCAZtvjoTKadefQA2paDdNjfkikIQVQ2O5FxTjwJ7CFMWXa+Wwom6W6FG06YUr2EM
         6DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737788; x=1698342588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWYjupHTrsybIbC+cKMPWbdoetkKkvlDaYZOGGNOxAI=;
        b=Iszal0pMScpiyBTLAJtVE6rJq22MOEcaNdM6HMebuIoUjgA5Tq1DCXd8pUiSJAm1yV
         rN4wZEykv2DpZe/RMBq2EubaT1tmAHjq4T/o8SwEC4o5TMesa9XrLI6smHj/YRa0kBrl
         xjtN/haN8GbFwD1TdQ56RMax7LZDLNVcTfO31rmC9SA2q+SAxwTkhm4H/kYUlGxHlQTs
         38JHcEV+XSYPWuGTVClW6PDdxhiSLagHKZ9Bpsna97tzQBmZ8b2HIHx2geID/SvoUQ9K
         t4yW7YmgYKndxBfWAkxde0AqJS9NEKc/4Dk0ME+9U1SPrMH2kHZq19CO+UZ2rC4H0doJ
         Shaw==
X-Gm-Message-State: AOJu0Yw279xThIN5uyikm0N96y0+8VEEmWGHb6Mgili+4lEmRXA3jvvt
	xSOqmDt/NY8xq1BG3p8cIYZpXHPCq0G0F8fjvzWZRI2ztON0OygGRWcLyBZx6FKGGH50IzKDMZZ
	PU9TNxw77hLYCYbBvk9nBsc6IwHrb1DWSNV1muN3SvjJLE8e75w==
X-Google-Smtp-Source: AGHT+IEDs813YIVNp2UYrfCj/ArCU1KhUq4M6m5fYHPHTE1se4+tuiUDRxgErFwcccFI78pEc92Oz5Y=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1825:b0:d9a:d272:ee58 with SMTP id
 cf37-20020a056902182500b00d9ad272ee58mr66876ybb.9.1697737787676; Thu, 19 Oct
 2023 10:49:47 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:49:34 -0700
In-Reply-To: <20231019174944.3376335-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019174944.3376335-2-sdf@google.com>
Subject: [PATCH bpf-next v4 01/11] xsk: Support tx_metadata_len
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
index 7dd0df2f6f8e..5ae88a00f34a 100644
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
index ba070fd37d24..ba4c77a24a83 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1265,6 +1265,14 @@ struct xdp_umem_reg_v1 {
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
@@ -1308,8 +1316,10 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 
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
2.42.0.655.g421f12c284-goog


