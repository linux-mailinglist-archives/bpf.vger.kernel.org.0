Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726D56667C1
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 01:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjALAeL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 19:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjALAdZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 19:33:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B859341672
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:32:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k18-20020a25e812000000b0077cc9ab9dd9so17667472ybd.8
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIXyTcFXIoT0THvwVfE0q19KqLiL+JhYWH6S0QvGGK0=;
        b=bpVcDLaLx298wEZ/1dT/mqs7m6/voAAzFv/4zOzccUpe3pVvXM0RyE5fPqidTlp5zd
         xZyXfyIJN+cu+Fmi9Xp+UYak+1b8gOyKHND0ogJaLcsbfYZ+RN/AxJ+KBmoP5h0asbFK
         t6vnpep2nz8JMzrYNwromy5K086V+CP9vr7IO/e2u+ZgZ6FgSVgBtpy0PdNwVzBy+sCD
         mzcWGyIOOoEsL4udYdqrkag3qYMtJIIgOw9W61cZfIIY5vy/KPgqyj0WGZxrXkGwLl6W
         ne7TYeVUn7K68gOkLc5ah8QtGoZ8zQaxzSNjDjwJfHgqv6SJjwhBQo2cLyBYzVR4GoUC
         uZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIXyTcFXIoT0THvwVfE0q19KqLiL+JhYWH6S0QvGGK0=;
        b=f6C6EncUAKZ8ocxRentOnI1fNJggGtt3+l7vXIpZoV+adzHIL2VBpHtU9wG+mMYd+W
         M+rpnFam9x6mpmMq6TBwt8upm7q+1QGzAoc5LpAuSQTBrIu6e8732mqGttPX9PPMLZ3F
         DQKJScjMQQ7QQwaam+w9LM9xYyBpJMDM/pogcQ8SK/akdoeMAXIXhw6DjSz8cA18fppI
         vlReQep+GIVNBfh66qMjERPUfk2A5qdx8Et718j2LJ+VCyw6Yia0L14uTFr6cd0uKE7L
         6VIrFLL1EhKO0nPRYEYLcZi/IAuKrRUJ00/H+bMYDBexGIl2WgOj3IR98RqQdsuvCdca
         hvVg==
X-Gm-Message-State: AFqh2kpc8jQPl43t+oXgDXvY8M5nl+76W9gPEV0Lspm2oCUf9pqAX4Dz
        7K/djYCm0zWP/3aB/6D6Xs1rRhfxlEOeASSJdtigoAYUThiEPSJntC9D61uhkBCn3fLYbIbS07Q
        6BiG+VytnN7v8DGOx0PwZCN/hwfuC+9tAbHAqtNQ6nIHVrOdj4g==
X-Google-Smtp-Source: AMrXdXuTNloDI9lsFevQNjZX+2QB9983NIv6XfX4t2aSiGlXUKAbpzH2goXiWhZdgf6I15USizGKt4I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:7e83:0:b0:7c8:140f:3c1b with SMTP id
 z125-20020a257e83000000b007c8140f3c1bmr92576ybc.575.1673483578896; Wed, 11
 Jan 2023 16:32:58 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:32:29 -0800
In-Reply-To: <20230112003230.3779451-1-sdf@google.com>
Mime-Version: 1.0
References: <20230112003230.3779451-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230112003230.3779451-17-sdf@google.com>
Subject: [PATCH bpf-next v7 16/17] net/mlx5e: Support RX XDP metadata
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        "=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Support RX hash and timestamp metadata kfuncs. We need to pass in the cqe
pointer to the mlx5e_skb_from* functions so it can be retrieved from the
XDP ctx to do this.

Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>
Cc: xdp-hints@xdp-project.net
Cc: netdev@vger.kernel.org
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  5 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  5 ++
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 23 +++++++++
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  5 ++
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   | 10 ++++
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.h   |  2 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  6 +++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 49 ++++++++++---------
 8 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/eth=
