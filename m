Return-Path: <bpf+bounces-4484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B3674B732
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 21:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D717B1C210A7
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35C182B7;
	Fri,  7 Jul 2023 19:30:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF5182A0
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 19:30:37 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DE92D74
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 12:30:24 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5428d1915acso3124706a12.0
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758224; x=1691350224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMna6Wr+v1zioR6ds26K6ru6nrJ9VR9FQlgZ/qoEQvo=;
        b=SPiyjutWwfK45TmtAU6Gy25RNueVIq5AxP8s1I4eJJosOxJKOjHDyNKmT8ZQuQn2cN
         58A1NDANxs/JYdpxq8HC/9CFvUXeutPSV7Z6xPqFaoWJbzh1NfFJJS97JbnysknSfgQP
         ZtwFHfB7zLrGZqcWtY5x+X/z5xB52cSqxestsxn4q3ENaZG/snnMLjTMPm5ZEti0jvJb
         jqa89WdqtcCx1YmxCWDRAAgh6hZZeFWYOVKP/bN35C6rGugokynN+TlNLS7bHT+P9mQG
         zpuVzdFjxdvLKDnKf//ti/MYL68JR3Z1W/imCKdv2TziLYWC6dNdjdQcsBoI7tXiY1rN
         sqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758224; x=1691350224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMna6Wr+v1zioR6ds26K6ru6nrJ9VR9FQlgZ/qoEQvo=;
        b=YTKWkQ/uT1ME8lTCoQq+M1gDb2M7Z4wZnVDBMOfeZyulLGxp598tSQsxbKgzmeVTQu
         z2tIibT/tg/OLM+xUzlGIEqry2HjmtesVGmN8NBwfPoniuqFxLAGtiIZMh4SvpPTftTy
         Vc1UMr58FCoMXwnHfvQvlcZ/lFRy+SbKoONxpOEoccKM/PMtHAsRucYNv+f77d4SaYzj
         apav73ukmX0U1zmRyKXFJKRZ36vYMlJFBHHvcjiusVJBPWNZTYX6sPLLgcPsOCZYuikR
         KJvtHBGBv3DBDwGw0/Lgp4iDV+DcOnAwBR8pmZSailyYAEIIpjvhUBC5uhdr+sRF/mVe
         ClzQ==
X-Gm-Message-State: ABy/qLa+k8GN4dKnqTlLNAqUee+fmhS08Py/O1rAQJgubuY8yTVpsLpu
	eV41M7TOxKt+djpgssNQAcNjp3/Zb6n8tGppH5hzL5aRpIPl+4As9nkrBplomWyrddnVplb9rRu
	oDL3OxipbwoQEAoOd7Iu7sv3KV/Evpc0Xm1rAdWF6DvMmxq4Uyw==
X-Google-Smtp-Source: APBJJlHotRSsn8OhdHnuGShUvwMQ/vboLGBwr+kDjpS0Kn78/lCF9Sc2H0c9UkJkH52Y242MiX9sMjY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:6d0a:0:b0:55c:aa9:794 with SMTP id
 i10-20020a636d0a000000b0055c0aa90794mr2837074pgc.6.1688758224224; Fri, 07 Jul
 2023 12:30:24 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:30:01 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-10-sdf@google.com>
Subject: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TX timestamp:
- requires passing clock, not sure I'm passing the correct one (from
  cq->mdev), but the timestamp value looks convincing

TX checksum:
- looks like device does packet parsing (and doesn't accept custom
  start/offset), so I'm using the same approach we do for skb (support
  specific header offesets)

Some quirks that might need some more thought:
- AF_XDP requires creating on-stack xdp_frame
- AF_XDP passes only head to the completion hook

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  15 ++
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 155 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |   4 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  10 ++
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  24 +++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  15 +-
 6 files changed, 217 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 879d698b6119..02b617a534c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -6,6 +6,7 @@
 
 #include "en.h"
 #include <linux/indirect_call_wrapper.h>
+#include <net/devtx.h>
 
 #define MLX5E_TX_WQE_EMPTY_DS_COUNT (sizeof(struct mlx5e_tx_wqe) / MLX5_SEND_WQE_DS)
 
