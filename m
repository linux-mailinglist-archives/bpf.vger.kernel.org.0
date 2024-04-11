Return-Path: <bpf+bounces-26530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1838A1678
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4749F286DAF
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C1D152169;
	Thu, 11 Apr 2024 14:00:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261014E2D8;
	Thu, 11 Apr 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844026; cv=none; b=k1frV9XmlewG6+0lz3sptLLXa7Rp04QfmL5POHG9GS1JBuoKKDk2CZguQf87JW4Yra14rSTj6i5OeXXDi/gYoxEOhKd3LQOmFTjNni/oasPfVjaTRLBOE/rRTzOcmaSVsZG0bBFxDIkpSqYR+k+hcDaCQdJupoOmgPmUKFG+O00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844026; c=relaxed/simple;
	bh=eBWqs9fv+T+1bqH2rncgTX0O81pwgTdfA92I++Mu2wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkEkJ1U4z44iu920mYvwF5Snai3GHDvtXACwOUJgxHy/G6Ul7OM7EbLNMOelTHzf0LTDLmQL+iDXBmfRWBoEDoZMUYnnWOaAEpBgOOGNP2E/2hgTpjDzfbkivKhLyRi7ZmNd47fjqcKBdjw/ZlJlMDdXAIZ5DQlL0O2FGK0F5Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51b5633c9cso701222366b.2;
        Thu, 11 Apr 2024 07:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844023; x=1713448823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0v0jOuLRJCnWd0s0TIZZ1gZgekQUwAKs2R0RJj3DsM=;
        b=X2CzgP/0VjWMsqv36tNELMzzAcbgq54QimJGDXcf/DA1WH0Vt7CkwoqILGUf2X7Lat
         q9qspw5TPyFgJrREmtp8w0xD6b3LN399HZ3e3JBDMS2xLNW6IiUB0Gxy5US0Iqd5dgHJ
         8eq53aNPdcIPhyG2M1whrGzvkTp1d+e9rlioVTMyZwu+C66kLSDoWA3LuP+dKlbjdd8O
         9p8iUZUqpO6Tx+d1CUaf/d4fIPaI6WzBF1ZFbH4hzUKU0kCk4PEKhRleGcIWvXLS/u24
         SvRsJSVhtKE3tBv1ubAHqJ/ME5xvKJsvmfHB5Nb0UyPVbEMvpWS3ysui2cWWlhNGWkn3
         D4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIcfT1apiK+KnQiHgxF3XMz+wfLI9FMfCBrGlC+ITjl669x/+aDmxgJFBSyS4BVSXHOGIOCXQqpxQ/WdSTlQIQQ16MPude6S6nDdJQ99UxNdUOECvkLexA5HuCpKrs7EVecQhHLwrtCVCkn7KUki6BV3olQOItFkdixTxRRPcbx2x61CbIcqQRzMMQEaDs8CC/O6d3DSIWRXE=
X-Gm-Message-State: AOJu0YykODZI2DgAfqlfhxK0F4r5dHB/WgKi/hAW9CGjz5/5nUw5Hqkb
	YrbNt2aV0JkQz5eO3uJlvZTJ2HiAxlhOJXq/OKOi5InxNOgeUngD
X-Google-Smtp-Source: AGHT+IFTqR/jZFnHmzm557r9/orvtXq98TQqJsnkJeh4/hAmpJeNcj3bTkWrbtWZGaebbkVxKmYtuA==
X-Received: by 2002:a17:907:7210:b0:a47:3526:2e0f with SMTP id dr16-20020a170907721000b00a4735262e0fmr4354803ejc.75.1712844023166;
        Thu, 11 Apr 2024 07:00:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id hz12-20020a1709072cec00b00a5226401c60sm454107ejc.107.2024.04.11.07.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:00:22 -0700 (PDT)
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
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH net-next v6 04/10] net: marvell: prestera: allocate dummy net_device dynamically
Date: Thu, 11 Apr 2024 06:59:28 -0700
Message-ID: <20240411135952.1096696-5-leitao@debian.org>
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
Acked-by: Elad Nachman <enachman@marvell.com>
---
 .../net/ethernet/marvell/prestera/prestera_rxtx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c b/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
index cc2a9ae794be..39d9bf82c115 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
@@ -96,7 +96,7 @@ struct prestera_sdma {
 	struct dma_pool *desc_pool;
 	struct work_struct tx_work;
 	struct napi_struct rx_napi;
-	struct net_device napi_dev;
+	struct net_device *napi_dev;
 	u32 map_addr;
 	u64 dma_mask;
 	/* protect SDMA with concurrent access from multiple CPUs */
@@ -654,13 +654,21 @@ static int prestera_sdma_switch_init(struct prestera_switch *sw)
 	if (err)
 		goto err_evt_register;
 
-	init_dummy_netdev(&sdma->napi_dev);
+	sdma->napi_dev = alloc_netdev_dummy(0);
+	if (!sdma->napi_dev) {
+		dev_err(dev, "not able to initialize dummy device\n");
+		err = -ENOMEM;
+		goto err_alloc_dummy;
+	}
 
-	netif_napi_add(&sdma->napi_dev, &sdma->rx_napi, prestera_sdma_rx_poll);
+	netif_napi_add(sdma->napi_dev, &sdma->rx_napi, prestera_sdma_rx_poll);
 	napi_enable(&sdma->rx_napi);
 
 	return 0;
 
+err_alloc_dummy:
+	prestera_hw_event_handler_unregister(sw, PRESTERA_EVENT_TYPE_RXTX,
+					     prestera_rxtx_handle_event);
 err_evt_register:
 err_tx_init:
 	prestera_sdma_tx_fini(sdma);
@@ -677,6 +685,7 @@ static void prestera_sdma_switch_fini(struct prestera_switch *sw)
 
 	napi_disable(&sdma->rx_napi);
 	netif_napi_del(&sdma->rx_napi);
+	free_netdev(sdma->napi_dev);
 	prestera_hw_event_handler_unregister(sw, PRESTERA_EVENT_TYPE_RXTX,
 					     prestera_rxtx_handle_event);
 	prestera_sdma_tx_fini(sdma);
-- 
2.43.0