ernet/mellanox/mlx5/core/en.h
index af663978d1b4..6de02d8aeab8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -627,10 +627,11 @@ struct mlx5e_rq;
 typedef void (*mlx5e_fp_handle_rx_cqe)(struct mlx5e_rq*, struct mlx5_cqe64=
*);
 typedef struct sk_buff *
 (*mlx5e_fp_skb_from_cqe_mpwrq)(struct mlx5e_rq *rq, struct mlx5e_mpw_info =
*wi,
-			       u16 cqe_bcnt, u32 head_offset, u32 page_idx);
+			       struct mlx5_cqe64 *cqe, u16 cqe_bcnt,
+			       u32 head_offset, u32 page_idx);
 typedef struct sk_buff *
 (*mlx5e_fp_skb_from_cqe)(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *=
wi,
-			 u32 cqe_bcnt);
+			 struct mlx5_cqe64 *cqe, u32 cqe_bcnt);
 typedef bool (*mlx5e_fp_post_rx_wqes)(struct mlx5e_rq *rq);
 typedef void (*mlx5e_fp_dealloc_wqe)(struct mlx5e_rq*, u16);
 typedef void (*mlx5e_fp_shampo_dealloc_hd)(struct mlx5e_rq*, u16, u16, boo=
l);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en/txrx.h
index 853f312cd757..757c012ece27 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -73,6 +73,11 @@ int mlx5e_poll_rx_cq(struct mlx5e_cq *cq, int budget);
 void mlx5e_free_rx_descs(struct mlx5e_rq *rq);
 void mlx5e_free_rx_in_progress_descs(struct mlx5e_rq *rq);
=20
+static inline bool mlx5e_rx_hw_stamp(struct hwtstamp_config *config)
+{
+	return config->rx_filter =3D=3D HWTSTAMP_FILTER_ALL;
+}
+
 /* TX */
 netdev_tx_t mlx5e_xmit(struct sk_buff *skb, struct net_device *dev);
 bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net=
/ethernet/mellanox/mlx5/core/en/xdp.c
index 31bb6806bf5d..d10d31e12ba2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -156,6 +156,29 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx=
5e_rq *rq,
 	return true;
 }
=20
+int mlx5e_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
+{
+	const struct mlx5e_xdp_buff *_ctx =3D (void *)ctx;
+
+	if (unlikely(!mlx5e_rx_hw_stamp(_ctx->rq->tstamp)))
+		return -EOPNOTSUPP;
+
+	*timestamp =3D  mlx5e_cqe_ts_to_ns(_ctx->rq->ptp_cyc2time,
+					 _ctx->rq->clock, get_cqe_ts(_ctx->cqe));
+	return 0;
+}
+
+int mlx5e_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash)
+{
+	const struct mlx5e_xdp_buff *_ctx =3D (void *)ctx;
+
+	if (unlikely(!(_ctx->xdp.rxq->dev->features & NETIF_F_RXHASH)))
+		return -EOPNOTSUPP;
+
+	*hash =3D be32_to_cpu(_ctx->cqe->rss_hash_result);
+	return 0;
+}
+
 /* returns true if packet was consumed by xdp */
 bool mlx5e_xdp_handle(struct mlx5e_rq *rq, struct page *page,
 		      struct bpf_prog *prog, struct mlx5e_xdp_buff *mxbuf)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net=
/ethernet/mellanox/mlx5/core/en/xdp.h
index 389818bf6833..cb568c62aba0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -46,6 +46,8 @@
=20
 struct mlx5e_xdp_buff {
 	struct xdp_buff xdp;
+	struct mlx5_cqe64 *cqe;
+	struct mlx5e_rq *rq;
 };
=20
 struct mlx5e_xsk_param;
@@ -60,6 +62,9 @@ void mlx5e_xdp_rx_poll_complete(struct mlx5e_rq *rq);
 int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frame=
s,
 		   u32 flags);
=20
+int mlx5e_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp);
+int mlx5e_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash);
+
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdp=
sq *sq,
 							  struct mlx5e_xmit_data *xdptxd,
 							  struct skb_shared_info *sinfo,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 9cff82d764e3..8bf3029abd3c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -49,6 +49,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 			umr_wqe->inline_mtts[i] =3D (struct mlx5_mtt) {
 				.ptag =3D cpu_to_be64(addr | MLX5_EN_WR),
 			};
