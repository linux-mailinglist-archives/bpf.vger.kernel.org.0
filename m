Return-Path: <bpf+bounces-8520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764A87878EF
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D60281689
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 19:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C211F193;
	Thu, 24 Aug 2023 19:34:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1A1ED2B;
	Thu, 24 Aug 2023 19:34:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045E31B0;
	Thu, 24 Aug 2023 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692905682; x=1724441682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v/9+YLj8PObvke9lo18PPjjZWs72+cBmo3t7jVTPzqc=;
  b=LMe1oWgGWDpyk8WyF/0HSHPwB7urQMe+h4Z9Xzb7bJACUZHJ50sgbIN0
   YuSnMK1raxjPwjLDXwvkFpfn+usEJAtPODks3BB1UD4+4Oh4c7suPNOcF
   z2yYTvOOfk0SKQrf7KlWBsOjDQo/IIr6b3rGhbmtRXPhseBajMSuLr1d+
   3kPhL4oMU55pRRV5HmWOiNlNDg6MWXFI0LpYGlaelBbLRMJ5quY8xzU0u
   yXhKH4hqbGV06Qr8Cc7jVEoVVIxclqx+DkrAHjdaOHEh2kV1XJbdBScl4
   W8H1aKJgbbMXR0SvAdf+l/BqMwHViV1DTdlH+Xf2SEgSwE8jCQDQjkaLc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354865516"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354865516"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 12:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="860830592"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860830592"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2023 12:34:36 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 347183491F;
	Thu, 24 Aug 2023 20:34:34 +0100 (IST)
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
Subject: [RFC bpf-next 22/23] mlx5: implement VLAN tag XDP hint
Date: Thu, 24 Aug 2023 21:27:01 +0200
Message-ID: <20230824192703.712881-23-larysa.zaremba@intel.com>
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

Implement the newly added .xmo_rx_vlan_tag() hint function.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 15 +++++++++++++++
 include/linux/mlx5/device.h                      |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 12f56d0db0af..e8319ab0fa85 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -256,9 +256,24 @@ static int mlx5e_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+static int mlx5e_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci,
+				 __be16 *vlan_proto)
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
index 93399802ba77..95ffd78546a7 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -913,7 +913,7 @@ static inline u8 get_cqe_tls_offload(struct mlx5_cqe64 *cqe)
 	return (cqe->tls_outer_l3_tunneled >> 3) & 0x3;
 }
 
-static inline bool cqe_has_vlan(struct mlx5_cqe64 *cqe)
+static inline bool cqe_has_vlan(const struct mlx5_cqe64 *cqe)
 {
 	return cqe->l4_l3_hdr_type & 0x1;
 }
-- 
2.41.0


