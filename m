Return-Path: <bpf+bounces-5292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD6E7596CB
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD29D28173A
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C117ABD;
	Wed, 19 Jul 2023 13:25:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23E17AA2;
	Wed, 19 Jul 2023 13:25:17 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A9C1724;
	Wed, 19 Jul 2023 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773116; x=1721309116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0yvv6bbrrFDTtRISrfnsatiXi/oYgnIG4pHC6L5r9c=;
  b=LTVIBiduQyIRYiFK//lPED6NyjHoclRDO0PBtKS+Ms37pdl+zVgs3CRX
   wDddIoDolcxkB3AZ2FEd3Ac0Lp6iLUvkTutv3frrxyePdNcVWy1DdtC5R
   nIjZx6NZ4gN1n/l9W3Jushe2bh91zKrOVeG2MCBkaG1DVdT6wAHlMxKat
   Fm4MBs7jRVRvBfH55QYVxAL0iR1H8wEzaCTpzOb9nRi5k8/kjMhZK+a5x
   hDl9snZbt3uCD+bFvovcho8UOtc5U+qA4IuVFhLQRpOhGsb7INU/VCSIM
   qCvyq3SLbmFwyEfg/dU2Kq3zC1a/72QF+27WtL7Z/1M+LQZl+0FB0eEY0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363920561"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363920561"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:24:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717978050"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717978050"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 06:24:53 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	tirthendu.sarkar@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v7 bpf-next 07/24] xsk: allow core/drivers to test EOP bit
Date: Wed, 19 Jul 2023 15:24:04 +0200
Message-Id: <20230719132421.584801-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
References: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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


