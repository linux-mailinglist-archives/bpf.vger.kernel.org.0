Return-Path: <bpf+bounces-27417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C228ACD02
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCF61F21D15
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB914A4DD;
	Mon, 22 Apr 2024 12:40:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3614A4E5;
	Mon, 22 Apr 2024 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789605; cv=none; b=ByZi+mvm4TOXr2BTBasAnkivTKONNohZaSrCLzYm8+a3iyac5xijBpS+WGMpKwJY2knjk6muK2UoDodbaMz55CtzAhxkmvch6s7mF3oIm13ufuq8FUBXbmWD52JsUjsnczeLny5ssFurVjBTuRXwIzi8Krnb5faKGZSEPVaMlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789605; c=relaxed/simple;
	bh=MB8+/MFHOEltGh7GM7e6UBLJe+yCPGpUyEgMI44tcDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adIQI1m5QLk0Sg/YfBepv4ay6CFUC+fZgUpL4QVic86fcj2Z4Sgdu9I/cOBxzdK870pFa0PlxrSOLUzISOIcY9lOJJiB1ai3odemO/KeT+gxE9EtcIUda7H8DxFtiPBJrQmlfRkyGH9QDEfIUJ6qkGnjb+d2XwruGoipYSo7+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5872b74c44so2300766b.3;
        Mon, 22 Apr 2024 05:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789602; x=1714394402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsBGQlMm+F00sLCL/qlkhF4TnT6nst/CdHn7pOQlov8=;
        b=IDVqPuj7DXVh9QVygnynA0ewJ7z3XexQmaJFZghrhzhQCPkniQm4njU/xjvhZba1sP
         dDM5qPGMpvEQnMQTL+YNyXrVTSI7H8dVr7i35aFNaaRQTYkOKHo7cFC54c2xm37SvpLb
         qkgTg4ZhO8fVpyO2rwdosi7G4nYVDw5TRi0bwcD3qJBz24eHFcl3xCn5hddtrISnzFBK
         zKwrg4Fs+WlQbaCnoVA9wJP4BwCd203YQn5ron02YcLDLch+UjdjS/rllyiCanNavGa0
         T87MZbmChNLvAXgqspVWJU362MbV2zyhXvc7YujRhd+R3VkM1y+wAV/l1giujCi+F3da
         eSPg==
X-Forwarded-Encrypted: i=1; AJvYcCUylcscOZzElLsNMNPapJJD6vBsV/dddbhQGpUf6KyhrG58cisdgg6wJAeXVeEvEBFbkzOcMrS1PVMtlEYZsFVtD3eTHv9MYOxbFzwu02C8yQaxIM48o44qQ9HIzEA8CfykDWcqU/oErYhnPcSfkja5oGI6nBzA9gncYVhVp8zjwUTGvOJIpFcwfsqk8A2Qdy0rYShKVnFLHno=
X-Gm-Message-State: AOJu0Yx176bwctL95FR7kou77Sx52xSHFmM77MHe1JrANI6tYUD1iQ2B
	SDan9I/gbXqTkO7YKT2EEnriK+dv6Zc1qG5jp0of8whPyuaGvnwN
X-Google-Smtp-Source: AGHT+IHYhw0Rn+ozFJSEJTushyVa4eDMtV3KSJg5ZGsXSxqJSwj9e3Rtt1XVTXpakF4a8hoFl8I45g==
X-Received: by 2002:a17:906:7949:b0:a47:20c3:7c51 with SMTP id l9-20020a170906794900b00a4720c37c51mr7458383ejo.71.1713789601643;
        Mon, 22 Apr 2024 05:40:01 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id fy7-20020a170906b7c700b00a55b1253fe5sm1659428ejb.194.2024.04.22.05.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:40:01 -0700 (PDT)
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
	kvalo@kernel.org
Cc: quic_jjohnson@quicinc.com,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	idosch@idosch.org,
	leitao@debian.org,
	angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	Alex Elder <elder@linaro.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH net-next v7 07/10] net: ibm/emac: allocate dummy net_device dynamically
Date: Mon, 22 Apr 2024 05:39:00 -0700
Message-ID: <20240422123921.854943-8-leitao@debian.org>
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
 drivers/net/ethernet/ibm/emac/mal.c | 14 +++++++++++---
 drivers/net/ethernet/ibm/emac/mal.h |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 2439f7e96e05..d92dd9c83031 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -605,9 +605,13 @@ static int mal_probe(struct platform_device *ofdev)
 	INIT_LIST_HEAD(&mal->list);
 	spin_lock_init(&mal->lock);
 
-	init_dummy_netdev(&mal->dummy_dev);
+	mal->dummy_dev = alloc_netdev_dummy(0);
+	if (!mal->dummy_dev) {
+		err = -ENOMEM;
+		goto fail_unmap;
+	}
 
-	netif_napi_add_weight(&mal->dummy_dev, &mal->napi, mal_poll,
+	netif_napi_add_weight(mal->dummy_dev, &mal->napi, mal_poll,
 			      CONFIG_IBM_EMAC_POLL_WEIGHT);
 
 	/* Load power-on reset defaults */
@@ -637,7 +641,7 @@ static int mal_probe(struct platform_device *ofdev)
 					  GFP_KERNEL);
 	if (mal->bd_virt == NULL) {
 		err = -ENOMEM;
-		goto fail_unmap;
+		goto fail_dummy;
 	}
 
 	for (i = 0; i < mal->num_tx_chans; ++i)
@@ -703,6 +707,8 @@ static int mal_probe(struct platform_device *ofdev)
 	free_irq(mal->serr_irq, mal);
  fail2:
 	dma_free_coherent(&ofdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
+ fail_dummy:
+	free_netdev(mal->dummy_dev);
  fail_unmap:
 	dcr_unmap(mal->dcr_host, 0x100);
  fail:
@@ -734,6 +740,8 @@ static void mal_remove(struct platform_device *ofdev)
 
 	mal_reset(mal);
 
+	free_netdev(mal->dummy_dev);
+
 	dma_free_coherent(&ofdev->dev,
 			  sizeof(struct mal_descriptor) *
 			  (NUM_TX_BUFF * mal->num_tx_chans +
diff --git a/drivers/net/ethernet/ibm/emac/mal.h b/drivers/net/ethernet/ibm/emac/mal.h
index d212373a72e7..e0ddc41186a2 100644
--- a/drivers/net/ethernet/ibm/emac/mal.h
+++ b/drivers/net/ethernet/ibm/emac/mal.h
@@ -205,7 +205,7 @@ struct mal_instance {
 	int			index;
 	spinlock_t		lock;
 
-	struct net_device	dummy_dev;
+	struct net_device	*dummy_dev;
 
 	unsigned int features;
 };
-- 
2.43.0


