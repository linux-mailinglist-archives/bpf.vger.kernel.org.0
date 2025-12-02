Return-Path: <bpf+bounces-75903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C96C9C679
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 18:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744293A7BB0
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB42C0F8E;
	Tue,  2 Dec 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+SqlccW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355E201004;
	Tue,  2 Dec 2025 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696749; cv=none; b=BWHME5SdfZJjHP4WtP7/K+O8pQ6e1eU8FpiYaldZvLZC8pHx1rf0RQi4Ldwe6qZ00ui4FSykVlEGZPOTSC78Jo3kunIZwWEIv6KEpGKecO+f9CarDjeo02+ijveV3iq7V1l1Musur45nrfpyU67P7XFgJwx5YCcSYetSLcvoOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696749; c=relaxed/simple;
	bh=EQlF8JKvmA+R/ZoGQgMxtrT9hlH3Gx80adCz2Z/N7Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n48vRYm72rjKbKVb9zH8DzdszQW4MKRZxbwq6P0QMQh1dJbmT5pUr9E1TM/rYDsetErl3javLBfnen2ndaj/A7z7c4KOEm0q7mHogUV4dchHYgS1ZoshpPEJ3NcVv1OTPJSlwDLVkF2e835T49s2D2OKuaxWOY+EMTUxEOR5HME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+SqlccW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2B7C4CEF1;
	Tue,  2 Dec 2025 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764696748;
	bh=EQlF8JKvmA+R/ZoGQgMxtrT9hlH3Gx80adCz2Z/N7Es=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D+SqlccWWbwYbb3alct9SwSGdx7ey2TIdqVcHS+53TLh9RQWAvYxfsNAICuhfJnO/
	 G2zqHeWCj2S8euNKW08k2cPgej2S7+8zbkRV2HcBJCWywBsKhxd10LKOeWLcUaNkaa
	 0Z6IZNg1WQBetpjOhAMJ78otOZyPGz3rp9cuIritiuP+FSEblIVi+/YCsMajkUKb+B
	 rweJhgq2ZDwGNPSVPTsF3qdzng5ic3dZqYElCq4J4ckba/XsgyRpjXjiUj8JfZzlvY
	 i+n5RvAIZHftaGFBzlWtHPQzGLNcNHDnwdFWzi4/M4shSMQaw8adjfg5lIeWiPTp/R
	 IC6+yWPtxJU1w==
Message-ID: <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
Date: Tue, 2 Dec 2025 18:32:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
To: Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
 <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/12/2025 17.49, Jon Kohler wrote:
