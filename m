Return-Path: <bpf+bounces-39063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536996E3F3
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71241F217A2
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD4192599;
	Thu,  5 Sep 2024 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eyH2cDZk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C091D515
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567658; cv=none; b=LRfiKBfjfyQ7b0IxWtn3+T8aWJ/zaVvPRV6bxq8LeuoWVr+5GcE/zhl2x3dfy8dD+ITjGHx0IuPc2Abv6P9GikQX3Qe5VJGYK1goUBgrEePLd/Dln09XIasxs6EjOEStIfS3HT3awA+fyhwun8JmaYHRKHIf7gUjf1SxTlsijhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567658; c=relaxed/simple;
	bh=GBXFjPobaaHx84AxU7inX5pUA9Ae8gEDxQPmFQv4WZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Az+wADvj4b55MNC5KSao7P1koRn0CR0gK1fBLd8Vj1EM1DZHVBDDdx+ki+gG38s+4Ux4if3ERNkX4SrFNm53J3yn58/gZQxqmiUZ6JqzWvdqdzmqo5d3m0EkNTZsyM3lKo3u1YsBZWMgXxh74sPD97mIXhH+XS6O8vwBx7/WSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eyH2cDZk; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5dfa315ffbdso798567eaf.3
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725567655; x=1726172455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFqjd9OEga2fLWXw9Ls/sQgBu7VuY3xcf5ug2DQkDPc=;
        b=eyH2cDZkjkWQWJZMZXG3RhT9Vb/xSOHqvpw3gsxVEWq4VUP03vT79aQGRjM3Hjs+E0
         VfKT8dIKC8/h3XJsbF2NH4pSF9TT/FWOE7gOmXTxvRcbaMFrRgeVnw732aWE0Z9QxLsk
         k6uCLgr6lWoi9Pbi4GowMu+ygnuLnFStyqM6NdRSoI73JXoNbuL7yo2q2B2I0agtRSlJ
         AXJFORWw8P7TEPIEdJNd45Oq0eq3cys9QtnpPg/WPhwe7kuRQEEViK6ki1jDBROvqX4x
         N1p4+BNnfOe2wfAwrGmD5yYVPBUBWeLsfH8VLsp/xzXyF77YwcoQ2L2tnWuwC9+iEfkZ
         RKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567655; x=1726172455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFqjd9OEga2fLWXw9Ls/sQgBu7VuY3xcf5ug2DQkDPc=;
        b=gaP16lM9tbbY+XkyV20dtR38333NpNr6GLAkM13ZYoYqD4eldPvhjPSQfLBy3i1Dsj
         +jrBDDDZ+yG4nH4EflBoOTPkWui6+QvhXBaVsaR+MZuKppXjcfLlKh6FBugG/jSyt/EK
         ++Ar7VgCUI0v52UovZ+ZE/zDV/vewrouIjCTevPIZIPW0Ikmfc0attRavJ49j5Oz8X9K
         ZRm0Wl/Ldhc3gxsmzVSyffwxxKzdstIT6z0uc06za527htAquIhhh1FbpfD+h6rxVmGZ
         yqaIZANL+itke9IxVZvSsjtzEGeHs/9Jo+U46OnELmHtTG9K/zdIYkXnBu0Ueh5ZdimW
         hJGg==
X-Gm-Message-State: AOJu0YxNz37jVMkiFtLwqAHO6Rdb3zc46jhJ+VZCsR2+9FpSms3Isr/8
	lbvqtjC3O30Dc6dkinIahmSQZX9DeKJlTrPnv8n/t4JmD4ug2j7YaYGjFYa9C3I=
X-Google-Smtp-Source: AGHT+IHye0K0BODVZ7adrvHrHRdSwGp1KOqNYB5dADIbfHMNYKX/sr7v2T88bDtlOy68DQ2cE+9YAQ==
X-Received: by 2002:a05:6358:c02a:b0:1b8:33fc:ae71 with SMTP id e5c5f4694b2df-1b833fcaeb5mr168031655d.16.1725567655136;
        Thu, 05 Sep 2024 13:20:55 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f00f9b6sm105203385a.124.2024.09.05.13.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 13:20:54 -0700 (PDT)
