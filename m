Return-Path: <bpf+bounces-27416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B1A8ACCFE
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DA61C20803
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E918D15218D;
	Mon, 22 Apr 2024 12:39:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AC14A097;
	Mon, 22 Apr 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789599; cv=none; b=pZNtfnVMZcjv4okC2mwVIrl58e07XHIim5ou8maqOZbhGeqWJ7jpKhoMdp2AKqLYdFVK4ABvFN7UVEtBInRCGcRi5L77IaKCnun1c9+8+YR2uIXb+qWDeQNY2zGt4N1oT4RksrUpYt8JuZNKtXYOeOuTF7bh0qj+0DmfzLULj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789599; c=relaxed/simple;
	bh=sIEoQVn7SzkSF0EcPon5MV5UPIJrhy7wn8PgFyS1szs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLXvzxT14RDicWSQr8eFC0IkI0OXL2vB6Vsw/LekuEK17VB+v2p96SDDIJ4B80oGNiPuOFtluyDI0ooTriFA30PtlWxbS0Q/WyyjrmIOqEJo4coSpY4r2ZwjlN5SmLOjcKbKoV9M1+l3dMPt3p2+wgoD/Skmr08sgU3GfP0OnOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a524ecaf215so444055666b.2;
        Mon, 22 Apr 2024 05:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789596; x=1714394396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM0a8ULPX5sI9tlDTBlw0auBDoAkdJnRbFJIF1dAPsY=;
        b=fQZW+95N8mVZMf/Wvf0P89mBBhxoywCbyJ21kcVpX90EdO0w9x7cHqidL0oXbBk1xY
         OkVJlk8FvykzU/zl7kAei67gmiZdBW70jJCtxEExcrMueIjnNlspQmwLbAqdxIDXoEEi
         HisR+1xXikkrlmGjFtdtc/e8LXrbNC/xM+3CXyIClEn1GwT/wb3Ko/LIWRh8p9wALKQj
         b8++Q83BHkdVZCWtwsVHjBch1nGZfBsVt180aH6u4dpoVPTBCfqs/75JtMELvJ+MGt/6
         B9SAHX7Lfm2L2Lniol0FQLuqwWtM3qqw5vRvK8/ip6sJpF6EcPt5vaNU+lPQX5k7PaPF
         ieag==
X-Forwarded-Encrypted: i=1; AJvYcCW2y+YQTXRR8BON4kTspl5MkNXQp0xfgKuatFEX1diQjVLTJ44frfvvj3OLPhtYBM4K0dJG8qIzs5wEd777GLmFiaD9zItDE0HvCJsjfhB0/cpOArwNt551Qo8qKFAAzfNUaUidBG8p5bvzEUvTNIv4gKnvhXhOW430V768eaQpuV97LzvVgNPUIdYaxQGvOoAaUXEZJy27q5M=
X-Gm-Message-State: AOJu0YzEpfwiq3W4zHIz0i3SWXJughddDvbTN3gqyaYPWiwYLECpGZXs
	3YWTcMepsAY69eJYVSlAO2Y2L7M+S983U1db7raLXH3tVVR+6Afx
X-Google-Smtp-Source: AGHT+IElmg7ko2SsLHcYhHpsj+2DNo6Q3PnnNVq9w1uOVEKpYSOEVIxGi3DE4xNzSKfjHpu7I5+s8A==
X-Received: by 2002:a17:906:bb17:b0:a55:55b9:57d1 with SMTP id jz23-20020a170906bb1700b00a5555b957d1mr6041497ejb.66.1713789596151;
        Mon, 22 Apr 2024 05:39:56 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id gu6-20020a170906f28600b00a4e44f724e8sm5708241ejb.186.2024.04.22.05.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:39:55 -0700 (PDT)
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
	matthias.bgg@gmail.com
Subject: [PATCH net-next v7 06/10] net: ipa: allocate dummy net_device dynamically
Date: Mon, 22 Apr 2024 05:38:59 -0700
Message-ID: <20240422123921.854943-7-leitao@debian.org>
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
---
 drivers/net/ipa/gsi.c | 12 ++++++++----
 drivers/net/ipa/gsi.h |  2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 6c8feb640a97..4c3227e77898 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1728,10 +1728,10 @@ static int gsi_channel_setup_one(struct gsi *gsi, u32 channel_id)
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
@@ -2367,12 +2367,14 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev,
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
@@ -2387,6 +2389,7 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev,
 	return 0;
 
 err_reg_exit:
+	free_netdev(gsi->dummy_dev);
 	gsi_reg_exit(gsi);
 
 	return ret;
@@ -2397,6 +2400,7 @@ void gsi_exit(struct gsi *gsi)
 {
 	mutex_destroy(&gsi->mutex);
 	gsi_channel_exit(gsi);
+	free_netdev(gsi->dummy_dev);
 	gsi_reg_exit(gsi);
 }
 
diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index 833135b35380..9d8e05d950e3 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -151,7 +151,7 @@ struct gsi {
 	struct mutex mutex;		/* protects commands, programming */
 	struct gsi_channel channel[GSI_CHANNEL_COUNT_MAX];
 	struct gsi_evt_ring evt_ring[GSI_EVT_RING_COUNT_MAX];
-	struct net_device dummy_dev;	/* needed for NAPI */
+	struct net_device *dummy_dev;	/* needed for NAPI */
 };
 
 /**
-- 
2.43.0


