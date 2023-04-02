Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0006D3646
	for <lists+bpf@lfdr.de>; Sun,  2 Apr 2023 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjDBIb0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjDBIbV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 04:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFED518FB6
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680424196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3MHHqoOS7n/QXgQznavf8gFNBnx4z6OXd+WEJfItp8=;
        b=MjKdF2g6CG3s9kJAf9LBaEanRphHa6iGGZoWO1l2dl1OeP3SbmvQhp9SKSKfAE31stBC6H
        0indNOy96PY1D25RJOpuZJ5P0uRwjw+tT7pfCDWY+uQnxnKP64TYFreaOjkIou3fy4IsxH
        yeb+x8T6iUfRIgsvoSTpZNo6Jx4DFCg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-t8L6YBCzMbatZ6VmBXwqTg-1; Sun, 02 Apr 2023 04:29:51 -0400
X-MC-Unique: t8L6YBCzMbatZ6VmBXwqTg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AAE429ABA07;
        Sun,  2 Apr 2023 08:29:50 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3317D400F4F;
        Sun,  2 Apr 2023 08:29:49 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 4BAEA30736C72;
        Sun,  2 Apr 2023 10:29:48 +0200 (CEST)
Subject: [PATCH bpf V6 2/5] mlx5: bpf_xdp_metadata_rx_hash add xdp rss hash
 type
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net, tariqt@nvidia.com, saeedm@nvidia.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Date:   Sun, 02 Apr 2023 10:29:48 +0200
Message-ID: <168042418826.4051476.17501531513091177668.stgit@firesoul>
In-Reply-To: <168042409059.4051476.8176861613304493950.stgit@firesoul>
References: <168042409059.4051476.8176861613304493950.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update API for bpf_xdp_metadata_rx_hash() with arg for xdp rss hash type
via mapping table.

The mlx5 hardware can also identify and RSS hash IPSEC.  This indicate
hash includes SPI (Security Parameters Index) as part of IPSEC hash.

Extend xdp core enum xdp_rss_hash_type with IPSEC hash type.

Fixes: bc8d405b1ba9 ("net/mlx5e: Support RX XDP metadata")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |   60 ++++++++++++++++++++++
 include/linux/mlx5/device.h                      |   14 ++++-
 include/net/xdp.h                                |    2 +
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index efe609f8e3aa..97ef1df94d50 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -34,6 +34,7 @@
 #include <net/xdp_sock_drv.h>
 #include "en/xdp.h"
 #include "en/params.h"
+#include <linux/bitfield.h>
 
 int mlx5e_xdp_max_mtu(struct mlx5e_params *params, struct mlx5e_xsk_param *xsk)
 {
@@ -169,15 +170,72 @@ static int mlx5e_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 	return 0;
 }
 
