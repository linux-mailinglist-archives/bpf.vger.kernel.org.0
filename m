Return-Path: <bpf+bounces-63606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F721B08FB2
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38E51C417D4
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29982F7D0A;
	Thu, 17 Jul 2025 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPXbbj3m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E229ACCC;
	Thu, 17 Jul 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763253; cv=none; b=jCoF0fATQopYqcIMhE790eJPl+ts8ZH5zMH7PfS+zsbvamjJAVQo1SGaFsY7uYm4FNKS5Oqw/sD9pFeXAac9hJTmSjH/hj1cqiBXE8aoxPKjLxTmKafn/DHwgL0Y1RhuCAFUFDhBhT5V1rMNJyulYEshqLnpLrF6Dgl9CK+ZFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763253; c=relaxed/simple;
	bh=bpWidnBpLifO5P1O5LA1/myCspMXXfq7Rf8rUup5noc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvRLgbl0FUoTg6zxLLvOclpfDWhkQeI6lBePzR8LTZgzGD8eAEfy8YT00r8lV7m56+ilZv6mLuO+I0gzsXsh7GuYvp/RNOgIqZv08IrOcVLRdPQ0BQ8XkakwXOYObxkfQi3q45XkLyM9P4GFKY8feoDly+U/Sl2I6Dlm1EP+TOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPXbbj3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60F6C4CEE3;
	Thu, 17 Jul 2025 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763252;
	bh=bpWidnBpLifO5P1O5LA1/myCspMXXfq7Rf8rUup5noc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XPXbbj3mVzfAxdH3n4ny9Wp7FtY4k82PPbnYItf8Z6JJw1nsY0r7QwzuDGEhAnoqs
	 ZUBaNNC+SIObdXT7sV9o8QWqDl18W/H0z8cwF7iw9Vzky5maZM0hSEWei4zbDg9TLZ
	 fslYEOp3QblKMAcVPAoGubIHloVu2Wb780x2boOlhrZ238WV3p14+6Jbwchu7Zx/g4
	 WnTUpJ8foDZiV1n+Mpv0uvktkD9BJelbdkYzfrN5wQQCYXCoxorWIVp4mmJrrxxosF
	 MXzsUQWxHVIXIDaUzsZGGzTsKpelWNqMo17sRHIJptL+s2jTpgZhnXy5wD9rVsK2jo
	 Qc7+qsS4G8nNw==
Message-ID: <d0561121-3d36-4c55-8dbb-fc6b802a0f68@kernel.org>
Date: Thu, 17 Jul 2025 16:40:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V2 1/7] net: xdp: Add xdp_rx_meta structure
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <borkmann@iogearbox.net>, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
 <175146829944.1421237.13943404585579626611.stgit@firesoul>
 <87v7nrdvi8.fsf@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87v7nrdvi8.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2025 11.19, Jakub Sitnicki wrote:
> On Wed, Jul 02, 2025 at 04:58 PM +02, Jesper Dangaard Brouer wrote:
>> From: Lorenzo Bianconi <lorenzo@kernel.org>
>>
>> Introduce the `xdp_rx_meta` structure to serve as a container for XDP RX
>> hardware hints within XDP packet buffers. Initially, this structure will
>> accommodate `rx_hash` and `rx_vlan` metadata. (The `rx_timestamp` hint will
>> get stored in `skb_shared_info`).
>>
>> A key design aspect is making this metadata accessible both during BPF
>> program execution (via `struct xdp_buff`) and later if an `struct
>> xdp_frame` is materialized (e.g., for XDP_REDIRECT).
>> To achieve this:
>>    - The `struct xdp_frame` embeds an `xdp_rx_meta` field directly for
>>      storage.
>>    - The `struct xdp_buff` includes an `xdp_rx_meta` pointer. This pointer
>>      is initialized (in `xdp_prepare_buff`) to point to the memory location
>>      within the packet buffer's headroom where the `xdp_frame`'s embedded
>>      `rx_meta` field would reside.
>>
>> This setup allows BPF kfuncs, operating on `xdp_buff`, to populate the
>> metadata in the precise location where it will be found if an `xdp_frame`
>> is subsequently created.
>>
>> The availability of this metadata storage area within the buffer is
>> indicated by the `XDP_FLAGS_META_AREA` flag in `xdp_buff->flags` (and
>> propagated to `xdp_frame->flags`). This flag is only set if sufficient
>> headroom (at least `XDP_MIN_HEADROOM`, currently 192 bytes) is present.
>> Specific hints like `XDP_FLAGS_META_RX_HASH` and `XDP_FLAGS_META_RX_VLAN`
>> will then denote which types of metadata have been populated into the
>> `xdp_rx_meta` structure.
>>
>> This patch is a step for enabling the preservation and use of XDP RX
>> hints across operations like XDP_REDIRECT.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   include/net/xdp.h       |   57 +++++++++++++++++++++++++++++++++++------------
>>   net/core/xdp.c          |    1 +
>>   net/xdp/xsk_buff_pool.c |    4 ++-
>>   3 files changed, 47 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>> index b40f1f96cb11..f52742a25212 100644
>> --- a/include/net/xdp.h
>> +++ b/include/net/xdp.h
>> @@ -71,11 +71,31 @@ struct xdp_txq_info {
>>   	struct net_device *dev;
>>   };
>>   
>> +struct xdp_rx_meta {
>> +	struct xdp_rx_meta_hash {
>> +		u32 val;
>> +		u32 type; /* enum xdp_rss_hash_type */
>> +	} hash;
>> +	struct xdp_rx_meta_vlan {
>> +		__be16 proto;
>> +		u16 tci;
>> +	} vlan;
>> +};
>> +
>> +/* Storage area for HW RX metadata only available with reasonable headroom
>> + * available. Less than XDP_PACKET_HEADROOM due to Intel drivers.
>> + */
>> +#define XDP_MIN_HEADROOM	192
>> +
>>   enum xdp_buff_flags {
>>   	XDP_FLAGS_HAS_FRAGS		= BIT(0), /* non-linear xdp buff */
>>   	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
>>   						   * pressure
>>   						   */
>> +	XDP_FLAGS_META_AREA		= BIT(2), /* storage area available */
> 
> Idea: Perhaps this could be called *HW*_META_AREA to differentiate from
> the existing custom metadata area:
> 

I agree, that calling it META_AREA can easily be misunderstood and 
confused with metadata or data_meta.

What do you think about renaming this to "hints" ?
  E.g. XDP_FLAGS_HINTS_AREA
  or   XDP_FLAGS_HINTS_AVAIL

And also renaming XDP_FLAGS_META_RX_* to
  e.g XDP_FLAGS_META_RX_HASH -> XDP_FLAGS_HINT_RX_HASH
                            or  XDP_FLAGS_HW_HINT_RX_HASH

> https://docs.kernel.org/networking/xdp-rx-metadata.html#af-xdp
> 
>> +	XDP_FLAGS_META_RX_HASH		= BIT(3), /* hw rx hash */
>> +	XDP_FLAGS_META_RX_VLAN		= BIT(4), /* hw rx vlan */
>> +	XDP_FLAGS_META_RX_TS		= BIT(5), /* hw rx timestamp */
>>   };
>>   
> 
> [...]

