Return-Path: <bpf+bounces-12714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C821F7D00E8
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD6E2822FC
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A7C37CB0;
	Thu, 19 Oct 2023 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QaEQvXn1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818838BA3
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 17:49:56 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDB712A
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:49:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5a586da6so8813567b3.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737793; x=1698342593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMRSkVyzONmBqCLxU/F/fpTa1AAX5XE/glws/xJG+fU=;
        b=QaEQvXn1QK+6QPcQDeeVUA/jDSzik9QjngwEgW0BYrTXsnUH6i/S37fHah5P1KXmJV
         FLDqcE9jM7zG6tlRm04DsT2/ONwEjq+/xIaumWFiB1mYSBoUkZ7XVxQMXsTD3azkAaKd
         3SrcLeSDaAMo+VRG+XWwpxiJ7HA6S4Yz1M5VpiT91A+wXsaVuQx3nMbfTHoZHpcNWB8x
         o6GHmiRKGMlHbSkWHPbOEPbrXW7w0oh7LXN/U+7R2pGS8Yj8jCc740bce4WntRRDv2F/
         WYgFPFv6xT0S8FL0291MDGeuumh+zA4txjSARcqpxc7OlzkmkVTSk4kHlL8q2zYoGP+i
         dFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737793; x=1698342593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMRSkVyzONmBqCLxU/F/fpTa1AAX5XE/glws/xJG+fU=;
        b=JkVzHwn1PxwX/DK72wIpAaEMbfqKOgVuDChv3LVSpiNQZ6TsMzbDAAek8vDj12hzL5
         SRGP1oEKnBZbSgPjUdAfIp//WlRJwL22VY171aGcTQjaGO3Bbny8FZEYbOJM9hlYcDMv
         ysGEEniaaKaPh+EHtWAeMkIGT2XHDTmsJzAtew5cMvJAOGHT3aBlF2N0pOsq2MylN+km
         HfU4fUtmRzYBkH77HGvjpfsV20TCTYCUOVV8bp7J5LbSfBn3BORXErOPSdd1zMKUegfL
         2wekaSll3JbTcEcca3JC1bso1nAd+mpGQg6lZ0ptyyT346Y9XIQ3FdIA0XFtNII+Hc+P
         O21A==
X-Gm-Message-State: AOJu0YysqrpPwx4E2kajpcyfM0R9PFAEFJhup2AVFeanf297Qbdbv/ib
	sPzXUSg0Ri72XEacHqpJrjsOFjAfBmV+DHlp7kR6qX8HmvH9aKstSagCT8O2aQ+Kk7BtWDoOt6N
	ohEZrFCpz7IoUyTz3o6V05oWtY27JXarv+ChGbn4MGk/SJ47kzw==
X-Google-Smtp-Source: AGHT+IH/CzfnT36x5Q5WXQ9JsuciavJ9eGCXtwE57kfArYpAKAVPEfh4lx3/UEhw8AHqlR0/XP1dThI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:d88e:0:b0:58c:e8da:4d1a with SMTP id
 a136-20020a0dd88e000000b0058ce8da4d1amr77449ywe.2.1697737793117; Thu, 19 Oct
 2023 10:49:53 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:49:37 -0700
In-Reply-To: <20231019174944.3376335-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019174944.3376335-5-sdf@google.com>
Subject: [PATCH bpf-next v4 04/11] net/mlx5e: Implement AF_XDP TX timestamp
 and checksum offload
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net, Saeed Mahameed <saeedm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

TX timestamp:
- requires passing clock, not sure I'm passing the correct one (from
  cq->mdev), but the timestamp value looks convincing

TX checksum:
- looks like device does packet parsing (and doesn't accept custom
  start/offset), so I'm ignoring user offsets

Cc: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 72 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  | 11 ++-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   | 17 ++++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  1 +
 5 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 2b3254e33fe5..695c609c4707 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -483,10 +483,12 @@ struct mlx5e_xdp_info_fifo {
 
 struct mlx5e_xdpsq;
 struct mlx5e_xmit_data;
+struct xsk_tx_metadata;
 typedef int (*mlx5e_fp_xmit_xdp_frame_check)(struct mlx5e_xdpsq *);
 typedef bool (*mlx5e_fp_xmit_xdp_frame)(struct mlx5e_xdpsq *,
 					struct mlx5e_xmit_data *,
-					int);
+					int,
+					struct xsk_tx_metadata *);
 
 struct mlx5e_xdpsq {
 	/* data path */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index cc3fcd24b36d..71df2f26812c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -103,7 +103,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 		xdptxd->dma_addr = dma_addr;
 
 		if (unlikely(!INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
-					      mlx5e_xmit_xdp_frame, sq, xdptxd, 0)))
+					      mlx5e_xmit_xdp_frame, sq, xdptxd, 0, NULL)))
 			return false;
 
 		/* xmit_mode == MLX5E_XDP_XMIT_MODE_FRAME */
@@ -145,7 +145,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 	xdptxd->dma_addr = dma_addr;
 
 	if (unlikely(!INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
-				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0)))
+				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0, NULL)))
 		return false;
 
 	/* xmit_mode == MLX5E_XDP_XMIT_MODE_PAGE */
