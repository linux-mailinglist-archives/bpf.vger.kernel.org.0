Return-Path: <bpf+bounces-33790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4E9267B8
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 20:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63141F26266
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 18:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71065188CD3;
	Wed,  3 Jul 2024 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDMEV+KM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449461850B1;
	Wed,  3 Jul 2024 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029831; cv=none; b=BqGs4AjxkP5E+CUeAKgPBiJk0hWKQoD2fcEwPx6/ytmEIEWzs0VXtt6ChKydgWZPfJlTO32gG4w2s9iSMCCHxHQDSncDMxpm9W6+x0DkmY3gOX72AFOQdgBm6ZklOOZIx9tiWZg3Z294ZinHE9+Actj9QFmnK0OyYnmtIeVwrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029831; c=relaxed/simple;
	bh=aI7mscXHDDOq7bMhI+STUiUsd/kM4cUrVQ2H+mEH92o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSj13Q+UFeWF+tWuJ3AAjjybJ7PYEATTJHCChf4knKpp4NhtZyzw79ag/dBkS3NKTW+2x8zL16XVPqdUEUDoTkX0/MCLwCPYmY6MBU/a64bwDCdcakYTiZbu8aE0eYKdzlyVtz8oVZNDEFyOeFkZT5qrssZj3Tve1e07C3nqIgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDMEV+KM; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e94eaf5efso1604838e87.2;
        Wed, 03 Jul 2024 11:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720029827; x=1720634627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5pUANthD2RfMuvZXmpYUOmYzj9A++tZ8LVG4JgOmllc=;
        b=TDMEV+KMy6ITcazY8D+vM2cgYk5N1jokFdqNjMuVOtEFIL5pL4f5it0Z9xO6RsRLIc
         +hkL6jNvtl0dvvNaTGM0TNAc7Q8piD4pn7eHpXU9tuOOm5ds/kkWckQ4Q+tWyLUe1Rhm
         YhnIr37DQK9zwn0wQBKmJGBvrus5+xs1nkSYoUaG6VcdJuv8cS1tNmbw8RDMUj4iy0fh
         0AudwAPpguxPqCX5NjzjE80cVzbgFDQuS2kJCoMkMvdx57gzJxcu5Cd5rtwjvA1AeLrx
         sbjpvwIPUsdNFnrbfEISGp1Pot2JnUhJPU7dAI5DG+ckDD6vQomllz3/A0pgkYaTlEoE
         9gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029827; x=1720634627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pUANthD2RfMuvZXmpYUOmYzj9A++tZ8LVG4JgOmllc=;
        b=YfKiD/3eBo6bdtin8xl2HJIXRC5BelNatyXwrOReW6EFqUjxL5eZCjkaVHUwH01NvY
         V7CrIs7+Ii+TPw//9Uwc22JP1Iv7sHuCJdsv8kGtlyayqhWj1shPKydf5EsbthsESzVq
         e56j1sQ5D00IdTjOLOd38FkTHyy63qZrrzD7WAqOmi2yxWI5Z8PFLzoiKx6T1rD0+8Di
         InzHKhb56RBrg0OWi+mQGG8hBeEsFAOXNmz7jeNZpOxf9FvuAZCNtQppVd3XMK4Zrbea
         y4zZJpdFpQLpQIt4Ob3sw0M8MVXGxvMB2kBw/vQjIDlnoIgjUAjzIdnZUfrnD1sNs27p
         ZC5w==
X-Forwarded-Encrypted: i=1; AJvYcCVsTq/X304wlRgQO9clF3yc1/zPxVB4ZWUwrh2eXP7tGHkbXCoIt6+dSQuras1XdS1IUxmI1a+BfvLzdP9i9CkC6SY2S8LqaHfDQvlYcmYP4DPTZd96s9DMp5xvL9y0K2lTS4VhHhZDq/S/Zo8A32XSkgDuk3HrlippYRFK2bYqkE7m1q+FVY3/hk+XX3dJybAQN8QYK8s0tQ==
X-Gm-Message-State: AOJu0YyDTDRnXXSUSZKOnpx2Mb91X3qR5H8qmlbN4cbiBg2d39pL+W4u
	gA77Rp8rQnAWXb/j7Wjv9MINFHnrqTQQ3Mx26oKU3qi6KwOsSgvOYhFsow==
