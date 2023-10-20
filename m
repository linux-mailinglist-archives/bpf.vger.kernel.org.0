Return-Path: <bpf+bounces-12871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F33D7D1841
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 23:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD2E1C2093D
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 21:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F402FE0D;
	Fri, 20 Oct 2023 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NA/0OH4c"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9C1A5A8
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 21:37:57 +0000 (UTC)
Received: from out-194.mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D97BD7A
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 14:37:51 -0700 (PDT)
Message-ID: <047bbde0-eb9c-7785-349a-d241c1623fab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697837869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DaSnHyuKtdUTDp3PA3Ycr2I841iXFtsPPUqcHWay0Wg=;
	b=NA/0OH4cLMvFdv3Ya5aRcqDNHQZQ96ivY1W3mfBX5LMoLhvRe4kHpLQT0h22DngZOSdzJv
	1sONIf9BCPybxY00m3crc8GY3TjuniuW2SAP9fjlu9VjgzrhRIJ4jhjDgaGgbQG4oLaj2k
	S+AWegvXbnyRHs4+AeZ1ZUtTxT4lumU=
Date: Fri, 20 Oct 2023 14:37:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/9] bpf: hold module for bpf_struct_ops_map.
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-4-thinker.li@gmail.com>
 <a245d4c4-6eb0-ce54-41aa-4f8c8acf3051@linux.dev>
 <7ea8ebf7-3349-4461-b204-be106e3b547a@gmail.com>
 <02e2a704-4939-4f8c-b465-473c3a2eae1c@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <02e2a704-4939-4f8c-b465-473c3a2eae1c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/19/23 10:07 PM, Kui-Feng Lee wrote:
> 
> 
> On 10/19/23 09:29, Kui-Feng Lee wrote:
>>
>>
>> On 10/18/23 17:36, Martin KaFai Lau wrote:
>>> On 10/17/23 9:23 AM, thinker.li@gmail.com wrote:
>>
>>>
>>>>   }
>>>>   void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>>>> @@ -215,7 +218,7 @@ void bpf_struct_ops_init(struct btf *btf, struct 
>>>> bpf_verifier_log *log)
>>>>       for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
>>>>           st_ops = bpf_struct_ops[i];
>>>> -        bpf_struct_ops_init_one(st_ops, btf, log);
>>>> +        bpf_struct_ops_init_one(st_ops, btf, NULL, log);
>>>>       }
>>>>   }
>>>> @@ -630,6 +633,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>>>>           bpf_jit_uncharge_modmem(PAGE_SIZE);
>>>>       }
>>>>       bpf_map_area_free(st_map->uvalue);
>>>> +    module_put(st_map->st_ops->owner);
>>>>       bpf_map_area_free(st_map);
>>>>   }
>>>> @@ -676,9 +680,18 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union 
>>>> bpf_attr *attr)
>>>>       if (!st_ops)
>>>>           return ERR_PTR(-ENOTSUPP);
>>>> +    /* If st_ops->owner is NULL, it means the struct_ops is
>>>> +     * statically defined in the kernel.  We don't need to
>>>> +     * take a refcount on it.
>>>> +     */
>>>> +    if (st_ops->owner && !btf_try_get_module(st_ops->btf))

While replying and looking at it again, I don't think the 
btf_try_get_module(st_ops->btf) is safe. The module's owned st_ops itself could 
have been gone with the module. The same goes with the "st_ops->owner" test, so 
btf_is_module(btf) should be used instead.

I am risking to act like a broken clock to repeat this question, does it really 
need to store btf back into the st_ops which may accidentally get into the above 
btf_try_get_module(st_ops->btf) usage?

>>>
>>> This just came to my mind. Is the module refcnt needed during map alloc/free 
>>> or it could be done during the reg/unreg instead?
>>
>>
>> Sure, I can move it to reg/unreg.
> 
> Just found that we relies type information in st_ops to update element and clean 
> up maps.
> We can not move get/put modules to reg/unreg except keeping a redundant copy in
> st_map or somewhere. It make the code much more complicated by
> introducing get/put module here and there.
> 
> I prefer to keep as it is now. WDYT?

Yeah, sure. I was asking after seeing a longer wait time for the module to go 
away in patch 11 selftest and requires an explicit waiting for the tasks_trace 
period. Releasing the module refcnt earlier will help.

Regardless of the module refcnt hold/free location, I think storing the type* 
and value* in the module's owned st_ops does not look correct now. It was fine 
and convenient to piggy back them into bpf_struct_ops when everything was 
built-in the kernel and no lifetime concern. It makes sense now to separate them 
out from the module's owned st_ops. Something like:

struct btf_struct_ops_desc {
	struct bpf_struct_ops *ops;
         const struct btf_type *type;
         const struct btf_type *value_type;
         u32 type_id;
         u32 value_id;
};

struct btf_struct_ops_tab {
         u32 cnt;
	u32 capacity;
	struct btf_struct_ops_desc *st_ops_desc[];
};

wdyt?

