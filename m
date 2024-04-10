Return-Path: <bpf+bounces-26422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A085389F405
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DB91C22DD8
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77CA171069;
	Wed, 10 Apr 2024 13:18:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3416F914;
	Wed, 10 Apr 2024 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755107; cv=none; b=rfrfKgl1hK4LXltUXDTPw0T0oOAV+uQeuvzODC1U/xrcFin2dYHNvIztJ7M7dpeqlzaqSG4eEwCATGjLZCTbCb5i6T4Dg8WI0B9mUhAq44+zKPwDrB78ShvQz6Sg3SjQJeXeYRZbEZ4K0x/U4ek+Ww3vNHuldxqBA6d650MCbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755107; c=relaxed/simple;
	bh=3jqcHKzZ3GD9fOOuNtL+5tC5x7Sajb0fEea0j4mcf2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNcydT42E+l5/7bTdoCvTMX3oZkNmd9FSP3+vGPZISDXAKP2S82CtjtISuqO6NW+AGcyUHfl+6nPdiwYa2JqPOJf4ZM3qqyVmQJMnn9do0lwXfv5D0h6uT28O28d6vmnoix2yle542MnoEcQf8Q10HE6f3B4lxnA8GF/uHYJyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d04fc04bso10377465e87.2;
        Wed, 10 Apr 2024 06:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755104; x=1713359904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BGqPmC8OttnSs/eU7zOpIE4pu3ScGIxqadvcYRpWVY=;
        b=Qextt6Lm2sUy0ej6P0pH6gWW/nKcPUMRdtFLUr/LiraYMGOSoT/awkZTXqOO2nb7+O
         PQsysFMyDhtlMWM26G2sC0Ube1X2TQwtoVkOoK/VzvoQm9ccQ3BvSgFAG0Y8m39qRiVN
         ZzMOq+U9ZcoxjAeGgtOSSMnQRc/Bd8c14meLnvfS+HJtXQYKBd/jd1U7ZmoG03hvmPEG
         OPkIkoj7zTFU8RD7DMFMX8ebDumMdy2yYtaUO+uvi/ZZPa+d3bVlyDczI1Xio3SFeaFc
         tR1ft0NEaO/kzgLJLu0xIx9xZUCUDiACC0+dRZUFyCkCKAnKuLYNjaKQUjIZqm+sOoiB
         Tn/w==
X-Forwarded-Encrypted: i=1; AJvYcCVxlcAZtx1wbLHIvHwAuRVPOqcq2b3ng1HA5H2cz7JAQ/FUqC/ALe4LtZ8kDjRHSicy6bA2nFHPzZIeINo5/o3crk3p1yXdw8yc38x0fLsF2OWXMTgy+np6cm/65DILmgJKkc/FRWcWgmF/mmFkWqFrnRVxpnHrl5CqhkgmcCafZo6rZsre+QdBmHUW65revae9obzQX+1BmNk=
X-Gm-Message-State: AOJu0YyO1Wh6hM/aan3IW+HvaSRtPjSsKMCLnl6ICd6Kfknt/ZxWNTMH
	8qLktqv/SrzNUt+VmqzruAjOw1Im6Xz7s0jI/acF9jj9VglyMru5
X-Google-Smtp-Source: AGHT+IHviCjCyxPLZMtL2RkyGuzaeGtDraBYTh6IkEObOiNwMifG9KcbhjesJ0nZLyGLu2godkApfw==
X-Received: by 2002:a05:6512:b95:b0:512:fe25:550b with SMTP id b21-20020a0565120b9500b00512fe25550bmr2904940lfv.47.1712755103739;
        Wed, 10 Apr 2024 06:18:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id kn6-20020a170906aa4600b00a4e238e46edsm6961222ejb.223.2024.04.10.06.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:18:22 -0700 (PDT)
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
	Jeff Johnson <jjohnson@kernel.org>
Cc: quic_jjohnson@quicinc.com,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	idosch@idosch.org,
	leitao@debian.org
Subject: [PATCH net-next v5 09/10] wifi: ath10k: allocate dummy net_device dynamically
Date: Wed, 10 Apr 2024 06:13:50 -0700
Message-ID: <20240410131407.3897251-10-leitao@debian.org>
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