@@ -506,4 +507,18 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw_info(struct mlx5e_rq *rq, int
 
 	return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array_size(i, isz));
 }
+
+struct mlx5e_devtx_ctx {
+	struct devtx_ctx devtx;
+	union {
+		struct {
+			struct mlx5_cqe64 *cqe; /* tx completion */
+			struct mlx5e_cq *cq; /* tx completion */
+		};
+		struct mlx5e_tx_wqe *wqe; /* tx */
+	};
+};
+
+DECLARE_DEVTX_HOOKS(mlx5e);
+
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index f0e6095809fa..59342d5e7e6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -255,9 +255,60 @@ static int mlx5e_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+static int mlx5e_devtx_request_tx_timestamp(const struct devtx_ctx *ctx)
+{
+	/* Nothing to do here, CQE always has a timestamp. */
+	return 0;
+}
+
+static int mlx5e_devtx_tx_timestamp(const struct devtx_ctx *_ctx, u64 *timestamp)
+{
+	const struct mlx5e_devtx_ctx *ctx = (void *)_ctx;
+	u64 ts;
+
+	if (unlikely(!ctx->cqe || !ctx->cq))
+		return -ENODATA;
+
+	ts = get_cqe_ts(ctx->cqe);
+
+	if (mlx5_is_real_time_rq(ctx->cq->mdev) || mlx5_is_real_time_sq(ctx->cq->mdev))
+		*timestamp = mlx5_real_time_cyc2time(&ctx->cq->mdev->clock, ts);
+	else
+		*timestamp = mlx5_timecounter_cyc2time(&ctx->cq->mdev->clock, ts);
+
+	return 0;
+}
+
+static int mlx5e_devtx_request_l4_checksum(const struct devtx_ctx *_ctx,
+					   u16 csum_start, u16 csum_offset)
+{
+	const struct mlx5e_devtx_ctx *ctx = (void *)_ctx;
+	struct mlx5_wqe_eth_seg *eseg;
+
+	if (unlikely(!ctx->wqe))
+		return -ENODATA;
+
+	eseg = &ctx->wqe->eth;
+
+	switch (csum_offset) {
+	case sizeof(struct ethhdr) + sizeof(struct iphdr) + offsetof(struct udphdr, check):
+	case sizeof(struct ethhdr) + sizeof(struct ipv6hdr) + offsetof(struct udphdr, check):
+		/* Looks like HW/FW is doing parsing, so offsets are largely ignored. */
+		eseg->cs_flags = MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_WQE_L4_CSUM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 const struct xdp_metadata_ops mlx5e_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= mlx5e_xdp_rx_timestamp,
 	.xmo_rx_hash			= mlx5e_xdp_rx_hash,
+	.xmo_request_tx_timestamp	= mlx5e_devtx_request_tx_timestamp,
+	.xmo_tx_timestamp		= mlx5e_devtx_tx_timestamp,
+	.xmo_request_l4_checksum	= mlx5e_devtx_request_l4_checksum,
 };
 
 /* returns true if packet was consumed by xdp */
@@ -453,6 +504,27 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 
 	mlx5e_xdp_mpwqe_add_dseg(sq, p, stats);
 
+	if (devtx_enabled()) {
+		struct mlx5e_xmit_data_frags *xdptxdf =
+			container_of(xdptxd, struct mlx5e_xmit_data_frags, xd);
+
+		struct xdp_frame frame = {
+			.data = p->data,
+			.len = p->len,
+			.metasize = sq->xsk_pool->tx_metadata_len,
+		};
+
+		struct mlx5e_devtx_ctx ctx = {
+			.devtx = {
+				.netdev = sq->cq.netdev,
+				.sinfo = xdptxd->has_frags ? xdptxdf->sinfo : NULL,
+			},
+			.wqe = sq->mpwqe.wqe,
+		};
+
+		mlx5e_devtx_submit_xdp(&ctx.devtx, &frame);
+	}
+
 	if (unlikely(mlx5e_xdp_mpwqe_is_full(session, sq->max_sq_mpw_wqebbs)))
 		mlx5e_xdp_mpwqe_complete(sq);
 
@@ -560,6 +632,24 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 		dseg++;
 	}
 
