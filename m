Return-Path: <bpf+bounces-22060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F137C855972
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 04:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9552874A3
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECEC6FB8;
	Thu, 15 Feb 2024 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KY0/JGk1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74382CA4;
	Thu, 15 Feb 2024 03:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966882; cv=none; b=exu1j13ilB1YnPGUt0oidr1e0xvf0k26VolTXn4uqyOAjLASHwCE4QcYwnFP9wbqjAWM1bWxMoOMQ+LEbAGpogd6W6eFl+I+q4d9XPjZIZX0XjFjGfMxNTHYpOwL2oNB/29M2GeA8dqsGmtA7HJ/24d10ZTlpRA2rAgaHsWdCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966882; c=relaxed/simple;
	bh=sLEedRMDncb0IeCD2q4hOTg4DPcXH151vX4zjRS2Q+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ri3dVHASaTZaWYaSxfLeEiSUd7jjFEk5qbsvihorazbnYVk6hdMxRGwiqCQ0fecLM0mAz363EBPnbxf8BLqqpdKU/KPP3UU96ujRhmus0UdQYol9pXV56tIC13BSq2JYrCIEIAi4xFLDUOgRunHg1orQExqR0+/QoLouQYFM03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KY0/JGk1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707966881; x=1739502881;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sLEedRMDncb0IeCD2q4hOTg4DPcXH151vX4zjRS2Q+o=;
  b=KY0/JGk16X+h8dtAIdWOH1qBQGZJnCVCGUvBpuI437YRwbVfCXscWzsu
   +BzYAXGMqBfmBZ+XswbI5/ANgh4vedbO66SQSfI9cOLqfCBhVJVcHBolL
   /UukKxpuyxJQNZCnZ4zuUbecWUeqvomfi1TTE9UXNW7BEoS2qXB2X9uu6
   HuQR9AYZwUx6ksBhoMeXyl2OwvraKtFCFdPgjMCOk72CJHUJ1QLVS5rj7
   bA4cTEojp91GXwy/tjcqlEsC5gOFdNuommmduY4Y2LppSYfvzEUXuke8+
   +NIKfeYObQ2ymexRswtevifj5b3OfZiOtaFXe+c/2s21FCFrpjt7BLjWx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1914711"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1914711"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:14:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8056455"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.84.237]) ([10.247.84.237])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:14:30 -0800
Message-ID: <9154ea9e-863b-49b3-8729-1ba077872bcc@linux.intel.com>
Date: Thu, 15 Feb 2024 11:14:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 06/11] net: stmmac: resetup XPCS according to
 the new interface mode
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Andrew Halaney
 <ahalaney@redhat.com>, Serge Semin <fancer.lancer@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, bpf@vger.kernel.org,
 Voon Wei Feng <weifeng.voon@intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>,
 Abdul Rahim Faizal <faizal.abdul.rahim@intel.com>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
 <20240129130253.1400707-7-yong.liang.choong@linux.intel.com>
 <ZbjNn+C/VHegH2t7@shell.armlinux.org.uk>
 <9e23671e-788c-4191-bdb4-94915ff7da5a@linux.intel.com>
 <ZbtYaXkNf2ZF1prE@shell.armlinux.org.uk>
 <2ad1f55c-f361-4439-9174-6af1bb429d55@linux.intel.com>
 <Zbys2orOUikYxeOm@shell.armlinux.org.uk>
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <Zbys2orOUikYxeOm@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/2/2024 4:50 pm, Russell King (Oracle) wrote:
>> Thank you for taking the time to review, got your concerns, and I'll address
>> the following concerns before submitting a new patch series:
>>
>> 1. Remove allow_switch_interface and have the PHY driver fill in
>> phydev->possible_interfaces.
> 
> Yes please.
> 

Hi Russell,

I regret to inform you that I didn't implement everything exactly as 
proposed in the new patch series. My intention was to simplify the series, 
focusing solely on managing SGMII and 2500BASE-X interface mode switching. 
The recommendation to have the PHY driver fill in 
"phydev->possible_interfaces" will be addressed in a separate patch 
submission. I hope this is acceptable.

In the new patch series, I removed "allow_switch_interface" patches. The 
current solution continues to work with PHYs that are C45 and follow the 
legacy path, such as Marvell Alaska 88E2110. For the upcoming patch series, 
I will implement "phydev->possible_interfaces" for C22 and C45 PHYs.


>> 2. Rework on the PCS to have similar implementation with the following patch
>> "net: macb: use .mac_select_pcs() interface"
>> (https://lore.kernel.org/netdev/E1n568J-002SZX-Gr@rmk-PC.armlinux.org.uk/T/).
> 
> mac_select_pcs() is about returning to phylink the PCS that the MAC
> needs to use for the specified interface mode, or NULL if no PCS is
> required, nothing more, nothing less.
> 
> Plase do not copy that mac_select_pcs() implementation - changing the
> "ops" underneath phylink is no longer permitted.
> 

Upon further examination, I discovered that no change is required for the 
"mac_select_pcs()" function; we can still use the same PCS. According to 
the XPCS datasheet, a soft reset is necessary to re-initiate Clause 37 
auto-negotiation when switching to SGMII interface mode. This is the only 
setting required for properly configuring the SGMII interface mode, and 
nothing extra is needed for 2500BASE-X configuration.

In the new patch series, I removed "mac_select_pcs()" related patches and 
added a "xpcs_soft_reset()" patch for the XPCS.

