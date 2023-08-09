Return-Path: <bpf+bounces-7386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EE57765AD
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D33D281DA4
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F91D2E1;
	Wed,  9 Aug 2023 16:54:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EDF1CA18
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:54:24 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E311BFE
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:54:23 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-686e29cb7a0so5278675b3a.3
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 09:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691600063; x=1692204863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBijZdqgmgenDKBkwzMTwPB4myWwJ+WNRzMnHtmF82k=;
        b=tgcnNFNP6nxc0XKkM3Bse2dJjsXQ71OXaHRNOqwLTJO32U/b10j0RcSdF4ih9zelsw
         Q+2mTaPx4hEKrbQ0p2sMZ8XoyUsVfHUWWmz3k60DniVWUXomNAxmkRb5AWvhLuHfuyky
         I/g4LRlik6JD5iEwnChRZweFK9CTwVFTljTxAHnloDbW6PbogcFexLJE8KJT5XRUo5UY
         VffN6h5QU9c06vUEY8/YZUkMF1bQqkkZj2zip2phuDKmun1fdHRXA0LR0SjPY1w+ILW7
         cpApK0AYtKTdkrdw2ZsSHqdayoMT2MWPolrLdAPLYaAXjZ1r70PHAugoBCzNiUAnvuNc
         RN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600063; x=1692204863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBijZdqgmgenDKBkwzMTwPB4myWwJ+WNRzMnHtmF82k=;
        b=VIQGHsjnzb/I2Dd96k9ye16hX19N8luOXvB6cx/oKf7jFfhxpIvo10O2n2fomBmJFK
         BnAF5FTZrNbUVq9gQolcRxcNP1e/2SXE/mAnjz9gYaffCXqDpPwhDB5+Y3JgnacUcvXu
         xqg47IWt3py4crxYJRCT4QrXlzzD0/K84yQEmPNnZE2/iRl/gdDsko8tveu7yqUhrQ4G
         jdeG0llQumlZn9jAklLogs2YRHIb+L8fpQjiIVn249RPbGHZRc4NwZUDjf5EqfHBdsrz
         my8qIj/7WH1nUwea/+63/sJEFfYr+W6TUk/ELXDw9FosKxNPmab8itwEUYEog3Boxox5
         I5Vg==
X-Gm-Message-State: AOJu0YwcCLWReTCNzdWuqjNoHb57z5qMOG2VMSOk8GjJXRNPixDDmW95
	28q9XDTAinWFkcXabjO4z7PcncM2aSg9iMbWnUVWuGoM9LYd5XL8gCHe6uUYRu8QsPMH1Psm+02
	WbtIlN1IEUIfx94J+5fjQiNi7bkJ4/m7wb6h410e1/KJBdqFx8Q==
X-Google-Smtp-Source: AGHT+IELn+slvV4wMjyJYneweTRzHrs1nFXaXRY7JcfjZZ4qc/8NXyFqg+y6XbUwOCnjLwgD7XekSj0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3912:b0:67d:41a8:3e19 with SMTP id
 fh18-20020a056a00391200b0067d41a83e19mr457830pfb.3.1691600062609; Wed, 09 Aug
 2023 09:54:22 -0700 (PDT)
Date: Wed,  9 Aug 2023 09:54:10 -0700
In-Reply-To: <20230809165418.2831456-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809165418.2831456-2-sdf@google.com>
Subject: [PATCH bpf-next 1/9] xsk: Support XDP_TX_METADATA_LEN
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For zerocopy mode, tx_desc->addr can point to the arbitrary offset
and carry some TX metadata in the headroom. For copy mode, there
is no way currently to populate skb metadata.

Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
to treat as metadata. Metadata bytes come prior to tx_desc address
(same as in RX case).

The size of the metadata has the same constraints as XDP:
- less than 256 bytes
- 4-byte aligned
- non-zero

This data is not interpreted in any way right now.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/xdp_sock.h      |  1 +
 include/net/xsk_buff_pool.h |  1 +
 include/uapi/linux/if_xdp.h |  1 +
 net/xdp/xsk.c               | 20 ++++++++++++++++++++
 net/xdp/xsk_buff_pool.c     |  1 +
 net/xdp/xsk_queue.h         | 17 ++++++++++-------
 6 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 1617af380162..467b9fb56827 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -51,6 +51,7 @@ struct xdp_sock {
 	struct list_head flush_node;
 	struct xsk_buff_pool *pool;
 	u16 queue_id;
+	u8 tx_metadata_len;
 	bool zc;
 	bool sg;
 	enum {
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index b0bdff26fc88..9c31e8d1e198 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -77,6 +77,7 @@ struct xsk_buff_pool {
 	u32 chunk_size;
 	u32 chunk_shift;
 	u32 frame_len;
+	u8 tx_metadata_len; /* inherited from xsk_sock */
 	u8 cached_need_wakeup;
 	bool uses_need_wakeup;
 	bool dma_need_sync;
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 8d48863472b9..b37b50102e1c 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -69,6 +69,7 @@ struct xdp_mmap_offsets {
 #define XDP_UMEM_COMPLETION_RING	6
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
+#define XDP_TX_METADATA_LEN		9
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 47796a5a79b3..28df3280501d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1338,6 +1338,26 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
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
+		if (!val || val > 256 || val % 4)
+			return -EINVAL;
+
+		mutex_lock(&xs->mutex);
+		if (xs->state != XSK_READY) {
+			mutex_unlock(&xs->mutex);
+			return -EBUSY;
+		}
+		xs->tx_metadata_len = val;
+		mutex_unlock(&xs->mutex);
+		return 0;
+	}
 	default:
 		break;
 	}
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index b3f7b310811e..b351732f1032 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -85,6 +85,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 		XDP_PACKET_HEADROOM;
 	pool->umem = umem;
 	pool->addrs = umem->addrs;
+	pool->tx_metadata_len = xs->tx_metadata_len;
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
-- 
2.41.0.640.ga95def55d0-goog


