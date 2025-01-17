Return-Path: <bpf+bounces-49199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D634AA15145
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 15:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3301659C0
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E664202C52;
	Fri, 17 Jan 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSexfObQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEDC202C3B;
	Fri, 17 Jan 2025 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122833; cv=none; b=STNoe+VNITlsaEwwCnjMo0OxyD7XSbi6sUI1vncC7kepGm/aPCioi2iT3e+pz08sXVGr4SIrF1W5FSjg7wCFXgb4GKMESO0sRiKS+lq2/cqrEl5DDdeGE+fVKFl9jdcl/PBOma+Pp+DMj+cwwtrKW4916GnHvRLSj4mB3Q08HRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122833; c=relaxed/simple;
	bh=JoibIR4zZQkOBFkS+APsUy4BDrDrp+ZGllSQEZJySjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nd6Z+8mEWGNM9QIvEXMedyLo3infQ3y+KuzH4RGFKPeXoTYf6AzrONgUQ1fV8RK0mgioyEuLZV+jARQpUYBw/oUlH3rgtJPqGq7gB3Rhp9PrXAl4VAOVZwKUA9mnW8wt147OO2ThJ63dRGTngyIs9RT15/9z8VCVCFxA+DCKI0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSexfObQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C54C4CEDD;
	Fri, 17 Jan 2025 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737122833;
	bh=JoibIR4zZQkOBFkS+APsUy4BDrDrp+ZGllSQEZJySjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cSexfObQqkr26eU9SGU+Vnn4sXEKLdMeqTikE8lP/HN3CVJFeyA0atJzsRLymodO8
	 JEcxdVp1DSodxsADnQ0d8KsJqs9DXJmdQM+hC0pgYjDs5orV5rZksag1NhLRUy+oZP
	 V9HAvxYFNWIyu/0Fmrxaeccb8CVlZFh2AVDSdeSK+LJwOlhzkKIu9GY+2Mr5eEj6bK
	 S22v8cMsW2RYen8DElGPQyyT76EJIj2go5HAnAo5Ipf235nYi3LDKBmw5o0o3hFzn8
	 CpI4q5+Pt77J+PglBwmvq16arSFDLZ7deZqoqEBXRto0kQrBfPl6pgDQe7hxfOpLtV
	 z8dzfTdj7CIuQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 17 Jan 2025 16:06:35 +0200
Subject: [PATCH net-next v2 3/3] net: ethernet: ti: am65-cpsw: streamline
 TX queue creation and cleanup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-am65-cpsw-streamline-v2-3-91a29c97e569@kernel.org>
References: <20250117-am65-cpsw-streamline-v2-0-91a29c97e569@kernel.org>
In-Reply-To: <20250117-am65-cpsw-streamline-v2-0-91a29c97e569@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, 
 danishanwar@ti.com, "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5366; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=JoibIR4zZQkOBFkS+APsUy4BDrDrp+ZGllSQEZJySjk=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnimQAR7c1ywZ8Z2CxW68gWxO3mF6JEd84qOCqE
 dMPBlXM4kqJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ4pkAAAKCRDSWmvTvnYw
 k8SbEADAvgAv7ERZnm8Oo2TGNJpRx/FBz9MJZRPBhoB1pqx6xfLUnWA5TLS8SE6YDrxQIL3RRzs
 FieYq7eoC3SOF0xaOCdO1CbraNz1J6AtlhlLhkU/AOEZSheDhOEUYPkHT5dkhLTpxUB9sBWU+oV
 k+QHvkPFV5uTeY9iW6LyOrKvsNIh8U+BruARKK8wEsOYgmhDpjg+ZthTwm46nKosk+AJ9K+OunA
 CazodQT2Cyeuvy6bdrWYHDfUx6Qd8MjNIB33oxaG3MkNff2Iro1U9hMA1lFQFw1BW79T/ofhT5b
 V0/zVwneOx7MmBOi+k/lb54z2146szAIyE6jaZrbnphffvySh69Qz+NfE9QP4tYk+LS3Og6sJNt
 kNTakMhDUC7eD0tOvQP8ZMIcR57QmY+Y0f6qz3BfAEg6A2NheZidBHpYO5Kz3s7DQas2BBq90EH
 Zp5bg10nmuHXfYMdZA5VUeDFCfjbIAqpKYP5zgJjkzqSqsSil8K4dlIrVeK49MAvE2gwR/MPQ3y
 uvzZd7+t8tb0cpzyqqYlsm8DyFe7cOfmLYwpqH/iU0nKBD5Q5+neM6rRn/1E1joqK/TGrPKJWaR
 Rsukg4DoioGaoEwn0hQPRIqV2079nlKN7pTrxM3F/9JX3q9gJ0YL+yV2KoNpBxgFXAlUMcGPrOP
 vSc+zPrF/ytsVSA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Introduce am65_cpsw_create_txqs() and am65_cpsw_destroy_txqs()
and use them.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 123 +++++++++++++++++++------------
 1 file changed, 77 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 5c87002eeee9..391e78425777 100644
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


