Return-Path: <bpf+bounces-8511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE107878CC
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E64E1C20DD9
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 19:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D92E1DA43;
	Thu, 24 Aug 2023 19:34:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845F168CF;
	Thu, 24 Aug 2023 19:34:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8D51B0;
	Thu, 24 Aug 2023 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692905662; x=1724441662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MrzRG4al62OiD9VEbOJ+kaeSZbDEICc4yRM2zQdS+Vw=;
  b=D0wuxCKilVOQqaMMJAGSn08UYgUPwIbLXWo7s9G+najmHd7JwYwmq5NG
   fj8bp4CWrjlhvASYrOKWMhV8r454JKURsf/FpZX1stPGnok9U3/e6s25X
   yrmThMZ8Yz3qCsTVQFmHzHPZf0fPGUcMe1ccvIV5qiWwG5Tral2qr5BLR
   Ak9ASlNqzqDQUCjL5CCKoZfP2avlmxmNxEk7JYcVTbMaHdIUO8c9RfmE2
   U8kc/PmNoOdxlw0JqwWgfS6hbwDetToQJD1vNW+Az0Pwz3lOWL4oFahsB
   6YuGo6gUbZ2AHeGA0pmg53od0++FQtRgLiyrkGrk+bdZChTc09sEhEdTb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354865346"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354865346"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 12:34:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="860830546"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860830546"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2023 12:34:15 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6E8AE3494D;
	Thu, 24 Aug 2023 20:34:13 +0100 (IST)
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
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [RFC bpf-next 13/23] ice: Implement checksum hint
Date: Thu, 24 Aug 2023 21:26:52 +0200
Message-ID: <20230824192703.712881-14-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824192703.712881-1-larysa.zaremba@intel.com>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement .xmo_rx_csum callback to allow XDP code to determine,
whether HW has validated any checksums.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 6ae57a98a4d8..f11a245705bc 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -660,8 +660,34 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci,
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


