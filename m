Return-Path: <bpf+bounces-16804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6CE806063
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CA928200F
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11ED6F638;
	Tue,  5 Dec 2023 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfZAnvZ0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF75918F;
	Tue,  5 Dec 2023 13:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810693; x=1733346693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PzgpWzlBPks4Kx6qHpW0WR8MQUw4c4t005R0l2P5V9A=;
  b=WfZAnvZ0ngkcSIWgBTbla4p0i8wS+AnJlcg1c7KpAwxMjawiMCI0uPkk
   +ZJC71xJqWI1WqVbBlvoEVdEW6xsoieW7BwiAu4zBiiWt1W2b281SR9wa
   1x74vlKfwSfrAQ92huaVPJhudcQjJjVNuqWgmn+y9mSez1NIFhXa9rGQm
   IAFMqv8XrP4CztVLDYdjJJ49TaKSizl7kGkBC/PzUOhy/E+CSrr/dgRnX
   HwCvG7qB8JiJJZg4VkbUtY/unjDqAkczz/Fx91afCIf6YlLgfclDtcEPD
   dnLJrRdkX1fBahO3RVcdnZqbUcANtXf7WA4gKNja3nsFYC7GHaLbX4Llr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392827529"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="392827529"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:11:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="764464724"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="764464724"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2023 13:11:24 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5C4A634328;
	Tue,  5 Dec 2023 21:11:22 +0000 (GMT)
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH bpf-next v8 14/18] mlx5: implement VLAN tag XDP hint
Date: Tue,  5 Dec 2023 22:08:43 +0100
Message-ID: <20231205210847.28460-15-larysa.zaremba@intel.com>
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

Implement the newly added .xmo_rx_vlan_tag() hint function.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 15 +++++++++++++++
 include/linux/mlx5/device.h                      |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index e2e7d82cfca4..9e695ed122ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -256,9 +256,24 @@ static int mlx5e_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+static int mlx5e_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
+				 u16 *vlan_tci)
+{
+	const struct mlx5e_xdp_buff *_ctx = (void *)ctx;
+	const struct mlx5_cqe64 *cqe = _ctx->cqe;
+
+	if (!cqe_has_vlan(cqe))
+		return -ENODATA;
+
+	*vlan_proto = htons(ETH_P_8021Q);
+	*vlan_tci = be16_to_cpu(cqe->vlan_info);
+	return 0;
+}
+
 const struct xdp_metadata_ops mlx5e_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= mlx5e_xdp_rx_timestamp,
 	.xmo_rx_hash			= mlx5e_xdp_rx_hash,
+	.xmo_rx_vlan_tag		= mlx5e_xdp_rx_vlan_tag,
 };
 
 struct mlx5e_xsk_tx_complete {
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 820bca965fb6..01275c6e8468 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -918,7 +918,7 @@ static inline u8 get_cqe_tls_offload(struct mlx5_cqe64 *cqe)
 	return (cqe->tls_outer_l3_tunneled >> 3) & 0x3;
 }
 
-static inline bool cqe_has_vlan(struct mlx5_cqe64 *cqe)
+static inline bool cqe_has_vlan(const struct mlx5_cqe64 *cqe)
 {
 	return cqe->l4_l3_hdr_type & 0x1;
 }
-- 
2.41.0


