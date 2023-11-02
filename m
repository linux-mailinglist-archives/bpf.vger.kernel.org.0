Return-Path: <bpf+bounces-13866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D59B7DE97E
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BCC1C20E87
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 00:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2004710F6;
	Thu,  2 Nov 2023 00:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pd15eFvk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AF371
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 00:38:07 +0000 (UTC)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9102BDB
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 17:38:03 -0700 (PDT)
Message-ID: <5bd504bb-6d0b-0a6c-0c12-37174ff22a2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698885482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V3C17W+NUJRqaDBjl23ZCi2Matx5/XILyFgz0Y7j34=;
	b=Pd15eFvkGfkcFcFakNa21xg/MqsDjv5OM5YwT/t3/41aBS8JGw4nRqRN7+m0x4tj2Hifmu
	mKQ/6hiRTS5PLEW1FWlFXwKlmO2mkwOf/cF050H35x1Q5coHZvMrgQ4iZVju62cMIJDIot
	Uv9xfjVAUAlbaEhQBlIdD2HOr7t8yqg=
Date: Thu, 2 Nov 2023 00:38:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Vadim Fedorenko <vadfed@meta.com>
References: <20231031134900.1432945-1-vadfed@meta.com>
 <dac97b74-5ff1-172b-9cd5-4cdcf07386ec@linux.dev>
 <91a6d5a7-7b18-48a2-9a74-7c00509467f8@linux.dev>
 <6947046d-27e3-90ee-3419-0b480af0abb0@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <6947046d-27e3-90ee-3419-0b480af0abb0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 01.11.2023 23:41, Martin KaFai Lau wrote:
> On 11/1/23 3:50 PM, Vadim Fedorenko wrote:
>>>> +static void *__bpf_dynptr_data_ptr(const struct bpf_dynptr_kern *ptr)
>>>> +{
>>>> +    enum bpf_dynptr_type type;
>>>> +
>>>> +    if (!ptr->data)
>>>> +        return NULL;
>>>> +
>>>> +    type = bpf_dynptr_get_type(ptr);
>>>> +
>>>> +    switch (type) {
>>>> +    case BPF_DYNPTR_TYPE_LOCAL:
>>>> +    case BPF_DYNPTR_TYPE_RINGBUF:
>>>> +        return ptr->data + ptr->offset;
>>>> +    case BPF_DYNPTR_TYPE_SKB:
>>>> +        return skb_pointer_if_linear(ptr->data, ptr->offset, 
>>>> __bpf_dynptr_size(ptr));
>>>> +    case BPF_DYNPTR_TYPE_XDP:
>>>> +    {
>>>> +        void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset, 
>>>> __bpf_dynptr_size(ptr));
>>>
>>> I suspect what it is doing here (for skb and xdp in particular) is very 
>>> similar to bpf_dynptr_slice. Please check if bpf_dynptr_slice(ptr, 0, NULL, 
>>> sz) will work.
>>>
>>
>> Well, yes, it's simplified version of bpf_dynptr_slice. The problem is
>> that bpf_dynptr_slice bpf_kfunc which cannot be used in another
>> bpf_kfunc. Should I refactor the code to use it in both places? Like
> 
> Sorry, scrolled too fast in my earlier reply :(
> 
> I am not aware of this limitation. What error does it have?
> The bpf_dynptr_slice_rdwr kfunc() is also calling the bpf_dynptr_slice() kfunc.
> 

Yeah, but they are in the same module. We do not declare prototypes of kfuncs in
linux/bpf.h and that's why we cannot use them outside of helpers.c.
The same problem was with bpf_dynptr_is_rdonly() I believe.

>> create __bpf_dynptr_slice() which will be internal part of bpf_kfunc?
> 
> 
> 
> 
> 
> 


