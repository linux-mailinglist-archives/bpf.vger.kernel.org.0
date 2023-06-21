Return-Path: <bpf+bounces-3058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB6738CAE
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 19:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16C01C20F74
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1DD1C753;
	Wed, 21 Jun 2023 17:03:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539B19937
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 17:03:08 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E46129
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:03:06 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666e3b5d305so2753109b3a.2
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366985; x=1689958985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwbBOZ5mIbfZQrRhwVaMrHD5n/o6Wow9MHXRzVGufzQ=;
        b=YJ+bi+DGhEfp/XX6mXzR6WDx/uLoEQofae8or87da/BvxPxN7nm6EXG2w1Jn2R0nUr
         gfq/A/qu2FjUstsORErpILsVE1TrX7N6kzpYOdLNHZoaFTGNDBBMSzRb9VB8I5ob0lBO
         hR/Dwvm3mVMYbs7xA11K+t8I1+pGQB4zQYrMCgvLczlX7zDI94K/zBYyGbAHPeKtHBsb
         lzxu/Lo6Y14VmH2oInFYoMiFeb1AAZ17JKiZXS26EHLzUBin2DdDedqygOMV+6F6xHKL
         89NTfmspiD/mPeiHxlyTVQc1sMGPAhJoY8I8yFiV++27QoLEatI8xA+XtcYSbBNPFnLK
         knSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366985; x=1689958985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwbBOZ5mIbfZQrRhwVaMrHD5n/o6Wow9MHXRzVGufzQ=;
        b=WGhVrZkTLbzQvYva0gzhE1OKGP/yVxr7I7umqJHD5dmoS54UYJiuMYYSjUaYNR8+2X
         RcnhHRhvay71rUXdaG/ohG8TKPw6my16Pr9xNyDE1rEkT9loZJ7GdbhmV0LLW1OcIbee
         KfTkkVZ9QzdKfcck/xanhcLV9zjUvdYSo7mFYr0I+eRVtX5bTx/CufkZP3h58wSDqgOy
         7xHrblWAJYO36RJa799hEzj6CZMuHrUTeHLTmOK4oYieFY3aEt/onhllWgoyrdCE6rMK
         t1A/BRkNlYHGKkyVRdiHxLtedDFr6N26CAzp7x9hJ62E+PhxE9zEwkpQ0Zg2c1wjIdAz
         Soqg==
X-Gm-Message-State: AC+VfDzKn1mZCpeT7CBVHgdFqxMtJcjLqranF9s7S2lcNHRhGvaUuHdD
	7MdH2oLqAYinifsc5Qbdx2Xd8fGJYBeNTbOl06p1PALArpSDM5dRtXADVP062IB9KYDqo4v4pVw
	xxq+MCX7aA8dbDEV7Os7mLAysqvz1uVShC7WtYrllls/7DQzQfA==
X-Google-Smtp-Source: ACHHUZ4vseU2C7wszAZFipl1H5C7vWcKJw1hh0yHCLV1qgakjL/WIEjP5KQqVZeAvBAfusdrcnRxIJk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:2d82:b0:668:7260:bbbb with SMTP id
 fb2-20020a056a002d8200b006687260bbbbmr2817243pfb.0.1687366985572; Wed, 21 Jun
 2023 10:03:05 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:44 -0700
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-12-sdf@google.com>
Subject: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

WIP, not tested, only to show the overall idea.
Non-AF_XDP paths are marked with 'false' for now.

Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h | 11 +++
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 96 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  9 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  3 +
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 16 ++++
 .../net/ethernet/mellanox/mlx5/core/main.c    | 26 ++++-
 6 files changed, 156 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 879d698b6119..e4509464e0b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -6,6 +6,7 @@
 
 #include "en.h"
 #include <linux/indirect_call_wrapper.h>
+#include <net/devtx.h>
 
 #define MLX5E_TX_WQE_EMPTY_DS_COUNT (sizeof(struct mlx5e_tx_wqe) / MLX5_SEND_WQE_DS)
 
