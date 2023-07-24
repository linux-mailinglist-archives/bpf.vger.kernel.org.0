Return-Path: <bpf+bounces-5776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C35760377
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 02:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5942813F9
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 00:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59315482;
	Tue, 25 Jul 2023 00:00:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADD14AA1
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 00:00:08 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF9172D
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583c1903ad3so31406397b3.2
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690243205; x=1690848005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4fO0t3hoO8EMoe9CjmivbGxtkOtK76t7CjjlMVkxO8=;
        b=a1rXlu/rTOxn/yQHScBmxOQggwFoJSg3GEt5rrFprG9+K4Wf3tuRmeF1mFf7yRpVwl
         xvj29rTsn0TbQC18iVTure8VSepVp/yyi20+yIgT1PCOngoeB30DJJQcA98/Nr948V7x
         cufk6iQ8CDWIygf9/7ahHFUPzA8f9Bj994M/Nu4/3fPfm+8aZNfdo3W1O5aTKA3i1O8n
         cjw4Uo+uhexeO4sKu2a+lQP+ViQfTe2neUYtYEpDh1SBP4Ao5HUN78W5y0qBtEwlEimb
         QKaBaLYzhTLHW/1TZWugMer+195uDx6TtFBOcU1ZooYgByZsx2xpNw/GL0GZX74iRO3l
         WFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690243205; x=1690848005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4fO0t3hoO8EMoe9CjmivbGxtkOtK76t7CjjlMVkxO8=;
        b=EwklKzfWRAlTUiC8B9ae8T4zszKQN2gtZ+yeBw9Ojtpu45vKtNsbVUeLrJ2vx4yxuG
         XrM3XksYdxwUc37IT7sIaaUw0Xs1LWin9S4e8gzumk9qbfj3cgpaSkEhpwPa7iN37uNk
         c5XoIqs/8R/GI5pf6iWA82uzGDaNclCKzmY7uenrqzoWxfE8u8y7s5OZZz3k+aHiV4hD
         HfNYQwlONC14jFmiKZWKFMjriQf4Iu/RA45Lcrt/QMtQQW9MlBDB5gkig2KKmbBIc+7t
         xlCoxf62NBWGXxpcKNV1dP90gjTjxyO2PrGRfviBQrWrC6Chvon/kea+W31VYKFw2ilZ
         HWzA==
X-Gm-Message-State: ABy/qLYa/j/EA9oyZ54A1Qq9OfKxtes40eyLSgfMiQ0mplDF3armvvGk
	8AZUtY+NJMH/7w8a53dhjojMvivKVkeEAuFun0D4eLRb4ve2Q7Vqev+/TaDSjHiFqep2VA0AaEu
	zSAab8NkFeR+XbdQbrTz7I88y4+lnp9s71HtiWP+ZmMl/B2c2qA==
X-Google-Smtp-Source: APBJJlFfm1Psa91gksoN1MX2VuEYawPJxGnOsAkC/+jsdau4PzrzRg0bhRRrLjbxnOEcEvb5+6keP0o=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:b50a:0:b0:576:92da:cd3d with SMTP id
 t10-20020a81b50a000000b0057692dacd3dmr76706ywh.8.1690243205055; Mon, 24 Jul
 2023 17:00:05 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:59:52 -0700
In-Reply-To: <20230724235957.1953861-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724235957.1953861-4-sdf@google.com>
Subject: [RFC net-next v4 3/8] net/mlx5e: Implement AF_XDP TX timestamp and
 checksum offload
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TX timestamp:
- requires passing clock, not sure I'm passing the correct one (from
  cq->mdev), but the timestamp value looks convincing

