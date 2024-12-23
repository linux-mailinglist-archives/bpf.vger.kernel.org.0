Return-Path: <bpf+bounces-47541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817E59FABEE
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 10:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44FB7A12AA
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3121917E6;
	Mon, 23 Dec 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhqnRlMq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E3259489;
	Mon, 23 Dec 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734945818; cv=none; b=ZKDn9egZ9ABtdowRjLYh5U3ViblcRxQ4ai5xUvZ2Ct/MAh21+XvWLEkB0hrrtB02Uk+tKU+xKejt3iuEQH1BMq/RQc838azelHUy6329nMK2R0xDmswJU5xsN58OqRf9mLBaclGErRi9pP5L5SsGXGIyrIgXR1q/huoh16WhqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734945818; c=relaxed/simple;
	bh=NOgNNrM3BWUsucXKrh8CtWNXkv+qSrOnDFok2szQa+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpSI26uRiYwJ6oe+tsIUy68MswYJNQfFiV5FuSuv0iWjG+hLm63EIZOQYXsPbZhJZbp34EYkn/9OSENiD3UUq+Y4p07s2XE4vHSj4+gu7wo5NOH56Q6qDDZci5iFaOV2+VhD16cxK9+PaIjkwTKWRhMvwt3UnDGNLkR53b8uycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhqnRlMq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734945815; x=1766481815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NOgNNrM3BWUsucXKrh8CtWNXkv+qSrOnDFok2szQa+s=;
  b=hhqnRlMqBnweHkQpmBFbfq0tx0QDKZNZrnpZOLvmeGm2B98N5VtkOaFZ
   9XWqD/wgM/zYjQri2XzEOW28fVcrdtK02f5MJaX1PPZaNvjoB1f99owgQ
   lE7n86HcyK4TwA9yl2z73YMM1qG4xh12ZZFaNJMT17MukfduUIuI/VoE3
   MzHx9/HctI9ehW/mXwtsOS0cFfArO2ei0HmC87bxhtnjlOqoDvkfQoK48
   wRPAK9++QlR4/NK715GNLRJk4dFU4D44+IL1OrhUirZ8DrnH7LuQGfNMp
   5kfs8Q4ffjoUnm63E8Mc4JrDtaxhZcNJdpVWsxMCB2+hmsM0WhYZyFG0c
   w==;
X-CSE-ConnectionGUID: 1Zr0aLYcRlOow57N/c44WA==
X-CSE-MsgGUID: Hv7XxniVQYeOPRrzrKnhAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="39342513"
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="39342513"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 01:23:34 -0800
X-CSE-ConnectionGUID: XpVJBZqeTji3kMi+jNQG4A==
X-CSE-MsgGUID: kg2Y2h+sTlqcGvVMNLXWnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122435984"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.22.166]) ([10.247.22.166])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 01:23:30 -0800
Message-ID: <ef07ba7e-eb61-495b-8abc-a46d675302d4@linux.intel.com>
Date: Mon, 23 Dec 2024 17:23:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 5/9] igc: Add support to set MAC Merge data via
 ethtool
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-6-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-6-faizal.abdul.rahim@linux.intel.com>
 <20241216181339.zcnnqna2nc73sdgh@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20241216181339.zcnnqna2nc73sdgh@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Vladimir,

On 17/12/2024 2:13 am, Vladimir Oltean wrote:
> On Mon, Dec 16, 2024 at 01:47:16AM -0500, Faizal Rahim wrote:
>> Created fpe_t struct to store MAC Merge data and implement the
>> "ethtool --set-mm" callback. The fpe_t struct will host other frame
>> preemption related data in future patches.
>>
>> The following fields are used to set IGC register:
>> a) pmac_enabled -> TQAVCTRL.PREEMPT_ENA
>>     This global register sets the preemption scheme, controlling
>>     preemption capabilities in transmit and receive directions, as well as
>>     the verification handshake capability.
> 
> I'm sorry, I'm not able to mentally translate this explanation into
> something technical. Which capabilities are we talking about, that this
> bit controls? I'm not clear what it does. The kernel-doc description of
> pmac_enabled is much more succinct (and at the same time, appears to
> contradict this much more elaborate yet unclear description).
> 

