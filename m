Return-Path: <bpf+bounces-13966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFC47DF778
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62FC3B2127C
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6D41DA21;
	Thu,  2 Nov 2023 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mGgiK8jm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855741D6B1
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:14:48 +0000 (UTC)
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03443DE
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 09:14:43 -0700 (PDT)
Message-ID: <c4e6296d-f273-4b27-a33a-eee5c8f54aab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698941682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLXkUz3573Bs0chUeznh7tiBsOqJWsCvPXdK1F+3COs=;
	b=mGgiK8jms7Oy7IwdwJwhqGhlv6RVqbJb5O0WN0ymNzRbGgpiJMV602zQml7lycgU9QIFuW
	DoHNumU+0+701di8vccgEV5vlcJ85uuZ9i2itK/pzoe8IPaO7BwE6o7SNZ/DwNE8iB7gQC
	/3UDtNHFvNfh4tKpW02W+HxnsE5iylI=
Date: Thu, 2 Nov 2023 16:14:38 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Vadim Fedorenko <vadfed@meta.com>, "David S. Miller" <davem@davemloft.net>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20231031134900.1432945-1-vadfed@meta.com>
 <dac97b74-5ff1-172b-9cd5-4cdcf07386ec@linux.dev>
 <91a6d5a7-7b18-48a2-9a74-7c00509467f8@linux.dev>
 <6947046d-27e3-90ee-3419-0b480af0abb0@linux.dev>
 <4258aabd-5f7b-4b7f-ab43-408b69bfdc58@linux.dev>
 <CAADnVQ+9pp33zv9DxouEmg24o7w27OKFUcvKChHuby_+d6-bLg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAADnVQ+9pp33zv9DxouEmg24o7w27OKFUcvKChHuby_+d6-bLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 02/11/2023 15:36, Alexei Starovoitov wrote:
> On Thu, Nov 2, 2023 at 6:44 AM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 01/11/2023 23:41, Martin KaFai Lau wrote:
>>> On 11/1/23 3:50 PM, Vadim Fedorenko wrote:
>>>>>> +static void *__bpf_dynptr_data_ptr(const struct bpf_dynptr_kern *ptr)
>>>>>> +{
>>>>>> +    enum bpf_dynptr_type type;
>>>>>> +
>>>>>> +    if (!ptr->data)
>>>>>> +        return NULL;
>>>>>> +
>>>>>> +    type = bpf_dynptr_get_type(ptr);
>>>>>> +
>>>>>> +    switch (type) {
>>>>>> +    case BPF_DYNPTR_TYPE_LOCAL:
>>>>>> +    case BPF_DYNPTR_TYPE_RINGBUF:
>>>>>> +        return ptr->data + ptr->offset;
>>>>>> +    case BPF_DYNPTR_TYPE_SKB:
>>>>>> +        return skb_pointer_if_linear(ptr->data, ptr->offset,
>>>>>> __bpf_dynptr_size(ptr));
>>>>>> +    case BPF_DYNPTR_TYPE_XDP:
>>>>>> +    {
>>>>>> +        void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset,
>>>>>> __bpf_dynptr_size(ptr));
>>>>>
>>>>> I suspect what it is doing here (for skb and xdp in particular) is
>>>>> very similar to bpf_dynptr_slice. Please check if
>>>>> bpf_dynptr_slice(ptr, 0, NULL, sz) will work.
>>>>>
>>>>
>>>> Well, yes, it's simplified version of bpf_dynptr_slice. The problem is
>>>> that bpf_dynptr_slice bpf_kfunc which cannot be used in another
>>>> bpf_kfunc. Should I refactor the code to use it in both places? Like
>>>
>>> Sorry, scrolled too fast in my earlier reply :(
>>>
>>> I am not aware of this limitation. What error does it have?
>>> The bpf_dynptr_slice_rdwr kfunc() is also calling the bpf_dynptr_slice()
>>> kfunc.
>>>
>>>> create __bpf_dynptr_slice() which will be internal part of bpf_kfunc?
>>
>> Apparently Song has a patch to expose these bpf_dynptr_slice* functions
>> ton in-kernel users.
>>
>> https://lore.kernel.org/bpf/20231024235551.2769174-2-song@kernel.org/
>>
>> Should I wait for it to be merged before sending next version?
> 
> If you need something from another developer it's best to ask them
> explicitly :)
> In this case Song can respin with just that change that you need.

Got it. I actually need 2 different changes from the same patchset, I'll 
ping Song in the appropriate thread, thanks!


