Return-Path: <bpf+bounces-41109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719AB992BAF
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F45E1C23067
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF851D3584;
	Mon,  7 Oct 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4BE7JHZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7511D1F63;
	Mon,  7 Oct 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303921; cv=none; b=DxOngPWRPmUgESj/JEzf8ya787l2m4gyX8cHyjV0peR38c7ENON3H23421raJaDXoYt2Dv0T50ph0QuQCeWlxKO5sWFM8JfNYZ8YV0I/86wqGCHfDZzahh30H30yxPAx/hcxXRL1Gx/5LqmBOU1OKm0DySdr7Ujg0eVOFIYmbbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303921; c=relaxed/simple;
	bh=jmNzshYLRcMGG27GagBV1VflSpy6wZhtH6C3XxtQ2FA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LY1huuimExrOrwCvVlGniOvtwuGO3D+eSAjClP17O31z5Si4iya84+cLksUZftaZrqh5ApTh1sxcuoXRJVjQvaiIAljdXqgl6EwRgHiSPXltsMSDaFJzalt6eYsDhWDdu2MC1nQ2lNNY8FLoxwosX/Fr8oOn20sXhwenwFmPQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4BE7JHZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728303919; x=1759839919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmNzshYLRcMGG27GagBV1VflSpy6wZhtH6C3XxtQ2FA=;
  b=F4BE7JHZUBrR4ybGMKIkYkhridsNtBhR324TdLBGzRQQU5ZfG/5PKqL7
   m0Q9rzUMARF+XTYy4svfHLxSaAtowjzIG02saManuSADQ7qh2YReE/nj4
   gtDkvwamfyWKBKou5sd0h7OCLvKQMCSHU2Dxktjd33jPDNqQf/J3TWaoH
   jTNhmJl0K+B3CP+ki3LOHy+03nkCYUFG2CuqepozP1aBwGJ77G5Q3H7oO
   8R/FD1iZWTAfqRRP1AU/ts3APXRIAhVWB34RNJsjBi+2yHGRLpVPp228X
   ceKfwra3QSI912hdMVQrAEuTcUnjcsRu4W1I+oZh3GOyB0UOq9R8PG92l
   Q==;
X-CSE-ConnectionGUID: CIrOpnsqQ4ClSixlyLNdMw==
X-CSE-MsgGUID: S2IVcMweRsqclFO8Xc5L7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="15066365"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="15066365"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:25:10 -0700
X-CSE-ConnectionGUID: j32FjuqQQFSe3G2VW3S1WA==
X-CSE-MsgGUID: JRpSuzsHRRuq+qKCTZXclQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80250916"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa005.jf.intel.com with ESMTP; 07 Oct 2024 05:25:09 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	vadfed@meta.com
Subject: [PATCH v2 bpf-next 3/6] xsk: get rid of xdp_buff_xsk::orig_addr
Date: Mon,  7 Oct 2024 14:24:55 +0200
Message-Id: <20241007122458.282590-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
References: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continue the process of dieting xdp_buff_xsk by removing orig_addr
member. It can be calculated from xdp->data_hard_start where it was
previously used, so it is not anything that has to be carried around in
struct used widely in hot path.

This has been used for initializing xdp_buff_xsk::frame_dma during pool
setup and as a shortcut in xp_get_handle() to retrieve address provided
to xsk Rx queue.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xsk_buff_pool.h | 19 +++++++++++--------
 net/xdp/xsk.c               |  2 +-
 net/xdp/xsk_buff_pool.c     |  4 +++-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index af8b6f776f86..468a23b1b4c5 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -28,7 +28,6 @@ struct xdp_buff_xsk {
 	dma_addr_t dma;
 	dma_addr_t frame_dma;
 	struct xsk_buff_pool *pool;
-	u64 orig_addr;
 	struct list_head list_node;
 };
 
@@ -119,7 +118,6 @@ void xp_free(struct xdp_buff_xsk *xskb);
 static inline void xp_init_xskb_addr(struct xdp_buff_xsk *xskb, struct xsk_buff_pool *pool,
 				     u64 addr)
 {
-	xskb->orig_addr = addr;
 	xskb->xdp.data_hard_start = pool->addrs + addr + pool->headroom;
 }
 
@@ -221,14 +219,19 @@ static inline void xp_release(struct xdp_buff_xsk *xskb)
 		xskb->pool->free_heads[xskb->pool->free_heads_cnt++] = xskb;
 }
 
-static inline u64 xp_get_handle(struct xdp_buff_xsk *xskb)
+static inline u64 xp_get_handle(struct xdp_buff_xsk *xskb,
+				struct xsk_buff_pool *pool)
 {
-	u64 offset = xskb->xdp.data - xskb->xdp.data_hard_start;
+	u64 orig_addr = xskb->xdp.data - pool->addrs;
+	u64 offset;
 
-	offset += xskb->pool->headroom;
-	if (!xskb->pool->unaligned)
-		return xskb->orig_addr + offset;
-	return xskb->orig_addr + (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
+	if (!pool->unaligned)
+		return orig_addr;
+
+	offset = xskb->xdp.data - xskb->xdp.data_hard_start;
+	orig_addr -= offset;
+	offset += pool->headroom;
+	return orig_addr + (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
 }
 
 static inline bool xp_tx_metadata_enabled(const struct xsk_buff_pool *pool)
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 520023405908..6c31c1de1619 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -141,7 +141,7 @@ static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff_xsk *xskb, u32 len,
 	u64 addr;
 	int err;
 
-	addr = xp_get_handle(xskb);
+	addr = xp_get_handle(xskb, xskb->pool);
 	err = xskq_prod_reserve_desc(xs->rx, addr, len, flags);
 	if (err) {
 		xs->rx_queue_full++;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 973557d5e4f7..7ecd4ccd2473 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -416,8 +416,10 @@ static int xp_init_dma_info(struct xsk_buff_pool *pool, struct xsk_dma_map *dma_
 
 		for (i = 0; i < pool->heads_cnt; i++) {
 			struct xdp_buff_xsk *xskb = &pool->heads[i];
+			u64 orig_addr;
 
-			xp_init_xskb_dma(xskb, pool, dma_map->dma_pages, xskb->orig_addr);
+			orig_addr = xskb->xdp.data_hard_start - pool->addrs - pool->headroom;
+			xp_init_xskb_dma(xskb, pool, dma_map->dma_pages, orig_addr);
 		}
 	}
 
-- 
2.34.1