Sorry for the unclear explanation, I was having trouble summarizing what it 
does.

Snippets of what TQAVCTRL.PREEMPT_ENA does from i226 documentation:

RX:
When preemption is enabled by the PREEMPT_ENA flag in TQAVCTRL register, 
Express traffic is routed to the high priority packet buffer and Best 
Effort traffic is routed to the low priority packet buffer.				
The receive unit re-assemble the received fragments back to whole packets. 
It classifies the incoming mPackets as whole packets or packets fragments 
that should be re-assembled. Classification is done based on the SMD, 
Fragment Count and the CRC. Foxville categorizes received packets by SMD 
only when preemption is enabled by the TQAVCTRL.PREEMPT_ENA.

TX:
TQAVCTRL.PREEMPT_ENA (Enables the transmit preemption state machine): This 
is a dynamic parameter that can be set while the transmit unit is active. 
Setting takes affect at whole packet boundaries.
Preemptable: Each transmit queue can be set as Preemptive - eTXQ for 
express traffic or Preemptable pTXQ for non-Express traffic. The pTXQs can 
be preempted by The eTXQs when preemption is enabled by the 
TQAVCTRL.PREEMPT_ENA


Based on my testing, this register bit needs to be enabled for the i226 to 
receive verify/response frames, which is why I added the phrase 
"verification handshake capability."

Do you think I should omit the explanation of TQAVCTRL.PREEMPT_ENA ?
Or would it be better for me to attempt to summarize it more clearly in the 
next version? Hmmm.


>> b) tx_min_frag_size -> TQAVCTRL.MIN_FRAG
>>     Global register to set minimum fragments.
> 
> When you say "global register", you mean global as opposed to what?
> Per station interface?

As opposed to something like a "queue context parameter".
In the i226 documentation, the terms "global parameter" and "queue context 
parameter" are commonly used. "Global" refers to NIC-wide settings, whereas 
"queue context" refers to parameters specific to a particular TX queue. I 
thought it would be useful to highlight this distinction for the reader, 
and it aligns with the style of explanation used in the i226 documentation.

Would it be better to remove the word "Global"?

