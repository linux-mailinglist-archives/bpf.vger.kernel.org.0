Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BF06528F0
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 23:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiLTWWq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 17:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiLTWWF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 17:22:05 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F341F9E0
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 14:21:09 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id g1-20020a636b01000000b00479222d9875so7851900pgc.12
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 14:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZD7d/ZFHMYivTnjWbSLJTGE8VEiskoYNU48VWuqPnU=;
        b=AWDhz/gWsPh8KGFp6T1EGfYutAB0EGFDARxg0MAhDIt7fgSdENwsdxKsh7vKHJgKmD
         CwY3aA47JHDBG9EJYPuyOjrlYlL2h9yvWqvkiV6xuhm5avWsHrpOUQ/uwgSYcE1iuDqR
         LQJovJxQ7aE5D8GRs1FsPbqnKqlFulRCkEcIgvLA6/WcBBV2ng/DfaN9PR2mLlT1X/Dk
         TqKcuVScnhdJFrwbWD00ny8Yz3tTjBijfxAwv6QAe0Mnav2HgW4Aby19DP21AByoYRY3
         qtslW1topbKl1P7kKkqPNs0JtF9113TPx7Qio2iXVHamgbPdT9eaMcwIVy2yeU1m5jm0
         34dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZD7d/ZFHMYivTnjWbSLJTGE8VEiskoYNU48VWuqPnU=;
        b=gTIYK7QDIlmTydHJo3Luyz1JoxjNY/ZfFTzL7V0NeLtD+ODpQYHTaZbZ9sxZnXyrpO
         1Xj5UsEVWNQt/XUs6upOJlicezVgcRSpZSRF+3kLUdLv1lgQf4zU6uDrsdzebpRB/wxV
         WgsBEpNGjKKI1emXYc3vFH9kMC0uzB2vtkSEENaKJgYPb92wV6IUpEXc4Rc0rbZefurb
         96XordrfCbGTq0Bi/Wfhn6JOxvlaX7gQtbq3lJRMrjtS4Zx1iml105TdGY1g/a7PtHJG
         qntDU+Yx1l+cwEffgv7DFB5P/s6FfJ5EHgUNun9Za3WMdE3w3xqyh5OF3IdZ5rAPIYlJ
         wXQA==
X-Gm-Message-State: AFqh2koEIw2tYV8M0Kj+X+ZAouvDMWAD6Mza6NaHNxnCXLdSMMDK86TS
        Kh13UDawdAkDp0qL+D9fnsNh9id6Ew0cwnUQW5hzfX/MPQBKMIm5dMbjjGlaCBYKxaBP76HrFnH
        Oa90qi4FFT56PlLc7i6aFwxbhiDZ6yJEBxtWKNgiQGvZ1ak/+/w==
X-Google-Smtp-Source: AA0mqf7fJCjdzB/od6Di8HAFZZqTMR0Urt4HmrCtIHHt0PYnASibMy79aCxgM2t6czzGJj6rlcZu5vw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:914:b0:219:a1e4:20e2 with SMTP id
 bo20-20020a17090b091400b00219a1e420e2mr2382259pjb.182.1671574868832; Tue, 20
 Dec 2022 14:21:08 -0800 (PST)
Date:   Tue, 20 Dec 2022 14:20:39 -0800
In-Reply-To: <20221220222043.3348718-1-sdf@google.com>
Mime-Version: 1.0
References: <20221220222043.3348718-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220222043.3348718-14-sdf@google.com>
Subject: [PATCH bpf-next v5 13/17] net/mlx4_en: Support RX XDP metadata
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

RX timestamp and hash for now. Tested using the prog from the next
patch.

Also enabling xdp metadata support; don't see why it's disabled,
there is enough headroom..

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
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 13 +++++---
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  6 ++++
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    | 33 ++++++++++++++++++-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  5 +++
 4 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index 98b5ffb4d729..9e3b76182088 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -58,9 +58,7 @@ u64 mlx4_en_get_cqe_ts(struct mlx4_cqe *cqe)
 	return hi | lo;
 }
 