@@ -261,6 +261,37 @@ const struct xdp_metadata_ops mlx5e_xdp_metadata_ops = {
 	.xmo_rx_hash			= mlx5e_xdp_rx_hash,
 };
 
+struct mlx5e_xsk_tx_complete {
+	struct mlx5_cqe64 *cqe;
+	struct mlx5e_cq *cq;
+};
+
+static u64 mlx5e_xsk_fill_timestamp(void *_priv)
+{
+	struct mlx5e_xsk_tx_complete *priv = _priv;
+	u64 ts;
+
+	ts = get_cqe_ts(priv->cqe);
+
+	if (mlx5_is_real_time_rq(priv->cq->mdev) || mlx5_is_real_time_sq(priv->cq->mdev))
+		return mlx5_real_time_cyc2time(&priv->cq->mdev->clock, ts);
+
+	return  mlx5_timecounter_cyc2time(&priv->cq->mdev->clock, ts);
+}
+
+static void mlx5e_xsk_request_checksum(u16 csum_start, u16 csum_offset, void *priv)
+{
+	struct mlx5_wqe_eth_seg *eseg = priv;
+
+	/* HW/FW is doing parsing, so offsets are largely ignored. */
+	eseg->cs_flags |= MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_WQE_L4_CSUM;
+}
+
+const struct xsk_tx_metadata_ops mlx5e_xsk_tx_metadata_ops = {
+	.tmo_fill_timestamp		= mlx5e_xsk_fill_timestamp,
+	.tmo_request_checksum		= mlx5e_xsk_request_checksum,
+};
+
 /* returns true if packet was consumed by xdp */
 bool mlx5e_xdp_handle(struct mlx5e_rq *rq,
 		      struct bpf_prog *prog, struct mlx5e_xdp_buff *mxbuf)
@@ -398,11 +429,11 @@ INDIRECT_CALLABLE_SCOPE int mlx5e_xmit_xdp_frame_check_mpwqe(struct mlx5e_xdpsq
 
 INDIRECT_CALLABLE_SCOPE bool
 mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
-		     int check_result);
+		     int check_result, struct xsk_tx_metadata *meta);
 
 INDIRECT_CALLABLE_SCOPE bool
 mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
-			   int check_result)
+			   int check_result, struct xsk_tx_metadata *meta)
 {
 	struct mlx5e_tx_mpwqe *session = &sq->mpwqe;
 	struct mlx5e_xdpsq_stats *stats = sq->stats;
@@ -420,7 +451,7 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 			 */
 			if (unlikely(sq->mpwqe.wqe))
 				mlx5e_xdp_mpwqe_complete(sq);
-			return mlx5e_xmit_xdp_frame(sq, xdptxd, 0);
+			return mlx5e_xmit_xdp_frame(sq, xdptxd, 0, meta);
 		}
 		if (!xdptxd->len) {
 			skb_frag_t *frag = &xdptxdf->sinfo->frags[0];
@@ -450,6 +481,7 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 		 * and it's safe to complete it at any time.
 		 */
 		mlx5e_xdp_mpwqe_session_start(sq);
+		xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, &session->wqe->eth);
 	}
 
 	mlx5e_xdp_mpwqe_add_dseg(sq, p, stats);
@@ -480,7 +512,7 @@ INDIRECT_CALLABLE_SCOPE int mlx5e_xmit_xdp_frame_check(struct mlx5e_xdpsq *sq)
 
 INDIRECT_CALLABLE_SCOPE bool
 mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
-		     int check_result)
+		     int check_result, struct xsk_tx_metadata *meta)
 {
 	struct mlx5e_xmit_data_frags *xdptxdf =
 		container_of(xdptxd, struct mlx5e_xmit_data_frags, xd);
@@ -599,6 +631,8 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 		sq->pc++;
 	}
 
+	xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, eseg);
+
 	sq->doorbell_cseg = cseg;
 
 	stats->xmit++;
@@ -608,7 +642,9 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				  struct mlx5e_xdp_wqe_info *wi,
 				  u32 *xsk_frames,
-				  struct xdp_frame_bulk *bq)
+				  struct xdp_frame_bulk *bq,
+				  struct mlx5e_cq *cq,
+				  struct mlx5_cqe64 *cqe)
 {
 	struct mlx5e_xdp_info_fifo *xdpi_fifo = &sq->db.xdpi_fifo;
 	u16 i;
@@ -668,10 +704,24 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 
 			break;
 		}
-		case MLX5E_XDP_XMIT_MODE_XSK:
+		case MLX5E_XDP_XMIT_MODE_XSK: {
 			/* AF_XDP send */
+			struct xsk_tx_metadata_compl *compl = NULL;
+			struct mlx5e_xsk_tx_complete priv = {
+				.cqe = cqe,
+				.cq = cq,
+			};
+
+			if (xp_tx_metadata_enabled(sq->xsk_pool)) {
+				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
+				compl = &xdpi.xsk_meta;
+
+				xsk_tx_metadata_complete(compl, &mlx5e_xsk_tx_metadata_ops, &priv);
+			}
+
 			(*xsk_frames)++;
 			break;
+		}
 		default:
 			WARN_ON_ONCE(true);
 		}
