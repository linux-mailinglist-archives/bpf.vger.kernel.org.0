Return-Path: <bpf+bounces-49197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0337A1513F
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 15:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0B5188CC83
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 14:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DFC20010A;
	Fri, 17 Jan 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pX1dk5c+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C08201001;
	Fri, 17 Jan 2025 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122825; cv=none; b=rST6DRCnWdC1rcRjZt5guC6KdCdkaT4ZkNVNlQCFP7ceTjyc8FVllFBsmln6Q988MqNxPX1GG3eDGckpdk0HB+KkyE3ChbrVcDt4J0SGrShMaeQm64U1CHP2MamIziXDMwrNrRvp9/JyHUvqXBrfJSIvgXezb+tn2/Z7PGK0OHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122825; c=relaxed/simple;
	bh=tTyOuIX6wz/sOdwJQexkXBdPNLWWPCx3wYLRGpjeAwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpuQbb+wVCZ6p3CL159VfSMGX8IMX31LweuNI/zrp3GQhRiViajrZkJ+0zwwzep+k+kEkq1wSSyMQ0UpVueVC63MUiuaTHanbh3D1/n3cO5h0LghgLuxA1X8Yay4XcmHHcAAzvGav9pe7OV3oZuZ1/qMVO2j63X7z6jHVAsCbac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pX1dk5c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E039C4CEE5;
	Fri, 17 Jan 2025 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737122825;
	bh=tTyOuIX6wz/sOdwJQexkXBdPNLWWPCx3wYLRGpjeAwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pX1dk5c+muJTHIpoac1FXIp6E+s8j3kNK6LO9apvxsJsfzfR0xlhADjIVcTpfBVPk
	 wilW5xes54w8+xrdrOSsNvDELSEcweQIFyriQT3g9/dtExEJvbQrSdcJQ/1ZkqlsEm
	 la9/1didEoUd/Ebcerkqw5VYVh2Ss0cq7Eqb53znoxZYPfUZqRf0Xrr4+Bb9mHL04T
	 8aAtJQAXSl7FY4nMfsjTflq47Z9eAxJhY1nSn8XG2n6hioG3fJf0CcTxzsJUMdNgVE
	 JOnWwCE0BGZoH9+YOq3mKvkQWCs75+hsfNI+6j2aQhnFhAKZeEOrYNSMS2iqz2WFfw
	 OvG4hH2e/zVew==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 17 Jan 2025 16:06:33 +0200
Subject: [PATCH net-next v2 1/3] net: ethernet: ti: am65-cpsw: ensure
 proper channel cleanup in error path
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-am65-cpsw-streamline-v2-1-91a29c97e569@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7071; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=tTyOuIX6wz/sOdwJQexkXBdPNLWWPCx3wYLRGpjeAwc=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnimQAz6aKBdB9EoWTO0GfJHJMp1Ru+cvzG2dQU
 cCoZr4mrFmJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ4pkAAAKCRDSWmvTvnYw
 kynpD/91z8xDFBCNWtnmW7Qbemstwey/6hMWzsFMjGokU0dVKyDj7B0O+VYE/qiu9Tg43QKyuws
 LvdztPzxSn3VG3jJ+p8Gwthxuuob4a0tkOZO25plbsufhLhd7jC97duQzcyLtmi8wM72Luu+a7H
 P+nklFAaSPG+U3AEQj6kJJg+D71fEysglWlZXxW5PiBpQjGSK8qAcx7IO2ynFTsyzH1V4c2lZAK
 zrqnTe+41QQ1QZ4udY6pXIET4RqKhh7tCphO/rZRQ2s2q8Al2To4KAaLLNWCmC/gUy5k9i2kWB4
 E4ngN4SybVfG0RCzUKyx0lSHdNc3OIOlTuLqKrVf+LpP07h8xbf8sykRcFy3Sr6Zgr2JYiqFJeC
 MUenyACBQSn7sjYYxjSVKJ+tL+gTZuE7JiXa/lyFj5QxayWxOV2arIwjiH75Yq0y9aztbOBe3oG
 y8xB0e7SWGoWuRbqMP0QWwxhq4/PI3860dKo2NhMWK/ds5oBBov7P6AKpcmX4cfumGu+B4ARP2D
 0KOn3kkQ9JSKwORlRoSR4e/Nk8ri5NbhYcHHASnrnDcC/wIaUDOJp5HD2HcpWVgS9DztR3GS30w
 fS7TTQ1v9aO7FXhI2/Org3L9vcB3WyAgA67TEJyv3niAA9Q1gkoI1oWTumMBWmRODXbrPrrHaey
 6KwzNtcNzM9sjLg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

