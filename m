Return-Path: <bpf+bounces-20591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59584067B
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAC11C23995
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0637362A05;
	Mon, 29 Jan 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/GDlXnT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107962817;
	Mon, 29 Jan 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534162; cv=none; b=EB1Bh4GiIcace/siku/eb/VxQU/WAk9ZhYpgd5jittcYqcLORSoTQ1GeOQHt+mwpq16GaLtszynec/SXYieInm0ZCrqI9VHx6V7+sCK8+snuclrgcW+d9zqdwpS1yUojx/jjqnQWVqXUcwcwFkvinsjb3ns2QdW8i9rpNVy7gg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534162; c=relaxed/simple;
	bh=AudW6lchVMASv39ToIRXtG1kL5HX7XZ/XXM+ITeoqgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwsH6c/AcQi2oujwfMvqn2ckzRxoM4+Hm+VAR7fpDWoQWmYEy48JKuwjNW5ofxKqCdA22LWqz6eIoTN6hkhmkn9sqLx26/3aPRFniyRtWhOjQ/V+rZPMLCnkiP7rRSJF8XWePb5j+xtpn8iBE4n2srkTlr+V8kr1F2/SE8TDuyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/GDlXnT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706534160; x=1738070160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AudW6lchVMASv39ToIRXtG1kL5HX7XZ/XXM+ITeoqgg=;
  b=Y/GDlXnTIKbZdR8VFwvbBvAjXKqDN0i+Hinli8VwzwECchxuop0kNk0B
   6C6xNwcXYdHsWdT8mBZllsXCZ0xxCgFOdhhWIyTkGgZwL/Dyt/M+N6zAW
   ZSZPHDdaEKpoe2RYV7w9/ASqrDWXYdIhHlGPkjKixDipLQ+5J2Vlo7e59
   rPez9aCZ6Voiha1ty2mJ6DxiV79LwKVtNnbrG+Hrz4MIDI+fShbkJnddW
   z/fjQP/1sorAsIAkxc+QkgQSPx4xtLp/kRwscix6oK5LodlUVO+85teYh
   /f8ooji7Anq2h/N1DRQqGRjuat1fxRjmzeB0U+BJseA1jX4DBJYD2hM4K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="9618542"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="9618542"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3461005"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.122.111]) ([10.247.122.111])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:15:46 -0800
Message-ID: <8b9d62e4-be3d-4190-83e7-4058487995af@linux.intel.com>
Date: Mon, 29 Jan 2024 21:15:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] net: pcs: xpcs: combine C37 SGMII AN and
 2500BASEX for Intel mGbE controller
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Wong Vee Khee
 <veekhee@apple.com>, Jon Hunter <jonathanh@nvidia.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Revanth Kumar Uppala <ruppala@nvidia.com>,
 Shenwei Wang <shenwei.wang@nxp.com>,
 Andrey Konovalov <andrey.konovalov@linaro.org>,
 Jochen Henneberg <jh@henneberg-systemdesign.com>,
 David E Box <david.e.box@intel.com>, Andrew Halaney <ahalaney@redhat.com>,
 Simon Horman <simon.horman@corigine.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, bpf@vger.kernel.org,
 Voon Wei Feng <weifeng.voon@intel.com>,
 Tan Tee Min <tee.min.tan@linux.intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>
