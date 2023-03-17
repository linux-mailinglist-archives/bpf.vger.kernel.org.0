Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503F26BEB5E
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 15:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjCQOeU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCQOeT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 10:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18B94C6F9
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679063603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hod61mZylfu08wdEEk6UggnUEIv87DpGjABXJuZEIeE=;
        b=JLagPBqeeM2tHSkFPc5CskYeepAR0iLwUoyTlcK2yKbjYMIjEuNzwWjHznc1bRrEx0kEFH
        L8Q5W/LyQxv4px19T9aiRV+broHBXeHHWBykzqN8ytnpN/hKigfwcensw7ncHjAooDjUv8
        sM+PtmIqsvhedykVT4doXh3TRL0V1dM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-GqEH-g7UM4WHFsrenrUXLQ-1; Fri, 17 Mar 2023 10:33:20 -0400
X-MC-Unique: GqEH-g7UM4WHFsrenrUXLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB92596DC82;
        Fri, 17 Mar 2023 14:33:16 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 725382027047;
        Fri, 17 Mar 2023 14:33:16 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id C80E630721A6C;
        Fri, 17 Mar 2023 15:33:15 +0100 (CET)
Subject: [PATCH bpf-next V1 1/7] xdp: bpf_xdp_metadata use EOPNOTSUPP for no
 driver support
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com
Date:   Fri, 17 Mar 2023 15:33:15 +0100
Message-ID: <167906359575.2706833.545256364239637451.stgit@firesoul>
In-Reply-To: <167906343576.2706833.17489167761084071890.stgit@firesoul>
References: <167906343576.2706833.17489167761084071890.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When driver doesn't implement a bpf_xdp_metadata kfunc the fallback
implementation returns EOPNOTSUPP, which indicate device driver doesn't
implement this kfunc.

Currently many drivers also return EOPNOTSUPP when the hint isn't
available, which is inconsistent from an API point of view. Instead
change drivers to return ENODATA in these cases.

There can be natural cases why a driver doesn't provide any hardware
info for a specific hint, even on a frame to frame basis (e.g. PTP).
Lets keep these cases as separate return codes.

When describing the return values, adjust the function kernel-doc layout
to get proper rendering for the return values.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 Documentation/networking/xdp-rx-metadata.rst     |    7 +++++--
 drivers/net/ethernet/mellanox/mlx4/en_rx.c       |    4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |    4 ++--
 drivers/net/veth.c                               |    4 ++--
 net/core/xdp.c                                   |   10 ++++++++--
 5 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index aac63fc2d08b..25ce72af81c2 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -23,10 +23,13 @@ metadata is supported, this set will grow:
 An XDP program can use these kfuncs to read the metadata into stack
 variables for its own consumption. Or, to pass the metadata on to other
 consumers, an XDP program can store it into the metadata area carried
-ahead of the packet.
+ahead of the packet. Not all packets will necessary have the requested
+metadata available in which case the driver returns ``-ENODATA``.
 
 Not all kfuncs have to be implemented by the device driver; when not
-implemented, the default ones that return ``-EOPNOTSUPP`` will be used.
+implemented, the default ones that return ``-EOPNOTSUPP`` will be used
+to indicate the device driver have not implemented this kfunc.
+
 
 Within an XDP frame, the metadata layout (accessed via ``xdp_buff``) is
 as follows::
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 0869d4fff17b..4b5e459b6d49 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -674,7 +674,7 @@ int mlx4_en_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 	struct mlx4_en_xdp_buff *_ctx = (void *)ctx;
 
 	if (unlikely(_ctx->ring->hwtstamp_rx_filter != HWTSTAMP_FILTER_ALL))
-		return -EOPNOTSUPP;
+		return -ENODATA;
 
 	*timestamp = mlx4_en_get_hwtstamp(_ctx->mdev,
 					  mlx4_en_get_cqe_ts(_ctx->cqe));
@@ -686,7 +686,7 @@ int mlx4_en_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash)
 	struct mlx4_en_xdp_buff *_ctx = (void *)ctx;
 
 	if (unlikely(!(_ctx->dev->features & NETIF_F_RXHASH)))
-		return -EOPNOTSUPP;
+		return -ENODATA;
 
 	*hash = be32_to_cpu(_ctx->cqe->immed_rss_invalid);
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index bcd6370de440..c5dae48b7932 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -162,7 +162,7 @@ static int mlx5e_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 	const struct mlx5e_xdp_buff *_ctx = (void *)ctx;
 
 	if (unlikely(!mlx5e_rx_hw_stamp(_ctx->rq->tstamp)))
-		return -EOPNOTSUPP;
+		return -ENODATA;
 
 	*timestamp =  mlx5e_cqe_ts_to_ns(_ctx->rq->ptp_cyc2time,
 					 _ctx->rq->clock, get_cqe_ts(_ctx->cqe));
@@ -174,7 +174,7 @@ static int mlx5e_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash)
 	const struct mlx5e_xdp_buff *_ctx = (void *)ctx;
 
 	if (unlikely(!(_ctx->xdp.rxq->dev->features & NETIF_F_RXHASH)))
-		return -EOPNOTSUPP;
+		return -ENODATA;
 
 	*hash = be32_to_cpu(_ctx->cqe->rss_hash_result);
 	return 0;
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1bb54de7124d..046461ee42ea 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1610,7 +1610,7 @@ static int veth_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 	struct veth_xdp_buff *_ctx = (void *)ctx;
 
 	if (!_ctx->skb)
-		return -EOPNOTSUPP;
+		return -ENODATA;
 
 	*timestamp = skb_hwtstamps(_ctx->skb)->hwtstamp;
 	return 0;
@@ -1621,7 +1621,7 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash)
 	struct veth_xdp_buff *_ctx = (void *)ctx;
 
 	if (!_ctx->skb)
-		return -EOPNOTSUPP;
+		return -ENODATA;
 
 	*hash = skb_get_hash(_ctx->skb);
 	return 0;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 8d3ad315f18d..7133017bcd74 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -705,7 +705,10 @@ __diag_ignore_all("-Wmissing-prototypes",
  * @ctx: XDP context pointer.
  * @timestamp: Return value pointer.
  *
- * Returns 0 on success or ``-errno`` on error.
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
+ * * ``-ENODATA``    : means no RX-timestamp available for this frame
  */
 __bpf_kfunc int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 {
@@ -717,7 +720,10 @@ __bpf_kfunc int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *tim
  * @ctx: XDP context pointer.
  * @hash: Return value pointer.
  *
- * Returns 0 on success or ``-errno`` on error.
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : means device driver doesn't implement kfunc
+ * * ``-ENODATA``    : means no RX-hash available for this frame
  */
 __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
 {


