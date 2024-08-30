Return-Path: <bpf+bounces-38607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CD7966B0F
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 23:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8311C21941
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 21:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F53E1BF7E4;
	Fri, 30 Aug 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fV2JCx7R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FAD14C585
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051775; cv=none; b=PxqdORTCKJTqhqwtTNtIaCBPqUV0Q95wA2PeRGccjOz7n6+sZQ5ytZ7hQ9grvloUM774vQc9+SNLDT7jMfwaqgzC/A54FsYypW0wnmXta06oIeZifQFn9C/fmxSdgYWkNVAUa2zeC6Ki0EertrOeJbziAWvm9RREDQ9FvH08BGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051775; c=relaxed/simple;
	bh=f5/T0oH6Ih9TmwEtZQ/Sk6nTvkwUfXrFfB0Ifv8jW0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8SHqbbzMLBPxV8p95OQsBns6WH0gggViBczPvLGpd36AsB4Eqz0OyqcAREcQgox5XTUo/R6OILthJr1dH3bNC+VBEAurAaZ5QaL56lD7APfH4mIdx+BSfpW3j2N0gsRPOpS57R9gx2OkrvTgp/r6GRM1I9MntYTCy/n5Tn+qXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fV2JCx7R; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c35427935eso3711026d6.3
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725051772; x=1725656572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msUYaMLebkrC9SuT1gHkl+ZbMGvcz1BQEyrVn86T7dU=;
        b=fV2JCx7RM7xc+ZhE1BT/lIBweX2IMEV/ZqcaMuRtXPtjDF/FPTRwV6S485Okz2x78m
         kDb6jEAnSt4wD8wvIqUDj9CFrNpl66v9ilRZb9hpV14WpraXXrtZh3ErjpfkXbswAXOy
         RP0PY598mTKwo+ucJIds2dsIYnLsFCB+VghqXacG5QqIgsKnbNW9nm1PHQ80RWcxVjxm
         1IffeXBHasd+AEu2jb7baASf+YpUbASzveT/WSwg735NL52DhK+IQ+Xq5vqyLqniP/xH
         Mm6dRNTZ8cXg6oPvDmOq1+UJh44s5oKoRqZnP+dSz+JsDH02RSwFBzpmI0wR2DlkgiD/
         GC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725051772; x=1725656572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msUYaMLebkrC9SuT1gHkl+ZbMGvcz1BQEyrVn86T7dU=;
        b=cypRtePM2XUvhu2C7SyJNqhUgqNRsGvOOBc1NFoj4wXSxaRLQG84lHePsCjOdH3u6U
         t1lrXo1CoU6SUFN6G/eBwLYdn0M9ZRmMVmLmbQgbKcFznhCGos7ytaz7KYPqnZaJfPf3
         rlY6BYw1HckhnHjQuMKyv24o3s0avCzJ4HFVpGzLrF9mPbJCz5qUyQROQ7fEyEr1rAlW
         WumhfzSlzKIwzxgbKhi4/SZME0itobYlj8f/qN3VsTCtiRHClLKWytazh5LX1QOla0gm
         Q/aI4/7/ZFQK2rasP37zaxe5zcg2rinG1nYfJxsXdt5PNsfcqEu58UkH2SOZvPGP5oFS
         R4kw==
X-Forwarded-Encrypted: i=1; AJvYcCXW4loXAhA/Did2U8LFCjOou/oePFfv5vCqLberSbTY040xLXXQ++8C964Orf12ZFufEPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8RtYmuB9tA+pixKhCzY5O5BDN63rCCfagAULteRVIFRcw77R
	vpWJmf12dtNj+97ysjoxQyTh2AoAJxTv0A4fuREOu5c7lJOsI7HT1OCY1cGwTww=
X-Google-Smtp-Source: AGHT+IGH/RxDl4D2CXUkDL/FQy2w0mZE3iR3UUySoojEB92eNZLXnc56zaZlKcMHCZvadw80kXT0Yw==
X-Received: by 2002:a05:6214:4892:b0:6c3:33c1:bdd1 with SMTP id 6a1803df08f44-6c355846edfmr11507386d6.51.1725051772199;
        Fri, 30 Aug 2024 14:02:52 -0700 (PDT)