References: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
 <20230921121946.3025771-3-yong.liang.choong@linux.intel.com>
 <ogrj3h65cpzmrtbv3antnxht5ebrxzzex4snj6oeqxzdtsvqeh@a5tq5ozokjr5>
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ogrj3h65cpzmrtbv3antnxht5ebrxzzex4snj6oeqxzdtsvqeh@a5tq5ozokjr5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/9/2023 6:51 pm, Serge Semin wrote:
> Hi Choong
> 
> On Thu, Sep 21, 2023 at 08:19:43PM +0800, Choong Yong Liang wrote:
>> From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>
>>
>> This commit introduces xpcs_sgmii_2500basex_features[] that combine
>> xpcs_sgmii_features[] and xpcs_2500basex_features[] for Intel mGbE
>> controller that desire to interchange the speed mode of
>> 10/100/1000/2500Mbps at runtime.
>>
>> Also, we introduce xpcs_config_aneg_c37_sgmii_2500basex() function
>> which is called by the xpcs_do_config() with the new AN mode:
>> DW_SGMII_2500BASEX, and this new function will proceed next-level
>> calling to perform C37 SGMII AN/2500BASEX configuration based on
>> the PHY interface updated by PHY driver.
> 
> Why do you even need all of those changes? Please thoroughly justify
> because ... (see below)
> 
>>
>> Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>> ---
>>   drivers/net/pcs/pcs-xpcs.c   | 72 ++++++++++++++++++++++++++++++------
>>   include/linux/pcs/pcs-xpcs.h |  1 +
>>   2 files changed, 62 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
>> index 4dbc21f604f2..60d90191677d 100644
>> --- a/drivers/net/pcs/pcs-xpcs.c
>> +++ b/drivers/net/pcs/pcs-xpcs.c
>> @@ -104,6 +104,21 @@ static const int xpcs_2500basex_features[] = {
>>   	__ETHTOOL_LINK_MODE_MASK_NBITS,
>>   };
>>   
> 
>> +static const int xpcs_sgmii_2500basex_features[] = {
>> +	ETHTOOL_LINK_MODE_Pause_BIT,
>> +	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
>> +	ETHTOOL_LINK_MODE_Autoneg_BIT,
>> +	ETHTOOL_LINK_MODE_10baseT_Half_BIT,
>> +	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
>> +	ETHTOOL_LINK_MODE_100baseT_Half_BIT,
>> +	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
>> +	ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
>> +	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
>> +	ETHTOOL_LINK_MODE_2500baseX_Full_BIT,
>> +	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> +	__ETHTOOL_LINK_MODE_MASK_NBITS,
>> +};
>> +
>>   static const phy_interface_t xpcs_usxgmii_interfaces[] = {
>>   	PHY_INTERFACE_MODE_USXGMII,
>>   };
>> @@ -133,6 +148,12 @@ static const phy_interface_t xpcs_2500basex_interfaces[] = {
>>   	PHY_INTERFACE_MODE_MAX,
>>   };
>>   
>> +static const phy_interface_t xpcs_sgmii_2500basex_interfaces[] = {
>> +	PHY_INTERFACE_MODE_SGMII,
>> +	PHY_INTERFACE_MODE_2500BASEX,
>> +	PHY_INTERFACE_MODE_MAX,
>> +};
>> +
> 
> ... these are just a combination of the
> xpcs_sgmii_features[]/xpcs_sgmii_interfaces[] and
> xpcs_2500basex_features[]/xpcs_2500basex_interfaces[] data which are
> already supported by the generic DW XPCS code. All of these features
> and interfaces are checked in the xpcs_create() method and then get to
> be combined in the framework of the xpcs_validate() and
> xpcs_get_interfaces() functions. And ...
> 
>>   enum {
>>   	DW_XPCS_USXGMII,
>>   	DW_XPCS_10GKR,
>> @@ -141,6 +162,7 @@ enum {
>>   	DW_XPCS_SGMII,
>>   	DW_XPCS_1000BASEX,
>>   	DW_XPCS_2500BASEX,
>> +	DW_XPCS_SGMII_2500BASEX,
>>   	DW_XPCS_INTERFACE_MAX,
>>   };
>>   
>> @@ -290,6 +312,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
>>   	case DW_AN_C37_SGMII:
>>   	case DW_2500BASEX:
>>   	case DW_AN_C37_1000BASEX:
>> +	case DW_SGMII_2500BASEX:
>>   		dev = MDIO_MMD_VEND2;
>>   		break;
>>   	default:
>> @@ -748,6 +771,8 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
>>   	if (xpcs->dev_flag == DW_DEV_TXGBE)
>>   		ret |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
>>   
> 
>> +	/* Disable 2.5G GMII for SGMII C37 mode */
>> +	ret &= ~DW_VR_MII_DIG_CTRL1_2G5_EN;
> 
> * This is the only specific change in this patch. But it can be
> * applied independently from the rest of the changes. Although I agree
> * with Russel, it must be double checked since may cause regressions
> * on the other platforms.
> 
>>   	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1, ret);
>>   	if (ret < 0)
>>   		return ret;
>> @@ -848,6 +873,26 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
>>   	return xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL, ret);
>>   }
>>   
> 
>> +static int xpcs_config_aneg_c37_sgmii_2500basex(struct dw_xpcs *xpcs,
>> +						unsigned int neg_mode,
>> +						phy_interface_t interface)
>> +{
>> +	int ret = -EOPNOTSUPP;
>> +
>> +	switch (interface) {
>> +	case PHY_INTERFACE_MODE_SGMII:
>> +		ret = xpcs_config_aneg_c37_sgmii(xpcs, neg_mode);
>> +		break;
>> +	case PHY_INTERFACE_MODE_2500BASEX:
>> +		ret = xpcs_config_2500basex(xpcs);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
> 
> ... this is just a copy of the code which is already available in xpcs_do_config():
> 
> <        compat = xpcs_find_compat(xpcs->id, interface);
> <        if (!compat)
> <                return -ENODEV;
> <
> <        switch (compat->an_mode) {
> < ...
> <        case DW_AN_C37_SGMII:
> <                ret = xpcs_config_aneg_c37_sgmii(xpcs, neg_mode);
> <                if (ret)
> <                        return ret;
> <                break;
> < ...
> <        case DW_2500BASEX:
> <                ret = xpcs_config_2500basex(xpcs);
> <                if (ret)
> <                        return ret;
> <                break;
> 
> So based on the passed interface xpcs_find_compat() will find a proper
> compat descriptor, which an_mode field will be then utilized to call
> the respective config method. Thus, unless I miss something, basically
> you won't need any of the changes below and the most of the changes
> above reducing the patch to just a few lines.
> 
> -Serge(y)
> 
>>   int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
>>   		   const unsigned long *advertising, unsigned int neg_mode)
>>   {
>> @@ -890,6 +935,12 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
>>   		if (ret)
>>   			return ret;
>>   		break;
>> +	case DW_SGMII_2500BASEX:
>> +		ret = xpcs_config_aneg_c37_sgmii_2500basex(xpcs, neg_mode,
>> +							   interface);
>> +		if (ret)
>> +			return ret;
>> +		break;
>>   	default:
>>   		return -1;
>>   	}
>> @@ -1114,6 +1165,11 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
>>   		}
>>   		break;
>>   	case DW_AN_C37_SGMII:
>> +	case DW_SGMII_2500BASEX:
>> +		/* 2500BASEX is not supported for in-band AN mode. */
>> +		if (state->interface == PHY_INTERFACE_MODE_2500BASEX)
>> +			break;
>> +
>>   		ret = xpcs_get_state_c37_sgmii(xpcs, state);
>>   		if (ret) {
>>   			pr_err("xpcs_get_state_c37_sgmii returned %pe\n",
>> @@ -1266,23 +1322,17 @@ static const struct xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
>>   		.num_interfaces = ARRAY_SIZE(xpcs_10gbaser_interfaces),
>>   		.an_mode = DW_10GBASER,
>>   	},
>> -	[DW_XPCS_SGMII] = {
>> -		.supported = xpcs_sgmii_features,
>> -		.interface = xpcs_sgmii_interfaces,
>> -		.num_interfaces = ARRAY_SIZE(xpcs_sgmii_interfaces),
>> -		.an_mode = DW_AN_C37_SGMII,
>> -	},
>>   	[DW_XPCS_1000BASEX] = {
>>   		.supported = xpcs_1000basex_features,
>>   		.interface = xpcs_1000basex_interfaces,
>>   		.num_interfaces = ARRAY_SIZE(xpcs_1000basex_interfaces),
>>   		.an_mode = DW_AN_C37_1000BASEX,
>>   	},
>> -	[DW_XPCS_2500BASEX] = {
>> -		.supported = xpcs_2500basex_features,
>> -		.interface = xpcs_2500basex_interfaces,
>> -		.num_interfaces = ARRAY_SIZE(xpcs_2500basex_interfaces),
>> -		.an_mode = DW_2500BASEX,
>> +	[DW_XPCS_SGMII_2500BASEX] = {
>> +		.supported = xpcs_sgmii_2500basex_features,
>> +		.interface = xpcs_sgmii_2500basex_interfaces,
>> +		.num_interfaces = ARRAY_SIZE(xpcs_sgmii_2500basex_features),
>> +		.an_mode = DW_SGMII_2500BASEX,
>>   	},
>>   };
>>   
>> diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
>> index da3a6c30f6d2..f075d2fca54a 100644
>> --- a/include/linux/pcs/pcs-xpcs.h
>> +++ b/include/linux/pcs/pcs-xpcs.h
>> @@ -19,6 +19,7 @@
>>   #define DW_2500BASEX			3
>>   #define DW_AN_C37_1000BASEX		4
>>   #define DW_10GBASER			5
>> +#define DW_SGMII_2500BASEX		6
>>   
>>   /* device vendor OUI */
>>   #define DW_OUI_WX			0x0018fc80
>> -- 
>> 2.25.1
>>
>>
Hi Serge and Russell

This patch does not serve the purpose correctly, I did remove this patch 
and handle it properly in the new patch series.

