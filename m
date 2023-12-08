Return-Path: <bpf+bounces-17114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A700809DFC
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 09:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEB528164C
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECBC10A3F;
	Fri,  8 Dec 2023 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NAqjHy/a"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8262E1722
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 00:17:07 -0800 (PST)
Message-ID: <cf59ff24-5c29-4c5e-951c-3c67927cf058@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702023426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fs9PjV5gUcCHntLYTmYP6gFebRUrehhn+JHZiGuipCc=;
	b=NAqjHy/anfb1ulcIJuFCWcX0UYAmpDDY1kEXf/VkLS86wV2aPYE4DNaA6LAU6EO7cPykEz
	v3G5UpY21WpoPwhdaZnRvcgbHQz11zgoOv6NQRXSjAsXzcjBd0raJ1/JLzPxBuvHALegkw
	CjZmBgVK2perce2kt5mE/CZDlsHZ51Q=
Date: Fri, 8 Dec 2023 00:16:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4] bpf: Fix a race condition between btf_put()
 and map_free()
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Hou Tao <houtao@huaweicloud.com>,
 bpf@vger.kernel.org
References: <20231206210959.1035724-1-yonghong.song@linux.dev>
 <d1c0232c-a41c-4cce-9bdf-3a1e8850ed05@linux.dev>
 <969852f3-34f8-45d9-bf2d-f6a4d5167e55@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <969852f3-34f8-45d9-bf2d-f6a4d5167e55@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/7/23 7:59 PM, Yonghong Song wrote:
>>
>> I am trying to avoid making a special case for "bool has_btf_ref;" and "bool 
>> from_map_check". It seems to a bit too much to deal with the error path for 
>> btf_parse().
>>
>> Would doing the refcount_set(&btf->refcnt, 1) earlier in btf_parse help?
> 
> No, it does not. The core reason is what Hao is mentioned in
> https://lore.kernel.org/bpf/47ee3265-23f7-2130-ff28-27bfaf3f7877@huaweicloud.com/
> We simply cannot take btf reference if called from btf_parse().
> Let us say we move refcount_set(&btf->refcnt, 1) earlier in btf_parse()
> so we take ref for btf during btf_parse_fields(), then we have
>       btf_put <=== expect refcount == 0 to start the destruction process
>         ...
>           btf_record_free <=== in which if graph_root, a btf reference will be hold
> so btf_put will never be able to actually free btf data.

ah. There is a loop like btf->struct_meta_tab->...btf.

> Yes, the kasan problem will be resolved but we leak memory.
> 
>>
>>> It is also unnecessary to take a reference since the value_rec is
>>> referring to a record in struct_meta_tab.
>>
>> If we optimize for not taking a refcnt, how about not taking a refcnt for all 
>> cases and postpone the btf_put(), instead of taking refcnt in one case but not 
>> another. Like your fix in v1. The failed selftest can be changed or even 
>> removed if it does not make sense anymore.
> 
> After a couple of iterations, I think taking necessary reference approach sounds 
> better
> and this will be consistent with how kptr is handled. For kptr, btf_parse will 
> ignore it.

Got it. It is why kptr.btf got away with the loop.

On the other hand, am I reading it correctly that kptr.btf only needs to take 
the refcnt for btf that is btf_is_kernel()?

> Unfortunately, for graph_root (list_head, rb_root), btf_parse and map_check will 
> both
> process it and that adds a little bit complexity.
> Alexei also suggested the same taking reference approach:
> https://lore.kernel.org/bpf/CAADnVQL+uc6VV65_Ezgzw3WH=ME9z1Fdy8Pd6xd0oOq8rgwh7g@mail.gmail.com/