+/* Mapping HW RSS Type bits CQE_RSS_HTYPE_IP + CQE_RSS_HTYPE_L4 into 4-bits*/
+#define RSS_TYPE_MAX_TABLE	16 /* 4-bits max 16 entries */
+#define RSS_L4		GENMASK(1, 0)
+#define RSS_L3		GENMASK(3, 2) /* Same as CQE_RSS_HTYPE_IP */
+
+/* Valid combinations of CQE_RSS_HTYPE_IP + CQE_RSS_HTYPE_L4 sorted numerical */
+enum mlx5_rss_hash_type {
+	RSS_TYPE_NO_HASH	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IP_NONE) |
+				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_NONE)),
+	RSS_TYPE_L3_IPV4	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV4) |
+				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_NONE)),
+	RSS_TYPE_L4_IPV4_TCP	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV4) |
+				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_TCP)),
+	RSS_TYPE_L4_IPV4_UDP	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV4) |
+				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_UDP)),
+	RSS_TYPE_L4_IPV4_IPSEC	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV4) |
+				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_IPSEC)),
+	RSS_TYPE_L3_IPV6	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV6) |
+				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_NONE)),
+	RSS_TYPE_L4_IPV6_TCP	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV6) |
+				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_TCP)),
+	RSS_TYPE_L4_IPV6_UDP	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV6) |
+				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_UDP)),
+	RSS_TYPE_L4_IPV6_IPSEC	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV6) |
+				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_IPSEC)),
+} mlx5_rss_hash_type;
+
+/* Invalid combinations will simply return zero, allows no boundary checks */
+static const enum xdp_rss_hash_type mlx5_xdp_rss_type[RSS_TYPE_MAX_TABLE] = {
+	[RSS_TYPE_NO_HASH]	 = XDP_RSS_TYPE_NONE,
+	[1]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
+	[2]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
+	[3]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
+	[RSS_TYPE_L3_IPV4]	 = XDP_RSS_TYPE_L3_IPV4,
+	[RSS_TYPE_L4_IPV4_TCP]	 = XDP_RSS_TYPE_L4_IPV4_TCP,
+	[RSS_TYPE_L4_IPV4_UDP]	 = XDP_RSS_TYPE_L4_IPV4_UDP,
+	[RSS_TYPE_L4_IPV4_IPSEC] = XDP_RSS_TYPE_L4_IPV4_IPSEC,
+	[RSS_TYPE_L3_IPV6]	 = XDP_RSS_TYPE_L3_IPV6,
+	[RSS_TYPE_L4_IPV6_TCP]	 = XDP_RSS_TYPE_L4_IPV6_TCP,
+	[RSS_TYPE_L4_IPV6_UDP]   = XDP_RSS_TYPE_L4_IPV6_UDP,
+	[RSS_TYPE_L4_IPV6_IPSEC] = XDP_RSS_TYPE_L4_IPV6_IPSEC,
+	[12]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
+	[13]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
+	[14]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
+	[15]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
+};
+
 static int mlx5e_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 			     enum xdp_rss_hash_type *rss_type)
 {
 	const struct mlx5e_xdp_buff *_ctx = (void *)ctx;
+	const struct mlx5_cqe64 *cqe = _ctx->cqe;
+	u32 hash_type, l4_type, ip_type, lookup;
 
 	if (unlikely(!(_ctx->xdp.rxq->dev->features & NETIF_F_RXHASH)))
 		return -ENODATA;
 
-	*hash = be32_to_cpu(_ctx->cqe->rss_hash_result);
+	*hash = be32_to_cpu(cqe->rss_hash_result);
+
+	hash_type = cqe->rss_hash_type;
+	BUILD_BUG_ON(CQE_RSS_HTYPE_IP != RSS_L3); /* same mask */
+	ip_type = hash_type & CQE_RSS_HTYPE_IP;
+	l4_type = FIELD_GET(CQE_RSS_HTYPE_L4, hash_type);
+	lookup = ip_type | l4_type;
+	*rss_type = mlx5_xdp_rss_type[lookup];
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 71b06ebad402..1db19a9d26e3 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -36,6 +36,7 @@
 #include <linux/types.h>
 #include <rdma/ib_verbs.h>
 #include <linux/mlx5/mlx5_ifc.h>
+#include <linux/bitfield.h>
 
 #if defined(__LITTLE_ENDIAN)
 #define MLX5_SET_HOST_ENDIANNESS	0
@@ -980,14 +981,23 @@ enum {
 };
 
 enum {
-	CQE_RSS_HTYPE_IP	= 0x3 << 2,
+	CQE_RSS_HTYPE_IP	= GENMASK(3, 2),
 	/* cqe->rss_hash_type[3:2] - IP destination selected for hash
 	 * (00 = none,  01 = IPv4, 10 = IPv6, 11 = Reserved)
 	 */
-	CQE_RSS_HTYPE_L4	= 0x3 << 6,
+	CQE_RSS_IP_NONE		= 0x0,
+	CQE_RSS_IPV4		= 0x1,
+	CQE_RSS_IPV6		= 0x2,
+	CQE_RSS_RESERVED	= 0x3,
+
+	CQE_RSS_HTYPE_L4	= GENMASK(7, 6),
 	/* cqe->rss_hash_type[7:6] - L4 destination selected for hash
 	 * (00 = none, 01 = TCP. 10 = UDP, 11 = IPSEC.SPI
 	 */
+	CQE_RSS_L4_NONE		= 0x0,
+	CQE_RSS_L4_TCP		= 0x1,
+	CQE_RSS_L4_UDP		= 0x2,
+	CQE_RSS_L4_IPSEC	= 0x3,
 };
 
 enum {
diff --git a/include/net/xdp.h b/include/net/xdp.h
index a76c4ea203ea..76aa748e7923 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -460,10 +460,12 @@ enum xdp_rss_hash_type {
 	XDP_RSS_TYPE_L4_IPV4_TCP     = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_TCP,
 	XDP_RSS_TYPE_L4_IPV4_UDP     = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
 	XDP_RSS_TYPE_L4_IPV4_SCTP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
+	XDP_RSS_TYPE_L4_IPV4_IPSEC   = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
 
 	XDP_RSS_TYPE_L4_IPV6_TCP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_TCP,
 	XDP_RSS_TYPE_L4_IPV6_UDP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
 	XDP_RSS_TYPE_L4_IPV6_SCTP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
+	XDP_RSS_TYPE_L4_IPV6_IPSEC   = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
 
 	XDP_RSS_TYPE_L4_IPV6_TCP_EX  = XDP_RSS_TYPE_L4_IPV6_TCP  | XDP_RSS_L3_DYNHDR,
 	XDP_RSS_TYPE_L4_IPV6_UDP_EX  = XDP_RSS_TYPE_L4_IPV6_UDP  | XDP_RSS_L3_DYNHDR,


