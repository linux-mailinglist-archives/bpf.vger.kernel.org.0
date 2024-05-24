Return-Path: <bpf+bounces-30535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA688CEBA2
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 23:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B907C282096
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5E12CD82;
	Fri, 24 May 2024 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6EFTu0s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C186134;
	Fri, 24 May 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584608; cv=none; b=aAerPGxL5BxUzUnofBU3R6tQzJBI4cKcARcKnYj4ocSEXV8bQptC8dpc+Y3qERV97OakLJWQR9LvU75pTD1buLOK4HAC/Mh4+3RqOzBmDxAlRbe9NmK+He8fUjHL/yqw4gSjmtx+ScVI8Ddq4KXEAsMvWw7Uw4iPlEB/1sQX8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584608; c=relaxed/simple;
	bh=2+xqMRQGLIjTOS81Zq0gKeXzmKGYY1z4ywWc8kW4mAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxRWfWUak2/nM4wO1mKkBT08vJ7TA/Y9G13W/ppP05JnkVPEmJOCorcT0N4svizlOkrcvQgBOzkaMACYT6egpdyH+5IEWiibhwiNAw7wwVX49Tcd20ETdo0hq+rxYKT3zjjEnbbzTQuZE1zRRddJnu9JauerNjNj0PE83opJ7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6EFTu0s; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-529646df247so1279356e87.3;
        Fri, 24 May 2024 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716584605; x=1717189405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SsA/DX4FQd1mwIvYQLseyq3XbpKYYuZmRUlHTPnong=;
        b=m6EFTu0s2pP20C32HFzg94WJbzyue+Esc5/8jhEbh0LtHXxHmC5Z0X05ZeU+HR45yk
         SbouVuGHrFQIJAGL+icTAB+mdEWBW6ymdmO7jkt6MSpNxHJgJoGpywxNECgRjmsZCsPk
         /Rj8/ygw6kZtp181wTdHB/ZUxWj8JKs/cFxzFQ+YyAjPGvWO71CQuOcX2epoIBd9k/H6
         Zw9+tY5v2pB91H8Vjsi48U6A8SPPAPu+Hyq4R/CsTHciYGcWGoa/CJu5zqxBW6PDQOSJ
         7/lbrvRqRN8QSgxIdNVuysFyM+1Q09qwSgnNoNqEg/kjLC8a4zVvwCKnq5b0gQZ1/WG4
         dIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716584605; x=1717189405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SsA/DX4FQd1mwIvYQLseyq3XbpKYYuZmRUlHTPnong=;
        b=eTmMtP1RbxyOaScf3HX//DhNJNoyQwV9m7sj7/+nxzq7jrVvDkToEYrBHdnGgkcaIR
         bEwKgk/NJ0pvWqslmrHPIHwdIFI1ER/fhXONOGRabEx50nIJ3v4t8rG1eDMAkfK0YPjs
         NqZI954Ne7vT7E/5TU4vAViiGAzHOpoz5sxMbNSe9w1Cr/mLqZl17loZsEYSy5iT20S3
         q0MPpjoshvtY8loF765AW1Cx6E5Z2kMsuGMZRbprLVFNpF1Z3aNHfSgKpzIXXuKf5CML
         XtotB2fnziNAOCXVev343yYY0OU9sL8VjLgPzTwZ1QW9UI8JkiH3YAfV189QP9rql2mX
         qGBw==
X-Forwarded-Encrypted: i=1; AJvYcCUZwu7vK3yf/+xyYvURQKHDGb5O9vMrOyGtY58MeNpoxO5vfwYbJe5MKIvAF09+5BdXbFq6SKlX0/ryj3MxRW46ctu19gJ43208upi1pO2y1rPe65c8C+o5KqKmU/a57ivynoEinGsEqXMyeRf8ZX+s2n+pFC+IQ2M7
X-Gm-Message-State: AOJu0YxrFiPOCLeV0Qxjg3l/EhGsIwpwQTwqzHz0dEGxcQd/YYlaOg/E
	CeoJcRmG40hEVFVJF1uYNO6vHd1OXIvYkO6jq8CJPjms14D7WPRn
X-Google-Smtp-Source: AGHT+IG0PT+7TnzaGJ6HfS/LUBBacBaRk08p6C1KaUcsx5/G5OJ+ElDL8rqeNbSK5PYnnNXLPfqj6Q==
X-Received: by 2002:ac2:454c:0:b0:523:a924:3268 with SMTP id 2adb3069b0e04-52964109a01mr1779610e87.6.1716584604952;
        Fri, 24 May 2024 14:03:24 -0700 (PDT)
