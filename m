Return-Path: <bpf+bounces-26419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB12889F3FA
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB84A1C230E7
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3D15ECEA;
	Wed, 10 Apr 2024 13:18:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C686D16E86B;
	Wed, 10 Apr 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755093; cv=none; b=CR0ctiFTkhAUw9E8n50ZQtXlOoMtxnxJI2ohsbI05svDSWyV+HS9ivaXCymLn+eYE8baCt3SNBJs4K1RqfSJoy1sxhj7bbNOOuDYkDdzsY2RafVeq9UriBnY276e6P7xwuledvw4+qLDlI75Zcxd37mLv6wyMSJmeqAe7C3bm+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755093; c=relaxed/simple;
	bh=QtQ6sHpbu3QCkabgr6hTrp4OmZME1Hi0HLc2rVVa08A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWCA+O0mtCooZ36HyOyagS7yDn7v5shr6fMlBEFhNVXwIjP/4Ub9QDCKG+qDiUmio4Lfp0XRTVf4SaOMkR3pwlr15Dl+tnqafJTaKvDGi0Hz6olpOclfxpXbHSe64AZkqH2ZCTYADcm+fwdaJhqPALZacaEQZUQXkWckKSEndsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so4121065a12.3;
        Wed, 10 Apr 2024 06:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755090; x=1713359890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ui1DJxKv+GCSubTCimqVqNTb9BwhV0yVlSdcCwIQq1A=;
        b=Gb7kxmpnPS+LFuQaqmkfyY/4f1oPz2t34A9pBT5MLpaqqRx09XY/W737hJolN798tm
         rex6hJSdMIU05gpsS96zUZM3qWUyLHXdVHHV9SbtUd0zFkRDEjvGpRcOZ8EAr929WU6q
         Vzi1H68KiwBm2YYf62S7sHiO2wvkBEztMnfiyOnOIF7OcpazlA+3YH1DICtMm1JwNBYM
         Il3qVwXKSEWkRnjJkJs9X4temEIwFmuf9kYuzwV7JgAkZhak+sFtsHC6oKYgo+fvxOe4
         BNrFx2pAnNXdTgNEG5kdEYXqGqhOEdvpdmtLlP2/Sz/IqPJLCLiyKUm0PiXvcCS25UTF
         J1og==
X-Forwarded-Encrypted: i=1; AJvYcCW8lKrZIcMWzdQDp6lfW3HwpJdPSmr1Ku2IiEVtO61PoP5JTcFHiBnXbduUqqyxkKv6pVgDqtAa8JapA7aSIi1Pk/MTrFJDlicSGCKCpsIxtAZqbCrnf8E+ANftfHtCOqrG7pRGdWX1FQxLzEEV7h0fQ4tgzqpfRycg118JJAeOZUDQPnh7Pg3Fu8MnQEcGb4+YaK+NYu1A9S4=
X-Gm-Message-State: AOJu0YzIr2CRuFXy9GNRLfF28fFQcnXzPYl51EuxaGpUj6FlaeCUXVRE
	4aYl3kfCWqp1VU3kiiWT6XLBtltskwnqspkco0pIOAHrhrRwMtal
X-Google-Smtp-Source: AGHT+IGftURUiLhae3IWuo+JgModGLFYkH2l8Vww82aSVu0SYVtXrmdtfM8lFQGJV5CM4+6FNOQ1pQ==
X-Received: by 2002:a50:d49c:0:b0:568:32cc:f808 with SMTP id s28-20020a50d49c000000b0056832ccf808mr1310263edi.15.1712755090031;
        Wed, 10 Apr 2024 06:18:10 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id fi9-20020a056402550900b0056bdc4a5cd6sm6359853edb.62.2024.04.10.06.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:18:09 -0700 (PDT)
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
	leitao@debian.org
Subject: [PATCH net-next v5 06/10] net: ipa: allocate dummy net_device dynamically
Date: Wed, 10 Apr 2024 06:13:47 -0700
Message-ID: <20240410131407.3897251-7-leitao@debian.org>
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
 drivers/net/ipa/gsi.c | 12 ++++++++----
 drivers/net/ipa/gsi.h |  2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 9a0b1fe4a93a..d70be15e95a6 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1730,10 +1730,10 @@ static int gsi_channel_setup_one(struct gsi *gsi, u32 channel_id)
 	gsi_channel_program(channel, true);
 
 	if (channel->toward_ipa)
-		netif_napi_add_tx(&gsi->dummy_dev, &channel->napi,
+		netif_napi_add_tx(gsi->dummy_dev, &channel->napi,
 				  gsi_channel_poll);
 	else
-		netif_napi_add(&gsi->dummy_dev, &channel->napi,
+		netif_napi_add(gsi->dummy_dev, &channel->napi,
 			       gsi_channel_poll);
 
 	return 0;
@@ -2369,12 +2369,14 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev,
 	/* GSI uses NAPI on all channels.  Create a dummy network device
 	 * for the channel NAPI contexts to be associated with.
 	 */
-	init_dummy_netdev(&gsi->dummy_dev);
+	gsi->dummy_dev = alloc_netdev_dummy(0);
+	if (!gsi->dummy_dev)
+		return -ENOMEM;
 	init_completion(&gsi->completion);
 
 	ret = gsi_reg_init(gsi, pdev);
 	if (ret)
-		return ret;
+		goto err_reg_exit;
 
 	ret = gsi_irq_init(gsi, pdev);	/* No matching exit required */
 	if (ret)
@@ -2389,6 +2391,7 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev,
 	return 0;
 
 err_reg_exit:
+	free_netdev(gsi->dummy_dev);
 	gsi_reg_exit(gsi);
 
 	return ret;
@@ -2399,6 +2402,7 @@ void gsi_exit(struct gsi *gsi)
 {
 	mutex_destroy(&gsi->mutex);
 	gsi_channel_exit(gsi);
+	free_netdev(gsi->dummy_dev);
 	gsi_reg_exit(gsi);
 }
 
diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index 42063b227c18..6b7ec2a39676 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -155,7 +155,7 @@ struct gsi {
 	struct mutex mutex;		/* protects commands, programming */
 	struct gsi_channel channel[GSI_CHANNEL_COUNT_MAX];
 	struct gsi_evt_ring evt_ring[GSI_EVT_RING_COUNT_MAX];
-	struct net_device dummy_dev;	/* needed for NAPI */
+	struct net_device *dummy_dev;	/* needed for NAPI */
 };
 
 /**
-- 
2.43.0


