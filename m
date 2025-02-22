Return-Path: <bpf+bounces-52227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDE3A40418
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 01:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397A5189C219
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 00:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF138FAD;
	Sat, 22 Feb 2025 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWPU/IGS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD663D76;
	Sat, 22 Feb 2025 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183975; cv=none; b=FocAnaZNvoXs+HTexZh4EoKdN0/CLRcRe5Tj9FONc4MJFs+x3fExmQHfrRKrFV9BarHIm8XEabsTqH3SC3WWDyd/nk2exUZ2fejkCujKiabZXpjnVrTqyrIlPWsGBaCSVYbGx6HNjEqcP6PXbHZgpCl8jBrxhCq98b3FmhwNxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183975; c=relaxed/simple;
	bh=vrsf0n7ZKY8Rgo7QAxaBCIwX0QhPlVwAlrXV1JsxYTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JM4Ew25ckpXs81dLLOHUp82m8pFR0nCdbZDp4ukXZj0e9hq9pdR1OBVZCu9e0RMdCwjZKGWlPnmDQxxKFhGyaf15V8zAg5M+5sCfBVSs0XFgaQDT+3JFn+fKvyTvh9gmMYP6Q/c0GJ2aWhoiZAInjbYu6GzjKBvYS2myOaWiJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWPU/IGS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740183974; x=1771719974;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vrsf0n7ZKY8Rgo7QAxaBCIwX0QhPlVwAlrXV1JsxYTc=;
  b=mWPU/IGSmd9dXAQEoPw/AWm42YieklVTTbJo8Aa+6T8xcYflLrwkG+pe
   5fuYFliXGGVXkKCxfbcFLpefBaJYvawZUGvYbvic+a8rYWNIC0NsKEjqi
   vHF6zMIBEihtwiaOPVd01bT4FKeuX26l47s7FZkf2yhKHlrwaoAcxP4Q0
   YOawdjjzxYlJi/1JDLBcWFGDBbyck7Ua9g/FsPlJ2QhF1YTBY1etPaPJq
   ES9OqkodsIeqHHguVGomVuzGqCW5e4nhiCRXmiT6cguerGuHeuFIPG7Tw
   8a8D588fOzFBMN2iglqwpM4SijslqcMlZDFaLXacCsOTxHpU4Qo//iu/R
   A==;
X-CSE-ConnectionGUID: V5i9HNfPR0iFBEgNSdS2QQ==
X-CSE-MsgGUID: BX6k5LuZT1ytoW5Cs0tsPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="63488032"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="63488032"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:26:13 -0800
X-CSE-ConnectionGUID: PHiHpXemQRq6zbcoQudtdA==
X-CSE-MsgGUID: +tqM9EucTUKBlk9KS9eT2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="115474920"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.60.175]) ([10.247.60.175])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:26:05 -0800
Message-ID: <fbcbfdc4-5f20-4dbc-9e46-e9c28fc399c8@linux.intel.com>
Date: Sat, 22 Feb 2025 08:26:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v5 1/9] net: ethtool: mm: extract stmmac
 verification logic into common library
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Furong Xu <0x1207@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
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
References: <20250220025349.3007793-1-faizal.abdul.rahim@linux.intel.com>
 <20250220025349.3007793-2-faizal.abdul.rahim@linux.intel.com>
 <20250221174249.000000cc@gmail.com> <20250221095651.npjpkoy2y6nehusy@skbuf>
 <20250221182409.00006fd1@gmail.com> <20250221104333.6s7nvn2wwco3axr3@skbuf>
 <3fbe3955-48b8-449d-93ff-2699a7efcd8d@linux.intel.com>
 <20250221144402.6nuuosfjmo5tqgmj@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250221144402.6nuuosfjmo5tqgmj@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/2/2025 10:44 pm, Vladimir Oltean wrote:
