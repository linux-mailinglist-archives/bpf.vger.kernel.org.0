Return-Path: <bpf+bounces-12677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994EF7CF128
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 09:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542A9281EFE
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 07:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13CDD29D;
	Thu, 19 Oct 2023 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XeoQDq4r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D7D26A
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 07:25:12 +0000 (UTC)
Received: from out-203.mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2529F
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 00:25:10 -0700 (PDT)
Message-ID: <33ff226e-a5b2-b222-c178-199e9c504e73@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697700308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsF14E9ZUVrAK6utKnkmTlOBxGxnJbc4+7G1x9j6YcM=;
	b=XeoQDq4rhB2qmIIBFeLAIQp47RcjIaezNF3WoclITmS0EPq+IE/Y0TvEY6ZPpuLR/OcK83
	9LybCGGd1uKhMTXn0vxGGf5vUA2SCv2U3dXMI0NUwVSqqO2jjYRxl7xdSLrKqy117HLRp9
	4y/hIBUjn1vELvjDLMiLnYI67/FVURE=
Date: Thu, 19 Oct 2023 00:25:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie
 generation/validation SOCK_OPS hooks.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, kuni1840@gmail.com,
 mykolal@fb.com, netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com,
 song@kernel.org, yonghong.song@linux.dev, sinquersw@gmail.com
References: <7aac6512-c1f9-42ce-b8ca-07980f90714e@gmail.com>
 <20231018223104.51121-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231018223104.51121-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/18/23 3:31 PM, Kuniyuki Iwashima wrote:
> From: Kui-Feng Lee <sinquersw@gmail.com>
> Date: Wed, 18 Oct 2023 14:47:43 -0700
>> On 10/18/23 10:20, Kuniyuki Iwashima wrote:
>>> From: Eric Dumazet <edumazet@google.com>
>>> Date: Wed, 18 Oct 2023 10:02:51 +0200
>>>> On Wed, Oct 18, 2023 at 8:19 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>>
>>>>> On 10/17/23 9:48 AM, Kuniyuki Iwashima wrote:
>>>>>> From: Martin KaFai Lau <martin.lau@linux.dev>
>>>>>> Date: Mon, 16 Oct 2023 22:53:15 -0700
>>>>>>> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
>>>>>>>> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
>>>>>>>> After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
>>>>>>>> server.  Our kernel module works at Netfilter input/output hooks and first
>>>>>>>> feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
>>>>>>>> for SYN+ACK, it looks up the corresponding request socket and overwrites
>>>>>>>> tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
>>>>>>>> complete 3WHS with the original ACK as is.
>>>>>>>
>>>>>>> Does the current kernel module also use the timestamp bits differently?
>>>>>>> (something like patch 8 and patch 10 trying to do)
>>>>>>
>>>>>> Our SYN Proxy uses TS as is.  The proxy nodes generate a random number
>>>>>> if TS is in SYN.
>>>>>>
>>>>>> But I thought someone would suggest making TS available so that we can
>>>>>> mock the default behaviour at least, and it would be more acceptable.
>>>>>>
>>>>>> The selftest uses TS just to strengthen security by validating 32-bits
>>>>>> hash.  Dropping a part of hash makes collision easier to happen, but
>>>>>> 24-bits were sufficient for us to reduce SYN flood to the managable
>>>>>> level at the backend.
>>>>>
>>>>> While enabling bpf to customize the syncookie (and timestamp), I want to explore
>>>>> where can this also be done other than at the tcp layer.
>>>>>
>>>>> Have you thought about directly sending the SYNACK back at a lower layer like
>>>>> tc/xdp after receiving the SYN?
>>>
>>> Yes.  Actually, at netconf I mentioned the cookie generation hook will not
>>> be necessary and should be replaced with XDP.

Right, it is also what I have been thinking when seeing the 
BPF_SOCK_OPS_GEN_SYNCOOKIE_CB carrying the bpf generated timestamp to the 
tcp_make_synack. It feels like trying hard to work with the tcp want_cookie 
logic while there is an existing better alternative in tc/xdp to deal with synflood.

>>>
>>>
>>>>> There are already bpf_tcp_{gen,check}_syncookie
>>>>> helper that allows to do this for the performance reason to absorb synflood. It
>>>>> will be natural to extend it to handle the customized syncookie also.
>>>
>>> Maybe we even need not extend it and can use XDP as said below.
>>>
>>>
>>>>>
>>>>> I think it should already be doable to send a SYNACK back with customized
>>>>> syncookie (and timestamp) at tc/xdp today.
>>>>>
>>>>> When ack is received, the prog@tc/xdp can verify the cookie. It will probably
>>>>> need some new kfuncs to create the ireq and queue the child socket. The bpf prog
>>>>> can change the ireq->{snd_wscale, sack_ok...} if needed. The details of the
>>>>> kfuncs need some more thoughts. I think most of the bpf-side infra is ready,
>>>>> e.g. acquire/release/ref-tracking...etc.
>>>>>
>>>>
>>>> I think I mostly agree with this.
>>>
>>> I didn't come up with kfunc to create ireq and queue it to listener, so
>>> cookie_v[46]_check() were best place for me to extend easily, but now it
>>> sounds like kfunc would be the way to go.
>>>
>>> Maybe we can move the core part of cookie_v[46]_check() except for kernel
>>> cookie's validation to __cookie_v[46]_check() and expose a wrapper of it
>>> as kfunc ?
>>>
>>> Then, we can look up sk and pass the listener, skb, and flags (for sack_ok,
>>> etc) to the kfunc.  (It could still introduce some conflicts with Eric's
>>> patch though...)
>>
>> Does that mean the packets handled in this way (in XDP) will skip all
>> netfilter at all?
> 
> Good point.
> 
> If we want not to skip other layers, maybe we can use tc ?
> 
> 1) allocate ireq and set sack_ok etc with kfunc
> 2) bpf_sk_assign() to set ireq to skb (this could be done in kfunc above)
> 3) let inet_steal_sock() return req->sk_listener if not sk_fullsock(sk)
> 4) if skb->sk is reqsk in cookie_v[46]_check(), skip validation and
>     req allocation and create full sk

Haven't looked at the details. The above feels reasonable and would be nice if 
it works out. don't know if the skb at tc can be used in cookie_v[46]_check() as 
is. It probably needs more thoughts.  [ note, xdp does not have skb. ]

Regarding the "allocate ireq and set sack_ok etc with kfunc", do you think it 
will be useful (and potentially cleaner) even for the 
BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB if it needed to go back to consider skops? Then 
only do the BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB and the xdp/tc can generate SYNACK. 
The xdp/tc can still do the check and drop the bad ACK earlier in the stack.


