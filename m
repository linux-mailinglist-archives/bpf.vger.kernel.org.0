Return-Path: <bpf+bounces-3152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D773A457
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98BB1C2117B
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F81F92E;
	Thu, 22 Jun 2023 15:07:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4611E526;
	Thu, 22 Jun 2023 15:07:55 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07391731;
	Thu, 22 Jun 2023 08:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8TPy4M/IgqT8baUzBBF1Ot9HCGGq63OZ2dRMS9U2qEs=; b=hr+LCn33yjNicFl80hCKAgwrYa
	93pDGSYl0/5FwW8xGbJb8Bzwztin6lA17hYELqtlfCGcjrfacnkQeDW1Lnhs4p6Yp9NR9LNSd0rby
	dueuqWRwCA/tDevppb+kFIH3iP5TedRM6dFD9YtjJX/8Ws4z3nGPQtt/kPtZ3e1NnRrVf76+qMMas
	62BEzt/rZsSylnXlBn0qSGDCDDv9NEhrrUizNFGFJRep32eCpFzYECJyP8A5b3s7RW+cRqYqeWdnp
	VDJTdWx8a7knGFAp2YasyuIJXY4IANgHDg2DsKL018BtVc64glMoFn4kujqH487kklA3eYmyQy7u1
	E9hIGVdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43762)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qCLtO-0004OW-29; Thu, 22 Jun 2023 16:06:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qCLtH-0000Wx-N7; Thu, 22 Jun 2023 16:06:31 +0100
Date: Thu, 22 Jun 2023 16:06:31 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <simon.horman@corigine.com>
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
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
	"Tan, Tee Min" <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next 3/6] net: phy: update in-band AN mode when
 changing interface by PHY driver
Message-ID: <ZJRjd0oqj95U0nHc@shell.armlinux.org.uk>
References: <20230622041905.629430-1-yong.liang.choong@linux.intel.com>
 <20230622041905.629430-4-yong.liang.choong@linux.intel.com>
 <ZJReJ2yxqKGQx1BU@corigine.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJReJ2yxqKGQx1BU@corigine.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 04:43:51PM +0200, Simon Horman wrote:
> On Thu, Jun 22, 2023 at 12:19:02PM +0800, Choong Yong Liang wrote:
> > From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>
> > 
> > Add cur_link_an_mode into phy_device struct for PHY drivers to
> > communicate the in-band AN mode setting with phylink framework.
> > 
> > As there is a mechanism in PHY drivers to switch the PHY interface
> > between SGMII and 2500BaseX according to link speed. In this case,
> > the in-band AN mode should be switching based on the PHY interface
> > as well, if the PHY interface has been changed/updated by PHY driver.
> > 
> > For e.g., disable in-band AN in 2500BaseX mode, or enable in-band AN
> > back for SGMII mode (10/100/1000Mbps).
> > 
> > Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
> > Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> 
> ...
> 
> > diff --git a/include/linux/phy.h b/include/linux/phy.h
> > index 11c1e91563d4..c685b526e307 100644
> > --- a/include/linux/phy.h
> > +++ b/include/linux/phy.h
> > @@ -756,6 +756,8 @@ struct phy_device {
> >  	/* MACsec management functions */
> >  	const struct macsec_ops *macsec_ops;
> >  #endif
> > +	/* For communicate the AN mode setting with phylink framework. */
> > +	u8 cur_link_an_mode;
> >  };
> 
> Hi Choong Yong Liang,
> 
> Please consider adding cur_link_an_mode to the kernel doc
> for struct phy_device - which is above the definition of struct phy_device.

This looks like it's grabbing something from phylink and stuffing it
into phylib.  However, I have no idea, because I don't seem to have
received the original patches. I'm guessing the reason is:

2023-06-22 05:21:24 1qCBoy-0003ji-G9 H=mga03.intel.com
[134.134.136.65]:57703 I=[78.32.30.218]:25
X=TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256
F=<yong.liang.choong@linux.intel.com> rejected after DATA: unqualified
address not permitted: failing address in "Cc:" header is: Tan

Which I suspect came from:

	Tan, Tee Min <tee.min.tan@linux.intel.com>

and someone doesn't realise that a "," in the display-name part of
an address *must* be quoted, otherwise "," is taken to be a separator
in the address list.

Consequently, it has now become:

	Tan@web.codeaurora.org, Tee Min <tee.min.tan@linux.intel.com>,

It should have been:

	"Tan, Tee Min" <tee.min.tan@linux.intel.com>

with the double-quotes.

Please do not review this series further, but instead, please can the
author repost it forthwith with correct conformant headers so that a
proper review can be undertaken by all?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

