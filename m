Return-Path: <bpf+bounces-3910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA36A74624F
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769DD280633
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13891801A;
	Mon,  3 Jul 2023 18:17:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6117FEB;
	Mon,  3 Jul 2023 18:17:38 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480F110C3;
	Mon,  3 Jul 2023 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688408252; x=1719944252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zFzZS0DIjk+EeZetggvdiNMpIpl+LFuLCTSvigsfImk=;
  b=AFCRw5rY++N7iPTLGq2nN7a7IS/6w8FRMNY4Nalt9vNZ3jg+86cwvMck
   DBFG+jVo2HefnsWQw322XJx2IYaPkj3ZWAaD3HlC7mw2WHpbcYDUR0I5U
   a65hS6L2+i4Jz7m2byHiBecEPGXMMhpdpZyyMAeJy4GaEwfX0dZ576kmi
   SCzzBvWV0unAkLS9L7J/tXgKhmSJKEm1UxTpaZHKvcwO1/s6HBslQQu3l
   bgw0/hF5yYBLQxBXqt3VWGan5FAgkrZX5UUhbKsYM8BJ+6vxfBD2PQSje
   BfIVq0O/tgkgf+IclFdLWR101haYCJ2td+6Yq/IW22PS45xYILO9N5Z79
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393682733"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="393682733"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="892615164"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="892615164"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2023 11:17:15 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 58A8635803;
	Mon,  3 Jul 2023 19:17:14 +0100 (IST)
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
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 17/20] veth: Implement VLAN tag and checksum level XDP hint
Date: Mon,  3 Jul 2023 20:12:23 +0200
Message-ID: <20230703181226.19380-18-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703181226.19380-1-larysa.zaremba@intel.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In order to test VLAN tag and checksum level XDP hints in
hardware-independent selfttests, implement newly added XDP hints in veth
driver.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/veth.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..a7f2b679551d 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1732,6 +1732,44 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tag,
+				__be16 *vlan_proto)
+{
+	struct veth_xdp_buff *_ctx = (void *)ctx;
+	struct sk_buff *skb = _ctx->skb;
+	int err;
+
+	if (!skb)
+		return -ENODATA;
+
+	err = __vlan_hwaccel_get_tag(skb, vlan_tag);
+	if (err)
+		return err;
+
+	*vlan_proto = skb->vlan_proto;
+	return err;
+}
+
+static int veth_xdp_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
+{
+	struct veth_xdp_buff *_ctx = (void *)ctx;
+	struct sk_buff *skb = _ctx->skb;
+
+	if (!skb)
+		return -ENODATA;
+
+	if (skb->ip_summed == CHECKSUM_UNNECESSARY)
+		*csum_level = skb->csum_level;
+	else if (skb->ip_summed == CHECKSUM_PARTIAL &&
+		 skb_checksum_start_offset(skb) == skb_transport_offset(skb) ||
+		 skb->csum_valid)
+		*csum_level = 0;
+	else
+		return -ENODATA;
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1756,6 +1794,8 @@ static const struct net_device_ops veth_netdev_ops = {
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
+	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_csum_lvl		= veth_xdp_rx_csum_lvl,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.41.0


