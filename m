Return-Path: <bpf+bounces-10571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6537A9C8F
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A589828338C
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA3D4BDDC;
	Thu, 21 Sep 2023 18:11:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63574BDB6;
	Thu, 21 Sep 2023 18:11:23 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB15A0F5C;
	Thu, 21 Sep 2023 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xOUC0XEpooWY3ocUiPMl1wGP/+abFgU7mgV5A8cPiqQ=; b=ODXexeYs4hjxZmP4XDsimLt1ld
	jIwXZ/SwJiN6T30MyTq0ozuGsVwAlUmQ8pwWTywvlnYMbx1IMxWubKbuPfadGgQSSIwH2gOsziYuk
	h8UzpIEg6Fx2rEs96em6OXLOt3bTLyZudculxw+sa7cI5L0MrWuJXCDldONkubQeiF8MPWRXXILOw
	ms9C4a92EZbyFjqDktlKpykZteXPXIeDVYXx8ZFIhFlbLXVU/GkWNJz8PE7sH1u/G7q7kSpl4yMa4
	M60CIhQ4+qem2OfbubuoCyOBvPAuNp7QyPRs02HeqgsV3QwKKWx1h9aZn1hxlMHCxIebWKmwVabxV
	WckeWJ0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54502)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qjJP5-0004aS-1s;
	Thu, 21 Sep 2023 14:07:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qjJOR-0003YC-Nd; Thu, 21 Sep 2023 14:06:55 +0100
Date: Thu, 21 Sep 2023 14:06:55 +0100
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
	David E Box <david.e.box@intel.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next v3 2/5] net: pcs: xpcs: combine C37 SGMII AN and
 2500BASEX for Intel mGbE controller
Message-ID: <ZQw/7/3jOJf7BOPt@shell.armlinux.org.uk>
References: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
 <20230921121946.3025771-3-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921121946.3025771-3-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 08:19:43PM +0800, Choong Yong Liang wrote:
> From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>
> 
> This commit introduces xpcs_sgmii_2500basex_features[] that combine
> xpcs_sgmii_features[] and xpcs_2500basex_features[] for Intel mGbE
> controller that desire to interchange the speed mode of
> 10/100/1000/2500Mbps at runtime.
> 
> Also, we introduce xpcs_config_aneg_c37_sgmii_2500basex() function

Clause 37... SGMII? 2500base-X? Technically, clause 37 doesn't cover
2500base-X.

