Return-Path: <bpf+bounces-63759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D9B0AAA4
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 21:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E713B51F8
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0F020485B;
	Fri, 18 Jul 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kntSKkfa"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886E2E8DFE
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866408; cv=none; b=LQRAl/HiqNFRUuChXkCKWz0Hhh/8bAyVFw6ZNrUTiWUE9XEtYhIqWyI5p699XDqXqNp8IdZwFaBbGuWHMuviiTAcFLSnzGyrOPRdU8AgG99ds0jK0nzZSWxBVyRs6vLPkiv2KZeaKFpw/1NAnX9riU85y9ZSRfqqvPnkx+tCays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866408; c=relaxed/simple;
	bh=wZLHt53aY3fMtLI3sTtK6qyEV/CaW185oZJeYYd2qXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2kosINNTYKSrr+Fn3mp6ocrdp0HIGflF60G47XOAk++/Cit7zqKM54Ju/JFHlv2YsX+nlNz2GGn/cqbXOFaUjRf4RpMr0EmDk2oSiFpfh4dcoIxB3c+u50oyAwrCVJkcpOiBE2dNoQ5/pKyWAd+hc26bU1nj1VXiuLLEFDnk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kntSKkfa; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1ae43248-189e-4765-b43c-b80e58160587@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752866392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3xfv7vq4DU0TXCxUYNiqBi0dkydLio+zoySe66/4wc=;
	b=kntSKkfaSEMHK/jORdBwwpPS1mZJY/UXMT7moS/2i5ZegsiWaknOod6sy8DfgXjZXKH9KQ
	r2tYYF7w8HRs4Isyt081FQatO47RbSXZ5I+GiRpBjHYsU5B6kEYPpIhGjP3d/quHZif6DY
	E4SD0lp7rb7HbJWNyo4oY+p0aapbQxE=
Date: Fri, 18 Jul 2025 12:19:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 01/13] bpf: Add dynptr type for skb metadata
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arthur Fabre <arthur@arthurfabre.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Joanne Koong <joannelkoong@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
 <20250716-skb-metadata-thru-dynptr-v2-1-5f580447e1df@cloudflare.com>
 <9aa1f2b0-0f63-45e8-b787-e14d53cac75a@linux.dev>
 <875xfpes14.fsf@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <875xfpes14.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/18/25 3:01 AM, Jakub Sitnicki wrote:
> On Thu, Jul 17, 2025 at 05:06 PM -07, Martin KaFai Lau wrote:
>> On 7/16/25 9:16 AM, Jakub Sitnicki wrote:
>>> +__bpf_kfunc int bpf_dynptr_from_skb_meta(struct __sk_buff *skb, u64 flags,
>>> +					 struct bpf_dynptr *ptr__uninit)
>>> +{
>>> +	return dynptr_from_skb_meta(skb, flags, ptr__uninit, false);
>>> +}
>>> +
>>>    __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_md *x, u64 flags,
>>>    				    struct bpf_dynptr *ptr__uninit)
>>>    {
>>> @@ -12165,8 +12190,15 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
>>>    	return 0;
>>>    }
>>>    +int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
>>> +				    struct bpf_dynptr *ptr__uninit)
>>> +{
>>> +	return dynptr_from_skb_meta(skb, flags, ptr__uninit, true);
>>> +}
>>> +
>>>    BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
>>>    BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
>>> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
>>
>> I looked at the high level of the set. I have a quick question.
>>
>> Have you considered to create another bpf_kfunc_check_set_xxx that is only for
>> the tc and tracing prog type? No need to expose this kfunc to other prog types

After some more thoughts, lets target it for tc only. I think skb_meta is not 
available in most of the tracepoints now. Lets wait until the skb_meta will be 
supported in other hooks/layers first.

>> if the skb_meta is not available now at those hooks.
>>
>> It seems patch 5 is to ensure other prog types has meta_len 0 and some of the
>> tests are to ensure that the other prog types cannot do useful things with the
>> new skb_meta kfunc. The tests will also be different eventually when the
>> skb_meta can be preserved beyond tc.
> 
> That is a neat idea!
> 
> It will let me drop three patches from this series.  Let me do that.

