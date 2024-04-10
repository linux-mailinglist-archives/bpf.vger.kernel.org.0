Return-Path: <bpf+bounces-26420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3182889F3FF
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634801C22EDF
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3939416F0CB;
	Wed, 10 Apr 2024 13:18:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA815ECF9;
	Wed, 10 Apr 2024 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755099; cv=none; b=si4Sp13SnX5QyQatBc0GMPeCQbr3ESpmeJMduy5dmpCRKLeLxsCKTz2xePPkL24+OYDeBO/V6QHB29q7Pf4L7r5kbAsJihOIaC5lMPrN5HLn8DSRGRT93eiqxb4ATlClTlswjQsKpg9oaekhw55sXOsL6vsB+SHq1BvtqVLHqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755099; c=relaxed/simple;
	bh=MB8+/MFHOEltGh7GM7e6UBLJe+yCPGpUyEgMI44tcDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5aGu5udhrfkyiygo5msSTmjSxfDHYOCHPgm/wc+RF3CUSDMSwKXjm5gLzbhCJgX4CdImilfNPaOZgQTyC95YfCis7iuBUQbqc1sS+6WCMkmyI2O3yKKr1aO3s0hH7ZaN6iSed5L6v0WIGWK7HINKEYtAW8YwMx8p4PhsyQ+c8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d485886545so118035971fa.2;
        Wed, 10 Apr 2024 06:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755096; x=1713359896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsBGQlMm+F00sLCL/qlkhF4TnT6nst/CdHn7pOQlov8=;
        b=pMZu6TFWP0mpo7OQ7GGc5Bju9UXHSPYkO/uhj+6xHUO8mjXZolvF16dVAVIiO+lCI1
         OFE+Kmj4IgzvKj6sMqdjK89gMPrv+dqrEOw9/I8KgGK6YvIr38bk9y5AvMQ1vdLbgTx/
         vqho6uzaFgIFSK7heAB3JE4yn/8IW9pjlKuDPDXyi+yj/F+Hz0jcszqvB8qWrCZA8Hmu
         9ep0+2zGY/i6OjXl0S+3pbAVSN2oyRthmxgDeRHRveLLwzF4Hr7ZZUm6dXsQ5FChiqpJ
         1+Hy98H2NfF8Si2Y1oOV8pIE1FQNiiklY6JxtA27wftIx8eRrwci0ivGKoklqCMJBxFD
         yJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLlS9JzUI4J4nhio74G2dYkT7zkp4A6Xq96iD2kjNmyV7yxjPiYV3S/YGVcIKuELBuUnra7gUyBWZkM9C2JXZzf/n8vwXW9bK4x0/9J6YQ64r/ZAETvIWwlNf6t3ap9AuEbtssZ42JLearonvP2KSFzIXasyUAoJ+Kloq6+5tCJllhGU0qpcXJKf/IPruGqPhUGrkzKyArX88=
X-Gm-Message-State: AOJu0YyY5d3fc/WNplcQqaBHynzaSsYUItg5jt2O6P4zsQZ8lN2+E+iA
	OnfAckyN4BimtTX0LFE/nafoIEwIVkl7QhzthGDpCYmIlSzqHOfj
X-Google-Smtp-Source: AGHT+IGPO9wT0OKbwO/gx4+xhRnOuGA7eN0JCfBeTdRn7c+VdXyJ56ZmoGT8+49f0mI/Xs97HLpwLQ==
X-Received: by 2002:a05:651c:4ce:b0:2d4:49d1:38e with SMTP id e14-20020a05651c04ce00b002d449d1038emr3242747lji.28.1712755096217;
        Wed, 10 Apr 2024 06:18:16 -0700 (PDT)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906b30a00b00a4e08e81e7esm6881397ejz.27.2024.04.10.06.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:18:15 -0700 (PDT)
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
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Nick Child <nnac123@linux.ibm.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH net-next v5 07/10] net: ibm/emac: allocate dummy net_device dynamically
Date: Wed, 10 Apr 2024 06:13:48 -0700
Message-ID: <20240410131407.3897251-8-leitao@debian.org>
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


