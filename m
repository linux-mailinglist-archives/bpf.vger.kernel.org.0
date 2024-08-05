Return-Path: <bpf+bounces-36374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424789479A7
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 12:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726451C20F78
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7A11552E1;
	Mon,  5 Aug 2024 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UUHnMVGs"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81213AD11;
	Mon,  5 Aug 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853490; cv=none; b=VboreSnxxR0a3YmgiT2J7PeIt/ztY5xf7NqQDsZscXXv6taP//gM0mNrdO8vZuI9C+MfBJniE0Jwm0X6naRCpbdMfGlRxqnaOH+BMnMwJX0U+rbBkw3sHT2PFoDQBnoSG9K/MzznVfn/s2qk7vDP5Sb5s4g0tosBahBQjE3CieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853490; c=relaxed/simple;
	bh=1j3UquTTiZ0Jm0MLp5VgBlk+r7fjWoWx9OlP0CX3kdo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=XXB6hPAPXTuuKwOiFXjebCunIEiJMeS+UWSz2bxN+NXAPk1cAu1vnnwJWA7Oiu8A8sJzkNoc5Hl19SUtMsQqU9H5wbHHYzVi616tsGaCaoj1yXGthlFe8dcPEXpa9yAZq6/eUhWJT1lJbLm/dwnOov1izPFSovNdXIJml0lyuJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UUHnMVGs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b/PN9G+ZcRJ7ZfEQK3iIHMMF/sStQOExr+dbK08iFCc=; b=UUHnMVGsIeFSSRBbFuNzg/kmf+
	C8WbcgXi0+jWM9LLrrsAP9XDV53wEiaaEMhmccWJB0MCeXfULDpxwKjoHQqyFEgX+MeDcno9GZe3/
	J8bVMwVE+bqhgP+cstrfn/jMtMKaWjHOmadddoCKsVo9lEGnR+FP22BNo/xx0wOPmFx2fZoRhRwH9
	MmIV5xuJn0DMzhfDT0T+iaNrhllp1eng4ejIFzloEKjrutm22CtgpVFCWLiWyTSQdBtOHC1cHS+zV
	Z9Dy4Xx2fm/N+JVXN7IuxNjlDzjNRp2imU6P2lZ1/OfcgSYUxsHBQQS2O+4rG7GPp0JlDCC9i7xnS
	2kF8L8uw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38840 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sautI-0002b2-1b;
	Mon, 05 Aug 2024 11:24:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sautN-000tui-K7; Mon, 05 Aug 2024 11:24:41 +0100
In-Reply-To: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
References: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sneh Shah <quic_snehshah@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH RFC net-next v4 01/14] net: stmmac: qcom-ethqos: add
 ethqos_pcs_set_inband()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sautN-000tui-K7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 05 Aug 2024 11:24:41 +0100

Add ethqos_pcs_set_inband() to improve readability, and to allow future
changes when phylink PCS support is properly merged.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 901a3c1959fa..092b053dd8da 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -636,6 +636,11 @@ static void ethqos_set_serdes_speed(struct qcom_ethqos *ethqos, int speed)
 	}
 }
 
+static void ethqos_pcs_set_inband(struct stmmac_priv *priv, bool enable)
+{
+	stmmac_pcs_ctrl_ane(priv, priv->ioaddr, enable, 0, 0);
+}
+
 /* On interface toggle MAC registers gets reset.
  * Configure MAC block for SGMII on ethernet phy link up
  */
@@ -654,7 +659,7 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
 			      RGMII_IO_MACRO_CONFIG2);
 		ethqos_set_serdes_speed(ethqos, SPEED_2500);
-		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 0, 0, 0);
+		ethqos_pcs_set_inband(priv, false);
 		break;
 	case SPEED_1000:
 		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
@@ -662,12 +667,12 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
 			      RGMII_IO_MACRO_CONFIG2);
 		ethqos_set_serdes_speed(ethqos, SPEED_1000);
-		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
+		ethqos_pcs_set_inband(priv, true);
 		break;
 	case SPEED_100:
 		val |= ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE;
 		ethqos_set_serdes_speed(ethqos, SPEED_1000);
-		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
+		ethqos_pcs_set_inband(priv, true);
 		break;
 	case SPEED_10:
 		val |= ETHQOS_MAC_CTRL_PORT_SEL;
@@ -677,7 +682,7 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 					 SGMII_10M_RX_CLK_DVDR),
 			      RGMII_IO_MACRO_CONFIG);
 		ethqos_set_serdes_speed(ethqos, SPEED_1000);
-		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
+		ethqos_pcs_set_inband(priv, true);
 		break;
 	}
 
-- 
2.30.2


