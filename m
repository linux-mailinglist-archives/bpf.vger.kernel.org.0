Return-Path: <bpf+bounces-15113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B387ECA08
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 18:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB271F27F10
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7121B364D5;
	Wed, 15 Nov 2023 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jzx+Obj/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FB11A8;
	Wed, 15 Nov 2023 09:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700070900; x=1731606900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j6gwKVjN5zDhrI8Qg8CP0sWoCX1TV6Jz0KKQcNP7yvU=;
  b=Jzx+Obj/iykFKydCb6vc8diFoaw4OszjBLOVoOvAfpuVjbTxM/NK290d
   gI5POZHI1Ox/G6l4mWohkto4K7n2sJGYtYilkMEI1fm0csb+NvG/VYYkS
   jRg9l/+QmFQKwrM7A6a9w/JABUPp/f2Lwg/bqxAYioOWbLOipx2gVVBBl
   DLIKuEJy4isjJLH02dlQcLSE1exdyKyz3w3Cnzlu+Mq1X4BUXYR0rH/hI
   vDdmoCNT1zR9N1B1R5bkSALT2V85wF8hrxtHxaiEGuV/gtMVc8KBMrQP0
   beKE1RXnldxC4V+5PDl2g36tnDV1jb97pz5X1HxSjOR2a2wPyHH0/nHat
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="375965548"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="375965548"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="855719970"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="855719970"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2023 09:54:54 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 800703581F;
	Wed, 15 Nov 2023 17:54:51 +0000 (GMT)
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
Subject: [PATCH bpf-next v7 12/18] veth: Implement VLAN tag XDP hint
Date: Wed, 15 Nov 2023 18:52:54 +0100
Message-ID: <20231115175301.534113-13-larysa.zaremba@intel.com>
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

In order to test VLAN tag hint in hardware-independent selftests, implement
newly added hint in veth driver.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/veth.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 9980517ed8b0..b6617784e7d3 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1743,6 +1743,24 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
+				u16 *vlan_tci)
+{
+	const struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct sk_buff *skb = _ctx->skb;
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
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1767,6 +1785,7 @@ static const struct net_device_ops veth_netdev_ops = {
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
+	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.41.0


