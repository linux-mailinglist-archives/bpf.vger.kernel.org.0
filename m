Return-Path: <bpf+bounces-10945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5627AFD6C
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 09:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2DA65284B34
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C85208C4;
	Wed, 27 Sep 2023 07:58:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4441D53F;
	Wed, 27 Sep 2023 07:58:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D28A126;
	Wed, 27 Sep 2023 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801523; x=1727337523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x8lW1juYjWSYOWLt8EtR7D38LHmGWtHNirCMAwpnvV8=;
  b=iKRQx1mwJz8FtycHzbgGu5YEySElLKAD34mlUpYplb5yy4cWbcpkpj7a
   5d81uxcohWh9ZlxiaW0g6fET69uCJngO9r01aONDMCV70qe+2AnE2rPu4
   leR2I4DuZlUV7YdOb9ahOAnxywYdXz1awMAAFtc1kBcziN+z+sC7b5yX/
   geiO18ojlTWar8tP13HatJ5PpnGZo2YohCenjByS7TFn5+W0B5Ai04KYJ
   ZndinME16TjqLQbmKBSCmAxddxnv0bGwrUCv9R5OyfGHFdlF3EnYi2VOu
   P7zAb6NAzSTKGV6UaJmbtqwuPtu+oqbInKn+LDbjSuZ92bqKiFJGTiJkc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366818307"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366818307"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:58:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725714106"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="725714106"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2023 00:58:35 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 927EC7EAC3;
	Wed, 27 Sep 2023 08:58:33 +0100 (IST)
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
Subject: [RFC bpf-next v2 24/24] mlx5: implement RX checksum XDP hint
Date: Wed, 27 Sep 2023 09:51:24 +0200
Message-ID: <20230927075124.23941-25-larysa.zaremba@intel.com>
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

Implement .xmo_rx_csum() callback to expose checksum information
to XDP code.

This version contains a lot of logic, duplicated from skb path, because
refactoring would be much more complex than implementation itself, checksum
code is too coupled with the skb concept.

Intended logic differences from the skb path:
- when checksum does not cover the whole packet, no fixups are performed,
  such packet is treated as one without complete checksum. Just to prevent
  the patch from ballooning from hints-unrelated code.
- with hints API, we can now inform about both complete and validated
  checksum statuses, that is why XDP_CHECKSUM_VERIFIED is ORed to the
  status. I hope this represents HW logic well.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  10 ++
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 100 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  12 +--
 include/linux/mlx5/device.h                   |   2 +-
 4 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 879d698b6119..9467a0dea6ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -506,4 +506,14 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw_info(struct mlx5e_rq *rq, int
 
 	return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array_size(i, isz));
 }
+
+static inline u8 get_ip_proto(void *data, int network_depth, __be16 proto)
+{
+	void *ip_p = data + network_depth;
+
+	return (proto == htons(ETH_P_IP)) ? ((struct iphdr *)ip_p)->protocol :
+					    ((struct ipv6hdr *)ip_p)->nexthdr;
+}
+
+#define short_frame(size) ((size) <= ETH_ZLEN + ETH_FCS_LEN)
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index d7cd14687ce8..d11a62cded2c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -270,10 +270,110 @@ static int mlx5e_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return 0;
 }
 
