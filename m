Return-Path: <bpf+bounces-26162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAA389BBEE
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 11:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3851C2210A
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0145F4F208;
	Mon,  8 Apr 2024 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qrMMFCkE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4894D9E8
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569098; cv=none; b=igY7sQUpYNerNJb4CvuRoUzv8SjpVWQKTt2UoHE0vzLbXvfqUbECiTMWhIcBfY0o5IWYQUhdzNByN8FTXJXlqImoclcBs+Ukdu3POI8fo/I1B27gIRjE1e1cBRNjUWKBjPo4eUPTZyVRQ+ulRRCVLdZGy20VhukLC+0pAx4oeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569098; c=relaxed/simple;
	bh=egsyeRYCkGmNZpNd4TFDJy0XrmDqk+g4czEF0/FsO7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmVspo7vo+PT+sKvd3cKgSNx481S0aDNRNfLcNzd8Am0AdDn4LRTZ7oiQ8wUzHc/1qawMS5rdPA+xZISZz2l2+2nEMKeHlhUCwJwUqyUOkDW/do9C7GPnWVqkXOxo+yYJnhWt72x6Se6dDo4yWP+a/Yykj3sAkVmYeJdTQmdub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qrMMFCkE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so244908a12.1
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712569095; x=1713173895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKnYVxHG6Ypqd9VKY8Y3OU7R3wT68BUjHb822YWnywA=;
        b=qrMMFCkE0iXH/0VDVG7LCzg74kXlflon0mR/hy+CYpduzRzlIyNToSkOmP0JKeiBSO
         u8Uu5UnoUM5O+ZitqhOKHvBWoMO+k9BW6yxYAgezIcAq/H7Le7C3V4BYcbhQol6qYhw1
         VnRRUzd8X/Sj+WpDsZHHVTJStn8QbIJs6ilRDEwa5P0WnnPnN2Aq2E0K6cTTcm9vEumB
         bvZMyvCfNicJj5ixvHIfp7dVRQ5qyGBBeNwVACmbiQdm+66t3JFJXPYwFbby0HbvZWCH
         /x6mHHyYE3PnO8c8uS0MUO68mQvbNQAnR5EQlJDk0R2M3d7+VHQKdF0DI0O/nxlAS2t8
         vsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712569095; x=1713173895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKnYVxHG6Ypqd9VKY8Y3OU7R3wT68BUjHb822YWnywA=;
        b=KnRSURjhUISb+vlobPvh+RJBoPNbF8koX6xxzleG2Xhd8ie9OVbEPTq/ubu6TDyoVF
         FCnd1k8uqyvKG+x/5lnWwQRy3m2LtYeMuYDVhTqeDl2ZdhaD0UcgVhw2vl2FHi3sXqHF
         SXqL3dxL73+JXTknWYeY5e9FhqoNUKeyr0gdC1sU7Gnhcic2Po2HGez0MhdIjoCKi9rP
         6KlRtWB7TFyxYGzR5FReexpypBmXKuW/Z54Q0UNbw7v8DNPUA3hKSa86Ey3wAMPb5/HZ
         LiK77PQVdnrrFCMoUw3aC8zP7ZC4sEsEPXOKPlPKc593zulcPy7B2E+7p5KFHJLGAutY
         w+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0itqh7vQOuURq6VIkt+N/eBUfqGmIKC2SAWiLTZ/fvxIl1aSqU29AixMP42mQf3IAVHAARXt9Vz3B5STpWnDOpwdg
X-Gm-Message-State: AOJu0Yy5W/E4M2ngiTdPoq4SCMxBzSBb8S5goEKb3i27bwSL2yGezUV/
	u+GQR5Zlhjad/1wj1b8KE5QlTTsRfoR/RjkoQr43/ftVB8f4vR9+c9wWkyEthfo=
X-Google-Smtp-Source: AGHT+IHgl+gOBCC18ARiTO3fEThbY4OkUyNz4i7KX80xwmn8UN/J5ysnLiL+7vakmrwgfOE5pdl2/Q==
X-Received: by 2002:a17:906:c29a:b0:a51:b463:6b62 with SMTP id r26-20020a170906c29a00b00a51b4636b62mr4084293ejz.55.1712569095151;
        Mon, 08 Apr 2024 02:38:15 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id ne6-20020a1709077b8600b00a4e5a6b57a2sm4175803ejc.163.2024.04.08.02.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:38:14 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Mon, 08 Apr 2024 11:38:03 +0200
