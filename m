Return-Path: <bpf+bounces-65778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AF1B28376
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 18:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5998F7AFF83
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15602288C06;
	Fri, 15 Aug 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAEGF1EX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDFC1F8755;
	Fri, 15 Aug 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273738; cv=none; b=AbEBye4h3wJ0IYhVxPNbmonK4WIFXSCPt+Uw2sEy4eXjuWhJHLkRrEndU8NjajDe7pRvdvhbVXuYOcb6rc3gXhXTJcXPloh5hb3aonO9VDIaJ+BByOqZNrtcSHGOwwHBrJZ7EMZ/vp+b63q+qGjIlJ5i0/fK0AV9+A41hTjoz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273738; c=relaxed/simple;
	bh=EVeXf5DHgq/R35/vUFneA1F4tcvpW3hzv8O4VHd7Fuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lT3vI8/4njPA6zJqn/uL1k3rHhPEitnHlvVVFkhAkoiYWpu6fPQBONxDtP21Zz/p+ijUpro7ulLAhjLGAoG7mN/Jsqzm8WG7jX6pSfFgBY22Tb699FyKYRmWMmrIBdVl+7EMXuaiE242x3RCmDkEuRAXiDmf9iVCzIclv5Grn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAEGF1EX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB5AC4CEEB;
	Fri, 15 Aug 2025 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755273737;
	bh=EVeXf5DHgq/R35/vUFneA1F4tcvpW3hzv8O4VHd7Fuc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UAEGF1EXXAoCrZRGndPLZaZjuPJchf0J+XNZux88o5sGekqwHCnhVhoAtFdIjr6TM
	 2elB2n5o9y6fp2gk/oXaU046VfIOh2l9thP6mK/Rahpjvm21H403+v+jsNxefQeST6
	 zVqVB3We0TCbiQF4BBJcOho3jOef5WVREWOlJWH0ORnvwsOCC5XYa3lStZq62piFZf
	 LByFCdWHhcaB8EjlXQOWXAvoWfPaBOQ7ZE87bzSH3xpnlGHq4mFfAEzJWDN5rBTnnX
	 fK4ssSTF5UYKCfpumINaIEL+DY4qcMr4TVCKPbZS3gFIPofSdAEYYwgnEV/E2b5k/B
	 KtHcsWVXu1QNg==
Message-ID: <bd1a2f1f-20bb-4cc0-82ed-150c5e36b1da@kernel.org>
Date: Fri, 15 Aug 2025 18:02:10 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] mlx5_core memory management issue
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Chris Arges
 <carges@cloudflare.com>, Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>, tariqt@nvidia.com,
 saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Rzeznik <arzeznik@cloudflare.com>, Yan Zhai <yan@cloudflare.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mina Almasry <almasrymina@google.com>
References: <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
 <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
 <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
 <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
 <aJuxY9oTtxSn4qZP@861G6M3> <aJzfPFCTlc35b2Bp@861G6M3>
 <5hinwlan55y6fl6ocilg7iccatuu5ftiyruf7wwfi44w5b4gpa@ainmdlgjtm5g>
 <4zkm7dmkxhfhf3cm7eniim26z6nbp3zsm4qttapg3xbvkrqhro@cvjnbr624m5h>
 <e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org>
 <tyioy6vj2os2lnlirqxdbiwdaquoxd64lf3j3quqmyz6qvryft@xrfztbgfk7td>
 <8d165026-1477-46cb-94d4-a01e1da40833@kernel.org>
 <20250815075929.6a19662d@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250815075929.6a19662d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/08/2025 16.59, Jakub Kicinski wrote:
> On Thu, 14 Aug 2025 17:58:21 +0200 Jesper Dangaard Brouer wrote:
>> Found-by: Dragos Tatulea <dtatulea@nvidia.com>
> 
> ENOSUCHTAG?
>

I pre-checked that "Found-by:" have already been used 32 times in git-
history. But don't worry, Martin applied it such that it isn't in the
tags section, by removing the ":" and placing it in the desc part.

>> Reported-by: Chris Arges <carges@cloudflare.com>
> 
>>>> The XDP code have evolved since the xdp_set_return_frame_no_direct()
>>>> calls were added.  Now page_pool keeps track of pp->napi and
>>>> pool-> cpuid.  Maybe the __xdp_return [1] checks should be updated?
>>>> (and maybe it allows us to remove the no_direct helpers).
>>>>   
>>> So you mean to drop the napi_direct flag in __xdp_return and let
>>> page_pool_put_unrefed_netmem() decide if direct should be used by
>>> page_pool_napi_local()?
>>
>> Yes, something like that, but I would like Kuba/Jakub's input, as IIRC
>> he introduced the page_pool->cpuid and page_pool->napi.
>>
>> There are some corner-cases we need to consider if they are valid.  If
>> cpumap get redirected to the *same* CPU as "previous" NAPI instance,
>> which then makes page_pool->cpuid match, is it then still valid to do
>> "direct" return(?).
> 
> I think/hope so, but it depends on xdp_return only being called from
> softirq context.. Since softirqs can't nest if producer and consumer
> of the page pool pages are on the same CPU they can't race.

That is true, softirqs can't nest.

Jesse pointed me at the tun device driver, where we in-principle are 
missing a xdp_set_return_frame_no_direct() section. Except I believe, 
that the memory type cannot be page_pool in this driver. (Code hint, 
tun_xdp_act() calls xdp_do_redirect).

The tun driver made me realize, that we do have users that doesn't run 
under a softirq, but they do remember to disable BH. (IIRC BH-disable 
can nest).  Are we also race safe in this case(?).

Is the code change as simple as below or did I miss something?

void __xdp_return
   [...]
   case MEM_TYPE_PAGE_POOL:
    [...]
     if (napi_direct && READ_ONCE(pool->cpuid) != smp_processor_id())
	napi_direct = false;

It is true, that when we exit NAPI, then pool->cpuid becomes -1.
Or what that only during shutdown?

> I'm slightly worried that drivers which don't have dedicated Tx XDP
> rings will clean it up from hard IRQ when netpoll calls. But that'd
> be a bug, right? We don't allow XDP processing from IRQ context.

I didn't consider this code path. But, yes that would be considered a
netpoll bug IMHO.

--Jesper

