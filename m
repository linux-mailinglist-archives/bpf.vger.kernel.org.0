Return-Path: <bpf+bounces-38848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E804896AC4F
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 00:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701871F257C5
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 22:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CD71D5886;
	Tue,  3 Sep 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rRbHe+4Y"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A038186E30
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403128; cv=none; b=LL7YK0CkvnnPEtF5VEDEUTpZ6PkyXaFujEMycq1/Y3MrJWUM7txTZ6ktZWJXtuOYDauz3cHk3ZPdVkP2kesXen6cCDC4d7c9ZMBRXmzARjI6U9mqFtilV5bV3e5Gb8QstzpshYtogm0MQhBLFCTZ1opVL0dzUxRFuv1Jy3MENPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403128; c=relaxed/simple;
	bh=X6IUOnTnRZm1y7kr//U9s+ZyMEUUkv17EGxS2BzcMjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/G63FCredBXBj4VZo3UelJ4yxHnAUJ/PfyDGJ1RF6Q5GilPTWnyShRjCuy0ehQ+VdKOk1z5PAb2zvEyqdGGR2jnG3bRqwH89iWdnkq0tH5vea5GfouxHMoSFFIUaa/FiQG22f5a7e9/PED+sKXM1UU+h2oFgb0jk+1Swhx5osU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rRbHe+4Y; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d89a6a41-c109-4033-8eba-1e11c3c6d1f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725403122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKLTs9vE6ldTR2fYfArYae53vbo7wVi47bV19fVWdC4=;
	b=rRbHe+4YWenvPO9Ji3Et/gOEbhIu1+RgILnfEcT/jW+31UaomOjIGHDvKjrBVHMToecpIs
	Z/7i5QZsiWn9m0bW6UozkkePI7OunUxdhc/wiLvaPSLf4C9jfLU/WG5dKAwdMXVEF2pEDa
	+rtOPgCyefrP62B8Sl6zMhNe5qddnUM=
Date: Tue, 3 Sep 2024 15:38:35 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <3e387788-1f5a-4159-9ff5-e53e897ae41c@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/30/24 2:02 PM, Zijian Zhang wrote:
> On 8/28/24 6:00 PM, Martin KaFai Lau wrote:
>> On 8/28/24 4:01 PM, Zijian Zhang wrote:
>>> On 8/28/24 2:29 PM, Martin KaFai Lau wrote:
>>>> On 8/26/24 6:37 PM, zijianzhang@bytedance.com wrote:
>>>>> From: Amery Hung <amery.hung@bytedance.com>
>>>>>
>>>>> This series prevents sockops users from accidentally causing packet
>>>>> drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
>>>>> reserves different option lengths in tcp_sendmsg().
>>>>>
>>>>> Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be called to
>>>>> reserve a space in tcp_send_mss(), which will return the MSS for TSO.
>>>>> Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in __tcp_transmit_skb()
>>>>> again to calculate the actual tcp_option_size and skb_push() the total
>>>>> header size.
>>>>>
>>>>> skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, which is
>>>>> derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
>>>>> reserved opt size is smaller than the actual header size, the len of the
>>>>> skb can exceed the MTU. As a result, ip(6)_fragment will drop the
>>>>> packet if skb->ignore_df is not set.
>>>>>
>>>>> To prevent this accidental packet drop, we need to make sure the
>>>>> second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
>>>>> not more than the first time. 
>>>>
>>>> iiuc, it is a bug in the bpf prog itself that did not reserve the same 
>>>> header length and caused a drop. It is not the only drop case though for an 
>>>> incorrect bpf prog. There are other cases where a bpf prog can accidentally 
>>>> drop a packet.
>>>>
>>>> Do you have an actual use case that the bpf prog cannot reserve the correct 
>>>> header length for the same sk ?
>>>
>>> That's right, it's the bug of the bpf prog itself. We are trying to have
>>> the error reported earlier in eBPF program, instead of successfully
>>> returning from bpf_sock_ops_reserve_hdr_opt but leading to packet drop
>>> at the end because of it.
>>>
>>> By adding this patch, the `remaining` variable passed to the
>>> bpf_skops_hdr_opt_len will be more precise, it takes the previously
>>> reserved size into account. As a result, if users accidentally set an
>>> option size larger than the reserved size, bpf_sock_ops_reserve_hdr_opt
>>> will return -ENOSPC instead of 0.
>>
>> Putting aside it adds more checks, this adds something pretty unique to the 
>> bpf header option comparing with other dynamic options like sack. e.g. For tp- 
>> >mss_cache, I assume it won't change since the earlier tcp_current_mss() was 
>> called?
>>
> 
> Agreed, this check is very unique comparing with other dynamic options.
> How about moving the check into function bpf_skops_hdr_opt_len? It
> already has some logic to check if the context is in tcp_current_mss.
> Does it look more reasonable?

Yes, it probably may be better to put that into the bpf_skops_hdr_opt_len(). 
This is implementation details which is something for later after figuring out 
if the reserved_opt_spc change is correct and needed.

> 
> `reserved_opt_spc = tp->mss_cache - tcp_skb_seglen(skb)`
> For tp->mss_cache here, yes, I also think it won't change,

This needs more details and clear explanation on why it is the case and why the 
existing regular bpf prog will continue to work.

afaik, mss_cache and tcp_skb_seglen() must be in-sync and the same between calls 
for this to work . From thinking about it, it should be but I haven't looked at 
all cases. Missing "- size" does not help the confidence here also.

Also, when "skb != NULL", I don't understand why the "MAX_TCP_OPTION_SPACE - 
size" is still being considered. I am likely missing something here. If the 
above formula is correct, why reserved_opt_spc is not always used for the "skb 
!= NULL" case and still need to be compared with the "MAX_TCP_OPTION_SPACE - size"?

> 
> I am trying to get the reserved bpf hdr size. Considering other dynamic
> options, this equation is not precise, and may change it to
> `reserved_opt_spc = tp->mss_cache - tcp_skb_seglen(skb) - size`?

"- size" is needed. The test did not catch it?

> 
> Or, not sure if adding a field in tcp_sock to precisely cache the
> reserved bpf hdr size is a good idea?

imo, adding one field in tcp_sock for this is overkill.

It seems your bpf prog is randomly reserving space. If this is the case, giving 
a fail signal in bpf_reserve_hdr_opt() does not improve the success rate for 
your random bpf prog to reserve header. I don't think adding a field or the 
change in this patch really solves anything in your randomly reserving space use 
case ?

> 
>>>
>>> We have a use case where we add options to some packets kind of randomly
>>> for the purpose of sampling, and accidentally set a larger option size
>>> than the reserved size. It is the problem of ourselves and takes us
>>> some effort to troubleshoot the root cause.
>>>
>>> If bpf_sock_ops_reserve_hdr_opt can return an error in this case, it
>>> could be helpful for users to avoid this mistake.
>>
>> The bpf_sk_storage can be used to decide if a sk has been sampled.
>>
>> Also, with bpf_cast_to_kern_ctx and bpf_rdonly_cast, all the checks in this 
>> patch can be done in the bpf prog itself.
>>
> 
> Thanks for pointing this out! Agreed, the check can be implemented in
> eBPF progs.


