Return-Path: <bpf+bounces-50793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 625E1A2C9A6
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 18:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13880188F3DD
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DDB1A314C;
	Fri,  7 Feb 2025 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cl6LlcBN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1688118E03A;
	Fri,  7 Feb 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947566; cv=none; b=UEmY1g4mSOhl5SChXe70Yl8wSkeznq5qn9pqiwwQvchUuLM7AY9tPjNj25RBz0z2N64g1pCVq52g/sF7sxh9/ceEbD4osERvkw+7nNCDD98OpKpupF1C1H2hkLMXgx458mvHjaPoaJQezuC+INmdlZXUrUSbgbb0MyNNrZTCgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947566; c=relaxed/simple;
	bh=h75b+TdsJ58/EyAZzGusAGULFypKzhj4oZJY0fm1wu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hM+Hh/ngMkxzIjzL4xmQk6REY9liMIOAxKQjGCkajnr204EUNnkVSpZ1VsbhvYLUOZGAdejy+57Fd5dJ8wRqrPo7l3SxizzoqPkwXHVfJ0jDmRw90p0aiV6+2FrD1eT+1M/6GZ6RLa4hCpmjI+KFr6IRvdGgQeeqKwd8SCMtQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cl6LlcBN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738947565; x=1770483565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h75b+TdsJ58/EyAZzGusAGULFypKzhj4oZJY0fm1wu8=;
  b=Cl6LlcBNDgMZSNek0LhjuIuQZShCcC3pLXwv1/7f5yf6Gp/KhAGfPojq
   da/LDB3NzjblgoxzfXSVDMafs9NJxcaT9v24jkuPFIfGSGw0VfQBKAz26
   bO1vCKlW/HLG5L38AlsOqBNRI4nxGkUYLYtbAB6s3WLNLjXIJDQxj9P+1
   1gVJQeQQEBLItlkV17dK4piTVbMr6fA59v8iieYP1hiU+lH8d7geQLLp8
   +nl7p5UqUUsHM6pbaEaNuL2x5zzKan931PM+iyYw5OlZkqdLv9PFQJ54L
   ZJv4IZ+yUoXAqSmDSUEzG57dkQiA8DfsJQr98m1PdEPwzCVE7S8qMFQWn
   g==;
X-CSE-ConnectionGUID: IG58bVWMSEu6JeYLZvmWqQ==
X-CSE-MsgGUID: LLbtF1WkRm6pHqr9kgGPGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42436001"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="42436001"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:59:24 -0800
X-CSE-ConnectionGUID: xh97f0y8TjGtJI3gx/8V4A==
X-CSE-MsgGUID: uTOuguuVSR6n8OMUQ6ULHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116777275"
Received: from wkuan-mobl1.gar.corp.intel.com (HELO [10.247.64.179]) ([10.247.64.179])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:59:15 -0800
Message-ID: <65c82c04-6c71-4120-aaa0-5d20e7eca0fe@linux.intel.com>
Date: Sat, 8 Feb 2025 00:59:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 5/9] igc: Add support for frame preemption
 verification
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
 John Fastabend <john.fastabend@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Furong Xu <0x1207@gmail.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Petr Tesarik <petr@tesarici.cz>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20250205100524.1138523-1-faizal.abdul.rahim@linux.intel.com>
 <20250205100524.1138523-6-faizal.abdul.rahim@linux.intel.com>
 <20250205171234.cuscjpzdyc34ofbn@skbuf>
 <6bf3f4b2-efee-41fe-97b3-cb53eca4dfed@linux.intel.com>
 <20250206150410.u4rehwxnnuhtcfxr@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250206150410.u4rehwxnnuhtcfxr@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/2/2025 11:04 pm, Vladimir Oltean wrote:
> On Thu, Feb 06, 2025 at 10:40:11PM +0800, Abdul Rahim, Faizal wrote:
>>
>> Hi Vladimir,
>>
>> Thanks for the quick review, appreciate your help.
>>
>> On 6/2/2025 1:12 am, Vladimir Oltean wrote:
>>> On Wed, Feb 05, 2025 at 05:05:20AM -0500, Faizal Rahim wrote:
>>>> This patch implements the "ethtool --set-mm" callback to trigger the
>>>> frame preemption verification handshake.
>>>>
>>>> Uses the MAC Merge Software Verification (mmsv) mechanism in ethtool
>>>> to perform the verification handshake for igc.
>>>> The structure fpe.mmsv is set by mmsv in ethtool and should remain
>>>> read-only for the driver.
>>>>
>>>> igc does not use two mmsv callbacks:
>>>> a) configure_tx()
>>>>      - igc lacks registers to configure FPE in the transmit direction.
>>>
>>> Yes, maybe, but it's still important to handle this. It tells you when
>>> the preemptible traffic classes should be sent as preemptible on the wire
>>> (i.e. when the verification is either disabled, or it succeeded).
>>>
>>> There is a selftest called manual_failed_verification() which supposedly
>>> tests this exact condition: if verification fails, then packets sent to
>>> TC0 are supposed to bump the eMAC's TX counters, even though TC0 is
>>> configured as preemptible. Otherwise stated: even if the tc program says
>>> that a certain traffic class is preemptible, you don't want to actually
>>> send preemptible packets if you haven't verified the link partner can
>>> handle them, since it will likely drop them on RX otherwise.
>>
>> Even though fpe in tx direction isn't set in igc, it still checks
>> ethtool_mmsv_is_tx_active() before setting a queue as preemptible.
>>
>> This is done in :
>> igc_tsn_enable_offload(struct igc_adapter *adapter) {
>> {
>> 	....
>> 	if (ethtool_mmsv_is_tx_active(&adapter->fpe.mmsv) &&
>>              ring->preemptible)
>> 	    txqctl |= IGC_TXQCTL_PREEMPTIBLE;
>>
>>
>> Wouldn't this handle the situation mentioned ?
>> Sorry if I miss something here.
> 
> And what if tx_active becomes true after you had already configured the
> queues with tc (and the above check caused IGC_TXQCTL_PREEMPTIBLE to not
> be set)? Shouldn't you set IGC_TXQCTL_PREEMPTIBLE now? Isn't
> ethtool_mmsv_configure_tx() exactly the function that notifies you of
> changes to tx_active, and hence, aren't you interested in setting up a
> callback for it?
> 

Ahh okay, got it. I sent v3 that also included this update. Thanks!

