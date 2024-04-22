Return-Path: <bpf+bounces-27420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89848ACD11
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A251F22F6E
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACE715357F;
	Mon, 22 Apr 2024 12:40:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2314E2FD;
	Mon, 22 Apr 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789613; cv=none; b=Fexl4rWVbqYCC7HKVH+u66z7C2UAG8jbrgE9+FvZ/kvjtsZSPVQL8fvacmfM6XczpKhO9tLGKCtlNDJYTMhtJd9xxL2sJbjO2UNlX7kCozoz7WQX6PeRCbWW7JzqT5y8N/9tox8drKGACa/F0q1eCgK0V06EF0MzSrVNY0vwSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789613; c=relaxed/simple;
	bh=C2/enydAC2YCsBNnm5NUTUC6WvB4CkjpCpQsFsdVyag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzPDE4ytmM/oy66RC3vpdagTRQGiE/icfqUwwKV7RFkWH5YqyfH2OGbDm0JUfqUQzfhKRXp54mr7ymIkVZywtpSHylo2gG9DrQ6xwmKjh7xzZtvPQxGPAr4EeQJR+odylTiPv57AsXca9pSVby6De+jnmYLQF2KuHDYHMfcwFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5720d52eb10so809705a12.0;
        Mon, 22 Apr 2024 05:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789610; x=1714394410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrYnp1tDsZ0sxZFnn5u9gBZrt+Gb2bRXco5M67sATos=;
        b=sJwTRuwAnhIuk2NaLokJx42mvtDH6cZC9YvLlaE3/k0tkW6vCPOuOfY/WqVmBkknSB
         c9OBmqG8VfHA8/78MdocR1zSmX0kByQiXjTqWh34SD6uEi0sg/jo15D2F5vVycpDBppz
         AeTsASpd0KZ3Gtks2dsESn9Xv6FnDUxtJ1UWhejguWz6YqFsElecVumCxHaukLHPWlnY
         hPTCIba+hndY/ZH3lw+sh2U8GfQwqSxV4VphlttYdixBwhKUWlaUGJvj60w5Ldb45eCM
         Uyx4rKCSKd/ryoYMcPWvNUCtcjHDwVJh+c9d1GPOYSXHdEUEGWqJgHnpP8CcgAd49nTQ
         KcsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+2LlRiDpA/hN/BOQAfWB0lX7oWMHEMXFa0AH7K5JEuhp9qXzgQ5n2H1h27qklElRxHWw5fOZLk+fiUGclnAp4AhN2/sUDRzxwtMz47Xy7urPDoCvsS8qhxsu0T/MBZuDmjoXx5XbLV4AsqYRtI/xJiLUSGL4rCLWla4IDZhKXi+gw+ZurmS8UTKeRtSDWc0bS7keqTUyVAUY=
X-Gm-Message-State: AOJu0YwQYIm8qKQNktNhgrBgBW9ufEGZOw6h0qARPeGi/ueQjefwW0FO
	9qL3Ju/2XBNClLsfwhpTm1FwYAOCiZkzP3n7NFJqYMRHk/MkSCjD
X-Google-Smtp-Source: AGHT+IGrZgag9UeQefghQLPV+ku8otAJz6U28ozWysOWpOYWi3aSs0tMI8tAitrA/dkQ2iNnyOPaxQ==
X-Received: by 2002:a50:8e5b:0:b0:56b:cfef:b2de with SMTP id 27-20020a508e5b000000b0056bcfefb2demr6802703edx.26.1713789609790;
        Mon, 22 Apr 2024 05:40:09 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id q10-20020a056402248a00b0056fe7c5475bsm5505410eda.10.2024.04.22.05.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:40:09 -0700 (PDT)
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
	kvalo@kernel.org,
	Jeff Johnson <jjohnson@kernel.org>
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
Subject: [PATCH net-next v7 10/10] wifi: ath11k: allocate dummy net_device dynamically
Date: Mon, 22 Apr 2024 05:39:03 -0700
Message-ID: <20240422123921.854943-11-leitao@debian.org>
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

