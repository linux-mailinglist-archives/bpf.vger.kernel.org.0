Return-Path: <bpf+bounces-57442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA2AAB1C7
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137FC188D86A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 04:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC7441A9B0;
	Tue,  6 May 2025 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtNmvy7R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92792D3F83;
	Mon,  5 May 2025 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485598; cv=none; b=bnLNmcqWaNXg6wHPqGhl05o/Yp32JxQpyhe2ZoNWIvR4LjfLPe9k5JcFp6xugNVYWBXV+5fqPOQ943yvdXHtBw+qCcysTh6HV4Dbp/g0TPlVBDr6DVAICitftARKP7NQZCVKwsg3osK+jiyyjmi1efXNbekVVmQQnjpOnaf1XKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485598; c=relaxed/simple;
	bh=ipesMSh3z1/RDiybCFvFCLMGT3b/P+ExHeVnzhzc0D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZijXC8l0HxKmZxsHqw/2ofQZDZRvZr21OKRLEDwMy5GLy/z99Oc3EqfU0k1ERxh38qcDnUwE2RmD3tdIhGIRrNW95cg00j0yQCzY9ISyAqnxb99K4CLogC/rImljyHUgs6dWp3bSBu1OioPN5LmN8ugAqkhDrPpIBrsm8WuSGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtNmvy7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A286C4CEE4;
	Mon,  5 May 2025 22:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485598;
	bh=ipesMSh3z1/RDiybCFvFCLMGT3b/P+ExHeVnzhzc0D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtNmvy7R8TdjUiXqmxPaAU/v7wphPPg1jPNpeYhRkn1YAEdAbp4DX4WD8s8iw+SUC
	 pbPgleUpSCJL+Stx8FrmmUa3jfd34g9g2wV/GRQgDEfi+wu0O7dIRfYLIDjPbPGnET
	 aWI/DlJUK+EhpP+eLIwQXV1KnNtUUnfxpoPvEhlNOq3PwapFktcbjNEbcYwXHTfUAh
	 nWHIylZFgY7/9dqOQ5yuJ6jXhBlKLLgZLicf3cz63dbBZEVAhFvgft/7FdbgTlzwjr
	 VAr2avtxJMDTWI2owNQdkzokT82C5DvzxCtNCBdTXvMxeMfAx6yvAoxMfRf7Ld/sNP
	 tl4IU/87sswNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexei Lazar <alazar@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	dtatulea@nvidia.com,
	michal.swiatkowski@linux.intel.com,
	yorayz@nvidia.com,
	lkayal@nvidia.com,
	witu@nvidia.com,
	leitao@debian.org,
	cratiu@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 379/486] net/mlx5: XDP, Enable TX side XDP multi-buffer support
Date: Mon,  5 May 2025 18:37:35 -0400
Message-Id: <20250505223922.2682012-379-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Alexei Lazar <alazar@nvidia.com>

[ Upstream commit 1a9304859b3a4119579524c293b902a8927180f3 ]

In XDP scenarios, fragmented packets can occur if the MTU is larger
than the page size, even when the packet size fits within the linear
part.
If XDP multi-buffer support is disabled, the fragmented part won't be
handled in the TX flow, leading to packet drops.

