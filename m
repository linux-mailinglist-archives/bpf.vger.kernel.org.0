Return-Path: <bpf+bounces-27415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 720578ACCFA
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67081B23694
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2229F1514FB;
	Mon, 22 Apr 2024 12:39:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9561509B6;
	Mon, 22 Apr 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789597; cv=none; b=oHr2Z7LgaM2MCoIgnfKhzvvQBqHEZiUmMZwKRt8/rVqVxL2FQ9VhLF0ZWq0JXp/79XX34vK4puCXRN3rTXge8V2ACq+eF5UmTF2SbIR2eADSXUMFbyr0LDn5uPQLV3dzUL3mKYcWn0obLYzeLtmPQpCGRu+5Gg6P+OcD7XcU8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789597; c=relaxed/simple;
	bh=thNNGA+Buyv1A48P5cMpc4XXfCvRQSFmpwoRUX9PFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih4azsVKURI33gDUsSIbjsUDJvq5dOsOVsPBBOYm7LxPYSdwa8E5C+g7IDgpF+THA53vtLxWZnzdWoM7vXqsXM72jWqLY1KZU0RkYnLUMo9zt0te9vDMR+e7GoX4Pp0ihizCLRovckbJqd+Nqq6dVXbPqKW5H0CAUsouFGkIa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso7088345a12.3;
        Mon, 22 Apr 2024 05:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789594; x=1714394394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGHHnAjzHXOHKZAHNwNt7Xm//rgfn0lSUB+nM5VysgU=;
        b=FKLAA/HUDsO8ATxftlmISc+swiR2cYjD90JZniYVfquOo/TkfXweb8daST4W92sFNd
         dRbYepcuXHT78GvvSmPe4aIzOAC1LKqkjIBkNE3mgtL5cfrX3IbEbMEAPowJJENum8Yv
         yvAyvqwKGkFQI7GVClzvBHu2rgBibhz5TmzxlI5nKS93wAHEC4ulwbqZEWx5INIpBRg/
         VMns+agqyJH+Hm02fUb0WcteZAnQ/WHE1eCBJqfs31dGzPGFkM92EuvkDOCLvJa4Pm38
         uVPellCAv2fbb2Ap7Mcav9zWpO52IPCsyxRF19JRm9SsF6J0GFlGtu/R50krEnAeGeft
         D6vg==
X-Forwarded-Encrypted: i=1; AJvYcCVJbeIXrJrVI6obHOxDBovSoWQCRLFilopezMLvC8ThXKn4I5dcFPenmMPrsd3acr3+n32qtyLDBIhxl3MY0qQBWlCGDnH5Cj7dA6B7I1tkSpoW9jNZakwTdD8Wu+oik/1oXTtCJClX3qgow9iSOdIeGB00B4We5ElPWR7X2LND0VMJilEmCzqG5y4huR97YoMZ9pFi8Y9tNQY=
X-Gm-Message-State: AOJu0YzxjQRO3iJClVlYm3isQKpko3lAoCJEMIsmHeHVXbJOZ9RDe8Hb
	JUC/ZODi901NOY5NLFFA7kMFiTtYO/Ret5+M/TiW22x6AtGCopBx
X-Google-Smtp-Source: AGHT+IG3PxVJn1BJwn3eTWAHON9DGoiJL/HK0PQrYKhksDGBOLFABsV9GJamJFTDvqvYbONN6dK/hw==
X-Received: by 2002:a50:9f6d:0:b0:570:5b3c:443 with SMTP id b100-20020a509f6d000000b005705b3c0443mr6592504edf.7.1713789594240;
        Mon, 22 Apr 2024 05:39:54 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id bf17-20020a0564021a5100b0056bf6287f32sm5488953edb.26.2024.04.22.05.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:39:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	taras.chornyi@plvision.eu,
	ath11k@lists.infradead.org,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	geomatsi@gmail.com,
	kvalo@kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: quic_jjohnson@quicinc.com,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	idosch@idosch.org,
	leitao@debian.org
Subject: [PATCH net-next v7 05/10] net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically
Date: Mon, 22 Apr 2024 05:38:58 -0700
Message-ID: <20240422123921.854943-6-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422123921.854943-1-leitao@debian.org>
References: <20240422123921.854943-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedding net_device into structures prohibits the usage of flexible
arrays in the net_device structure. For more details, see the discussion
at [1].

Un-embed the net_device from the private struct by converting it
into a pointer. Then use the leverage the new alloc_netdev_dummy()
helper to allocate and initialize dummy devices.

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 17 +++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index caa13b9cedff..d7a96dc11c07 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1710,7 +1710,7 @@ static struct page_pool *mtk_create_page_pool(struct mtk_eth *eth,
 	if (IS_ERR(pp))
 		return pp;
 
-	err = __xdp_rxq_info_reg(xdp_q, &eth->dummy_dev, id,
+	err = __xdp_rxq_info_reg(xdp_q, eth->dummy_dev, id,
 				 eth->rx_napi.napi_id, PAGE_SIZE);
 	if (err < 0)
 		goto err_free_pp;
@@ -4188,6 +4188,8 @@ static int mtk_free_dev(struct mtk_eth *eth)
 		metadata_dst_free(eth->dsa_meta[i]);
 	}
 
+	free_netdev(eth->dummy_dev);
+
 	return 0;
 }
 
@@ -4983,9 +4985,14 @@ static int mtk_probe(struct platform_device *pdev)
 	/* we run 2 devices on the same DMA ring so we need a dummy device
 	 * for NAPI to work
 	 */
-	init_dummy_netdev(&eth->dummy_dev);
-	netif_napi_add(&eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
-	netif_napi_add(&eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
+	eth->dummy_dev = alloc_netdev_dummy(0);
+	if (!eth->dummy_dev) {
+		err = -ENOMEM;
+		dev_err(eth->dev, "failed to allocated dummy device\n");
+		goto err_unreg_netdev;
+	}
+	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
+	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
 
 	platform_set_drvdata(pdev, eth);
 	schedule_delayed_work(&eth->reset.monitor_work,
@@ -4993,6 +5000,8 @@ static int mtk_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_unreg_netdev:
+	mtk_unreg_dev(eth);
 err_deinit_ppe:
 	mtk_ppe_deinit(eth);
 	mtk_mdio_cleanup(eth);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 9ae3b8a71d0e..723fc637027c 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1242,7 +1242,7 @@ struct mtk_eth {
 	spinlock_t			page_lock;
 	spinlock_t			tx_irq_lock;
 	spinlock_t			rx_irq_lock;
-	struct net_device		dummy_dev;
+	struct net_device		*dummy_dev;
 	struct net_device		*netdev[MTK_MAX_DEVS];
 	struct mtk_mac			*mac[MTK_MAX_DEVS];
 	int				irq[3];
-- 
2.43.0


