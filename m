Return-Path: <bpf+bounces-30533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6398CEB9C
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 23:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CDD4B216A0
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 21:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D3F84D03;
	Fri, 24 May 2024 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPTWeVLa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD323C47C;
	Fri, 24 May 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584604; cv=none; b=TNNp1UoVAIwH3ZsFnPhnMqc6ILIlp35N9OFqXKt4cqDlx6OiHxTPzip5a4lK9iGgknvFW0DB2+GUHuUed+pfgRAZSMjXCs8HGPRprflJeYzpODjk8zjrkPzrTusmjWKRC1xuKQCSDaHEIIBkQti3EDzG+iZU02RQoQ5Yii++1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584604; c=relaxed/simple;
	bh=UvvZgf/c7R2Kuz7t2PBciYgKKn+4xkq6ebZaQLyY6oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwK4Y/HSLfTpbgtVBLT++5yPBjI79oHuwHrOtZPRouPwrocWTBZK3kD4WKIo1qZKlpvRL35cFJZVFhmjsHnkOxbF+WOADzcKeJyQeCQNHjb3hhN97ke6VdXLSnT4Uc1bTta/bCRKES6/p3HHxRGyK/ogSfDFbhW53XW53MK3tYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPTWeVLa; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so69083151fa.2;
        Fri, 24 May 2024 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716584601; x=1717189401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfTzYX+duGMsU7h/VpsgnG4SbDyXgyQ9P7UXQAwHfVg=;
        b=aPTWeVLaspchA5msb3QDFifp1gd5kW4gMuvVd/xGBKQKEUunIZ69dlIl/i9jHOc6ZZ
         6N8J2aRFHxd7KU2aUP/qI5N5RiGesaqb3VOZ5BCo/yRwYUFEerM53Tac6UD+H9c7Bq4K
         iXKb7ALmMkC9jfgqPXeCfXfzKfKppT/u0/ahP0WrML2TTmvHZBD0ivQwrAB/uTBiAjPQ
         JSqR0Ta1nN3AgRGQ3nCRGqcZxP9qe6+dMDDw+eHYIEJchhB1PqhF2504oN8e1OXy8irO
         QXiKlMt6Q1u9wHYNkGZuIzei4e9mvrDXoJAbkbg/2zcLsan51nLuM3DTwUOsxq5tXggQ
         0c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716584601; x=1717189401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfTzYX+duGMsU7h/VpsgnG4SbDyXgyQ9P7UXQAwHfVg=;
        b=iK84pa3xC+jDKksszQrbFNFSAMCJtFuIHYKojTBFUUigllOlBoRkIOdMzMpnJUz4ks
         Ie5qiEpjQsdjVtvLXfHu+9S//1WrTr+LgQESMD6jjZBnmnmZPviXa+YnJBhEjjG9Z0+c
         4eOA/va4OrldJZn71qWztt0+n/Ku7Zmd9m+jiG8vQ8QY1aZ3okSuYKx6EUjkkId1034K
         rBA0RQpcHugNJ/an2HrV9PgHYGl/RE46au65RbWOWXWO5L/9OVKvJRKq68ZGwqkK4Mw1
         +d5J9K5pGktECHcFKuRqWvRwDznQumpQtE2EeN3EDIBcFEXBrhM+XR38tSMhztTAt8na
         wywQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNavcBdq31TyeqmOCiVPBgtuSdPDjT6GUKiSJuJFNexQxj2ivxohGsyehNTGeD8UI3+2Nu56d7lmenPa3TyfZ4NtSYtjaAElfza5F6xrC5cE8A1X9gAMe6iEzEvrkRkph89wkr4vly5BE/7bj9h0ZM9YCPv6vNuyvk
X-Gm-Message-State: AOJu0YyFkB7qfj0PYO3h2u+7ubDIkA4xrY1tbmww1vyp3iaQpho+jXwA
	iM/UI7tZvgjO0aX9reoLKfV1V04tQKq0jQxiK0iXq+1R5mjdwziL
X-Google-Smtp-Source: AGHT+IFsvg+3eW+uFt+8zbMHGOvvmM7wbkkNlpRI+IgIK/fpNCjG+0mt4y0mWAeB+ZHjQFEWsw7fgQ==
X-Received: by 2002:a19:381d:0:b0:523:889a:ebd with SMTP id 2adb3069b0e04-52964ea947bmr1972965e87.24.1716584601070;
        Fri, 24 May 2024 14:03:21 -0700 (PDT)
Received: from localhost ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970e1ef56sm236078e87.228.2024.05.24.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 14:03:20 -0700 (PDT)
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
Subject: [PATCH RFC net-next 1/3] net: stmmac: Prevent RGSMIIIS IRQs flood
Date: Sat, 25 May 2024 00:02:57 +0300
Message-ID: <20240524210304.9164-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without reading the GMAC_RGSMIIIS/MAC_PHYIF_Control_Status the IRQ line
won't be de-asserted causing interrupt handler executed over and over. As
a quick-fix let's just dummy-read the CSR for now.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index adb872d5719f..2ae8467c588e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -304,6 +304,8 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
 	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
 
 	if (intr_status & PCS_RGSMIIIS_IRQ) {
+		/* TODO Dummy-read to clear the IRQ status */
+		readl(ioaddr + GMAC_RGSMIIIS);
 		phylink_pcs_change(&hw->mac_pcs, false);
 		x->irq_rgmii_n++;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index a892d361a4e4..cd2ca1d0222c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -896,6 +896,8 @@ static int dwmac4_irq_status(struct mac_device_info *hw,
 
 	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
 	if (intr_status & PCS_RGSMIIIS_IRQ) {
+		/* TODO Dummy-read to clear the IRQ status */
+		readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
 		phylink_pcs_change(&hw->mac_pcs, false);
 		x->irq_rgmii_n++;
 	}
-- 
2.43.0


