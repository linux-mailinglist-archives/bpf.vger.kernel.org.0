Return-Path: <bpf+bounces-51364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B99A3376E
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA1B7A3900
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 05:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44968206F17;
	Thu, 13 Feb 2025 05:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fqzdhc3x"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE50B206F05;
	Thu, 13 Feb 2025 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425361; cv=none; b=BLrs+OpT6sWZIxxp30amHTLCfqmcl82JoxZsX4wjwgEJjSIv4BMjfJ14swtoS7y5+es0hg2nGw0BXoQc/o0AtXXdfHt9FzHUK6O/gPIhXarMMFDHjV0CSrmR00bNJxhq/HucTO3f6fkZBsRCyqEbA/MP5Z3HZCxo51u389O2BZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425361; c=relaxed/simple;
	bh=s1+zMW0r7uW6tCZ4MRxVO4Jw77rHPs73bHu8Fg5RZuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAlTF9XLp/apadJ1XD04f+zXQMkZcxuR6gILBsgbqNW6dKHyRzcQyU/wfjM9OH+gDr5HXYWZfiDMbg8a4UuISfCxOPb0lwZZbBmoUKErlorYIj8f60zsbP+8aSuK/k6ajsDWdcNyuJPrSVe3+RzRwYsG0glcwI5WiTvv5u2v6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fqzdhc3x; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739425360; x=1770961360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s1+zMW0r7uW6tCZ4MRxVO4Jw77rHPs73bHu8Fg5RZuA=;
  b=Fqzdhc3xkAFSv4ZfrEh8z+g5RK13ayGpI1bBAhenxwrAX4MZBXyjOr43
   j8cN0+VSdJcXrjXrRqwKjW+MFkcYNL+qfwTLpCtgfGA8unAl2/DDsBeH3
   VrcElUhz2q951scF+KUqTyR6VrGWnhftvd3hofZn6XZziMf35/qkCa5QW
   mi45Ib93ofQc5gOG+Z9NlsI60mOMHN5dNB3stG4Bejl7TIGKw/vg8aVPs
   2zuoPBFzbyeeoc3n+XCWwcPqhcfyTGJ25QXen9Zwu7dEo9bFvItrvY+BB
   xQNei/nPvvfl1/BbptNGVWanrPGhWUmJQrjz9u9rA9BzxcgFU/P5g5qbg
   A==;
X-CSE-ConnectionGUID: BVJ6e4aoTXOU+pVHjUiVPg==
X-CSE-MsgGUID: bPyTzJtvTuGNMjcTcji4bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40144840"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40144840"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 21:42:39 -0800
X-CSE-ConnectionGUID: absVRYFWTE6GjFbSpIfu3A==
X-CSE-MsgGUID: Rc56qI39ThGchxAi5S5+/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118128278"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.42.34]) ([10.247.42.34])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 21:42:31 -0800
Message-ID: <74a324de-7a64-4d67-8167-79bf6e4ae8da@linux.intel.com>
Date: Thu, 13 Feb 2025 13:42:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 9/9] igc: Add support to get frame preemption
 statistics via ethtool
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Andrew Halaney <ahalaney@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250210070207.2615418-10-faizal.abdul.rahim@linux.intel.com>
 <20250212215408.v47eb42zx67ij6vp@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250212215408.v47eb42zx67ij6vp@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/2/2025 5:54 am, Vladimir Oltean wrote:
> On Mon, Feb 10, 2025 at 02:02:07AM -0500, Faizal Rahim wrote:
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index f15ac7565fbd..cd5160315993 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -3076,6 +3076,7 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
>>   			break;
>>   
>>   		if (static_branch_unlikely(&igc_fpe_enabled) &&
>> +		    adapter->fpe.mmsv.pmac_enabled &&
> 
> This bit is misplaced in this patch.

My bad, thanks for catching that.