+	if (devtx_enabled()) {
+		struct xdp_frame frame = {
+			.data = xdptxd->data,
+			.len = xdptxd->len,
+			.metasize = sq->xsk_pool->tx_metadata_len,
+		};
+
+		struct mlx5e_devtx_ctx ctx = {
+			.devtx = {
+				.netdev = sq->cq.netdev,
+				.sinfo = xdptxd->has_frags ? xdptxdf->sinfo : NULL,
+			},
+			.wqe = wqe,
+		};
+
+		mlx5e_devtx_submit_xdp(&ctx.devtx, &frame);
+	}
+
 	cseg->opmod_idx_opcode = cpu_to_be32((sq->pc << 8) | MLX5_OPCODE_SEND);
 
 	if (test_bit(MLX5E_SQ_STATE_XDP_MULTIBUF, &sq->state)) {
@@ -607,7 +697,9 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
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
@@ -626,6 +718,21 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 			xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 			dma_addr = xdpi.frame.dma_addr;
 
+			if (devtx_enabled()) {
+				struct mlx5e_devtx_ctx ctx = {
+					.devtx = {
+						.netdev = sq->cq.netdev,
+						.sinfo = xdp_frame_has_frags(xdpf) ?
+							 xdp_get_shared_info_from_frame(xdpf) :
+							 NULL,
+					},
+					.cqe = cqe,
+					.cq = cq,
+				};
+
+				mlx5e_devtx_complete_xdp(&ctx.devtx, xdpi.frame.xdpf);
+			}
+
 			dma_unmap_single(sq->pdev, dma_addr,
 					 xdpf->len, DMA_TO_DEVICE);
 			if (xdp_frame_has_frags(xdpf)) {
@@ -659,6 +766,24 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
+				if (devtx_enabled()) {
+					struct xdp_frame frame = {
+						.data = page,
+						.len = PAGE_SIZE,
+						.metasize = sq->xsk_pool->tx_metadata_len,
+					};
+
+					struct mlx5e_devtx_ctx ctx = {
+						.devtx = {
+							.netdev = sq->cq.netdev,
+						},
+						.cqe = cqe,
+						.cq = cq,
+					};
+
+					mlx5e_devtx_complete_xdp(&ctx.devtx, &frame);
+				}
+
 				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
 				 * as we know this is a page_pool page.
 				 */
@@ -668,10 +793,32 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 
 			break;
 		}
-		case MLX5E_XDP_XMIT_MODE_XSK:
+		case MLX5E_XDP_XMIT_MODE_XSK: {
 			/* AF_XDP send */
+			struct xdp_frame frame = {};
+
+			xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
+			frame.data = xdpi.frame.xsk_head;
+			xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
+			frame.len = xdpi.frame.xsk_head_len;
+
+			if (devtx_enabled()) {
+				struct mlx5e_devtx_ctx ctx = {
+					.devtx = {
+						.netdev = sq->cq.netdev,
+					},
+					.cqe = cqe,
+					.cq = cq,
+				};
+
+				frame.metasize = sq->xsk_pool->tx_metadata_len;
+
+				mlx5e_devtx_complete_xdp(&ctx.devtx, &frame);
+			}
+
 			(*xsk_frames)++;
 			break;
+		}
 		default:
 			WARN_ON_ONCE(true);
 		}
@@ -720,7 +867,7 @@ bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq)
 
 			sqcc += wi->num_wqebbs;
 
