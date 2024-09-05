Return-Path: <bpf+bounces-39056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6796E355
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6BC28BEA3
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 19:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64F18EFF8;
	Thu,  5 Sep 2024 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PgrsrglA"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C8B19C579
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565105; cv=none; b=crWO1s6KSpfGOD9XTVs/Ar7c1BMIZqP8VsgcjnZPw6WdRidBPbbYcr43zEJ/JozIaMt+ZgjZUIs2LsFbJi/CWsBI6FMpEbSLYuvUVbwRk7qLsAjIZjw9PuOm0mJl8vK7FO8fMjdXWJQUFjfc+HROWDROyddIusaNiBy3BpyCoAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565105; c=relaxed/simple;
	bh=3ExggAE1QyD2DYyYaJihx7hvOUyecV4KvcpCDvMVJcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WACXGCv5eEmAZXoTknVwFTiYEhQzjIJHokBusDJTOoM96Sb4AGXAtb9FHxAVrsGL7dMkICT7IS78kD9pKm9InzfW+u2ZjKWMGvhxC+0hg0OBY1eIdKYrhEPMr6yQq97wouMUOxWyvAIsKOlJsWGCrx3nenf10toGCwAOCvI7xQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PgrsrglA; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c56c516a-3e9d-4e42-b5e8-527d6f4cf74b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725565099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15TQUMpjY6JMKWXQYXO/ngt/J3iHpVAz84riwxrUbNs=;
	b=PgrsrglAig7cWcbT+SNI9TM8ILC5jf2XhQVOGXvHqla4vXjDX/mVFYps0/S3cecpG/oeL+
	Sb6vh5y3ww9sq6wtrsDWi0rUXtqr3RYgTiMnjj1Ai3xLHU0iP28EiEuDCPXEdw7+ivtUcV
	U5JXU2ehM/kXMTan28iae4udZvZkCjo=
Date: Thu, 5 Sep 2024 12:38:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: tcp: prevent bpf_reserve_hdr_opt()
 from growing skb larger than MTU
