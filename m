Return-Path: <bpf+bounces-48953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82BA12903
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF06188952A
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A90198842;
	Wed, 15 Jan 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdS7+rPs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC71D5AD3;
	Wed, 15 Jan 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959404; cv=none; b=Eh7wSAh37yiVCYp6dkMJy+JFvguSQYqYFKy7jO7D8z1At6bsNsxUvQE3eEkMtqw4hoQXoWLhqtgDqYW4RePGadRDapRjhu+K5Hqxs7cl+EgSJTxXhnLILwYqZCL+Q8qtsmVLHZNVnT6aKVvlGm6WfI/upIUQQPc7b11FB1Xp0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959404; c=relaxed/simple;
	bh=QOp2WlEwA+Z1LybALk22qqERK8TTocfaR6CLWR1V+mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IOQfDj3ipsRKU4rryWroKjvPhZ4N5fac0SNh62zl/Qj/LAZ3eXuVrfxtLk5RyuHxGvzBs/NKaCEetRR+vC1peehVQVzO5b522NmR0eRROVu14Ftf2mW6leR6EetGuTCZxQKYHURgu3r0sliQOBuqdlNpryFceGB8ELxOlbMDLek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdS7+rPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0667C4CEE4;
	Wed, 15 Jan 2025 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736959404;
	bh=QOp2WlEwA+Z1LybALk22qqERK8TTocfaR6CLWR1V+mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WdS7+rPs3Ixf76c3FSWkH80J6rrzaiRVNwkM57KWQIddHjkky9AhXQ0WuGMP0DBQH
	 LlATspFvdFYxGrdMliQ37dl83CSZtGEubOb3RMRls5F95OrY/71HMpnCnJZ66NCgeD
	 M/BowfTtCcGm8DSlftOYvq4Rtp5Z/CCHr1nluAMgmywMAoCKV7BpV/OC8pHbrPUYCY
	 gdrga8lrrJABhZ/2k9ckY0Vq9cAqTqs8rLUs1DJknWdPmt4Fpe8f1fE6UQ9Bc1baLO
	 aqEYj+G+uMhM33rblj2yKszGa1CRXnvgb9wP5KJumCMRQsUpbVfELAq07YnkGsQefD
	 MwFbwDN5/SEhg==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 15 Jan 2025 18:43:03 +0200
Subject: [PATCH net-next 4/4] net: ethernet: ti: am65-cpsw: streamline TX
 queue creation and cleanup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-am65-cpsw-streamline-v1-4-326975c36935@kernel.org>
References: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
In-Reply-To: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, 
 danishanwar@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5366; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=QOp2WlEwA+Z1LybALk22qqERK8TTocfaR6CLWR1V+mc=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnh+WXnrAhu1fO1/1jbaRbXGBLaowUBkMzlfG8F
 JhMEeISyrGJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ4fllwAKCRDSWmvTvnYw
 k2Y2D/oCt6etsCeeE4rxpQfxaPpwosAcH6a9rL5OdSv5CS/Qmc3ACbYisDOWLLJBe/9wpxbMWlC
 QZk3cQc0VX6X4PvwGP+FP/I14SrKI4XWGIwVujlfNWBFe4r91yu0H9YrlqJ61ECG47pcclRV4Yz
 Pwoi33zYRr2x0KdrRMl9tC6b95zGuoCTRjaI+Pei5GvTPd43pcXlZkMaKgmYBmZXeDTtxUFarEU
 IsgWSF3AkXavcdt0DjIoQ1xecbUrIKuUYj8LpBznZr9JVYZAFzLHDgEQyEynWfj82FCYwQmpB+m
 Jbks10LujFkWqBnA1fC1OqR4/NDZbozzctuV6Kjxt+PwDoP93npgUP5pB3FDtMmV31/NKeTuKW1
 zf9UD2xdRh6aCzam6v+Ll0BB1JcROvilEHSHep53WaTGFFOZ+p3D+9biF3XNC2+lXD6tQtODd9o
 gNGCXmIXS8UC4xf/FhEe8yhdqsqbTMHpStHZNcUsSdGv+9BzQiOROLAM2T0VlSdEMv763CElAq2
 68cpmWBSV3jid2QY38yHGSlHYEnE/XL/f1KpZKLEL9QQD1PdXxykmqCtdiJw+0G068bWwlvlruD
 GA3gL+hwF1sybp4n2wCFUduibGA9pr4KQoHsts5JKFx+U9/7pvoNP3pCm/SjZ5/ahdUUCEhXSEP
 a71lqg7mgNmzDNw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Introduce am65_cpsw_create_txqs() and am65_cpsw_destroy_txqs()
and use them.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 123 +++++++++++++++++++------------
 1 file changed, 77 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index b5e679bb3f3c..55c50fefe4b5 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -501,6 +501,7 @@ static inline void am65_cpsw_put_page(struct am65_cpsw_rx_flow *flow,
 				      struct page *page,
 				      bool allow_direct);
 static void am65_cpsw_nuss_rx_cleanup(void *data, dma_addr_t desc_dma);
+static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma);
 
 static void am65_cpsw_destroy_rxq(struct am65_cpsw_common *common, int id)
 {
@@ -655,6 +656,76 @@ static int am65_cpsw_create_rxqs(struct am65_cpsw_common *common)
 	return ret;
 }
 
