Return-Path: <bpf+bounces-43589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A19B6A1A
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 18:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7371F21806
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DADA231CBB;
	Wed, 30 Oct 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0dH4wj5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987E231C86;
	Wed, 30 Oct 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307280; cv=none; b=elKxjLLS6VA8eHo8dAoq++5xpmJpiJA13p97PbZ3r1SQIJ1RnoXB+ddoCTIyUHKSDuJB55TTfAmRHPtXtGKILbCugYk2XhC7XZOYkLIDucmEkKyY+Ib6cPgFTmzEY4v3kiYne8x/Idsx0Z8T9BcdlWUdkfbnvCZHQHVph/QCYzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307280; c=relaxed/simple;
	bh=9NVl3qC4o8Zw61QwjUR2G6eHRR94GLSptDSfljZygyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFU8e8zCOH4uELszvpRB7wb5ogMZgXqOrQuNAzJDME/iwC6oN855z78ywLbcT+vJyHclRgpJYE6aQSrdHeYAslxshZK+qdAvG0CXceukbF1JKV0+cAnuOTsYIxsWxVGkq1k488zCmGweu+ObLcIToDqOEc4o2cZhtaVlWCgJ35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0dH4wj5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730307279; x=1761843279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NVl3qC4o8Zw61QwjUR2G6eHRR94GLSptDSfljZygyU=;
  b=e0dH4wj5KgZTQ4k2655RWFZv3BMCZZt9B+8Pmgv9sTNlGLU/FUA8O0yt
   g5w4lggvAfraQfFN2LJSvC2pSuKvB1V6KiOe4uzfLvLqSOQtfVaINI0o6
   eBYXrLevUXEIdyn0bG+Jwa+eBi1ABH7k+SJml9+b0GgxFMpvIS0HtlJAm
   WBN75Dd61XYmjYaiTZ6oZfwIbRbcVM+MsfgWVEvTJUmxiCiYKLx6Jj8AA
   1P5pcH5sPouyPEVNb7ra8ymnHE2jtSH9XSzMJhgMxZ8mU/bWUD4sCkIVx
   WAC2laYBmhQFDSSDX7dYwdMTwpLcuF3bIoLqt89NllNULf6Mr6zgzk6jX
   g==;
X-CSE-ConnectionGUID: vmJMrHk6QMqFbVqZZY6jcQ==
X-CSE-MsgGUID: y8oZ89vHTgmhuzve0bVWAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41389854"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="41389854"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:54:39 -0700
X-CSE-ConnectionGUID: M0zcxHgKRpKvS25+98kFNg==
X-CSE-MsgGUID: udTRuFhCT8WDHoDOpgDFgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="87524691"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2024 09:54:35 -0700
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
Subject: [PATCH net-next v3 17/18] libeth: support native XDP and register memory model
Date: Wed, 30 Oct 2024 17:52:00 +0100
Message-ID: <20241030165201.442301-18-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030165201.442301-1-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand libeth's Page Pool functionality by adding native XDP support.
This means picking the appropriate headroom and DMA direction.
Also, register all the created &page_pools as XDP memory models.
A driver then can call xdp_rxq_info_attach_page_pool() when registering
its RxQ info.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/rx.h                |  6 +++++-
 drivers/net/ethernet/intel/libeth/rx.c | 20 +++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 43574bd6612f..148be5cd822e 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -13,8 +13,10 @@
 
 /* Space reserved in front of each frame */
 #define LIBETH_SKB_HEADROOM	(NET_SKB_PAD + NET_IP_ALIGN)
+#define LIBETH_XDP_HEADROOM	(ALIGN(XDP_PACKET_HEADROOM, NET_SKB_PAD) + \
+				 NET_IP_ALIGN)
 /* Maximum headroom for worst-case calculations */
-#define LIBETH_MAX_HEADROOM	LIBETH_SKB_HEADROOM
+#define LIBETH_MAX_HEADROOM	LIBETH_XDP_HEADROOM
 /* Link layer / L2 overhead: Ethernet, 2 VLAN tags (C + S), FCS */
 #define LIBETH_RX_LL_LEN	(ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN)
 /* Maximum supported L2-L4 header length */
@@ -66,6 +68,7 @@ enum libeth_fqe_type {
  * @count: number of descriptors/buffers the queue has
  * @type: type of the buffers this queue has
  * @hsplit: flag whether header split is enabled
+ * @xdp: flag indicating whether XDP is enabled
  * @buf_len: HW-writeable length per each buffer
  * @nid: ID of the closest NUMA node with memory
  */
@@ -81,6 +84,7 @@ struct libeth_fq {
 	/* Cold fields */
 	enum libeth_fqe_type	type:2;
 	bool			hsplit:1;
+	bool			xdp:1;
 
 	u32			buf_len;
 	int			nid;
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index f20926669318..616426a2e363 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -68,7 +68,7 @@ static u32 libeth_rx_hw_len_truesize(const struct page_pool_params *pp,
 static bool libeth_rx_page_pool_params(struct libeth_fq *fq,
 				       struct page_pool_params *pp)
 {
-	pp->offset = LIBETH_SKB_HEADROOM;
+	pp->offset = fq->xdp ? LIBETH_XDP_HEADROOM : LIBETH_SKB_HEADROOM;
 	/* HW-writeable / syncable length per one page */
 	pp->max_len = LIBETH_RX_PAGE_LEN(pp->offset);
 
@@ -155,11 +155,12 @@ int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
 		.dev		= napi->dev->dev.parent,
 		.netdev		= napi->dev,
 		.napi		= napi,
-		.dma_dir	= DMA_FROM_DEVICE,
 	};
 	struct libeth_fqe *fqes;
 	struct page_pool *pool;
-	bool ret;
+	int ret;
+
+	pp.dma_dir = fq->xdp ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
 
 	if (!fq->hsplit)
 		ret = libeth_rx_page_pool_params(fq, &pp);
@@ -173,18 +174,26 @@ int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
 		return PTR_ERR(pool);
 
 	fqes = kvcalloc_node(fq->count, sizeof(*fqes), GFP_KERNEL, fq->nid);
-	if (!fqes)
+	if (!fqes) {
+		ret = -ENOMEM;
 		goto err_buf;
+	}
+
+	ret = xdp_reg_page_pool(pool);
+	if (ret)
+		goto err_mem;
 
 	fq->fqes = fqes;
 	fq->pp = pool;
 
 	return 0;
 
+err_mem:
+	kvfree(fqes);
 err_buf:
 	page_pool_destroy(pool);
 
-	return -ENOMEM;
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_create, LIBETH);
 
@@ -194,6 +203,7 @@ EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_create, LIBETH);
  */
 void libeth_rx_fq_destroy(struct libeth_fq *fq)
 {
+	xdp_unreg_page_pool(fq->pp);
 	kvfree(fq->fqes);
 	page_pool_destroy(fq->pp);
 }
-- 
2.47.0