To: Zijian Zhang <zijianzhang@bytedance.com>,
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <58d770f9-18c7-435b-b14f-215482ee151f@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/5/24 11:19 AM, Zijian Zhang wrote:
> On 9/3/24 3:38 PM, Martin KaFai Lau wrote:
>> On 8/30/24 2:02 PM, Zijian Zhang wrote:
>>> On 8/28/24 6:00 PM, Martin KaFai Lau wrote:
>>>> On 8/28/24 4:01 PM, Zijian Zhang wrote:
>>>>> On 8/28/24 2:29 PM, Martin KaFai Lau wrote:
>>>>>> On 8/26/24 6:37 PM, zijianzhang@bytedance.com wrote:
>>>>>>> From: Amery Hung <amery.hung@bytedance.com>
>>>>>>>
>>>>>>> This series prevents sockops users from accidentally causing packet
>>>>>>> drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
>>>>>>> reserves different option lengths in tcp_sendmsg().
>>>>>>>
>>>>>>> Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be called to
>>>>>>> reserve a space in tcp_send_mss(), which will return the MSS for TSO.
>>>>>>> Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in __tcp_transmit_skb()
>>>>>>> again to calculate the actual tcp_option_size and skb_push() the total
>>>>>>> header size.
>>>>>>>
>>>>>>> skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, which is
>>>>>>> derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
>>>>>>> reserved opt size is smaller than the actual header size, the len of the
>>>>>>> skb can exceed the MTU. As a result, ip(6)_fragment will drop the
>>>>>>> packet if skb->ignore_df is not set.
>>>>>>>
>>>>>>> To prevent this accidental packet drop, we need to make sure the
>>>>>>> second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
>>>>>>> not more than the first time. 
>>>>>>
>>>>>> iiuc, it is a bug in the bpf prog itself that did not reserve the same 
>>>>>> header length and caused a drop. It is not the only drop case though for 
>>>>>> an incorrect bpf prog. There are other cases where a bpf prog can 
>>>>>> accidentally drop a packet.
>>>>>>
>>>>>> Do you have an actual use case that the bpf prog cannot reserve the 
>>>>>> correct header length for the same sk ?
>>>>>
>>>>> That's right, it's the bug of the bpf prog itself. We are trying to have
>>>>> the error reported earlier in eBPF program, instead of successfully
>>>>> returning from bpf_sock_ops_reserve_hdr_opt but leading to packet drop
>>>>> at the end because of it.
>>>>>
>>>>> By adding this patch, the `remaining` variable passed to the
>>>>> bpf_skops_hdr_opt_len will be more precise, it takes the previously
>>>>> reserved size into account. As a result, if users accidentally set an
>>>>> option size larger than the reserved size, bpf_sock_ops_reserve_hdr_opt
>>>>> will return -ENOSPC instead of 0.
>>>>
>>>> Putting aside it adds more checks, this adds something pretty unique to the 
>>>> bpf header option comparing with other dynamic options like sack. e.g. For 
>>>> tp- >mss_cache, I assume it won't change since the earlier tcp_current_mss() 
>>>> was called?
>>>>
>>>
>>> Agreed, this check is very unique comparing with other dynamic options.
>>> How about moving the check into function bpf_skops_hdr_opt_len? It
>>> already has some logic to check if the context is in tcp_current_mss.
>>> Does it look more reasonable?
>>
>> Yes, it probably may be better to put that into the bpf_skops_hdr_opt_len(). 
>> This is implementation details which is something for later after figuring out 
>> if the reserved_opt_spc change is correct and needed.
>>
>>>
>>> `reserved_opt_spc = tp->mss_cache - tcp_skb_seglen(skb)`
>>> For tp->mss_cache here, yes, I also think it won't change,
>>
>> This needs more details and clear explanation on why it is the case and why 
>> the existing regular bpf prog will continue to work.
>>
>> afaik, mss_cache and tcp_skb_seglen() must be in-sync and the same between 
>> calls for this to work . From thinking about it, it should be but I haven't 
>> looked at all cases. Missing "- size" does not help the confidence here also.
>>
>> Also, when "skb != NULL", I don't understand why the "MAX_TCP_OPTION_SPACE - 
>> size" is still being considered. I am likely missing something here. If the 
>> above formula is correct, why reserved_opt_spc is not always used for the 
>> "skb != NULL" case and still need to be compared with the 
>> "MAX_TCP_OPTION_SPACE - size"?
>>
> 
> Cases I can think of are as follows,
> - When it's not a GSO skb, tcp_skb_seglen will simply return skb->len,
> it might make `tp->mss_cache - tcp_skb_seglen(skb)` a large number.
> 
> - When we are in tcp_mtu_probe, tp->mss_cache will be smaller than
> tcp_skb_seglen(skb), which makes the equation again a large number.

In tcp_mtu_probe, mss_cache is (smaller) than the tcp_skb_seglen(skb)?

> 
> 
> "MAX_TCP_OPTION_SPACE - size" is considered here as the strict upper
> bound, while reserved_opt_spc is expected to be a stricter upper bound.
> In the above or other cases, where the equation malfunctioned, we can
> always fall back to the original bound.

Make sense. Thanks for the explanation. The commit message could have used this 
details.

> 
> 
> I am not sure which way to get the reserved size is better,
> 1. We could precisely cache the result of the reserved size, may
> need to have a new field for it, I agree that a field in tcp_sock
> is overkill.
> 
> 2. In this patch, we use an equation to infer the value of it. There are
> some concerns with tp->mss_cache and tcp_skb_seglen(skb) here, I agree.
> If tp->mss_cache and tcp_skb_seglen(skb) might not be in-sync, we may
> have an underestimated reserved_opt_spc, it may break existing bpf
> progs. If this method is preferred I will do more investigations to
> verify it or modify the equation :)

imo, the bpf prog can always use bpf_sk_storage to add fields to a sock and 
store the previous reserved space there. I think this is the solution you should 
use in your use case which randomly reserves header space. Adding a field in the 
tcp_sock feels wrong especially the only use case I am hearing so far is a bpf 
prog randomly reserving header spaces.

If (2) can be convinced to be correct, improving bpf_reserve_hdr_opt() is fine 
as long as it does not break the existing program. I expect some tests to cover 
this.


