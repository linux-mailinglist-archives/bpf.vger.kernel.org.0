Return-Path: <bpf+bounces-36262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E4E9459C8
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 10:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16056281B75
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300D1C2312;
	Fri,  2 Aug 2024 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a7YhIvz/"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350191494DE;
	Fri,  2 Aug 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586916; cv=none; b=UlHgWv0P1bUDUfoTxTw9gV4euhykwzIqJfpBGYHpQ5C1LR12Jx53Nl5j54IvHu2oANyfvP4fLwJ8FI+7Svz20Y5HCD3y4jKjQezdPHjHw1aY0gF/vC6hwXknE9TuPXpnVwmXO9QJGSqSFd32ZsuftVR2whJawnYhuP8CIgjIcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586916; c=relaxed/simple;
	bh=pyRcYd8CSBUZF25XqKrMhSHeXZ2ZYTUFYzbtn1uX0TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGbbzseIsbJ1IUA1oBeBlzjmq1QJBSScQGX1xWYXUDUrObxD4ALt4Ms1Pe7zWjW0bg8mnRCsltbiXpMOmXCGCBTNRCpZcwU9SogSpfBOP6L3rAsIueoHK1SPYnuZgOhgHCzFJcVsBRUSa+j3Q69kRN3B2MMt6lQtvxCGB82Qxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a7YhIvz/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cVA3KSjGKzz0infH/ajrMtNFEZmegRydGsvJox3T7UY=; b=a7YhIvz/hBRIRY22EVQeDn5Gsw
	wXaTKPqm/II4v6VQuG8sPopnBLFqEofucrqiXtYwz//X7XZs7KkOUA7yuZ+mWGLdHmkE7Tm5aVG4I
	f052rARoqoQCcDLgIhxCsEQ+mx801ewgCrN10FjJwbw7KeJqrgywOo0PErsxzpHkXgl/wxuKsIH6j
	yKcMAZHSzBqgsL39kbtHHTUE2jsS06fqkOMeHtHm8k7L7n2Ie6rWiqn2kgF/wMmKBXCV65SUd3OF7
	KfQjbpbWTK84mO3z5U/cLuHyF+CHYpYPTztqKFxCZfgTx972S8MxFIF2AfuED0e2QdvDsyR9Lmoj2
	aehXoxxw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38364)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZnXe-0004yQ-2X;
	Fri, 02 Aug 2024 09:21:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZnXf-0007tF-JT; Fri, 02 Aug 2024 09:21:39 +0100
Date: Fri, 2 Aug 2024 09:21:39 +0100
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
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: Add basic dwxgmac4 support
 to stmmac core
Message-ID: <ZqyXE0XJkn+Of6rR@shell.armlinux.org.uk>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-2-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802031822.1862030-2-jitendra.vegiraju@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 01, 2024 at 08:18:20PM -0700, jitendra.vegiraju@broadcom.com wrote:
> +static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
> +{
> +	u32 reg_val = 0;
> +	u32 val = 0;

val is unnecessary.

> +
> +	reg_val |= mode << XGMAC4_MSEL_SHIFT & XGMAC4_MODE_SELECT;

Consider using:

	reg_val |= FIELD_PREP(XGMAC4_MODE_SELECT, mode);

and similarly everywhere else you use a shift and mask. With this, you
can remove _all_ _SHIFT definitions in your header file.

> +	reg_val |= channel << XGMAC4_AOFF_SHIFT & XGMAC4_ADDR_OFFSET;
> +	reg_val |= XGMAC4_CMD_TYPE | XGMAC4_OB;
> +	writel(reg_val, ioaddr + XGMAC4_DMA_CH_IND_CONTROL);
> +	val = readl(ioaddr + XGMAC4_DMA_CH_IND_DATA);
> +	return val;

	return readl(ioaddr + XGMAC4_DMA_CH_IND_DATA);

...

> +void dwxgmac4_dma_init(void __iomem *ioaddr,
> +		       struct stmmac_dma_cfg *dma_cfg, int atds)
> +{
> +	u32 value;
> +	u32 i;
> +
> +	value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +
> +	if (dma_cfg->aal)
> +		value |= XGMAC_AAL;
> +
> +	if (dma_cfg->eame)
> +		value |= XGMAC_EAME;

What if dma_cfg doesn't have these bits set? Is it possible they will be
set in the register?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

