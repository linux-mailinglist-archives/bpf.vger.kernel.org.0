Return-Path: <bpf+bounces-63421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBBCB0719A
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 11:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03A77A2EB2
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DF62EFDBE;
	Wed, 16 Jul 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV8QBgOV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8842F0059;
	Wed, 16 Jul 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657989; cv=none; b=qJFg1MGkV3UtkEjffvrhw67dmUvYgZwCSlKr8bJmnECMFhrh6mZsFyTCLt1QMtasl/UWmVbxlXiRHUjPkPOpoeHP5Lm93JdGIAlImRLh5w6cjMDoI1dX8xwwqPcRPxH/7q9RaQKPokJnM7psUzJx0agFTXq/izqJNpC5cksQ2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657989; c=relaxed/simple;
	bh=rZFV7iCiwcCgWnCKhjPZ1zpfN5fAxekeaBpaYqRspxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqYfwCzA29e73UvntFaP32QPy2L4dzCL6ZkicygAWDBd4Qb3m8QY+te0jfxZK19zaICAGMehoOErVt8z2/r71omSBxEDQaDz29jAq58+TiXOa6BE6Wc4WS0V+jFPs5NiveMthzcXWMoI94cQqx0vLbS0i3iTot7aa6u3K3rUKsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV8QBgOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ECEC4CEF0;
	Wed, 16 Jul 2025 09:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752657988;
	bh=rZFV7iCiwcCgWnCKhjPZ1zpfN5fAxekeaBpaYqRspxc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GV8QBgOVbpAs4HDllMV5uCVc8Pw02E4JwJg9Au3KHZbyiDW+E9qegDcLn8mXH6p1s
	 jV1ElzA9RiOwwq3eoa+id2OmrJLN6+BEKV2CbSPBW1ClcaVWWNyTFfrTRRUW0ikyWc
	 5NAoJJ089zojD4qGVqsDsUIJbw2SI5ZkNsvzK0W9L47Fz9v5HOLtmTGJu7hgfJ0cJp
	 w09LGsjhtiT+DG2kdXS8t25D15W4/smfKkrhLT8HxVsIYQZN+d+1o8r3NW6AnbCdFu
	 EN9SWpOz7qD4cHtwLuZa3c4LUE7koGsd0THT3xzGjcM2+coQyzQM5zEP57HEtpiZ/z
	 5i3CZnvLd9V2g==
Message-ID: <d0c8c1ce-5bb2-45f5-9d7f-fac734dcfe31@kernel.org>
Date: Wed, 16 Jul 2025 11:26:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4] net: track pfmemalloc drops via
 SKB_DROP_REASON_PFMEMALLOC
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 kernel-team@cloudflare.com, mfleming@cloudflare.com
References: <175146472829.1363787.9293177520571232738.stgit@firesoul>
 <20250707174346.2211c46a@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250707174346.2211c46a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/07/2025 02.43, Jakub Kicinski wrote:
> On Wed, 02 Jul 2025 15:59:19 +0200 Jesper Dangaard Brouer wrote:
>> Add a new SKB drop reason (SKB_DROP_REASON_PFMEMALLOC) to track packets
>> dropped due to memory pressure. In production environments, we've observed
>> memory exhaustion reported by memory layer stack traces, but these drops
>> were not properly tracked in the SKB drop reason infrastructure.
>>
>> While most network code paths now properly report pfmemalloc drops, some
>> protocol-specific socket implementations still use sk_filter() without
>> drop reason tracking:
>> - Bluetooth L2CAP sockets
>> - CAIF sockets
>> - IUCV sockets
>> - Netlink sockets
>> - SCTP sockets
>> - Unix domain sockets
> 
>> @@ -1030,10 +1030,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>   	}
>>   
>>   	if (tfile->socket.sk->sk_filter &&
>> -	    sk_filter(tfile->socket.sk, skb)) {
>> -		drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
>> +	    (sk_filter_reason(tfile->socket.sk, skb, &drop_reason)))
> 
> why the outside brackets?
> 

Good catch, yes the brackets are unnecessary, will remove in V5.

>> @@ -591,6 +592,10 @@ enum skb_drop_reason {
>>   	 * non conform CAN-XL frame (or device is unable to receive CAN frames)
>>   	 */
>>   	SKB_DROP_REASON_CANXL_RX_INVALID_FRAME,
>> +	/**
>> +	 * @SKB_DROP_REASON_PFMEMALLOC: dropped when under memory pressure
> 
> I guess kinda, but in practice not very precise?
> 
> How about: packet allocated from memory reserve reached a path or
> socket not eligible for use of memory reserves.
> 

I like it, this is a good description, thanks! :-)

> I could be misremembering the meaning of "memory reserve" TBH.
> 
>> +	 */
>> +	SKB_DROP_REASON_PFMEMALLOC,
>>   	/**
>>   	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>>   	 * shouldn't be used as a real 'reason' - only for tracing code gen
> 
>> -	if (unlikely(sk_add_backlog(sk, skb, limit))) {
>> +	if (unlikely((err = sk_add_backlog(sk, skb, limit)))) {
> 
> I understand the else if () case but here you can simply:
> 
> 	err = sk_add_backlog(sk, skb, limit);
> 	if (unlikely(err))

Agreed, will fix in V5.

> no need to make checkpatch upset.
> 
>> @@ -162,7 +163,7 @@ static int rose_state3_machine(struct sock *sk, struct sk_buff *skb, int framety
>>   		rose_frames_acked(sk, nr);
>>   		if (ns == rose->vr) {
>>   			rose_start_idletimer(sk);
>> -			if (sk_filter_trim_cap(sk, skb, ROSE_MIN_LEN) == 0 &&
>> +			if (sk_filter_trim_cap(sk, skb, ROSE_MIN_LEN, &dr) == 0 &&
> 
> let's switch to negation rather than comparing to 0 while at it?
> otherwise we run over 80 chars
> 

Sure I will adjust code.

>>   			    __sock_queue_rcv_skb(sk, skb) == 0) {
>>   				rose->vr = (rose->vr + 1) % ROSE_MODULUS;
>>   				queued = 1;

--Jesper

