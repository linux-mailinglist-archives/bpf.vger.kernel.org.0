Return-Path: <bpf+bounces-38335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BE2963729
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 03:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAF01C21366
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 01:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5F1B949;
	Thu, 29 Aug 2024 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cVW+XSa8"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC4211C
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893250; cv=none; b=benZ/QqKRXBXSfhfluREzAYIRjAX4+cUnK2JlCX5YWOgfczdwqGtGNaj5hLWSQuSkgd/GPI8Y8jAmjeRzCnGGUP1fCOYmWAzIwho+4z1I8dem0hBc7ZKBHofY96BJVvF0pY4w+WQVLmQ4Dfvn1CVY50Cds7kVToU6mGoSzXq3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893250; c=relaxed/simple;
	bh=4pQDqnWyAKTAknROCYlqFHj1MYlYDBqbmyV7fQih7FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZNG2Ghd7WYm0Bjobi+dYRNthLnzU5N//9e3zmJCzpx+gLwVvO7ypwgt/qkE7gPTfcIbZUfVwj8RgoIwf63hDingfsR08d+m+IvEBj77PJXT5hx9pLpDcX12qhD8KMJpkeSUEnXNMfxwP236Onmr1Kyeo4ohhL3rxlxDVAkW32g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cVW+XSa8; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9cf1c15-5038-4c85-be80-5fff34a2df44@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724893246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIcQlwIxH1XcfGMDeSQVy1CHuj1BX1bN9LhFWGVEFMg=;
	b=cVW+XSa8NW69O2btWyTGwBDWlORdrVq5xQoRfsj+DdD7QEPokngH61qwzCZSolDvC4Qb2d
	jfsHS9+Wx8+CE9pfP/hDdhaUwylbD8fhKpl2Ui1UDIjUUjvexOojZlnVfZNDrPMKrDm8o6
	6mSIvllOt5bfqsgcHkxPsTmwmZAN1T8=
Date: Wed, 28 Aug 2024 18:00:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: tcp: prevent bpf_reserve_hdr_opt()
 from growing skb larger than MTU
To: Zijian Zhang <zijianzhang@bytedance.com>,
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <955cb3be-1dc4-4ebf-b0de-75c25f393c1e@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/24 4:01 PM, Zijian Zhang wrote:
> On 8/28/24 2:29 PM, Martin KaFai Lau wrote:
>> On 8/26/24 6:37 PM, zijianzhang@bytedance.com wrote:
>>> From: Amery Hung <amery.hung@bytedance.com>
>>>
>>> This series prevents sockops users from accidentally causing packet
>>> drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
>>> reserves different option lengths in tcp_sendmsg().
>>>
>>> Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be called to
>>> reserve a space in tcp_send_mss(), which will return the MSS for TSO.
>>> Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in __tcp_transmit_skb()
>>> again to calculate the actual tcp_option_size and skb_push() the total
>>> header size.
>>>
>>> skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, which is
>>> derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
>>> reserved opt size is smaller than the actual header size, the len of the
>>> skb can exceed the MTU. As a result, ip(6)_fragment will drop the
>>> packet if skb->ignore_df is not set.
>>>
>>> To prevent this accidental packet drop, we need to make sure the
>>> second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
>>> not more than the first time. 
>>
>> iiuc, it is a bug in the bpf prog itself that did not reserve the same header 
>> length and caused a drop. It is not the only drop case though for an incorrect 
>> bpf prog. There are other cases where a bpf prog can accidentally drop a packet.
>>
>> Do you have an actual use case that the bpf prog cannot reserve the correct 
>> header length for the same sk ?
> 
> That's right, it's the bug of the bpf prog itself. We are trying to have
> the error reported earlier in eBPF program, instead of successfully
> returning from bpf_sock_ops_reserve_hdr_opt but leading to packet drop
> at the end because of it.
> 
> By adding this patch, the `remaining` variable passed to the
> bpf_skops_hdr_opt_len will be more precise, it takes the previously
> reserved size into account. As a result, if users accidentally set an
> option size larger than the reserved size, bpf_sock_ops_reserve_hdr_opt
> will return -ENOSPC instead of 0.

Putting aside it adds more checks, this adds something pretty unique to the bpf 
header option comparing with other dynamic options like sack. e.g. For 
tp->mss_cache, I assume it won't change since the earlier tcp_current_mss() was 
called?

> 
> We have a use case where we add options to some packets kind of randomly
> for the purpose of sampling, and accidentally set a larger option size
> than the reserved size. It is the problem of ourselves and takes us
> some effort to troubleshoot the root cause.
> 
> If bpf_sock_ops_reserve_hdr_opt can return an error in this case, it
> could be helpful for users to avoid this mistake.

The bpf_sk_storage can be used to decide if a sk has been sampled.

Also, with bpf_cast_to_kern_ctx and bpf_rdonly_cast, all the checks in this 
patch can be done in the bpf prog itself.