Un-embed the net_device from struct ath10k by converting it
into a pointer. Then use the leverage alloc_netdev() to allocate the
net_device object at ath10k_core_create(). The free of the device occurs
at ath10k_core_destroy().

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 9 +++++++--
 drivers/net/wireless/ath/ath10k/core.h | 2 +-
 drivers/net/wireless/ath/ath10k/pci.c  | 2 +-
 drivers/net/wireless/ath/ath10k/sdio.c | 2 +-
 drivers/net/wireless/ath/ath10k/snoc.c | 4 ++--
 drivers/net/wireless/ath/ath10k/usb.c  | 2 +-
 6 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 9ce6f49ab261..8663822e0b8d 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3673,11 +3673,13 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 	INIT_WORK(&ar->set_coverage_class_work,
 		  ath10k_core_set_coverage_class_work);
 
-	init_dummy_netdev(&ar->napi_dev);
+	ar->napi_dev = alloc_netdev_dummy(0);
+	if (!ar->napi_dev)
+		goto err_free_tx_complete;
 
 	ret = ath10k_coredump_create(ar);
 	if (ret)
-		goto err_free_tx_complete;
+		goto err_free_netdev;
 
 	ret = ath10k_debug_create(ar);
 	if (ret)
@@ -3687,6 +3689,8 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 
 err_free_coredump:
 	ath10k_coredump_destroy(ar);
+err_free_netdev:
+	free_netdev(ar->napi_dev);
 err_free_tx_complete:
 	destroy_workqueue(ar->workqueue_tx_complete);
 err_free_aux_wq:
@@ -3708,6 +3712,7 @@ void ath10k_core_destroy(struct ath10k *ar)
 
 	destroy_workqueue(ar->workqueue_tx_complete);
 
+	free_netdev(ar->napi_dev);
 	ath10k_debug_destroy(ar);
 	ath10k_coredump_destroy(ar);
 	ath10k_htt_tx_destroy(&ar->htt);
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index c110d15528bd..26003b519574 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1269,7 +1269,7 @@ struct ath10k {
 	struct ath10k_per_peer_tx_stats peer_tx_stats;
 
 	/* NAPI */
-	struct net_device napi_dev;
+	struct net_device *napi_dev;
 	struct napi_struct napi;
 
 	struct work_struct set_coverage_class_work;
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 5c34b156b4ff..558bec96ae40 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -3217,7 +3217,7 @@ static void ath10k_pci_free_irq(struct ath10k *ar)
 
 void ath10k_pci_init_napi(struct ath10k *ar)
 {
-	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_pci_napi_poll);
+	netif_napi_add(ar->napi_dev, &ar->napi, ath10k_pci_napi_poll);
 }
 
 static int ath10k_pci_init_irq(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 0ab5433f6cf6..e28f2fe1101b 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2532,7 +2532,7 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 		return -ENOMEM;
 	}
 
-	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_sdio_napi_poll);
+	netif_napi_add(ar->napi_dev, &ar->napi, ath10k_sdio_napi_poll);
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT,
 		   "sdio new func %d vendor 0x%x device 0x%x block 0x%x/0x%x\n",
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 2c39bad7ebfb..0449b9ffc32d 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -935,7 +935,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
-	dev_set_threaded(&ar->napi_dev, true);
+	dev_set_threaded(ar->napi_dev, true);
 	ath10k_core_napi_enable(ar);
 	ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
@@ -1253,7 +1253,7 @@ static int ath10k_snoc_napi_poll(struct napi_struct *ctx, int budget)
 
 static void ath10k_snoc_init_napi(struct ath10k *ar)
 {
-	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_snoc_napi_poll);
+	netif_napi_add(ar->napi_dev, &ar->napi, ath10k_snoc_napi_poll);
 }
 
 static int ath10k_snoc_request_irq(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/ath/ath10k/usb.c
index 3c482baacec1..3b51b7f52130 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -1014,7 +1014,7 @@ static int ath10k_usb_probe(struct usb_interface *interface,
 		return -ENOMEM;
 	}
 
-	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_usb_napi_poll);
+	netif_napi_add(ar->napi_dev, &ar->napi, ath10k_usb_napi_poll);
 
 	usb_get_dev(dev);
 	vendor_id = le16_to_cpu(dev->descriptor.idVendor);
-- 
2.43.0


