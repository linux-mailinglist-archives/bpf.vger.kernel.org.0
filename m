Return-Path: <bpf+bounces-33364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B591C1CE
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 16:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B1C2864C9
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15D51C231A;
	Fri, 28 Jun 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MGYf7Kdn"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5511BE25F;
	Fri, 28 Jun 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586476; cv=none; b=M4QmqiHzsqUUaxvloCKFTeK5eB1e9P9Q9xg23uI/fSpEPW5YzuYkv0HywSRYdxQXiCi0M0nbyNS9yspjV8cfkLV7YfuBuuVFK3azQ6jPyf1gGsARZ6nMTVMaG65GDEDx1WHpT+hmOh/Qog4mUnxXfr9rXBavwTtEDYVL0VmhJYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586476; c=relaxed/simple;
	bh=Ou4xM+KfwaWQtRXzFZntff3Dpxcze4HWoGlzHDofmiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gm8vBPE45VtVrOv9tiNHKTM3BuXjcZeL6ygs8Jp+mmizOJMzo7MGpSYnM7rYt4LnEuoMGSMnM029CSXqG5Hv0dBnvassCHQIxGMVNCShqIZtPuOWA5iZIHHyv2HEpqfdpEuBcq6Aw0GERWuPvAX9KuYMv70kk+rzxDP+5SzcAmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MGYf7Kdn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=81FpBswvqTN/+g4RZ2JQLI94RMcUtnvBgT5CRymvy00=; b=MGYf7KdnGuXY1WWsPiwRchgkQh
	ckcHUlfg+yk3eL6vt4Rsvd5uI2k0bL8Gqkt4+p+vMHVp00sZytVvFCe/KhlzOuFFz+S3gA8u4PI0V
	Eis+uEXgk0ESe02/721q9JveAWDX8ObVdhiaYOybrkobYbcLZ5wOdPYMILvu86VguhJexRV9y7cgE
	JcraytzqsYeMIg3qNTsJrXZh/myRdCnjN7oomiwToTd7E9OvA89qlR18GbJJFKEn5S7S67riVx8h/
	Im3BJ63YZhjxDDDNe6niBS5eMb5L4LPud3nqarCn6r18jtYaZ4eKaM4pZ5vk0zNF9xewkVqaxwo11
	uESa2Vuw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35642)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sNCzM-0006mN-02;
	Fri, 28 Jun 2024 15:54:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sNCzN-0006ah-A6; Fri, 28 Jun 2024 15:54:13 +0100
Date: Fri, 28 Jun 2024 15:54:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>, Vinod Koul <vkoul@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 10/17] net: stmmac: Introduce internal
 PCS offset-based CSR access
Message-ID: <Zn7OlQ4aoO2vZTrj@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <20240624132802.14238-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624132802.14238-2-fancer.lancer@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 24, 2024 at 04:26:27PM +0300, Serge Semin wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 80eb72bc6311..d0bcebe87ee8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -633,7 +633,7 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>  			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
>  			      RGMII_IO_MACRO_CONFIG2);
>  		ethqos_set_serdes_speed(ethqos, SPEED_2500);
> -		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 0, 0, 0);
> +		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 0, 0, 0);
>  		break;
>  	case SPEED_1000:
>  		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
> @@ -641,12 +641,12 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>  			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
>  			      RGMII_IO_MACRO_CONFIG2);
>  		ethqos_set_serdes_speed(ethqos, SPEED_1000);
> -		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
> +		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 1, 0, 0);
>  		break;
>  	case SPEED_100:
>  		val |= ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE;
>  		ethqos_set_serdes_speed(ethqos, SPEED_1000);
> -		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
> +		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 1, 0, 0);
>  		break;
>  	case SPEED_10:
>  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
> @@ -656,7 +656,7 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>  					 SGMII_10M_RX_CLK_DVDR),
>  			      RGMII_IO_MACRO_CONFIG);
>  		ethqos_set_serdes_speed(ethqos, SPEED_1000);
> -		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
> +		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 1, 0, 0);
>  		break;
>  	}
>  

I think a better preparatory patch (given what you do in future patches)
would be to change all of these to:

	ethqos_pcs_set_inband(priv, {false | true});

which would be:

static void ethqos_pcs_set_inband(struct stmmac_priv *priv, bool enable)
{
	stmmac_pcs_ctrl_ane(priv, priv->ioaddr, enable, 0, 0);
}

which then means this patch becomes a single line, and your subsequent
patch just has to replace stmmac_pcs_ctrl_ane() with its open-coded
equivalent.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 84fd57b76fad..3666893acb69 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -6,6 +6,7 @@
>  
>  #include "common.h"
>  #include "stmmac.h"
> +#include "stmmac_pcs.h"
>  #include "stmmac_ptp.h"
>  #include "stmmac_est.h"
>  
> @@ -116,6 +117,7 @@ static const struct stmmac_hwif_entry {
>  	const void *tc;
>  	const void *mmc;
>  	const void *est;
> +	const void *pcs;

I'm not a fan of void pointers. common.h includes linux/phylink.h, which
will define struct phylink_pcs_ops, so there is no reason not to declare
this as:

	const struct phylink_pcs_ops *pcs;

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

