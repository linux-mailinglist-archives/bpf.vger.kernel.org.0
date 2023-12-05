Return-Path: <bpf+bounces-16797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8539480604C
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CAC1C210AB
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31A6EB63;
	Tue,  5 Dec 2023 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTgm8wyJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233F21A3;
	Tue,  5 Dec 2023 13:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810671; x=1733346671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9j8qTLrfqLKrq4maRhdtYEicrJnt7F+CXYmcKq7uhZY=;
  b=fTgm8wyJkcry/qetom0tJmQAMWNS+d4DtZmvLGbYEx8JJ7K6QGe86aUe
   801n8d+8LBTj6G+J/q8wtgH0uw1gsqQ1tpKjVwkt3TksKWQOolsV+cPIJ
   6ca4fyx3NQaXSllp7rO7kQ4WHAtrp3f6cu25dViL4nst6Ca8cK5PUFMOd
   2mZOfPS1/5TIN1Lo+j2xoog6BdpCN8h2P0vVMcJRN0AwskCVJ4vSXXPET
   NGNXhKySCeu4qyeA6AtWt5OfI8YIFRaH8At2/fUys8y6wwH3Jp+PrAV05
   SarVi3mti6R8W/3Mu61k9fJZp5SUE5qLpn3MrdDV/2cwCgnPHq4mixJ1O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373421917"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="373421917"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:11:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774757787"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="774757787"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2023 13:11:04 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1972D34328;
	Tue,  5 Dec 2023 21:11:00 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v8 07/18] xsk: add functions to fill control buffer
Date: Tue,  5 Dec 2023 22:08:36 +0100
Message-ID: <20231205210847.28460-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205210847.28460-1-larysa.zaremba@intel.com>
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk") has added
a buffer for custom data to xdp_buff_xsk. Particularly, this memory is used
for data, consumed by XDP hints kfuncs. It does not always change on
a per-packet basis and some parts can be set for example, at the same time
as RX queue info.

Add functions to fill all cbs in xsk_buff_pool with the same metadata.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 include/net/xdp_sock_drv.h  | 17 +++++++++++++++++
 include/net/xsk_buff_pool.h |  2 ++
 net/xdp/xsk_buff_pool.c     | 12 ++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 81e02de3f453..b62bb8525a5f 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -14,6 +14,12 @@
 
 #ifdef CONFIG_XDP_SOCKETS
 
+struct xsk_cb_desc {
+	void *src;
+	u8 off;
+	u8 bytes;
+};
+
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
@@ -47,6 +53,12 @@ static inline void xsk_pool_set_rxq_info(struct xsk_buff_pool *pool,
 	xp_set_rxq_info(pool, rxq);
 }
 
+static inline void xsk_pool_fill_cb(struct xsk_buff_pool *pool,
+				    struct xsk_cb_desc *desc)
+{
+	xp_fill_cb(pool, desc);
+}
+
 static inline unsigned int xsk_pool_get_napi_id(struct xsk_buff_pool *pool)
 {
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -274,6 +286,11 @@ static inline void xsk_pool_set_rxq_info(struct xsk_buff_pool *pool,
 {
 }
 
+static inline void xsk_pool_fill_cb(struct xsk_buff_pool *pool,
+				    struct xsk_cb_desc *desc)
+{
+}
+
 static inline unsigned int xsk_pool_get_napi_id(struct xsk_buff_pool *pool)
 {
 	return 0;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 8d48d37ab7c0..99dd7376df6a 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -12,6 +12,7 @@
 
 struct xsk_buff_pool;
 struct xdp_rxq_info;
+struct xsk_cb_desc;
 struct xsk_queue;
 struct xdp_desc;
 struct xdp_umem;
@@ -135,6 +136,7 @@ static inline void xp_init_xskb_dma(struct xdp_buff_xsk *xskb, struct xsk_buff_p
 
 /* AF_XDP ZC drivers, via xdp_sock_buff.h */
 void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq);
+void xp_fill_cb(struct xsk_buff_pool *pool, struct xsk_cb_desc *desc);
 int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 	       unsigned long attrs, struct page **pages, u32 nr_pages);
 void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 4f6f538a5462..28711cc44ced 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -125,6 +125,18 @@ void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq)
 }
 EXPORT_SYMBOL(xp_set_rxq_info);
 
+void xp_fill_cb(struct xsk_buff_pool *pool, struct xsk_cb_desc *desc)
+{
+	u32 i;
+
+	for (i = 0; i < pool->heads_cnt; i++) {
+		struct xdp_buff_xsk *xskb = &pool->heads[i];
+
+		memcpy(xskb->cb + desc->off, desc->src, desc->bytes);
+	}
+}
+EXPORT_SYMBOL(xp_fill_cb);
+
 static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
 {
 	struct netdev_bpf bpf;
-- 
2.41.0