+static void am65_cpsw_destroy_txq(struct am65_cpsw_common *common, int id)
+{
+	struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[id];
+
+	napi_disable(&tx_chn->napi_tx);
+	hrtimer_cancel(&tx_chn->tx_hrtimer);
+	k3_udma_glue_reset_tx_chn(tx_chn->tx_chn, tx_chn,
+				  am65_cpsw_nuss_tx_cleanup);
+	k3_udma_glue_disable_tx_chn(tx_chn->tx_chn);
+}
+
+static void am65_cpsw_destroy_txqs(struct am65_cpsw_common *common)
+{
+	struct am65_cpsw_tx_chn *tx_chn = common->tx_chns;
+	int id;
+
+	/* shutdown tx channels */
+	atomic_set(&common->tdown_cnt, common->tx_ch_num);
+	/* ensure new tdown_cnt value is visible */
+	smp_mb__after_atomic();
+	reinit_completion(&common->tdown_complete);
+
+	for (id = 0; id < common->tx_ch_num; id++)
+		k3_udma_glue_tdown_tx_chn(tx_chn[id].tx_chn, false);
+
+	id = wait_for_completion_timeout(&common->tdown_complete,
+					 msecs_to_jiffies(1000));
+	if (!id)
+		dev_err(common->dev, "tx teardown timeout\n");
+
+	for (id = common->tx_ch_num - 1; id >= 0; id--)
+		am65_cpsw_destroy_txq(common, id);
+}
+
+static int am65_cpsw_create_txq(struct am65_cpsw_common *common, int id)
+{
+	struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[id];
+	int ret;
+
+	ret = k3_udma_glue_enable_tx_chn(tx_chn->tx_chn);
+	if (ret)
+		return ret;
+
+	napi_enable(&tx_chn->napi_tx);
+
+	return 0;
+}
+
+static int am65_cpsw_create_txqs(struct am65_cpsw_common *common)
+{
+	int id, ret;
+
+	for (id = 0; id < common->tx_ch_num; id++) {
+		ret = am65_cpsw_create_txq(common, id);
+		if (ret) {
+			dev_err(common->dev, "couldn't create txq %d: %d\n",
+				id, ret);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	for (--id; id >= 0; id--)
+		am65_cpsw_destroy_txq(common, id);
+
+	return ret;
+}
+
 static int am65_cpsw_nuss_desc_idx(struct k3_cppi_desc_pool *desc_pool,
 				   void *desc,
 				   unsigned char dsize_log2)
@@ -789,9 +860,8 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
 static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 {
 	struct am65_cpsw_host *host_p = am65_common_get_host(common);
-	struct am65_cpsw_tx_chn *tx_chn = common->tx_chns;
-	int port_idx, ret, tx;
 	u32 val, port_mask;
+	int port_idx, ret;
 
 	if (common->usage_count)
 		return 0;
@@ -855,27 +925,14 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 	if (ret)
 		return ret;
 
-	for (tx = 0; tx < common->tx_ch_num; tx++) {
-		ret = k3_udma_glue_enable_tx_chn(tx_chn[tx].tx_chn);
-		if (ret) {
-			dev_err(common->dev, "couldn't enable tx chn %d: %d\n",
-				tx, ret);
-			tx--;
-			goto fail_tx;
-		}
-		napi_enable(&tx_chn[tx].napi_tx);
-	}
+	ret = am65_cpsw_create_txqs(common);
+	if (ret)
+		goto cleanup_rx;
 
 	dev_dbg(common->dev, "cpsw_nuss started\n");
 	return 0;
 
-fail_tx:
-	while (tx >= 0) {
-		napi_disable(&tx_chn[tx].napi_tx);
-		k3_udma_glue_disable_tx_chn(tx_chn[tx].tx_chn);
-		tx--;
-	}
-
+cleanup_rx:
 	am65_cpsw_destroy_rxqs(common);
 
 	return ret;
@@ -883,39 +940,13 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 
 static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 {
-	struct am65_cpsw_tx_chn *tx_chn = common->tx_chns;
-	int i;
-
 	if (common->usage_count != 1)
 		return 0;
 
 	cpsw_ale_control_set(common->ale, HOST_PORT_NUM,
 			     ALE_PORT_STATE, ALE_PORT_STATE_DISABLE);
 
-	/* shutdown tx channels */
-	atomic_set(&common->tdown_cnt, common->tx_ch_num);
-	/* ensure new tdown_cnt value is visible */
-	smp_mb__after_atomic();
-	reinit_completion(&common->tdown_complete);
-
-	for (i = 0; i < common->tx_ch_num; i++)
-		k3_udma_glue_tdown_tx_chn(tx_chn[i].tx_chn, false);
-
-	i = wait_for_completion_timeout(&common->tdown_complete,
-					msecs_to_jiffies(1000));
-	if (!i)
-		dev_err(common->dev, "tx timeout\n");
-	for (i = 0; i < common->tx_ch_num; i++) {
-		napi_disable(&tx_chn[i].napi_tx);
-		hrtimer_cancel(&tx_chn[i].tx_hrtimer);
-	}
-
-	for (i = 0; i < common->tx_ch_num; i++) {
-		k3_udma_glue_reset_tx_chn(tx_chn[i].tx_chn, &tx_chn[i],
-					  am65_cpsw_nuss_tx_cleanup);
-		k3_udma_glue_disable_tx_chn(tx_chn[i].tx_chn);
-	}
-
+	am65_cpsw_destroy_txqs(common);
 	am65_cpsw_destroy_rxqs(common);
 	cpsw_ale_stop(common->ale);
 

-- 
2.34.1