Received: from [10.200.138.138] (ec2-52-9-159-93.us-west-1.compute.amazonaws.com. [52.9.159.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c3567b43d2sm1300306d6.96.2024.08.30.14.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 14:02:51 -0700 (PDT)
Message-ID: <3e387788-1f5a-4159-9ff5-e53e897ae41c@bytedance.com>
Date: Fri, 30 Aug 2024 14:02:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: tcp: prevent bpf_reserve_hdr_opt()
 from growing skb larger than MTU
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Amery Hung <amery.hung@bytedance.com>, bpf@vger.kernel.org
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 xiyou.wangcong@gmail.com, wangdongdong.6@bytedance.com,
 zhoufeng.zf@bytedance.com
References: <20240827013736.2845596-1-zijianzhang@bytedance.com>
 <20240827013736.2845596-2-zijianzhang@bytedance.com>
 <5186a69b-c53d-4afa-b3be-e6bd272d264f@linux.dev>
 <955cb3be-1dc4-4ebf-b0de-75c25f393c1e@bytedance.com>
 <c9cf1c15-5038-4c85-be80-5fff34a2df44@linux.dev>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <c9cf1c15-5038-4c85-be80-5fff34a2df44@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 6:00 PM, Martin KaFai Lau wrote:
> On 8/28/24 4:01 PM, Zijian Zhang wrote:
>> On 8/28/24 2:29 PM, Martin KaFai Lau wrote:
>>> On 8/26/24 6:37 PM, zijianzhang@bytedance.com wrote:
>>>> From: Amery Hung <amery.hung@bytedance.com>
>>>>
>>>> This series prevents sockops users from accidentally causing packet
>>>> drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
>>>> reserves different option lengths in tcp_sendmsg().
>>>>
>>>> Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be 
>>>> called to
>>>> reserve a space in tcp_send_mss(), which will return the MSS for TSO.
>>>> Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in 
>>>> __tcp_transmit_skb()
>>>> again to calculate the actual tcp_option_size and skb_push() the total
>>>> header size.
>>>>
>>>> skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, which is
>>>> derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
>>>> reserved opt size is smaller than the actual header size, the len of 
>>>> the
>>>> skb can exceed the MTU. As a result, ip(6)_fragment will drop the
>>>> packet if skb->ignore_df is not set.
>>>>
>>>> To prevent this accidental packet drop, we need to make sure the
>>>> second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
>>>> not more than the first time. 
>>>
>>> iiuc, it is a bug in the bpf prog itself that did not reserve the 
>>> same header length and caused a drop. It is not the only drop case 
>>> though for an incorrect bpf prog. There are other cases where a bpf 
>>> prog can accidentally drop a packet.
>>>
>>> Do you have an actual use case that the bpf prog cannot reserve the 
>>> correct header length for the same sk ?
>>
>> That's right, it's the bug of the bpf prog itself. We are trying to have
>> the error reported earlier in eBPF program, instead of successfully
>> returning from bpf_sock_ops_reserve_hdr_opt but leading to packet drop
>> at the end because of it.
>>
>> By adding this patch, the `remaining` variable passed to the
>> bpf_skops_hdr_opt_len will be more precise, it takes the previously
>> reserved size into account. As a result, if users accidentally set an
>> option size larger than the reserved size, bpf_sock_ops_reserve_hdr_opt
>> will return -ENOSPC instead of 0.
> 
> Putting aside it adds more checks, this adds something pretty unique to 
> the bpf header option comparing with other dynamic options like sack. 
> e.g. For tp->mss_cache, I assume it won't change since the earlier 
> tcp_current_mss() was called?
> 

Agreed, this check is very unique comparing with other dynamic options.
How about moving the check into function bpf_skops_hdr_opt_len? It
already has some logic to check if the context is in tcp_current_mss.
Does it look more reasonable?

`reserved_opt_spc = tp->mss_cache - tcp_skb_seglen(skb)`
For tp->mss_cache here, yes, I also think it won't change,

I am trying to get the reserved bpf hdr size. Considering other dynamic
options, this equation is not precise, and may change it to
`reserved_opt_spc = tp->mss_cache - tcp_skb_seglen(skb) - size`?

Or, not sure if adding a field in tcp_sock to precisely cache the
reserved bpf hdr size is a good idea?

>>
>> We have a use case where we add options to some packets kind of randomly
>> for the purpose of sampling, and accidentally set a larger option size
>> than the reserved size. It is the problem of ourselves and takes us
>> some effort to troubleshoot the root cause.
>>
>> If bpf_sock_ops_reserve_hdr_opt can return an error in this case, it
>> could be helpful for users to avoid this mistake.
> 
> The bpf_sk_storage can be used to decide if a sk has been sampled.
> 
> Also, with bpf_cast_to_kern_ctx and bpf_rdonly_cast, all the checks in 
> this patch can be done in the bpf prog itself.
> 

Thanks for pointing this out! Agreed, the check can be implemented in
eBPF progs.

