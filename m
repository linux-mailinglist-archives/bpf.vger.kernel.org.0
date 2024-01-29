Return-Path: <bpf+bounces-20592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818284068E
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A141F24F4C
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF66310F;
	Mon, 29 Jan 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKmA4peO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15896604C6;
	Mon, 29 Jan 2024 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534328; cv=none; b=juv/JakzGan+VkvCAJUanzznE5y0LdMegdQa0lwEXUvaXYrA3wB+wA3n1H2JhRuv37vxmV3QRnERZCDToIOhW9BZpma1kY8VjM8i2iR/86Auf+XDtBBxyorLyLMPQ20EnObY+aL1WX4SxJOWTJ8zbLoVBcb3YON5ppF/DJ/MGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534328; c=relaxed/simple;
	bh=JpFZYsNzV1BEiQaBqprQnIqEqg0c3XqDOiJt3LcQ2KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJrlppYuDEUnvTPrS9DXba/4CCW5ZQ7hrhuhwcNCFvJgTJ7spuiwlpgA5lZO9jd7FKh2YoUD2Vko/DKY54aB20JLBklN78RT6yGuDk5Kj1joOMNlBjok0lvcQh4VaKLB3lhKUcOGi9FB+mKQiquSg5+BEhfvcASXNtBnp/o6J/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKmA4peO; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706534327; x=1738070327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JpFZYsNzV1BEiQaBqprQnIqEqg0c3XqDOiJt3LcQ2KU=;
  b=aKmA4peOILY/X5XC9dL826/Fu8lo61brUGqZxBiOBAWzN7nAqoObHntU
   pziwvZtWF2JWfa5fDIZI2esECZYTy5/NJShPO0GMN7TcZ53T+Bo7Xytkg
   axefPyEGDA4VcACwLapuFzLSxCidn/4S/rMM62lPdz0ZArDSWX+iF7Rj3
   VFZ2syf2DMr1I8gCqa+yu90p5fMb46TVwRIUC2UNzru93KR3iJi32fRxm
   9QKM+CHptmlo7gY1LqUe/Z7xivzoGO3OEdmOy5s5t1qJHXjfxiXYp2Y90
   VQM0FSrddiJb9oc4Q5xH83TtjOG/Q6L97i+X46/hdtqHsiAgYShFvO/hz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="400092653"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="400092653"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:18:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="787828961"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="787828961"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.122.111]) ([10.247.122.111])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:18:33 -0800
Message-ID: <d1e28a1e-5d82-40bd-99d5-ca30a1744ccc@linux.intel.com>
Date: Mon, 29 Jan 2024 21:18:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] net: phy: update in-band AN mode when
 changing interface by PHY driver
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
 <20230921121946.3025771-4-yong.liang.choong@linux.intel.com>
 <ZQxNhYcusHfrJvxM@shell.armlinux.org.uk>
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ZQxNhYcusHfrJvxM@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/9/2023 10:04 pm, Russell King (Oracle) wrote:
> On Thu, Sep 21, 2023 at 08:19:44PM +0800, Choong Yong Liang wrote:
>> As there is a mechanism in PHY drivers to switch the PHY interface
>> between SGMII and 2500BaseX according to link speed. In this case,
>> the in-band AN mode should be switching based on the PHY interface
>> as well, if the PHY interface has been changed/updated by PHY driver.
>>
>> For e.g., disable in-band AN in 2500BaseX mode, or enable in-band AN
>> back for SGMII mode (10/100/1000Mbps).
>>
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> 
> This approach is *going* to break existing setups, sorry.
> 
>> +/**
>> + * phylink_interface_change() - update both cfg_link_an_mode and
>> + * cur_link_an_mode when there is a change in the interface.
>> + * @phydev: pointer to &struct phy_device
>> + *
>> + * When the PHY interface switches between SGMII and 2500BaseX in
>> + * accordance with the link speed, the in-band AN mode should also switch
>> + * based on the PHY interface
>> + */
>> +static void phylink_interface_change(struct phy_device *phydev)
>> +{
>> +	struct phylink *pl = phydev->phylink;
>> +
>> +	if (pl->phy_state.interface != phydev->interface) {
>> +		/* Fallback to the correct AN mode. */
>> +		if (phy_interface_mode_is_8023z(phydev->interface) &&
>> +		    pl->cfg_link_an_mode == MLO_AN_INBAND) {
>> +			pl->cfg_link_an_mode = MLO_AN_PHY;
>> +			pl->cur_link_an_mode = MLO_AN_PHY;
> 
> 1. Why are you changing both cfg_link_an_mode (configured link AN mode)
> and cur_link_an_mode (current link AN mode) ?
> 
> The "configured" link AN mode is supposed to be whatever was configured
> at phylink creation time, and it's never supposed to change. The
> "current" link AN mode can change, but changing that must be followed
> by a major reconfiguration to ensure everything is correctly setup.
> That will happen only because the change to the current link AN mode
> can only happen when pl->phy_state.interface has changed, and the
> change of pl->phy_state.interface triggers the reconfiguration.
> 
During the phylink_create, the cfg_link_an_mode will be set to MLO_AN_INBAND.

Then we switch from the SGMII interface to 2500BASEX interface. When we 
perform 'ifconfig eth0 down' and 'ifconfig eth0 up' then we will not able 
to bring up the PHY due to the phylink_attach_phy function. It is not 
expect to have MLO_AN_INBAND with PHY_INTERFACE_MODE_2500BASEX interface.

static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
			      phy_interface_t interface)
{
	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED ||
		    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
		     phy_interface_mode_is_8023z(interface) && !pl->sfp_bus)))
		return -EINVAL;

	if (pl->phydev)
		return -EBUSY;

	return phy_attach_direct(pl->netdev, phy, 0, interface);
}

I did change different ways to handle it in the new patch series.
So it should not impact much on the existing phylink framework.

> 2. You force this behaviour on everyone, so now everyone with a SFP
> module that operates in 802.3z mode will be switched out of inband mode
> whether they want that or not. This is likely to cause some breakage.
> 
>> +		} else if (pl->config->ovr_an_inband) {
>> +			pl->cfg_link_an_mode = MLO_AN_INBAND;
>> +			pl->cur_link_an_mode = MLO_AN_INBAND;
> 
> Here you force inband when not 802.3z mode and ovr_an_inband is set.
> There are SFP modules that do *not* support in-band at all, and this
> will break these modules when combined with a driver that sets
> ovr_an_inband. So more breakage.
> 
> Please enumerate the PHY interface modes that you are trying to support
> with this patch set, and indicate whether you want in-band for that
> mode or not, and where the restriction for whether in-band can be used
> comes from (PHY, PCS or MAC) so that it's possible to better understand
> what you're trying to achieve.
> 
> Thanks.
> 
Thank you for pointing out the bug that will impact everyone. Actually 
cur_link_an_mode is just required for PCS, I did handle it that only intel 
platforms will get the PCS negotiation mode for the PCS.

