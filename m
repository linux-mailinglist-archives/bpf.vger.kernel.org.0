Return-Path: <bpf+bounces-46962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAF89F1B21
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F184188889B
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C929A1EBFE1;
	Fri, 13 Dec 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c/Op9mKR"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355A1EBA1E
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134148; cv=none; b=eU9NkGdxxO1kcW1gzdo8VLOn1Q23QLUcR8KnY4c4qabsqa9BGd4pigqEvOc8sCTZBr3x1YdFMJutiTue+ssC+iPF6/JK9EuZIjunyCdPgqziTMhw3vI8a0jQU953Rp6MDcQ7PzhRaCMAFePE7ypkd+yGuwBk5TS5J4B4BQTYq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134148; c=relaxed/simple;
	bh=XqG2JijYRpxL2/j3DukylYuY6FOBReLBkzB2NTjm1OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IM4I9N/WkbU9xGG/w2y4h+h8m4xaYK2rEoca7l+YdYujFzF2zzRcbXMT3CH7oc84SvWspnVgckXvPVPKJU/O6hK3t0njcWNxcett4Uhro/oS27+ggIJGjHWS0PpwNScuC8akyV4ju49iTw2Vlk+UuJSQOxnpgDABmEzG0183m9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c/Op9mKR; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55384b37-005d-48e9-894b-8bbe4f7a6b24@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734134143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Wx0ubisvuXuYNQ0Vjor9tnJWsgXG5tKeIY4c7YfW0I=;
	b=c/Op9mKR5nKAnru1LNVAA0LkoQNk8blbd8PtEgJ22dGt1HlBaR/S774tkeh8sCkpXkgqXZ
	XV4bAC5TNVMC5VoaX1toJx9ndFTAC/GxGD0Df0zapA/MCwGtYixfB7FZu09C2n043gvMQ6
	LhVzK6dYN06cIUVrOLkcrzyxvXXOwzU=
Date: Fri, 13 Dec 2024 15:55:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 10/11] net-timestamp: export the tskey for TCP
 bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-11-kerneljasonxing@gmail.com>
 <9f5081bb-ed66-4171-acef-786ae02cf69c@linux.dev>
 <CAL+tcoCCvKapSQ8N48iKh83YxYskDkPyM+bpT5=m8cE_YrCovg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoCCvKapSQ8N48iKh83YxYskDkPyM+bpT5=m8cE_YrCovg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 7:44 AM, Jason Xing wrote:
>>> @@ -5569,7 +5569,10 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb,
>>>                return;
>>>        }
>>>
>>> -     bpf_skops_tx_timestamping(sk, skb, op, 2, args);
>>> +     if (sk_is_tcp(sk))
>>> +             args[2] = skb_shinfo(skb)->tskey;
>> Instead of only passing one info "skb_shinfo(skb)->tskey" of a skb, pass the
>> whole skb ptr to the bpf prog. Take a look at bpf_skops_init_skb. Lets start
>> with end_offset = 0 for now so that the bpf prog won't use it to read the
>> skb->data. It can be revisited later.
>>
>>          bpf_skops_init_skb(&sock_ops, skb, 0);
>>
>> The bpf prog can use bpf_cast_to_kern_ctx() and bpf_core_cast() to get to the
>> skb_shinfo(skb). Take a look at the md_skb example in type_cast.c.
> Sorry, I didn't give it much thought on getting to the shinfo. That's
> why I quickly gave up using bpf_skops_init_skb() after I noticed the
> seq of skb is always zero 🙁
> 
> I will test it tomorrow. Thanks.
> 
>> Then it needs to add a bpf_sock->op check to the existing
>> bpf_sock_ops_{load,store}_hdr_opt() helpers to ensure these helpers can only be
>> used by the BPF_SOCK_OPS_PARSE_HDR_OPT_CB, BPF_SOCK_OPS_HDR_OPT_LEN_CB, and
>> BPF_SOCK_OPS_WRITE_HDR_OPT_CB callback.
> Forgive me. I cannot see how the bpf_sock_ops_load_hdr_opt helper has
> something to do with the current thread? Could you enlighten me?

Sure. This is the same discussion as in patch 2, so may be worth to highlight 
something that I guess may be missing:

a bpf prog does not need to use a helper does not mean:
a bpf prog is not allowed to call a helper because it is not safe.

The sockops prog running at the new timestamp hook does not need to call 
bpf_setsockopt() but it does not mean the bpf prog is not allowed to call 
bpf_setsockopt() without holding the sk_lock which is then broken.

The sockops timestamp prog does not need to use the 
bpf_sock_ops_{load,store}_hdr_opt but it does not mean the bpf prog is not 
allowed to call bpf_sock_ops_{load,store}_hdr_opt to change the skb which is 
then also broken.

Now, skops->skb is not NULL only when the sockops prog is allowed to read/write 
the skb.

With bpf_skops_init_skb(), skops->skb will not be NULL in the new timestamp 
callback hook. bpf_sock_ops_{load,store}_hdr_opt() will be able to use the 
skops->skb and it will be broken.

> 
>> btw, how is the ack_skb used for the SCM_TSTAMP_ACK by the user space now?
> To be honest, I hardly use the ack_skb[1] under this circumstance... I
> think if someone offers a suggestion to use it, then we can support
> it?

Thanks for the pointer.

Yep, supporting it later is fine. I am curious because the ack_skb is used in 
the user space time stamping now but not in your patch. I was asking to ensure 
that we should be able to support it in the future if there is a need.  We 
should be able to reuse the skops->syn_skb to support that in the future.

> 
> [1]
> commit e7ed11ee945438b737e2ae2370e35591e16ec371
> Author: Yousuk Seung<ysseung@google.com>
> Date:   Wed Jan 20 12:41:55 2021 -0800
> 
>      tcp: add TTL to SCM_TIMESTAMPING_OPT_STATS
> 
>      This patch adds TCP_NLA_TTL to SCM_TIMESTAMPING_OPT_STATS that exports
>      the time-to-live or hop limit of the latest incoming packet with
>      SCM_TSTAMP_ACK. The value exported may not be from the packet that acks
>      the sequence when incoming packets are aggregated. Exporting the
>      time-to-live or hop limit value of incoming packets helps to estimate
>      the hop count of the path of the flow that may change over time.



