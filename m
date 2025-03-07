Return-Path: <bpf+bounces-53569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0348FA5671F
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 12:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7A01899332
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C516E2185AC;
	Fri,  7 Mar 2025 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXI7ahFk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A520E302;
	Fri,  7 Mar 2025 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348367; cv=none; b=BJoP6t49rnit1+fAvgHY76nfLogDYf8YbJRzxo/YxdYFj2g5J7DB79luGhrRoQ+YqE7lG3dxrzCwfUp70oCHcunWUc/ODZrMJQSoR8owQ4CPop0TNQMx0RlDJUnr2Oj1ooGRhf7JiCzNIOPpKJy5AT9vKMsfGulYlkJoFLrfQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348367; c=relaxed/simple;
	bh=HfAgk9zOtpbfUTR/ph6GVkTV0/0ByfBX3QerezGYdeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yn5kFlDx/c1FwfN6BTUHnNR5R2vxq+AfeWvZeZyeJmgn+ovymGcVrS/kAMsvmYst1s3suGULHzwCXY22/hUyi4EkTZ+bRBt49rqvQcMy8F98Tr8lP6sLF/8qkehhwR0lKIU97uSv9/QrN1YoGDKlHNGwmaxpCQJDB0wBHDiMURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXI7ahFk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741348366; x=1772884366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HfAgk9zOtpbfUTR/ph6GVkTV0/0ByfBX3QerezGYdeI=;
  b=gXI7ahFkDyc36jI4fe+aiG62LNdFlP587Y2Dn3SQYFv7bi9tb87npwa1
   Jv/hwwAoHF6NEaHZIFGXa0DZ5qiAbU2Ul59iAgXNrS6X61zscO2cc88u7
   NhZ7uNbFVpeStQqcFrNKlIIRzfhUucpqbksN0Ikqouleu7EDPiCzwJUuN
   d+e+WS5vIhv5Ls/8q0BIvqtl1HUyR1KxzE7m8e2gTyQSQ+RZN6p/PDMQ8
   yrPYIoYORYAb3ox1j19aO1CXtijGHYvpqxkdZHwRxinkeHj90P6/RjvaY
   SfF5YFfmNiwxhiVvfeVXLQYKoXSo2JpTDpwKLhLpTxMNL3whfdNlbQL/e
   A==;
X-CSE-ConnectionGUID: fAoitVxaRMOK3mAL3CkIrA==
X-CSE-MsgGUID: sKCGp9TXTemIKmsg1BLnuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="64834311"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="64834311"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:52:44 -0800
X-CSE-ConnectionGUID: Gq2NhXteTvWPF9+DnKuFJQ==
X-CSE-MsgGUID: opl3JIbRQVSlCkVEbStQSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120226099"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.100.177]) ([10.247.100.177])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:52:36 -0800
Message-ID: <43277258-7100-4230-82da-8a78ad341dde@linux.intel.com>
Date: Fri, 7 Mar 2025 19:52:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v8 07/11] igc: add support for frame preemption
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
 John Fastabend <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Chwee-Lin Choong <chwee.lin.choong@intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-8-faizal.abdul.rahim@linux.intel.com>
 <20250306002825.rva7wjsymmms7kbd@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250306002825.rva7wjsymmms7kbd@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/3/2025 8:28 am, Vladimir Oltean wrote:
