Return-Path: <bpf+bounces-26418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE5989F3F6
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D271F2B5F1
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C0416DEC8;
	Wed, 10 Apr 2024 13:18:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38EA16D9AB;
	Wed, 10 Apr 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755090; cv=none; b=Obp2TIOn1IU/qAPkALYoEAuPAXSfYQgY32d6tGHvFAKhMyNHyp+HV9T+IHloYvFct/BiYaShKMX8Fx+dr3kpO29yAJps6uZO4tlHj7zWS0dhhG8uXjo3Hvty4JNiw//yoJjXF/u0cZ6TawBeEQGGGE/49dPlX+y0BRHiD/K97IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755090; c=relaxed/simple;
	bh=thNNGA+Buyv1A48P5cMpc4XXfCvRQSFmpwoRUX9PFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyKBAbOsKGnVJJuRiKGXMjiOkFB1LrxTIEFjXlxR37RQ1VORJKYtgt0xSE8JNveh2pqOBLruEhwLNpCsNFnUpcH0Y8mcc84NI/Yw3o8DAWBdY3t7HQpHQRx7zu9kAa9aoGA2xM3ITcfnChjNvY+3/5jptEjETUec6y+zYFzPPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e2ac1c16aso6858175a12.0;
        Wed, 10 Apr 2024 06:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755087; x=1713359887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGHHnAjzHXOHKZAHNwNt7Xm//rgfn0lSUB+nM5VysgU=;
        b=T9XWF/GSmbwTBbB6ryoVLwfFrd4VekxTEsHkKXYrre3vkNNrQx6OuOk8GpMAwe6l+H
         uYjhbE29RMlUpf0EtuUn5LziwLWlbzCwFEePZIcF7nEnCWji8mcV1n7Q5r2nr+RKVoXq
         cNwHhcOdi2Mit1dKQdVtpl81rOaB+L1pDv1FEnuQEXDVH8lGO97rkXPJjNObc2V4viy9
         EXW970WFyNJZr1UhepVSIRk61G4klHbMCHrdEgbsYVs6a4sALIohzwq33veeZGHxjphz
         WJpShdKVXwQoOlCBjILdjz9AC3NMCYnwbxz1vPCQp63XX9aXHDUVsoIoNRa/oa7CS6+x
         DeyA==
X-Forwarded-Encrypted: i=1; AJvYcCUCJL7XRQw8z6X9C2ijkiwV09xu8GFVob8mKhmEcRpvhwyQTDmb/wxMqJeUIXo2ugReQ0Jt5h5Jgz+O/MUEekEZGrGWL5qHk3eRPyW+c2UjhrW9bsYzmPVCqDWLNBzE/k52FbWHMZm8ZC/1yg8nCMBnjBPN6Mblw8dm+e3BwH9bUWgFt8AYZXBIiP4OdorBxkvZ+awpWJJGYtY=
X-Gm-Message-State: AOJu0Yyvaa+VqmZVJ1y5KdNh08c/QHQA22zklXhZJsg85IhBFbxmqEy4
	C9Wq8WITVlTrUnL5RIUgsW4oYSndYJQ0+Qp/32GJMsHwhBizSinX
X-Google-Smtp-Source: AGHT+IHfRDKViblgpUPyWrUAnhST+TBB6wSl0qe87VqUsLBU1kMLXMG9TkoSj5KDLOwo8qX+Dgkttg==
X-Received: by 2002:a50:9e27:0:b0:56e:23e3:bdc3 with SMTP id z36-20020a509e27000000b0056e23e3bdc3mr434260ede.16.1712755087472;
        Wed, 10 Apr 2024 06:18:07 -0700 (PDT)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id h1-20020a0564020e8100b005682a0e915fsm6433736eda.76.2024.04.10.06.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:18:06 -0700 (PDT)
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
Subject: [PATCH net-next v5 05/10] net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically
Date: Wed, 10 Apr 2024 06:13:46 -0700
Message-ID: <20240410131407.3897251-6-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410131407.3897251-1-leitao@debian.org>
References: <20240410131407.3897251-1-leitao@debian.org>
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