TX checksum:
- looks like device does packet parsing (and doesn't accept custom
  start/offset), so I'm ignoring user offsets

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 71 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  | 10 ++-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  9 ++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  1 +
 5 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index b1807bfb815f..dcbef1074148 100644
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
index 40589cebb773..16e16d047542 100644
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
@@ -260,6 +260,38 @@ const struct xdp_metadata_ops mlx5e_xdp_metadata_ops = {
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
+	struct mlx5_wqe_eth_seg *eseg;
+
+	eseg = priv;
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
@@ -397,11 +429,11 @@ INDIRECT_CALLABLE_SCOPE int mlx5e_xmit_xdp_frame_check_mpwqe(struct mlx5e_xdpsq
 
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
@@ -419,7 +451,7 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 			 */
 			if (unlikely(sq->mpwqe.wqe))
 				mlx5e_xdp_mpwqe_complete(sq);
-			return mlx5e_xmit_xdp_frame(sq, xdptxd, 0);
+			return mlx5e_xmit_xdp_frame(sq, xdptxd, 0, meta);
 		}
 		if (!xdptxd->len) {
 			skb_frag_t *frag = &xdptxdf->sinfo->frags[0];
@@ -449,6 +481,7 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 		 * and it's safe to complete it at any time.
 		 */
 		mlx5e_xdp_mpwqe_session_start(sq);
+		xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, &session->wqe->eth);
 	}
 
 	mlx5e_xdp_mpwqe_add_dseg(sq, p, stats);
@@ -479,7 +512,7 @@ INDIRECT_CALLABLE_SCOPE int mlx5e_xmit_xdp_frame_check(struct mlx5e_xdpsq *sq)
 
 INDIRECT_CALLABLE_SCOPE bool
 mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
-		     int check_result)
+		     int check_result, struct xsk_tx_metadata *meta)
 {
 	struct mlx5e_xmit_data_frags *xdptxdf =
 		container_of(xdptxd, struct mlx5e_xmit_data_frags, xd);
@@ -598,6 +631,8 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 		sq->pc++;
 	}
 
+	xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, eseg);
+
 	sq->doorbell_cseg = cseg;
 
 	stats->xmit++;
@@ -607,7 +642,9 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
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
@@ -667,10 +704,22 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 
 			break;
 		}
-		case MLX5E_XDP_XMIT_MODE_XSK:
+		case MLX5E_XDP_XMIT_MODE_XSK: {
 			/* AF_XDP send */
+			struct mlx5e_xsk_tx_complete priv = {
+				.cqe = cqe,
+				.cq = cq,
+			};
+			struct xsk_tx_metadata *meta;
+
+			xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
+			meta = (void *)xdpi.frame.xsk_meta;
+
+			xsk_tx_metadata_complete(meta, &mlx5e_xsk_tx_metadata_ops, &priv);
+
 			(*xsk_frames)++;
 			break;
+		}
 		default:
 			WARN_ON_ONCE(true);
 		}
@@ -719,7 +768,7 @@ bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq)
 
 			sqcc += wi->num_wqebbs;
 
-			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
+			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, cq, cqe);
 		} while (!last_wqe);
 
 		if (unlikely(get_cqe_opcode(cqe) != MLX5_CQE_REQ)) {
@@ -766,7 +815,7 @@ void mlx5e_free_xdpsq_descs(struct mlx5e_xdpsq *sq)
 
 		sq->cc += wi->num_wqebbs;
 
-		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
+		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, NULL, NULL);
 	}
 
 	xdp_flush_frame_bulk(&bq);
@@ -839,7 +888,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
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
index 597f319d4770..86e66d916176 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
@@ -55,12 +55,15 @@ static void mlx5e_xsk_tx_post_err(struct mlx5e_xdpsq *sq,
 
 	nopwqe = mlx5e_post_nop(&sq->wq, sq->sqn, &sq->pc);
 	mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo, *xdpi);
+	mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+			     (union mlx5e_xdp_info) { .frame.xsk_meta = NULL });
 	sq->doorbell_cseg = &nopwqe->ctrl;
 }
 
 bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 {
 	struct xsk_buff_pool *pool = sq->xsk_pool;
+	struct xsk_tx_metadata *meta = NULL;
 	union mlx5e_xdp_info xdpi;
 	bool work_done = true;
 	bool flush = false;
@@ -93,12 +96,13 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
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
@@ -106,6 +110,9 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 			mlx5e_xsk_tx_post_err(sq, &xdpi);
 		} else {
 			mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo, xdpi);
+			mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+					     (union mlx5e_xdp_info)
+					     { .frame.xsk_meta = (void *)meta });
 		}
 
 		flush = true;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index defb1efccb78..e19f313f4612 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5084,6 +5084,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->netdev_ops = &mlx5e_netdev_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
+	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
 
 	mlx5e_dcbnl_build_netdev(netdev);
 
-- 
2.41.0.487.g6d72f3e995-goog


