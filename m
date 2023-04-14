Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401536E1BAE
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 07:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjDNF15 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 01:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNF1z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 01:27:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9F6189;
        Thu, 13 Apr 2023 22:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681450071; x=1712986071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=05el0GbmvDR3YWRdVeSlvCTQiybog2+7dMjJ1CLpvxg=;
  b=nTc9yctehFJOFBvxD/eP2PRoCUbQ1k4HFKnk13dXugfwgiwLQxmgQbV+
   W8Q8LiFnN5y0ebJfCN9UzZIrm1EAFoqAVUmSkbd3XIGDUXJTGIvincY7a
   Mh5Ev2rUw0cYbamFtl7pYgNJeRlCn4NNbOXNxu0nt3DJbBAXFjGTqv+y9
   uU7t5RYWrbKWf6fHuU6u2mzAdH3NJ2d42D6HwPCMY8yAaHMrQQnPwJ0U9
   w14IE3wVbgBjzFMk3ThM50QCUn/wTnmzlwGgciNiyDzt61j0PsaN13Lej
   Y21rv8kwGQ/HPuq94vx5iRfPdp4MFtTCqC55xeAk7Sve3skjYfsh6/y5z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="333152726"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="333152726"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 22:27:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692234164"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692234164"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2023 22:27:45 -0700
From:   Song Yoong Siang <yoong.siang.song@intel.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xdp-hints@xdp-project.net,
        Song Yoong Siang <yoong.siang.song@intel.com>
Subject: [PATCH net-next v5 2/3] net: stmmac: add Rx HWTS metadata to XDP receive pkt
Date:   Fri, 14 Apr 2023 13:26:50 +0800
Message-Id: <20230414052651.1871424-3-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414052651.1871424-1-yoong.siang.song@intel.com>
References: <20230414052651.1871424-1-yoong.siang.song@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add receive hardware timestamp metadata support via kfunc to XDP receive
packets.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 40 ++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index ac8ccf851708..826ac0ec88c6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -94,6 +94,9 @@ struct stmmac_rx_buffer {
 
 struct stmmac_xdp_buff {
 	struct xdp_buff xdp;
+	struct stmmac_priv *priv;
+	struct dma_desc *p;
+	struct dma_desc *np;
 };
 
 struct stmmac_rx_queue {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 10b9f8912bb2..74f78e5537a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5313,10 +5313,15 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
-					 buf->page_offset, buf1_len, false);
+					 buf->page_offset, buf1_len, true);
 
 			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
 				  buf->page_offset;
+
+			ctx.priv = priv;
+			ctx.p = p;
+			ctx.np = np;
+
 			skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
 			/* Due xdp_adjust_tail: DMA sync for_device
 			 * cover max len CPU touch
@@ -7060,6 +7065,37 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable)
 	}
 }
 
+static int stmmac_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
+{
+	const struct stmmac_xdp_buff *ctx = (void *)_ctx;
+	struct stmmac_priv *priv = ctx->priv;
+	struct dma_desc *desc = ctx->p;
+	struct dma_desc *np = ctx->np;
+	struct dma_desc *p = ctx->p;
+	u64 ns = 0;
+
+	if (!priv->hwts_rx_en)
+		return -ENODATA;
+
+	/* For GMAC4, the valid timestamp is from CTX next desc. */
+	if (priv->plat->has_gmac4 || priv->plat->has_xgmac)
+		desc = np;
+
+	/* Check if timestamp is available */
+	if (stmmac_get_rx_timestamp_status(priv, p, np, priv->adv_ts)) {
+		stmmac_get_timestamp(priv, desc, priv->adv_ts, &ns);
+		ns -= priv->plat->cdc_error_adj;
+		*timestamp = ns_to_ktime(ns);
+		return 0;
+	}
+
+	return -ENODATA;
+}
+
+static const struct xdp_metadata_ops stmmac_xdp_metadata_ops = {
+	.xmo_rx_timestamp		= stmmac_xdp_rx_timestamp,
+};
+
 /**
  * stmmac_dvr_probe
  * @device: device pointer
@@ -7167,6 +7203,8 @@ int stmmac_dvr_probe(struct device *device,
 
 	ndev->netdev_ops = &stmmac_netdev_ops;
 
+	ndev->xdp_metadata_ops = &stmmac_xdp_metadata_ops;
+
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			    NETIF_F_RXCSUM;
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-- 
2.34.1

