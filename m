Return-Path: <bpf+bounces-20589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581B7840663
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B94D1C241E7
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ED2629EE;
	Mon, 29 Jan 2024 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YC4DUsm8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8BB6340E;
	Mon, 29 Jan 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533931; cv=none; b=SyltPVSF4DcuSm+t7jz4EoEwVka+xgihZnzYLVACpn8g9SWHWt1qa1aarNk+2evK1XLExZsfPEQBYnrg+h5+ePNetxYNmVMSNla/EqRo3nYhfHh04V92YTHRsdnIZfa9REwiYSdJ8ZPhkUHIVivx/Q6cuTQosS/dAojg98CrwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533931; c=relaxed/simple;
	bh=+Ew5LUI3g/pPiKdhhQ2t8V+CzBXr7IlkIiYR6xaMc2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfQVTkcLMPOEXnxS736OixosEW3sraKNhoV/6X+43Xjqi+mzJqTym17wEZoH0dRvGMh6ymA+ttwOwndBNt3B+WyR+Vqp9AOkdkRr8vH6yrdDEUbQpOKBIiW9E58EuYcVopk3vOY9aKTEYU8eYOHZxGr+VmlnzNw2VvVBOCJCMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YC4DUsm8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706533931; x=1738069931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Ew5LUI3g/pPiKdhhQ2t8V+CzBXr7IlkIiYR6xaMc2Q=;
  b=YC4DUsm8dK20MvP3ERW0YBTv1/EnztBrD/5OEmKRhfiHCZ4ncrtNCyNZ
   82De0zanK/R2nKfktCf8GzU4eaIFvaz3NivKNesPQQWIQnHoeJgbL5Mg/
   FMNeGdOdzqLaQCkJNExesZE2ORNqS7cWIffHMzWPEP/KQ6g/ccOCLpx5l
   iRd7Z8fFUCbm0ojisVCu+L3CuxWeXezalsK0umzyVf795jr9XPZPjqTqj
   zEqSUbZtR4BZ8/LAeP0WQ2F8WpdBhrNjEoZT7mpVkb6dptH9yZyOzwvZP
   px1lRD/hU7RlK5EqDCw4Np7ZFfao7otOytJCL3RWhxV5acqqJOah+xgmd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10328222"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="10328222"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:12:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="878068136"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="878068136"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.122.111]) ([10.247.122.111])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:11:56 -0800
Message-ID: <aec1ba8e-b609-4ec1-b6e2-8f850ab45c7f@linux.intel.com>
Date: Mon, 29 Jan 2024 21:11:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/5] TSN auto negotiation between 1G and 2.5G
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
 Jochen Henneberg <jh@henneberg-systemdesign.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, bpf@vger.kernel.org,
 Voon Wei Feng <weifeng.voon@intel.com>,
 Tan Tee Min <tee.min.tan@linux.intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>
References: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
 <5bd05ba2-fd88-4e5c-baed-9971ff917484@lunn.ch>
 <f9b21a9d-4ae2-1f91-b621-2e27f746f661@linux.intel.com>
 <37fe9352-ec84-47b8-bb49-9441987ca1b9@lunn.ch>
 <ZQxPQ9t8/TKcjlo8@shell.armlinux.org.uk>
 <0098eaf3-717a-4b50-b2a0-4b28b75b0735@lunn.ch>
 <ZQxZVbmdcAN6UI2G@shell.armlinux.org.uk>
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ZQxZVbmdcAN6UI2G@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/9/2023 10:55 pm, Russell King (Oracle) wrote:
> On Thu, Sep 21, 2023 at 04:41:20PM +0200, Andrew Lunn wrote:
>> On Thu, Sep 21, 2023 at 03:12:19PM +0100, Russell King (Oracle) wrote:
>>> On Thu, Sep 21, 2023 at 03:21:00PM +0200, Andrew Lunn wrote:
>>>>> Hi Andrew,
>>>>>
>>>>> After conducting a comprehensive study, it seems that implementing
>>>>> out-of-band for all link modes might not be feasible. I may have missed some
>>>>> key aspects during my analysis.
>>>>>
>>>>> Would you be open to sharing a high-level idea of how we could potentially
>>>>> make this feasible? Your insights would be greatly appreciated.
>>>>
>>>> stmmac_mac_link_up() gets passed interface, speed and duplex. That
>>>> tells you what the PHY has negotiated. Is there anything else you need
>>>> to know?
>>>
>>> The problem is... the stmmac driver is utter bollocks - that information
>>> is *not* passed to the BSP. Instead, stmmac parse and store information
>>> such as the PHY interface mode at initialisation time. BSPs also re-
>>> parse and store e.g. the PHY interface mode at initialisation time.
>>> The driver ignores what it gets from phylink.
>>>
>>> The driver is basically utter crap. That's an area I _had_ patches to
>>> clean up. I no longer do. stmmac is crap crap crap and will stay crap
>>> until they become more receptive to patches to fix it, even if the
>>> patches are not 100% to their liking but are in fact correct. Maybe
>>> if I ever decide to touch that driver in the future. Which I doubt
>>> given my recent experience.
>>
>> Hi Russell
>>
>> You pointed out the current proposal will break stuff. Do you see a
>> way forward for this patchset which does not first involve actually
>> cleaning up of this driver?
> 
> As I said in one of my replies, it would really help if the author can
> provide a table showing what is attempting to be achieved here. With
> that, we should be able to work out exactly what is required, what
> needs to change in stmmac, etc.
> 

Thank you, Russell and Andrew for the comments.

What I'm trying to achieve here is to enable interface mode switching 
between 2500basex and SGMII interfaces for Intel platforms.

I did based on the DM7052 SFP module and BCM84881 PHY to make the necessary 
changes in the new version of my patch series.

In the new patch series, the 'allow_switch_interface' flag was introduced, 
based on the 'allow_switch_interface' flag, the interface mode is 
configured to PHY_INTERFACE_MODE_NA within the 'phylink_validate_phy' 
function. This setting allows all ethtool link modes that are supported and 
advertised will be published. Then interface mode switching occurs based on
the selection of different link modes.

During the interface mode switching, the code will go through the 
`phylink_major_config` function and based on the interface mode to select 
PCS and PCS negotiation mode to configure PCS. Then, the MAC driver will 
perform SerDes configuration according to the interface mode.

I did rewrite the description for the new patch series, hoping that it is 
clear to describe the whole intention of the changes.

