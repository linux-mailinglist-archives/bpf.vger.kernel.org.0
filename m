Return-Path: <bpf+bounces-26284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6105989D99D
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4A02897E6
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3978212EBE4;
	Tue,  9 Apr 2024 12:58:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22609130486;
	Tue,  9 Apr 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667517; cv=none; b=VPXy5kz1xVgHgFTGWYxHS72iipaphr1piSTpxqKKe09uUxE11WmzkBy08j/OOr2Th4HBpMkL43Q2QF0KigzvWJyOHDVHbQJS8EeRAlDfjhwcWBo9+yl0mpTSo9knt484uXIPinOVR5na9eyrurXJMIolVNc/qhXS6KiXACuxEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667517; c=relaxed/simple;
	bh=QtQ6sHpbu3QCkabgr6hTrp4OmZME1Hi0HLc2rVVa08A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/GpEYiWc7Lkd6x+u1JDAuAXXO7oU5wdCrRv//QmugDrdW/uL49gbXq8Gs1y6lVFPPbWgKoNDwvw0r7bkRDxlwZ/Ooqg8EdHFowm73pvVqqf3DzZyjkXZongAdrQaDWzCV61JbKo671ASUQXwL4qk8wMD1VNZCBg5S2QLhiBVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51fc011e8fso68899866b.0;
        Tue, 09 Apr 2024 05:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667514; x=1713272314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ui1DJxKv+GCSubTCimqVqNTb9BwhV0yVlSdcCwIQq1A=;
        b=qz6K39f9XQ/w7mqqzQ9C4IN6SmIRAWZYCZhaOYBJEz7CPk3LPKdxR9iXPtoBTZynHh
         fszSq2AWZtVtTOYpwf8FUTq74m8u75AChheOkduPzuJH4EIl0Sq+SntcUk5r/T+QeALh
         jpCwwIsvSsoVrAofV5KyNezqELfrX7O0k3kQgjRfGrJ6aqf5OEGZu/4zStGlYm0A1uSJ
         NVlT6bcY3SQhaVjIhogiPm5V32kr2QcrGDSWLMHO1+dF3jlzx450NlPMnt1IaJ/4TCkc
         StgxBB7oWylW/zKrz8JGMNqNlDQ+C9grqFMQvh6KTM339M88CwTsiIrv3H6SyyUfR1er
         O7HA==
X-Forwarded-Encrypted: i=1; AJvYcCXYfIn4UmhHi5BbNhjdIeX6SWaec0qOnVb9mVBAvLAulyDJzJ/9eh2aKOpAjgQ7O9hs1nvef4ZFIUh1D2mcaCJT6x3/zjf/xITxLSvIwP4TnS1UaOHzAWnheBm7w0C8+m1gkMpOrv8S2/K/4e/gA63/o0N7ITehKPB46/kIamwUq9wtvRlsGNRuDpovOnIF86OhxyUCUfZYPg4=
X-Gm-Message-State: AOJu0YyRLiB1wtlZpfCBE6Qd+4EwnXlcj73SMMTL17OBO7tfo/Tcm0SN
	gfEVQNIeY+N7HaGRby7mJfnltAVkb3/H5gTcnVNlzSfZs2NOSlW5
X-Google-Smtp-Source: AGHT+IFX9vgI8UCCry7BfofE5Ljgb8WBye/SIsxKOnQZrsH4P+U5jyrpZ39NCimgZJgd0natGKodbw==
X-Received: by 2002:a17:907:7ba2:b0:a51:b0e1:8640 with SMTP id ne34-20020a1709077ba200b00a51b0e18640mr9945768ejc.9.1712667514412;
        Tue, 09 Apr 2024 05:58:34 -0700 (PDT)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id ao11-20020a170907358b00b00a51aa517076sm5293794ejc.74.2024.04.09.05.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:58:34 -0700 (PDT)
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
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 5/9] net: ipa: allocate dummy net_device dynamically
Date: Tue,  9 Apr 2024 05:57:19 -0700
Message-ID: <20240409125738.1824983-6-leitao@debian.org>
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