Un-embed the net_device from struct ath11k_ext_irq_grp by converting it
into a pointer. Then use the leverage alloc_netdev() to allocate the
net_device object at ath11k_ahb_config_ext_irq() for ahb, and
ath11k_pcic_ext_irq_config() for pcic.

The free of the device occurs at ath11k_ahb_free_ext_irq() for the ahb
case, and ath11k_pcic_free_ext_irq() for the pcic case.

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
Tested-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |  9 +++++++--
 drivers/net/wireless/ath/ath11k/core.h |  2 +-
 drivers/net/wireless/ath/ath11k/pcic.c | 21 +++++++++++++++++----
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 7c0a23517949..7f3f6479d553 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -442,6 +442,7 @@ static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
 			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
 
 		netif_napi_del(&irq_grp->napi);
+		free_netdev(irq_grp->napi_ndev);
 	}
 }
 
@@ -533,8 +534,12 @@ static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
 
 		irq_grp->ab = ab;
 		irq_grp->grp_id = i;
-		init_dummy_netdev(&irq_grp->napi_ndev);
-		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
+
+		irq_grp->napi_ndev = alloc_netdev_dummy(0);
+		if (!irq_grp->napi_ndev)
+			return -ENOMEM;
+
+		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
 			       ath11k_ahb_ext_grp_napi_poll);
 
 		for (j = 0; j < ATH11K_EXT_IRQ_NUM_MAX; j++) {
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b3fb74a226fb..590307ca7a11 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -174,7 +174,7 @@ struct ath11k_ext_irq_grp {
 	u64 timestamp;
 	bool napi_enabled;
 	struct napi_struct napi;
-	struct net_device napi_ndev;
+	struct net_device *napi_ndev;
 };
 
 enum ath11k_smbios_cc_type {
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index add4db4c50bc..79eb3f9c902f 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -316,6 +316,7 @@ static void ath11k_pcic_free_ext_irq(struct ath11k_base *ab)
 			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
 
 		netif_napi_del(&irq_grp->napi);
+		free_netdev(irq_grp->napi_ndev);
 	}
 }
 
@@ -558,7 +559,7 @@ ath11k_pcic_get_msi_irq(struct ath11k_base *ab, unsigned int vector)
 
 static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 {
-	int i, j, ret, num_vectors = 0;
+	int i, j, n, ret, num_vectors = 0;
 	u32 user_base_data = 0, base_vector = 0;
 	unsigned long irq_flags;
 
@@ -578,8 +579,11 @@ static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 
 		irq_grp->ab = ab;
 		irq_grp->grp_id = i;
-		init_dummy_netdev(&irq_grp->napi_ndev);
-		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
+		irq_grp->napi_ndev = alloc_netdev_dummy(0);
+		if (!irq_grp->napi_ndev)
+			return -ENOMEM;
+
+		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
 			       ath11k_pcic_ext_grp_napi_poll);
 
 		if (ab->hw_params.ring_mask->tx[i] ||
@@ -601,8 +605,13 @@ static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 			int vector = (i % num_vectors) + base_vector;
 			int irq = ath11k_pcic_get_msi_irq(ab, vector);
 
-			if (irq < 0)
+			if (irq < 0) {
+				for (n = 0; n <= i; n++) {
+					irq_grp = &ab->ext_irq_grp[n];
+					free_netdev(irq_grp->napi_ndev);
+				}
 				return irq;
+			}
 
 			ab->irq_num[irq_idx] = irq;
 
@@ -615,6 +624,10 @@ static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 			if (ret) {
 				ath11k_err(ab, "failed request irq %d: %d\n",
 					   vector, ret);
+				for (n = 0; n <= i; n++) {
+					irq_grp = &ab->ext_irq_grp[n];
+					free_netdev(irq_grp->napi_ndev);
+				}
 				return ret;
 			}
 		}
-- 
2.43.0


