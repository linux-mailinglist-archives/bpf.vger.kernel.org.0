Return-Path: <bpf+bounces-44772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD79C7748
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94C3281917
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54054217466;
	Wed, 13 Nov 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zuea/yrU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F0321730F;
	Wed, 13 Nov 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511570; cv=none; b=uzrplxU0Sqajc7jnUXpnbMyUOPzvQpVrajXcyflirUY+XX7p2wv4TL6anp02J1YvdBZeuoWsjC5gzbpDwLTmJvzZesbmNV/ELdiSQ7Ao0M9F3FUkYB0ZpNZFng/iUOCGGjigwsZ7LwsJFKgMegn/WGPnl+xqiDjcJVXROPqS8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511570; c=relaxed/simple;
	bh=w49RAZ+8uMjhzY9cwwAS/yrxn853A/gL1dROucE0B1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTOr3OcZ/SqqLBPHd9Ltl0r1/t/FZz6s7arQj2F1ECYa0IbnoiwmDKm5tYJFTc/cob+K9CF57W7WmYIO/WolkpAHvCrfxBNqYPBQoSWBovzmhbI4crIzKrVrK9zlRywYXtIc9xCHjfXrFVl+COSz7t3sdQ2Hwxor3ZbgUuogoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zuea/yrU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511569; x=1763047569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w49RAZ+8uMjhzY9cwwAS/yrxn853A/gL1dROucE0B1Q=;
  b=Zuea/yrUCD7Hcc5SP/V5PeBHsH5GA+CYib0wbDCITxFQwNEDcPa/cDxH
   dZWbdQzBnsJgvTqVEfOKA3bTDTLiW0g2Rs3VyDEZXvtKFZhhXzYmgr4+u
   tFla5CDO2IxSRRZ8vfsfSBqyjo9WZYfj8Idvr4zdKAZ6AB8PdeMGQmEH1
   Niqb2OkDUNVFhAhTjVG0sPsmKKyTXviH5T0dacf5p/Ib/BQwtGqe9YXZL
   RS1/UVzrZEdhwaSTBl0AGbbwDFMLb1qHetyPvT0dODwwu0voEUIMJt472
   P4U7aelV5jzDfjHqZFyNxJkFPp1HT03iMV6tnvvQjPsmieR6DX5Gg5iKk
   Q==;
X-CSE-ConnectionGUID: 4Z9hjXOrTiedvCHkbiwm/w==
X-CSE-MsgGUID: G7xeK7y7Qs2q1PDUW4YmmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799469"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799469"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:26:09 -0800
X-CSE-ConnectionGUID: w1QGxGP4TmGY/7yhce5l6w==
X-CSE-MsgGUID: 4Pmx0WOyQ5KL5cgeDnPLhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118727037"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:26:05 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 17/19] xsk: add helper to get &xdp_desc's DMA and meta pointer in one go
Date: Wed, 13 Nov 2024 16:24:40 +0100
Message-ID: <20241113152442.4000468-18-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when you send an XSk frame with metadata, you need to do
the following:

* call external xsk_buff_raw_get_dma();
* call inline xsk_buff_get_metadata(), which calls external
  xsk_buff_raw_get_data() and then do some inline checks.

This effectively means that the following piece:

addr = pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;

is done twice per frame, plus you have 2 external calls per frame, plus
this:

	meta = pool->addrs + addr - pool->tx_metadata_len;
	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))

is always inlined, even if there's no meta or it's invalid.

Add xsk_buff_raw_get_ctx() (xp_raw_get_ctx() to be precise) to do that
in one go. It returns a small structure with 2 fields: DMA address,
filled unconditionally, and metadata pointer, valid only if it's
present. The address correction is performed only once and you also
have only 1 external call per XSk frame, which does all the calculations
and checks outside of your hotpath. You only need to check
`if (ctx.meta)` for the metadata presence.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp_sock_drv.h  | 23 +++++++++++++++++++++
 include/net/xsk_buff_pool.h |  8 ++++++++
 net/xdp/xsk_buff_pool.c     | 40 +++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 6aae95b83645..324a4bb04431 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -205,6 +205,23 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 	return xp_raw_get_data(pool, addr);
 }
 
+/**
+ * xsk_buff_raw_get_ctx - get &xdp_desc context
+ * @pool: XSk buff pool desc address belongs to
+ * @addr: desc address (from userspace)
+ *
+ * Wrapper for xp_raw_get_ctx() to be used in drivers, see its kdoc for
+ * details.
+ *
+ * Return: new &xdp_desc_ctx struct containing desc's DMA address and metadata
+ * pointer, if it is present and valid (initialized to %NULL otherwise).
+ */
+static inline struct xdp_desc_ctx
+xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
+{
+	return xp_raw_get_ctx(pool, addr);
+}
+
 #define XDP_TXMD_FLAGS_VALID ( \
 		XDP_TXMD_FLAGS_TIMESTAMP | \
 		XDP_TXMD_FLAGS_CHECKSUM | \
@@ -402,6 +419,12 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 	return NULL;
 }
 
+static inline struct xdp_desc_ctx
+xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
+{
+	return (struct xdp_desc_ctx){ };
+}
+
 static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
 {
 	return false;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 50779406bc2d..1dcd4d71468a 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -141,6 +141,14 @@ u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max);
 bool xp_can_alloc(struct xsk_buff_pool *pool, u32 count);
 void *xp_raw_get_data(struct xsk_buff_pool *pool, u64 addr);
 dma_addr_t xp_raw_get_dma(struct xsk_buff_pool *pool, u64 addr);
+
+struct xdp_desc_ctx {
+	dma_addr_t dma;
+	struct xsk_tx_metadata *meta;
+};
+
+struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr);
+
 static inline dma_addr_t xp_get_dma(struct xdp_buff_xsk *xskb)
 {
 	return xskb->dma;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index ae71da7d2cd6..02c42caec9f4 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -715,3 +715,43 @@ dma_addr_t xp_raw_get_dma(struct xsk_buff_pool *pool, u64 addr)
 		(addr & ~PAGE_MASK);
 }
 EXPORT_SYMBOL(xp_raw_get_dma);
+
+/**
+ * xp_raw_get_ctx - get &xdp_desc context
+ * @pool: XSk buff pool desc address belongs to
+ * @addr: desc address (from userspace)
+ *
+ * Helper for getting desc's DMA address and metadata pointer, if present.
+ * Saves one call on hotpath, double calculation of the actual address,
+ * and inline checks for metadata presence and sanity.
+ * Please use xsk_buff_raw_get_ctx() in drivers instead.
+ *
+ * Return: new &xdp_desc_ctx struct containing desc's DMA address and metadata
+ * pointer, if it is present and valid (initialized to %NULL otherwise).
+ */
+struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
+{
+	struct xsk_tx_metadata *meta;
+	struct xdp_desc_ctx ret;
+
+	addr = pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;
+	ret = (typeof(ret)){
+		/* Same logic as in xp_raw_get_dma() */
+		.dma	= (pool->dma_pages[addr >> PAGE_SHIFT] &
+			   ~XSK_NEXT_PG_CONTIG_MASK) + (addr & ~PAGE_MASK),
+	};
+
+	if (!pool->tx_metadata_len)
+		goto out;
+
+	/* Same logic as in xp_raw_get_data() + xsk_buff_get_metadata() */
+	meta = pool->addrs + addr - pool->tx_metadata_len;
+	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+		goto out;
+
+	ret.meta = meta;
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL(xp_raw_get_ctx);
-- 
2.47.0


