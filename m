Return-Path: <bpf+bounces-30709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F9F8D186C
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67C91C23F6E
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51BD16C697;
	Tue, 28 May 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sqNnxhk5"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C5C16A384;
	Tue, 28 May 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891727; cv=none; b=IE4dy0ne9HRpwpVfAQdE8cxNBYMX6hHKAn6rP/gWLQgDNvtwnLQCxzOJFQKmTkvFWVDSI9bUO4hVomxcDuvLaPzfk2SeZKJ5xsUSZAAhEiLo9HI9O1CcfzSd9SWXHFhZID8pImLWsuOzAcs+tHtr0dS6105vzhZz9gLXWuOwMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891727; c=relaxed/simple;
	bh=sRey+u5pmGwHMY7PBUYlpXaOnGtRIBoM3ykxb58m6ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR2UsxsvqdOaWbpWwzgWaN0U0h7wC2IVc6TLIOjiGgu37t8tl4hHz4g/UXb7vORbGOScUsMXKB4Y/jO+UBdHr8Uc29agkB31RL3IrlLPTXAhGvJvGdg7GLldPZmKcBmXssrxP2LFBe3zR/PEGUYNHnNOh58y79ugvAxRLOWRErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sqNnxhk5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xKVMZlVJjByQlTcWIHcb8ICc2Adw+z+dOdz53NVlpuo=; b=sqNnxhk5J6XXakffML7EBhL0FA
	8kDy73eLiLSXZ0NN/9oIEJaRO1aECUF1NNEnpClyaHQO1C2xxRyDBWk/ySafx5iIaduFQM8cXLiZO
	Jr3adIdqJ0gPPUkb00oHQDK8GqXAt/APcH7lE8sn6KEtAnQnPdCd0nQd7r2wY3t/OxUB+AcC7EP72
	Ys+VvkuY7agbOJXYLjA9KeG1hiuymXHK6yYl0Vd2It8wPBdbBjv8ZPaSUe0Lej6Gq4jiQjpH1p1Lm
	uHp5M3Sr52QMTDb2TDJi/OjZf+M6Ur1nS90+LiP+ScF4WL+DjmeNmzsN/OfJI2Ah/yUyJ1ykb072h
	Vfl7bTGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41282)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBtxd-0004by-2l;
	Tue, 28 May 2024 11:21:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBtxc-0003BF-0p; Tue, 28 May 2024 11:21:40 +0100
Date: Tue, 28 May 2024 11:21:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Byungho An <bh74.an@samsung.com>,
	Giuseppe CAVALLARO <peppe.cavallaro@st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/3] net: stmmac: Activate Inband/PCS flag
 based on the selected iface
Message-ID: <ZlWwMzMZrwb5fscN@shell.armlinux.org.uk>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-2-fancer.lancer@gmail.com>
 <ZlNoLHoHjt3BsFde@shell.armlinux.org.uk>
 <fvjrnunu4lriegq3z7xkefsts6ybn2vkxmve6xzi73krjgvcj6@bhf4b4xx3x72>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fvjrnunu4lriegq3z7xkefsts6ybn2vkxmve6xzi73krjgvcj6@bhf4b4xx3x72>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 27, 2024 at 12:57:02AM +0300, Serge Semin wrote:
> On Sun, May 26, 2024 at 05:49:48PM +0100, Russell King (Oracle) wrote:
> > On Sat, May 25, 2024 at 12:02:58AM +0300, Serge Semin wrote:
> > > The HWFEATURE.PCSSEL flag is set if the PCS block has been synthesized
> > > into the DW GMAC controller. It's always done if the controller supports
> > > at least one of the SGMII, TBI, RTBI PHY interfaces. If none of these
> > > interfaces support was activated during the IP-core synthesize the PCS
> > > block won't be activated either and the HWFEATURE.PCSSEL flag won't be
> > > set. Based on that the RGMII in-band status detection procedure
> > > implemented in the driver hasn't been working for the devices with the
> > > RGMII interface support and with none of the SGMII, TBI, RTBI PHY
> > > interfaces available in the device.
> > > 
> > > Fix that just by dropping the dma_cap.pcs flag check from the conditional
> > > statement responsible for the In-band/PCS functionality activation. If the
> > > RGMII interface is supported by the device then the in-band link status
> > > detection will be also supported automatically (it's always embedded into
> > > the RGMII RTL code). If the SGMII interface is supported by the device
> > > then the PCS block will be supported too (it's unconditionally synthesized
> > > into the controller). The later is also correct for the TBI/RTBI PHY
> > > interfaces.
> > > 
> > > Note while at it drop the netdev_dbg() calls since at the moment of the
> > > stmmac_check_pcs_mode() invocation the network device isn't registered. So
> > > the debug prints will be for the unknown/NULL device.
> > 
> 
> > Thanks. As this is a fix, shouldn't it be submitted for the net tree as
> > it seems to be fixing a bug in the driver as it stands today?
> 
> From one point of view it could be submitted for the net tree indeed,
> but on the second thought are you sure we should be doing that seeing
> it will activate the RGMII-inband detection and the code with the
> netif-carrier toggling behind the phylink back? Who knows what new
> regressions the activated PCS-code can cause?..

If it's not a fix that is suitable without the remainder of the patch
set, this should be stated in the commit description and it shouldn't
have a Fixes: tag.

The reason is because it wouldn't be stable kernel material without the
other patches - if stable picks it up without the other patches then
it could end up being applied without the other patches resulting in
the situation you mention above.

Shall I remove the Fixes: tag?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

