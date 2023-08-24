Return-Path: <bpf+bounces-8515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1270C7878D7
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435631C20D24
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7224D1E538;
	Thu, 24 Aug 2023 19:34:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0111E506;
	Thu, 24 Aug 2023 19:34:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392541B0;
	Thu, 24 Aug 2023 12:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692905670; x=1724441670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CUxxhqkl+Ex1qgH0qus/XMXsPO/e1+lJ9YTcuZMfzCQ=;
  b=k2MlM0lLJ4HqtMEZVasCgULlXLODpD3xZna31yXfXtwJYMkts8u+lnsJ
   XKJ5QHHeyvFe0hvMhyniRwyMHcLQ3R7UV1s0GFEk62nWaJnmraNeNGZg0
   jMraOWWkJoEBCqDUjLp76519UizUWJceMXCV6deAQtFixTcNgL2Kqo2Wa
   75lsrGIOElvDYWZfUhHwxJ+4F5hY7eE2IeU0qz5W+USPioW+VU2fM9Q4m
   yRMpf/YyVAF5mp/dlpcK6f3deCbnQmtxKXYOqxUAzb1XXBzpn/YBp2l7v
   EBWQVmvdeqw84pJVfaYc6WcIAQbAp733q88T0zPFhwr8+oTzSxVJoTiww
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354865424"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354865424"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 12:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="860830560"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860830560"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2023 12:34:23 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 37B3A33EAF;
	Thu, 24 Aug 2023 20:34:22 +0100 (IST)
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
Subject: [RFC bpf-next 17/23] veth: Implement VLAN tag and checksum XDP hint
Date: Thu, 24 Aug 2023 21:26:56 +0200
Message-ID: <20230824192703.712881-18-larysa.zaremba@intel.com>
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

In order to test VLAN tag and checksum XDP hints in hardware-independent
selftests, implement newly added XDP hints in veth driver.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/veth.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 953f6d8f8db0..f3ee85aa5edf 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1732,6 +1732,46 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
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
+			    __wsum *csum)
+{
+	struct veth_xdp_buff *_ctx = (void *)ctx;
+	struct sk_buff *skb = _ctx->skb;
+
+	if (!skb)
+		return -ENODATA;
+
+	if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
+		*csum_status = XDP_CHECKSUM_VERIFIED;
+	} else if (skb->ip_summed == CHECKSUM_COMPLETE) {
+		*csum_status = XDP_CHECKSUM_COMPLETE;
+		*csum = skb->csum;
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
@@ -1756,6 +1796,8 @@ static const struct net_device_ops veth_netdev_ops = {
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
+	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_csum			= veth_xdp_rx_csum,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.41.0


