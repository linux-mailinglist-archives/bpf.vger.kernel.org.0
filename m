Return-Path: <bpf+bounces-65447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFF7B23333
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 20:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768361A232E0
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2B0280037;
	Tue, 12 Aug 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CbvtVuqo"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36341282E1
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022859; cv=none; b=SsZ8seUls1kRumddFBsF1HxYQqrjaSZfUyi78VC6mKY2D0hxyervepUcNhYqL0uEX8/N+cfuJYlX/+kdpHHpuCxiEWRDlyXAtOWi1cH0TndS88946PPc1WbVznF7MkLTpLS50ip5HVYdo9jLYLhib751vH75u/gI5h30fw34GpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022859; c=relaxed/simple;
	bh=v/nsCGs2xmu59cnfR1Tz4Wld6szL/A5pJS3oBSOfQp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdrGWAOU+eTySWzLstzAh2cFhqvK0IJ/l71fNW/164L69L/Yl7YMqpWL0bqeWTHS1YR6n4Aq/v6VrhgbNvHs98yyhL2Mz4SNmrqBhvtZrW6P/9YUG3TzOf2CSEyM+AeJb6ACzHNc/kc9cQGQX1huVRB5fP66Crb7bOZ2MpHmri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CbvtVuqo; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff37dd97-dde7-48a3-9bb6-7d424f94e345@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755022845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1oQvtxW/ScS+64KV6i67Bpm+cSlP1i/7We44hEj0RE=;
	b=CbvtVuqoUcEzfe3i81tee05aN0G26f/yHxQG3mDPFX1KzRf0a5GWVZKV79+dOLJIlxiAY4
	kWy3mbvZzljmjmyZvFXljzYxk0f7fTJxx7vfyqOBy/p89Z60A11dNVyLZW5xYPedX1rMc3
	B3wfk7kWzEcUqimaXx/Tmh0I6sZ/tWg=
Date: Tue, 12 Aug 2025 11:20:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: Cover metadata access from
 a modified skb clone
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arthur Fabre <arthur@arthurfabre.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Joanne Koong <joannelkoong@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
 <20250804-skb-metadata-thru-dynptr-v6-9-05da400bfa4b@cloudflare.com>
 <7a73fb00-9433-40d7-acb7-691f32f198ff@linux.dev>
 <87h5yi82gp.fsf@cloudflare.com>
 <e30d66a8-c4de-4d81-880d-36d996b67854@linux.dev>
 <87tt2cr8eb.fsf@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87tt2cr8eb.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/12/25 6:12 AM, Jakub Sitnicki wrote:
>> No strong opinion to either copy the metadata on a clone or set the dynptr
>> rdonly for a clone. I am ok with either way.
>>
>> A brain dump:
>> On one hand, it is hard to comment without visibility on how will it look like
>> when data_meta can be preserved in the future, e.g. what may be the overhead but
>> there is flags in bpf_dynptr_from_skb_meta and bpf_dynptr_write, so there is
>> some flexibility. On the other hand, having a copy will be less surprise on the
>> clone skb like what we have discovered in this and the earlier email thread but
>> I suspect there is actually no write use case on the skb data_meta now.
> 
> All makes sense.
> 
> To keep things simple and consistent, it would be best to have a single
> unclone (bpf_try_make_writable) point caused by a write to metadata
> through an skb clone.
> 
> Today, the unclone in the prologue can already be triggered by a write
> to data_meta from a dead branch. Despite being useless, since
> pskb_expand_head resets meta_len.
> 
> We also need the prologue unclone for bpf_dynptr_slice_rdwr created from
> an skb_meta dynptr, because creating a slice does not invalidate packet
> pointers by contract.
> 
> So I'm thinking it makes sense to unclone in the prologue if we see a
> potential bpf_dynptr_write to skb_meta dynptr as well. This could be
> done by tweaking check_helper_call to set the seen_direct_write flag:
> 
> static int check_helper_call(...)
> {
>          // ...
>         	switch (func_id) {
>          // ...
> 	case BPF_FUNC_dynptr_write:
> 	{
>                  // ...
> 		dynptr_type = dynptr_get_type(env, reg);
>                  // ...
> 		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
> 		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
> 			changes_data = true;

This looks ok.

> 		if (dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
> 			env->seen_direct_write = true;

The "seen_direct_write = true;" addition will be gone from the verifier 
eventually when pskb_expand_head can keep the data_meta (?). Right, there are 
existing cases that the prologue call might be unnecessary. However, I don't 
think it should be the reason that it can set "seen_direct_write" on top of the 
"changes_data". I think it is confusing.

> 
> 		break;
> 	}
>          // ...
> }
> 
> That would my the plan for the next iteration, if it sounds sensible.
> 
> As for keeping metadata intact past a pskb_expand_head call, on second
> thought, I'd leave that for the next patch set, to keep the patch count
> within single digits.

If the plan is to make pskb_expand_head support the data_meta later, just set 
the rdonly bit in the bpf_dynptr_from_skb_meta now. Then the future 
pskb_expand_head change will be a clean change in netdev and filter.c, and no 
need to revert the "seen_direct_write" changes from the verifier.

