Return-Path: <bpf+bounces-10863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3517AEACC
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 12:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CB2FF281B56
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7970826296;
	Tue, 26 Sep 2023 10:52:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6C1A5AF;
	Tue, 26 Sep 2023 10:52:08 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C544101;
	Tue, 26 Sep 2023 03:52:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so140701011fa.3;
        Tue, 26 Sep 2023 03:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695725524; x=1696330324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qddpFrAbHgrI9I4qDNwU5xvTVB3IzX2OJ7vgquZmuOo=;
        b=G5DX5P9tUuot3RfDnk0qHZISEPCusSa3V0VhwUFFIhzx7+RN528sS8zZHHJip3cSXd
         pRi/s12ewGNBV0Zi2T/EzGCjJKYdQQFd2Und8ynmmyzqzRn6Hq4ob+VUyK7AOLxEszCj
         7TtDjhPMdi37fW5VszTFRrgbvEO30Sh4xbtbmObbUE4KyyC88oicoFs2vooj8B/cl1JU
         FD3ZB5+6ub6eKDBhU6+f+zRA7rrVjnzLaFWT/ZXfFn1JGWwOs3+EpyZ/98xRLSk6n8Rb
         LIJ/TAAmcd8V2ZaQjcOH01YC4j3T+b+mb7gJcr2pH7fTpiNDGQBKErBFTpgN9Qe7K/JS
         Bgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725524; x=1696330324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qddpFrAbHgrI9I4qDNwU5xvTVB3IzX2OJ7vgquZmuOo=;
        b=Ti/PnraOPbq5VSQ6WzhhBDqHP14yGwmvpUG7Gp3wOUv0HjjLuwTSjVeD3beyMNUAU9
         sPouadXcRGfY7rAIyHqRdHKmGyz246m1jMZ6QcW75X45fZN5zwHa1ue98nkpi2A76vrW
         Do89KQGUS5EtB942vEBoL2CKpzCIQh4YToY/BXRvU4R7onmp798SnyMnGMAUHdRAM5DE
         wnn14bO97PcJJyHOCaFZPko2phytBILxCCyaXd4KOi5Y9c/FvTplVFMMqHO8V0XPIsyM
         6TfDl37BgnuqaAHSn5VPlX9Q/JPIluVhHmy3GCD+tXthfpZdoI5yit9neNCmCMLX+x4R
         6OOQ==
X-Gm-Message-State: AOJu0Yxskg5uKoqNFCbdlKjZgnp9GiVn23Pwj24/Aa+BMpB9/qLrFsjj
	d9oiRDK8f+erTI3nnLs85QgkUlGkye5ZbQ==
X-Google-Smtp-Source: AGHT+IHSoFKqX0fg4X/60v5LLHrytvVwsD0oPAsS9XDYQtQ0atkHkPuaXxm6c3eyVBDTG5qsh0EXbA==
X-Received: by 2002:a2e:be89:0:b0:2c1:522a:8e1b with SMTP id a9-20020a2ebe89000000b002c1522a8e1bmr7697238ljr.51.1695725523667;
        Tue, 26 Sep 2023 03:52:03 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f4-20020a2e6a04000000b002b95eb96ab7sm2575327ljc.18.2023.09.26.03.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:52:03 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:51:59 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>, 
	Russell King <linux@armlinux.org.uk>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
	David E Box <david.e.box@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mark Gross <markgross@kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Wong Vee Khee <veekhee@apple.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Revanth Kumar Uppala <ruppala@nvidia.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Andrey Konovalov <andrey.konovalov@linaro.org>, 
	Jochen Henneberg <jh@henneberg-systemdesign.com>, David E Box <david.e.box@intel.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Simon Horman <simon.horman@corigine.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, bpf@vger.kernel.org, 
	Voon Wei Feng <weifeng.voon@intel.com>, Tan Tee Min <tee.min.tan@linux.intel.com>, 
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>, Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next v3 2/5] net: pcs: xpcs: combine C37 SGMII AN and
 2500BASEX for Intel mGbE controller
Message-ID: <ogrj3h65cpzmrtbv3antnxht5ebrxzzex4snj6oeqxzdtsvqeh@a5tq5ozokjr5>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Choong

On Thu, Sep 21, 2023 at 08:19:43PM +0800, Choong Yong Liang wrote:
> From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>
> 
> This commit introduces xpcs_sgmii_2500basex_features[] that combine
> xpcs_sgmii_features[] and xpcs_2500basex_features[] for Intel mGbE
> controller that desire to interchange the speed mode of
> 10/100/1000/2500Mbps at runtime.
> 
> Also, we introduce xpcs_config_aneg_c37_sgmii_2500basex() function
> which is called by the xpcs_do_config() with the new AN mode:
> DW_SGMII_2500BASEX, and this new function will proceed next-level
> calling to perform C37 SGMII AN/2500BASEX configuration based on
> the PHY interface updated by PHY driver.

Why do you even need all of those changes? Please thoroughly justify
because ... (see below)

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

... these are just a combination of the
xpcs_sgmii_features[]/xpcs_sgmii_interfaces[] and
xpcs_2500basex_features[]/xpcs_2500basex_interfaces[] data which are
already supported by the generic DW XPCS code. All of these features
and interfaces are checked in the xpcs_create() method and then get to
be combined in the framework of the xpcs_validate() and
xpcs_get_interfaces() functions. And ...

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

* This is the only specific change in this patch. But it can be
* applied independently from the rest of the changes. Although I agree
* with Russel, it must be double checked since may cause regressions
* on the other platforms.

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

... this is just a copy of the code which is already available in xpcs_do_config():

<        compat = xpcs_find_compat(xpcs->id, interface);
<        if (!compat)
<                return -ENODEV;
<
<        switch (compat->an_mode) {
< ...
<        case DW_AN_C37_SGMII:
<                ret = xpcs_config_aneg_c37_sgmii(xpcs, neg_mode);
<                if (ret)
<                        return ret;
<                break;
< ...
<        case DW_2500BASEX:
<                ret = xpcs_config_2500basex(xpcs);
<                if (ret)
<                        return ret;
<                break;

So based on the passed interface xpcs_find_compat() will find a proper
compat descriptor, which an_mode field will be then utilized to call
the respective config method. Thus, unless I miss something, basically
you won't need any of the changes below and the most of the changes
above reducing the patch to just a few lines.

-Serge(y)

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

