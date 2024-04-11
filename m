Return-Path: <bpf+bounces-26533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850C58A1684
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 16:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4AB286F05
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941C0153571;
	Thu, 11 Apr 2024 14:00:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6614C5BE;
	Thu, 11 Apr 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844036; cv=none; b=hdtSezl34EZM9UjAmvBPFZ25Zh/u9Nqd+IC+V4o18oQFGAXc0Svf5xnQmzYOqpz2k3gICRyFHUcxww6i8xqDPxodfhzU8b1erlQA08o0QDnujoAfLVikz/bizC7bY+NqY4onujSHIUf0Oq1Ll26GK7xBbEOlVhXgCaqaW03fbbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844036; c=relaxed/simple;
	bh=MB8+/MFHOEltGh7GM7e6UBLJe+yCPGpUyEgMI44tcDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZcRfH5/SDWLshTc2UaySfmYvhDUGb9K5PQQib82h+4CeNJdgDQZ5z3rAqgZn7JGJxuPtaUSgiJqoyesq2NrkQHP0Yeg/lwCIiAEYUhj/CvQ1ZA2KEfnKUqrYM97jY2ZiaS8QAUKH0S/+bpyz3rgs1xI1zyJVnFaPFiM3Yc9/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so11463460a12.2;
        Thu, 11 Apr 2024 07:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844033; x=1713448833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsBGQlMm+F00sLCL/qlkhF4TnT6nst/CdHn7pOQlov8=;
        b=S2CnkqaTNg8jdXyHHhqQdc10I7dCAK57PFkU7WbU4bRD1raIZ/S7bgv8At5+ROj20j
         hme3rq5wW0NqFTBRKpNNTlN8drGqqeYF04ZJRf7y/M1kkL03K+4dvLX7IrZ9vlLULaUL
         4xlKbxEJp6v1cE+sqdwlMh4GkgBXvQH7o1ZyQBDDd4Pyxplx9tVRE2SGoTi0AMaQ+xou
         rIFG70pUbuvzcLuYHgMS1LqzcYUXEeDNNEeUtWZXqakfXGJ6OBmLXqF/zvtd9lCP90+P
         GQYsDlTJXew/Ep7p41LidjBf/kXjl/8N9lv+cpJKJcnhnCZVYtzYMOttRyzr3eP/mrOi
         qJNA==
X-Forwarded-Encrypted: i=1; AJvYcCVMkFvkJQOg4uOcpqQq9rAgMexjb6DgFK1iCipBuVT/C99GCY5NAUa8HWuFnoBq1Fl9Qi/q3ttKnNGZUSOfRN3kRFvdLZvJbpIds4BdvYbJkxrSdR66eGe2Jf1m0zyAHgUgBsVpgsm2f7VL+SiW1b7Uc6NBrs74NG9W8bksBMzLXmNRMAI0GQGPd47mq0JEJ+Y7rD73FOHEOTw=
X-Gm-Message-State: AOJu0Yyu77RyV3ds5qyGT5RJk6bRkg0rKvKmHX+sKtNlIThHUe4Hp0v4
	KIsvr3Kxw8nlrTzToA7t1tBorXxHXclnDpVZJB4X1f5Ik86Jy+Vx
X-Google-Smtp-Source: AGHT+IFud+Eom8L4ZFwJRqHZVgEqfH7X88Ie/XPPj8tgIpWpDGGDBjHw1/LfCtyATsqdzgihSLhWLQ==
X-Received: by 2002:a50:cdde:0:b0:56f:ebcf:bd94 with SMTP id h30-20020a50cdde000000b0056febcfbd94mr1037512edj.12.1712844032908;
        Thu, 11 Apr 2024 07:00:32 -0700 (PDT)
Received: from localhost (fwdproxy-lla-111.fbsv.net. [2a03:2880:30ff:6f::face:b00c])
        by smtp.gmail.com with ESMTPSA id cs9-20020a0564020c4900b005682a0e915fsm733377edb.76.2024.04.11.07.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:00:32 -0700 (PDT)
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
	Tariq Toukan <tariqt@nvidia.com>,
	Alex Elder <elder@linaro.org>,
	Nick Child <nnac123@linux.ibm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net-next v6 07/10] net: ibm/emac: allocate dummy net_device dynamically
Date: Thu, 11 Apr 2024 06:59:31 -0700
Message-ID: <20240411135952.1096696-8-leitao@debian.org>
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