> On Wed, Mar 05, 2025 at 08:00:22AM -0500, Faizal Rahim wrote:
>> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>> Co-developed-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
>> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> ---
>> +
>> +static inline bool igc_fpe_is_verify_or_response(union igc_adv_rx_desc *rx_desc,
>> +						 unsigned int size, void *pktbuf)
>> +{
>> +	u32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);
>> +	static const u8 zero_payload[SMD_FRAME_SIZE] = {0};
>> +	int smd;
>> +
>> +	smd = FIELD_GET(IGC_RXDADV_STAT_SMD_TYPE_MASK, status_error);
>> +
>> +	return (smd == IGC_RXD_STAT_SMD_TYPE_V || smd == IGC_RXD_STAT_SMD_TYPE_R) &&
>> +		size == SMD_FRAME_SIZE &&
>> +		!memcmp(pktbuf, zero_payload, SMD_FRAME_SIZE); /* Buffer is all zeros */
> 
> Using this definition...
> 
>> +}
>> +
>> +static inline void igc_fpe_lp_event_status(union igc_adv_rx_desc *rx_desc,
>> +					   struct ethtool_mmsv *mmsv)
>> +{
>> +	u32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);
>> +	int smd;
>> +
>> +	smd = FIELD_GET(IGC_RXDADV_STAT_SMD_TYPE_MASK, status_error);
>> +
>> +	if (smd == IGC_RXD_STAT_SMD_TYPE_V)
>> +		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET);
>> +	else if (smd == IGC_RXD_STAT_SMD_TYPE_R)
>> +		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET);
>> +}
>> @@ -2617,6 +2617,15 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>>   			size -= IGC_TS_HDR_LEN;
>>   		}
>>   
>> +		if (igc_fpe_is_pmac_enabled(adapter) &&
>> +		    igc_fpe_is_verify_or_response(rx_desc, size, pktbuf)) {
> 
> ... invalid SMD-R and SMD-V frames will skip this code block altogether, and
> will be passed up the network stack, and visible at least in tcpdump, correct?
> Essentially, if the link partner would craft an ICMP request packet with
> an SMD-V or SMD-R, your station would respond to it, which is incorrect.
> 
> A bit strange, the behavior in this case seems a bit under-specified in
> the standard, and I don't see any counter that should be incremented.
> 
>> +			igc_fpe_lp_event_status(rx_desc, &adapter->fpe.mmsv);
>> +			/* Advance the ring next-to-clean */
>> +			igc_is_non_eop(rx_ring, rx_desc);
>> +			cleaned_count++;
>> +			continue;
>> +		}
> 
> To fix this, don't you want to merge the unnaturally split
> igc_fpe_is_verify_or_response() and igc_fpe_lp_event_status() into a
> single function, which returns true whenever the mPacket should be
> consumed by the driver, but decides whether to emit a mmsv event on its
> own? Merging the two would also avoid reading rx_desc->wb.upper.status_error
> twice.
> 
> Something like this:
> 
> static inline bool igc_fpe_handle_mpacket(struct igc_adapter *adapter,
> 					  union igc_adv_rx_desc *rx_desc,
> 					  unsigned int size, void *pktbuf)
> {
> 	u32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);
> 	int smd;
> 
> 	smd = FIELD_GET(IGC_RXDADV_STAT_SMD_TYPE_MASK, status_error);
> 	if (smd != IGC_RXD_STAT_SMD_TYPE_V && smd != IGC_RXD_STAT_SMD_TYPE_R)
> 		return false;
> 
> 	if (size == SMD_FRAME_SIZE && mem_is_zero(pktbuf, SMD_FRAME_SIZE)) {
> 		struct ethtool_mmsv *mmsv = &adapter->fpe.mmsv;
> 		enum ethtool_mmsv_event event;
> 
> 		if (smd == IGC_RXD_STAT_SMD_TYPE_V)
> 			event = ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET;
> 		else
> 			event = ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET;
> 
> 		ethtool_mmsv_event_handle(mmsv, event);
> 	}
> 
> 	return true;
> }
> 
> 		if (igc_fpe_is_pmac_enabled(adapter) &&
> 		    igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf)) {
> 			/* Advance the ring next-to-clean */
> 			igc_is_non_eop(rx_ring, rx_desc);
> 			cleaned_count++;
> 			continue;
> 		}
> 
> [ also remark the use of mem_is_zero() instead of memcmp() with a buffer
>    pre-filled with zeroes. It should be more efficient, for the simple
>    reason that it's accessing a single memory buffer and not two. Though
>    I'm surprised how widespread the memcmp() pattern is throughout the
>    kernel. ]

Thanks for the suggestion—it reads much better and flows smoothly. Got it 
on the driver needing to consume a non-zero packet buffer from SMD-V and SMD-R.

