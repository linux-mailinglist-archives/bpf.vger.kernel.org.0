Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD26DF0BF
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 11:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjDLJnn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjDLJnd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 05:43:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2607D61A7;
        Wed, 12 Apr 2023 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681292609; x=1712828609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cpc+vWCiVUmsOySpGlMg+6/vKyP6bVmouafrvWfaSpU=;
  b=beua4jA4s1Mf/lsblZ2BXvVEpuIZ72Q4iiYBAn+CK52WbIkCoTQ9nWQn
   g7qvCEdxgD/pmITVGras+3zB+JnQ9ApuZagzj7ogkZc/I3lBAwNgapMfU
   JWl3ibdjC98EUMEMRg3vPv8YU3LXs20YZ0wvhzn6mSYK6gk3zUHiRtVMC
   0PL1BLexkF+siEVWTy3qnqF8gSRtFZY7TU/lOD3f7GqXL3m5SgzVy60o6
   I6pwslO0cn2bBfkfHmfhmOLtnb1BCApvgk8FYbdWwgt9+oAg7vdbIcjhJ
   SZhYxDZ+9iUl/bI/kfa1pl3lsC/uT7gDS6tQYfvcArIgTFW3rdXNRJwjF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="346526388"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="346526388"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 02:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="682430937"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="682430937"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orsmga007.jf.intel.com with ESMTP; 12 Apr 2023 02:43:22 -0700
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xdp-hints@xdp-project.net,
        Song Yoong Siang <yoong.siang.song@intel.com>
Subject: [PATCH net-next v3 2/4] net: stmmac: introduce wrapper for struct xdp_buff
Date:   Wed, 12 Apr 2023 17:42:33 +0800
Message-Id: <20230412094235.589089-3-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412094235.589089-1-yoong.siang.song@intel.com>
References: <20230412094235.589089-1-yoong.siang.song@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce struct stmmac_xdp_buff as a preparation to support XDP Rx
metadata via kfuncs.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  4 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 +++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 3d15e1e92e18..ac8ccf851708 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -92,6 +92,10 @@ struct stmmac_rx_buffer {
 	dma_addr_t sec_addr;
 };
 
+struct stmmac_xdp_buff {
+	struct xdp_buff xdp;
+};
+
 struct stmmac_rx_queue {
 	u32 rx_count_frames;
 	u32 queue_index;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2cc6237a9c28..f7bbdf04d20c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5189,9 +5189,9 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	int status = 0, coe = priv->hw->rx_csum;
 	unsigned int next_entry = rx_q->cur_rx;
 	enum dma_data_direction dma_dir;
+	struct stmmac_xdp_buff ctx = {};
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
-	struct xdp_buff xdp;
 	int xdp_status = 0;
 	int buf_sz;
 
@@ -5313,17 +5313,17 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
 
-			xdp_init_buff(&xdp, buf_sz, &rx_q->xdp_rxq);
-			xdp_prepare_buff(&xdp, page_address(buf->page),
+			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
+			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, false);
 
-			pre_len = xdp.data_end - xdp.data_hard_start -
+			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
 				  buf->page_offset;
-			skb = stmmac_xdp_run_prog(priv, &xdp);
+			skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
 			/* Due xdp_adjust_tail: DMA sync for_device
 			 * cover max len CPU touch
 			 */
-			sync_len = xdp.data_end - xdp.data_hard_start -
+			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
 				   buf->page_offset;
 			sync_len = max(sync_len, pre_len);
 
@@ -5333,7 +5333,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 				if (xdp_res & STMMAC_XDP_CONSUMED) {
 					page_pool_put_page(rx_q->page_pool,
-							   virt_to_head_page(xdp.data),
+							   virt_to_head_page(ctx.xdp.data),
 							   sync_len, true);
 					buf->page = NULL;
 					priv->dev->stats.rx_dropped++;
@@ -5361,7 +5361,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (!skb) {
 			/* XDP program may expand or reduce tail */
-			buf1_len = xdp.data_end - xdp.data;
+			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
 
 			skb = napi_alloc_skb(&ch->rx_napi, buf1_len);
 			if (!skb) {
@@ -5371,7 +5371,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			}
 
 			/* XDP program may adjust header */
-			skb_copy_to_linear_data(skb, xdp.data, buf1_len);
+			skb_copy_to_linear_data(skb, ctx.xdp.data, buf1_len);
 			skb_put(skb, buf1_len);
 
 			/* Data payload copied into SKB, page ready for recycle */
-- 
2.34.1

