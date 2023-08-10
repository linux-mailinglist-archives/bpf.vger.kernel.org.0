Return-Path: <bpf+bounces-7438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1077777463
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 11:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC15B281FA1
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA0E1EA6E;
	Thu, 10 Aug 2023 09:24:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1623C3C;
	Thu, 10 Aug 2023 09:24:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E11704;
	Thu, 10 Aug 2023 02:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691659441; x=1723195441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0kRWsvAisMK8ylRZ6jr2PcSZ59g1ZWZu9ngL3IpeqhQ=;
  b=if79p6KNkX9HPd4iYmAbauSL7aogj4XWKmuUJuzpsu0JETkKFB/i7Mp/
   T6qGm8Q5pqjU3L+m1DH23CVi7MCSLdsQqAJSPZwchNpwJherL0bcFSNgF
   9H4w2Se+TrLp/XqeF4QvEmnaD0E5T022DH45osLk9LhvJ6nRAgCIZXayw
   Latlbmu3Cdn4OatnUcD/JjAARaicPgiAQtlMDweyp83W02D0cnkFPFyJ2
   YHxhXQd/XZHUg25xnkVAROTjPKzG+T/M9cT7lnovxDAdwzytJfGYRBA4X
   26ZtwZ+R+yilmMuIMxF9P7YB03gEN0rjXsnpsF/WnSOroocLxCEoiT596
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="375066398"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="375066398"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 02:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="905981541"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="905981541"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.213.42.193]) ([10.213.42.193])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 02:23:48 -0700
Message-ID: <0aacc9b8-3780-6298-60db-7b140a52b92f@linux.intel.com>
Date: Thu, 10 Aug 2023 17:23:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2 3/5] net: phy: update in-band AN mode when
 changing interface by PHY driver
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Marek_Beh=c3=ban?=
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
 Jochen Henneberg <jh@henneberg-systemdesign.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, bpf@vger.kernel.org,
 Voon Wei Feng <weifeng.voon@intel.com>,
 Tan Tee Min <tee.min.tan@linux.intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>
References: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
 <20230804084527.2082302-4-yong.liang.choong@linux.intel.com>
 <ZMy+q84hVAbTQIk5@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ZMy+q84hVAbTQIk5@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 4/8/2023 5:02 pm, Russell King (Oracle) wrote:
> On Fri, Aug 04, 2023 at 04:45:25PM +0800, Choong Yong Liang wrote:
>> From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>
>>
>> Add cur_link_an_mode into phy_device struct for PHY drivers to
>> communicate the in-band AN mode setting with phylink framework.
>>
>> As there is a mechanism in PHY drivers to switch the PHY interface
>> between SGMII and 2500BaseX according to link speed. In this case,
>> the in-band AN mode should be switching based on the PHY interface
>> as well, if the PHY interface has been changed/updated by PHY driver.
>>
>> For e.g., disable in-band AN in 2500BaseX mode, or enable in-band AN
>> back for SGMII mode (10/100/1000Mbps).
>>
>> Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>> ---
>>   drivers/net/phy/marvell10g.c | 6 ++++++
>>   drivers/net/phy/phylink.c    | 4 ++++
>>   include/linux/phy.h          | 3 +++
>>   3 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
>> index d4bb90d76881..a9df19278618 100644
>> --- a/drivers/net/phy/marvell10g.c
>> +++ b/drivers/net/phy/marvell10g.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/phy.h>
>>   #include <linux/sfp.h>
>>   #include <linux/netdevice.h>
>> +#include <linux/phylink.h>
>>   
>>   #define MV_PHY_ALASKA_NBT_QUIRK_MASK	0xfffffffe
>>   #define MV_PHY_ALASKA_NBT_QUIRK_REV	(MARVELL_PHY_ID_88X3310 | 0xa)
>> @@ -946,6 +947,9 @@ static void mv3310_update_interface(struct phy_device *phydev)
>>   	 * xaui / rxaui modes according to the speed.
>>   	 * Florian suggests setting phydev->interface to communicate this to the
>>   	 * MAC. Only do this if we are already in one of the above modes.
>> +	 * In-band Auto-negotiation is not supported in 2500BASE-X.
>> +	 * Setting phydev->cur_link_an_mode to communicate this to the
>> +	 * phylink framework.
>>   	 */
>>   	switch (phydev->speed) {
>>   	case SPEED_10000:
>> @@ -956,11 +960,13 @@ static void mv3310_update_interface(struct phy_device *phydev)
>>   		break;
>>   	case SPEED_2500:
>>   		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
>> +		phydev->cur_link_an_mode = MLO_AN_PHY;
>>   		break;
>>   	case SPEED_1000:
>>   	case SPEED_100:
>>   	case SPEED_10:
>>   		phydev->interface = PHY_INTERFACE_MODE_SGMII;
>> +		phydev->cur_link_an_mode = MLO_AN_INBAND;
>>   		break;
>>   	default:
>>   		break;
>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>> index 4f1c8bb199e9..f9cbb6d7e134 100644
>> --- a/drivers/net/phy/phylink.c
>> +++ b/drivers/net/phy/phylink.c
>> @@ -1720,6 +1720,8 @@ static void phylink_phy_change(struct phy_device *phydev, bool up)
>>   		pl->phy_state.pause |= MLO_PAUSE_RX;
>>   	pl->phy_state.interface = phydev->interface;
>>   	pl->phy_state.link = up;
>> +	pl->cur_link_an_mode = phydev->cur_link_an_mode;
>> +	pl->cfg_link_an_mode = phydev->cur_link_an_mode;
>>   	mutex_unlock(&pl->state_mutex);
>>   
>>   	phylink_run_resolve(pl);
>> @@ -1824,6 +1826,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
>>   	if (pl->config->mac_managed_pm)
>>   		phy->mac_managed_pm = true;
>>   
>> +	pl->phydev->cur_link_an_mode = pl->cur_link_an_mode;
> 
> I am really not happy with exposing phylink's AN mode into phylib.
> 
Hi Russell,

Thank you for the feedback.
After conducting further analysis on my end, it appears that this line 
"pl->phydev->cur_link_an_mode = pl->cur_link_an_mode;" is not necessary.
If we remove this line of code, would the implementation of this patch be 
acceptable to you?

