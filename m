Return-Path: <bpf+bounces-56257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8AAA93EAB
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D5A3BEEE2
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 20:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B286722D7AB;
	Fri, 18 Apr 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy17wIAw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298981B4243;
	Fri, 18 Apr 2025 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006891; cv=none; b=Lmg+RtjdN3s8DDwDldOggZ4e3911NMUIBOz25Vi5O1ruCMrnY0Txk3gS5JhDI84bVHuML2RsMtdrNysXVNrE/NvKj4LEJVLdFNi6tNr5W2ZCJue2KQCk8jT3WJjCUb0nYFxpL0st3O0qO4r5TxI6bDxT49EycLgmzQk7C8LNO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006891; c=relaxed/simple;
	bh=0ocz98/xK/N6V2PmfKx8ugmIQC4yHJEOYGGLuWJ6Pt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFgeSsH8obihnTUg45IyqCsBPA7MkZZdB5YxYHBbTBFAG5c7+ePNagjSC27Ks2QWtS0pIdh4OoWYFX55EwEGqXDa8sXJEFt+3p9MG/JnuphxWx/W108kDYUDfHGAAJEMcsjU0fOOjMukebCMlXK5Ns9mCtsWFc0ZI+Gz+Bvw7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy17wIAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E63C4CEE7;
	Fri, 18 Apr 2025 20:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745006890;
	bh=0ocz98/xK/N6V2PmfKx8ugmIQC4yHJEOYGGLuWJ6Pt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qy17wIAwGhuK9p5LIzKMxtQHQrfc4C+xKeOIvDuoojz5p3b68zmHWqB3dEkDY417i
	 5db4qe0uhaTPTC/+1SsnElTyoVYEAD/VAoVYDV/4DTiHXqKiUfMmLrzmqT1tseVYiZ
	 QUikgUZoRs4FxDZXpxPVozvmO9e45logQ6eLcI6xxrmUGrTitP7YzXD0pSzIjFHMW5
	 U/B+XYv85QC8SF8Wxtw5eDa0dXT/TwmaD9Wq5R6J3CHYi8R39rIOl6EOes9ec5LN9H
	 6vVhWKdYmahYDBVR+ptcj73DbeKVN60Nk1pyV0ExNOqlsaxEf+ajYZe2jAu29jekTv
	 WkBuvvSDkWE6Q==
Message-ID: <e49b96fa-6b2c-4722-adcc-7639f1a9a66a@kernel.org>
Date: Fri, 18 Apr 2025 22:08:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: Toshiaki Makita <toshiaki.makita1@gmail.com>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <174489803410.355490.13216831426556849084.stgit@firesoul>
 <174489811513.355490.8155513147018728621.stgit@firesoul>
 <8265c592-a51f-4b26-9e6d-df69c16aebf4@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <8265c592-a51f-4b26-9e6d-df69c16aebf4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/04/2025 14.38, Toshiaki Makita wrote:
> On 2025/04/17 22:55, Jesper Dangaard Brouer wrote:
> ...
>> +    case NETDEV_TX_BUSY:
>> +        /* If a qdisc is attached to our virtual device, returning
>> +         * NETDEV_TX_BUSY is allowed.
>> +         */
>> +        txq = netdev_get_tx_queue(dev, rxq);
>> +
>> +        if (qdisc_txq_has_no_queue(txq)) {
>> +            dev_kfree_skb_any(skb);
>> +            goto drop;
>> +        }
>> +        netif_tx_stop_queue(txq);
>> +        /* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
>> +        __skb_push(skb, ETH_HLEN);
>> +        if (use_napi)
>> +            __veth_xdp_flush(rq);
>> +        /* Cancel TXQ stop for very unlikely race */
>> +        if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
>> +            netif_tx_wake_queue(txq);
> 
> xdp_ring is only initialized when use_napi is not NULL.
> Should add "if (use_napi)" ?
> 

We actually don't need the "if (use_napi)" check, because this code path
cannot be invoked without use_name set.  This also means the check
before __veth_xdp_flush() is unnecessary.  I still added it, because it
is subtle that this isn't needed and if code change slightly is will be
needed.

Regarding xdp_ring is only initialized when use_napi is not NULL, I'm
considering not adding a if(use_napi) check, because this code path
cannot be called without use_napi is true, and if that change in the
future, then it's better that the code crash.  Different opinions are
welcomed...

> BTW, you added a check for the ring_empty here. so
> 
> if empty:
>    this function starts the queue by itself
> else:
>    it is guaranteed that veth_xdp_rcv() consumes the ring after this point.
>    so the rcv side definitely starts the queue.
> 
> With that, __veth_xdp_flush invocation seems to be unnecessary,
> if your concern is starting the queue.

That is actually correct. I'm trying to catch the race in two different
ways. The __ptr_ring_empty() will be sufficient, to cover both cases.
I'll try to think of a good comment that explains, the parring with the
!__ptr_ring_empty() check in veth_poll().

--Jesper

