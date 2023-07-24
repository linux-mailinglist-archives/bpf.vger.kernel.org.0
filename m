Return-Path: <bpf+bounces-5774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA3F76036F
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 02:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9957B2814A6
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 00:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC613ADD;
	Tue, 25 Jul 2023 00:00:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911EB13AE8
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 00:00:03 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B4A1729
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:02 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c04f5827eso2466101a12.1
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690243202; x=1690848002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymr8o17vJSUQpypwAQoDIcs9nAf632/dWN/6S7ClCgA=;
        b=x8wyqgnxkPI1R47kOF7czeBcKbDo19Us6Wz2B+3EQjxMRjz/uaWz6WAYn5ZJUNHtPT
         9sP62arZNoaFQyl0mjxQsDq7Oz/dRRsp8t7sV43IiivWynxk7PTIL1GmxBk/szFMeNmI
         R/0ltnSXbLG0uBwJ3XVgn1+mbNHla5VaPC6DsuCex4+CX08iR5XzcirtSxdhjxc2EEMG
         5ooxcFl7mH7951dX68I0fZr+uAyGNk7QAZ/yqzneYO+drbO7PHkASHIfU1xZKOe/HIoK
         gyyO3uuNynRf8xW+hGj9KjM50kVPQaaG4newQPYl+Jmbdef6Z5yjkl3HH4wZADoC0XT6
         j7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690243202; x=1690848002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymr8o17vJSUQpypwAQoDIcs9nAf632/dWN/6S7ClCgA=;
        b=Zb5wQIE5qd7vJUxvHgxpDRAlKF2d9QqWtYW7DftFHfOaZfKRkbMnIY8VtmSxDtgoLb
         32q+G9fXsQt2FNpAobAk+NM2W4/erM+4FISkUuLUAjdVAWw7An8+cDCATIWFMYzPEyHi
         LeBtRvCX+feNCkxEOKJqnojrV+O5t0w64ScRhwXJzv28tQSWr0yLO6tmecgV03fgz4HU
         1MyBRdkFXjpIEDo30ywnU4tBnsfM1xF1tRrlYzwk9sPCqq5PUEgUxLhncLtdTA7SkxB2
         NbPK9J3TgY1O0meFoVce9GYBumx9zc4e5O6pg//bu4TquG4u6YKD2oGXT7Qc0DeMJE/E
         In6Q==
X-Gm-Message-State: ABy/qLYqDMKXLKqVJDD1GcMwgbAD+XtDviNWlyGEnP2yKo6GXVPdjQNd
	2TCFjzg2NC8zDvTG8kqqyi99XPnIOE0QQtjumci7iA8q4LPsdUAbZDBUwEwGEpbXyfQvJo3gYOa
	sEqN6Jjls676gUlGfeUv5S6uN379uqqJU6QeMUnHIvD8Qx9WN7A==
X-Google-Smtp-Source: APBJJlErUfwmrS0d2RvZugBgVb6ZaXP+fW/wxDQ4lV9RPiRCVOmKdMSFH2IMrq5vkOJhND2554kTdcc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:da18:0:b0:563:4869:f54d with SMTP id
 c24-20020a63da18000000b005634869f54dmr43774pgh.11.1690243201202; Mon, 24 Jul
 2023 17:00:01 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:59:50 -0700
In-Reply-To: <20230724235957.1953861-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724235957.1953861-2-sdf@google.com>
Subject: [RFC net-next v4 1/8] xsk: Support XDP_TX_METADATA_LEN
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
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
index 4f1e0599146e..81106e4d6e0f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1337,6 +1337,26 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
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
2.41.0.487.g6d72f3e995-goog


