Return-Path: <bpf+bounces-29675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64FA8C4A00
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 01:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124171F22166
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C581185635;
	Mon, 13 May 2024 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NyaprXNz"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B882488;
	Mon, 13 May 2024 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642516; cv=none; b=cKClsFA1XXln8FdeePM7ZOr2LVnoley2JndhcMJmOHDWaJ/khhOFcjHvqByYy9fEow6C9hXW13zolH72uK1q4EOrur7wpH58nlvN1v0iIa41I3/61VVxNmICC6frRtLuiGTMe6qvR69IrJRlzjWbozG6wdDdB/jbaCfSvtwtMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642516; c=relaxed/simple;
	bh=5Hu3Ue1JCG8w+Uoj6MasMKr4x/laIiBHPQdLygw00SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfoKvKNpLKkOslCNjG4yTABYmONhz+odTO+l6faDNGhfG71zaiUQ9B3FZpuamQUCjzYMDwmqThEUnPSAqzagywKQX5rO1bJRi1/AMcsTVf1Eq31l9d+F4VR2yaC0uPMXjVSiMsgXEtjSuRTajdokmwH9Lk6O2YE7RI3wH81tlpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NyaprXNz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FjwP5rNIPk7wislr0WzdyfpykGMwHjroQxITaXdC+UA=; b=NyaprXNzRSUuVsKQHvEPtW1l3X
	pt7i21YkM0E2XUC2EbXrGOrr5aip+1VIOzK6DihejQNUocOqg4kpl7fcpSaJkvjF/s1JZ67AQ1yZu
	yhgMYfv70QUA2ddS2tt/3Er356HDMimN5895M/gL/gZmwPShcEc/dZK35eX+0uFoHW4o2JIXVPO0X
	LJhDypc8pDcgAT+8um0Yy5nrgNd586K2vETUAyffOn3FB01W1PhrQ38EDTLXuLtjCKCF6xPbkKK0g
	3K7u172/QK27E/dfLlH1BtPLU8nBor/vLo+MX6TrRjH5EDyqvXmtcg3lWJyh5/Jk6BtKA9ZUFs+t4
	mHYcaoOg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32964)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s6ezH-0002OH-2r;
	Tue, 14 May 2024 00:21:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s6ezG-0006Vz-8j; Tue, 14 May 2024 00:21:42 +0100
Date: Tue, 14 May 2024 00:21:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC 0/6] net: stmmac: convert stmmac "pcs" to phylink
Message-ID: <ZkKghpox1r6ZqtyB@shell.armlinux.org.uk>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <y2iz5uhcj5xh3dtpg3rnxap4qgvmgavzkf6qd7c2vqysmll3yx@drhs7upgpojz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y2iz5uhcj5xh3dtpg3rnxap4qgvmgavzkf6qd7c2vqysmll3yx@drhs7upgpojz>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 14, 2024 at 02:04:00AM +0300, Serge Semin wrote:
> Hi Russell
> 
> I'll give your series a try later on this week on my DW GMAC with the
> RGMII interface (alas I don't have an SGMII capable device, so can't
> help with the AN-part testing).

Thanks!

> Today I've made a brief glance on it
> and already noted a few places which may require a fix to make the
> change working for RGMII (at least the RGSMIIIS IRQ must be got back
> enabled). After making the patch set working for my device in what
> form would you prefer me to submit the fixes? As incremental patches
> in-reply to this thread?

I think it depends on where the issues are.

If they are addressing issues that are also present in the existing
code, then it would make sense to get those patched as the driver
stands today, because backporting them to stable would be easier.

If they are for "new" issues, given that this patch series is more
or less experimental, I would prefer to roll them into these
patches. As mentioned, when it comes to submitting these patches,
the way I've split them wouldn't make much sense, but it does
make sense for where I am with it. Hence, I'll want to resplit
the series into something better for submission than it currently
is. If you want to reply to this thread, that is fine.

There's still a few netif_carrier_off()/netif_carrier_on()s left
in the driver even after this patch series, but I think they're in
more obscure paths, but I will also want to address those as well.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

