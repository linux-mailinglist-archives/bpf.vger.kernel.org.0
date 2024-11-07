Return-Path: <bpf+bounces-44271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814539C0B5C
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F6B1C23AA1
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4574B21F4D0;
	Thu,  7 Nov 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XW196hQq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8B21F4B7;
	Thu,  7 Nov 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996097; cv=none; b=D25E2MznEKPr8PKl8Rtq3XWbE01vj8qF2yM3XDiH6m1IUWE053E1UM6NTaHNRK8ET4nfefafjxSKPa8G8Wuh5bsWwpWRsJjhQldmsG3p3w4SGayInguRJG2lA7FSv/whPGm5deywMi7aZ2FD5NNTiHl+AWNyzTf9dvOkhHWrz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996097; c=relaxed/simple;
	bh=9NVl3qC4o8Zw61QwjUR2G6eHRR94GLSptDSfljZygyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+5Zy6w2rhtFP/BMkzMULN0Zwpm0KalVa0swtABKwH1joc7w2cq9RiQ5o/6vHJqVlvenc69GKpSf8AtfMIm/d/Rn8QQyTnwlfqjbktSlgW9/LFHF5wU0X59U6FKQqv+6m+dKkNbvRbsH4zt7qcrloo000Sb73jMyt5xbUAORhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XW196hQq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730996096; x=1762532096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NVl3qC4o8Zw61QwjUR2G6eHRR94GLSptDSfljZygyU=;
  b=XW196hQqjs4NrQrSoWr8DL5oVFLNlqsoTFApc4mVSc5jbg44sn6r8zG+
   jSa9RpYN1FoIMQDLWXJhIQEu/jXCUs00vixwzhAR8Rx8/C4SYFsUX4Ojt
   5/G37fkqargAg6ALykawFwX2hhdVUdoOuF0HUuWHfm1wtgD/VHTm4gcHp
   8KOwjWtpWOgAs1IxCesozlmuoUfGcft91kRNP/uUykRf0jM/LhE45JDDr
   2CUGhf2qpFdSSHVfawPKlloorI/tRbRjKc8CVkaFPMgzrZ8I68vnOIWsj
   dE/ytuc9JiLHaFq5e7Gse4wNMZxFLhegVS08gudXwkQvwpDI3i2aLS5Nt
   A==;
X-CSE-ConnectionGUID: 8bSG11BXTa+hkfh1YFkoFg==
X-CSE-MsgGUID: JAMC8UUCTIu07PDkaAhl6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41956102"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41956102"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:14:56 -0800
X-CSE-ConnectionGUID: xmkejufBQTWus3kHwveUFw==
X-CSE-MsgGUID: 3Vvl9jWjRXysX3Z9YNVfcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="90258256"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 08:14:52 -0800
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
Subject: [PATCH net-next v4 18/19] libeth: support native XDP and register memory model
Date: Thu,  7 Nov 2024 17:10:25 +0100
Message-ID: <20241107161026.2903044-19-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
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


