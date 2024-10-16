Return-Path: <bpf+bounces-42145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8015F9A00CF
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 07:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FA2B258D0
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 05:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD1818BBB2;
	Wed, 16 Oct 2024 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pyElI2wE"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563ED21E3A4
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 05:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056934; cv=none; b=lyv7MJvXaQNxOfssiAtWLgSyEeVTpe09O3Pk3rnYaRMa+QuP2+L9la/y4GQ8LGVrjzzPVqbB9eENVfLNePX1voa/huaN1loxliHA07NfbyzZntewAvZdsivc35sWLHRvEFZzsXD5lRBh49tl55CUfro/rKdIJ7JBMdc20c7sOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056934; c=relaxed/simple;
	bh=QrTy41cZnVymSPMDjT34h+lx890hs9L1hZPXqnz2+MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQLC0dy527FFl7GFtgjr3YcL/yenEeu8j8Lvfe8oeJ8doy+MSecwSTEa0ipOfqkbOJG9C4Ka2JKJ5MpgzIcdOF9F6oGQBqwMAdcclAg4Lm9z0jj6KZRorhqPNRhnqaSrhzi7TPJxL08/HeCn3DzoXZArnupcZO54QERzaAQVurk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pyElI2wE; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c7b2366-074e-48c1-a918-daf0a94c4b55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729056925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeubJZBwO9M+mM4XecvhWKBee4wfwBNkg1ns7JBH5sg=;
	b=pyElI2wEssYgkyB+rg2RPg0J0t99Up6w4NZYVxxhcCwdfSrJ00he49n6VVk1kGPKL174ur
	2ePmjKuzKdJHoil0gVlub5A4oq6L4SHuS/JYswqlbkvl/tL8YOu55fLnSrYN6jC9A/QBSw
	TckD9pvuh4gIQUv6jSswYRphOvCpTt8=
Date: Tue, 15 Oct 2024 22:35:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 06/12] net-timestamp: introduce
 TS_SCHED_OPT_CB to generate dev xmit timestamp
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-7-kerneljasonxing@gmail.com>
 <b4767fab-9c61-49f0-8185-6445349ae30b@linux.dev>
 <CAL+tcoD8OF0LCSFVEN-oEQas1JGfR+HF7Zt+2fqMH5_4eK9X4g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoD8OF0LCSFVEN-oEQas1JGfR+HF7Zt+2fqMH5_4eK9X4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/15/24 6:24 PM, Jason Xing wrote:
> On Wed, Oct 16, 2024 at 9:01 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 10/11/24 9:06 PM, Jason Xing wrote:
>>> From: Jason Xing <kernelxing@tencent.com>
>>>
>>> Introduce BPF_SOCK_OPS_TS_SCHED_OPT_CB flag so that we can decide to
>>> print timestamps when the skb just passes the dev layer.
>>>
>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>>> ---
>>>    include/uapi/linux/bpf.h       |  5 +++++
>>>    net/core/skbuff.c              | 17 +++++++++++++++--
>>>    tools/include/uapi/linux/bpf.h |  5 +++++
>>>    3 files changed, 25 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 157e139ed6fc..3cf3c9c896c7 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -7019,6 +7019,11 @@ enum {
>>>                                         * by the kernel or the
>>>                                         * earlier bpf-progs.
>>>                                         */
>>> +     BPF_SOCK_OPS_TS_SCHED_OPT_CB,   /* Called when skb is passing through
>>> +                                      * dev layer when SO_TIMESTAMPING
>>> +                                      * feature is on. It indicates the
>>> +                                      * recorded timestamp.
>>> +                                      */
>>>    };
>>>
>>>    /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>> index 3a4110d0f983..16e7bdc1eacb 100644
>>> --- a/net/core/skbuff.c
>>> +++ b/net/core/skbuff.c
>>> @@ -5632,8 +5632,21 @@ static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype)
>>>                return;
>>>
>>>        tp = tcp_sk(sk);
>>> -     if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG))
>>> -             return;
>>> +     if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)) {
>>> +             struct timespec64 tstamp;
>>> +             u32 cb_flag;
>>> +
>>> +             switch (tstype) {
>>> +             case SCM_TSTAMP_SCHED:
>>> +                     cb_flag = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
>>> +                     break;
>>> +             default:
>>> +                     return;
>>> +             }
>>> +
>>> +             tstamp = ktime_to_timespec64(ktime_get_real());
>>> +             tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv_nsec);
>>
>> There is bpf_ktime_get_*() helper. The bpf prog can directly call the
>> bpf_ktime_get_* helper and use whatever clock it sees fit instead of enforcing
>> real clock here and doing an extra ktime_to_timespec64. Right now the
>> bpf_ktime_get_*() does not have real clock which I think it can be added.
> 
> In this way, there is no need to add tcp_call_bpf_*arg() to pass
> timestamp to userspace, right? Let the bpf program implement it.
> 
> Now I wonder what information I should pass? Sorry for the lack of BPF
> related knowledge :(

Just pass the cb_flag op in this case.

A bpf selftest is missing in this series to show how it is going to be used. 
Yes, there are existing socket API tests on time stamping but I believe this 
discussion has already shown some subtle differences that warrant a closer to 
real world bpf prog example first.

> 
>>
>> I think overall the tstamp reporting interface does not necessarily have to
>> follow the socket API. The bpf prog is running in the kernel. It could pass
>> other information to the bpf prog if it sees fit. e.g. the bpf prog could also
>> get the original transmitted tcp skb if it is useful.
> 
> Good to know that! But how the BPF program parses the skb by using
> tcp_call_bpf_2arg() which only passes u32 parameters.

"struct skbuff *skb" has already been added to "struct bpf_sock_ops_kern". It is 
only assigned during the "BPF_SOCK_OPS_PARSE_*HDR_CB". It is not exposed 
directly to bpf prog but it could be. However, it may need to change some 
convert_ctx code in filter.c which I am not excited about. We haven't added 
convert_ctx changes for a while since it is the old way.

Together with the "u32	bpf_sock_ops_cb_flags;" change in patch 9 which is only 
for tcp_sock and other _CB flags are also tcp specific only. For now, I am not 
sure carrying this sockops to the future UDP support is desired.

Take a look at tcp_call_bpf(). It needs to initialize the whole "struct 
bpf_sock_ops_kern" regardless of what the bpf prog is needed before calling the 
bpf prog. The "u32 args[4]" is one of them. The is the older way of using bpf to 
extend kernel.

bpf has struct_ops support now which can pass only what is needed and without 
the need of doing the convert_ctx in filter.c. The "struct tcp_congestion_ops" 
can already be implemented in bpf. Take a look at 
selftests/bpf/progs/bpf_cubic.c. All the BPF_SOCK_OPS_*_CB (e.g. 
BPF_SOCK_OPS_TS_SCHED_OPT_CB here) could just a "ops" in the struct_ops.

That said, I think the first thing needs to figure out is how to enable bpf time 
stamping without having side effect on the user space. Continue the sockops 
approach first and use it to create a selftest bpf prog example. Then we can decide.