+static __be16 xdp_buff_last_ethertype(const struct xdp_buff *xdp,
+				      int *network_offset)
+{
+	__be16 proto = ((struct ethhdr *)xdp->data)->h_proto;
+	struct vlan_hdr *remaining_data = xdp->data + ETH_HLEN;
+	u8 allowed_depth = VLAN_MAX_DEPTH;
+
+	while (eth_type_vlan(proto)) {
+		struct vlan_hdr *next_data = remaining_data + 1;
+
+		if ((void *)next_data > xdp->data_end || !--allowed_depth)
+			return 0;
+		proto = remaining_data->h_vlan_encapsulated_proto;
+		remaining_data = next_data;
+	}
+
+	*network_offset = (void *)remaining_data - xdp->data;
+	return proto;
+}
+
+static bool xdp_csum_needs_fixup(const struct xdp_buff *xdp, int network_depth,
+				 __be16 proto)
+{
+	struct ipv6hdr *ip6;
+	struct iphdr   *ip4;
+	int pkt_len;
+
+	if (network_depth > ETH_HLEN)
+		return true;
+
+	switch (proto) {
+	case htons(ETH_P_IP):
+		ip4 = (struct iphdr *)(xdp->data + network_depth);
+		pkt_len = network_depth + ntohs(ip4->tot_len);
+		break;
+	case htons(ETH_P_IPV6):
+		ip6 = (struct ipv6hdr *)(xdp->data + network_depth);
+		pkt_len = network_depth + sizeof(*ip6) + ntohs(ip6->payload_len);
+		break;
+	default:
+		return true;
+	}
+
+	if (likely(pkt_len >= xdp->data_end - xdp->data))
+		return false;
+
+	return true;
+}
+
+static int mlx5e_xdp_rx_csum(const struct xdp_md *ctx,
+			     enum xdp_csum_status *csum_status,
+			     __wsum *csum)
+{
+	const struct mlx5e_xdp_buff *_ctx = (void *)ctx;
+	const struct mlx5_cqe64 *cqe = _ctx->cqe;
+	const struct mlx5e_rq *rq = _ctx->rq;
+	__be16 last_ethertype;
+	int network_offset;
+	u8 lro_num_seg;
+
+	lro_num_seg = be32_to_cpu(cqe->srqn) >> 24;
+	if (lro_num_seg) {
+		*csum_status = XDP_CHECKSUM_VERIFIED;
+		return 0;
+	}
+
+	if (test_bit(MLX5E_RQ_STATE_NO_CSUM_COMPLETE, &rq->state) ||
+	    get_cqe_tls_offload(cqe))
+		goto csum_unnecessary;
+
+	if (short_frame(ctx->data_end - ctx->data))
+		goto csum_unnecessary;
+
+	last_ethertype = xdp_buff_last_ethertype(&_ctx->xdp, &network_offset);
+	if (last_ethertype != htons(ETH_P_IP) && last_ethertype != htons(ETH_P_IPV6))
+		goto csum_unnecessary;
+	if (unlikely(get_ip_proto(_ctx->xdp.data, network_offset,
+				  last_ethertype) == IPPROTO_SCTP))
+		goto csum_unnecessary;
+
+	*csum_status = XDP_CHECKSUM_COMPLETE;
+	*csum = csum_unfold((__force __sum16)cqe->check_sum);
+
+	if (test_bit(MLX5E_RQ_STATE_CSUM_FULL, &rq->state))
+		goto csum_unnecessary;
+
+	if (unlikely(xdp_csum_needs_fixup(&_ctx->xdp, network_offset,
+					  last_ethertype)))
+		*csum_status = 0;
+
+csum_unnecessary:
+	if (likely((cqe->hds_ip_ext & CQE_L3_OK) &&
+		   (cqe->hds_ip_ext & CQE_L4_OK))) {
+		*csum_status |= XDP_CHECKSUM_VERIFIED;
+	}
+
+	return *csum_status ? 0 : -ENODATA;
+}
+
 const struct xdp_metadata_ops mlx5e_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= mlx5e_xdp_rx_timestamp,
 	.xmo_rx_hash			= mlx5e_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= mlx5e_xdp_rx_vlan_tag,
+	.xmo_rx_csum			= mlx5e_xdp_rx_csum,
 };
 
 /* returns true if packet was consumed by xdp */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 3fd11b0761e0..c303ab8b928c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1374,16 +1374,6 @@ static inline void mlx5e_enable_ecn(struct mlx5e_rq *rq, struct sk_buff *skb)
 	rq->stats->ecn_mark += !!rc;
 }
 
-static u8 get_ip_proto(struct sk_buff *skb, int network_depth, __be16 proto)
-{
-	void *ip_p = skb->data + network_depth;
-
-	return (proto == htons(ETH_P_IP)) ? ((struct iphdr *)ip_p)->protocol :
-					    ((struct ipv6hdr *)ip_p)->nexthdr;
-}
-
-#define short_frame(size) ((size) <= ETH_ZLEN + ETH_FCS_LEN)
-
 #define MAX_PADDING 8
 
 static void
@@ -1493,7 +1483,7 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 		goto csum_unnecessary;
 
 	if (likely(is_last_ethertype_ip(skb, &network_depth, &proto))) {
-		if (unlikely(get_ip_proto(skb, network_depth, proto) == IPPROTO_SCTP))
+		if (unlikely(get_ip_proto(skb->data, network_depth, proto) == IPPROTO_SCTP))
 			goto csum_unnecessary;
 
 		stats->csum_complete++;
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 0805f8231452..26298c824050 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -911,7 +911,7 @@ static inline bool cqe_is_tunneled(struct mlx5_cqe64 *cqe)
 	return cqe->tls_outer_l3_tunneled & 0x1;
 }
 
-static inline u8 get_cqe_tls_offload(struct mlx5_cqe64 *cqe)
+static inline u8 get_cqe_tls_offload(const struct mlx5_cqe64 *cqe)
 {
 	return (cqe->tls_outer_l3_tunneled >> 3) & 0x3;
 }
-- 
2.41.0