Subject: [PATCH net-next v8 2/3] net: ethernet: ti: Add desc_infos member
 to struct k3_cppi_desc_pool
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v8-2-f3421b58da09@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v8-0-f3421b58da09@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v8-0-f3421b58da09@baylibre.com>
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
 Naveen Mamindlapalli <naveenm@marvell.com>
Cc: danishanwar@ti.com, yuehaibing@huawei.com, rogerq@kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712569087; l=3592;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=egsyeRYCkGmNZpNd4TFDJy0XrmDqk+g4czEF0/FsO7g=;
 b=EZWf2Dw1rLqJZCiv70aLLxj8z1Gtfoeh3NwBjUbr82+Ic+2uVOIbqWQyYlOfAKdNRJ20yticv
 2WUxdg4OoUOC53dXGo6QsqD4OWoGu7P4b1nBE7uz2zXxD2EYb7qfdcg
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch introduces a member and the related accessors which can be
used to store descriptor specific additional information. This member
can store, for instance, an ID to differentiate a skb TX buffer type
from a xdpf TX buffer type.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 29 +++++++++++++++++++++++++++++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index 414bcac9dcc6..e79d039fdaa5 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -22,6 +22,7 @@ struct k3_cppi_desc_pool {
 	size_t			mem_size;
 	size_t			num_desc;
 	struct gen_pool		*gen_pool;
+	void			**desc_infos;
 };
 
 void k3_cppi_desc_pool_destroy(struct k3_cppi_desc_pool *pool)
@@ -37,6 +38,8 @@ void k3_cppi_desc_pool_destroy(struct k3_cppi_desc_pool *pool)
 		dma_free_coherent(pool->dev, pool->mem_size, pool->cpumem,
 				  pool->dma_addr);
 
+	kfree(pool->desc_infos);
+
 	gen_pool_destroy(pool->gen_pool);	/* frees pool->name */
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_destroy);
@@ -72,6 +75,16 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 		goto gen_pool_create_fail;
 	}
 
+	pool->desc_infos = kcalloc(pool->num_desc,
+				   sizeof(*pool->desc_infos), GFP_KERNEL);
+	if (!pool->desc_infos) {
+		ret = -ENOMEM;
+		dev_err(pool->dev,
+			"pool descriptor infos alloc failed %d\n", ret);
+		kfree_const(pool_name);
+		goto gen_pool_desc_infos_alloc_fail;
+	}
+
 	pool->gen_pool->name = pool_name;
 
 	pool->cpumem = dma_alloc_coherent(pool->dev, pool->mem_size,
@@ -94,6 +107,8 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 	dma_free_coherent(pool->dev, pool->mem_size, pool->cpumem,
 			  pool->dma_addr);
 dma_alloc_fail:
+	kfree(pool->desc_infos);
+gen_pool_desc_infos_alloc_fail:
 	gen_pool_destroy(pool->gen_pool);	/* frees pool->name */
 gen_pool_create_fail:
 	devm_kfree(pool->dev, pool);
@@ -144,5 +159,19 @@ void *k3_cppi_desc_pool_cpuaddr(const struct k3_cppi_desc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_cpuaddr);
 
+void k3_cppi_desc_pool_desc_info_set(struct k3_cppi_desc_pool *pool,
+				     int desc_idx, void *info)
+{
+	pool->desc_infos[desc_idx] = info;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_info_set);
+
+void *k3_cppi_desc_pool_desc_info(const struct k3_cppi_desc_pool *pool,
+				  int desc_idx)
+{
+	return pool->desc_infos[desc_idx];
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_info);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");
diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
index 3c6aed0bed71..851d352b338b 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
@@ -28,5 +28,9 @@ void k3_cppi_desc_pool_free(struct k3_cppi_desc_pool *pool, void *addr);
 size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool);
 size_t k3_cppi_desc_pool_desc_size(const struct k3_cppi_desc_pool *pool);
 void *k3_cppi_desc_pool_cpuaddr(const struct k3_cppi_desc_pool *pool);
+void k3_cppi_desc_pool_desc_info_set(struct k3_cppi_desc_pool *pool,
+				     int desc_idx, void *info);
+void *k3_cppi_desc_pool_desc_info(const struct k3_cppi_desc_pool *pool,
+				  int desc_idx);
 
 #endif /* K3_CPPI_DESC_POOL_H_ */

-- 
2.37.3