> 
> 
>> On Nov 27, 2025, at 10:02 PM, Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Wed, Nov 26, 2025 at 3:19 AM Jon Kohler <jon@nutanix.com> wrote:
>>>
>>> Optimize TUN_MSG_PTR batch processing by allocating sk_buff structures
>>> in bulk from the per-CPU NAPI cache using napi_skb_cache_get_bulk.
>>> This reduces allocation overhead and improves efficiency, especially
>>> when IFF_NAPI is enabled and GRO is feeding entries back to the cache.
>>
>> Does this mean we should only enable this when NAPI is used?
> 
> No, it does not mean that at all, but I see what that would be confusing.
> I can clean up the commit msg on the next go around
> 
>>>
>>> If bulk allocation cannot fully satisfy the batch, gracefully drop only
>>> the uncovered portion, allowing the rest of the batch to proceed, which
>>> is what already happens in the previous case where build_skb() would
>>> fail and return -ENOMEM.
>>>
>>> Signed-off-by: Jon Kohler <jon@nutanix.com>
>>
>> Do we have any benchmark result for this?
> 
> Yes, it is in the cover letter:
> https://patchwork.kernel.org/project/netdevbpf/cover/20251125200041.1565663-1-jon@nutanix.com/
> 
>>> ---
>>> drivers/net/tun.c | 30 ++++++++++++++++++++++++------
>>> 1 file changed, 24 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>> index 97f130bc5fed..64f944cce517 100644
>>> --- a/drivers/net/tun.c
>>> +++ b/drivers/net/tun.c
[...]
>>> @@ -2454,6 +2455,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>>>                 ret = tun_xdp_act(tun, xdp_prog, xdp, act);
>>>                 if (ret < 0) {
>>>                         /* tun_xdp_act already handles drop statistics */
>>> +                       kfree_skb_reason(skb, SKB_DROP_REASON_XDP);
>>
>> This should belong to previous patches?
> 
> Well, not really, as we did not even have an SKB to free at this point
> in the previous code
>>
>>>                         put_page(virt_to_head_page(xdp->data));

This calling put_page() directly also looks dubious.

>>>                         return ret;
>>>                 }
>>> @@ -2463,6 +2465,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>>>                         *flush = true;
>>>                         fallthrough;
>>>                 case XDP_TX:
>>> +                       napi_consume_skb(skb, 1);
>>>                         return 0;
>>>                 case XDP_PASS:
>>>                         break;
>>> @@ -2475,13 +2478,15 @@ static int tun_xdp_one(struct tun_struct *tun,
>>>                                 tpage->page = page;
>>>                                 tpage->count = 1;
>>>                         }
>>> +                       napi_consume_skb(skb, 1);
>>
>> I wonder if this would have any side effects since tun_xdp_one() is
>> not called by a NAPI.
> 
> As far as I can tell, this napi_consume_skb is really just an artifact of
> how it was named and how it was traditionally used.
> 
> Now this is really just a napi_consume_skb within a bh disable/enable
> section, which should meet the requirements of how that interface
> should be used (again, AFAICT)
> 

Yicks - this sounds super ugly.  Just wrapping napi_consume_skb() in bh
disable/enable section and then assuming you get the same protection as
NAPI is really dubious.

Cc Sebastian as he is trying to cleanup these kind of use-case, to make
kernel preemption work.


>>
>>>                         return 0;
>>>                 }
>>>         }
>>>
>>> build:
>>> -       skb = build_skb(xdp->data_hard_start, buflen);
>>> +       skb = build_skb_around(skb, xdp->data_hard_start, buflen);
>>>         if (!skb) {
>>> +               kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
> 
> Though to your point, I dont think this actually does anything given
> that if the skb was somehow nuked as part of build_skb_around, there
> would not be an skb to free. Doesn’t hurt though, from a self documenting
> code perspective tho?
> 
>>>                 dev_core_stats_rx_dropped_inc(tun->dev);
>>>                 return -ENOMEM;
>>>         }
>>> @@ -2566,9 +2571,11 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
>>>         if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
>>>             ctl && ctl->type == TUN_MSG_PTR) {
>>>                 struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>>> +               int flush = 0, queued = 0, num_skbs = 0;
>>>                 struct tun_page tpage;
>>>                 int n = ctl->num;
>>> -               int flush = 0, queued = 0;
>>> +               /* Max size of VHOST_NET_BATCH */
>>> +               void *skbs[64];
>>
>> I think we need some tweaks
>>
>> 1) TUN is decoupled from vhost, so it should have its own value (a
>> macro is better)
> 
> Sure, I can make another constant that does a similar thing
> 
>> 2) Provide a way to fail or handle the case when more than 64
> 
> What if we simply assert that the maximum here is 64, which I think
> is what it actually is in practice?
> 
>>
>>>
>>>                 memset(&tpage, 0, sizeof(tpage));
>>>
>>> @@ -2576,13 +2583,24 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
>>>                 rcu_read_lock();
>>>                 bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
>>>
>>> -               for (i = 0; i < n; i++) {
>>> +               num_skbs = napi_skb_cache_get_bulk(skbs, n);
>>
>> Its document said:
>>
>> """
>> * Must be called *only* from the BH context.
>> “"”
> We’re in a bh_disable section here, is that not good enough?

Again this feels very ugly and prone to painting ourselves into a
corner, assuming BH-disabled sections have same protection as NAPI.

(The napi_skb_cache_get/put function are operating on per CPU arrays
without any locking.)

--Jesper