@@ -720,7 +770,7 @@ bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq)
 
 			sqcc += wi->num_wqebbs;
 
-			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
+			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, cq, cqe);
 		} while (!last_wqe);
 
 		if (unlikely(get_cqe_opcode(cqe) != MLX5_CQE_REQ)) {
@@ -767,7 +817,7 @@ void mlx5e_free_xdpsq_descs(struct mlx5e_xdpsq *sq)
 
 		sq->cc += wi->num_wqebbs;
 
-		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
+		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, NULL, NULL);
 	}
 
 	xdp_flush_frame_bulk(&bq);
@@ -840,7 +890,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 		}
 
 		ret = INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
-				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0);
+				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0, NULL);
 		if (unlikely(!ret)) {
 			int j;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index ecfe93a479da..e054db1e10f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -33,6 +33,7 @@
 #define __MLX5_EN_XDP_H__
 
 #include <linux/indirect_call_wrapper.h>
+#include <net/xdp_sock.h>
 
 #include "en.h"
 #include "en/txrx.h"
@@ -82,7 +83,7 @@ enum mlx5e_xdp_xmit_mode {
  *    num, page_1, page_2, ... , page_num.
  *
  * MLX5E_XDP_XMIT_MODE_XSK:
- *    none.
+ *    frame.xsk_meta.
  */
 #define MLX5E_XDP_FIFO_ENTRIES2DS_MAX_RATIO 4
 
@@ -97,6 +98,7 @@ union mlx5e_xdp_info {
 		u8 num;
 		struct page *page;
 	} page;
+	struct xsk_tx_metadata_compl xsk_meta;
 };
 
 struct mlx5e_xsk_param;
@@ -112,13 +114,16 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 		   u32 flags);
 
 extern const struct xdp_metadata_ops mlx5e_xdp_metadata_ops;
+extern const struct xsk_tx_metadata_ops mlx5e_xsk_tx_metadata_ops;
 
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq,
 							  struct mlx5e_xmit_data *xdptxd,
-							  int check_result));
+							  int check_result,
+							  struct xsk_tx_metadata *meta));
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq,
 						    struct mlx5e_xmit_data *xdptxd,
-						    int check_result));
+						    int check_result,
+						    struct xsk_tx_metadata *meta));
 INDIRECT_CALLABLE_DECLARE(int mlx5e_xmit_xdp_frame_check_mpwqe(struct mlx5e_xdpsq *sq));
 INDIRECT_CALLABLE_DECLARE(int mlx5e_xmit_xdp_frame_check(struct mlx5e_xdpsq *sq));
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
index 597f319d4770..a59199ed590d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
@@ -55,12 +55,16 @@ static void mlx5e_xsk_tx_post_err(struct mlx5e_xdpsq *sq,
 
 	nopwqe = mlx5e_post_nop(&sq->wq, sq->sqn, &sq->pc);
 	mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo, *xdpi);
+	if (xp_tx_metadata_enabled(sq->xsk_pool))
+		mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+				     (union mlx5e_xdp_info) { .xsk_meta = {} });
 	sq->doorbell_cseg = &nopwqe->ctrl;
 }
 
 bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 {
 	struct xsk_buff_pool *pool = sq->xsk_pool;
+	struct xsk_tx_metadata *meta = NULL;
 	union mlx5e_xdp_info xdpi;
 	bool work_done = true;
 	bool flush = false;
@@ -93,12 +97,13 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 		xdptxd.dma_addr = xsk_buff_raw_get_dma(pool, desc.addr);
 		xdptxd.data = xsk_buff_raw_get_data(pool, desc.addr);
 		xdptxd.len = desc.len;
+		meta = xsk_buff_get_metadata(pool, desc.addr);
 
 		xsk_buff_raw_dma_sync_for_device(pool, xdptxd.dma_addr, xdptxd.len);
 
 		ret = INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
 				      mlx5e_xmit_xdp_frame, sq, &xdptxd,
-				      check_result);
+				      check_result, meta);
 		if (unlikely(!ret)) {
 			if (sq->mpwqe.wqe)
 				mlx5e_xdp_mpwqe_complete(sq);
@@ -106,6 +111,16 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 			mlx5e_xsk_tx_post_err(sq, &xdpi);
 		} else {
 			mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo, xdpi);
+			if (xp_tx_metadata_enabled(sq->xsk_pool)) {
+				struct xsk_tx_metadata_compl compl;
+
+				xsk_tx_metadata_to_compl(meta, &compl);
+				XSK_TX_COMPL_FITS(void *);
+
+				mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+						     (union mlx5e_xdp_info)
+						     { .xsk_meta = compl });
+			}
 		}
 
 		flush = true;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index afc3d488b8f6..70c7816c9177 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5160,6 +5160,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->netdev_ops = &mlx5e_netdev_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
+	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
 
 	mlx5e_dcbnl_build_netdev(netdev);
 
-- 
2.42.0.655.g421f12c284-goog