We are missing netif_napi_del() and am65_cpsw_nuss_free_tx/rx_chns()
in error path when am65_cpsw_nuss_init_tx/rx_chns() is used anywhere
other than at probe(). i.e. am65_cpsw_nuss_update_tx_rx_chns and
am65_cpsw_nuss_resume()

As reported, in am65_cpsw_nuss_update_tx_rx_chns(),
if am65_cpsw_nuss_init_tx_chns() partially fails then
devm_add_action(dev, am65_cpsw_nuss_free_tx_chns,..) is added
but the cleanup via am65_cpsw_nuss_free_tx_chns() will not run.

Same issue exists for am65_cpsw_nuss_init_tx/rx_chns() failures
in am65_cpsw_nuss_resume() as well.

This would otherwise require more instances of devm_add/remove_action
and is clearly more of a distraction than any benefit.

So, drop devm_add/remove_action for am65_cpsw_nuss_free_tx/rx_chns()
and call am65_cpsw_nuss_free_tx/rx_chns() and netif_napi_del()
where required.

Reported-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Closes: https://lore.kernel.org/all/m4rhkzcr7dlylxr54udyt6lal5s2q4krrvmyay6gzgzhcu4q2c@r34snfumzqxy/
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 67 +++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index dcb6662b473d..f5ae63999516 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2242,8 +2242,6 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 	struct device *dev = common->dev;
 	int i;
 
-	devm_remove_action(dev, am65_cpsw_nuss_free_tx_chns, common);
-
 	common->tx_ch_rate_msk = 0;
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
@@ -2265,8 +2263,6 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
 
-		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
-				  am65_cpsw_nuss_tx_poll);
 		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 		tx_chn->tx_hrtimer.function = &am65_cpsw_nuss_tx_timer_callback;
 
@@ -2279,9 +2275,21 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 				tx_chn->id, tx_chn->irq, ret);
 			goto err;
 		}
+
+		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
+				  am65_cpsw_nuss_tx_poll);
 	}
 
+	return 0;
+
 err:
+	for (--i ; i >= 0 ; i--) {
+		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
+
+		netif_napi_del(&tx_chn->napi_tx);
+		devm_free_irq(dev, tx_chn->irq, tx_chn);
+	}
+
 	return ret;
 }
 
@@ -2362,12 +2370,10 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 		goto err;
 	}
 
+	return 0;
+
 err:
-	i = devm_add_action(dev, am65_cpsw_nuss_free_tx_chns, common);
-	if (i) {
-		dev_err(dev, "Failed to add free_tx_chns action %d\n", i);
-		return i;
-	}
+	am65_cpsw_nuss_free_tx_chns(common);
 
 	return ret;
 }
@@ -2395,7 +2401,6 @@ static void am65_cpsw_nuss_remove_rx_chns(struct am65_cpsw_common *common)
 
 	rx_chn = &common->rx_chns;
 	flows = rx_chn->flows;
-	devm_remove_action(dev, am65_cpsw_nuss_free_rx_chns, common);
 
 	for (i = 0; i < common->rx_ch_num_flows; i++) {
 		if (!(flows[i].irq < 0))
@@ -2494,7 +2499,7 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 						i, &rx_flow_cfg);
 		if (ret) {
 			dev_err(dev, "Failed to init rx flow%d %d\n", i, ret);
-			goto err;
+			goto err_flow;
 		}
 		if (!i)
 			fdqring_id =
@@ -2506,14 +2511,12 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 			dev_err(dev, "Failed to get rx dma irq %d\n",
 				flow->irq);
 			ret = flow->irq;