@@ -506,4 +507,14 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw_info(struct mlx5e_rq *rq, int
 
 	return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array_size(i, isz));
 }
+
+struct mlx5e_devtx_frame {
+	struct devtx_frame frame;
+	struct mlx5_cqe64 *cqe; /* tx completion */
+	struct mlx5e_tx_wqe *wqe; /* tx */
+};
+
+void mlx5e_devtx_submit(struct devtx_frame *ctx);
+void mlx5e_devtx_complete(struct devtx_frame *ctx);
+
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index f0e6095809fa..0cb0f0799cbc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -255,9 +255,30 @@ static int mlx5e_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+static int mlx5e_devtx_sb_request_timestamp(const struct devtx_frame *ctx)
+{
+	/* Nothing to do here, CQE always has a timestamp. */
+	return 0;
+}
+
+static int mlx5e_devtx_cp_timestamp(const struct devtx_frame *_ctx, u64 *timestamp)
+{
+	const struct mlx5e_devtx_frame *ctx = (void *)_ctx;
+	u64 ts;
+
+	if (unlikely(!ctx->cqe))
+		return -ENODATA;
+
+	ts = get_cqe_ts(ctx->cqe);
+	*timestamp = mlx5_real_time_cyc2time(NULL, ts);
+	return 0;
+}
+
 const struct xdp_metadata_ops mlx5e_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= mlx5e_xdp_rx_timestamp,
 	.xmo_rx_hash			= mlx5e_xdp_rx_hash,
+	.xmo_sb_request_timestamp	= mlx5e_devtx_sb_request_timestamp,
+	.xmo_cp_timestamp		= mlx5e_devtx_cp_timestamp,
 };
 
 /* returns true if packet was consumed by xdp */
@@ -453,6 +474,23 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 
 	mlx5e_xdp_mpwqe_add_dseg(sq, p, stats);
 
+	if (devtx_enabled()) {
+		struct mlx5e_xmit_data_frags *xdptxdf =
+			container_of(xdptxd, struct mlx5e_xmit_data_frags, xd);
+
+		struct mlx5e_devtx_frame ctx = {
+			.frame = {
+				.data = p->data,
+				.len = p->len,
+				.meta_len = sq->xsk_pool->tx_metadata_len,
+				.sinfo = xdptxd->has_frags ? xdptxdf->sinfo : NULL,
+				.netdev = sq->cq.netdev,
+			},
+			.wqe = sq->mpwqe.wqe,
+		};
+		mlx5e_devtx_submit(&ctx.frame);
+	}
+
 	if (unlikely(mlx5e_xdp_mpwqe_is_full(session, sq->max_sq_mpw_wqebbs)))
 		mlx5e_xdp_mpwqe_complete(sq);
 
@@ -560,6 +598,20 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 		dseg++;
 	}
 
