Return-Path: <bpf+bounces-39048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5CA96E1C4
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6DA1F24856
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 18:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DF117920E;
	Thu,  5 Sep 2024 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NjzDbI+c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46028063C
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560381; cv=none; b=c0pzowiwoB+taNibBk5+vGjCnTZqbDUTbxKfNtUMobtABe4qR2mpJgGYAOJw8eg/kIMjexohlEDJi2dqwXOVnvV2mJTvSsQ9pYIJa36bBCLtqsO+ptcLg2gd6XlkUolkdM8grS6IddbfuTh2T+Cl5DGMCrUz0jTa4NWxAN84CI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560381; c=relaxed/simple;
	bh=09RAxIOFlpiNFzEmsXRSRIyEX2iKAXCEYOBNagnNdFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJwFkl1nOjdVWYXh+QCn/YNiDkGalzB71vtnSZzgF3wXQhOZ96O8lD1URZEW0kn6Hf9zBCvsfNv926FZIUH/T3SwgZk98IymvhWQpf5i+fJSXKM3c45d1nfWAIZvi084JJgIKrOx8o7mjb6kYEfAGAZm24/KifCuWGDshaUYou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NjzDbI+c; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2705d31a35cso740657fac.0
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725560377; x=1726165177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYUTGLcrEafm5uw22f7kXUq5CwQiFFJp5CkFQhefpNM=;
        b=NjzDbI+cHV9/Tp1iLR3cGC56V2arxh0HFHxUu1uZES97XEj7q1c7JourA1NzeEFSub
         1XrKhNK+P8vdRjDWVrBYLhg9hOxrJ0tyllmzrpTHQZor/rO2uUuTcZi589aYM7/VGNav
         P1/bVqu0ZRT/CSFSMrohSbRKIhkwx0qbNq4a7i077wd4/hE7WUqZwc/gOjCinMjjDlPe
         QVoYtAd1YDuD0lQ7GS0K/6JRMFxzjRq+4Xghft/+dR3fGYh13XE4UNQnDiTpURsUfYbk
         0dRwJ7vYV2vJ9fyPgMQc9Rx1IPm6Kt+yufknWCFeyFcvuNwr01qZQbsJi1FWKc3DRpZU
         Wciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725560377; x=1726165177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYUTGLcrEafm5uw22f7kXUq5CwQiFFJp5CkFQhefpNM=;
        b=JFY7LADuPxHPOU4LLLEgq3K+YywSznDPUb7DbVXGczg405XxT+PTnSyqPtMfF+3pN+
         CZNJ+UJ7oJ8co+K17t6EO6RJstz8Dy7/U1xnuyRonPQDB7JbAIPi+YlHUlBm6xnkecfx
         jKmfo3JCHp/u0rep83lrXsJaHitYSg9D9aSLIWF5rVwaLDnc0Let1+3QfqquypnhYOSk
         5cSu4XfGah90uNnhvybIc+0OydWZK1iecVJveH7XmbDfCGC5pCcSFn4XXilAq5k/2LEY
         taLz6QMfZjLUSJTJIxfU9JWMWoxsxQnftxPehA5G2tn2Nx0KQGhxX7NWIZiKM8F79+Ni
         W8lw==
X-Gm-Message-State: AOJu0Yy3DImmHDk7dA5Q6/+4mYMj77wA9EK0/Bxg+A7DcwEGeejRKUaM
	Y6qbrePq2hLfrY0rEkUhYsJ8bdAIA2X+GvaU10mkNA+0Kpxd7sdz4epc9sViEq8=
X-Google-Smtp-Source: AGHT+IGB1Xuku1YHdxthwh26nGMPfCOGTyUC5UVHr1R6z+DtUYH/5NVmkEGonuDfyPlnXStIGb1+uQ==
X-Received: by 2002:a05:6871:ca6a:b0:260:f50e:923f with SMTP id 586e51a60fabf-27b8302a3d1mr95767fac.42.1725560377585;
        Thu, 05 Sep 2024 11:19:37 -0700 (PDT)
