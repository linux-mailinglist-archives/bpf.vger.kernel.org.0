Return-Path: <bpf+bounces-43679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0A99B8741
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 00:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6701F22978
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 23:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E21E2609;
	Thu, 31 Oct 2024 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OBd3M8sD"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DFC19C564
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730418667; cv=none; b=UKNkyEcAv4sO8UBQoLmV0hyrmU2d9fxIDg6v9NwEu/7nawtAdztHsniqk3h9d9n7bV/bXtj9KFHM/i7Dou/bpomhyA6rycJ9AyGyRPAeJSGmZwxYfk+MOg530wisBxAd6HS7LRnmsQZ+uc84aqvfuGvelMBfQCyjlm1NJFoDn/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730418667; c=relaxed/simple;
	bh=lYp87BbaFeU2tmq71lq6VGQKwXvGLaAD3fQ8iaUeVmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpWD9TyL/L+T2GDE8zffsq2B8g+aY1Yw53B7C5PCAzpJKBX9Ungc0C5oEMJV02CYA4tIaUcnM6KnfdzPZUFh6tTXx5A1f5QCzOI+QrgOj8McIdlYUJXZyoC9vKf+IpkLLzs+yBRyXspYT/gHu1betdPQsMrO1xQEgEWseRBVcKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OBd3M8sD; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <29a4e6ef-0af0-4905-8511-398fb20619bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730418659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ry3g7bPdkS0fypgvfHnI0eMkQG8ESIEK7GLmsdCO0gE=;
	b=OBd3M8sDDVE8JBjArcswgxwILTwIdjaE8VpvIvSAKoiGPrYWr4Ka0toBxpwtmHVAeStcSd
	Spk9gsOtBcKghUXQDxs7U8cWj/j8casVEbYr3F+1MiYH8ekBVNQkT2Y038XmuhemBT4cw2
	8RbgmujcbSDNrE9l0KxC4P2O6Kn6wcs=
Date: Thu, 31 Oct 2024 16:50:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com>
 <8fd16b77-b8e8-492c-ab69-8192cafa9fc7@linux.dev>
 <CAL+tcoBNiZQr=yk_fb9eoKX1_Nr4LuDaa1kkLGbdnc=8JNKnNg@mail.gmail.com>
 <e56f78a9-cbda-4b80-8b55-c16b36e4efb1@linux.dev>
 <CAL+tcoDi86GkJRd8fShGNH8CgdFu3kbfMubWxCLVdo+3O-wnfg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoDi86GkJRd8fShGNH8CgdFu3kbfMubWxCLVdo+3O-wnfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/30/24 7:41 PM, Jason Xing wrote:
>> bpf prog cannot directly access the skops->skb now. It is because the sockops
>> prog sees the uapi "struct bpf_sock_ops" instead of "struct
>> bpf_sock_ops(_kern)". The conversion is done in sock_ops_convert_ctx_access. It
>> is an old way before BTF. I don't want to extend the uapi "struct bpf_sock_ops".
> 
> Oh, so it seems we cannot use this way, right?

No. don't extend the uapi "struct bpf_sock_ops". Use bpf_cast_to_kern_ctx() instead.

> 
> I also noticed a use case that allow users to get the information from one skb:
> "int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)" in
> tools/testing/selftests/bpf/progs/netif_receive_skb.c
> But it requires us to add the tracepoint in __skb_tstamp_tx() first.
> Two months ago, I was planning to use a tracepoint for some people who
> find it difficult to deploy bpf.


It is a tracing prog instead of sockops prog. The verifier allows accessing 
different things based on the program type. This patch set is using the sockops 
bpf prog type which is not a tracing prog. Tracing can do a lot of read-only 
things but here we need write (e.g. bpf_setsockopt), so tracing prog is not 
suitable here.

> 
>>
>> Instead, use bpf_cast_to_kern_ctx((struct bpf_sock_ops *)skops_ctx) to get a
>> trusted "struct bpf_sock_ops(_kern) *skops" pointer. Then it can access the
>> skops->skb.
> 
> Let me spend some time on it. Thanks.

Take a look at the bpf_cast_to_kern_ctx() examples in selftests/bpf. I think 
this can be directly used to get to (struct bpf_sock_ops_kern *)skops->skb. Ping 
back if your selftest bpf prog cannot load.

> 
>> afaik, the tcb->seq should be available already during sendmsg. it
>> should be able to get it from TCP_SKB_CB(skb)->seq with the bpf_core_cast. Take
>> a look at the existing examples of bpf_core_cast.
>>
>> The same goes for the skb->data. It can use the bpf_dynptr_from_skb(). It is not
>> available to skops program now but should be easy to expose.
 > I wonder what the use of skb->data is here.

You are right, not needed. I was thinking it may need to parse the tcp header 
from the skb at the rx timestamping. It is not needed. The tcp stack should have 
already parsed it and TCP_SKB_CB can be directly used as long as the sockops 
prog can get to the skops->skb.

>>
>> In the bpf prog, when the SCHED/SND/ACK timestamp comes back, it has to find the
>> earlier sendmsg timestamp. One option is to store the earlier sendmsg timestamp
>> at the bpf map key-ed by seqno or the shinfo's tskey. Storing in a bpf map
>> key-ed by seqno/tskey is probably what the selftest should do. In the future, we
>> can consider allowing the rbtree in the bpf sk local storage for searching
>> seqno. There is shinfo's hwtstamp that can be used also if there is a need.
> 
> Thanks for the information! Let me investigate how the bpf map works...
> 
> I wonder that for the selftests could it be much simpler if we just
> record each timestamp stored in three variables and calculate them at
> last since we only send the small packet once instead of using bpf
> map. I mean, bpf map is really good as far as I know, but I'm a bit
> worried that implementing such a function could cause more extra work
> (implementation and review).

Don't worry on the review side. imo, a closer to the real world selftest prog is 
actually helping the review process. It needs to test the tskey anyway and it 
needs to store somewhere. bpf map is pretty simple to use. I don't think it will 
have much different in term of complexity also.

