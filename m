Return-Path: <bpf+bounces-73375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FA1C2DB58
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 19:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 462E434B083
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 18:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730FD296BAF;
	Mon,  3 Nov 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="SXN1cVaH"
X-Original-To: bpf@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB21A7AE3
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.0.186.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195253; cv=none; b=EKNdDRmltLxsoNId3ehwmlGKfsvUXuDMUXAYDnWIg95zA1TeCeVU4vCLTMy9oJjas/qLjWMsnI0jY5gnXCQSBVCHHNm7WiMfuUZW7/Q3ERgb+pE8eW8Q1CJG/Elqbv51b7tYZSFX0QixMawgRMMN4o0xF2+e/JhnmEltN8iapNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195253; c=relaxed/simple;
	bh=glFgkj7MjXsOiAWpn6J+km/RtrCJX6sZXCrhNI2Du3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX2bZjd6RMTaw/sa5ipTboVe9Es8xdzkA4CerBLJyutWgbobJiZLcbdzR4V4HTW22JHf6vP0abASsRS4p6LCS9FD23h9JM8eusHdL8DIkAz0ERYYxhGjO1VfvJQknoHz/b3n/nImrYeR/hOV6h/zgaiuSvUXKPvAiPyBM/Z40Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=SXN1cVaH; arc=none smtp.client-ip=142.0.186.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email-od.com
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1762195252; x=1764787252;
	h=content-transfer-encoding:content-type:in-reply-to:from:content-language:references:cc:to:subject:mime-version:date:message-id:x-thread-info:subject:to:from:cc:reply-to;
	bh=U8h7PzoUbT1+X5pM4fvxo+Qt4T0+vhHtCUCRzU9q0Ek=;
	b=SXN1cVaH0PRl4CRiCIHHs3mmwqHSgPgNY9r2VE4wRo3iYVsgpLln9eUL/OEPn9dvR8jLPT6YSRtjlsQWW0q1lpHGlRbWNWizDD+gyd8QnvHLsCRtgo/G4V1AJfZ6tnt5jOX1i5CPTzzkl8TWpOa1Ohfbh83hgpyCepii+7LCTHM=
X-Thread-Info: NDUwNC4xMi44MTkwOTAwMDIyNGRjY2QuYnBmPXZnZXIua2VybmVsLm9yZw==
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from [192.168.0.212] (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPSA id 5F8E12CE0005;
	Mon,  3 Nov 2025 12:40:14 -0500 (EST)
Message-ID: <6c83089b-3e0d-4c72-80a9-8049cff1dd57@nalramli.com>
Date: Mon, 3 Nov 2025 12:40:14 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC ixgbe 1/2] ixgbe: Implement support for ndo_xdp_xmit in skb
 mode
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, lishujin@kuaishou.com,
 xingwanli@kuaishou.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 team-kernel@fastly.com, khubert@fastly.com, nalramli@fastly.com
References: <20251009192831.3333763-1-dev@nalramli.com>
 <20251009192831.3333763-2-dev@nalramli.com> <aQjahdk/fl6EBcso@boxer>
Content-Language: en-US
From: "Nabil S. Alramli" <dev@nalramli.com>
In-Reply-To: <aQjahdk/fl6EBcso@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 11:38, Maciej Fijalkowski wrote:
> On Thu, Oct 09, 2025 at 03:28:30PM -0400, Nabil S. Alramli wrote:
>> This commit adds support for `ndo_xdp_xmit` in skb mode in the ixgbe
>> ethernet driver, by allowing the call to continue to transmit the packets
>> using `dev_direct_xmit`.
>>
>> Previously, the driver did not support the operation in skb mode. The
>> handler `ixgbe_xdp_xmit` had the following condition:
>>
>> ```
>> 	ring = adapter->xdp_prog ? ixgbe_determine_xdp_ring(adapter) : NULL;
>> 	if (unlikely(!ring))
>> 		return -ENXIO;
>> ```
>>
>> That only works in native mode. In skb mode, `adapter->xdp_prog == NULL` so
>> the call returned an error, which prevented the ability to send packets
>> using `bpf_prog_test_run_opts` with the `BPF_F_TEST_XDP_LIVE_FRAMES` flag.
> 
> Hi Nabil,
> 
> What stops you from loading a dummy XDP program to interface? This has
> been an approach that we follow when we want to use anything that utilizes
> XDP resources (XDP Tx queues).
> 

