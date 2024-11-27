Return-Path: <bpf+bounces-45755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A269DAEA8
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6C8282088
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B752202F6A;
	Wed, 27 Nov 2024 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UPIrU8yd"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03219885D
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732740901; cv=none; b=YKxkg1/jbTHilabBoGcZrLR2YCfj+OqIpoExFNuBCou8V5oqkLMmnICLNKp2Tmjii6GcKvUCMrBZKsdAR5JP2zuKYuSsUjOqjEz+lzSYHYdT9zYCrW0PkZO1uoAyOBYmIgBL5ipozleAz7kJYcVgvfEQ8+1aC/i3mG/SBe9CS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732740901; c=relaxed/simple;
	bh=4skVQellwOqYGRiovGbCtZVr/T7fMA9BSRqxnWFOgxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AV4gAjclFGjxgw7o52LjNmRhUyZSI1jxcnfk+/iZE17Vknp3iQAzZ3O9bYsQLJz4+daLodQ7pyQWDR1VuS2iVQDGQ254STvAoeWrI14mBBU1hqhGr+ayDPOzLxAPkuGXCUqY/q0Pl7KZaj4/PeKUWxR9v0vENg6T5Vdh19dIjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UPIrU8yd; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d1e95498-4613-43e0-bc6b-6f6157802649@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732740897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbHhYQdAxtCG5GrYaKwcMXOAfucu73yI0Yldf1hEGZM=;
	b=UPIrU8ydnJWg5ioc3r6kGmVgNcMp/9Z33Jv2Lk6wdAn6VGgZgEM0Q9O52Gr1j1K9gHO4hj
	0gkc9a/24CU0u5nhCswAB8gc6uBgTkuKzHKcvy3zNf9ud5ye8G+AZtN6dmaEuITL3ldCzO
	oaLYoXNvkJLn4yQDEdKzxg6+EmpKj0U=
Date: Wed, 27 Nov 2024 12:54:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [External] Storing sk_buffs as kptrs in map
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Amery Hung <amery.hung@bytedance.com>, bpf@vger.kernel.org,
 magnus.karlsson@intel.com, sreedevi.joshi@intel.com, ast@kernel.org
References: <Z0X/9PhIhvQwsgfW@boxer>
 <CAONe225n=HosL1vBOOkzaOnG9jTYpQwDH6hwyQRAu0Cb=NBymA@mail.gmail.com>
 <d854688a-9d2d-4fed-9cb8-3e5c4498f165@linux.dev> <Z0dt/wZZhigcgGPI@boxer>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Z0dt/wZZhigcgGPI@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/27/24 11:07 AM, Maciej Fijalkowski wrote:
> But kfunc does not work on PTR_TO_CTX - it takes in directly sk_buff, not
> __sk_buff. As I mention above we use bpf_cast_to_kern_ctx() and per my
> current limited understanding it overwrites the reg->type to
> PTR_TO_BTF_ID | PTR_TRUSTED.

Can you try skip calling the bpf_cast_to_kern_ctx and directly pass the "struct 
__sk_buff *skb" to the "struct sk_buff *bpf_skb_acquire(struct __sk_buff *skb).

> I tried to simplify the use case that customer has, but I am a bit worried
> that it might only confuse people more :/ however, here it is:

No. not at all. I suspect the use case has some similarity to the net-timestamp 
patches 
(https://lore.kernel.org/bpf/20241028110535.82999-1-kerneljasonxing@gmail.com/) 
which uses a skb tskey to associate/co-relate different timestamp.

Please share the patch and the test case. It will be easier for others to help.

> On TC egress hook skb is stored in a map - reason for picking it over the
> linked list or rbtree is that we want to be able to access skbs via some index,
> say a hash. This is where we bump the skb's refcount via acquire kfunc.
> 
> During TC ingress hook on the same interface, the skb that was previously
> stored in map is retrieved, current skb that resides in the context of
> hook carries the timestamp via metadata. We then use the retrieved skb and
> tstamp from metadata on skb_tstamp_tx() (another kfunc) and finally
> decrement skb's refcount via release kfunc.
> 
> 
> Anyways, since we are able to do similar operations on task_struct
> (holding it in map via kptr), I don't see a reason why wouldn't we allow
> ourselves to do it on sk_buffs, no?

skb holds other things like dev and dst, like someone may be trying to remove 
the netdevice and route...etc. Overall, yes, the skb refcnt will eventually be 
decremented when the map is freed like other kptr (e.g. task) do.


