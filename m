Return-Path: <bpf+bounces-23147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9320E86E3EE
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 16:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B57BB226A8
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3DC6FB80;
	Fri,  1 Mar 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="foq7AARx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0C3AC12
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305397; cv=none; b=LlYTfmUowmXQORhCe6gCzyBMAM7Dd1OOlC+QOuoQH9YMckeLbV2WdIlJXUumBPCSrLO/xLpN2E+UUTdkd3mWmfNxdDNo0xWJO3BIOGIzFdxW8m/0hB6OjifQPlVDPXw0Yv1rMHzxfBZqeuwqbg6dsrAz4kRqrMtAQtJHzgGWnTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305397; c=relaxed/simple;
	bh=EbndbMWImRHT/Zd+Qtiz8QKdnhzhNDbY2t+5huMZp44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZigbMFleiYTcoky9R3O9qBovjt+kao81Ly371UvdfYCb4WbQv5K8U2VN6Lj7nSqpOjCTwXY6v2BARj5P+/qDBmjiMAG+AYysDVqBT4rREl2k4x2vylqYzLEV7EFf5mdWbvI7CscIf95/uSDk8iEXhtnG8pYFrZEIZXlU8ehKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=foq7AARx; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so23988801fa.3
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 07:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709305394; x=1709910194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1ewQPCjSRFFTnAzhBTqIbNVKy9NJW4piTjNHE9xDN0=;
        b=foq7AARxRnWxGEJ0jIcqiRKKfTXJ4KurSxbK2Hw5uUwB4xDNb6F60kJpalxW9yDlE8
         yXLCQWZAi/8oUMUpp9y0CQ1AaoEjxdCCRGOcpNuFz/F4+jYlzoMvhE9Rmw6oVOL2vwBP
         K7lijjZu+RerhbM+VKLtwgLh4Vjy27GEI7VOImvxDj9KsEX4UU3N1UoHT2dhNbckjstt
         6HFtTXgI8aZKkWi5Qgk+jOaAlAtUDiJgoCFPPLHnhevRs1esQY80Yp2ErPrcpfRVf61n
         ol9HDqbW8c5X/x3MBppOsAvAiV9dVRP1GyE9kK3POp3ODODDn+npC6qx58pa/QounuKy
         NRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709305394; x=1709910194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1ewQPCjSRFFTnAzhBTqIbNVKy9NJW4piTjNHE9xDN0=;
        b=XBVsEmxdcZF9mWTWaUYK5lnTVVyyWOeEEWMEWizYAkEvQytHX2uqnrk0MW+FBC9SWI
         PgFitXlM1B/2e5QVwHDVxtH0xIfjhODAbVUrmeAN0J7Ql74LpD7IKd2nlo1DU8Mkt7sK
         lTgboy4KBPSFPLmhBU9xGqA+8smdxzSpdB4WGqogrJ6A3s6Te0sVK4dp2C65mXC/gM4g
         RmvITLnZQ2htRHamNLkLbTCRKph2pWAYoqsP2ssS6mrxuBOcCcH2RvQG/VTUlrwUugWP
         SPmA/Wf6SzGysyRAlMrEzb81rugHIkVGbopV7mNWxIpsjcyh01YQ3JCJ7u1VbA2PeWE7
         SSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDuhrwn83kJQf4GANmBvZrD5e67pOk6I8VnoM1HoTDLg/KUvn4r0nUO21P/FMHBvvx9/cn/8dy7W8O357k3v8IOWXa
X-Gm-Message-State: AOJu0YwDcB0YPYuM/MvbJ9FnWqhkA88haRpTdLR3N11zrgd/IoCSY/BK
	BN/DfmSjFW4GUJIfeyUqa4yrKSSZU4doifR0J8CL3G0NM5KqLiivrL/aw9riXFY=
X-Google-Smtp-Source: AGHT+IGUKr5XgjU6TuOv0mpo8L8nD6eU1BjTFxCjpnBp8lzdPBlpysX8CKZNTtSVQJIMO1v3TPLxhA==
X-Received: by 2002:a2e:9415:0:b0:2d2:3017:c144 with SMTP id i21-20020a2e9415000000b002d23017c144mr1362086ljh.39.1709305394086;
        Fri, 01 Mar 2024 07:03:14 -0800 (PST)
Received: from [127.0.1.1] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b00412bca49a5bsm5666875wms.42.2024.03.01.07.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:03:13 -0800 (PST)
From: Julien Panis <jpanis@baylibre.com>
Date: Fri, 01 Mar 2024 16:02:52 +0100
Subject: [PATCH v2 1/2] net: ethernet: ti: Add accessors for struct
 k3_cppi_desc_pool members
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v2-1-01c6caacabb6@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709305390; l=1861;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=EbndbMWImRHT/Zd+Qtiz8QKdnhzhNDbY2t+5huMZp44=;
 b=82JY4JvNcwuNykwwf9bi9p4VvX7xmFPPC0nhH7YJhdGp27tsLGn8FMl/dr+mZfIpZnBW4Odhc
 3OxI/TPWAAQCVaAqG0egpgGwz9qrQATQExQM+gQBKFmaZlf6tEgTdIq
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch adds accessors for desc_size and cpumem members. They may be
necessary, for instance, to compute a page pool page index.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 12 ++++++++++++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index 05cc7aab1ec8..fe8203c05731 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -132,5 +132,17 @@ size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_avail);
 
+size_t k3_cppi_desc_pool_desc_size(struct k3_cppi_desc_pool *pool)
+{
+	return pool->desc_size;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_size);
+
+void *k3_cppi_desc_pool_cpuaddr(struct k3_cppi_desc_pool *pool)
+{
+	return pool->cpumem;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_cpuaddr);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");
diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
index a7e3fa5e7b62..149d5579a5e2 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
@@ -26,5 +26,7 @@ k3_cppi_desc_pool_dma2virt(struct k3_cppi_desc_pool *pool, dma_addr_t dma);
 void *k3_cppi_desc_pool_alloc(struct k3_cppi_desc_pool *pool);
 void k3_cppi_desc_pool_free(struct k3_cppi_desc_pool *pool, void *addr);
 size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool);
+size_t k3_cppi_desc_pool_desc_size(struct k3_cppi_desc_pool *pool);
+void *k3_cppi_desc_pool_cpuaddr(struct k3_cppi_desc_pool *pool);
 
 #endif /* K3_CPPI_DESC_POOL_H_ */

-- 
2.37.3


