Return-Path: <bpf+bounces-10934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AE07AFD4E
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 09:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8431A283A51
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D1B1D68A;
	Wed, 27 Sep 2023 07:58:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F01D52D;
	Wed, 27 Sep 2023 07:58:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2655B1A6;
	Wed, 27 Sep 2023 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801501; x=1727337501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=03LkefjeBenrPX6vZKJMBeEVffbM4VKuslv0KH2qVIM=;
  b=ac6M57LM0FSd9cm6SyeD0fMravgHHnYUA48h/PibFC1sTuMS1SwM1JF+
   uVQ3gATCMVd3ZsyN+y4yIheDjTozsvLdzRbwyTfxvPmHi5BDBJqANTVRc
   MNFicoj0AC7iWmo3w6U+u634WcL0e3vU0HjjJEIGL38RCeJbJ+VUSvNwu
   FSQSwoJXmGu0FkT6i7LI+EfpNv6O7R+3J6PL8XyYm+BtCmjxIjRZ1g0jo
   /iMugHnRi2r4muObljGD8LuGoiwWphbH2p8PpFblJPjAncJDyU4uuC5sb
   2nLyupHNROdt1qu1RfDc3Yiwj6AcLl9I4CQp+mfwZwpuJ/zuxhH348AF6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366818094"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366818094"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725714048"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="725714048"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2023 00:58:13 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 965B97EAC1;
	Wed, 27 Sep 2023 08:58:11 +0100 (IST)
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
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [RFC bpf-next v2 13/24] ice: Implement checksum hint
Date: Wed, 27 Sep 2023 09:51:13 +0200
Message-ID: <20230927075124.23941-14-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927075124.23941-1-larysa.zaremba@intel.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement .xmo_rx_csum callback to allow XDP code to determine,
whether HW has validated any checksums.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index cc4ba7e995b7..5f12f67af85f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -647,8 +647,34 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return 0;
 }
 
+/**
+ * ice_xdp_rx_csum - RX checksum XDP hint handler
+ * @ctx: XDP buff pointer
+ * @csum_status: status destination address
+ * @csum: not used
+ */
+static int ice_xdp_rx_csum(const struct xdp_md *ctx,
+			   enum xdp_csum_status *csum_status, __wsum *csum)
+{
+	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+	const union ice_32b_rx_flex_desc *eop_desc;
+	enum ice_rx_csum_status status;
+	u16 ptype;
+
+	eop_desc = xdp_ext->pkt_ctx.eop_desc;
+	ptype = ice_get_ptype(eop_desc);
+
+	status = ice_get_rx_csum_status(eop_desc, ptype);
+	if (status & ICE_RX_CSUM_FAIL)
+		return -ENODATA;
+
+	*csum_status = XDP_CHECKSUM_VERIFIED;
+	return 0;
+}
+
 const struct xdp_metadata_ops ice_xdp_md_ops = {
 	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
 	.xmo_rx_hash			= ice_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
+	.xmo_rx_csum			= ice_xdp_rx_csum,
 };
-- 
2.41.0


