Return-Path: <bpf+bounces-10569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF657A9CCD
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C0E3B250ED
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24E4CFB4;
	Thu, 21 Sep 2023 18:11:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4B4BDD4;
	Thu, 21 Sep 2023 18:11:21 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5078E98A72;
	Thu, 21 Sep 2023 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=etZ2gpA0uz+JRPag03uqb6cfh/kPa8Z3gAMOKitX9GI=; b=XJFeAWsJK6qNPSOEXR7+0kE+V4
	4M/gOJKBPlGa+X30hfCd+WanZJzjvHIg3FOF+0PiDMyYKdq2GmP3ET7jaqP+coWsJhapZAKkw8XBp
	YXoEu+OSuRKJy8kMvQA+1uK6bnykQqT3wiDi16tAorZtuVizYtC0+q1DOQqAlh1wAjC8THQ5j1tBb
	n/IVlVmgzyC3E/JOKzyKNxwUAzemhr/7mg2Mnn9ljY2801G2xkTtLiqJpDZMyMiXD40F4Rjw8bpZ1
	iLzGICk+q44J1b1OKypm+kQ/qteOXGLyEtKJFXgJpGWWDjwMCPUvm9uR4EZYSUOWmQK0fR8ZT1pgq
	aMWFFDyg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46552)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qjJuR-0004g0-21;
	Thu, 21 Sep 2023 14:39:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qjJuO-0003aT-Te; Thu, 21 Sep 2023 14:39:56 +0100
Date: Thu, 21 Sep 2023 14:39:56 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Wong Vee Khee <veekhee@apple.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Revanth Kumar Uppala <ruppala@nvidia.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrey Konovalov <andrey.konovalov@linaro.org>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next v2 0/5] TSN auto negotiation between 1G and 2.5G
Message-ID: <ZQxHrPS5C13SfTfA@shell.armlinux.org.uk>
References: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
 <5bd05ba2-fd88-4e5c-baed-9971ff917484@lunn.ch>
 <f9b21a9d-4ae2-1f91-b621-2e27f746f661@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9b21a9d-4ae2-1f91-b621-2e27f746f661@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 08:25:05PM +0800, Choong Yong Liang wrote:
> 
> 
> On 4/8/2023 8:04 pm, Andrew Lunn wrote:
> > On Fri, Aug 04, 2023 at 04:45:22PM +0800, Choong Yong Liang wrote:
> > > Intel platforms’ integrated Gigabit Ethernet controllers support
> > > 2.5Gbps mode statically using BIOS programming. In the current
> > > implementation, the BIOS menu provides an option to select between
> > > 10/100/1000Mbps and 2.5Gbps modes. Based on the selection, the BIOS
> > > programs the Phase Lock Loop (PLL) registers. The BIOS also read the
> > > TSN lane registers from Flexible I/O Adapter (FIA) block and provided
> > > 10/100/1000Mbps/2.5Gbps information to the stmmac driver. But
> > > auto-negotiation between 10/100/1000Mbps and 2.5Gbps is not allowed.
> > > The new proposal is to support auto-negotiation between 10/100/1000Mbps
> > > and 2.5Gbps . Auto-negotiation between 10, 100, 1000Mbps will use
> > > in-band auto negotiation. Auto-negotiation between 10/100/1000Mbps and
> > > 2.5Gbps will work as the following proposed flow, the stmmac driver reads
> > > the PHY link status registers then identifies the negotiated speed.
> > > Based on the speed stmmac driver will identify TSN lane registers from
> > > FIA then send IPC command to the Power Management controller (PMC)
> > > through PMC driver/API. PMC will act as a proxy to programs the
> > > PLL registers.
> > 
> > Have you considered using out of band for all link modes? You might
> > end up with a cleaner architecture, and not need any phylink/phylib
> > hacks.
> > 
> > 	Andrew
> Hi Andrew,
> 
> After conducting a comprehensive study, it seems that implementing
> out-of-band for all link modes might not be feasible. I may have missed some
> key aspects during my analysis.

You need to provide details of why you think it's not feasible, because
you're making those reading your message have to guess.

We _do_ have cases where this is already supported. The DM7052 SFP
module for example has a BCM84881 PHY on board that has no in-band
support, so always has to use out-of-band. This module supports 10G,
5G, 2.5G, 1G, 100M and 10M speeds. It switches its interface between
10G, 2500base-X and SGMII mode. It's been supported in Linux for a
while with MAC/PCS that implement phylink _correctly_.

I wouldn't call stmmac a proper phylink implementation, especially
when it comes to switching between different interfaces.

My attempt at starting to clean up the stmmac code was thwarted by
niggly review comments (over whether %u or %d should be used to print
a _signed integer_ that stmmac stupidly implicitly casts to an unsigned
integer. That lead me to decide that stmmac was beyond being cleaned
up, so I junked the large patch set of improvements that I had - along
with multiple issues that I had found in the driver.

Someone else needs to sort stmmac out, and I suspect that may be a
pre-requisit for your changes so that stmmac operates _correctly_ with
phylink.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

