Return-Path: <bpf+bounces-7389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DFE7765BA
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51BA1C20D13
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF041D31B;
	Wed,  9 Aug 2023 16:54:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A81D310
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:54:29 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F921BFE
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:54:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53f6e19f814so96893a12.3
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691600068; x=1692204868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1K35zwU44vULt8r6sA56yve559h8s6Eneimtat4doU4=;
        b=llm4bY2o52xa0GBmUt8V/x9IDery52wwddzpPoReor0TlCVZovRWwwPJHR04KhJWQv
         uFbM5NUC3x4IHtH5FfSqKt2vjHenSnE8YJ6LZx+KsBxchAV3D7yv/EZZIMC9w/0WtA/A
         V1A10BjjztK8NMYrWVmftz1YY99n1zAE/srGceC71devKZN0uRNSY2JiaClOOcM7mzxV
         Z3SKCCAk/C7c62xE52q1n+eidu7mg5uU82eEKQ2SM3hQC0gYg4lLRg5Ypm7LMxVbSulg
         5MXOtOBUz7/DFtUmat1S5/ZuQBnXePVAoOaq4rNk/AgMVUZC40QmQFT9YYwK4KhmfhJn
         A0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600068; x=1692204868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1K35zwU44vULt8r6sA56yve559h8s6Eneimtat4doU4=;
        b=D2xyzI7gW3mkjyt6tx+/EeSWxARRycCYcDuUrZx8irfl3mJsVUK0oi+mdiVRmG/AQx
         JaQ4Es+qJj76ZI5FlnmtBft3UYGRu+j+2/lEryVkBgQRiItTvzEfPwEXCPiCnp0+Go6Z
         qaBgDlFaK/ffEl1GPFqPuktBFDewf+Saf5WdDpxZOgQ0cecynuj0GYDPgfLfj2bDnRz6
         hepFee3rP5RQ0iCk51aUW4qUjlD5azlE1vlvi0YcxDCuvIuyNWugHsmE3p2D3HmQ7Zgr
         x6fKF13Rn//eLb5GjSm9/3cB4WuJ/cAPmuod/8IIWwmIh6H3Q4QvL4ANoktGj0ssRnJT
         X1iA==
X-Gm-Message-State: AOJu0Yz/9ouiKBncIQZRtDqExcwVKP6eCdBcrkoemQL/Poll5pCVl7oS
	dON7nSmGq4MoT2JYYR/WZfRztgSd8H1INVQiDChoUDWF3vXfkdFHyqgJ0QajjyBayUvaIIReixZ
	JBbovz+d5ovNHjEK66wMNtwL9abxBtOjTVU6l07rhFXVxJJucQQ==
X-Google-Smtp-Source: AGHT+IEWtDHxVNfb01HTFE7LnqpBfP25Qy36ZgPVOkId7b3aUkw+bytmCZpbqoc4pYIPLl4R/5Cv13Q=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:9d8d:0:b0:55b:24a0:584c with SMTP id
 i135-20020a639d8d000000b0055b24a0584cmr275216pgd.4.1691600068116; Wed, 09 Aug
 2023 09:54:28 -0700 (PDT)
Date: Wed,  9 Aug 2023 09:54:13 -0700
In-Reply-To: <20230809165418.2831456-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809165418.2831456-5-sdf@google.com>
Subject: [PATCH bpf-next 4/9] net/mlx5e: Implement AF_XDP TX timestamp and
 checksum offload
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net, 
	Saeed Mahameed <saeedm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  | 10 ++-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   | 11 ++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  1 +
 5 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 0f8f70b91485..6f38627ae7f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -476,10 +476,12 @@ struct mlx5e_xdp_info_fifo {
 
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
index 40589cebb773..197d372048ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -102,7 +102,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 		xdptxd->dma_addr = dma_addr;
 
 		if (unlikely(!INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
-					      mlx5e_xmit_xdp_frame, sq, xdptxd, 0)))
+					      mlx5e_xmit_xdp_frame, sq, xdptxd, 0, NULL)))
 			return false;
 
 		/* xmit_mode == MLX5E_XDP_XMIT_MODE_FRAME */
@@ -144,7 +144,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 	xdptxd->dma_addr = dma_addr;
 
 	if (unlikely(!INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
-				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0)))
+				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0, NULL)))
 		return false;
 
 	/* xmit_mode == MLX5E_XDP_XMIT_MODE_PAGE */