-			goto err;
+			goto err_flow;
 		}
 
 		snprintf(flow->name,
 			 sizeof(flow->name), "%s-rx%d",
 			 dev_name(dev), i);
-		netif_napi_add(common->dma_ndev, &flow->napi_rx,
-			       am65_cpsw_nuss_rx_poll);
 		hrtimer_init(&flow->rx_hrtimer, CLOCK_MONOTONIC,
 			     HRTIMER_MODE_REL_PINNED);
 		flow->rx_hrtimer.function = &am65_cpsw_nuss_rx_timer_callback;
@@ -2526,20 +2529,28 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 			dev_err(dev, "failure requesting rx %d irq %u, %d\n",
 				i, flow->irq, ret);
 			flow->irq = -EINVAL;
-			goto err;
+			goto err_flow;
 		}
+
+		netif_napi_add(common->dma_ndev, &flow->napi_rx,
+			       am65_cpsw_nuss_rx_poll);
 	}
 
 	/* setup classifier to route priorities to flows */
 	cpsw_ale_classifier_setup_default(common->ale, common->rx_ch_num_flows);
 
-err:
-	i = devm_add_action(dev, am65_cpsw_nuss_free_rx_chns, common);
-	if (i) {
-		dev_err(dev, "Failed to add free_rx_chns action %d\n", i);
-		return i;
+	return 0;
+
+err_flow:
+	for (--i; i >= 0 ; i--) {
+		flow = &rx_chn->flows[i];
+		netif_napi_del(&flow->napi_rx);
+		devm_free_irq(dev, flow->irq, flow);
 	}
 
+err:
+	am65_cpsw_nuss_free_rx_chns(common);
+
 	return ret;
 }
 
@@ -3349,7 +3360,7 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 		return ret;
 	ret = am65_cpsw_nuss_init_rx_chns(common);
 	if (ret)
-		return ret;
+		goto err_remove_tx;
 
 	/* The DMA Channels are not guaranteed to be in a clean state.
 	 * Reset and disable them to ensure that they are back to the
@@ -3370,7 +3381,7 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 
 	ret = am65_cpsw_nuss_register_devlink(common);
 	if (ret)
-		return ret;
+		goto err_remove_rx;
 
 	for (i = 0; i < common->port_num; i++) {
 		port = &common->ports[i];
@@ -3401,6 +3412,10 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 err_cleanup_ndev:
 	am65_cpsw_nuss_cleanup_ndev(common);
 	am65_cpsw_unregister_devlink(common);
+err_remove_rx:
+	am65_cpsw_nuss_remove_rx_chns(common);
+err_remove_tx:
+	am65_cpsw_nuss_remove_tx_chns(common);
 
 	return ret;
 }
@@ -3420,6 +3435,8 @@ int am65_cpsw_nuss_update_tx_rx_chns(struct am65_cpsw_common *common,
 		return ret;
 
 	ret = am65_cpsw_nuss_init_rx_chns(common);
+	if (ret)
+		am65_cpsw_nuss_remove_tx_chns(common);
 
 	return ret;
 }
@@ -3678,6 +3695,8 @@ static void am65_cpsw_nuss_remove(struct platform_device *pdev)
 	 */
 	am65_cpsw_nuss_cleanup_ndev(common);
 	am65_cpsw_unregister_devlink(common);
+	am65_cpsw_nuss_remove_rx_chns(common);
+	am65_cpsw_nuss_remove_tx_chns(common);
 	am65_cpsw_nuss_phylink_cleanup(common);
 	am65_cpts_release(common->cpts);
 	am65_cpsw_disable_serdes_phy(common);
@@ -3739,8 +3758,10 @@ static int am65_cpsw_nuss_resume(struct device *dev)
 	if (ret)
 		return ret;
 	ret = am65_cpsw_nuss_init_rx_chns(common);
-	if (ret)
+	if (ret) {
+		am65_cpsw_nuss_remove_tx_chns(common);
 		return ret;
+	}
 
 	/* If RX IRQ was disabled before suspend, keep it disabled */
 	for (i = 0; i < common->rx_ch_num_flows; i++) {

-- 
2.34.1


