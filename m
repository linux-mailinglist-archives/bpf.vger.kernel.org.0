Return-Path: <bpf+bounces-26417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF8289F3F1
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6AF1C25B82
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD63F16D33A;
	Wed, 10 Apr 2024 13:18:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEC16C44D;
	Wed, 10 Apr 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755088; cv=none; b=tB0rcFFWn6Mc3/sYQsY7xDaDsGx5EjklPkHjIKd5eocqLkOorrBurR3/vS/nK/WJBUg/dMPofwp00EZBcpTYqiPHA+hhDRNEObS7fNPCFvD3aNOMD0Z7oKwB4QikV9ZlWhp2oGzQYgmGy3sUp7OnVHr9QqGfHv4pMykFlpgEtUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755088; c=relaxed/simple;
	bh=eBWqs9fv+T+1bqH2rncgTX0O81pwgTdfA92I++Mu2wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0asKMrQU0vBXgc+/34otbccElvj3qcK0MuKf79GDEBbVt6flyHyS0A9gZj9tb5Ng0IbiyN7wAW18UuY93G89nB+2cZe2zbI4pvvGfyTwez7LR1/njaD4YfJKnJPjkKKiolkGkK95z3EZ9vxmNKng6YX6uh/UJ4+2BHrjfzD1wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44ad785a44so787288266b.3;
        Wed, 10 Apr 2024 06:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755085; x=1713359885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0v0jOuLRJCnWd0s0TIZZ1gZgekQUwAKs2R0RJj3DsM=;
        b=rjlXcVuiCnAa66Q2OVgR3UA0OD6Pq78H62Efl54tX9EYIvel9sBetVAUBXtHgeDVlc
         wSIN8TGU6U+oWnCBeLUIHmY2MbbmLoUi6FbQPfF1nSd6Z50S6nbgYd6Ckx07HPAVf1JJ
         dyqJ/qLnaXTiD7m3Ljn48LzVwIHGjWYnXeRya23ouhcViF1b16ksrtW5t/DXmJCtE4vR
         yKE8jYPgqi+SQj0O6W/kRCg5A6IoZv0o1ZmJSAWjUYfzxuUBdeoRYzkynDm6lM8uNlnf
         R3v5BtXYi2AbyXrION9psVe/M99v2xEAdGWB3XPUtkHIQF2wSqBb4lo5YjCXcacyNfXc
         NyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOZMGCemM6sg2vU2FItIFfN8WGmX1aGLZ6g3tjQ1mvrKxzSGGJ1S5+kJYKm+hh72UUqdFNvfKvK/WnFeNfCSCIHrr7x/EwZchQfVX4+30Ppuf3unO1lnUYmcOlsdl4U0CiGHY32XMfoW+ufVbBpq4FJgi2tg+ELDFXKsdvW3uXEYPQ6b9OHJe/HeG69R1x2ICzgLt3+MoMJsY=
X-Gm-Message-State: AOJu0Yy/uSxcg9BKqYkjwM4sl/PDxDWQlLSAIQrmAAnF68n5WZKUFjp4
	hqVcKY8x3YJ6PbsPvqFrL5UmMvl4PVVOPbWnHVx9g3WUvBfi3uFs
X-Google-Smtp-Source: AGHT+IH7+U+qW5DuChVaZ9Yjnr/uILgb+IAUK0IN9pp6hNnY+Ion9hpWvWwXtUxP7oAsdllTb4QHyw==
X-Received: by 2002:a17:907:20e8:b0:a50:e067:e211 with SMTP id rh8-20020a17090720e800b00a50e067e211mr1583949ejb.36.1712755085041;
        Wed, 10 Apr 2024 06:18:05 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id gs44-20020a1709072d2c00b00a46a3ad035esm6986256ejc.179.2024.04.10.06.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:18:04 -0700 (PDT)
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
Subject: [PATCH net-next v5 04/10] net: marvell: prestera: allocate dummy net_device dynamically
Date: Wed, 10 Apr 2024 06:13:45 -0700
Message-ID: <20240410131407.3897251-5-leitao@debian.org>
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


