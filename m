Return-Path: <bpf+bounces-26531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28438A167C
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 16:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD4EB27048
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0930152523;
	Thu, 11 Apr 2024 14:00:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E3152179;
	Thu, 11 Apr 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844028; cv=none; b=aUWEbc/Dq2tObKqgxRp2goXi6lI1O1XLEDmlvfNI7/O9w/gsih8vJkqAeXTsj6bx5/paabvExLZUIyprIpbZ0ryxfS5SWWxeeWplfeIU4O6lu9U5jOmFj9fi5NKZ/FTbbFIOIC5aWgeKE84TwlZxLc3GAJYr06OTdUjF9sOZVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844028; c=relaxed/simple;
	bh=thNNGA+Buyv1A48P5cMpc4XXfCvRQSFmpwoRUX9PFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2EikBqWOzlLUlMj5aS79IYqhsKJ1KeSZZyiu0xsD9Bxd/ClBvm/WJ92TwXrLLg0RrEkJeSJZul5uMG/4ekVjWiNGN8JCHZqe5GUiY2sDc5Rn4Mn8x67BNNrJEoWrvTseRTLv135g6HGi1sEzOZxNfZr/ixsIDtmUgPP2+Zp6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51d0dda061so138197566b.1;
        Thu, 11 Apr 2024 07:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844025; x=1713448825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGHHnAjzHXOHKZAHNwNt7Xm//rgfn0lSUB+nM5VysgU=;
        b=lm6Vn8OaDQUfNyz8tWlO8L9itkXyWWcoNCax2MEm9SXsJ4t1LYYZwX3sQANIX2rVlY
         x5iFZQ5yApms2zX2cXdaZd4IZvxI3EEKTlOWSFJJGLpuM25jLrtSs1Im+VwgxECfCS6+
         gzQ3Gqii2g0kT37n3+iom62uYrQBKdg2xlDnJ/k6+ewkGKENMrsGSG4vT46AQb5Na140
         jHqbmcIZm6QuSb74JOaGHjMcNxLmk0VlqnDsZCwx8SKZ+JY6uqEVO1aDGi2ddGepfqg9
         uOJnEup6S8VJYp1ZJ51HhzLTcAymNxIXJQ1Uq1d7hizNam/0fmgGOgGsWQlXKwerQzpV
         ZScg==
X-Forwarded-Encrypted: i=1; AJvYcCUtAI7+LmFKeFIS04puRsrQd4uwzRFKFDacy22VamFPmqmQ/8MqSBpWHjis2HIBJ7IOLSTom9Ap7KJjPPFtPApWC1GCV0t/0h/5i2YbbFChi0NVxmp1uWC6CFzZSyfG/SVYmrWcC33SmKSO+Vy5x6/rZ4Y4etpTMWSYpPUeiPZUY0KpOI063kOX2Y8K0dYvvSSadpogrIBy5Cs=
X-Gm-Message-State: AOJu0YzHP3tojFmQ4y+8dbt1rgeXovQ3GvKaEgfwG93E+hMXz0NP0efe
	0LSGAHcIfhIRJSfmKZ1i5+SzzcaZNUv5bHrxXtt9lcemMjVU66Bs
X-Google-Smtp-Source: AGHT+IFxOmGSIuAo0wZUWkrauT0Df5Dw6XBlFRpFNMRfvlacHHcHSCFBfO1xLfD0FfesNZg9hXPQZg==
X-Received: by 2002:a17:907:6d27:b0:a52:197b:5f4a with SMTP id sa39-20020a1709076d2700b00a52197b5f4amr2654126ejc.2.1712844025222;
        Thu, 11 Apr 2024 07:00:25 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063f8900b00a522e8740ecsm20659ejj.139.2024.04.11.07.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:00:24 -0700 (PDT)
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
Subject: [PATCH net-next v6 05/10] net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically
Date: Thu, 11 Apr 2024 06:59:29 -0700
Message-ID: <20240411135952.1096696-6-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411135952.1096696-1-leitao@debian.org>
References: <20240411135952.1096696-1-leitao@debian.org>
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


