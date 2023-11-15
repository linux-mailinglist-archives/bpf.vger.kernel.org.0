Return-Path: <bpf+bounces-15115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A67ECA0C
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 18:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9726928148F
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCCA446C9;
	Wed, 15 Nov 2023 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjS2sS8g"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F9D196;
	Wed, 15 Nov 2023 09:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700070906; x=1731606906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSLXy1BW6cJ3lWRjLoIRRFE1ix4RmNuNmYE81gRdDDI=;
  b=GjS2sS8gvcGu4Kztz3hL/LJV7605buGFsaMkbm8167XSQq1Jf2PtIw00
   5BR676h9+582JTmuNgviIB3F9j0t8E9VcdNx2y3oYAy0Myt6SBEVNEYKM
   EEqKilLbViJPcnvzx61nL+uUx+YbtH+7jkFO0WEKtHpQEWS6nUtvjvd/l
   S0I/SoFXkyNt6uTOL6BjY+H/L2EG96QYGY+SS2xB9hS5zhoxAiQ2qT/Ix
   SHIOuvnVEXOdcOWoAPhQ6qecLkajbJgUQa2KL8+FSrTPu4hF46Xq7Xrjm
   n7GwCx2zk69u4sVvljmKlltScE0Rtw8fP2/sYCvDqwv2989S5VNwNPVJ6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="375965587"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="375965587"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:55:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="855720085"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="855720085"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2023 09:55:00 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DE04C3683D;
	Wed, 15 Nov 2023 17:54:57 +0000 (GMT)
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
Subject: [PATCH bpf-next v7 14/18] mlx5: implement VLAN tag XDP hint
Date: Wed, 15 Nov 2023 18:52:56 +0100
Message-ID: <20231115175301.534113-15-larysa.zaremba@intel.com>
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

Implement the newly added .xmo_rx_vlan_tag() hint function.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 15 +++++++++++++++
 include/linux/mlx5/device.h                      |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 7decc81ed33a..9a9f78d1c6c7 100644
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
 
 /* returns true if packet was consumed by xdp */
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