-			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
+			mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, cq, cqe);
 		} while (!last_wqe);
 
 		if (unlikely(get_cqe_opcode(cqe) != MLX5_CQE_REQ)) {
@@ -767,7 +914,7 @@ void mlx5e_free_xdpsq_descs(struct mlx5e_xdpsq *sq)
 
 		sq->cc += wi->num_wqebbs;
 
-		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq);
+		mlx5e_free_xdpsq_desc(sq, wi, &xsk_frames, &bq, NULL, NULL);
 	}
 
 	xdp_flush_frame_bulk(&bq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index 9e8e6184f9e4..f3ea9f58273a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -82,13 +82,15 @@ enum mlx5e_xdp_xmit_mode {
  *    num, page_1, page_2, ... , page_num.
  *
  * MLX5E_XDP_XMIT_MODE_XSK:
- *    none.
+ *    frame.xsk_head + frame.xsk_head_len for header portion only.
  */
 union mlx5e_xdp_info {
 	enum mlx5e_xdp_xmit_mode mode;
 	union {
 		struct xdp_frame *xdpf;
 		dma_addr_t dma_addr;
+		void *xsk_head;
+		u32 xsk_head_len;
 	} frame;
 	union {
 		struct mlx5e_rq *rq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
index 597f319d4770..4ea1fc1aa500 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
@@ -55,6 +55,10 @@ static void mlx5e_xsk_tx_post_err(struct mlx5e_xdpsq *sq,
 
 	nopwqe = mlx5e_post_nop(&sq->wq, sq->sqn, &sq->pc);
 	mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo, *xdpi);
+	mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+			     (union mlx5e_xdp_info) { .frame.xsk_head = NULL });
+	mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+			     (union mlx5e_xdp_info) { .frame.xsk_head_len = 0 });
 	sq->doorbell_cseg = &nopwqe->ctrl;
 }
 
@@ -106,6 +110,12 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
 			mlx5e_xsk_tx_post_err(sq, &xdpi);
 		} else {
 			mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo, xdpi);
+			mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+					     (union mlx5e_xdp_info)
+					     { .frame.xsk_head = xdptxd.data });
+			mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+					     (union mlx5e_xdp_info)
+					     { .frame.xsk_head_len = xdptxd.len });
 		}
 
 		flush = true;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index c7eb6b238c2b..fc76e8efc9ea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -758,6 +758,18 @@ static void mlx5e_tx_wi_consume_fifo_skbs(struct mlx5e_txqsq *sq, struct mlx5e_t
 	for (i = 0; i < wi->num_fifo_pkts; i++) {
 		struct sk_buff *skb = mlx5e_skb_fifo_pop(&sq->db.skb_fifo);
 
+		if (devtx_enabled()) {
+			struct mlx5e_devtx_ctx ctx = {
+				.devtx = {
+					.netdev = skb->dev,
+					.sinfo = skb_shinfo(skb),
+				},
+				.cqe = cqe,
+			};
+
+			mlx5e_devtx_complete_skb(&ctx.devtx, skb);
+		}
+
 		mlx5e_consume_skb(sq, skb, cqe, napi_budget);
 	}
 }
@@ -826,6 +838,18 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 			sqcc += wi->num_wqebbs;
 
 			if (likely(wi->skb)) {
+				if (devtx_enabled()) {
+					struct mlx5e_devtx_ctx ctx = {
+						.devtx = {
+							.netdev = wi->skb->dev,
+							.sinfo = skb_shinfo(wi->skb),
+						},
+						.cqe = cqe,
+					};
+
+					mlx5e_devtx_complete_skb(&ctx.devtx, wi->skb);
+				}
+
 				mlx5e_tx_wi_dma_unmap(sq, wi, &dma_fifo_cc);
 				mlx5e_consume_skb(sq, wi->skb, cqe, napi_budget);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 88dbea6631d5..ca0c71688b88 100644
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
@@ -2277,6 +2279,8 @@ static void mlx5_core_verify_params(void)
 	}
 }
 
+DEFINE_DEVTX_HOOKS(mlx5e);
+
 static int __init mlx5_init(void)
 {
 	int err;
@@ -2289,9 +2293,15 @@ static int __init mlx5_init(void)
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
@@ -2307,6 +2317,8 @@ static int __init mlx5_init(void)
 	mlx5_sf_driver_unregister();
 err_sf:
 	mlx5e_cleanup();
+err_devtx:
+	devtx_hooks_unregister(&mlx5e_devtx_hook_ids);
 err_debug:
 	mlx5_unregister_debugfs();
 	return err;
@@ -2314,6 +2326,7 @@ static int __init mlx5_init(void)
 
 static void __exit mlx5_cleanup(void)
 {
+	devtx_hooks_unregister(&mlx5e_devtx_hook_ids);
 	pci_unregister_driver(&mlx5_core_driver);
 	mlx5_sf_driver_unregister();
 	mlx5e_cleanup();
-- 
2.41.0.255.g8b1d071c50-goog


