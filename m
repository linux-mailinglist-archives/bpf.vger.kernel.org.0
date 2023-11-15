Return-Path: <bpf+bounces-15107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003DB7EC9FB
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 18:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA061F22C4F
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EB14177E;
	Wed, 15 Nov 2023 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dn4EPL3T"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072B1196;
	Wed, 15 Nov 2023 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700070887; x=1731606887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2XBORvBSn1xwXCNwHQn6EmVUzRqirjF1bywIM1yr48Y=;
  b=Dn4EPL3TmFToM2O8YL1M5ISMEqpFIhIsHngfY2A7nyDrDOFNridffii0
   QMEy3Bl8CkxHFh134xOt/FbZEciDZcQUH//C855sPIb5T7f8iJAxn6jfT
   lIilAPkPhFxTSNktQukGEkNSOoOKJlf44squgF/cMISOqzs94I6aeraR9
   x7tAXhw9UVHSfFsn8J4fE55VHb2LI0LoOfoU6+yQhnj6ZReO9Oh5Imw9b
   tdLB/LgK3ffUcKq0J6I6Ls55m5FZf0dOK6SQfyqIcReIvd8z4iWEyR+hP
   funPRkn9ShBlUAWHP3sRXVFaYZaG23VO7pl/CwRjPDA6uvqww+prnpWJ/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422020519"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="422020519"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:54:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12842630"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 15 Nov 2023 09:54:40 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 97B8237212;
	Wed, 15 Nov 2023 17:54:37 +0000 (GMT)
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
Subject: [PATCH bpf-next v7 07/18] xsk: add functions to fill control buffer
Date: Wed, 15 Nov 2023 18:52:49 +0100
Message-ID: <20231115175301.534113-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115175301.534113-1-larysa.zaremba@intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
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
index 1f6fc8c7a84c..6239c37dba5d 100644
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
@@ -250,6 +262,11 @@ static inline void xsk_pool_set_rxq_info(struct xsk_buff_pool *pool,
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
index b0bdff26fc88..f17793ee35d6 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -12,6 +12,7 @@
 
 struct xsk_buff_pool;
 struct xdp_rxq_info;
+struct xsk_cb_desc;
 struct xsk_queue;
 struct xdp_desc;
 struct xdp_umem;
@@ -132,6 +133,7 @@ static inline void xp_init_xskb_dma(struct xdp_buff_xsk *xskb, struct xsk_buff_p
 
 /* AF_XDP ZC drivers, via xdp_sock_buff.h */
 void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq);
+void xp_fill_cb(struct xsk_buff_pool *pool, struct xsk_cb_desc *desc);
 int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 	       unsigned long attrs, struct page **pages, u32 nr_pages);
 void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 49cb9f9a09be..a94581041c2c 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -123,6 +123,18 @@ void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq)
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


