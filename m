Return-Path: <bpf+bounces-47266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554199F6C9B
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92ADE1894848
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F6F1FBC8D;
	Wed, 18 Dec 2024 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e71tM8Qh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682161369B4;
	Wed, 18 Dec 2024 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543950; cv=none; b=WQRLVV0ybzeSar5Z7KfZhDbzUdzwt9qYhkKROvRqkTHjaurCBM4bflos57wVZtRQgxyy61ej154PQYbufSZX7ksUxAtlOY7AHO+Xo/0ZWbYQBMjTKMX9Tz6sBqa2Mzkli2DYLXvwTxsxbGH5Ggt0+/UfmU1GfzHkrz4UKzSALMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543950; c=relaxed/simple;
	bh=Ra+4Z3WOBik46iypn3QYcGKHgYGufSSiH3OJVu257So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5MaUiOKvJZaTEI0TqVjwG4+MUhzR2PQtHZcwZzDdEd6qKUdEFo9m+iV8h3C/f8ndiuocA/WZwIIpfx0lPpiH5e9Hcn6j+L7QlidcGZ/+LTjGS8QkMHkZTM4btVWhjC/5kug4rMdJ7gCD6lSJftf/dmObnfmZAOmK94sI6Qlen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e71tM8Qh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734543948; x=1766079948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ra+4Z3WOBik46iypn3QYcGKHgYGufSSiH3OJVu257So=;
  b=e71tM8QhxbYR4O0o138b0rJ3tImlfcZ8ADpYfj8CeK+/gb7WRyEZUUu5
   aMuCN8CJpX3QVNlM4sCzXWjHAlp5VD8rekzHFHFAFaudfPAPUO406GM5s
   YoRA3wbQTH+qlEhfnbK5NCFXS7/l7R//as7b9esqz723vWpgNwuVuPnG1
   RmDk3/5SZoY6ZQk5DURuC3XZoU1zbknXrze2nlFGmXsK9diMgqjK53mGb
   A1y4CZd4awo0IP6Bv4GC26H0T9AQ2Abat8/xdTFYNXpWLSicQF69GXHp4
   OcK10Jt7agG6/A282Ned0RjFGqOoB621BCSAzFLNCZYq1IF5o47MRyZDp
   A==;
X-CSE-ConnectionGUID: Ln3SXn1uQe2aJCpkzDID5w==
X-CSE-MsgGUID: TgkqMkmnRqie3Q/8CDqlAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22621036"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="22621036"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 09:45:48 -0800
X-CSE-ConnectionGUID: xTFwoUobQBmDAJeF6WU0fg==
X-CSE-MsgGUID: l0x00dcFSnCVaBfc43Th/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121192346"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 18 Dec 2024 09:45:43 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/7] xsk: add helper to get &xdp_desc's DMA and meta pointer in one go
Date: Wed, 18 Dec 2024 18:44:34 +0100
Message-ID: <20241218174435.1445282-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
References: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
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
index 86620c818965..7fd1709deef5 100644
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
index 1f7975b49657..4ea742da304d 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -714,3 +714,43 @@ dma_addr_t xp_raw_get_dma(struct xsk_buff_pool *pool, u64 addr)
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
2.47.1


