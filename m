Return-Path: <bpf+bounces-20590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062A0840674
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947631F26702
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C356311F;
	Mon, 29 Jan 2024 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lks3LUW5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE26281E;
	Mon, 29 Jan 2024 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534024; cv=none; b=uLmHLROvrSO9htLhylWGi4meaERpQJDy1ic+61xUkdcv/FOCKJLRyqBiv0h5M26ID2ybiYiWKAaDYLuWY/cn8qCqaNwohFze3FHoDUciw6PMgRzo/Ohcuqna7ishouF5lDJxszMSZJKFJlu1bQLVubz9Die4d8Mf76x3Vtc4Q9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534024; c=relaxed/simple;
	bh=1A2kwv15wQygVVOoqucjQOG6yZvrsKLSOxdqdrtflpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgNVtu48PSlitj169KMOH2Ucatxx1ZYmcRrlsgYRG+tzla23/WaiE83XgzJuZkgItqy2eKH/g2T5oZBbT5IrVgCEz5i9GskFcEcYEZXtN6HGGRIcyJfrLotPJxw/ZkRBGLOlQrLs7f7glaRkBK5ofo+r/mmNPM15B6EQ8f5KwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lks3LUW5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706534024; x=1738070024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1A2kwv15wQygVVOoqucjQOG6yZvrsKLSOxdqdrtflpo=;
  b=Lks3LUW5kikOTYIsZHogC66eDYYP+quAz/YTIE6ggUGSheUDKfFESczK
   f6+EcvBj0ftXVaKDQ0g5hiJ3hb5PKgvBN44CNL2NsCnwTOJDIfp4S+lJh
   ndtOJZaWVy1rLqk7m/aFTxFuzyqIniFU3SbUp8dZ5fqXZ7ufavUWpgQzg
   VsDHsWLeAMJrt59bBKBu0k+w9ufC+Qmufs2DPeHMCEHX9iH6gQxvjco7q
   6hAkVODIP2F2HxeBY8jksoHNbs3c/SBZ/e1F5YMy0IgBp9aDZRSRdqveT
   bX+oTJZI4iFWED+vOZdansj5dSjzxvRUOaPyQqrMaaBIbbkH3ZQf/tC5Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10328513"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="10328513"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:13:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="878068306"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="878068306"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.122.111]) ([10.247.122.111])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:13:28 -0800
Message-ID: <41f08e94-3a0b-442b-be79-d30579f3e12d@linux.intel.com>
Date: Mon, 29 Jan 2024 21:13:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/5] TSN auto negotiation between 1G and 2.5G
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
 <4caade36-d4be-4670-ac79-d9d00488293d@lunn.ch>
 <ZQxOgfw3LD5Bu2iD@shell.armlinux.org.uk>
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ZQxOgfw3LD5Bu2iD@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/9/2023 10:09 pm, Russell King (Oracle) wrote:
> On Thu, Sep 21, 2023 at 03:14:59PM +0200, Andrew Lunn wrote:
>>> Auto-negotiation between 10, 100, 1000Mbps will use
>>> in-band auto negotiation. Auto-negotiation between 10/100/1000Mbps and
>>> 2.5Gbps will work as the following proposed flow, the stmmac driver reads
>>> the PHY link status registers then identifies the negotiated speed.
>>
>> I don't think you replied to my comment.
>>
>> in-band is just an optimisation. It in theory allows you to avoid a
>> software path, the PHY driver talking to the MAC driver about the PHY
>> status. As an optimisation, it is optional. Linux has the software
>> path and the MAC driver you are using basically has it implemented.
> 
> Sorry Andrew, I have to disagree. It isn't always optional - there are
> PHYs out there where they won't pass data until the in-band exchange
> has completed. If you try to operate out-of-band without the PHY being
> told that is the case, and program the MAC/PCS end not to respond to
> the in-band frames from the PHY, the PHY will report link up as normal
> (since it reports the media side), but no data will flow because the
> MAC facing side of the PHY hasn't completed.
> 
> The only exception are PHYs that default to in-band but have an inband
> bypass mode also enabled to cover the case where the MAC/PCS doesn't
> respond to the inband messages.
> 
Russell is correct, we did set out-of-band for PCS and configured MAC.
Due to the PHY not being completed, there will be no data flow through.