@@ -260,6 +260,37 @@ const struct xdp_metadata_ops mlx5e_xdp_metadata_ops = {
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
@@ -397,11 +428,11 @@ INDIRECT_CALLABLE_SCOPE int mlx5e_xmit_xdp_frame_check_mpwqe(struct mlx5e_xdpsq
 
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
@@ -419,7 +450,7 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 			 */
 			if (unlikely(sq->mpwqe.wqe))
 				mlx5e_xdp_mpwqe_complete(sq);
-			return mlx5e_xmit_xdp_frame(sq, xdptxd, 0);
+			return mlx5e_xmit_xdp_frame(sq, xdptxd, 0, meta);
 		}
 		if (!xdptxd->len) {
 			skb_frag_t *frag = &xdptxdf->sinfo->frags[0];
@@ -449,6 +480,7 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 		 * and it's safe to complete it at any time.
 		 */
 		mlx5e_xdp_mpwqe_session_start(sq);
+		xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, &session->wqe->eth);
 	}
 
 	mlx5e_xdp_mpwqe_add_dseg(sq, p, stats);
@@ -479,7 +511,7 @@ INDIRECT_CALLABLE_SCOPE int mlx5e_xmit_xdp_frame_check(struct mlx5e_xdpsq *sq)
 
 INDIRECT_CALLABLE_SCOPE bool
 mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
-		     int check_result)
+		     int check_result, struct xsk_tx_metadata *meta)
 {
 	struct mlx5e_xmit_data_frags *xdptxdf =
 		container_of(xdptxd, struct mlx5e_xmit_data_frags, xd);
@@ -598,6 +630,8 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 		sq->pc++;
 	}
 
+	xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, eseg);
+
 	sq->doorbell_cseg = cseg;
 
 	stats->xmit++;
@@ -607,7 +641,9 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
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
@@ -667,10 +703,24 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 
 			break;
 		}
-		case MLX5E_XDP_XMIT_MODE_XSK:
+		case MLX5E_XDP_XMIT_MODE_XSK: {
 			/* AF_XDP send */
+			struct mlx5e_xsk_tx_complete priv = {
+				.cqe = cqe,
+				.cq = cq,
+			};
+			struct xsk_tx_metadata *meta = NULL;
+
+			if (xp_tx_metadata_enabled(sq->xsk_pool)) {
+				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
+				meta = (void *)xdpi.frame.xsk_meta;
+
+				xsk_tx_metadata_complete(meta, &mlx5e_xsk_tx_metadata_ops, &priv);
+			}
+
 			(*xsk_frames)++;
 			break;
+		}
 		default:
 			WARN_ON_ONCE(true);
 		}
@@ -719,7 +769,7 @@ bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq)
 
 			sqcc += wi->num_wqebbs;
 
-			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
+			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, cq, cqe);
 		} while (!last_wqe);
 
 		if (unlikely(get_cqe_opcode(cqe) != MLX5_CQE_REQ)) {
@@ -766,7 +816,7 @@ void mlx5e_free_xdpsq_descs(struct mlx5e_xdpsq *sq)
 
 		sq->cc += wi->num_wqebbs;
 
-		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
+		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, NULL, NULL);
 	}
 
 	xdp_flush_frame_bulk(&bq);
@@ -839,7 +889,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 		}
 
 		ret = INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
-				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0);
+				      mlx5e_xmit_xdp_frame, sq, xdptxd, 0, NULL);
 		if (unlikely(!ret)) {
 			int j;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index 9e8e6184f9e4..2fcd19c16103 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -82,13 +82,14 @@ enum mlx5e_xdp_xmit_mode {
  *    num, page_1, page_2, ... , page_num.
  *
  * MLX5E_XDP_XMIT_MODE_XSK:
- *    none.
+ *    frame.xsk_meta.
  */
 union mlx5e_xdp_info {
 	enum mlx5e_xdp_xmit_mode mode;
 	union {
 		struct xdp_frame *xdpf;
 		dma_addr_t dma_addr;
+		void *xsk_meta;
 	} frame;
 	union {
 		struct mlx5e_rq *rq;
@@ -110,13 +111,16 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
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
index 597f319d4770..2f69c7912490 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
@@ -55,12 +55,16 @@ static void mlx5e_xsk_tx_post_err(struct mlx5e_xdpsq *sq,
 
 	nopwqe = mlx5e_post_nop(&sq->wq, sq->sqn, &sq->pc);
 	mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo, *xdpi);
+	if (xp_tx_metadata_enabled(sq->xsk_pool))
+		mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+				     (union mlx5e_xdp_info) { .frame.xsk_meta = NULL });
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
@@ -106,6 +111,10 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 			mlx5e_xsk_tx_post_err(sq, &xdpi);
 		} else {
 			mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo, xdpi);
+			if (xp_tx_metadata_enabled(sq->xsk_pool))
+				mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+						     (union mlx5e_xdp_info)
+						     { .frame.xsk_meta = (void *)meta });
 		}
 
 		flush = true;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 1c820119e438..99c2a6babaea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5097,6 +5097,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->netdev_ops = &mlx5e_netdev_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
+	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
 
 	mlx5e_dcbnl_build_netdev(netdev);
 
-- 
2.41.0.640.ga95def55d0-goog


