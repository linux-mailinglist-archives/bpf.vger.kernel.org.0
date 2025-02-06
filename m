Return-Path: <bpf+bounces-50684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D76A2B140
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 19:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00326160DB7
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C591D86FB;
	Thu,  6 Feb 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgktsySt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A631D63DB;
	Thu,  6 Feb 2025 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866649; cv=none; b=M9PCtZB5kwCLUIEfavJsDt1UGQ9b3qiqK86inD982nRcSmOQ65tfj8AVRB3jxyDTSCIbf9v0GypU77OlHC1hI7T/qoE9wMcPHHr4GHhn05tIT5rSWhcG9p/6gFkzFdGu1T2PyaeQeT74DASUan+NsZc6YfT56DssGv4/2qiX994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866649; c=relaxed/simple;
	bh=DH0AgivTe8MS9FAs7iNfl3KHQN3uOqPy3+QRqscL/Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBSK3st0GnDewqBM237YCndEDdPOQoHnnHoMtBP41MBOtGBd0KOpf7zFCngUXV151+0f1hm9DllY3QREO7XVNPQP7gQsoJvYjgxu+3XqE5C2uemDLWjlzSyqndKDoP801Hvhjs8peCIsTQIlTV9W6lnb4ny9qhLJ2ADButFp9wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgktsySt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738866647; x=1770402647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DH0AgivTe8MS9FAs7iNfl3KHQN3uOqPy3+QRqscL/Ok=;
  b=QgktsyStbg4J5r4KAaFcXgE/aSCQtXO5QdKmBCxsVmu7vkjDm4ApvEdk
   a0OkZnka5hGJiijxNgMjMSwWZcZvIfNQU/H0jx1ZUJgSLTFjh3opqOotj
   onvxH3ONo8vCDY0olep8SeV5/5htkBO4IgAf24U3cYMqHMLcFEddVVrh6
   oTmHyhU37kpYzfeNhxaYqyFICr+tU0XztiWR6w7MdkNMPr+ENeMc/qFFl
   /EwUBe/y/cjEDNQihl/+WzGCg7lY3pcVWE2LlixsxH0DdMRtkohmVuSME
   sF9adz2+iVOSZqOSEXmy831K2r5oaHz0DefuQwWL5VhvFP5o7fU9FWr4/
   Q==;
X-CSE-ConnectionGUID: P45S6D6FRASMju++BHhZQw==
X-CSE-MsgGUID: VwbP7lvlS/K2zkZgHlNRFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49734526"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="49734526"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:30:46 -0800
X-CSE-ConnectionGUID: YBOvmXwcSfyh3KWrhJRnew==
X-CSE-MsgGUID: fl6iGoDJSPWASY+NiWusAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111065902"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 06 Feb 2025 10:30:42 -0800
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
Subject: [PATCH net-next 4/4] xsk: add helper to get &xdp_desc's DMA and meta pointer in one go
Date: Thu,  6 Feb 2025 19:26:29 +0100
Message-ID: <20250206182630.3914318-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when your driver supports XSk Tx metadata and you want to
send an XSk frame, you need to do the following:

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
filled unconditionally, and metadata pointer, non-NULL only if it's
present and valid. The address correction is performed only once and
you also have only 1 external call per XSk frame, which does all the
calculations and checks outside of your hotpath. You only need to
check `if (ctx.meta)` for the metadata presence.
To not copy any existing code, derive address correction and getting
virtual and DMA address into small helpers. bloat-o-meter reports no
object code changes for the existing functionality.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp_sock_drv.h  | 43 +++++++++++++++++++++++++++++++---
 include/net/xsk_buff_pool.h |  8 +++++++
 net/xdp/xsk_buff_pool.c     | 46 +++++++++++++++++++++++++++++++++----
 3 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 784cd34f5bba..15086dcf51d8 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -196,6 +196,23 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
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
@@ -207,20 +224,27 @@ xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
 	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
 }
 
-static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
+static inline struct xsk_tx_metadata *
+__xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
 {
 	struct xsk_tx_metadata *meta;
 
 	if (!pool->tx_metadata_len)
 		return NULL;
 
-	meta = xp_raw_get_data(pool, addr) - pool->tx_metadata_len;
+	meta = data - pool->tx_metadata_len;
 	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
 		return NULL; /* no way to signal the error to the user */
 
 	return meta;
 }
 
+static inline struct xsk_tx_metadata *
+xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
+{
+	return __xsk_buff_get_metadata(pool, xp_raw_get_data(pool, addr));
+}
+
 static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp)
 {
 	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
@@ -388,12 +412,25 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
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
 }
 
-static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
+static inline struct xsk_tx_metadata *
+__xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
+{
+	return NULL;
+}
+
+static inline struct xsk_tx_metadata *
+xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
 {
 	return NULL;
 }
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
index 1f7975b49657..c263fb7a68dc 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -699,18 +699,56 @@ void xp_free(struct xdp_buff_xsk *xskb)
 }
 EXPORT_SYMBOL(xp_free);
 
-void *xp_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
+static u64 __xp_raw_get_addr(const struct xsk_buff_pool *pool, u64 addr)
+{
+	return pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;
+}
+
+static void *__xp_raw_get_data(const struct xsk_buff_pool *pool, u64 addr)
 {
-	addr = pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;
 	return pool->addrs + addr;
 }
+
+void *xp_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
+{
+	return __xp_raw_get_data(pool, __xp_raw_get_addr(pool, addr));
+}
 EXPORT_SYMBOL(xp_raw_get_data);
 
-dma_addr_t xp_raw_get_dma(struct xsk_buff_pool *pool, u64 addr)
+static dma_addr_t __xp_raw_get_dma(const struct xsk_buff_pool *pool, u64 addr)
 {
-	addr = pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;
 	return (pool->dma_pages[addr >> PAGE_SHIFT] &
 		~XSK_NEXT_PG_CONTIG_MASK) +
 		(addr & ~PAGE_MASK);
 }
+
+dma_addr_t xp_raw_get_dma(struct xsk_buff_pool *pool, u64 addr)
+{
+	return __xp_raw_get_dma(pool, __xp_raw_get_addr(pool, addr));
+}
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
+ *
+ * Return: new &xdp_desc_ctx struct containing desc's DMA address and metadata
+ * pointer, if it is present and valid (initialized to %NULL otherwise).
+ */
+struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
+{
+	struct xdp_desc_ctx ret;
+
+	addr = __xp_raw_get_addr(pool, addr);
+
+	ret.dma = __xp_raw_get_dma(pool, addr);
+	ret.meta = __xsk_buff_get_metadata(pool, __xp_raw_get_data(pool, addr));
+
+	return ret;
+}
+EXPORT_SYMBOL(xp_raw_get_ctx);
-- 
2.48.1


