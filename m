Return-Path: <bpf+bounces-9678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B8779AAB3
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 20:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E691C208E8
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F188156EA;
	Mon, 11 Sep 2023 18:08:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31022154B4
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 18:08:40 +0000 (UTC)
Received: from out-210.mta0.migadu.com (out-210.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C8C106
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 11:08:38 -0700 (PDT)
Message-ID: <dfa73556-6097-82cf-dcf9-5ae179d7f407@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694455717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvfTrJqC5ZVvRjuLgp5olVGxg/zOhnCEu+HKmrCSMbY=;
	b=IKZPxMNYA8rerDahaGEh4uUT+02JXQM5e806P8QBTAtoKiQ38hX5obRaRKghRy6M5aRSXO
	Zirzz8RXzPNQV9U/nZUdAl3rTGfX/5cjLHrsrQ7p+ZTkxXpoWMJ7bjdJrQ0Xavjorr1MEU
	OVSjtgw2k6rwQasQy+IIQdGIXjb9iRg=
Date: Mon, 11 Sep 2023 11:08:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: return correct -ENOBUFS from
 bpf_clone_redirect
To: Daniel Borkmann <daniel@iogearbox.net>,
 Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, andrii@kernel.org, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org
References: <20230908210007.1469091-1-sdf@google.com>
 <acdb12bc-518a-c3f6-ef09-2dfd714770b5@linux.dev>
 <ZP9KJpQIpoYqzaB3@google.com>
 <a7570c31-b19d-e1d8-8e7e-f47ead34b79b@iogearbox.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <a7570c31-b19d-e1d8-8e7e-f47ead34b79b@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/11/23 10:23 AM, Daniel Borkmann wrote:
> On 9/11/23 7:11 PM, Stanislav Fomichev wrote:
>> On 09/09, Martin KaFai Lau wrote:
>>> On 9/8/23 2:00 PM, Stanislav Fomichev wrote:
>>>> Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
>>>> packets") exposed the fact that bpf_clone_redirect is capable of
>>>> returning raw NET_XMIT_XXX return codes.
>>>>
>>>> This is in the conflict with its UAPI doc which says the following:
>>>> "0 on success, or a negative error in case of failure."
>>>>
>>>> Let's wrap dev_queue_xmit's return value (in __bpf_tx_skb) into
>>>> net_xmit_errno to make sure we correctly propagate NET_XMIT_DROP
>>>> as -ENOBUFS instead of 1.
>>>>
>>>> Note, this is technically breaking existing UAPI where we used to
>>>> return 1 and now will do -ENOBUFS. The alternative is to
>>>> document that bpf_clone_redirect can return 1 for DROP and 2 for CN.
>>>>
>>>> Reported-by: Daniel Borkmann <daniel@iogearbox.net>
>>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>>> ---
>>>>    net/core/filter.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>> index a094694899c9..9e297931b02f 100644
>>>> --- a/net/core/filter.c
>>>> +++ b/net/core/filter.c
>>>> @@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, 
>>>> struct sk_buff *skb)
>>>>        ret = dev_queue_xmit(skb);
>>>>        dev_xmit_recursion_dec();
>>>> +    if (ret > 0)
>>>> +        ret = net_xmit_errno(ret);
>>>
>>> I think it is better to have bpf_clone_redirect returning -ENOBUFS instead
>>> of leaking NET_XMIT_XXX to the uapi. The bpf_clone_redirect in the
>>> uapi/bpf.h also mentions
>>>
>>>   *      Return
>>>   *              0 on success, or a negative error in case of failure.
>>>
>>> If -ENOBUFS is returned in __bpf_tx_skb, should the same be done for
>>> __bpf_rx_skb? and should net_xmit_errno() only be done for
>>> bpf_clone_redirect()?  __bpf_{tx,rx}_skb is also used by skb_do_redirect()
>>> which also calls __bpf_redirect_neigh() that returns NET_XMIT_xxx but no
>>> caller seems to care the NET_XMIT_xxx value now.
>>
>> __bpf_rx_skb seems to only add to backlog and doesn't seem to return any
>> of the NET_XMIT_xxx. But I might be wrong and haven't looked too deep
>> into that.

enqueue_to_backlog could return NET_RX_DROP which happens to have the same value 
as NET_XMIT_DROP. I think this will get propagated back to __bpf_rx_skb().

>>
>>> Daniel should know more here. I would wait for Daniel to comment.
>>
>> Ack, sure!
> 
> I think my preference would be to just document it in the helper UAPI, what
> Stan was suggesting below:
> 
> | Note, this is technically breaking existing UAPI where we used to
> | return 1 and now will do -ENOBUFS. The alternative is to
> | document that bpf_clone_redirect can return 1 for DROP and 2 for CN.
> 
> And then only adjusting the test case.
> 
> Programs checking for ret < 0 will continue to behave as before. Technically
> the bpf_clone_redirect() did its job just that on the veth side things were
> dropped. Other drivers such as tun, vrf, ipvlan, bond could already have
> returned NET_XMIT_DROP, so technically it's not a new situation where it is
> possible. And having a ret > 0 could then also be clearly used to differentiate
> that something came from driver side rather than helper side.

sure. sgtm. Not sure if it will be useful to spell out the >0 meaning in uapi/bpf.h.

> 
>>> For the selftest, may be another option is to use a 28 bytes data_in for the
>>> lwt program redirecting to veth? 14 bytes used by bpf_prog_test_run_skb and
>>> leave 14 bytes for veth_xmit. It seems the original intention of the "veth
>>> ETH_HLEN+1 packet ingress" test is expecting it to succeed also.
>>
>> IIUC, you're suggesting to pass full ipv4 or ipv6 packet for veth tests
>> to make them actually succeed with the forwarding, right?
>>
>> Sure, I can do that. But let's keep this entry with the -NOBUFS as well?
>> Just for the sake of ensuring that we don't export NET_XMIT_xxx from
>> uapi.

In that case it makes sense to only change the eth+1byte test case to expect >0 
ret (or -ENOBUF as in patch 2, depending on the above discussion). No need to 
add an extra test.