+	if (devtx_enabled()) {
+		struct mlx5e_devtx_frame ctx = {
+			.frame = {
+				.data = xdptxd->data,
+				.len = xdptxd->len,
+				.meta_len = sq->xsk_pool->tx_metadata_len,
+				.sinfo = xdptxd->has_frags ? xdptxdf->sinfo : NULL,
+				.netdev = sq->cq.netdev,
+			},
+			.wqe = wqe,
+		};
+		mlx5e_devtx_submit(&ctx.frame);
+	}
+
 	cseg->opmod_idx_opcode = cpu_to_be32((sq->pc << 8) | MLX5_OPCODE_SEND);
 
 	if (test_bit(MLX5E_SQ_STATE_XDP_MULTIBUF, &sq->state)) {
@@ -607,7 +659,8 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				  struct mlx5e_xdp_wqe_info *wi,
 				  u32 *xsk_frames,
-				  struct xdp_frame_bulk *bq)
+				  struct xdp_frame_bulk *bq,
+				  struct mlx5_cqe64 *cqe)
 {
 	struct mlx5e_xdp_info_fifo *xdpi_fifo = &sq->db.xdpi_fifo;
 	u16 i;
@@ -626,6 +679,14 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 			xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 			dma_addr = xdpi.frame.dma_addr;
 
+			if (false && devtx_enabled()) {
+				struct mlx5e_devtx_frame ctx;
+
+				devtx_frame_from_xdp(&ctx.frame, xdpf, sq->cq.netdev);
+				ctx.cqe = cqe;
+				mlx5e_devtx_complete(&ctx.frame);
+			}
+
 			dma_unmap_single(sq->pdev, dma_addr,
 					 xdpf->len, DMA_TO_DEVICE);
 			if (xdp_frame_has_frags(xdpf)) {
@@ -659,6 +720,20 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
+				if (false && devtx_enabled()) {
+					struct mlx5e_devtx_frame ctx = {
+						.frame = {
+							.data = page,
+							.len = PAGE_SIZE,
+							.meta_len = sq->xsk_pool->tx_metadata_len,
+							.netdev = sq->cq.netdev,
+						},
+						.cqe = cqe,
+					};
+
+					mlx5e_devtx_complete(&ctx.frame);
+				}
+
 				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
 				 * as we know this is a page_pool page.
 				 */
@@ -670,6 +745,21 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 		}
 		case MLX5E_XDP_XMIT_MODE_XSK:
 			/* AF_XDP send */
+
+			if (devtx_enabled()) {
+				struct mlx5e_devtx_frame ctx = {
+					.frame = {
+						.data = xdpi.frame.xsk_head,
+						.len = xdpi.page.xsk_head_len,
+						.meta_len = sq->xsk_pool->tx_metadata_len,
+						.netdev = sq->cq.netdev,
+					},
+					.cqe = cqe,
+				};
+
+				mlx5e_devtx_complete(&ctx.frame);
+			}
+
 			(*xsk_frames)++;
 			break;
 		default:
@@ -720,7 +810,7 @@ bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq)
 
 			sqcc += wi->num_wqebbs;
 
