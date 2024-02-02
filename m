Return-Path: <bpf+bounces-20997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7195584664C
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 04:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBDF1F253F9
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160DC8E1;
	Fri,  2 Feb 2024 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJpo4bFC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13946DDCE;
	Fri,  2 Feb 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843172; cv=none; b=TLS3wNunLICxT3MkCQS6OoNoj1vy3aihsJp9LLZbXrhwn9+as6yiVqivrpGqsR/8+uMvaHPoPfaLaoCPsP6zMtc+RkkUxQLeWvIhxP8pj2UDq/r86Rdvl9Bugye6Hh+pY8P/f9vk4/qzuEv5bUFXwmcr9BIB5nOuZpe0q3utFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843172; c=relaxed/simple;
	bh=tGLiGtD2ffb0omsWaMaWz1meXi7Me/QbXHDdjQQbe+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMWcJ/rZqe3A0EWIG509HTosLTbiG+QDth6od3zQO8upOTk2A6renaxvks4WF+YOKdmZhgREjMZWlD6gDLdT0FVO2JY51LZBrqRpsijDHmS5fSKl/WwuL330HvpxICG7ghFABgm73H43Spn7FKnIugx088WCjdjxi5gK+tLDacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJpo4bFC; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706843171; x=1738379171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tGLiGtD2ffb0omsWaMaWz1meXi7Me/QbXHDdjQQbe+c=;
  b=iJpo4bFChC9X7kZ6k8wND0L+OrzpKOpDgb1FBvCr+MpJwJ3AjBAiFeUf
   /aoGNXy24ESQPoJQvWjrTbvAOJKqemsOp4IXdhiWH1uRkNUVTHozPRPOq
   CmHBkfs0g5EHyy39wn52hRjm8ElLT7Nn4jx637IYVkIPNt3+SAODdkK2m
   pdijyzWATzyM9lsRybBMFlsSvQC0PN4PeJALTdNOF9K7IvUtsEoZTF3g5
   3q356Z/SmaDoF6PjVdCCGh+xUV6MA38wuq8841lqrCSyFJjQ+9uQZ5ZLD
   +ub2KiBcnj4b/wWmA5BTyfTAgiAkjKmp35Ew6RWIfDq2391u8eL0lrwbp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="468283919"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="468283919"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 19:06:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859304194"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859304194"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.22.55]) ([10.247.22.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 19:06:01 -0800
Message-ID: <c0a87401-9f8b-4b60-b47d-31232873bba9@linux.intel.com>
Date: Fri, 2 Feb 2024 11:06:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 08/11] stmmac: intel: configure SerDes
 according to the interface mode
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Andrew Halaney
 <ahalaney@redhat.com>, Simon Horman <simon.horman@corigine.com>,
 Serge Semin <fancer.lancer@gmail.com>, Netdev <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, bpf@vger.kernel.org,
 Voon Wei Feng <weifeng.voon@intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>,
 Abdul Rahim Faizal <faizal.abdul.rahim@intel.com>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
 <20240129130253.1400707-9-yong.liang.choong@linux.intel.com>
 <99d78f25-dd2a-4a52-4c2a-b0e29505a776@linux.intel.com>
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <99d78f25-dd2a-4a52-4c2a-b0e29505a776@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 31/1/2024 6:58 pm, Ilpo Järvinen wrote:
> On Mon, 29 Jan 2024, Choong Yong Liang wrote:
> 
>> From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>
>>
>> Intel platform will configure the SerDes through PMC api based on the
>> provided interface mode.
>>
>> This patch adds several new functions below:-
>> - intel_tsn_interface_is_available(): This new function reads FIA lane
>>    ownership registers and common lane registers through IPC commands
>>    to know which lane the mGbE port is assigned to.
>> - intel_config_serdes(): To configure the SerDes based on the assigned
>>    lane and latest interface mode, it sends IPC command to the PMC through
>>    PMC driver/API. The PMC acts as a proxy for R/W on behalf of the driver.
>> - intel_set_reg_access(): Set the register access to the available TSN
>>    interface.
>>
>> Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
>>   .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 113 +++++++++++++++++-
>>   .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  75 ++++++++++++
>>   3 files changed, 188 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> index 85dcda51df05..be423fb2b46c 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> @@ -273,6 +273,7 @@ config DWMAC_INTEL
>>   	default X86
>>   	depends on X86 && STMMAC_ETH && PCI
>>   	depends on COMMON_CLK
>> +	select INTEL_PMC_IPC
> 
> INTEL_PMC_IPC has depends on ACPI but selecting INTEL_PMC_IPC won't
> enforce it AFAIK.
> 
Hi Ilpo,

Thank you for pointing this out.
I will check on my side too.
Will fix it in the new patch series.