Message-ID: <7ce7a2f7-d1d5-43c1-9d44-97bfedc6c123@bytedance.com>
Date: Thu, 5 Sep 2024 13:20:49 -0700
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
 <58d770f9-18c7-435b-b14f-215482ee151f@bytedance.com>
 <c56c516a-3e9d-4e42-b5e8-527d6f4cf74b@linux.dev>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <c56c516a-3e9d-4e42-b5e8-527d6f4cf74b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 12:38 PM, Martin KaFai Lau wrote:
> On 9/5/24 11:19 AM, Zijian Zhang wrote:
>> On 9/3/24 3:38 PM, Martin KaFai Lau wrote:
>>> On 8/30/24 2:02 PM, Zijian Zhang wrote:
>>>> On 8/28/24 6:00 PM, Martin KaFai Lau wrote:
>>>>> On 8/28/24 4:01 PM, Zijian Zhang wrote:
>>>>>> On 8/28/24 2:29 PM, Martin KaFai Lau wrote:
>>>>>>> On 8/26/24 6:37 PM, zijianzhang@bytedance.com wrote:
>>>>>>>> From: Amery Hung <amery.hung@bytedance.com>
>>>>>>>>
>>>>>>>> This series prevents sockops users from accidentally causing packet
>>>>>>>> drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
>>>>>>>> reserves different option lengths in tcp_sendmsg().
>>>>>>>>
>>>>>>>> Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be 
>>>>>>>> called to
>>>>>>>> reserve a space in tcp_send_mss(), which will return the MSS for 
>>>>>>>> TSO.
>>>>>>>> Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in 
>>>>>>>> __tcp_transmit_skb()
>>>>>>>> again to calculate the actual tcp_option_size and skb_push() the 
>>>>>>>> total
>>>>>>>> header size.
>>>>>>>>
>>>>>>>> skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, 
>>>>>>>> which is
>>>>>>>> derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
>>>>>>>> reserved opt size is smaller than the actual header size, the 
>>>>>>>> len of the
>>>>>>>> skb can exceed the MTU. As a result, ip(6)_fragment will drop the
>>>>>>>> packet if skb->ignore_df is not set.
>>>>>>>>
>>>>>>>> To prevent this accidental packet drop, we need to make sure the
>>>>>>>> second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves 
>>>>>>>> space
>>>>>>>> not more than the first time. 
>>>>>>>
>>>>>>> iiuc, it is a bug in the bpf prog itself that did not reserve the 
>>>>>>> same header length and caused a drop. It is not the only drop 
>>>>>>> case though for an incorrect bpf prog. There are other cases 
>>>>>>> where a bpf prog can accidentally drop a packet.
>>>>>>>
>>>>>>> Do you have an actual use case that the bpf prog cannot reserve 
>>>>>>> the correct header length for the same sk ?
>>>>>>
>>>>>> That's right, it's the bug of the bpf prog itself. We are trying 
>>>>>> to have
>>>>>> the error reported earlier in eBPF program, instead of successfully
>>>>>> returning from bpf_sock_ops_reserve_hdr_opt but leading to packet 
>>>>>> drop
>>>>>> at the end because of it.
>>>>>>
>>>>>> By adding this patch, the `remaining` variable passed to the
>>>>>> bpf_skops_hdr_opt_len will be more precise, it takes the previously
>>>>>> reserved size into account. As a result, if users accidentally set an
>>>>>> option size larger than the reserved size, 
>>>>>> bpf_sock_ops_reserve_hdr_opt
>>>>>> will return -ENOSPC instead of 0.
>>>>>
>>>>> Putting aside it adds more checks, this adds something pretty 
>>>>> unique to the bpf header option comparing with other dynamic 
>>>>> options like sack. e.g. For tp- >mss_cache, I assume it won't 
>>>>> change since the earlier tcp_current_mss() was called?
>>>>>
>>>>
>>>> Agreed, this check is very unique comparing with other dynamic options.
>>>> How about moving the check into function bpf_skops_hdr_opt_len? It
>>>> already has some logic to check if the context is in tcp_current_mss.
>>>> Does it look more reasonable?
>>>
>>> Yes, it probably may be better to put that into the 
>>> bpf_skops_hdr_opt_len(). This is implementation details which is 
>>> something for later after figuring out if the reserved_opt_spc change 
>>> is correct and needed.
>>>
>>>>
>>>> `reserved_opt_spc = tp->mss_cache - tcp_skb_seglen(skb)`
>>>> For tp->mss_cache here, yes, I also think it won't change,
>>>
>>> This needs more details and clear explanation on why it is the case 
>>> and why the existing regular bpf prog will continue to work.
>>>
>>> afaik, mss_cache and tcp_skb_seglen() must be in-sync and the same 
>>> between calls for this to work . From thinking about it, it should be 
>>> but I haven't looked at all cases. Missing "- size" does not help the 
>>> confidence here also.
>>>
>>> Also, when "skb != NULL", I don't understand why the 
>>> "MAX_TCP_OPTION_SPACE - size" is still being considered. I am likely 
>>> missing something here. If the above formula is correct, why 
>>> reserved_opt_spc is not always used for the "skb != NULL" case and 
>>> still need to be compared with the "MAX_TCP_OPTION_SPACE - size"?
>>>
>>
>> Cases I can think of are as follows,
>> - When it's not a GSO skb, tcp_skb_seglen will simply return skb->len,
>> it might make `tp->mss_cache - tcp_skb_seglen(skb)` a large number.
>>
>> - When we are in tcp_mtu_probe, tp->mss_cache will be smaller than
>> tcp_skb_seglen(skb), which makes the equation again a large number.
> 
> In tcp_mtu_probe, mss_cache is (smaller) than the tcp_skb_seglen(skb)?
> 

