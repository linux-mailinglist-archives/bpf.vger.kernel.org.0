Return-Path: <bpf+bounces-26532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3758A1680
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 16:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BAA1F235BC
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BDD1534EA;
	Thu, 11 Apr 2024 14:00:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC79152531;
	Thu, 11 Apr 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844030; cv=none; b=AkKiKNE2dLjznGAys3VVHiR5meb/Rg+ri9B/nUcoezN3bBo/iTkhzJ0FvFzak4T3s6w+MqdK7QSw0ZN1Suq1f86LlzrWHsKdaj590N5QcYVFubOYzgV2mLYF7nD2Tmyxf4+xpURsM72YN1Y0EfoYHWC8CKF5Azkfpcfj2ZND+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844030; c=relaxed/simple;
	bh=QtQ6sHpbu3QCkabgr6hTrp4OmZME1Hi0HLc2rVVa08A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8DCB759CLmpVM1GwgJAaagnfw+d2bM/UuSl0uOZoHTfPQY9XBN0EkHu6K/JLIoZdfAUOODWm4m8a5CpPFDrAMcHSFF8glwMYi5AomY5jC/DF0cXQRH675Fmdqr2MKD6iGYAFsNGCO1HSnyMewZ6I1K+exFfJV0qEzoma0nWbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so6035235a12.1;
        Thu, 11 Apr 2024 07:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844027; x=1713448827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ui1DJxKv+GCSubTCimqVqNTb9BwhV0yVlSdcCwIQq1A=;
        b=GJEdN3EG4ztZAPpcM6j+gbTKOZM0t5PlW0U8ABAzYQMnF/kmDBwpUIrizbDfnnIam0
         yA9qC3sR1JoleESApvCp+aRuFG//qy+9jljv4316Vw1+MbRezXHDrn8+I8FuSrYh/a8B
         YET3itWyVx+jki7re/K0ad3Ine4OFH5b4fhDjL7ns8uMc+VWMrryc7hFD/UFjXv6ljBY
         tEYS3kQAYhiqlWh94FDB8LBXrP9Bj+F5V+tgj/cItqxFg04/dbT1I3BqJXNFyc6Hebtu
         lLx1BVTnu4ZbaSb4XQQqTZy++UzapB4mknkyd1DI1lHGYRgpv03q0piM4nOiawDUXvmT
         eUOw==
X-Forwarded-Encrypted: i=1; AJvYcCWs2KioW/USVQVThVm7xa8tuuZ8DUcAW3EjnQzff5AS6J1ovOGwGMoha7UeGEYaiFUr+2Y3t+4ScMZl2RFStmQ7NVNPo+LqUdgyLllnEiwMzSfip2JeRd5J8iWv1FxvLUiGAFVPKzQtJPdDKZQ9CEru9ZcNS9K8o1K/lc3ah6D/P4CTJF2py8fjL88n16fN+hlnfL6nue47+Ro=
X-Gm-Message-State: AOJu0Yxqgv+hw3fBZHCGe7uUhz2DZcgf81QyVIam6E0LFNuftALeeKpt
	PgGM3OufxH1SQsObD1IEvVW5Cjrj0dDchEDP9GgJKTXY7a5Kb68I
X-Google-Smtp-Source: AGHT+IGa4CDM72vlKOor8+w1MyVyP7+F7eUpGeuoeMCvslO+UDO5Y56CkrGXAa2ECZfmmZeR4r3AZA==
X-Received: by 2002:a17:907:7f87:b0:a4e:6b81:49db with SMTP id qk7-20020a1709077f8700b00a4e6b8149dbmr4431766ejc.8.1712844027220;
        Thu, 11 Apr 2024 07:00:27 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id hz21-20020a1709072cf500b00a522c110705sm200497ejc.148.2024.04.11.07.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:00:26 -0700 (PDT)
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
Subject: [PATCH net-next v6 06/10] net: ipa: allocate dummy net_device dynamically
Date: Thu, 11 Apr 2024 06:59:30 -0700
Message-ID: <20240411135952.1096696-7-leitao@debian.org>
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


