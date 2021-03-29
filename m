Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F7F34D146
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 15:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhC2Ng5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 09:36:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:45673 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhC2Ngc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 09:36:32 -0400
IronPort-SDR: dyxDYcuema28+gfC9jIl8znU/jfa279e4tkDB23O2YZ26S16Pq/PBswyVevMqUzFRAKYfJ3MQy
 RmDKWkxb18JQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191578697"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191578697"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 06:36:32 -0700
IronPort-SDR: 9mq9iFMh9fjNGPZ+tbSSHXq3BiIR99BMTE3bxQ4VsL5Ao5enZwVn+YGLQ6/rJpHIzHRfPghxdG
 YbvcZaiHGznQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="411079357"
Received: from glass.png.intel.com ([10.158.65.59])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2021 06:36:27 -0700
From:   Ong Boon Leong <boon.leong.ong@intel.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Ong Boon Leong <boon.leong.ong@intel.com>
Subject: [PATCH net-next 2/6] net: stmmac: make SPH enable/disable to be configurable
Date:   Mon, 29 Mar 2021 21:40:09 +0800
Message-Id: <20210329134013.9516-3-boon.leong.ong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329134013.9516-1-boon.leong.ong@intel.com>
References: <20210329134013.9516-1-boon.leong.ong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SPH functionality splits header and payload according to split mode and
offsef fields (SPLM and SPLOFST). It is beneficials for Linux network
stack RX processing however it adds a lot of complexity in XDP
processing.

So, this patch makes the split-header (SPH) capability of the controller
is stored in "priv->sph_cap" and the enabling/disabling of SPH is decided
by "priv->sph".

This is to prepare initial XDP enabling for stmmac to disable the use of
SPH whenever XDP is enabled.

Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 9966f6f10905..e293423f98c3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -160,6 +160,7 @@ struct stmmac_priv {
 	bool tx_path_in_lpi_mode;
 	bool tso;
 	int sph;
+	int sph_cap;
 	u32 sarc_type;
 
 	unsigned int dma_buf_sz;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d34388b1ffcc..ace3c3835a9f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2858,6 +2858,7 @@ static int stmmac_hw_setup(struct net_device *dev, bool init_ptp)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u32 rx_cnt = priv->plat->rx_queues_to_use;
 	u32 tx_cnt = priv->plat->tx_queues_to_use;
+	bool sph_en;
 	u32 chan;
 	int ret;
 
@@ -2952,10 +2953,10 @@ static int stmmac_hw_setup(struct net_device *dev, bool init_ptp)
 	}
 
 	/* Enable Split Header */
-	if (priv->sph && priv->hw->rx_csum) {
-		for (chan = 0; chan < rx_cnt; chan++)
-			stmmac_enable_sph(priv, priv->ioaddr, 1, chan);
-	}
+	sph_en = (priv->hw->rx_csum > 0) && priv->sph;
+	for (chan = 0; chan < rx_cnt; chan++)
+		stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
+
 
 	/* VLAN Tag Insertion */
 	if (priv->dma_cap.vlins)
@@ -5697,7 +5698,8 @@ int stmmac_dvr_probe(struct device *device,
 
 	if (priv->dma_cap.sphen) {
 		ndev->hw_features |= NETIF_F_GRO;
-		priv->sph = true;
+		priv->sph_cap = true;
+		priv->sph = priv->sph_cap;
 		dev_info(priv->device, "SPH feature enabled\n");
 	}
 
-- 
2.25.1

