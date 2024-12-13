Return-Path: <bpf+bounces-46805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E364C9F0266
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CC6167B47
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3773A1DB;
	Fri, 13 Dec 2024 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s0ldrN8W"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BB52AEE9
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734054105; cv=none; b=eI9j+wJ0+oYIhGzansAm6IVu4we4UCGuF9KrV4YhJjNixKIBTjjnRWdewojHgFYcL9O31d+7hUGlaqL2FEWbOcuREWIVBB9wNQeubpBD5vC4OBLiEnjPEJwIDSlJ7+sS2BRoUixuQhwWzwFrrNTRvHeb+2yHdGhAE0fDrjRalMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734054105; c=relaxed/simple;
	bh=ui59P38uJwis1FiwNN+RGOJebMgUHp6llktsO9CLa2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1Tvab3D3VeXsVmdCNBqT5ejopOkbFZ3PUTNstKlIJQTb9tYBIBW3wGotnbWgPUFvnksmIvqVNIKPyF9VNTT/2XgiOihuqJBCD0H0kLLc83VwgZpTgzShITGFC+M7DDRdrSpSeKs0LmEDYjCbYWfePfRpE8JO+RrWAuCoS4brSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s0ldrN8W; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <996cbe46-e2cd-44b6-a53a-13fd6ebfc4c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734054099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6eBcxaJia8xUifVxoqhVW2ol1hqy4lN6BzesBYXABk=;
	b=s0ldrN8WjKpCOsNKziOSZ7EexAUWRECaYxUhHanY72MjbEJJPS84cKGqRWZn5k2/Exljc8
	7QTOK1YkPvzBz1OVeTx6UWNXyCFbw2smYqSbn8rEVstzQ8pH6N/dFcGokzi6ClydP0B1tR
	uV9hrEamdKBSpJ08IY6pko7K2dNvYrc=
Date: Thu, 12 Dec 2024 17:41:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 02/11] net-timestamp: prepare for bpf prog use
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-3-kerneljasonxing@gmail.com>
 <f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@linux.dev>
 <CAL+tcoDGq8Jih9vwsz=-O8byC1S0R1uojShMvUiTZKQvMDnfTQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoDGq8Jih9vwsz=-O8byC1S0R1uojShMvUiTZKQvMDnfTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/11/24 1:17 AM, Jason Xing wrote:
> On Wed, Dec 11, 2024 at 10:02 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 12/7/24 9:37 AM, Jason Xing wrote:
>>> From: Jason Xing <kernelxing@tencent.com>
>>>
>>> Later, I would introduce three points to report some information
>>> to user space based on this.
>>>
>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>>> ---
>>>    include/net/sock.h |  7 +++++++
>>>    net/core/sock.c    | 15 +++++++++++++++
>>>    2 files changed, 22 insertions(+)
>>>
>>> diff --git a/include/net/sock.h b/include/net/sock.h
>>> index 0dd464ba9e46..f88a00108a2f 100644
>>> --- a/include/net/sock.h
>>> +++ b/include/net/sock.h
>>> @@ -2920,6 +2920,13 @@ int sock_set_timestamping(struct sock *sk, int optname,
>>>                          struct so_timestamping timestamping);
>>>
>>>    void sock_enable_timestamps(struct sock *sk);
>>> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
>>> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
>>> +#else
>>> +static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
>>> +{
>>> +}
>>> +#endif
>>>    void sock_no_linger(struct sock *sk);
>>>    void sock_set_keepalive(struct sock *sk);
>>>    void sock_set_priority(struct sock *sk, u32 priority);
>>> diff --git a/net/core/sock.c b/net/core/sock.c
>>> index 74729d20cd00..79cb5c74c76c 100644
>>> --- a/net/core/sock.c
>>> +++ b/net/core/sock.c
>>> @@ -941,6 +941,21 @@ int sock_set_timestamping(struct sock *sk, int optname,
>>>        return 0;
>>>    }
>>>
>>> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
>>> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
>>> +{
>>> +     struct bpf_sock_ops_kern sock_ops;
>>> +
>>> +     sock_owned_by_me(sk);
>>
>> I don't think this can be assumed in the time stamping callback.
> 
> I'll remove this.
> 
>>
>> To remove this assumption for sockops, I believe it needs to stop the bpf prog
>> from calling a few bpf helpers. In particular, the bpf_sock_ops_cb_flags_set and
>> bpf_sock_ops_setsockopt. This should be easy by asking the helpers to check the
>> "u8 op" in "struct bpf_sock_ops_kern *".
> 
> Sorry, I don't follow. Could you rephrase your thoughts? Thanks.

Take a look at bpf_sock_ops_setsockopt in filter.c. To change a sk, it needs to 
hold the sk_lock. If you drill down bpf_sock_ops_setsockopt, 
sock_owned_by_me(sk) is checked somewhere.

The sk_lock held assumption is true so far for the existing sockops callbacks.
The new timestamping sockops callback does not necessary have the sk_lock held, 
so it will break the bpf_sock_ops_setsockopt() assumption on the sk_lock.

> 
>>
>> I just noticed a trickier one, sockops bpf prog can write to sk->sk_txhash. The
>> same should go for reading from sk. Also, sockops prog assumes a fullsock sk is
>> a tcp_sock which also won't work for the udp case. A quick thought is to do
>> something similar to is_fullsock. May be repurpose the is_fullsock somehow or a
>> new u8 is needed. Take a look at SOCK_OPS_{GET,SET}_FIELD. It avoids
>> writing/reading the sk when is_fullsock is false.
> 
> Do you mean that if we introduce a new field, then bpf prog can
> read/write the socket?

The same goes for writing the sk, e.g. writing the sk->sk_txhash. It needs the 
sk_lock held. Reading may be ok-ish. The bpf prog can read it anyway by 
bpf_probe_read...etc.

When adding udp timestamp callback later, it needs to stop reading the tcp_sock 
through skops from the udp callback for sure. Do take a look at 
SOCK_OPS_GET_TCP_SOCK_FIELD. I think we need to ensure the udp timestamp 
callback won't break here before moving forward.

> 
> Reading the socket could be very helpful in the long run.
> 
>>
>> This is a signal that the existing sockops interface has already seen better
>> days. I hope not too many fixes like these are needed to get tcp/udp
>> timestamping to work.
>>
>>> +
>>> +     memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>>> +     sock_ops.op = op;
>>> +     sock_ops.is_fullsock = 1;
>>
>> I don't think we can assume it is always is_fullsock either.
> 
> Right, but for now, TCP seems to need this. I can remove this also.

I take this back. After reading the existing __skb_tstamp_tx, I think sk is 
always fullsock here.

> 
>>
>>> +     sock_ops.sk = sk;
>>> +     __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
>>
>> Same here. sk may not be fullsock. BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops) is
>> needed.
> 
> If we use this helper, we will change when the udp bpf extension needs
> to be supported.
> 
>>
>> [ I will continue the rest of the set later. ]
> 
> Thanks a lot :)
> 
>>
>>> +}
>>> +#endif
>>> +
>>>    void sock_set_keepalive(struct sock *sk)
>>>    {
>>>        lock_sock(sk);
>>