```
tcp_init_tso_segs(nskb, nskb->len);
if (!tcp_transmit_skb(sk, nskb, 1, GFP_ATOMIC)) ...
```

In the tcp_transmit_skb inside tcp_mtu_probe, it tries to send an skb
with larger mss, so I assume mss_cache will be smaller than
tcp_skb_seglen(skb). Sorry for the confusion here.

>>
>>
>> "MAX_TCP_OPTION_SPACE - size" is considered here as the strict upper
>> bound, while reserved_opt_spc is expected to be a stricter upper bound.
>> In the above or other cases, where the equation malfunctioned, we can
>> always fall back to the original bound.
> 
> Make sense. Thanks for the explanation. The commit message could have 
> used this details.
> 

No problem ;)

>>
>>
>> I am not sure which way to get the reserved size is better,
>> 1. We could precisely cache the result of the reserved size, may
>> need to have a new field for it, I agree that a field in tcp_sock
>> is overkill.
>>
>> 2. In this patch, we use an equation to infer the value of it. There are
>> some concerns with tp->mss_cache and tcp_skb_seglen(skb) here, I agree.
>> If tp->mss_cache and tcp_skb_seglen(skb) might not be in-sync, we may
>> have an underestimated reserved_opt_spc, it may break existing bpf
>> progs. If this method is preferred I will do more investigations to
>> verify it or modify the equation :)
> 
> imo, the bpf prog can always use bpf_sk_storage to add fields to a sock 
> and store the previous reserved space there. I think this is the 
> solution you should use in your use case which randomly reserves header 
> space. Adding a field in the tcp_sock feels wrong especially the only 
> use case I am hearing so far is a bpf prog randomly reserving header 
> spaces.

Agree, thanks for the suggestion.

> 
> If (2) can be convinced to be correct, improving bpf_reserve_hdr_opt() 
> is fine as long as it does not break the existing program. I expect some 
> tests to cover this.
> 

Got it, will take a further look and do more tests.


