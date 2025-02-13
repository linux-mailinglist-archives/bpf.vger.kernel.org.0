Return-Path: <bpf+bounces-51414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED3A340D9
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 14:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B63168B3C
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93361487FA;
	Thu, 13 Feb 2025 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsR7wsI/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F624BC0D;
	Thu, 13 Feb 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454854; cv=none; b=p3KnCbB3m/5u5GrgrztFmt81gnRtvIpLq/aU9BLKf+YhCgPtaUhFClYDdLeTmq86Fnx7sKZNVJHCw/NVtMAL25yhqKQ/vzlZAIYQq8jUVpoREyo44Zom/y+FHzLGsrI56qrotQqoUpIYu6EZmLU+7v4gV0TDo2kna9sJ8n2TSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454854; c=relaxed/simple;
	bh=g5HGHBuqAjMQOceJtIfxFmXU57w01hrdcPk8EKvjSzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/T9Ce0DQCsXxZcpJW6AVT9MgJkkN6d+zlTle5IpY3QhDaS5fQ+7JFih57KDUl5IsC/HSn9PQy0GuPfuL/hmpk11f9Ruato7BZX+KtV7cRGvkz+6hbWitTU9yqiOCshoRRceRCB4fawrAL5zVBRgCP7+4RdeOqEnDp/3GJQivHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsR7wsI/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454853; x=1770990853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g5HGHBuqAjMQOceJtIfxFmXU57w01hrdcPk8EKvjSzU=;
  b=dsR7wsI/gJFB++j7xyA3eg2TFuAPg61NMoHq3uUMi5HremhdxCfkVzDb
   mq1BOJ0GdlwVPmUYFnpJe9cFkeBuC+0LHZWKLcNzyI25YZk9g9/3BYa9K
   dSr8V3DywSt1Jy9DLoi7hWwTpDSnXzL4TA6PjUeVuuwwCX7znMWnTON+4
   4b9V+7NDpfJCQlc95ztHi07c+UDbU3no1oisQWfIOXAl806JhNlmmsdHp
   QSDJqTP3uJ29RxtU5UDNQEahA9hZKl8mMd5kS+9aDR2p76rqslsjwK36g
   mF5c2liwiGvN1x3rQ0l5bsZE7R5Jx+YOU11mdBciIlnDGlq9OxdXiYi3b
   w==;
X-CSE-ConnectionGUID: WUtiAvDuSzyTpVB3Vbvs5A==
X-CSE-MsgGUID: o5M64SCRTZONPQcJtMK42Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40019842"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40019842"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:54:12 -0800
X-CSE-ConnectionGUID: Va5fv8RuSjiYMn+k3238nA==
X-CSE-MsgGUID: 1CjFB4TaT2qSpWMyGvwtMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118080787"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.42.34]) ([10.247.42.34])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:54:04 -0800
Message-ID: <1c981aa1-e796-4c53-9853-3eae517f2f6d@linux.intel.com>
Date: Thu, 13 Feb 2025 21:54:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 0/9] igc: Add support for Frame Preemption
 feature in IGC
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
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
 <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250212220121.ici3qll66pfoov62@skbuf>
 <b19357dc-590d-458c-9646-ee5993916044@linux.intel.com>
 <87cyfmnjdh.fsf@kurt.kurt.home>
 <5902cc28-a649-4ae9-a5ba-83aa265abaf8@linux.intel.com>
 <20250213130003.nxt2ev47a6ppqzrq@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250213130003.nxt2ev47a6ppqzrq@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/2/2025 9:00 pm, Vladimir Oltean wrote:
> On Thu, Feb 13, 2025 at 08:54:18PM +0800, Abdul Rahim, Faizal wrote:
>>> Well, my idea was to move the current mqprio offload implementation from
>>> legacy TSN Tx mode to the normal TSN Tx mode. Then, taprio and mqprio
>>> can share the same code (with or without fpe). I have a draft patch
>>> ready for that. What do you think about it?
>>
>> Hi Kurt,
>>
>> I’m okay with including it in this series and testing fpe + mqprio, but I’m
>> not sure if others might be concerned about adding different functional
>> changes in this fpe series.
>>
>> Hi Vladimir,
>> Any thoughts on this ?
> 
> Well, what do you think of my split proposal from here, essentially
> drawing the line for the first patch set at just ethtool mm?
> https://lore.kernel.org/netdev/20250213110653.iqy5magn27jyfnwh@skbuf/
> 

Honestly, after reconsidering, I’d prefer to keep the current series as is 
(without Kurt’s patch), assuming you’re okay with enabling mqprio + fpe 
later rather than at the same time as taprio + fpe. There likely won’t be 
any additional work needed for mqprio + fpe after Kurt’s patch is accepted, 
since it will mostly reuse the taprio code flow.

If I were to split it, the structure would look something like this:
First part of fpe series:
igc: Add support to get frame preemption statistics via ethtool
igc: Add support to get MAC Merge data via ethtool
igc: Add support to set tx-min-frag-size
igc: Add support for frame preemption verification
igc: Set the RX packet buffer size for TSN mode
igc: Optimize the TX packet buffer utilization
igc: Rename xdp_get_tx_ring() for non-XDP usage
net: ethtool: mm: Extract stmmac verification logic into a common library

Second part of fpe:
igc: Add support for preemptible traffic class in taprio

I don’t think Kurt’s patch should be included in my second part of fpe, as 
it’s not logically related. Another approach would be to wait for Kurt’s 
patch to be accepted first, then submit the second part and verify both 
taprio + mqprio. However, that would delay i226 from having a basic fpe 
feature working as a whole, which I'd really like to avoid.