Received: from [10.73.215.90] ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f007c8esm95949285a.102.2024.09.05.11.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 11:19:37 -0700 (PDT)
Message-ID: <58d770f9-18c7-435b-b14f-215482ee151f@bytedance.com>
Date: Thu, 5 Sep 2024 11:19:31 -0700
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
 Amery Hung <amery.hung@bytedance.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, xiyou.wangcong@gmail.com, wangdongdong.6@bytedance.com,
 zhoufeng.zf@bytedance.com
References: <20240827013736.2845596-1-zijianzhang@bytedance.com>
 <20240827013736.2845596-2-zijianzhang@bytedance.com>
 <5186a69b-c53d-4afa-b3be-e6bd272d264f@linux.dev>
 <955cb3be-1dc4-4ebf-b0de-75c25f393c1e@bytedance.com>
 <c9cf1c15-5038-4c85-be80-5fff34a2df44@linux.dev>
 <3e387788-1f5a-4159-9ff5-e53e897ae41c@bytedance.com>
 <d89a6a41-c109-4033-8eba-1e11c3c6d1f6@linux.dev>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <d89a6a41-c109-4033-8eba-1e11c3c6d1f6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 3:38 PM, Martin KaFai Lau wrote:
> On 8/30/24 2:02 PM, Zijian Zhang wrote:
>> On 8/28/24 6:00 PM, Martin KaFai Lau wrote:
>>> On 8/28/24 4:01 PM, Zijian Zhang wrote:
>>>> On 8/28/24 2:29 PM, Martin KaFai Lau wrote:
>>>>> On 8/26/24 6:37 PM, zijianzhang@bytedance.com wrote:
>>>>>> From: Amery Hung <amery.hung@bytedance.com>
>>>>>>
>>>>>> This series prevents sockops users from accidentally causing packet
>>>>>> drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
>>>>>> reserves different option lengths in tcp_sendmsg().
>>>>>>
>>>>>> Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be 
>>>>>> called to
>>>>>> reserve a space in tcp_send_mss(), which will return the MSS for TSO.
>>>>>> Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in 
>>>>>> __tcp_transmit_skb()
>>>>>> again to calculate the actual tcp_option_size and skb_push() the 
>>>>>> total
>>>>>> header size.
>>>>>>
>>>>>> skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, 
>>>>>> which is
>>>>>> derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
>>>>>> reserved opt size is smaller than the actual header size, the len 
>>>>>> of the
>>>>>> skb can exceed the MTU. As a result, ip(6)_fragment will drop the
>>>>>> packet if skb->ignore_df is not set.
>>>>>>
>>>>>> To prevent this accidental packet drop, we need to make sure the
>>>>>> second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
>>>>>> not more than the first time. 
>>>>>
>>>>> iiuc, it is a bug in the bpf prog itself that did not reserve the 
>>>>> same header length and caused a drop. It is not the only drop case 
>>>>> though for an incorrect bpf prog. There are other cases where a bpf 
>>>>> prog can accidentally drop a packet.
>>>>>
>>>>> Do you have an actual use case that the bpf prog cannot reserve the 
>>>>> correct header length for the same sk ?
>>>>
>>>> That's right, it's the bug of the bpf prog itself. We are trying to 
>>>> have
>>>> the error reported earlier in eBPF program, instead of successfully
>>>> returning from bpf_sock_ops_reserve_hdr_opt but leading to packet drop
>>>> at the end because of it.
>>>>
>>>> By adding this patch, the `remaining` variable passed to the
>>>> bpf_skops_hdr_opt_len will be more precise, it takes the previously
>>>> reserved size into account. As a result, if users accidentally set an
>>>> option size larger than the reserved size, bpf_sock_ops_reserve_hdr_opt
>>>> will return -ENOSPC instead of 0.
>>>
>>> Putting aside it adds more checks, this adds something pretty unique 
>>> to the bpf header option comparing with other dynamic options like 
>>> sack. e.g. For tp- >mss_cache, I assume it won't change since the 
>>> earlier tcp_current_mss() was called?
>>>
>>
>> Agreed, this check is very unique comparing with other dynamic options.
>> How about moving the check into function bpf_skops_hdr_opt_len? It
>> already has some logic to check if the context is in tcp_current_mss.
>> Does it look more reasonable?
> 
> Yes, it probably may be better to put that into the 
> bpf_skops_hdr_opt_len(). This is implementation details which is 
> something for later after figuring out if the reserved_opt_spc change is 
> correct and needed.
> 
>>
>> `reserved_opt_spc = tp->mss_cache - tcp_skb_seglen(skb)`
>> For tp->mss_cache here, yes, I also think it won't change,
> 
> This needs more details and clear explanation on why it is the case and 
> why the existing regular bpf prog will continue to work.
> 
> afaik, mss_cache and tcp_skb_seglen() must be in-sync and the same 
> between calls for this to work . From thinking about it, it should be 
> but I haven't looked at all cases. Missing "- size" does not help the 
> confidence here also.
> 
> Also, when "skb != NULL", I don't understand why the 
> "MAX_TCP_OPTION_SPACE - size" is still being considered. I am likely 
> missing something here. If the above formula is correct, why 
> reserved_opt_spc is not always used for the "skb != NULL" case and still 
> need to be compared with the "MAX_TCP_OPTION_SPACE - size"?
> 