+			wi->alloc_units[i].mxbuf->rq =3D rq;
 		}
 	} else if (unlikely(rq->mpwqe.umr_mode =3D=3D MLX5E_MPWRQ_UMR_MODE_UNALIG=
NED)) {
 		for (i =3D 0; i < batch; i++) {
@@ -58,6 +59,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 				.key =3D rq->mkey_be,
 				.va =3D cpu_to_be64(addr),
 			};
+			wi->alloc_units[i].mxbuf->rq =3D rq;
 		}
 	} else if (likely(rq->mpwqe.umr_mode =3D=3D MLX5E_MPWRQ_UMR_MODE_TRIPLE))=
 {
 		u32 mapping_size =3D 1 << (rq->mpwqe.page_shift - 2);
@@ -81,6 +83,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 				.key =3D rq->mkey_be,
 				.va =3D cpu_to_be64(rq->wqe_overflow.addr),
 			};
+			wi->alloc_units[i].mxbuf->rq =3D rq;
 		}
 	} else {
 		__be32 pad_size =3D cpu_to_be32((1 << rq->mpwqe.page_shift) -
@@ -100,6 +103,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 i=
x)
 				.va =3D cpu_to_be64(rq->wqe_overflow.addr),
 				.bcount =3D pad_size,
 			};
+			wi->alloc_units[i].mxbuf->rq =3D rq;
 		}
 	}
=20
@@ -230,6 +234,7 @@ static struct sk_buff *mlx5e_xsk_construct_skb(struct m=
lx5e_rq *rq, struct xdp_b
=20
 struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 						    struct mlx5e_mpw_info *wi,
+						    struct mlx5_cqe64 *cqe,
 						    u16 cqe_bcnt,
 						    u32 head_offset,
 						    u32 page_idx)
