Return-Path: <bpf+bounces-51519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80155A355AC
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 05:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3792D7A36A9
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 04:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A1915CD4A;
	Fri, 14 Feb 2025 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVRUzszS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C91519AD;
	Fri, 14 Feb 2025 04:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506845; cv=none; b=r6yFzxy5j//jW81XPAtVIfjkrbEkYleVwlvQZTaVtsoHLw2DUNqU14hprIPfs3FKOsBEr07MmHLuGIwFWgZr0r8MEakdP7BabiXfb3LL0ma5v8G9g5bELwyz8gzmyD9c/CZp7HZcLVmYByvnl+1IBq8UzqMJ1It7DMadK/EAvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506845; c=relaxed/simple;
	bh=0N+NIkjKA48xzvqbJnB29lAB08YfjMQLZFPJzVlNIO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTdyPYpOuaCFmfFSivacpdnZY7ek4a9Lk7AKuUz57X8GGZ9iTs/6+67j5Zx5D1Tpuit/v7AVOQ1jvZ6wdwYTjt6abdhiF2kofTnPl9G6buAcnMuigp0+A40FQzNHxTuezQsPkqQcDpmwkC8pTD2EIMvDln4Kd5cXms6FFAymJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVRUzszS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739506844; x=1771042844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0N+NIkjKA48xzvqbJnB29lAB08YfjMQLZFPJzVlNIO4=;
  b=MVRUzszSODMo+CjeMJQztsIQEh5TdFOj/0xI2mu+GxKcABaz0zemx+T4
   jCfek2j7HVL2Ogzk9An7jBlZrG4ltamFKNJB/yJp78nHbupJrFDDjEjHi
   D1lbIgpzkTrzoXPyUFgeDnZoHO0oSigp3An8BdwGBRKn7UWLWzIb1+PVk
   fKxNPiRiedxvmCPjOTfbr4OTt9g7yjytPwN/886Q2DVOe/Mvcf12V6YXs
   IWefsO7rOf6dVAezYml37ATJvd4Oq2cmLRm6zIoSg8RMfw8Do7N4SlLIs
   zWV8DRL36hDb4gjEvHWBhTVL84Q3wAsEvXVnQ8kJdH418qLFDgbHC4hgt
   w==;
X-CSE-ConnectionGUID: OgLyfioHRG+BnVbwwivk2Q==
X-CSE-MsgGUID: /1i3tsybTI6BtQdrOVSdzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40505957"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40505957"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 20:20:43 -0800
X-CSE-ConnectionGUID: VV+jgGj8RGadw8WZ3YmWXQ==
X-CSE-MsgGUID: ktMrD4xUQYq+G2zq3bq7DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="144209439"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.123.6]) ([10.247.123.6])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 20:20:33 -0800
Message-ID: <b7740709-6b4a-4f44-b4d7-e265bb823aca@linux.intel.com>
Date: Fri, 14 Feb 2025 12:20:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 0/9] igc: Add support for Frame Preemption
 feature in IGC
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
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
 <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250212220121.ici3qll66pfoov62@skbuf>
 <b19357dc-590d-458c-9646-ee5993916044@linux.intel.com>
 <87cyfmnjdh.fsf@kurt.kurt.home>
 <5902cc28-a649-4ae9-a5ba-83aa265abaf8@linux.intel.com>
 <20250213130003.nxt2ev47a6ppqzrq@skbuf>
 <1c981aa1-e796-4c53-9853-3eae517f2f6d@linux.intel.com>
 <877c5undbg.fsf@kurt.kurt.home> <20250213184613.cqc2zhj2wkaf5hn7@skbuf>
 <87v7td3bi1.fsf@kurt.kurt.home>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <87v7td3bi1.fsf@kurt.kurt.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/2/2025 3:12 am, Kurt Kanzenbach wrote:
> On Thu Feb 13 2025, Vladimir Oltean wrote:
>> So, confusingly to me, it seems like one operating mode is fundamentally
>> different from the other, and something will have to change if both will
>> be made to behave the same. What will change? You say mqprio will behave
>> like taprio, but I think if anything, mqprio is the one which does the
>> right thing, in igc_tsn_tx_arb(), and taprio seems to use the default Tx
>> arbitration scheme?
> 
> Correct. taprio is using the default scheme. mqprio configures it to
> what ever the user provided (in igc_tsn_tx_arb()).
> 
>> I don't think I'm on the same page as you guys, because to me, it is
>> just odd that the P traffic classes would be the first ones with
>> mqprio, but the last ones with taprio.
> 
> I think we are on the same page here. At the end both have to behave the
> same. Either by using igc_tsn_tx_arb() for taprio too or only using the
> default scheme for both (and thereby keeping broken_mqprio). Whatever
> Faizal implements I'll match the behavior with mqprio.
> 

Hi Kurt & Vladimir,

After reading Vladimir's reply on tc, hw queue, and socket priority mapping 
for both taprio and mqprio, I agree they should follow the same priority 
scheme for consistency—both in code and command usage (i.e., taprio, 
mqprio, and fpe in both configurations). Since igc_tsn_tx_arb() ensures a 
standard mapping of tc, socket priority, and hardware queue priority, I'll 
enable taprio to use igc_tsn_tx_arb() in a separate patch submission.

I'll split the changes based on Vladimir's suggestion.

First part - ethtool-mm related:
igc: Add support to get frame preemption statistics via ethtool
igc: Add support to get MAC Merge data via ethtool
igc: Add support to set tx-min-frag-size
igc: Add support for frame preemption verification
igc: Set the RX packet buffer size for TSN mode
igc: Optimize TX packet buffer utilization
igc: Rename xdp_get_tx_ring() for non-XDP usage
net: ethtool: mm: Extract stmmac verification logic into a common library

Second part:
igc: Add support for preemptible traffic class in taprio and mqprio
igc: Use igc_tsn_tx_arb() for taprio queue priority scheme
igc: Kurt's patch on mqprio to use normal TSN Tx mode

Kurt can keep igc_tsn_tx_arb() for his mqprio patch, so preemptible tc 
should work the same for both taprio and mqprio.

I'm suggesting to include Kurt's patch in the second part since there's 
some dependency and potential code conflict, even though it mixes different 
functional changes in the same series.

Does this sound good to you?


