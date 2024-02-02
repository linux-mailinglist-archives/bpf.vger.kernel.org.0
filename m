Return-Path: <bpf+bounces-20995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A1D84663C
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 04:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD2F1F261E1
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9126E563;
	Fri,  2 Feb 2024 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIY20bC+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F9C130;
	Fri,  2 Feb 2024 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843070; cv=none; b=bh/sFWnNheAvmPsBAoeBxDb1waaBCmUz69eDhxaDZdycYcRMH0Z9byzqi0klt2FUeVfP0MGiFvHr8Yt7v2FLURTyX9Kpku3fUyyEstELvjwFg0Traz+26XCoLdrSjvXMR4ha7OTq0HRS6qHmneRyn1p5YFSHJvY+h1TLY3c3J/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843070; c=relaxed/simple;
	bh=l3bgt/i5okwgssxhTR2nxbBEc5VyBQCo8JSDXE2iktI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N47y6hj5bVJ9WImJEYnzIxjLp4UdGFTWRReFly7toXzUi7QdNz0kO9WrfPTsRkC9QSvolPEhpHP5P1g6j1gr8tHqQUj98lTVDZQBIOkq8uVz/quCfRzWIQX4G+q0JpjQMM+/zR/N8wP0Uzw1AZ5uDpA6786H8n8BsWaY8TgDmv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIY20bC+; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706843067; x=1738379067;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l3bgt/i5okwgssxhTR2nxbBEc5VyBQCo8JSDXE2iktI=;
  b=hIY20bC+p1dHl4QGFG3cNh0blrlM8YMk36lfbrwk11ejA4snzaL/ZxKH
   TzKAAelZFfx88ZuWTzjMQExhKA0Ld/R0Fen5c71O0jDZ5qyZkIKgpmYzs
   WSIQ8C/r388Q+J+BUvwSQMC6JBP45lEZFHCliOWqMjSOj62u7atoeRRIj
   pESK233sRi6nisrSh9U7PRl0bmka5D3k6TV5uIpMundjU5cfNIzPlUVap
   ILrXE9Zafm30uBcpwTUr5F9MN2miE0Sk+hp9nmmWgFpyFJ0Av8idgmY+5
   l7uzcBl3vsGV8xLZLvWSfp67bBIgAkT/O0QNyH02+g9UE1NFWVDgkSmg7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="468283605"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="468283605"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 19:04:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859304037"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859304037"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.22.55]) ([10.247.22.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 19:04:17 -0800
Message-ID: <8fa87696-0c8d-405b-9e38-835d1ed65e90@linux.intel.com>
Date: Fri, 2 Feb 2024 11:04:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 07/11] arch: x86: Add IPC mailbox accessor
 function and add SoC register access
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
 <20240129130253.1400707-8-yong.liang.choong@linux.intel.com>
 <1fccbf0d-5b96-447b-80f1-19af70628edc@linux.intel.com>
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <1fccbf0d-5b96-447b-80f1-19af70628edc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 31/1/2024 6:54 pm, Ilpo Järvinen wrote:
> On Mon, 29 Jan 2024, Choong Yong Liang wrote:
> 
>> From: "David E. Box" <david.e.box@linux.intel.com>
>>
>> - Exports intel_pmc_ipc() for host access to the PMC IPC mailbox
>> - Add support to use IPC command allows host to access SoC registers
>> through PMC firmware that are otherwise inaccessible to the host due to
>> security policies.
>>
>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>> Signed-off-by: Chao Qin <chao.qin@intel.com>
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>> ---
>>   MAINTAINERS                                   |  2 +
>>   arch/x86/Kconfig                              |  9 +++
>>   arch/x86/platform/intel/Makefile              |  1 +
>>   arch/x86/platform/intel/pmc_ipc.c             | 75 +++++++++++++++++++
>>   .../linux/platform_data/x86/intel_pmc_ipc.h   | 34 +++++++++
>>   5 files changed, 121 insertions(+)
>>   create mode 100644 arch/x86/platform/intel/pmc_ipc.c
>>   create mode 100644 include/linux/platform_data/x86/intel_pmc_ipc.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8709c7cd3656..441eb921edef 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10973,8 +10973,10 @@ M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
>>   M:	David E Box <david.e.box@intel.com>
>>   L:	platform-driver-x86@vger.kernel.org
>>   S:	Maintained
>> +F:	arch/x86/platform/intel/pmc_ipc.c
>>   F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
>>   F:	drivers/platform/x86/intel/pmc/
>> +F:	linux/platform_data/x86/intel_pmc_ipc.h
>>   
>>   INTEL PMIC GPIO DRIVERS
>>   M:	Andy Shevchenko <andy@kernel.org>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 5edec175b9bf..bceae28b9381 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -666,6 +666,15 @@ config X86_AMD_PLATFORM_DEVICE
>>   	  I2C and UART depend on COMMON_CLK to set clock. GPIO driver is
>>   	  implemented under PINCTRL subsystem.
>>   
>> +config INTEL_PMC_IPC
>> +	tristate "Intel Core SoC Power Management Controller IPC mailbox"
>> +	depends on ACPI
>> +	help
>> +	  This option enables sideband register access support for Intel SoC
>> +	  power management controller IPC mailbox.
>> +
>> +	  If you don't require the option or are in doubt, say N.
>> +
>>   config IOSF_MBI
>>   	tristate "Intel SoC IOSF Sideband support for SoC platforms"
>>   	depends on PCI
>> diff --git a/arch/x86/platform/intel/Makefile b/arch/x86/platform/intel/Makefile
>> index dbee3b00f9d0..470fc68de6ba 100644
>> --- a/arch/x86/platform/intel/Makefile
>> +++ b/arch/x86/platform/intel/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   obj-$(CONFIG_IOSF_MBI)			+= iosf_mbi.o
>> +obj-$(CONFIG_INTEL_PMC_IPC)		+= pmc_ipc.o
>> \ No newline at end of file
> 
> New line missing.
> 
> 
Thank you for letting me know.
I will fix it in the new patch series.

