Return-Path: <bpf+bounces-10560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BC67A9C4B
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1E1B22A81
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC42543A9B;
	Thu, 21 Sep 2023 18:10:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA619BB9;
	Thu, 21 Sep 2023 18:10:48 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5FDAFC09;
	Thu, 21 Sep 2023 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z/gjZ6NwdeuNXyz1iXfuNTb1780WrCUmfyXB8A74g+o=; b=mDecZEV1D+Pkf7/ecZob0+PcEI
	ydp21+7Xc4bfOIzUutQLHT7djnvEvIPGcR+X8uvGKkLB1LSGAGof30d4Iz/x2/PooFHIQd+SHN4V4
	l57farp1zDlyjbX6Wctfvy7L+7NuRZyy3wrFanEnZ3ZHWAxnhPRrvmdsYbdWtQTmAlkY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qjKro-0076AY-OI; Thu, 21 Sep 2023 16:41:20 +0200
Date: Thu, 21 Sep 2023 16:41:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
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
Message-ID: <0098eaf3-717a-4b50-b2a0-4b28b75b0735@lunn.ch>
References: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
 <5bd05ba2-fd88-4e5c-baed-9971ff917484@lunn.ch>
 <f9b21a9d-4ae2-1f91-b621-2e27f746f661@linux.intel.com>
 <37fe9352-ec84-47b8-bb49-9441987ca1b9@lunn.ch>
 <ZQxPQ9t8/TKcjlo8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQxPQ9t8/TKcjlo8@shell.armlinux.org.uk>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 03:12:19PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 21, 2023 at 03:21:00PM +0200, Andrew Lunn wrote:
> > > Hi Andrew,
> > > 
> > > After conducting a comprehensive study, it seems that implementing
> > > out-of-band for all link modes might not be feasible. I may have missed some
> > > key aspects during my analysis.
> > > 
> > > Would you be open to sharing a high-level idea of how we could potentially
> > > make this feasible? Your insights would be greatly appreciated.
> > 
> > stmmac_mac_link_up() gets passed interface, speed and duplex. That
> > tells you what the PHY has negotiated. Is there anything else you need
> > to know?
> 
> The problem is... the stmmac driver is utter bollocks - that information
> is *not* passed to the BSP. Instead, stmmac parse and store information
> such as the PHY interface mode at initialisation time. BSPs also re-
> parse and store e.g. the PHY interface mode at initialisation time.
> The driver ignores what it gets from phylink.
> 
> The driver is basically utter crap. That's an area I _had_ patches to
> clean up. I no longer do. stmmac is crap crap crap and will stay crap
> until they become more receptive to patches to fix it, even if the
> patches are not 100% to their liking but are in fact correct. Maybe
> if I ever decide to touch that driver in the future. Which I doubt
> given my recent experience.

Hi Russell

You pointed out the current proposal will break stuff. Do you see a
way forward for this patchset which does not first involve actually
cleaning up of this driver?

	Andrew