@@ -250,6 +255,8 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(str=
uct mlx5e_rq *rq,
 	 */
 	WARN_ON_ONCE(head_offset);
=20
+	/* mxbuf->rq is set on allocation, but cqe is per-packet so set it here *=
/
+	mxbuf->cqe =3D cqe;
 	xsk_buff_set_size(&mxbuf->xdp, cqe_bcnt);
 	xsk_buff_dma_sync_for_cpu(&mxbuf->xdp, rq->xsk_pool);
 	net_prefetch(mxbuf->xdp.data);
@@ -284,6 +291,7 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(str=
uct mlx5e_rq *rq,
=20
 struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct mlx5e_rq *rq,
 					      struct mlx5e_wqe_frag_info *wi,
+					      struct mlx5_cqe64 *cqe,
 					      u32 cqe_bcnt)
 {
 	struct mlx5e_xdp_buff *mxbuf =3D wi->au->mxbuf;
@@ -296,6 +304,8 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct ml=
x5e_rq *rq,
 	 */
 	WARN_ON_ONCE(wi->offset);
=20
+	/* mxbuf->rq is set on allocation, but cqe is per-packet so set it here *=
/
+	mxbuf->cqe =3D cqe;
 	xsk_buff_set_size(&mxbuf->xdp, cqe_bcnt);
 	xsk_buff_dma_sync_for_cpu(&mxbuf->xdp, rq->xsk_pool);
 	net_prefetch(mxbuf->xdp.data);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h b/drivers/=
net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
index 087c943bd8e9..cefc0ef6105d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
@@ -13,11 +13,13 @@ int mlx5e_xsk_alloc_rx_wqes_batched(struct mlx5e_rq *rq=
, u16 ix, int wqe_bulk);
 int mlx5e_xsk_alloc_rx_wqes(struct mlx5e_rq *rq, u16 ix, int wqe_bulk);
 struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 						    struct mlx5e_mpw_info *wi,
+						    struct mlx5_cqe64 *cqe,
 						    u16 cqe_bcnt,
 						    u32 head_offset,
 						    u32 page_idx);
 struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct mlx5e_rq *rq,
 					      struct mlx5e_wqe_frag_info *wi,
+					      struct mlx5_cqe64 *cqe,
 					      u32 cqe_bcnt);
=20
 #endif /* __MLX5_EN_XSK_RX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_main.c
index cff5f2e29e1e..be942c060774 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4913,6 +4913,11 @@ const struct net_device_ops mlx5e_netdev_ops =3D {
 #endif
 };
=20
+static const struct xdp_metadata_ops mlx5_xdp_metadata_ops =3D {
+	.xmo_rx_timestamp		=3D mlx5e_xdp_rx_timestamp,
+	.xmo_rx_hash			=3D mlx5e_xdp_rx_hash,
+};
+
 static u32 mlx5e_choose_lro_timeout(struct mlx5_core_dev *mdev, u32 wanted=
_timeout)
 {
 	int i;
@@ -5053,6 +5058,7 @@ static void mlx5e_build_nic_netdev(struct net_device =
*netdev)
 	SET_NETDEV_DEV(netdev, mdev->device);
=20
 	netdev->netdev_ops =3D &mlx5e_netdev_ops;
+	netdev->xdp_metadata_ops =3D &mlx5_xdp_metadata_ops;
=20
 	mlx5e_dcbnl_build_netdev(netdev);
=20
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/=
ethernet/mellanox/mlx5/core/en_rx.c
index 6affdddf5bcf..7b08653be000 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -62,10 +62,12 @@
=20
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info=
 *wi,
-				u16 cqe_bcnt, u32 head_offset, u32 page_idx);
+				struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
+				u32 page_idx);
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_i=
nfo *wi,
-				   u16 cqe_bcnt, u32 head_offset, u32 page_idx);
+				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
+				   u32 page_idx);
 static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq=
e);
 static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe=
64 *cqe);
 static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct m=
lx5_cqe64 *cqe);
@@ -76,11 +78,6 @@ const struct mlx5e_rx_handlers mlx5e_rx_handlers_nic =3D=
 {
 	.handle_rx_cqe_mpwqe_shampo =3D mlx5e_handle_rx_cqe_mpwrq_shampo,
 };
=20
-static inline bool mlx5e_rx_hw_stamp(struct hwtstamp_config *config)
-{
-	return config->rx_filter =3D=3D HWTSTAMP_FILTER_ALL;
-}
-
 static inline void mlx5e_read_cqe_slot(struct mlx5_cqwq *wq,
 				       u32 cqcc, void *data)
 {
@@ -1575,16 +1572,19 @@ struct sk_buff *mlx5e_build_linear_skb(struct mlx5e=
_rq *rq, void *va,
 	return skb;
 }
=20
-static void mlx5e_fill_mxbuf(struct mlx5e_rq *rq, void *va, u16 headroom,
-			     u32 len, struct mlx5e_xdp_buff *mxbuf)
+static void mlx5e_fill_mxbuf(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
+			     void *va, u16 headroom, u32 len,
+			     struct mlx5e_xdp_buff *mxbuf)
 {
 	xdp_init_buff(&mxbuf->xdp, rq->buff.frame0_sz, &rq->xdp_rxq);
 	xdp_prepare_buff(&mxbuf->xdp, va, headroom, len, true);
+	mxbuf->cqe =3D cqe;
+	mxbuf->rq =3D rq;
 }
=20
 static struct sk_buff *
 mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info =
*wi,
-			  u32 cqe_bcnt)
+			  struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
 {
 	union mlx5e_alloc_unit *au =3D wi->au;
 	u16 rx_headroom =3D rq->buff.headroom;
@@ -1630,7 +1630,7 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct=
 mlx5e_wqe_frag_info *wi,
=20
 static struct sk_buff *
 mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_in=
fo *wi,
-			     u32 cqe_bcnt)
+			     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
 {
 	struct mlx5e_rq_frag_info *frag_info =3D &rq->wqe.info.arr[0];
 	struct mlx5e_wqe_frag_info *head_wi =3D wi;
@@ -1654,7 +1654,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, str=
uct mlx5e_wqe_frag_info *wi
 	net_prefetchw(va); /* xdp_frame data area */
 	net_prefetch(va + rx_headroom);
=20
-	mlx5e_fill_mxbuf(rq, va, rx_headroom, frag_consumed_bytes, &mxbuf);
+	mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, frag_consumed_bytes, &mxbuf);
 	sinfo =3D xdp_get_shared_info_from_buff(&mxbuf.xdp);
 	truesize =3D 0;
=20
@@ -1777,7 +1777,7 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, =
struct mlx5_cqe64 *cqe)
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
 			      mlx5e_xsk_skb_from_cqe_linear,
