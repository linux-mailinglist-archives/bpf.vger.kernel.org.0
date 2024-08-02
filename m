Return-Path: <bpf+bounces-36263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF659459D0
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 10:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18269B20E95
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3B81C2316;
	Fri,  2 Aug 2024 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kn7Ndqi2"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FB13FF6;
	Fri,  2 Aug 2024 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587014; cv=none; b=JXghGY6dhp25/AkQ1JAWG2Cg4/11P8fHQcFU17RY5pbvtBsH4plnOscM0vIgumhM+JIknw5xRw/nEsFnQtPPrFXPq2tEs0GxK/qyqS0n429KJw2z6kp+UVJ4oyyvsOICPlviXfyMWMx3AuPcGJTvtuZBGiH3p0zd4JKqqCP6mhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587014; c=relaxed/simple;
	bh=/JFOpX6c03oiUEVf2eeXWR8mNod1ZH7BtsDAtQdND2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br2xvLCI9DdcV7cKOlERlzl+ikvnKdswt2jGli33L9v67ucCqUpEGIVqbSw0buaasd1dLsEXKFEHKM4DzMbEefgmbqyLwPGjsrI+IrgfjRGdJjlYM5YmXZpEqJ19xE38nCmIrI+pp1ZbYXSDbHU9r8oWpyy5uDLZdsmKW6aBDC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Kn7Ndqi2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ocBM1K9/X1NEjC6z+jnrLicjhSmeXGMLZSZ4AGPCtSE=; b=Kn7Ndqi2p+R9/chxP+VspXbcKz
	kNYNF6hLTV+l9ivKcO/BUvd4J3xsc71S+I593gOisUtBjpX3Ic6Amc/uKzcBtPhVo1h5Mh03pmWyQ
	e92SkQTpbg6rfzt5IxpSUlMSdEjlDhdWv7iq95u9viAPNOp5P564naSw0ZdUYm7uJVDke1yspqmH1
	mPSO84IFk3JMj+/X0691VjU7yj5bLzN0ACcqculKR1ai+XWDDI0usFRw32w2dGt8yBAlKl4dwa2S1
	/q3bJnTOsGQnmf1/rYUq+udpwYrm3URd/mkpYBNzVSSP0gE1eUhL6Jt8O9gP6yliG2yZPNvfDH0L+
	yeIOSTfg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42218)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZnZK-0004zr-2x;
	Fri, 02 Aug 2024 09:23:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZnZO-0007tN-9D; Fri, 02 Aug 2024 09:23:26 +0100
Date: Fri, 2 Aug 2024 09:23:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: jitendra.vegiraju@broadcom.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	andrew@lunn.ch, horms@kernel.org, florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Integrate dwxgmac4 into
 stmmac hwif handling
Message-ID: <ZqyXfonFv1GNlbvK@shell.armlinux.org.uk>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 01, 2024 at 08:18:21PM -0700, jitendra.vegiraju@broadcom.com wrote:
> +static u32 stmmac_get_user_version(struct stmmac_priv *priv, u32 id_reg)
> +{
> +	u32 reg = readl(priv->ioaddr + id_reg);
> +
> +	if (!reg) {
> +		dev_info(priv->device, "User Version not available\n");
> +		return 0x0;
> +	}
> +
> +	return (reg & GENMASK(23, 16)) >> 16;

	return FIELD_GET(GENMASK(23, 16), reg);

For even more bonus points, use a #define for the field mask.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

