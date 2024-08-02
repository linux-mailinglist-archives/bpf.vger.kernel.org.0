Return-Path: <bpf+bounces-36326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1200946607
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 01:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5DCB21BD4
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACCF13AA3F;
	Fri,  2 Aug 2024 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vIRi5f6u"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593631ABEAC;
	Fri,  2 Aug 2024 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722639597; cv=none; b=Tv14voL0xVLbXQ1obls6OLVIEawFXTUZXNgJGaxrG4JTLQd3Hp2z/Q+hvi1rrgC1K9NcoBXc3fUx1sVgVOjs6JVg9E90p+WW5ok6EAuemKi0anN+uAfD3x581wPSStclQF454R3RiIw6LJtcGNxXEsbFUBKmQwb7QLEehcyUBi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722639597; c=relaxed/simple;
	bh=5wWuergmD1DQ2jlE61lyoX1orcqo7cfOnbvgDX9v+ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkPEOItcJgBhNGAXs/2+X/rtS7K2xD7fpUU+xHxVu8fzakpnJK5F7fkIrua5fHu3a2lslkpG4m1bcfzBSS/Oe2iu8lrq33s2MaICiGxl+w+TIXzCyUVPaHTPol5lx9kIfu6VJM3uZP+s/IxhTCeRDwaq1qdntKFiynBKgHdkD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vIRi5f6u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2ftwNXrX2dXrmGqkEavOurs8H08rzbSsBllQvHtYN8g=; b=vIRi5f6uKAKKULYcDhEb5UInie
	wLV84cuk1HZzx3x3Ki+PYtPU97tQ5ICrCQUZ1KLD8vF4W+1mk1vLpaVJQXJVxyxO7B1nIt/6zZaOf
	2m2md9BZ8E+6Rz4rrVsB5suqs+Ahy0aHlf9rfD5FcDjFHQJpWkLpgKt7vTjtcCVSiuM0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sa1F8-003tiM-KT; Sat, 03 Aug 2024 00:59:26 +0200
Date: Sat, 3 Aug 2024 00:59:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: jitendra.vegiraju@broadcom.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	linux@armlinux.org.uk, horms@kernel.org,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Integrate dwxgmac4 into
 stmmac hwif handling
Message-ID: <1e6e6eaa-3fd3-4820-bc1d-b1c722610e2f@lunn.ch>
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

> +	user_ver = stmmac_get_user_version(priv, GMAC4_VERSION);
> +	if (priv->synopsys_id == DWXGMAC_CORE_4_00 &&
> +	    user_ver == DWXGMAC_USER_VER_X22)
> +		mac->dma = &dwxgmac400_dma_ops;

I know nothing about this hardware....

Does priv->synopsys_id == DWXGMAC_CORE_4_0 not imply
dwxgmac400_dma_ops?

Could a user synthesise DWXGMAC_CORE_4_00 without using
dwxgmac400_dma_ops? Could dwxgmac500_dma_ops or dwxgmac100_dma_ops be
used?

	Andrew