>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index 817838677817..1954561ec4aa 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> @@ -8,6 +8,7 @@
>>   
>>   #include "igc.h"
>>   #include "igc_diag.h"
>> +#include "igc_tsn.h"
>>   
>>   /* forward declaration */
>>   struct igc_stats {
>> @@ -1781,6 +1782,34 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
>>   	return 0;
>>   }
>>   
>> +static int igc_ethtool_set_mm(struct net_device *netdev,
>> +			      struct ethtool_mm_cfg *cmd,
>> +			      struct netlink_ext_ack *extack)
>> +{
>> +	struct igc_adapter *adapter = netdev_priv(netdev);
>> +	struct fpe_t *fpe = &adapter->fpe;
>> +
>> +	if (cmd->tx_min_frag_size < IGC_TX_MIN_FRAG_SIZE ||
>> +	    cmd->tx_min_frag_size > IGC_TX_MAX_FRAG_SIZE)
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Invalid value for tx-min-frag-size");
> 
> Shouldn't the execution actually stop here with an error code?
> 
I initially stop execution, but then I figured if the other parameters are 
set correctly, the feature could still work since this field has a valid 
default value set.

I'll update it to stop execution then.

>> +	else
>> +		fpe->verify_time = cmd->verify_time;
>> +
>> +	fpe->tx_enabled = cmd->tx_enabled;
>> +	fpe->pmac_enabled = cmd->pmac_enabled;
>> +	fpe->verify_enabled = cmd->verify_enabled;
>> +
>> +	return igc_tsn_offload_apply(adapter);
> 
> hmm, igc_tsn_offload_apply() is a function which always returns zero.
> It seems more natural to make it return void.
> 

You mean, to make igc_tsn_offload_apply() return void ?

Currently, igc_tsn_offload_apply() calls igc_tsn_reset(), which can return 
a non-zero value, but igc_tsn_offload_apply() doesn't use that result and 
always returns zero. It seems more logical to modify 
igc_tsn_offload_apply() to handle the return value from igc_tsn_reset().

What do you think ?

But... should this change be in this series though ?


>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> index 5cd54ce435b9..b968c02f5fee 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> @@ -194,12 +210,22 @@ static void igc_tsn_set_retx_qbvfullthreshold(struct igc_adapter *adapter)
>>   	wr32(IGC_RETX_CTL, retxctl);
>>   }
>>   
>> +static u8 igc_fpe_get_frag_size_mult(const struct fpe_t *fpe)
>> +{
>> +	u32 tx_min_frag_size = fpe->tx_min_frag_size;
>> +	u8 mult = (tx_min_frag_size / 64) - 1;
>> +
>> +	return clamp_t(u8, mult, IGC_MIN_FOR_TX_MIN_FRAG,
>> +		       IGC_MAX_FOR_TX_MIN_FRAG);
>> +}
> 
> If you translate the continuous range of TX fragment sizes into
> discrete multipliers because that's what the hardware works with, why
> don't you just reject the non-multiple values using
> ethtool_mm_frag_size_min_to_add(), and at the same time use the output
> of that function directly to obtain your multiplier? IIUC it gets you
> the same result.
> 

Yeah, I can reuse ethtool_mm_frag_size_min_to_add(), but it will need some 
modifications. See my reply below

>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
>> index 98ec845a86bf..08e7582f257e 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_tsn.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
>> @@ -4,6 +4,15 @@
>>   #ifndef _IGC_TSN_H_
>>   #define _IGC_TSN_H_
>>   
>> +/* IGC_TX_MIN_FRAG_SIZE is based on the MIN_FRAG field in Section 8.12.2 of the
>> + * SW User Manual.
>> + */
>> +#define IGC_TX_MIN_FRAG_SIZE		68
>> +#define IGC_TX_MAX_FRAG_SIZE		260
> 
> Odd. Is there a link to this manual (for I225 I suppose)? Standard values are 60, 124, 188, 252.
> Maybe the methodology for calculating these is used here? As things stand,
> if the driver reports these values, IIUC, openlldp gets confused and communicates
> a LLDP_8023_ADD_ETH_CAPS_ADD_FRAG_SIZE value to the link partner which is higher
> than it could have been (68 is rounded up to the next standard TX fragment size,
> which is 124). So the link partner will preempt in larger chunks and this will
> not reduce latency as much.
>> Regarding the TX minimum fragment size, I’m currently looking into it. After
>> speaking with the i226 hardware owners (Shalev Avi), I realized I may have
>> misunderstood the fragment size details. Avi mentioned that the i226
>> supports fragment sizes of 64, 128, 192, and 256 bytes (without mCRC).
>> However, these values are still 4 bytes larger than the standard you
>> mentioned.
> 
> Yes, the standard I mention is 802.1Q section 99.4.4 Transmit processing:
> 
> The earliest starting position of preemption is controlled by the addFragSize
> variable. Preemption does not occur until at least 64 x (1 + addFragSize) – 4
> octets of the preemptable frame have been sent. The addFragSize variable is set
> to the value of the addFragSize field in the received Additional Ethernet
> Capabilities TLV (see 79.3.7).
> 
> The preemptableFragSize state machine variable says that the MAC can
> preempt as soon as enough octets have been put on to wire so as to have
> a fixed minimum length (by default, a valid Ethernet packet). You're
> saying that the i226 MAC performs preemption at least 4 octets later
> than the standard says it could.
> 
>> Avi provided the following explanation for these sizes:
>>
>> "The i226 always performs preemption on 16-byte boundaries. Once we read a
>> 16-byte line from the internal packet buffer memory, we transmit it entirely
>> before deciding on preemption. This avoids keeping partial bytes from the
>> 16-byte line, ensuring that we continue with the preempted frame only after
>> finishing the current 16-byte line."
> 
> User space assumes that, when it gets an addFragSize over LLDP from the
> link partner, it can program the local transmitter to preempt at that
> fragment size, and that the operation will succeed. The formula to
> translate from addFragSize to preemptableFragSize is standard. There is
> no mechanism built into the UAPI for user space to guess, if programming
> a standard value failed, what other custom value could work.
> 
> I guess that leaves 2 options:
> (1) accept and report the standard values, but "secretly" preempt later
>      than expected
> (2) accept any values in the discrete range, and round them up to the
>      first value supported by the NIC, then report that non-standard
>      value. Then keep this as a quirk isolated to the current generation
>      of NICs, and be better with new drivers which accept standard values
>      and don't do any rounding.
> 
> I think I prefer seeing the latter variant. I'm trying to think if this
> is going to cause problems with openlldp or with the lldp_change_add_frag_size()
> selftest, but I think it's generally safe. That test only checks that
> LLDP reacts to the addFragSize of the link partner by programming its
> local addFragSize to the same value. It doesn't check that the
> tx-min-frag-size is exactly equal to the formula derived from that
> addFragSize.