> which is called by the xpcs_do_config() with the new AN mode:
> DW_SGMII_2500BASEX, and this new function will proceed next-level
> calling to perform C37 SGMII AN/2500BASEX configuration based on
> the PHY interface updated by PHY driver.
> 
> Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> ---
>  drivers/net/pcs/pcs-xpcs.c   | 72 ++++++++++++++++++++++++++++++------
>  include/linux/pcs/pcs-xpcs.h |  1 +
>  2 files changed, 62 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 4dbc21f604f2..60d90191677d 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -104,6 +104,21 @@ static const int xpcs_2500basex_features[] = {
>  	__ETHTOOL_LINK_MODE_MASK_NBITS,
>  };
>  
> +static const int xpcs_sgmii_2500basex_features[] = {
> +	ETHTOOL_LINK_MODE_Pause_BIT,
> +	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> +	ETHTOOL_LINK_MODE_Autoneg_BIT,
> +	ETHTOOL_LINK_MODE_10baseT_Half_BIT,
> +	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> +	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
> +	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,

The connected PHY could be one that supports 1000baseX as well.

> +	ETHTOOL_LINK_MODE_2500baseX_Full_BIT,
> +	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +	__ETHTOOL_LINK_MODE_MASK_NBITS,
> +};
> +
>  static const phy_interface_t xpcs_usxgmii_interfaces[] = {
>  	PHY_INTERFACE_MODE_USXGMII,
>  };
> @@ -133,6 +148,12 @@ static const phy_interface_t xpcs_2500basex_interfaces[] = {
>  	PHY_INTERFACE_MODE_MAX,
>  };
>  
> +static const phy_interface_t xpcs_sgmii_2500basex_interfaces[] = {
> +	PHY_INTERFACE_MODE_SGMII,
> +	PHY_INTERFACE_MODE_2500BASEX,
> +	PHY_INTERFACE_MODE_MAX,
> +};
> +
>  enum {
>  	DW_XPCS_USXGMII,
>  	DW_XPCS_10GKR,
> @@ -141,6 +162,7 @@ enum {
>  	DW_XPCS_SGMII,
>  	DW_XPCS_1000BASEX,
>  	DW_XPCS_2500BASEX,
> +	DW_XPCS_SGMII_2500BASEX,
>  	DW_XPCS_INTERFACE_MAX,
>  };
>  
> @@ -290,6 +312,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
>  	case DW_AN_C37_SGMII:
>  	case DW_2500BASEX:
>  	case DW_AN_C37_1000BASEX:
> +	case DW_SGMII_2500BASEX:
>  		dev = MDIO_MMD_VEND2;
>  		break;
>  	default:
> @@ -748,6 +771,8 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
>  	if (xpcs->dev_flag == DW_DEV_TXGBE)
>  		ret |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
>  
> +	/* Disable 2.5G GMII for SGMII C37 mode */
> +	ret &= ~DW_VR_MII_DIG_CTRL1_2G5_EN;

Do you know that this is correct for every user of this function?

>  	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1, ret);
>  	if (ret < 0)
>  		return ret;
> @@ -848,6 +873,26 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
>  	return xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL, ret);
>  }
>  
> +static int xpcs_config_aneg_c37_sgmii_2500basex(struct dw_xpcs *xpcs,
> +						unsigned int neg_mode,
> +						phy_interface_t interface)
> +{
> +	int ret = -EOPNOTSUPP;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		ret = xpcs_config_aneg_c37_sgmii(xpcs, neg_mode);
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		ret = xpcs_config_2500basex(xpcs);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
>  		   const unsigned long *advertising, unsigned int neg_mode)
>  {
> @@ -890,6 +935,12 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
>  		if (ret)
>  			return ret;
>  		break;
> +	case DW_SGMII_2500BASEX:
> +		ret = xpcs_config_aneg_c37_sgmii_2500basex(xpcs, neg_mode,
> +							   interface);
> +		if (ret)
> +			return ret;
> +		break;
>  	default:
>  		return -1;
>  	}
> @@ -1114,6 +1165,11 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
>  		}
>  		break;
>  	case DW_AN_C37_SGMII:
> +	case DW_SGMII_2500BASEX:
> +		/* 2500BASEX is not supported for in-band AN mode. */
> +		if (state->interface == PHY_INTERFACE_MODE_2500BASEX)
> +			break;
> +
>  		ret = xpcs_get_state_c37_sgmii(xpcs, state);
>  		if (ret) {
>  			pr_err("xpcs_get_state_c37_sgmii returned %pe\n",
> @@ -1266,23 +1322,17 @@ static const struct xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
>  		.num_interfaces = ARRAY_SIZE(xpcs_10gbaser_interfaces),
>  		.an_mode = DW_10GBASER,
>  	},
> -	[DW_XPCS_SGMII] = {
> -		.supported = xpcs_sgmii_features,
> -		.interface = xpcs_sgmii_interfaces,
> -		.num_interfaces = ARRAY_SIZE(xpcs_sgmii_interfaces),
> -		.an_mode = DW_AN_C37_SGMII,
> -	},

Doesn't this break SGMII-only support (those using DW_XPCS_SGMII) ?

>  	[DW_XPCS_1000BASEX] = {
>  		.supported = xpcs_1000basex_features,
>  		.interface = xpcs_1000basex_interfaces,
>  		.num_interfaces = ARRAY_SIZE(xpcs_1000basex_interfaces),
>  		.an_mode = DW_AN_C37_1000BASEX,
>  	},
> -	[DW_XPCS_2500BASEX] = {
> -		.supported = xpcs_2500basex_features,
> -		.interface = xpcs_2500basex_interfaces,
> -		.num_interfaces = ARRAY_SIZE(xpcs_2500basex_interfaces),
> -		.an_mode = DW_2500BASEX,

Doesn't this break 2500base-X only support (those using
DW_XPCS_2500BASEX)?

> +	[DW_XPCS_SGMII_2500BASEX] = {
> +		.supported = xpcs_sgmii_2500basex_features,
> +		.interface = xpcs_sgmii_2500basex_interfaces,
> +		.num_interfaces = ARRAY_SIZE(xpcs_sgmii_2500basex_features),
> +		.an_mode = DW_SGMII_2500BASEX,
>  	},
>  };
>  
> diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
> index da3a6c30f6d2..f075d2fca54a 100644
> --- a/include/linux/pcs/pcs-xpcs.h
> +++ b/include/linux/pcs/pcs-xpcs.h
> @@ -19,6 +19,7 @@
>  #define DW_2500BASEX			3
>  #define DW_AN_C37_1000BASEX		4
>  #define DW_10GBASER			5
> +#define DW_SGMII_2500BASEX		6
>  
>  /* device vendor OUI */
>  #define DW_OUI_WX			0x0018fc80
> -- 
> 2.25.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