Cases I can think of are as follows,
- When it's not a GSO skb, tcp_skb_seglen will simply return skb->len,
it might make `tp->mss_cache - tcp_skb_seglen(skb)` a large number.

- When we are in tcp_mtu_probe, tp->mss_cache will be smaller than
tcp_skb_seglen(skb), which makes the equation again a large number.


"MAX_TCP_OPTION_SPACE - size" is considered here as the strict upper
bound, while reserved_opt_spc is expected to be a stricter upper bound.
In the above or other cases, where the equation malfunctioned, we can
always fall back to the original bound.


I am not sure which way to get the reserved size is better,
1. We could precisely cache the result of the reserved size, may
need to have a new field for it, I agree that a field in tcp_sock
is overkill.

2. In this patch, we use an equation to infer the value of it. There are
some concerns with tp->mss_cache and tcp_skb_seglen(skb) here, I agree.
If tp->mss_cache and tcp_skb_seglen(skb) might not be in-sync, we may
have an underestimated reserved_opt_spc, it may break existing bpf
progs. If this method is preferred I will do more investigations to
verify it or modify the equation :)

Do you have preference to either option?

>>
>> I am trying to get the reserved bpf hdr size. Considering other dynamic
>> options, this equation is not precise, and may change it to
>> `reserved_opt_spc = tp->mss_cache - tcp_skb_seglen(skb) - size`?
> 
> "- size" is needed. The test did not catch it?
> 
>>
>> Or, not sure if adding a field in tcp_sock to precisely cache the
>> reserved bpf hdr size is a good idea?
> 
> imo, adding one field in tcp_sock for this is overkill.
> 
> It seems your bpf prog is randomly reserving space. If this is the case, 
> giving a fail signal in bpf_reserve_hdr_opt() does not improve the 
> success rate for your random bpf prog to reserve header. I don't think 
> adding a field or the change in this patch really solves anything in 
> your randomly reserving space use case ?
> 

It's true that it won't help with the success rate, but it could help
save packets from being dropped.

The goal is to let bpf_reserve_hdr_opt fail, when it is supposed to.
And, as a bonus effect, it could also save packets from being dropped.

When the accidental mistake happens, we want bpf_reserve_hdr_opt to
fail, so that `sock_ops.remaining_opt_len` won't be updated.
If it is still updated in this case, the packet will be dropped in
ip_fragment because `IPCB(skb)->frag_max_size > mtu`.

>>
>>>>
>>>> We have a use case where we add options to some packets kind of 
>>>> randomly
>>>> for the purpose of sampling, and accidentally set a larger option size
>>>> than the reserved size. It is the problem of ourselves and takes us
>>>> some effort to troubleshoot the root cause.
>>>>
>>>> If bpf_sock_ops_reserve_hdr_opt can return an error in this case, it
>>>> could be helpful for users to avoid this mistake.
>>>
>>> The bpf_sk_storage can be used to decide if a sk has been sampled.
>>>
>>> Also, with bpf_cast_to_kern_ctx and bpf_rdonly_cast, all the checks 
>>> in this patch can be done in the bpf prog itself.
>>>
>>
>> Thanks for pointing this out! Agreed, the check can be implemented in
>> eBPF progs.
> 


