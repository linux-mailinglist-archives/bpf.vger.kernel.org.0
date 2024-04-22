Return-Path: <bpf+bounces-27414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BFC8ACCF5
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F4F1F221CD
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3841C1509BD;
	Mon, 22 Apr 2024 12:39:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49714A097;
	Mon, 22 Apr 2024 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789595; cv=none; b=QmVtnsd+ACh0TvKodBLYp5bR2cxTtBsz17JhziB9SRylVeAnEZVN0TWHS4glmW/m4gjdAVE9q4bXWQ82BHq5dbsafHo0026b6TCNODuUkpfphLvP7gWtsNIXg+p122urr0GzG0gC2eDwZDF7YhxO2QKO+rIZg1LZLj9BUSDXzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789595; c=relaxed/simple;
	bh=eBWqs9fv+T+1bqH2rncgTX0O81pwgTdfA92I++Mu2wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nImSCdFOclXcOe2epbc5jGxoArvUzQHvehGodIuLlnw2eK0ZX3aEH07trhqQxoDSoGhWo7DaA2kOuMFUuevaDV1tdnl4VgO4YAJjQ3ayLeeoYUm1Ntn9y9dfKpKOHlvDttk4wUWBnpiA75teWgi7D/OhFQ4km/KsoT+uswkhD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-571e3f40e31so1765308a12.2;
        Mon, 22 Apr 2024 05:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789592; x=1714394392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0v0jOuLRJCnWd0s0TIZZ1gZgekQUwAKs2R0RJj3DsM=;
        b=E0y7L0lEWVm8rZzrYfHEjcBGVblhk8FmgeayMRoWZmSm0TwsdGYIKQPR6ic2lsAfOY
         0LcYa8j8jQm9ZBWmBOOQHEnGAE3mTRRHUOMobaKoDzbt6bseED2a63YnG7yVX08PiMRL
         dgMBBrdEwveh53AnN7VTmJSU2Ow5TPg4A2dqqF33o4qJ3kGNuIcH+ZybcLlQw/Tq2v7N
         883vYzn/JxzOE4BNwz4vZSKRAY/TP+Sy6yvNSb9tUbSh019EWBDoY1mZ32GYFmyOZriW
         gjuLuTznri/uvKwa8oyU20aL2BMSBRHfwqGoOY0M1l16V09Nn2HldCi7HZCnRxO4Rkdz
         DOZA==
X-Forwarded-Encrypted: i=1; AJvYcCWFgG9t3eZLdz2keoycHeXeQam4SmLXYeh0ZKagk7WQ8GtDdh4zO7+puPF72+w6LEqTtMrn6lxZezfD6ameJyx5BuktNCzBrfoEkjaB6rQqk5hzUgk/GNH3ObsurxuxLEfng8cOSaF+xl4leErzpBVTMWtNhtHdEaT7TCAGCtcvd7fnMWxK5KCFqRAmGeRkR4Re+HsyFgEBlyI=
X-Gm-Message-State: AOJu0YwDDGMigDUFEskKLoDd7Rk/khXRGN3DcNqzarftt9TdHaWzWfKg
	pE4N1yByU+aZ+DszRzjtUwpSiFOO5wftqgUz8HbbJqQTVNyXhpru
X-Google-Smtp-Source: AGHT+IGHbh2X84tfuM0BxvxkSJ4a/Te4rvJmXfwdgWIdWRMMTjRGBDQP4P9Ep594uDPYAWS3wGgSnw==
X-Received: by 2002:a17:906:1c5b:b0:a51:d204:d69e with SMTP id l27-20020a1709061c5b00b00a51d204d69emr7213996ejg.7.1713789592388;
        Mon, 22 Apr 2024 05:39:52 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a51d3785c7bsm5686475ejq.196.2024.04.22.05.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:39:52 -0700 (PDT)
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
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH net-next v7 04/10] net: marvell: prestera: allocate dummy net_device dynamically
Date: Mon, 22 Apr 2024 05:38:57 -0700
Message-ID: <20240422123921.854943-5-leitao@debian.org>
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


