Return-Path: <bpf+bounces-13861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA867DE915
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 00:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD47B20EBC
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5001CAA5;
	Wed,  1 Nov 2023 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QMui0MZx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFA184F
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 23:42:02 +0000 (UTC)
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC5AC2
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 16:41:58 -0700 (PDT)
Message-ID: <6947046d-27e3-90ee-3419-0b480af0abb0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698882116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZMYinCK5nATTv27ermACPnZcPbsAMm/p92D7mhqgMY=;
	b=QMui0MZxANiw45tOWolfc71QUZDgiJoHtouJaZjQWLYa+MzmIGw0J8Xv/PXToqbIA8mMV1
	KVGXEo/hWM+zRBnI0s52u/UclkKdLwB4Uwc44bxg4rrTRRJg9UiKVBAMLSZuhCWM/kvG5K
	NjPfeErlG1Wy0w+hrt/C/phKmWXKVAg=
Date: Wed, 1 Nov 2023 16:41:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Vadim Fedorenko <vadfed@meta.com>,
 "David S. Miller" <davem@davemloft.net>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20231031134900.1432945-1-vadfed@meta.com>
 <dac97b74-5ff1-172b-9cd5-4cdcf07386ec@linux.dev>
 <91a6d5a7-7b18-48a2-9a74-7c00509467f8@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <91a6d5a7-7b18-48a2-9a74-7c00509467f8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/1/23 3:50 PM, Vadim Fedorenko wrote:
>>> +static void *__bpf_dynptr_data_ptr(const struct bpf_dynptr_kern *ptr)
>>> +{
>>> +    enum bpf_dynptr_type type;
>>> +
>>> +    if (!ptr->data)
>>> +        return NULL;
>>> +
>>> +    type = bpf_dynptr_get_type(ptr);
>>> +
>>> +    switch (type) {
>>> +    case BPF_DYNPTR_TYPE_LOCAL:
>>> +    case BPF_DYNPTR_TYPE_RINGBUF:
>>> +        return ptr->data + ptr->offset;
>>> +    case BPF_DYNPTR_TYPE_SKB:
>>> +        return skb_pointer_if_linear(ptr->data, ptr->offset, 
>>> __bpf_dynptr_size(ptr));
>>> +    case BPF_DYNPTR_TYPE_XDP:
>>> +    {
>>> +        void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset, 
>>> __bpf_dynptr_size(ptr));
>>
>> I suspect what it is doing here (for skb and xdp in particular) is very 
>> similar to bpf_dynptr_slice. Please check if bpf_dynptr_slice(ptr, 0, NULL, 
>> sz) will work.
>>
> 
> Well, yes, it's simplified version of bpf_dynptr_slice. The problem is
> that bpf_dynptr_slice bpf_kfunc which cannot be used in another
> bpf_kfunc. Should I refactor the code to use it in both places? Like

Sorry, scrolled too fast in my earlier reply :(

I am not aware of this limitation. What error does it have?
The bpf_dynptr_slice_rdwr kfunc() is also calling the bpf_dynptr_slice() kfunc.

> create __bpf_dynptr_slice() which will be internal part of bpf_kfunc?