X-Google-Smtp-Source: AGHT+IEzqdXoqCQ87ptf6kZX7djqsIHyutpvUl0WyZiNqihSTsmFkE+7S47HCg6mq1RDtsjlWdH3Kw==
X-Received: by 2002:a05:6512:2315:b0:52c:db75:9640 with SMTP id 2adb3069b0e04-52e82701721mr8301874e87.48.1720029825101;
        Wed, 03 Jul 2024 11:03:45 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e9b59bdcfsm143863e87.293.2024.07.03.11.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:03:44 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:03:41 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Halaney <ahalaney@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 10/17] net: stmmac: Introduce internal
 PCS offset-based CSR access
Message-ID: <57xxremctndaz7rfmuyw3rjuz3hi7tntbaghvqda5uxngku7pl@rsekr4b5gbzr>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <20240624132802.14238-2-fancer.lancer@gmail.com>
 <Zn7OlQ4aoO2vZTrj@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn7OlQ4aoO2vZTrj@shell.armlinux.org.uk>

On Fri, Jun 28, 2024 at 03:54:13PM +0100, Russell King (Oracle) wrote:
> On Mon, Jun 24, 2024 at 04:26:27PM +0300, Serge Semin wrote:
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > index 80eb72bc6311..d0bcebe87ee8 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > @@ -633,7 +633,7 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
> >  			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> >  			      RGMII_IO_MACRO_CONFIG2);
> >  		ethqos_set_serdes_speed(ethqos, SPEED_2500);
> > -		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 0, 0, 0);
> > +		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 0, 0, 0);
> >  		break;
> >  	case SPEED_1000:
> >  		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
> > @@ -641,12 +641,12 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
> >  			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> >  			      RGMII_IO_MACRO_CONFIG2);
> >  		ethqos_set_serdes_speed(ethqos, SPEED_1000);
> > -		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
> > +		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 1, 0, 0);
> >  		break;
> >  	case SPEED_100:
> >  		val |= ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE;
> >  		ethqos_set_serdes_speed(ethqos, SPEED_1000);
> > -		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
> > +		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 1, 0, 0);
> >  		break;
> >  	case SPEED_10:
> >  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
> > @@ -656,7 +656,7 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
> >  					 SGMII_10M_RX_CLK_DVDR),
> >  			      RGMII_IO_MACRO_CONFIG);
> >  		ethqos_set_serdes_speed(ethqos, SPEED_1000);
> > -		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
> > +		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 1, 0, 0);
> >  		break;
> >  	}
> >  
> 

> I think a better preparatory patch (given what you do in future patches)
> would be to change all of these to:
> 
> 	ethqos_pcs_set_inband(priv, {false | true});
> 
> which would be:
> 
> static void ethqos_pcs_set_inband(struct stmmac_priv *priv, bool enable)
> {
> 	stmmac_pcs_ctrl_ane(priv, priv->ioaddr, enable, 0, 0);
> }
> 
> which then means this patch becomes a single line, and your subsequent
> patch just has to replace stmmac_pcs_ctrl_ane() with its open-coded
> equivalent.

Why not. We can introduce one more preparation patch as you suggest.

> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > index 84fd57b76fad..3666893acb69 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > @@ -6,6 +6,7 @@
> >  
> >  #include "common.h"
> >  #include "stmmac.h"
> > +#include "stmmac_pcs.h"
> >  #include "stmmac_ptp.h"
> >  #include "stmmac_est.h"
> >  
> > @@ -116,6 +117,7 @@ static const struct stmmac_hwif_entry {
> >  	const void *tc;
> >  	const void *mmc;
> >  	const void *est;
> > +	const void *pcs;
> 

> I'm not a fan of void pointers. common.h includes linux/phylink.h, which
> will define struct phylink_pcs_ops, so there is no reason not to declare
> this as:
> 
> 	const struct phylink_pcs_ops *pcs;

So am I. But in this case we have all the ops fields defined as voids.
So I just followed the local convention.

Anyway, I failed to find out the reason of using void pointers here.
So locally, in one of my cleanup patchesets, I've got them converted
to the typed pointers. I can submit that patch as another preparation
patch to this series. Then we can use the pointer to phylink_pcs_ops
with no doubts. What do you think?

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

