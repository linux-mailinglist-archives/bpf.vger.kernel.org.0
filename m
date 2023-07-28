Return-Path: <bpf+bounces-6247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7887673DE
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193DD1C21343
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D1D21511;
	Fri, 28 Jul 2023 17:44:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B4214FA;
	Fri, 28 Jul 2023 17:44:43 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF219B;
	Fri, 28 Jul 2023 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690566282; x=1722102282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ilvtgIUqJ5hEp3FeBkpAW9MohoyE2wINrHeApnNuVy8=;
  b=TQpie49mhhUoRDOLbR8dxmdzXmOSQWnOmlfTU8C6Ox/Wk5fN8ShrNC2n
   YdjqvOF44No5YKNga24n5b6b4iYiWdhP2XaW1ZzBGqq0qTtyApdA2mgw3
   TOsNB244yacxqwPXey8HguiXFkloQU2cSVCeSAhKjfIPVQroSIwtHOUhl
   zs9+PY+IUMiLb9ltCxAyfyCBubOyHas35X0tz7hb2NhcWDFjDKQpQCiY0
   K5I8QIfTXSEbFqNd1WfnDgA4WOXY+Ldeq9u/5s5pxo+WmVRwFwfFB/HTG
   l4haVz9xTqb9jN/kSYwx0cmFDlkcLU3S+8fpLiYsDBAmjDSO4NlkRK3O2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="366117456"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="366117456"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="851294678"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851294678"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 10:44:30 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C0E51386B4;
	Fri, 28 Jul 2023 18:44:28 +0100 (IST)
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
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH bpf-next v4 13/21] ice: Implement checksum hint
Date: Fri, 28 Jul 2023 19:39:15 +0200
Message-ID: <20230728173923.1318596-14-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728173923.1318596-1-larysa.zaremba@intel.com>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement .xmo_rx_csum callback to allow XDP code to determine,
whether HW has validated any checksums.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 6ae57a98a4d8..e7a7c8e536b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -660,8 +660,37 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci,
 	return 0;
 }
 
+/**
+ * ice_xdp_rx_csum_lvl - Get level, at which HW has checked the checksum
+ * @ctx: XDP buff pointer
+ * @csum_status: destination address
+ * @csum_info: destination address
+ *
+ * Copy HW checksum level (if was checked) to the destination address.
+ */
+static int ice_xdp_rx_csum(const struct xdp_md *ctx,
+			   enum xdp_csum_status *csum_status,
+			   union xdp_csum_info *csum_info)
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
+	if (status & ICE_RX_CSUM_NONE)
+		return -ENODATA;
+
+	*csum_status = XDP_CHECKSUM_VALID_LVL0 + ice_rx_csum_lvl(status);
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