Received: from localhost ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066bcd6sm237510e87.164.2024.05.24.14.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 14:03:24 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 3/3] net: stmmac: Drop TBI/RTBI PCS flags
Date: Sat, 25 May 2024 00:02:59 +0300
Message-ID: <20240524210304.9164-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524210304.9164-1-fancer.lancer@gmail.com>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First of all the flags are never set by any of the driver parts. If nobody
have them set then the respective statements will always have the same
result. Thus the statements can be simplified or even dropped with no risk
to break things.

Secondly shall any of the TBI or RTBI flag is set the MDIO-bus
registration will be bypassed. Why? It really seems weird. It's perfectly
fine to have a TBI/RTBI-capable PHY configured over the MDIO bus
interface.

Based on the notes above the TBI/RTBI PCS flags can be freely dropped thus
simplifying the driver code.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  2 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 ++++++-------------
 2 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index b02b905bc892..40a930ea4ff3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -268,8 +268,6 @@ struct stmmac_safety_stats {
 /* PCS defines */
 #define STMMAC_PCS_RGMII	(1 << 0)
 #define STMMAC_PCS_SGMII	(1 << 1)
-#define STMMAC_PCS_TBI		(1 << 2)
-#define STMMAC_PCS_RTBI		(1 << 3)
 
 #define SF_DMA_MODE 1		/* DMA STORE-AND-FORWARD Operation Mode */
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6c4e90b1fea3..06f95dfdf09e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -471,13 +471,6 @@ bool stmmac_eee_init(struct stmmac_priv *priv)
 {
 	int eee_tw_timer = priv->eee_tw_timer;
 
-	/* Using PCS we cannot dial with the phy registers at this stage
-	 * so we do not support extra feature like EEE.
-	 */
-	if (priv->hw->pcs == STMMAC_PCS_TBI ||
-	    priv->hw->pcs == STMMAC_PCS_RTBI)
-		return false;
-
 	/* Check if MAC core supports the EEE feature. */
 	if (!priv->dma_cap.eee)
 		return false;
@@ -3945,9 +3938,7 @@ static int __stmmac_open(struct net_device *dev,
 	if (ret < 0)
 		return ret;
 
-	if (priv->hw->pcs != STMMAC_PCS_TBI &&
-	    priv->hw->pcs != STMMAC_PCS_RTBI &&
-	    (!priv->hw->xpcs ||
+	if ((!priv->hw->xpcs ||
 	     xpcs_get_an_mode(priv->hw->xpcs, mode) != DW_AN_C73) &&
 	    !priv->hw->lynx_pcs) {
 		ret = stmmac_init_phy(dev);
@@ -7724,16 +7715,12 @@ int stmmac_dvr_probe(struct device *device,
 	if (!pm_runtime_enabled(device))
 		pm_runtime_enable(device);
 
-	if (priv->hw->pcs != STMMAC_PCS_TBI &&
-	    priv->hw->pcs != STMMAC_PCS_RTBI) {
-		/* MDIO bus Registration */
-		ret = stmmac_mdio_register(ndev);
-		if (ret < 0) {
-			dev_err_probe(priv->device, ret,
-				      "%s: MDIO bus (id: %d) registration failed\n",
-				      __func__, priv->plat->bus_id);
-			goto error_mdio_register;
-		}
+	ret = stmmac_mdio_register(ndev);
+	if (ret < 0) {
+		dev_err_probe(priv->device, ret,
+			      "MDIO bus (id: %d) registration failed\n",
+			      priv->plat->bus_id);
+		goto error_mdio_register;
 	}
 
 	if (priv->plat->speed_mode_2500)
@@ -7776,9 +7763,7 @@ int stmmac_dvr_probe(struct device *device,
 	phylink_destroy(priv->phylink);
 error_xpcs_setup:
 error_phy_setup:
-	if (priv->hw->pcs != STMMAC_PCS_TBI &&
-	    priv->hw->pcs != STMMAC_PCS_RTBI)
-		stmmac_mdio_unregister(ndev);
+	stmmac_mdio_unregister(ndev);
 error_mdio_register:
 	stmmac_napi_del(ndev);
 error_hw_init:
@@ -7817,9 +7802,9 @@ void stmmac_dvr_remove(struct device *dev)
 	if (priv->plat->stmmac_rst)
 		reset_control_assert(priv->plat->stmmac_rst);
 	reset_control_assert(priv->plat->stmmac_ahb_rst);
-	if (priv->hw->pcs != STMMAC_PCS_TBI &&
-	    priv->hw->pcs != STMMAC_PCS_RTBI)
-		stmmac_mdio_unregister(ndev);
+
+	stmmac_mdio_unregister(ndev);
+
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
-- 
2.43.0


