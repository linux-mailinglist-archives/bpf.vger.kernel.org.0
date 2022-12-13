Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E093D64ADBC
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 03:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiLMCh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 21:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiLMCg5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 21:36:57 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A351E3C5
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 18:36:26 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u15-20020a170902e5cf00b001899d29276eso11995933plf.10
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 18:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QpcOlS8O+iuDE4q8v93o9r3bTjxxaLceef6G1IdJp60=;
        b=ZfhSnk19BzTLecLyGQAcv1E/UPDJClqPahgcrWUXPjCGZ6wOkNIYQX3CpsXcCq/zQk
         sBnWn+5kSDKD9R8+fpcYK3+Dowo912j+bgGBSSI/0HZ6PYeQGmao8IfXdgLbR4WTowER
         3Yu//BwPXc/ihwM/BEiKTCdRKdDChj8XCl/42PpLa8v6vcrVMjmkfPQcxF77FGgj7xCZ
         UDsTb5r3ZUjILHsZG6IJi59neki8ABIUbNkVb/50om+cfrbStZEBhwXyeXeQzxAp6hEX
         yOL7q1/UR53a+jZOYlP8ICwGK+S7EFesMFTUfJ1fukDLRSbJcZaf2fRjf2kvwaec4PqI
         oKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpcOlS8O+iuDE4q8v93o9r3bTjxxaLceef6G1IdJp60=;
        b=ULyfv67pYwVmlrRTBED6cEtf9Muq0EGc3yQz3HzjHOtDeeVVxL1rKEsF6MkApguJ+C
         T39D26NHHTQfvwHSVvdb7wKcK1vZ37fS1wZ8KGt+uGK8MlXzTIxr2pFvXMb5wNSyqEtj
         EGAsBs+2pLcxhkpbj9pBrNUqXyA9LVMWtlKg2eIEYCzl41KwVBE6WWe0/C/0zfiyif1t
         u+3PpuqPdIvDRappQUlMtej4BV6D9eVvm+HFubkYnT+0/w2y8509G3zyrJ9+SzuqzSNl
         DuYN5dQHiur+K83MaCq8gxnk5X9Kzybl9BV5zVV9dhxl5P5Xqr102Y4jJSdcwsH7keez
         gM0g==
X-Gm-Message-State: ANoB5pnq9qJ6nleaiObKlq7GgbuGFoOHL4gEAVirW3YJurAQEh7PDYYP
        OAwOWGnE+kVpF8aVqdklW79fmwbelh4rZWSQ/yvEz7PUPE/1b6W0Gln1VkqCGt2+zV6Jxuebg3o
        fGLPE0dUSmsyJGOyzreynOxZNkqJZbxWNWeOtYi7dDE6FOorYAQ==
X-Google-Smtp-Source: AA0mqf4KekH88SFJ0ktqphFkTc4elIpJE6hYad5/nf4FGPzvo6ReWFOd39PCP1S3NPxsZv3q/jweyDA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:4fc6:b0:21a:a0f:6acc with SMTP id
 q64-20020a17090a4fc600b0021a0a0f6accmr175898pjh.77.1670898985610; Mon, 12 Dec
 2022 18:36:25 -0800 (PST)
Date:   Mon, 12 Dec 2022 18:36:01 -0800
In-Reply-To: <20221213023605.737383-1-sdf@google.com>
Mime-Version: 1.0
References: <20221213023605.737383-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213023605.737383-12-sdf@google.com>
Subject: [PATCH bpf-next v4 11/15] net/mlx4_en: Support RX XDP metadata
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

Cc: Tariq Toukan <tariqt@nvidia.com>
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
index e132ff4c82f2..2f8ef0b30083 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -788,10 +788,15 @@ void mlx4_en_update_pfc_stats_bitmap(struct mlx4_dev *dev,
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
2.39.0.rc1.256.g54fd8350bd-goog