-void mlx4_en_fill_hwtstamps(struct mlx4_en_dev *mdev,
-			    struct skb_shared_hwtstamps *hwts,
-			    u64 timestamp)
+u64 mlx4_en_get_hwtstamp(struct mlx4_en_dev *mdev, u64 timestamp)
 {
 	unsigned int seq;
 	u64 nsec;
@@ -70,8 +68,15 @@ void mlx4_en_fill_hwtstamps(struct mlx4_en_dev *mdev,
 		nsec = timecounter_cyc2time(&mdev->clock, timestamp);
 	} while (read_seqretry(&mdev->clock_lock, seq));
 
+	return ns_to_ktime(nsec);
+}
+
+void mlx4_en_fill_hwtstamps(struct mlx4_en_dev *mdev,
+			    struct skb_shared_hwtstamps *hwts,
+			    u64 timestamp)
+{
 	memset(hwts, 0, sizeof(struct skb_shared_hwtstamps));
-	hwts->hwtstamp = ns_to_ktime(nsec);
+	hwts->hwtstamp = mlx4_en_get_hwtstamp(mdev, timestamp);
 }
 
 /**
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 8800d3f1f55c..af4c4858f397 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -2889,6 +2889,11 @@ static const struct net_device_ops mlx4_netdev_ops_master = {
 	.ndo_bpf		= mlx4_xdp,
 };
 
+static const struct xdp_metadata_ops mlx4_xdp_metadata_ops = {
+	.xmo_rx_timestamp		= mlx4_en_xdp_rx_timestamp,
+	.xmo_rx_hash			= mlx4_en_xdp_rx_hash,
+};
+
 struct mlx4_en_bond {
 	struct work_struct work;
 	struct mlx4_en_priv *priv;
@@ -3310,6 +3315,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 		dev->netdev_ops = &mlx4_netdev_ops_master;
 	else
 		dev->netdev_ops = &mlx4_netdev_ops;
+	dev->xdp_metadata_ops = &mlx4_xdp_metadata_ops;
 	dev->watchdog_timeo = MLX4_EN_WATCHDOG_TIMEOUT;
 	netif_set_real_num_tx_queues(dev, priv->tx_ring_num[TX]);
 	netif_set_real_num_rx_queues(dev, priv->rx_ring_num);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 014a80af2813..0869d4fff17b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -663,8 +663,35 @@ static int check_csum(struct mlx4_cqe *cqe, struct sk_buff *skb, void *va,
 
 struct mlx4_en_xdp_buff {
 	struct xdp_buff xdp;
+	struct mlx4_cqe *cqe;
+	struct mlx4_en_dev *mdev;
+	struct mlx4_en_rx_ring *ring;
+	struct net_device *dev;
 };
 
+int mlx4_en_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
+{
+	struct mlx4_en_xdp_buff *_ctx = (void *)ctx;
+
+	if (unlikely(_ctx->ring->hwtstamp_rx_filter != HWTSTAMP_FILTER_ALL))
+		return -EOPNOTSUPP;
+
+	*timestamp = mlx4_en_get_hwtstamp(_ctx->mdev,
+					  mlx4_en_get_cqe_ts(_ctx->cqe));
+	return 0;
+}
+
+int mlx4_en_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash)
+{
+	struct mlx4_en_xdp_buff *_ctx = (void *)ctx;
+
+	if (unlikely(!(_ctx->dev->features & NETIF_F_RXHASH)))
+		return -EOPNOTSUPP;
+
+	*hash = be32_to_cpu(_ctx->cqe->immed_rss_invalid);
+	return 0;
+}
+
 int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int budget)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
@@ -781,8 +808,12 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 						DMA_FROM_DEVICE);
 
 			xdp_prepare_buff(&mxbuf.xdp, va - frags[0].page_offset,
-					 frags[0].page_offset, length, false);
+					 frags[0].page_offset, length, true);
 			orig_data = mxbuf.xdp.data;
+			mxbuf.cqe = cqe;
+			mxbuf.mdev = priv->mdev;
+			mxbuf.ring = ring;
+			mxbuf.dev = dev;
 
 			act = bpf_prog_run_xdp(xdp_prog, &mxbuf.xdp);
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index 3d4226ddba5e..544e09b97483 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -796,10 +796,15 @@ void mlx4_en_update_pfc_stats_bitmap(struct mlx4_dev *dev,
 int mlx4_en_netdev_event(struct notifier_block *this,
 			 unsigned long event, void *ptr);
 
+struct xdp_md;
+int mlx4_en_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp);
+int mlx4_en_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash);
+
 /*
  * Functions for time stamping
  */
 u64 mlx4_en_get_cqe_ts(struct mlx4_cqe *cqe);
+u64 mlx4_en_get_hwtstamp(struct mlx4_en_dev *mdev, u64 timestamp);
 void mlx4_en_fill_hwtstamps(struct mlx4_en_dev *mdev,
 			    struct skb_shared_hwtstamps *hwts,
 			    u64 timestamp);
-- 
2.39.0.314.g84b9a713c41-goog

