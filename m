Return-Path: <bpf+bounces-26285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6246389D9A1
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914CF1C20B22
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 13:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F420130E4F;
	Tue,  9 Apr 2024 12:58:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9912EBEE;
	Tue,  9 Apr 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667523; cv=none; b=UjQNVGekunv0HmllmCYI1LpFstg4Wfok/rCXTTBuEm/Ge/J4dbdbRJNaDekT0yap1DrRGGorjFpXMrFtWI0Fxtfpeli8ntIzqWXtEt4tQE4FP76VWZWmQK/CVZjXNc40wFi+3V28eAoYutuPWsZN7bl/5jd32P82Wmj5TjJABHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667523; c=relaxed/simple;
	bh=MB8+/MFHOEltGh7GM7e6UBLJe+yCPGpUyEgMI44tcDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEWGKd6Cx21SdRcuLiUCws6ZsDvWG85bSZkqZjG6bYZ3OuF5vZsV4JXEHDCg+YB/TGc0TNzE6rSiBDphemZAss+BGeVtqPbxUgWP6Fi8/aEeF383QjV80FBbxG/j6HCWv6tPXkYptMmm/ssQlt1q8cUtrf7h9gJKzQ/cFC9pxYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso22745561fa.0;
        Tue, 09 Apr 2024 05:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667520; x=1713272320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsBGQlMm+F00sLCL/qlkhF4TnT6nst/CdHn7pOQlov8=;
        b=vvMVhwHQ0Ma5Mg5SzkVTqVXZkc3LRRHy4VSgyQUAtPIimNMlYqYB5XEXe/1nGKxiQV
         k4kqHqfECa60Zu3+21bChNrC0Ai7DAhbqE2ifcdGoCPctNg/S5xJyhVE14kG3BpkKqSR
         jhqeDiUC7vxt6ZVpIpQUF7dflFozCwwcIM8ZoI6yOx2eEa6H342W+wuOavRXHvjT/xjx
         Ec03lECF+QRZWtYpqIau6/kQE9Z8taTlptpHNoVmpPtZQZkdZC20AlcQqVSbgdTYoK5S
         rDqPHsUQhr+UMJwLLn5+R5ZulGm7k4M7Bxdywu1mXUN+sGsrQjC1biQiUqjE0E/OAJR5
         8hNg==
X-Forwarded-Encrypted: i=1; AJvYcCUakMYWEIZlf4BuHiBPqk3haZ0JbMHNMiTk4GDV19M8XSGNVEOCkhZatFHgIofh85FzJkcExzd6sHpAF7kTKJ4KEsG2CLI+YXmy9MM6S6tqMy6AIWpR+uvtWdQgHO6hfftivDc7c5X3P08RYXaeG+FNnTFwBW0VpGWYWtNXm4SWpPn4B9iFbNrtENMXdHwV1Ki9igpc/cLplHk=
X-Gm-Message-State: AOJu0Yz3rUIOrBb6daFYw6u6Huwwb30xDkS87F7tccRTgC3CUFcEZFVt
	re+WmamVfKvdgEK7bd+yJ6aqBcin1BOXuC09JmfT32x35eujgP2H
X-Google-Smtp-Source: AGHT+IFv2F9tjG1pTfhQ3ayjSwIyYhqoG2h0I6HYPRoOOsyO4a7PYZ9y4kYYkXAVTH8/Ca3Th0oWfA==
X-Received: by 2002:a2e:86d0:0:b0:2d8:a82f:50a0 with SMTP id n16-20020a2e86d0000000b002d8a82f50a0mr1107084ljj.35.1712667520220;
        Tue, 09 Apr 2024 05:58:40 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id q18-20020aa7d452000000b0056e247de8e3sm5224408edr.1.2024.04.09.05.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:58:39 -0700 (PDT)
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
	Tariq Toukan <tariqt@nvidia.com>,
	Wei Fang <wei.fang@nxp.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH net-next v4 6/9] net: ibm/emac: allocate dummy net_device dynamically
Date: Tue,  9 Apr 2024 05:57:20 -0700
Message-ID: <20240409125738.1824983-7-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409125738.1824983-1-leitao@debian.org>
References: <20240409125738.1824983-1-leitao@debian.org>
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


