Return-Path: <bpf+bounces-26282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376E789D995
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 14:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F1D289803
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC16512FF69;
	Tue,  9 Apr 2024 12:58:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2112DDAC;
	Tue,  9 Apr 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667514; cv=none; b=p3w1cSK5C91sUK+YOR9i+30p+MuVxRHYhRL13vdulTMlcLKKwpGL7esnN2BiX7qEHyG8dcJ60C81ygP5Qe99IN2punOnnL4+poMAoVpUmHaAZ9Genll1TWEBX9GOoaUREAooo8l6GddKmxqDTymar5uxBTqXQl8+KV0O6bxJMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667514; c=relaxed/simple;
	bh=eBWqs9fv+T+1bqH2rncgTX0O81pwgTdfA92I++Mu2wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icQaDBdYvBWH0zl0IULmojn0rpvoIBrwft3QoZAoMOZvA2LclXEcMiN33oq2NQOzSVOmWrcUsQcJpuNd/OHoOV2MH3EwWxH2iyYY+vVpAIZL7hKZPQo0BlqqJFys/MTXhyE5EamSmIZYgcX6U3Ex4O1wa0Z546iNGZvxULf8dTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44ad785a44so657058066b.3;
        Tue, 09 Apr 2024 05:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667511; x=1713272311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0v0jOuLRJCnWd0s0TIZZ1gZgekQUwAKs2R0RJj3DsM=;
        b=kce0otZRexPf+mvO1IrbHwx76BvOAz+YuG3UcW7GiWZ/DjpjcMnc5HQsx4lzw45aBY
         A+oaWfNxHyx5MmCSOJ8J5F3L40QmlUNbGmCHV2YIRca7koKkTdux0A4Wd3ZYknJQdHct
         0aMnWeXOg/yG1eUgHk9P4+bp7UzqZWr85gGcyaafHD4z0R3zOQ1Gy1Dg5UH/hd/RxyLb
         tmpR7BmTlCLR1vEemILcZ/pvijWtl11sP1hihr6ZbaJC/UibrQY4cFP57+GqNWPYJ0j1
         Ls+6WCSLK9XMX14F5MyKXzuY294UOgRS9oOfrhF7HV+aQCCk/Fp4CwUleyKEXRNBfBHW
         beLA==
X-Forwarded-Encrypted: i=1; AJvYcCUITZxBK2+q4nQCVCLtu6zehMNNlMa6FInaGW7IaqWd/Z7OloRM+mMkhbbXOu83A5yzvr0otlUzufzpd+wS4oTbO2MZsid6HADX8XaK0uLYI2Qn1I5HtQGMcNiY0MpTkA5GXTPRAQhHWqcl1JRXrgHydysSBuotTGmf8B4MYxa5od5Jv2ZhH9dR9+aIX8TIC81lU8T5I1AisX4=
X-Gm-Message-State: AOJu0YzNdWgDZoLD+b1f2ynD+Kx1V2kylUajIsbNx95VOnSimVW9t4lv
	EW0claSLVRcWfBjjQ+LF2hw9VgzCSW1znMZ7nr0yMh8tFEzh+oh6
X-Google-Smtp-Source: AGHT+IHyK7ujyUyZh8iF233ZssOvRS6odkm3B+SQqJXDLyPLOk07R78HAolnGi6zyM2diHi7B8+VPw==
X-Received: by 2002:a17:906:11da:b0:a46:d041:28e0 with SMTP id o26-20020a17090611da00b00a46d04128e0mr7230425eja.59.1712667510661;
        Tue, 09 Apr 2024 05:58:30 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709061ec800b00a46d2e9fd73sm5660571ejj.222.2024.04.09.05.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:58:30 -0700 (PDT)
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
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH net-next v4 3/9] net: marvell: prestera: allocate dummy net_device dynamically
Date: Tue,  9 Apr 2024 05:57:17 -0700
Message-ID: <20240409125738.1824983-4-leitao@debian.org>
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


