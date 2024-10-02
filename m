Return-Path: <bpf+bounces-40770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E6798DFE6
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AFF1C22FC4
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75FA1D131E;
	Wed,  2 Oct 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zk1MzkkD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB41D12E3;
	Wed,  2 Oct 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884498; cv=none; b=P9y0MWzwhXl8r+PIur1k/clfKBw/ISuIBIK+pa6KzVYcweUqlRbCd8WFvZRN5E+hkPutW2DobW5G+/EiIvextLxcTuOguqTSpYho92M18G5wYIuGrgFfGD9T2NIzMBa9n77UOJSavgNvWBTqt94wcZKRLZFXh7D/Q63f9mHabL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884498; c=relaxed/simple;
	bh=KvVnpCkxmabJb+RRBOEsAMz7vD62sAxroz3xiSVnRMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MlsQe8Mk/fqaib785mdFCEcYGGUmk7mr+iyLgXFypK68PlU59+vkbm1v3bJA90pkVr6SlPWpZbP8gFLP6xWVvCJaJmMHNzXRgfxgu4OXCk2lEWGcN9OyZlmTtsug6zeXG8WBiFum1uFN7/HtUbAL0v9bLCu8s6C93RJFEW/BUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zk1MzkkD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727884498; x=1759420498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KvVnpCkxmabJb+RRBOEsAMz7vD62sAxroz3xiSVnRMs=;
  b=Zk1MzkkDtLxbayX0oCuFHNWPa/iLtzrNDuy5xprI+xL2lzE5Kt1fg40r
   9NQkyGYTsSqqq5CffrCXjGACccRmQiEwx9qP/zvSr9LyCiztecqk+HIcc
   qc1yzI0XMiBEJ4gDf1ohJjPctGdkVddrzST2+pyy9RNSTdl6/ZELCXhzp
   3ErT5b44gZGhG1L8uf8KP/IJA4skguwGSmRCTKk9i0sbl2H/7gVbbhGsT
   qfrSIrwcaD/+IMHaimhC2uPQ6K3F9fc1suAxnqFhC1G0oaN7Z1bEoArXb
   KtWteylUJxxaqlcg98U7zDjt98JLdlKuyEStQvXtXF9uYxqm/5VliYGMR
   A==;
X-CSE-ConnectionGUID: UOHqnWaES++DNjlRDOxIaA==
X-CSE-MsgGUID: 1FkMOXvPRzO7bszfJyoOQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30762982"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="30762982"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 08:54:56 -0700
X-CSE-ConnectionGUID: W+Ah3BYyT1aQ2/aYH8WMpw==
X-CSE-MsgGUID: ALWYIiQkRSewZO/KMXVT8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="73628794"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2024 08:54:53 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com
Subject: [PATCH bpf-next 5/6] xsk: wrap duplicated code to function
Date: Wed,  2 Oct 2024 17:54:40 +0200
Message-Id: <20241002155441.253956-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
References: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both allocation paths have exactly the same code responsible for getting
and initializing xskb. Pull it out to common function.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk_buff_pool.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index e946ba4a5ccf..ae71da7d2cd6 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -503,6 +503,22 @@ static bool xp_check_aligned(struct xsk_buff_pool *pool, u64 *addr)
 	return *addr < pool->addrs_cnt;
 }
 
+static struct xdp_buff_xsk *xp_get_xskb(struct xsk_buff_pool *pool, u64 addr)
+{
+	struct xdp_buff_xsk *xskb;
+
+	if (pool->unaligned) {
+		xskb = pool->free_heads[--pool->free_heads_cnt];
+		xp_init_xskb_addr(xskb, pool, addr);
+		if (pool->dma_pages)
+			xp_init_xskb_dma(xskb, pool, pool->dma_pages, addr);
+	} else {
+		xskb = &pool->heads[xp_aligned_extract_idx(pool, addr)];
+	}
+
+	return xskb;
+}
+
 static struct xdp_buff_xsk *__xp_alloc(struct xsk_buff_pool *pool)
 {
 	struct xdp_buff_xsk *xskb;
@@ -528,14 +544,7 @@ static struct xdp_buff_xsk *__xp_alloc(struct xsk_buff_pool *pool)
 		break;
 	}
 
-	if (pool->unaligned) {
-		xskb = pool->free_heads[--pool->free_heads_cnt];
-		xp_init_xskb_addr(xskb, pool, addr);
-		if (pool->dma_pages)
-			xp_init_xskb_dma(xskb, pool, pool->dma_pages, addr);
-	} else {
-		xskb = &pool->heads[xp_aligned_extract_idx(pool, addr)];
-	}
+	xskb = xp_get_xskb(pool, addr);
 
 	xskq_cons_release(pool->fq);
 	return xskb;
@@ -593,14 +602,7 @@ static u32 xp_alloc_new_from_fq(struct xsk_buff_pool *pool, struct xdp_buff **xd
 			continue;
 		}
 
-		if (pool->unaligned) {
-			xskb = pool->free_heads[--pool->free_heads_cnt];
-			xp_init_xskb_addr(xskb, pool, addr);
-			if (pool->dma_pages)
-				xp_init_xskb_dma(xskb, pool, pool->dma_pages, addr);
-		} else {
-			xskb = &pool->heads[xp_aligned_extract_idx(pool, addr)];
-		}
+		xskb = xp_get_xskb(pool, addr);
 
 		*xdp = &xskb->xdp;
 		xdp++;
-- 
2.34.1