Hi Maciej,

Thank you for your response. In one use case we have multiple XDP programs
already loaded on an interface in SKB mode using the dispatcher, and we want
to use bpf_prog_test_run_opts to egress packets from another XDP program. We
want to avoid having to unload the dispatcher or be forced to use it in native
mode. Without this patch, that does not seem possible currently, correct?

>>
>> Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  8 ++++
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 43 +++++++++++++++++--
>>  2 files changed, 47 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> index e6a380d4929b..26c378853755 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> @@ -846,6 +846,14 @@ struct ixgbe_ring *ixgbe_determine_xdp_ring(struct ixgbe_adapter *adapter)
>>  	return adapter->xdp_ring[index];
>>  }
>>  
>> +static inline
>> +struct ixgbe_ring *ixgbe_determine_tx_ring(struct ixgbe_adapter *adapter)
>> +{
>> +	int index = ixgbe_determine_xdp_q_idx(smp_processor_id());
>> +
>> +	return adapter->tx_ring[index];
>> +}
>> +
>>  static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
>>  {
>>  	switch (adapter->hw.mac.type) {
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 467f81239e12..fed70cbdb1b2 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -10748,7 +10748,8 @@ static int ixgbe_xdp_xmit(struct net_device *dev, int n,
>>  	/* During program transitions its possible adapter->xdp_prog is assigned
>>  	 * but ring has not been configured yet. In this case simply abort xmit.
>>  	 */
>> -	ring = adapter->xdp_prog ? ixgbe_determine_xdp_ring(adapter) : NULL;
>> +	ring = adapter->xdp_prog ? ixgbe_determine_xdp_ring(adapter) :
>> +		ixgbe_determine_tx_ring(adapter);
>>  	if (unlikely(!ring))
>>  		return -ENXIO;
>>  
>> @@ -10762,9 +10763,43 @@ static int ixgbe_xdp_xmit(struct net_device *dev, int n,
>>  		struct xdp_frame *xdpf = frames[i];
>>  		int err;
>>  
>> -		err = ixgbe_xmit_xdp_ring(ring, xdpf);
>> -		if (err != IXGBE_XDP_TX)
>> -			break;
>> +		if (adapter->xdp_prog) {
>> +			err = ixgbe_xmit_xdp_ring(ring, xdpf);
>> +			if (err != IXGBE_XDP_TX)
>> +				break;
>> +		} else {
>> +			struct xdp_buff xdp = {0};
>> +			unsigned int metasize = 0;
>> +			unsigned int size = 0;
>> +			unsigned int truesize = 0;
>> +			struct sk_buff *skb = NULL;
>> +
>> +			xdp_convert_frame_to_buff(xdpf, &xdp);
>> +			size = xdp.data_end - xdp.data;
>> +			metasize = xdp.data - xdp.data_meta;
>> +			truesize = SKB_DATA_ALIGN(xdp.data_end - xdp.data_hard_start) +
>> +				   SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> +
>> +			skb = napi_alloc_skb(&ring->q_vector->napi, truesize);
>> +			if (likely(skb)) {
>> +				skb_reserve(skb, xdp.data - xdp.data_hard_start);
>> +				skb_put_data(skb, xdp.data, size);
>> +				build_skb_around(skb, skb->data, truesize);
>> +				if (metasize)
>> +					skb_metadata_set(skb, metasize);
>> +				skb->dev = dev;
>> +				skb->queue_mapping = ring->queue_index;
>> +
>> +				err = dev_direct_xmit(skb, ring->queue_index);
>> +				if (!dev_xmit_complete(err))
>> +					break;
>> +			} else {
>> +				break;
>> +			}
>> +
>> +			xdp_return_frame_rx_napi(xdpf);
>> +		}
>> +
>>  		nxmit++;
>>  	}
>>  
>> -- 
>> 2.43.0
>>
>>