-			      rq, wi, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt);
 	if (!skb) {
 		/* probably for XDP */
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
@@ -1830,7 +1830,7 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *=
rq, struct mlx5_cqe64 *cqe)
 	skb =3D INDIRECT_CALL_2(rq->wqe.skb_from_cqe,
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
-			      rq, wi, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt);
 	if (!skb) {
 		/* probably for XDP */
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
@@ -1889,7 +1889,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5=
e_rq *rq, struct mlx5_cqe64
 	skb =3D INDIRECT_CALL_2(rq->mpwqe.skb_from_cqe_mpwrq,
 			      mlx5e_skb_from_cqe_mpwrq_linear,
 			      mlx5e_skb_from_cqe_mpwrq_nonlinear,
-			      rq, wi, cqe_bcnt, head_offset, page_idx);
+			      rq, wi, cqe, cqe_bcnt, head_offset, page_idx);
 	if (!skb)
 		goto mpwrq_cqe_out;
=20
@@ -1940,7 +1940,8 @@ mlx5e_fill_skb_data(struct sk_buff *skb, struct mlx5e=
_rq *rq,
=20
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_i=
nfo *wi,
-				   u16 cqe_bcnt, u32 head_offset, u32 page_idx)
+				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
+				   u32 page_idx)
 {
 	union mlx5e_alloc_unit *au =3D &wi->alloc_units[page_idx];
 	u16 headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
@@ -1979,7 +1980,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *r=
q, struct mlx5e_mpw_info *w
=20
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info=
 *wi,
-				u16 cqe_bcnt, u32 head_offset, u32 page_idx)
+				struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
+				u32 page_idx)
 {
 	union mlx5e_alloc_unit *au =3D &wi->alloc_units[page_idx];
 	u16 rx_headroom =3D rq->buff.headroom;
@@ -2010,7 +2012,7 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, =
struct mlx5e_mpw_info *wi,
 		struct mlx5e_xdp_buff mxbuf;
=20
 		net_prefetchw(va); /* xdp_frame data area */
-		mlx5e_fill_mxbuf(rq, va, rx_headroom, cqe_bcnt, &mxbuf);
+		mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, cqe_bcnt, &mxbuf);
 		if (mlx5e_xdp_handle(rq, au->page, prog, &mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
 				__set_bit(page_idx, wi->xdp_xmit_bitmap); /* non-atomic */
@@ -2174,8 +2176,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct m=
lx5e_rq *rq, struct mlx5_cq
 		if (likely(head_size))
 			*skb =3D mlx5e_skb_from_cqe_shampo(rq, wi, cqe, header_index);
 		else
-			*skb =3D mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe_bcnt, data_offs=
et,
-								  page_idx);
+			*skb =3D mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe, cqe_bcnt,
+								  data_offset, page_idx);
 		if (unlikely(!*skb))
 			goto free_hd_entry;
=20
@@ -2249,7 +2251,8 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq=
 *rq, struct mlx5_cqe64 *cq
 			      mlx5e_skb_from_cqe_mpwrq_linear,
 			      mlx5e_skb_from_cqe_mpwrq_nonlinear,
 			      mlx5e_xsk_skb_from_cqe_mpwrq_linear,
-			      rq, wi, cqe_bcnt, head_offset, page_idx);
+			      rq, wi, cqe, cqe_bcnt, head_offset,
+			      page_idx);
 	if (!skb)
 		goto mpwrq_cqe_out;
=20
@@ -2494,7 +2497,7 @@ static void mlx5i_handle_rx_cqe(struct mlx5e_rq *rq, =
struct mlx5_cqe64 *cqe)
 	skb =3D INDIRECT_CALL_2(rq->wqe.skb_from_cqe,
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
-			      rq, wi, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt);
 	if (!skb)
 		goto wq_free_wqe;
=20
@@ -2586,7 +2589,7 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq =
*rq, struct mlx5_cqe64 *cqe
 		goto free_wqe;
 	}
=20
-	skb =3D mlx5e_skb_from_cqe_nonlinear(rq, wi, cqe_bcnt);
+	skb =3D mlx5e_skb_from_cqe_nonlinear(rq, wi, cqe, cqe_bcnt);
 	if (!skb)
 		goto free_wqe;
=20
--=20
2.39.0.314.g84b9a713c41-goog