-			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
+			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, cqe);
 		} while (!last_wqe);
 
 		if (unlikely(get_cqe_opcode(cqe) != MLX5_CQE_REQ)) {
@@ -767,7 +857,7 @@ void mlx5e_free_xdpsq_descs(struct mlx5e_xdpsq *sq)
 
 		sq->cc += wi->num_wqebbs;
 
-		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
+		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, NULL);
 	}
 
 	xdp_flush_frame_bulk(&bq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index 9e8e6184f9e4..860638e1209b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -50,6 +50,11 @@ struct mlx5e_xdp_buff {
 	struct mlx5e_rq *rq;
 };
 
+struct mlx5e_xdp_md {
+	struct xdp_md md;
+	struct mlx5_cqe64 *cqe;
+};
+
 /* XDP packets can be transmitted in different ways. On completion, we need to
  * distinguish between them to clean up things in a proper way.
  */
@@ -82,18 +87,20 @@ enum mlx5e_xdp_xmit_mode {
  *    num, page_1, page_2, ... , page_num.
  *
  * MLX5E_XDP_XMIT_MODE_XSK:
- *    none.
+ *    frame.xsk_head + page.xsk_head_len for header portion only.
  */
 union mlx5e_xdp_info {
 	enum mlx5e_xdp_xmit_mode mode;
 	union {
 		struct xdp_frame *xdpf;
 		dma_addr_t dma_addr;
+		void *xsk_head;
 	} frame;
 	union {
 		struct mlx5e_rq *rq;
 		u8 num;
 		struct page *page;
+		u32 xsk_head_len;
 	} page;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
index 597f319d4770..1b97d6f6a9ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
@@ -96,6 +96,9 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 
 		xsk_buff_raw_dma_sync_for_device(pool, xdptxd.dma_addr, xdptxd.len);
 
+		xdpi.frame.xsk_head = xdptxd.data;
+		xdpi.page.xsk_head_len = xdptxd.len;
+
 		ret = INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
 				      mlx5e_xmit_xdp_frame, sq, &xdptxd,
 				      check_result);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index c7eb6b238c2b..f8d3e210408a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -758,6 +758,14 @@ static void mlx5e_tx_wi_consume_fifo_skbs(struct mlx5e_txqsq *sq, struct mlx5e_t
 	for (i = 0; i < wi->num_fifo_pkts; i++) {
 		struct sk_buff *skb = mlx5e_skb_fifo_pop(&sq->db.skb_fifo);
 
+		if (false && devtx_enabled()) {
+			struct mlx5e_devtx_frame ctx = {};
+
+			devtx_frame_from_skb(&ctx.frame, skb, sq->cq.netdev);
+			ctx.cqe = cqe;
+			mlx5e_devtx_complete(&ctx.frame);
+		}
+
 		mlx5e_consume_skb(sq, skb, cqe, napi_budget);
 	}
 }
@@ -826,6 +834,14 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 			sqcc += wi->num_wqebbs;
 
 			if (likely(wi->skb)) {
+				if (false && devtx_enabled()) {
+					struct mlx5e_devtx_frame ctx = {};
+
+					devtx_frame_from_skb(&ctx.frame, wi->skb, cq->netdev);
+					ctx.cqe = cqe;
+					mlx5e_devtx_complete(&ctx.frame);
+				}
+
 				mlx5e_tx_wi_dma_unmap(sq, wi, &dma_fifo_cc);
 				mlx5e_consume_skb(sq, wi->skb, cqe, napi_budget);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index a7eb65cd0bdd..7160389a5bc6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -48,6 +48,7 @@
 #include <linux/mlx5/vport.h>
 #include <linux/version.h>
 #include <net/devlink.h>
+#include <net/devtx.h>
 #include "mlx5_core.h"
 #include "thermal.h"
 #include "lib/eq.h"
@@ -73,6 +74,7 @@
 #include "sf/dev/dev.h"
 #include "sf/sf.h"
 #include "mlx5_irq.h"
+#include "en/xdp.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -2132,6 +2134,19 @@ static void mlx5_core_verify_params(void)
 	}
 }
 
+__weak noinline void mlx5e_devtx_submit(struct devtx_frame *ctx)
+{
+}
+
+__weak noinline void mlx5e_devtx_complete(struct devtx_frame *ctx)
+{
+}
+
+BTF_SET8_START(mlx5e_devtx_hook_ids)
+BTF_ID_FLAGS(func, mlx5e_devtx_submit)
+BTF_ID_FLAGS(func, mlx5e_devtx_complete)
+BTF_SET8_END(mlx5e_devtx_hook_ids)
+
 static int __init mlx5_init(void)
 {
 	int err;
@@ -2144,9 +2159,15 @@ static int __init mlx5_init(void)
 	mlx5_core_verify_params();
 	mlx5_register_debugfs();
 
+	err = devtx_hooks_register(&mlx5e_devtx_hook_ids, &mlx5e_xdp_metadata_ops);
+	if (err) {
+		pr_warn("failed to register devtx hooks: %d", err);
+		goto err_debug;
+	}
+
 	err = mlx5e_init();
 	if (err)
-		goto err_debug;
+		goto err_devtx;
 
 	err = mlx5_sf_driver_register();
 	if (err)
@@ -2162,6 +2183,8 @@ static int __init mlx5_init(void)
 	mlx5_sf_driver_unregister();
 err_sf:
 	mlx5e_cleanup();
+err_devtx:
+	devtx_hooks_unregister(&mlx5e_devtx_hook_ids);
 err_debug:
 	mlx5_unregister_debugfs();
 	return err;
@@ -2169,6 +2192,7 @@ static int __init mlx5_init(void)
 
 static void __exit mlx5_cleanup(void)
 {
+	devtx_hooks_unregister(&mlx5e_devtx_hook_ids);
 	pci_unregister_driver(&mlx5_core_driver);
 	mlx5_sf_driver_unregister();
 	mlx5e_cleanup();
-- 
2.41.0.162.gfafddb0af9-goog


