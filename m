Return-Path: <bpf+bounces-30534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E678CEB9F
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 23:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05AB1F2199B
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 21:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2276D8627C;
	Fri, 24 May 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXhmjXxy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42581736;
	Fri, 24 May 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584606; cv=none; b=mEy5DONTIfhWlyMGVCHXEMYGGtJHQu7oI6PlmZwnpF8MjyFCoNLE18LM+GgOn+NjZW/M7b6sp6fnmbfhiPT8rscMbXyBZ5Hsyvuwzd7i6rgzyN/ImWjoU+I9mBB5DtBYZZGu13xFFbswuA5wNzgHYcDj5F0cyi5EjG3Gu8CaaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584606; c=relaxed/simple;
	bh=BmmOFiaM3c9lqEmGJRdRDqzqAs68U0g+JY7m5ZCB0HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAz2dxcQsMF196CgyZGE07r/rCKoyPYCNPWwl6kHqDYuBVH/bMJ2sHE8L6w3vUkEPE+E0HovbxcZ+v/cN1Ta+0vrs7QPStgrRDlngPDNX8JF704/53cYjOjreVo9mT6WZIHtOGo77fzZE8ETKIeCKGtt0dQuNsPOG596dJxhbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXhmjXxy; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5295e488248so1484667e87.2;
        Fri, 24 May 2024 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716584603; x=1717189403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxT1J6TEpAgvO5DZP/UxXlPe1jaIeEw8wHuXNfn0DlA=;
        b=dXhmjXxyoBUhdE63vQgwIYKM8YNEwu9gPnu6Sib2Q/5hsNrjvmgBem3FBBin5Eaygn
         zqME2CWJ2Yx6VbOUra5B/GjnTDI5Mj0ji8h9RlpchEU45K+aq0GiLhhYDkJecNgsjUmm
         +r0Sskkrb2+4aaUAD6vA/rm6P+FCipJCtxXBTWzHvB8AqOOK/1fXygzvVREz7PK6uMeX
         2Ym6d+TIN4OQnggTnxhrhraz8JvwI1HNCrfPS/noU1vmyJVPZJ/4aDBKM6Yq/92T04An
         GtSSUeoUNrmX6O+sUOfRAlryJcjzpBUY1iBuBA//W4ep9lUDhO+Ym83116gRh1GzDOp0
         UoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716584603; x=1717189403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxT1J6TEpAgvO5DZP/UxXlPe1jaIeEw8wHuXNfn0DlA=;
        b=OAXlloDOKT3A3epvviI1JvtHlxuoLRCfilhQ/5l49aXxtceKMVX1GGN4PPDvV9cIVW
         w/qlehkxt+EKbxO6zFBC0nFDopDnRJ6UpP2/jJmFT0Q/YSa2UzQ6C+Liwc8d8NSv4IfS
         hXL4svs2OmH/eoaGWZnn5muQBYg47Ji1x+vF7sHeWNJmlUriTS03oNtfD3KhfJWdkR50
         Wdk1OcGwnHJfSWoWfGm8y4DfiVN4BnomCkh7mXf3VoNqBdj0wJ7Wv4TJKv8z/CZVNt7/
         7QwvIiZKZwdssVbcujnh/zdxVp/I1UPN+UDq2E+Mr2R65PqREE9cMJ7hZVml+c77ZQqp
         UtdA==
X-Forwarded-Encrypted: i=1; AJvYcCUsLTL3Sg/nItrGOqL01hD82cvzCWB5+3DbZRM+RJwnknyNbUMYIprzuJVlU1LDf3c1tdncopeJg0TPZFjBd1hGFHOv2xrewhLQeZtILl3u/6bjm+D4jAf7a986sUwOXGH49hZ3s+q88uj6T9uh3yuZKASBAKK1wO/H
X-Gm-Message-State: AOJu0YyrxmahBN1PGGqZVbuL98s2hYiock+idcEQo88yp9UwGcpqmHP8
	qN1gpeEYDh+pq63PsuwR4eFIDlrj9KjCxcHxYSrawyP2vV0ChAiT
X-Google-Smtp-Source: AGHT+IHiFHbJSkm3a+YnVrAqiEBUxqU0zl1zz3q7VRqSYd34a0x8WLy+5xT5KHOoe8SsJpqmPTpH8g==
X-Received: by 2002:a05:6512:3b86:b0:51e:2282:63cf with SMTP id 2adb3069b0e04-529666db5f9mr2844583e87.45.1716584602922;
        Fri, 24 May 2024 14:03:22 -0700 (PDT)
Received: from localhost ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296ee4aa90sm241351e87.92.2024.05.24.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 14:03:22 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Byungho An <bh74.an@samsung.com>,
	Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 2/3] net: stmmac: Activate Inband/PCS flag based on the selected iface
Date: Sat, 25 May 2024 00:02:58 +0300
Message-ID: <20240524210304.9164-2-fancer.lancer@gmail.com>
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

The HWFEATURE.PCSSEL flag is set if the PCS block has been synthesized
into the DW GMAC controller. It's always done if the controller supports
at least one of the SGMII, TBI, RTBI PHY interfaces. If none of these
interfaces support was activated during the IP-core synthesize the PCS
block won't be activated either and the HWFEATURE.PCSSEL flag won't be
set. Based on that the RGMII in-band status detection procedure
implemented in the driver hasn't been working for the devices with the
RGMII interface support and with none of the SGMII, TBI, RTBI PHY
interfaces available in the device.

Fix that just by dropping the dma_cap.pcs flag check from the conditional
statement responsible for the In-band/PCS functionality activation. If the
RGMII interface is supported by the device then the in-band link status
detection will be also supported automatically (it's always embedded into
the RGMII RTL code). If the SGMII interface is supported by the device
then the PCS block will be supported too (it's unconditionally synthesized
into the controller). The later is also correct for the TBI/RTBI PHY
interfaces.

Note while at it drop the netdev_dbg() calls since at the moment of the
stmmac_check_pcs_mode() invocation the network device isn't registered. So
the debug prints will be for the unknown/NULL device.

Fixes: e58bb43f5e43 ("stmmac: initial support to manage pcs modes")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 90c065920af2..6c4e90b1fea3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1146,18 +1146,10 @@ static void stmmac_check_pcs_mode(struct stmmac_priv *priv)
 {
 	int interface = priv->plat->mac_interface;
 
-	if (priv->dma_cap.pcs) {
-		if ((interface == PHY_INTERFACE_MODE_RGMII) ||
-		    (interface == PHY_INTERFACE_MODE_RGMII_ID) ||
-		    (interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
-		    (interface == PHY_INTERFACE_MODE_RGMII_TXID)) {
-			netdev_dbg(priv->dev, "PCS RGMII support enabled\n");
-			priv->hw->pcs = STMMAC_PCS_RGMII;
-		} else if (interface == PHY_INTERFACE_MODE_SGMII) {
-			netdev_dbg(priv->dev, "PCS SGMII support enabled\n");
-			priv->hw->pcs = STMMAC_PCS_SGMII;
-		}
-	}
+	if (phy_interface_mode_is_rgmii(interface))
+		priv->hw.pcs = STMMAC_PCS_RGMII;
+	else if (interface == PHY_INTERFACE_MODE_SGMII)
+		priv->hw.pcs = STMMAC_PCS_SGMII;
 }
 
 /**
-- 
2.43.0


