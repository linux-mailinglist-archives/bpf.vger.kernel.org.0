Return-Path: <bpf+bounces-6975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F95876FCC6
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 11:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF35B281A47
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 09:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1F4A925;
	Fri,  4 Aug 2023 09:03:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E589449;
	Fri,  4 Aug 2023 09:03:30 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F9349FF;
	Fri,  4 Aug 2023 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qf2nlPt4v7aUf9lUAfeJGAwTZszOxnIID/uXD0x3Dg8=; b=FEX8LW7ZWgWlDBfNCVJqykaVs4
	ui3uSCSPrdKQjxRgAA1AVTCL4cr7N8EmaYUasFXu8Lub2Mlteg8GIQIFHN80Tj0Ir32LacOQ6kP68
	xUSS43q5IQngTYC67by/kpTAx4aU2oTLrfnSRgrJPlXOAlE8/uMjP4V9vUr3rUvcBUXvA+k2MMvrQ
	WHT1sLFIBqnuEoflX2BwPqgOri3m13R3K6Zrz7FUzsrmSQEwWuR2Y9OdkBBd0OqqmJ21k2QSA/rrZ
	RIBwOqjYl5vGpzoEEwA1vZCrfosAm19eFvOz7x8Ao0soXUBeFpYHU+8wqUx+Qjfiz6C/bnfY/OTG+
	RCpNqsmw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41564)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qRqhl-0008NN-24;
	Fri, 04 Aug 2023 10:02:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qRqhf-0003pC-52; Fri, 04 Aug 2023 10:02:35 +0100
Date: Fri, 4 Aug 2023 10:02:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
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
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next v2 3/5] net: phy: update in-band AN mode when
 changing interface by PHY driver
Message-ID: <ZMy+q84hVAbTQIk5@shell.armlinux.org.uk>
References: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
 <20230804084527.2082302-4-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804084527.2082302-4-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 04:45:25PM +0800, Choong Yong Liang wrote:
> From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>
> 
> Add cur_link_an_mode into phy_device struct for PHY drivers to
> communicate the in-band AN mode setting with phylink framework.
> 
> As there is a mechanism in PHY drivers to switch the PHY interface
> between SGMII and 2500BaseX according to link speed. In this case,
> the in-band AN mode should be switching based on the PHY interface
> as well, if the PHY interface has been changed/updated by PHY driver.
> 
> For e.g., disable in-band AN in 2500BaseX mode, or enable in-band AN
> back for SGMII mode (10/100/1000Mbps).
> 
> Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> ---
>  drivers/net/phy/marvell10g.c | 6 ++++++
>  drivers/net/phy/phylink.c    | 4 ++++
>  include/linux/phy.h          | 3 +++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index d4bb90d76881..a9df19278618 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -30,6 +30,7 @@
>  #include <linux/phy.h>
>  #include <linux/sfp.h>
>  #include <linux/netdevice.h>
> +#include <linux/phylink.h>
>  
>  #define MV_PHY_ALASKA_NBT_QUIRK_MASK	0xfffffffe
>  #define MV_PHY_ALASKA_NBT_QUIRK_REV	(MARVELL_PHY_ID_88X3310 | 0xa)
> @@ -946,6 +947,9 @@ static void mv3310_update_interface(struct phy_device *phydev)
>  	 * xaui / rxaui modes according to the speed.
>  	 * Florian suggests setting phydev->interface to communicate this to the
>  	 * MAC. Only do this if we are already in one of the above modes.
> +	 * In-band Auto-negotiation is not supported in 2500BASE-X.
> +	 * Setting phydev->cur_link_an_mode to communicate this to the
> +	 * phylink framework.
>  	 */
>  	switch (phydev->speed) {
>  	case SPEED_10000:
> @@ -956,11 +960,13 @@ static void mv3310_update_interface(struct phy_device *phydev)
>  		break;
>  	case SPEED_2500:
>  		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
> +		phydev->cur_link_an_mode = MLO_AN_PHY;
>  		break;
>  	case SPEED_1000:
>  	case SPEED_100:
>  	case SPEED_10:
>  		phydev->interface = PHY_INTERFACE_MODE_SGMII;
> +		phydev->cur_link_an_mode = MLO_AN_INBAND;
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 4f1c8bb199e9..f9cbb6d7e134 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1720,6 +1720,8 @@ static void phylink_phy_change(struct phy_device *phydev, bool up)
>  		pl->phy_state.pause |= MLO_PAUSE_RX;
>  	pl->phy_state.interface = phydev->interface;
>  	pl->phy_state.link = up;
> +	pl->cur_link_an_mode = phydev->cur_link_an_mode;
> +	pl->cfg_link_an_mode = phydev->cur_link_an_mode;
>  	mutex_unlock(&pl->state_mutex);
>  
>  	phylink_run_resolve(pl);
> @@ -1824,6 +1826,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
>  	if (pl->config->mac_managed_pm)
>  		phy->mac_managed_pm = true;
>  
> +	pl->phydev->cur_link_an_mode = pl->cur_link_an_mode;

I am really not happy with exposing phylink's AN mode into phylib.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

