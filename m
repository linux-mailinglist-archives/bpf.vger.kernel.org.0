Return-Path: <bpf+bounces-2657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57421731F02
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 19:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13503280C38
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2816404;
	Thu, 15 Jun 2023 17:26:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662615AC3;
	Thu, 15 Jun 2023 17:26:48 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9062D61;
	Thu, 15 Jun 2023 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686849996; x=1718385996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wMV2V2E1sFrBlyO+yBc8Em/Okxc0+BCvYpMSJeYiI1E=;
  b=cngw1pieSebM5Y3yGWSJW4UyrWnobzwM21ByJ6Iuaoz4FGF3+9HrhAM0
   ieMVrnDlPowlZJpRYRnykb832aRckxzl9YBlj6CqZoNLeGfyUtZjIb/C+
   QoCMTARFCUV/CVquVL8MGeXJMQVXSsbGPTMN1euMkZ+/cf7MbHPGkzkz+
   H/ztN0x4WeVLnLgzT1IZ84/QbpUHpJ6pQFmRK7WaKv7mcQgCr+C92ob8p
   jp/6jdutP9fbBVZcvY9Sw0vwZDbHwYfF0XWS5+zmCCemnjjq5gi1OJcPh
   ZWz5Ue31qTD5ATQEIcAyljPyc7DYb9dwi21LUYspPhgXt4jDyubFWn3pF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="358983517"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="358983517"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689858553"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689858553"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 10:26:34 -0700
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
Subject: [PATCH v4 bpf-next 07/22] xsk: allow core/drivers to test EOP bit
Date: Thu, 15 Jun 2023 19:25:51 +0200
Message-Id: <20230615172606.349557-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
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
index 9c0d860609ba..a3e18b958d93 100644
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


