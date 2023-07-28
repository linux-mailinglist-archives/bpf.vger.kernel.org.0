Return-Path: <bpf+bounces-6250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95CD7673F1
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73080281FB6
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B47622EF9;
	Fri, 28 Jul 2023 17:44:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7B22EF4;
	Fri, 28 Jul 2023 17:44:46 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EEB19B;
	Fri, 28 Jul 2023 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690566285; x=1722102285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w00SflrFjEy5duFNVMvx/HixptvAurNMTPG3+nsIXKc=;
  b=CFqvOSgVjxca6iwoqlOf6CYRUNDdmfzJ8hRgv5IKOkNb9IqY+NfH5sq8
   9VQi4csPd0cYcEhfdz4HRy+ZJUYgeemEUawjWKAsPtHO/BLDqcm9zwukW
   rBZFm1eG/1PRPPn6Ne7NLVCC+1QTvjEgwpRMShgtEgQeFcdgtm/Jj+nC/
   W49gCSpVHB5BMNxP92oLdXG1IeGzN4QwPVm8R4m3AXh5xITKZKY60DuII
   Zy2LmdGD+u56vAWhfhyuxcROM85Wymo/uu0CCBRgM0nOYg6tuIbqZeTgA
   YY5YVs6Rz2J1bo40Cd0wBR1yHTBDO6gIpdvbzcpKyhOw2z4fz0Sa6uLVG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="367530970"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="367530970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="757254508"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="757254508"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2023 10:44:39 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6B50537E1F;
	Fri, 28 Jul 2023 18:44:37 +0100 (IST)
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
Subject: [PATCH bpf-next v4 17/21] veth: Implement VLAN tag and checksum XDP hint
Date: Fri, 28 Jul 2023 19:39:19 +0200
Message-ID: <20230728173923.1318596-18-larysa.zaremba@intel.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In order to test VLAN tag and checksum XDP hints in hardware-independent
selftests, implement newly added XDP hints in veth driver.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/veth.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..13933f080dcd 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1732,6 +1732,50 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci,
+				__be16 *vlan_proto)
+{
+	struct veth_xdp_buff *_ctx = (void *)ctx;
+	struct sk_buff *skb = _ctx->skb;
+	int err;
+
+	if (!skb)
+		return -ENODATA;
+
+	err = __vlan_hwaccel_get_tag(skb, vlan_tci);
+	if (err)
+		return err;
+
+	*vlan_proto = skb->vlan_proto;
+	return err;
+}
+
+static int veth_xdp_rx_csum(const struct xdp_md *ctx,
+			    enum xdp_csum_status *csum_status,
+			    union xdp_csum_info *csum_info)
+{
+	struct veth_xdp_buff *_ctx = (void *)ctx;
+	struct sk_buff *skb = _ctx->skb;
+
+	if (!skb)
+		return -ENODATA;
+
+	if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
+		*csum_status = XDP_CHECKSUM_VALID_LVL0 + skb->csum_level;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		*csum_status = XDP_CHECKSUM_PARTIAL;
+		csum_info->csum_start = skb_checksum_start_offset(skb);
+		csum_info->csum_offset = skb->csum_offset;
+	} else if (skb->ip_summed == CHECKSUM_COMPLETE) {
+		*csum_status = XDP_CHECKSUM_COMPLETE;
+		csum_info->checksum = skb->csum;
+	} else {
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1756,6 +1800,8 @@ static const struct net_device_ops veth_netdev_ops = {
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
+	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_csum			= veth_xdp_rx_csum,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.41.0


