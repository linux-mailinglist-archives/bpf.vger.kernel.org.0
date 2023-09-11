Return-Path: <bpf+bounces-9681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2894279AAD2
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 20:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3418B1C20A1C
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433F154B7;
	Mon, 11 Sep 2023 18:36:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42600AD23
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 18:36:30 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FDA10E
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xZDctP2KQUvM6OsJbEYD6fZmy5KR2yljUwOBMEX3XcQ=; b=KOM/AbRICUkpVh5yMPng0DI0KR
	h3PjnWB3tz89zhp3KWRLXIiXO1kHV4SQCGKt9Bn6dmKoHqdue7ihQFccAKKHHMnV3gR1wNwWuo162
	aKWjqbmfFTwLAARWk9MgjnNuaxdBuuRkYr6Tk0czFAUx9BREm3I/FdnyNfZGji1MDSS/Y/ecE+9Xb
	a8IrabhyqzA4FXzu46W5Io3PeHKfNjHxLkcXMpog2Rtj8T9bkhy6+boguW7ltbR0Ic1VKo2W5MBh6
	5MPDAg6fWVtbUWl4ohj8piE/8sRPmvTpj6UO4Ta+rP6vZWoj3rXop+wiyg/IcNd0aWBwPBsMYUrGf
	vmFkiBNA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qfllh-000ET7-P0; Mon, 11 Sep 2023 20:36:17 +0200
Received: from [208.125.9.132] (helo=localhost.localdomain)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qfllh-0003Jb-8W; Mon, 11 Sep 2023 20:36:17 +0200
Subject: Re: [PATCH bpf-next 1/2] bpf: return correct -ENOBUFS from
 bpf_clone_redirect
To: Stanislav Fomichev <sdf@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20230908210007.1469091-1-sdf@google.com>
 <acdb12bc-518a-c3f6-ef09-2dfd714770b5@linux.dev>
 <ZP9KJpQIpoYqzaB3@google.com>
 <a7570c31-b19d-e1d8-8e7e-f47ead34b79b@iogearbox.net>
 <ZP9RSu3QDRN0wsr/@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <927cc104-a266-7300-f601-e39d5d0fef59@iogearbox.net>
Date: Mon, 11 Sep 2023 20:36:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZP9RSu3QDRN0wsr/@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27028/Mon Sep 11 09:37:06 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/11/23 7:41 PM, Stanislav Fomichev wrote:
> On 09/11, Daniel Borkmann wrote:
>> On 9/11/23 7:11 PM, Stanislav Fomichev wrote:
>>> On 09/09, Martin KaFai Lau wrote:
>>>> On 9/8/23 2:00 PM, Stanislav Fomichev wrote:
>>>>> Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
>>>>> packets") exposed the fact that bpf_clone_redirect is capable of
>>>>> returning raw NET_XMIT_XXX return codes.
>>>>>
>>>>> This is in the conflict with its UAPI doc which says the following:
>>>>> "0 on success, or a negative error in case of failure."
>>>>>
>>>>> Let's wrap dev_queue_xmit's return value (in __bpf_tx_skb) into
>>>>> net_xmit_errno to make sure we correctly propagate NET_XMIT_DROP
>>>>> as -ENOBUFS instead of 1.
>>>>>
>>>>> Note, this is technically breaking existing UAPI where we used to
>>>>> return 1 and now will do -ENOBUFS. The alternative is to
>>>>> document that bpf_clone_redirect can return 1 for DROP and 2 for CN.
>>>>>
>>>>> Reported-by: Daniel Borkmann <daniel@iogearbox.net>
>>>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>>>> ---
>>>>>     net/core/filter.c | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>>> index a094694899c9..9e297931b02f 100644
>>>>> --- a/net/core/filter.c
>>>>> +++ b/net/core/filter.c
>>>>> @@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
>>>>>     	ret = dev_queue_xmit(skb);
>>>>>     	dev_xmit_recursion_dec();
>>>>> +	if (ret > 0)
>>>>> +		ret = net_xmit_errno(ret);
>>>>
>>>> I think it is better to have bpf_clone_redirect returning -ENOBUFS instead
>>>> of leaking NET_XMIT_XXX to the uapi. The bpf_clone_redirect in the
>>>> uapi/bpf.h also mentions
>>>>
>>>>    *      Return
>>>>    *              0 on success, or a negative error in case of failure.
>>>>
>>>> If -ENOBUFS is returned in __bpf_tx_skb, should the same be done for
>>>> __bpf_rx_skb? and should net_xmit_errno() only be done for
>>>> bpf_clone_redirect()?  __bpf_{tx,rx}_skb is also used by skb_do_redirect()
>>>> which also calls __bpf_redirect_neigh() that returns NET_XMIT_xxx but no
>>>> caller seems to care the NET_XMIT_xxx value now.
>>>
>>> __bpf_rx_skb seems to only add to backlog and doesn't seem to return any
>>> of the NET_XMIT_xxx. But I might be wrong and haven't looked too deep
>>> into that.
>>>
>>>> Daniel should know more here. I would wait for Daniel to comment.
>>>
>>> Ack, sure!
>>
>> I think my preference would be to just document it in the helper UAPI, what
>> Stan was suggesting below:
>>
>> | Note, this is technically breaking existing UAPI where we used to
>> | return 1 and now will do -ENOBUFS. The alternative is to
>> | document that bpf_clone_redirect can return 1 for DROP and 2 for CN.
>>
>> And then only adjusting the test case.
> 
> In this case, would we also need something similar to our
> TCP_BPF_<state> changes? Like BUILD_BUG_ON(BPF_NET_XMIT_XXX !=
> NET_XMIT_XXX)? Otherwise, we risk more leakage into the UAPI.
> Merely documenting doesn't seem enough?

We could probably just mention that a positive, non-zero code indicates
that the skb clone got forwarded to the target netdevice but got dropped
from driver side. This is somewhat also driver dependent e.g. if you look
at dummy which does drop-all, it returns NETDEV_TX_OK. Anything more
specific in the helper doc such as defining BPF_NET_XMIT_* would be more
confusing.

>> Programs checking for ret < 0 will continue to behave as before. Technically
>> the bpf_clone_redirect() did its job just that on the veth side things were
>> dropped. Other drivers such as tun, vrf, ipvlan, bond could already have
>> returned NET_XMIT_DROP, so technically it's not a new situation where it is
>> possible. And having a ret > 0 could then also be clearly used to differentiate
>> that something came from driver side rather than helper side.
>>
>>>> For the selftest, may be another option is to use a 28 bytes data_in for the
>>>> lwt program redirecting to veth? 14 bytes used by bpf_prog_test_run_skb and
>>>> leave 14 bytes for veth_xmit. It seems the original intention of the "veth
>>>> ETH_HLEN+1 packet ingress" test is expecting it to succeed also.
>>>
>>> IIUC, you're suggesting to pass full ipv4 or ipv6 packet for veth tests
>>> to make them actually succeed with the forwarding, right?
>>>
>>> Sure, I can do that. But let's keep this entry with the -NOBUFS as well?
>>> Just for the sake of ensuring that we don't export NET_XMIT_xxx from
>>> uapi.


