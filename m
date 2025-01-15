Return-Path: <bpf+bounces-48884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E928A11612
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 01:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E46E169E08
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB97B134B0;
	Wed, 15 Jan 2025 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QboO3FkK"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7E182D2
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 00:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736900800; cv=none; b=I8LNaABm4u5DBOH0F8OwP7Ka0bsaoUvSrbkiaYG8W9iXHLw+k+5f0CbKxKB6vlC1o8eUIZ47Q4lQUaf01BpxD2VyU7hPJZSp9BNVbxjgnccL0FYNM+ixUQ5rndCAfm6+J093j4bcQWuT2dlH2eZuOFT+Z6CGDU+//5eZtlGBkDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736900800; c=relaxed/simple;
	bh=Lv6XkVPkDTuK91Ef3joVT1ex+vnsK8LZ70VLHwVphI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJictXWbDz6YYRwvNu7ZhkZFLWF559JeOuLLnDwKdTv4C5X+9Dn8qB6T7YTdtNBxWrP7TI1933o0Nlh2DTo9fhCXMoTif3EjknkOckG//vmx0MUh4kdBLJSVP/YlEFenu65vzZ6s6/WsM6oPcQDXOJjgeP22ix+nbReyqEohWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QboO3FkK; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1a0cdf13-644a-4119-9ad8-e12f81751c79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736900785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tn9D2iJX3gpfj94JtATCTA6aRdJUnUOmoo1pOB+CjIU=;
	b=QboO3FkKvu+2IGzGCAzK+25XFWSfolPOU0AoNGUKyueuTBENLnCsdC9aXfJzn0qzeFxVRX
	OB1TUJw6rrxIhgRwQmvoXbNQjf1GulhAZTv7YMeEz+B5pqLXldGwQeHkIYcODr9d9zPvab
	VaCGw1RS3WVVnvYThJ5TZmND0NLKmRU=
Date: Tue, 14 Jan 2025 16:26:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 02/15] net-timestamp: prepare for bpf prog use
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-3-kerneljasonxing@gmail.com>
 <5480eedb-ceb0-402e-883b-da4207dcc43d@linux.dev>
 <CAL+tcoCn_u_tgYuGbKqp9n1fqao_Yi0ogO8HFcA2TcQcHJOa2w@mail.gmail.com>
 <CAL+tcoA2+MO4WgzHHnX1hhCaQs6afmXWoOXNKf7wrz3QZVeeyA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoA2+MO4WgzHHnX1hhCaQs6afmXWoOXNKf7wrz3QZVeeyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/14/25 4:15 PM, Jason Xing wrote:
> On Wed, Jan 15, 2025 at 8:09 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>
>> On Wed, Jan 15, 2025 at 7:40 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>
>>> On 1/12/25 3:37 AM, Jason Xing wrote:
>>>> Later, I would introduce three points to report some information
>>>> to user space based on this.
>>>>
>>>> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
>>>> ---
>>>>    include/net/sock.h |  7 +++++++
>>>>    net/core/sock.c    | 14 ++++++++++++++
>>>>    2 files changed, 21 insertions(+)
>>>>
>>>> diff --git a/include/net/sock.h b/include/net/sock.h
>>>> index f5447b4b78fd..dd874e8337c0 100644
>>>> --- a/include/net/sock.h
>>>> +++ b/include/net/sock.h
>>>> @@ -2930,6 +2930,13 @@ int sock_set_timestamping(struct sock *sk, int optname,
>>>>                          struct so_timestamping timestamping);
>>>>
>>>>    void sock_enable_timestamps(struct sock *sk);
>>>> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
>>>> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
>>>> +#else
>>>> +static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
>>>> +{
>>>> +}
>>>> +#endif
>>>>    void sock_no_linger(struct sock *sk);
>>>>    void sock_set_keepalive(struct sock *sk);
>>>>    void sock_set_priority(struct sock *sk, u32 priority);
>>>> diff --git a/net/core/sock.c b/net/core/sock.c
>>>> index eae2ae70a2e0..e06bcafb1b2d 100644
>>>> --- a/net/core/sock.c
>>>> +++ b/net/core/sock.c
>>>> @@ -948,6 +948,20 @@ int sock_set_timestamping(struct sock *sk, int optname,
>>>>        return 0;
>>>>    }
>>>>
>>>> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
>>>> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
>>>> +{
>>>> +     struct bpf_sock_ops_kern sock_ops;
>>>> +
>>>> +     memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>>>> +     sock_ops.op = op;
>>>> +     if (sk_is_tcp(sk) && sk_fullsock(sk))
>>>> +             sock_ops.is_fullsock = 1;
>>>> +     sock_ops.sk = sk;
>>>> +     __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
>>>
>>> hmm... I think I have already mentioned it in the earlier revision
>>> (https://lore.kernel.org/bpf/f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@linux.dev/).
>>
>> Right, sorry, but I deleted it intentionally.
>>
>>>
>>> __cgroup_bpf_run_filter_sock_ops(sk, ...) requires sk to be fullsock.
>>
>> Well, I don't understand it, BPF_CGROUP_RUN_PROG_SOCK_OPS_SK() don't
>> need to check whether it is fullsock or not.

It is because the callers of BPF_CGROUP_RUN_PROG_SOCK_OPS_SK guarantees it is 
fullsock.

>>
>>> Take a look at how BPF_CGROUP_RUN_PROG_SOCK_OPS does it.
>>> sk_to_full_sk() is used to get back the listener. For other mini socks,
>>> it needs to skip calling the cgroup bpf prog. I still don't understand
>>> why BPF_CGROUP_RUN_PROG_SOCK_OPS cannot be used here because of udp.
>>
>> Sorry, I got lost here. BPF_CGROUP_RUN_PROG_SOCK_OPS cannot support
>> udp, right? And I think we've discussed that we have to get rid of the
>> limitation of fullsock.

It is the part I am missing. Why BPF_CGROUP_RUN_PROG_SOCK_OPS cannot support 
udp? UDP is not a fullsock?

> 
> To support udp case, I think I can add the following check for
> __cgroup_bpf_run_filter_sock_ops() instead of directly calling
> BPF_CGROUP_RUN_PROG_SOCK_OPS():
> 1) if the socket belongs to tcp type, it should be fullsock.
> 2) or if it is a udp type socket. Then no need to check and use the fullsock.
> 
> Above lines/policies should be applied to the rest of the series, right?
> 
> According to the existing callbacks, the tcp socket is indeed fullsock.

