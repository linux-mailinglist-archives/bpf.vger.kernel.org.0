Return-Path: <bpf+bounces-20916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42984509D
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 06:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D0EB240AA
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241573C497;
	Thu,  1 Feb 2024 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hfo0TwT4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA8366;
	Thu,  1 Feb 2024 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764228; cv=none; b=bZ4UJngXxpOhvRMhE5iWWv8G5sqr6q9PdSkpAXz1huhJ97/0pOaDfrm2MKaykOGXQQPuY5Hr1wSgI5XdoFzqBms8Dzq1HTLuMlT4g2J8EO8xZge4aOOWtwKuF6rtDBDYi797IbD4pluxb2E2KkW/nT3+pMn5A0m5UlhdaDSsT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764228; c=relaxed/simple;
	bh=TZ4WdxaS6sBzLI6TTeW0UbEUGPpFWeuJx+KfLwa7rnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MI9bBqsKEvkLDG+GW3ovpSt8G/XeQgoRPFsogwqojEb8QnhVLNwmqvfc6xYd2iesnF++yM6JjRH3/r4TKNizLwGDzQTTMly4TVfXCL5J/NdzS/pMRLRF82aU18EG97Agq3s43aYBq32LKlcTNbznB5RdJKI/VqjQzOODR2Iopmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hfo0TwT4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706764227; x=1738300227;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TZ4WdxaS6sBzLI6TTeW0UbEUGPpFWeuJx+KfLwa7rnQ=;
  b=Hfo0TwT4iF7pfEchdTAN09ZkgQgq0lmNmD9iBurnBCxQJ/WmXe6Oa8nB
   b6mSUwR7Xc536bN8XV2dv2X9pUKiB6VCREYzQyD4QKHnJOtowTrx999CS
   +Gj5K7wDVYIHSTwq74lacgxH/ZN25tjr4IVPyE3FlBCgo0QfE/E1uoxHv
   +mKaUwrWCcIVXnQrPuOxCplwVUaZCpzgF/vnAmzNp0Z2grKFoTXzwU81W
   Vhq9H+F+hS7a+87OUUnNqUu2tRawMh6/Bsk9USdsCdaGv4soBarPIR0fr
   DaIDfY3wjxNouCqyFe4OKICNYGaz+/SL9sECV65IfCwINYT+dI10nK6iY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17196091"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="17196091"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 21:10:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="908132348"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="908132348"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.5.230]) ([10.247.5.230])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 21:10:17 -0800
Message-ID: <9e23671e-788c-4191-bdb4-94915ff7da5a@linux.intel.com>
Date: Thu, 1 Feb 2024 13:10:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 06/11] net: stmmac: resetup XPCS according to
 the new interface mode
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
 <ahalaney@redhat.com>, Simon Horman <simon.horman@corigine.com>,
 Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, bpf@vger.kernel.org,
 Voon Wei Feng <weifeng.voon@intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>,
 Abdul Rahim Faizal <faizal.abdul.rahim@intel.com>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
 <20240129130253.1400707-7-yong.liang.choong@linux.intel.com>
 <ZbjNn+C/VHegH2t7@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ZbjNn+C/VHegH2t7@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/1/2024 6:21 pm, Russell King (Oracle) wrote:
> NAK. Absolutely not. You haven't read the phylink documentation, nor
> understood how phylink works.
> 
> Since you haven't read the phylink documentation, I'm not going to
> waste any more time reviewing this series since you haven't done your
> side of the bargin here.
> 
Hi Russell,

Sorry that previously I only studied the phylink based on the `phylink.h` 
itself. I think it might not be sufficient. I did search through the 
internet and found the phylink document from kernel.org 
(https://docs.kernel.org/networking/sfp-phylink.html). Kindly let me know 
if there are any other phylink documents I might have overlooked.

According to the phylink document from kernel.org, it does mention that 
"phylink is a mechanism to support hot-pluggable networking modules 
directly connected to a MAC without needing to re-initialise the adapter on 
hot-plug events." I realize I should not destroy and reinitialize the PCS.
Instead, I plan to follow the implementation in "net: macb: use 
.mac_select_pcs() interface" 
(https://lore.kernel.org/netdev/E1n568J-002SZX-Gr@rmk-PC.armlinux.org.uk/T/). 
This involves initializing the required PCS during the MAC probe and 
querying the PCS based on the interface.

Kindly let me know if I've overlooked anything in this proposed solution.

