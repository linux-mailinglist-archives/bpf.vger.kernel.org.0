Return-Path: <bpf+bounces-16798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051C480604F
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34B7281EC8
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E66EB74;
	Tue,  5 Dec 2023 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8CcjOU7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C527618B;
	Tue,  5 Dec 2023 13:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810673; x=1733346673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Brl6QUkDRxqwdZEr3xIXm0DcfqXL1tvrj7z2zvu2s9Q=;
  b=Z8CcjOU7dmQBPkRz8gzPRoaHBn2u0flATaYvZgR40GP5fWH2JXqhcXnk
   h4OBjH6gqAhFc68jJMfBqKnfJUetCpL9YOPavHn4CiEL/4SUiZLmNkstP
   0F5HwEGQhiqTVNewWJDNAVmzHJhHCtPZl/J8H51h8Bdtrcr9tg1toK0RP
   AmHvVI4Yz5bVt1RN7rVzFRZkWjY694/bH5mkQMk6fdzzqEmvjQW+i748U
   iRJPHrzirAQ7BBJYTjEMcnjud2g9e8u2z9gqE5dlAlme0hPuyFY/JRA8r
   +7DwDc+xuaB7F7Xwz+GKAt50zkQbGg9PdlgtKu5TsSxqwQkKTSYgXksAa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373421928"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="373421928"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:11:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774757801"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="774757801"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2023 13:11:07 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C8B1734338;
	Tue,  5 Dec 2023 21:11:03 +0000 (GMT)
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
Subject: [PATCH bpf-next v8 08/18] ice: Support XDP hints in AF_XDP ZC mode
Date: Tue,  5 Dec 2023 22:08:37 +0100
Message-ID: <20231205210847.28460-9-larysa.zaremba@intel.com>
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

In AF_XDP ZC, xdp_buff is not stored on ring,
instead it is provided by xsk_buff_pool.
Space for metadata sources right after such buffers was already reserved
in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").

Some things (such as pointer to packet context) do not change on a
per-packet basis, so they can be set at the same time as RX queue info.
On the other hand, RX descriptor is unique for each packet, but is already
known when setting DMA addresses. This minimizes performance impact of
hints on regular packet processing.

Update AF_XDP ZC packet processing to support XDP hints.

Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 14 ++++++++++++++
 drivers/net/ethernet/intel/ice/ice_xsk.c  |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 2d83f3c029e7..a040f02a342e 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -519,6 +519,19 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	return 0;
 }
 
+static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
+{
+	void *ctx_ptr = &ring->pkt_ctx;
+	struct xsk_cb_desc desc = {};
+
+	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
+	desc.src = &ctx_ptr;
+	desc.off = offsetof(struct ice_xdp_buff, pkt_ctx) -
+		   sizeof(struct xdp_buff);
+	desc.bytes = sizeof(ctx_ptr);
+	xsk_pool_fill_cb(ring->xsk_pool, &desc);
+}
+
 /**
  * ice_vsi_cfg_rxq - Configure an Rx queue
  * @ring: the ring being configured
@@ -553,6 +566,7 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			if (err)
 				return err;
 			xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
+			ice_xsk_pool_fill_cb(ring);
 
 			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
 				 ring->q_index);
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 906e383e864a..11b6114ab83d 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -458,6 +458,11 @@ static u16 ice_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
 		rx_desc->read.pkt_addr = cpu_to_le64(dma);
 		rx_desc->wb.status_error0 = 0;
 
+		/* Put private info that changes on a per-packet basis
+		 * into xdp_buff_xsk->cb.
+		 */
+		ice_xdp_meta_set_desc(*xdp, rx_desc);
+
 		rx_desc++;
 		xdp++;
 	}
-- 
2.41.0