Since XDP multi-buffer support is always available, this commit removes
the conditional check for enabling it.
This ensures that XDP multi-buffer support is always enabled,
regardless of the `is_xdp_mb` parameter, and guarantees the handling of
fragmented packets in such scenarios.

Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250209101716.112774-16-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 -
 .../ethernet/mellanox/mlx5/core/en/params.c   |  1 -
 .../ethernet/mellanox/mlx5/core/en/params.h   |  1 -
 .../mellanox/mlx5/core/en/reporter_tx.c       |  1 -
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 49 ++++++++-----------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 29 -----------
 6 files changed, 21 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 57b7298a0e793..d6266f6a96d6e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -385,7 +385,6 @@ enum {
 	MLX5E_SQ_STATE_VLAN_NEED_L2_INLINE,
 	MLX5E_SQ_STATE_PENDING_XSK_TX,
 	MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
-	MLX5E_SQ_STATE_XDP_MULTIBUF,
 	MLX5E_NUM_SQ_STATES, /* Must be kept last */
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 31eb99f09c63c..8c4d710e85675 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -1242,7 +1242,6 @@ void mlx5e_build_xdpsq_param(struct mlx5_core_dev *mdev,
 	mlx5e_build_sq_param_common(mdev, param);
 	MLX5_SET(wq, wq, log_wq_sz, params->log_sq_size);
 	param->is_mpw = MLX5E_GET_PFLAG(params, MLX5E_PFLAG_XDP_TX_MPWQE);
-	param->is_xdp_mb = !mlx5e_rx_is_linear_skb(mdev, params, xsk);
 	mlx5e_build_tx_cq_param(mdev, params, &param->cqp);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 3f8986f9d8629..bd5877acc5b1e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -33,7 +33,6 @@ struct mlx5e_sq_param {
 	struct mlx5_wq_param       wq;
 	bool                       is_mpw;
 	bool                       is_tls;
-	bool                       is_xdp_mb;
 	u16                        stop_room;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 09433b91be176..532c7fa94d172 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -16,7 +16,6 @@ static const char * const sq_sw_state_type_name[] = {
 	[MLX5E_SQ_STATE_VLAN_NEED_L2_INLINE] = "vlan_need_l2_inline",
 	[MLX5E_SQ_STATE_PENDING_XSK_TX] = "pending_xsk_tx",
 	[MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC] = "pending_tls_rx_resync",
-	[MLX5E_SQ_STATE_XDP_MULTIBUF] = "xdp_multibuf",
 };
 
 static int mlx5e_wait_for_sq_flush(struct mlx5e_txqsq *sq)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 4610621a340e5..08ab0999f7b31 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -546,6 +546,7 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 	bool inline_ok;
 	bool linear;
 	u16 pi;
+	int i;
 
 	struct mlx5e_xdpsq_stats *stats = sq->stats;
 
@@ -612,41 +613,33 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 
 	cseg->opmod_idx_opcode = cpu_to_be32((sq->pc << 8) | MLX5_OPCODE_SEND);
 
-	if (test_bit(MLX5E_SQ_STATE_XDP_MULTIBUF, &sq->state)) {
-		int i;
-
-		memset(&cseg->trailer, 0, sizeof(cseg->trailer));
-		memset(eseg, 0, sizeof(*eseg) - sizeof(eseg->trailer));
-
-		eseg->inline_hdr.sz = cpu_to_be16(inline_hdr_sz);
+	memset(&cseg->trailer, 0, sizeof(cseg->trailer));
+	memset(eseg, 0, sizeof(*eseg) - sizeof(eseg->trailer));
 
-		for (i = 0; i < num_frags; i++) {
-			skb_frag_t *frag = &xdptxdf->sinfo->frags[i];
-			dma_addr_t addr;
+	eseg->inline_hdr.sz = cpu_to_be16(inline_hdr_sz);
 
-			addr = xdptxdf->dma_arr ? xdptxdf->dma_arr[i] :
-				page_pool_get_dma_addr(skb_frag_page(frag)) +
-				skb_frag_off(frag);
+	for (i = 0; i < num_frags; i++) {
+		skb_frag_t *frag = &xdptxdf->sinfo->frags[i];
+		dma_addr_t addr;
 
-			dseg->addr = cpu_to_be64(addr);
-			dseg->byte_count = cpu_to_be32(skb_frag_size(frag));
-			dseg->lkey = sq->mkey_be;
-			dseg++;
-		}
+		addr = xdptxdf->dma_arr ? xdptxdf->dma_arr[i] :
+			page_pool_get_dma_addr(skb_frag_page(frag)) +
+			skb_frag_off(frag);
 
-		cseg->qpn_ds = cpu_to_be32((sq->sqn << 8) | ds_cnt);
+		dseg->addr = cpu_to_be64(addr);
+		dseg->byte_count = cpu_to_be32(skb_frag_size(frag));
+		dseg->lkey = sq->mkey_be;
+		dseg++;
+	}
 
-		sq->db.wqe_info[pi] = (struct mlx5e_xdp_wqe_info) {
-			.num_wqebbs = num_wqebbs,
-			.num_pkts = 1,
-		};
+	cseg->qpn_ds = cpu_to_be32((sq->sqn << 8) | ds_cnt);
 
-		sq->pc += num_wqebbs;
-	} else {
-		cseg->fm_ce_se = 0;
+	sq->db.wqe_info[pi] = (struct mlx5e_xdp_wqe_info) {
+		.num_wqebbs = num_wqebbs,
+		.num_pkts = 1,
+	};
 
-		sq->pc++;
-	}
+	sq->pc += num_wqebbs;
 
 	xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, eseg);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 1c087fa1ca269..15ec9750d4be0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2030,41 +2030,12 @@ int mlx5e_open_xdpsq(struct mlx5e_channel *c, struct mlx5e_params *params,
 	csp.min_inline_mode = sq->min_inline_mode;
 	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
 
-	if (param->is_xdp_mb)
-		set_bit(MLX5E_SQ_STATE_XDP_MULTIBUF, &sq->state);
-
 	err = mlx5e_create_sq_rdy(c->mdev, param, &csp, 0, &sq->sqn);
 	if (err)
 		goto err_free_xdpsq;
 
 	mlx5e_set_xmit_fp(sq, param->is_mpw);
 
-	if (!param->is_mpw && !test_bit(MLX5E_SQ_STATE_XDP_MULTIBUF, &sq->state)) {
-		unsigned int ds_cnt = MLX5E_TX_WQE_EMPTY_DS_COUNT + 1;
-		unsigned int inline_hdr_sz = 0;
-		int i;
-
-		if (sq->min_inline_mode != MLX5_INLINE_MODE_NONE) {
-			inline_hdr_sz = MLX5E_XDP_MIN_INLINE;
-			ds_cnt++;
-		}
-
-		/* Pre initialize fixed WQE fields */
-		for (i = 0; i < mlx5_wq_cyc_get_size(&sq->wq); i++) {
-			struct mlx5e_tx_wqe      *wqe  = mlx5_wq_cyc_get_wqe(&sq->wq, i);
-			struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
-			struct mlx5_wqe_eth_seg  *eseg = &wqe->eth;
-
-			sq->db.wqe_info[i] = (struct mlx5e_xdp_wqe_info) {
-				.num_wqebbs = 1,
-				.num_pkts   = 1,
-			};
-
-			cseg->qpn_ds = cpu_to_be32((sq->sqn << 8) | ds_cnt);
-			eseg->inline_hdr.sz = cpu_to_be16(inline_hdr_sz);
-		}
-	}
-
 	return 0;
 
 err_free_xdpsq:
-- 
2.39.5