Thanks for the suggestion! I was actually about to suggest option 2 myself, 
but you got there first.

To recap:

Standard range: 60, 124, 188, 252 (without mCRC).
i226 range: 64, 128, 192, 256 (without mCRC).

The current IGC_TX_MIN_FRAG_SIZE is incorrectly set to 68 due to our 
misinterpretation of the i226 documentation:
"The minimum size for non-final preempted fragments is 64 * (1 + MIN_FRAG) 
+ 4 (mCRC)."

The calculation above is for the fragment size on the wire, including mCRC. 
For the TX preemption point and pure fragment size, mCRC should not be 
included, as confirmed by the hardware owner.

On RX, i226 can handle any size, even the standard minimum of 60 octets 
(without mCRC).

What would be ideal for i226:
Min frag user set 60:64 → Multiplier = 0.
Min frag user set 65:128 → Multiplier = 1.
(And so on)

To make this work and reuse the existing code, we’d need to tweak these two 
functions:
ethtool_mm_frag_size_add_to_min(val_min, xxx)
ethtool_mm_frag_size_min_to_add(xx)

With the current code, if I pass 64 octets as val_min to 
ethtool_mm_frag_size_add_to_min(), it returns error.

Proposed modification:
Add a new parameter to ethtool_mm_frag_size_min_to_add() - maybe let's call 
it dev_min_tx_frag_len.

Set dev_min_tx_frag_len = 64 for i226, 60 for other drivers.
This field will be used to:
(1) modify the calculation in ethtool_mm_frag_size_min_to_add()
(2) as a warning prompt to user when the value is not standard, done in 
ethtool_mm_frag_size_add_to_min()

I was thinking (1) would modify the existing:
u32 ethtool_mm_frag_size_add_to_min(u32 val_add)
{
	return (ETH_ZLEN + ETH_FCS_LEN) * (1 + val_add) - ETH_FCS_LEN;
}

To something like:
u32 ethtool_mm_frag_size_add_to_min(u32 val_add, u32 dev_min_tx_frag_len)
{
     return dev_min_tx_frag_len + (val_add * 64);
}

So this will yield:
Standard range (dev_min_tx_frag_len = 60): 60, 124, 188, 252
i226 range (dev_min_tx_frag_len = 64): 64, 128, 192, 256

But what's not so nice is, the rest of other drivers have to set this new 
param when calling ethtool_mm_frag_size_add_to_min().

Is something like this okay ? I'm open to better suggestion.