> On Fri, Feb 21, 2025 at 09:30:09PM +0800, Abdul Rahim, Faizal wrote:
>> On 21/2/2025 6:43 pm, Vladimir Oltean wrote:
>>> On Fri, Feb 21, 2025 at 06:24:09PM +0800, Furong Xu wrote:
>>>> Your fix is better when link is up/down, so I vote verify_enabled.
>>>
>>> Hmmm... I thought this was a bug in stmmac that was carried over to
>>> ethtool_mmsv, but it looks like it isn't.
>>>
>>> In fact, looking at the original refactoring patch I had attached in
>>> this email:
>>> https://lore.kernel.org/netdev/20241217002254.lyakuia32jbnva46@skbuf/
>>>
>>> these 2 lines in ethtool_mmsv_link_state_handle() didn't exist at all.
>>>
>>> 	} else {
>>>>>>> 		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
>>>>>>> 		mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;
>>>
>>> 		/* No link or pMAC not enabled */
>>> 		ethtool_mmsv_configure_pmac(mmsv, false);
>>> 		ethtool_mmsv_configure_tx(mmsv, false);
>>> 	}
>>>
>>> Faizal, could you remind me why they were added? I don't see this
>>> explained in change logs.
>>>
>>
>> Hi Vladimir,
>>
>> Yeah, it wasn’t there originally. I added that change because it failed the
>> link down/link up test.
>> After a successful verification, if the link partner goes down, the status
>> still shows ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED, which isn’t correct—so
>> that’s why I added it.
>>
>> Sorry for not mentioning it earlier. I assumed you’d check the delta between
>> the original patch and the upstream one, my bad, should have mentioned this
>> logic change.
>>
>> Should I update it to the latest suggestion?
> 
> Never, ever modify logic in the same commit as you are moving code.
> I was wondering what's with the Co-developed-by: tags, but I had just
> assumed fixups were made to code I had improperly moved because I
> didn't have hardware to test. Always structure patches to be one single
> logical change per patch, well justified and trivially correct.

Got it, sorry about that.

> I had assumed, in good faith, changes like this wouldn't sneak in, but I
> guess thanks for letting me know I should check next time :)
> 
> I think it's a slightly open question which state should the verification
> be in when the link fails, but in any case, your argument could be made
> that the state of the previous verification should be lost.
> 
> If I look at figure 99-8 in the Verify state diagram, I see that
> whenever the condition "begin || link_fail || disableVerify || !pEnable"
> is true, we transition to the state INIT_VERIFICATION. From there, there
> is a UCT (unconditional transition) to VERIFICATION_IDLE, and from there,
> a transition to state SEND_VERIFY based on "pEnable && !disableVerify".
> In principle what this is telling me is that as long as management
> software doesn't set pEnable (tx_enable in Linux) to false, verification
> would be attempted even with link down, and should eventually fail.
> 
> But the mmsv state machine does call ethtool_mmsv_configure_tx(mmsv, false),
> and in that case, if I were to interpret the standard state machine very
> strictly, it would remain blocked in state VERIFICATION_IDLE until a
> link up (thus, we should report the state as "verifying").
> 
> But, to be honest, I think the existence of the VERIFICATION_IDLE state
> doesn't make a lot of sense. The state machine should just transition on
> "!link_fail && !disable_verify && pEnable" to SEND_VERIFY directly, and
> from state WAIT_FOR_RESPONSE it should cycle back to SEND_VERIFY if the
> verify timer expired but we still have retries, or to INIT_VERIFICATION
> if link_fail, disableVerify or pEnable change. One more reason why I
> believe the VERIFICATION_IDLE state is redundant and under-specified is
> because it gives the user no chance to even _see_ the "initial" state
> being reported ever, given the unconditional transition to VERIFICATION_IDLE.
> 
> So in that sense, I agree with your proposal, and in terms of code,
> I would recommend just this:
> 
>   } else {
> +	/* Reset the reported verification state while the link is down */
> +	if (mmsv->verify_enabled)
> +		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
>   
>   	/* No link or pMAC not enabled */
>   	ethtool_mmsv_configure_pmac(mmsv, false);
>   	ethtool_mmsv_configure_tx(mmsv, false);
>   }
> 
> Because this is just for reporting to user space, resetting
> "mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;" doesn't matter,
> we'll do it on link up anyway.
> 
> Also note that there's no ternary operator like in the discussion with
> Furong. If mmsv->verify_enabled is false, the mmsv->status should
> already be DISABLED, no need for us to re-assign it.
> 

Will update, thanks.


