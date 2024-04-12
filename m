Return-Path: <bpf+bounces-26626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F888A32A6
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 17:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16A2287949
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12E148850;
	Fri, 12 Apr 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oLA+8nZA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0E148310
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936332; cv=none; b=dRhTYC+3qdfkPUlQmcv97jlz1zxHLrAwxfXoiGklXgtMsiWLscu6Ts75SU2a+8UxvtYwcZAA5r2LeJKafIVCWhVYf8ONy5Uq6yGFBNGVTuuAXu2G9BOTPi3v+hryAA8+ltMZMODpD4MSZXXk6JpoCD1/IrhfIkzKDLR5eL3K5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936332; c=relaxed/simple;
	bh=Re/6+1U2LAuPEHOo1bgE74Qxp1Wr7Exdy/CAp9M2vxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TaKLXLRG3poeOUtUzKnovG+gNBPIcXpPEe/2G+5pDGyFnCthpf939f1LF44x2anCjHXc6NU4WsQu44gOS0kS5o1Vv0eMlz8ARAwhdQTRBRkHTKkFXgV4eHG2jklN1z0BaIIG03EPKXuxl6LpnQvMmwCezHdG5TZbNFJZDb4qaWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oLA+8nZA; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d8b4778f5fso9242111fa.3
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712936329; x=1713541129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGT1V+qxwnkICdCuj9bPwelDxtJ9iZysRlNMNFDJDUk=;
        b=oLA+8nZAe49wwx7uPggQ0tWjQxFsh8Ji0Mng8bwN9QIpZxa/Xc39KlS5UwInbKtGE9
         t5PDmrKDOrwsySEgdR1SV+25acdTRzQ1S7nND0qLSNsnxV6pOcSggmF54bVMnpHjw3EK
         thkFsXheigyYFzYCDIhX+YGRAA+zPncgV7po6QnLqu9zd2rccR2vaNlBMldH/kIzwdB7
         quzDZlEg8ovqXWZJlTLYutrSQ77ay3b2ErHhT1aavlvVt82FDyKwUeWC6o4TsbJDPHub
         hFFvAG2o94kgFah7AvqGeOhaWr/WHmcP868TOlveSsRU/Nv4txiiMum8ayZZJT3o3TK5
         BgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712936329; x=1713541129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGT1V+qxwnkICdCuj9bPwelDxtJ9iZysRlNMNFDJDUk=;
        b=TyAQUh0yL58jqNC2riz/SMbbuYC3gPOWAKfAQGeQRMzWqx6ZNBKQDXacZyFqSvOiZL
         Xj1tmKx7ZKVjdd72JAf/yOMx18m1lSg9dwrMcTfzrqHkTebr8VIOI8j0U6jkuzwf/MGK
         XgS9bCNSIAxSrUCWw/jK03JpreOR1A019fK7rIKl3Fx4PxPXtPvglsIXHqvCT2c6kTO1
         42zbog1uOloOcgUBIqWpPMlXZ6MTtWG3JGB/DoZBDeF0Cl/Px6rGfa2yjtH7Xcrkd7IB
         UjQxcvsSl5Dbenashy9ZDzYArxn9lcqC2Dw0gmRxj/W0nMd0K1jke153cuNa0TCHJ0/y
         egMw==
X-Forwarded-Encrypted: i=1; AJvYcCXgv73iZhx/Wlzud5DRFFBEMmsS5zWdz3k/zJKyb2P25bForwp4S7paCc06oS2k/m0PC8O+vd6wRlrvTW5MCcuKv8Kq
X-Gm-Message-State: AOJu0Yxb70YPhdYdmurxU8PJMC5p8XC6fCCf2/kmIoKMdJrhU58x8n2+
	T5poFYtYxJOW0v62NfFwn4Zsy2okskYjmZxXo1E7mI6ZbJ+pIRuiHlQj1QhmFEE=
X-Google-Smtp-Source: AGHT+IGAMzeVB+BmYUvEhD4kf0B+7Qmv5vfxlEfD9Jg/Pw0lyjnJOWxBZjXkA5kvb0EJ3MQfsAF3xg==
X-Received: by 2002:a05:651c:1047:b0:2d8:452b:f7af with SMTP id x7-20020a05651c104700b002d8452bf7afmr1996952ljm.48.1712936329214;
        Fri, 12 Apr 2024 08:38:49 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id k9-20020adff289000000b0033e45930f35sm4545791wro.6.2024.04.12.08.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:38:48 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Fri, 12 Apr 2024 17:38:32 +0200
Subject: [PATCH net-next v9 1/3] net: ethernet: ti: Add accessors for
 struct k3_cppi_desc_pool members
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v9-1-2c194217e325@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Naveen Mamindlapalli <naveenm@marvell.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: danishanwar@ti.com, yuehaibing@huawei.com, rogerq@kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712936324; l=1930;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=Re/6+1U2LAuPEHOo1bgE74Qxp1Wr7Exdy/CAp9M2vxY=;
 b=heOTqq4Ok3/KbJ5iU1uNpkdh/P0ApR24igyDMUJh4JLdHG37jAAriKffrnGT4K0Na+Iz2M2De
 iHOHU113/XTCxUMSY9lrWh3rNRKoNVFzJE2uFFeAj8XbmjmCnE/xKnC
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch adds accessors for desc_size and cpumem members. They may be
used, for instance, to compute a descriptor index.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 12 ++++++++++++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index 05cc7aab1ec8..414bcac9dcc6 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -132,5 +132,17 @@ size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_avail);
 
+size_t k3_cppi_desc_pool_desc_size(const struct k3_cppi_desc_pool *pool)
+{
+	return pool->desc_size;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_size);
+
+void *k3_cppi_desc_pool_cpuaddr(const struct k3_cppi_desc_pool *pool)
+{
+	return pool->cpumem;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_cpuaddr);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");
diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
index a7e3fa5e7b62..3c6aed0bed71 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
@@ -26,5 +26,7 @@ k3_cppi_desc_pool_dma2virt(struct k3_cppi_desc_pool *pool, dma_addr_t dma);
 void *k3_cppi_desc_pool_alloc(struct k3_cppi_desc_pool *pool);
 void k3_cppi_desc_pool_free(struct k3_cppi_desc_pool *pool, void *addr);
 size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool);
+size_t k3_cppi_desc_pool_desc_size(const struct k3_cppi_desc_pool *pool);
+void *k3_cppi_desc_pool_cpuaddr(const struct k3_cppi_desc_pool *pool);
 
 #endif /* K3_CPPI_DESC_POOL_H_ */

-- 
2.37.3


