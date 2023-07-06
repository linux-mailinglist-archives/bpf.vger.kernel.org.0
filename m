Return-Path: <bpf+bounces-4312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B6A74A534
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FF01C20E5F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A301643D;
	Thu,  6 Jul 2023 20:47:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5E71642B;
	Thu,  6 Jul 2023 20:47:41 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0481992;
	Thu,  6 Jul 2023 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688676460; x=1720212460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0yvv6bbrrFDTtRISrfnsatiXi/oYgnIG4pHC6L5r9c=;
  b=mumlVJ7AXc5cqBOLOhWQKv/Hg6YnZ4m7O3W0VHu6fRIdDPehYpDBzV6r
   ZAN/NpqSditMqBxPHm6m3r2fIn/4xLh5+JP7ctT0mxQPNq26oOiNOGq6+
   Zs8J15m1v3TUivIZB0deUd5ZM/GLolWVemR2vqPPUv/x5RSk5IpIggIPe
   3C25dbYm/sW0tBn8jMGKhw/7hFsjw8bGDzuAipS7dtbKj7A8xJkE4Gkna
   HfBl22w0MfgZ74V7Buq8n6lXtsc/e9idC73e104kbE3ENluDmgsOBasxc
   3qh8nO9yA+0TzxR+nZyGfipGR3zrVnvMCMuL3rRhEINMTTMW2HC6ep3Pk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361195332"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361195332"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="785059538"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="785059538"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 13:47:37 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	maciej.fijalkowski@intel.com,
	simon.horman@corigine.com,
	toke@kernel.org
Subject: [PATCH v5 bpf-next 07/24] xsk: allow core/drivers to test EOP bit
Date: Thu,  6 Jul 2023 22:46:33 +0200
Message-Id: <20230706204650.469087-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
References: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Drivers are used to check for EOP bit whereas AF_XDP operates on
inverted logic - user space indicates that current frag is not the last
one and packet continues. For AF_XDP core needs, add xp_mb_desc() that
will simply test XDP_PKT_CONTD from xdp_desc::options, but in order to
preserve drivers default behavior, introduce an interface for ZC drivers
that will negate xp_mb_desc() result and therefore make it easier to
test EOP bit from during production of HW Tx descriptors.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h  | 10 ++++++++++
 include/net/xsk_buff_pool.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index c243f906ebed..0d34cdb5567d 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -89,6 +89,11 @@ static inline struct xdp_buff *xsk_buff_alloc(struct xsk_buff_pool *pool)
 	return xp_alloc(pool);
 }
 
+static inline bool xsk_is_eop_desc(struct xdp_desc *desc)
+{
+	return !xp_mb_desc(desc);
+}
+
 /* Returns as many entries as possible up to max. 0 <= N <= max. */
 static inline u32 xsk_buff_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max)
 {
@@ -241,6 +246,11 @@ static inline struct xdp_buff *xsk_buff_alloc(struct xsk_buff_pool *pool)
 	return NULL;
 }
 
+static inline bool xsk_is_eop_desc(struct xdp_desc *desc)
+{
+	return false;
+}
+
 static inline u32 xsk_buff_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max)
 {
 	return 0;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index a8d7b8a3688a..4dcca163e076 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -184,6 +184,11 @@ static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
 	       !(pool->dma_pages[addr >> PAGE_SHIFT] & XSK_NEXT_PG_CONTIG_MASK);
 }
 
+static inline bool xp_mb_desc(struct xdp_desc *desc)
+{
+	return desc->options & XDP_PKT_CONTD;
+}
+
 static inline u64 xp_aligned_extract_addr(struct xsk_buff_pool *pool, u64 addr)
 {
 	return addr & pool->chunk_mask;
-- 
2.34.1


