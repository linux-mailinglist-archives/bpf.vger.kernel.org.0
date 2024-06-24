Return-Path: <bpf+bounces-32904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A88D914E7B
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5225D282D43
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDACA13E3F4;
	Mon, 24 Jun 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBqvaOJa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56C13DBB1;
	Mon, 24 Jun 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235714; cv=none; b=SWewAe9wq9OPaIradj9n2X4KBQwFnZk/Knw/IjmmeZdAcujjZIdUSsvdsVYAV9Y25fEFhsHDabgts8Frj/3X53Ti+XssU0LmRTnhSfGEHRfnB9xd9sop36CeJb37Y2GKDQbLr9bOqO1IjBRtdI5GGScDdjW7BUqyMeX1M/OFc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235714; c=relaxed/simple;
	bh=Knw25hLKGn36AJuU2/rDQCCe9C1d6rjfmd8w0Kwrf9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ij8DXfiKXToFuDTVY01tS2zaDXOgFK/145lGw/7AK1/YTvys5gv0yLNOrAjkhpr2ddB9DLUUWe/TI54fe4hJz+OSo7d9R3ntMbHkOrzAGfMsW4XO4QTsxNsemsLzL2VFSyZnR+DhZs7o/gxS4HD/gJkVySpIiYUFGm5T5mxa3qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBqvaOJa; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ce6a9fd5cso873385e87.3;
        Mon, 24 Jun 2024 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235711; x=1719840511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weoB2927OHeQLkItSsl1+92aESa5A0VbbSHXdYNaCxU=;
        b=ZBqvaOJaLpBvLvoDx4+DB36f8kUyelHn7dA4o5VH2fu5akGL1L2M/v7Re1FvqGErkF
         mL1F5jvl4QWMYgYQZr3xx0ZRORv058uKBOq6DLNq72BmAEgtnLh3mam/TQH4MYdrn+X3
         nulmPUr2Q5XfiZxrdEZf0ECMlwE3xQXJ0gHo7SChh+oc+TPkMBrZaqdMrVabH05uaE5B
         Nh0lcQ6pveVRIbGhyWMvnpQH6mpvqSUapGMgx+t4AHgwJFq/wlDj2WpJBhnyM/iqlWXp
         hR8Fd9WdK6ubpox/SmGHNNOsyTvxLLPFJxz3RaMsZKQqGjeC2DwiX9AG9VeGsRYer1tc
         JMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235711; x=1719840511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weoB2927OHeQLkItSsl1+92aESa5A0VbbSHXdYNaCxU=;
        b=fyvs2AGvpIUvOqgmcHFIFZhnu7kIV8W8EmYEZH/eCyDk25EKSqBq91i5L19Tq/bbPj
         zWss7SJLYKo7PvUhOM0Cgtj2jtwFrJ4wBdIPXof94xmMGKPkRjR9aqV9ZuOCDghoIvmt
         Hze1vnJlf84I53RfTDp9QlKhnVxeY8FXGvscPpxzuHfyZm0dxXAVtc+IGKpcK+b8v7OG
         R5ZXB9jLvB9pi5YMZAcEh4rBcnkbLx6POZSaVdhkT9IQNkyCVyAFiGkD68oYF5t6mk+z
         jd67Pi0xg4bbQav2mEvecgx5A831sZRK+/2ZG/d2+Ckx5juVdgzbOyX0KoQOClEDdRUs
         OZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt8CSfWT4qrkq+0q/n3qmvCqQnGgicP+g4OCNefaeSFP3D/8xqjy1FPUhwKUWdiPIBuiIsrdO7FAmFxx9hIwSrHbWW/XMy86jKPNXsByQvewpenDSVsNr0d4hir4JG5syLkVvZCbUZHWtFYYAwhfljYH3OTXZX7+Pg
X-Gm-Message-State: AOJu0Yz1/FD+xM4RPyEWifSDkAfday+9RUKDTLkuGQGIPank5SvnS0Ov
	K4EyCiijSgJsKG2PnuRMGAfVZbimGVWf911QrvHFkMx0nMldC20E
X-Google-Smtp-Source: AGHT+IFq8C6kBEtbmGEGitX4D9FUoJzf8LPqBHNhfBy21YGAueF442o3wAvxepev68ZGGljisU8J+g==
X-Received: by 2002:a05:6512:ba1:b0:52c:dd38:f3a3 with SMTP id 2adb3069b0e04-52ce185cf4amr3356821e87.46.1719235710522;
        Mon, 24 Jun 2024 06:28:30 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd6454a96sm968129e87.303.2024.06.24.06.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:28:30 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v2 09/17] net: stmmac: Introduce mac_device_info::priv pointer
Date: Mon, 24 Jun 2024 16:26:26 +0300
Message-ID: <20240624132802.14238-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is going to be introduced an PCS-specific CSR space pointer defined
in the stmmac_priv structure nearby the mmcaddr, estaddr and ptpaddr
fields. In order to have that pointer accessible from the PCS-specific
callback, let's introduce pointer to stmmac_priv defined in the
mac_device_info structure.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note the better approach would be to convert the mac_device_info instance
to being embedded into the stmmac_priv structure. It would have solved
many driver problems like non-unified HW abstraction interface, duplicated
fields (ioaddr and pcsr, etc) or too many non-runtime parameters passed to
the callbacks, etc. But the change also would have been much-much more
invasive than this one is. If despite of that you find the mac_device_info
embedding into stmmac_priv more appropriate (as I do), then I'll provide
the respective patch in place of this one.
---
 drivers/net/ethernet/stmicro/stmmac/common.h | 1 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index a66b836996d6..f7661268518f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -580,6 +580,7 @@ struct mii_regs {
 };
 
 struct mac_device_info {
+	struct stmmac_priv *priv;
 	const struct stmmac_ops *mac;
 	const struct stmmac_desc_ops *desc;
 	const struct stmmac_dma_ops *dma;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 29367105df54..84fd57b76fad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -351,6 +351,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		mac->tc = mac->tc ? : entry->tc;
 		mac->mmc = mac->mmc ? : entry->mmc;
 		mac->est = mac->est ? : entry->est;
+		mac->priv = priv;
 
 		priv->hw = mac;
 		priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
-- 
2.43.0


