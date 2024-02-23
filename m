Return-Path: <bpf+bounces-22554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EBA860A35
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 06:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7126E1F26445
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 05:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB711738;
	Fri, 23 Feb 2024 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="THVhGb7D"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589428F56
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 05:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708665921; cv=none; b=nzMe9f5JaCJwnzQKBhNv8f1ihacfu1bdZzgT56EmjKuz8R3yBm6EVQPXAiKOwxdGo/4DmFQA2n7E2fqUpF31uSjXZCTwKuOu5HOefD0rsUZJPFt5uQEsbFcFwMIe0me28cOomwFlY2AER8+5pDIFZbzMikL8kYJCr/Hn6oBCYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708665921; c=relaxed/simple;
	bh=CSefd1B4s0EaZGVBXkKxNdw5Yjz0n4edty3BdcRGOEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhzCw9Jf6WgHCZeDjNFmLVsNdCPeVaGnHcYCc6HST7d9o56u99qGVi5Ma0u0NvIxu2exAXsFBChexp/AFNyzayQCmLFVqejpa/Nh+SsvGRmRPcFsy5eVGKo+P2IsMZT560uW2Fl+uACfJlD0Y8CMK/TuBaspeWURHWCT3C+CW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=THVhGb7D; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b8bac273-27c7-485a-8e45-8825251d6d5a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708665916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsQ5pDmeNOyqLoDgC1BGAR2g2ivY989pb8Cz0Yqpy20=;
	b=THVhGb7Duqu4w24tPUy+Ft+NR8J7pqCq6BSdGMncYA2aC56L+1gQwLt6FxVx/+t6IQkHbO
	rZEfs9gp2G/6wyvxVTGm9y6tpiIskJCcx69xoLefc6j8cgOfiPguP0/wcIaLLqAK6nT0dQ
	IOW7aO+6ppt7nfO26uXCweRQ3+3+dWo=
Date: Thu, 22 Feb 2024 21:25:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] bpf: struct_ops supports more than one
 page for trampolines.
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240221225911.757861-1-thinker.li@gmail.com>
 <20240221225911.757861-3-thinker.li@gmail.com>
 <c59cc446-531b-4b4a-897d-3b298ac72dd2@linux.dev>
 <3e4cc350-34c9-42c1-944f-303a466022d2@gmail.com>
 <7402facf-5f2e-4506-a381-6a84fe1ba841@linux.dev>
 <25982f53-732e-4ce8-bbb2-3354f5684296@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <25982f53-732e-4ce8-bbb2-3354f5684296@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/22/24 7:01 PM, Kui-Feng Lee wrote:
> 
> 
> 
> On 2/22/24 18:16, Martin KaFai Lau wrote:
>> On 2/22/24 5:35 PM, Kui-Feng Lee wrote:
>>>
>>>
>>> On 2/22/24 16:33, Martin KaFai Lau wrote:
>>>> On 2/21/24 2:59 PM, thinker.li@gmail.com wrote:
>>>>> @@ -531,10 +567,10 @@ static long bpf_struct_ops_map_update_elem(struct 
>>>>> bpf_map *map, void *key,
>>>>>       const struct btf_type *module_type;
>>>>>       const struct btf_member *member;
>>>>>       const struct btf_type *t = st_ops_desc->type;
>>>>> +    void *image = NULL, *image_end = NULL;
>>>>>       struct bpf_tramp_links *tlinks;
>>>>>       void *udata, *kdata;
>>>>>       int prog_fd, err;
>>>>> -    void *image, *image_end;
>>>>>       u32 i;
>>>>>       if (flags)
>>>>> @@ -573,15 +609,14 @@ static long bpf_struct_ops_map_update_elem(struct 
>>>>> bpf_map *map, void *key,
>>>>>       udata = &uvalue->data;
>>>>>       kdata = &kvalue->data;
>>>>> -    image = st_map->image;
>>>>> -    image_end = st_map->image + PAGE_SIZE;
>>>>>       module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
>>>>>       for_each_member(i, t, member) {
>>>>>           const struct btf_type *mtype, *ptype;
>>>>>           struct bpf_prog *prog;
>>>>>           struct bpf_tramp_link *link;
>>>>> -        u32 moff;
>>>>> +        u32 moff, tflags;
>>>>> +        int tsize;
>>>>>           moff = __btf_member_bit_offset(t, member) / 8;
>>>>>           ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
>>>>> @@ -653,10 +688,38 @@ static long bpf_struct_ops_map_update_elem(struct 
>>>>> bpf_map *map, void *key,
>>>>>                     &bpf_struct_ops_link_lops, prog);
>>>>>           st_map->links[i] = &link->link;
>>>>> -        err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>>>>> -                            &st_ops->func_models[i],
>>>>> -                            *(void **)(st_ops->cfi_stubs + moff),
>>>>> -                            image, image_end);
>>>>> +        tflags = BPF_TRAMP_F_INDIRECT;
>>>>> +        if (st_ops->func_models[i].ret_size > 0)
>>>>> +            tflags |= BPF_TRAMP_F_RET_FENTRY_RET;
>>>>> +
>>>>> +        /* Compute the size of the trampoline */
>>>>> +        tlinks[BPF_TRAMP_FENTRY].links[0] = link;
>>>>> +        tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
>>>>> +        tsize = arch_bpf_trampoline_size(&st_ops->func_models[i],
>>>>> +                         tflags, tlinks, NULL);
>>>>> +        if (tsize < 0) {
>>>>> +            err = tsize;
>>>>> +            goto reset_unlock;
>>>>> +        }
>>>>> +
>>>>> +        /* Allocate pages */
>>>>> +        if (tsize > (unsigned long)image_end - (unsigned long)image) {
>>>>> +            if (tsize > PAGE_SIZE) {
>>>>> +                err = -E2BIG;
>>>>> +                goto reset_unlock;
>>>>> +            }
>>>>> +            image = bpf_struct_ops_map_inc_image(st_map);
>>>>> +            if (IS_ERR(image)) {
>>>>> +                err = PTR_ERR(image);
>>>>> +                goto reset_unlock;
>>>>> +            }
>>>>> +            image_end = image + PAGE_SIZE;
>>>>> +        }
>>>>> +
>>>>> +        err = arch_prepare_bpf_trampoline(NULL, image, image_end,
>>>>> +                          &st_ops->func_models[i],
>>>>> +                          tflags, tlinks,
>>>>> +                          *(void **)(st_ops->cfi_stubs + moff));
>>>>
>>>> I don't prefer to copy the BPF_TRAMP_F_* setting on tflags, tlinks, and the 
>>>> arch_*_trampoline_*() logic from bpf_struct_ops_prepare_trampoline() which 
>>>> is used by the bpf_dummy_ops for testing also. Considering struct_ops 
>>>> supports kernel module now, in the future, it is better to move 
>>>> bpf_dummy_ops out to the bpf_testmod somehow and avoid its 
>>>> bpf_struct_ops_prepare_trampoline() usage. For now, it is still better to 
>>>> keep bpf_struct_ops_prepare_trampoline() to be reusable by both.
>>>>
>>>> Have you thought about the earlier suggestion in v1 to do 
>>>> arch_alloc_bpf_trampoline() in bpf_struct_ops_prepare_trampoline() instead 
>>>> of copying codes from bpf_struct_ops_prepare_trampoline() to 
>>>> bpf_struct_ops_map_update_elem()?
>>>>
>>>> Something like this (untested code):
>>>>
>>>> void *bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>>>>                      struct bpf_tramp_link *link,
>>>>                      const struct btf_func_model *model,
>>>>                      void *stub_func, void *image,
>>>>                      u32 *image_off,
>>>>                      bool allow_alloc)
>>
>> To be a little more specific, the changes in bpf_struct_ops_map_update_elem()
>> could be mostly like this (untested):
>>
>>          ret_image = bpf_struct_ops_prepare_trampoline(tlinks, link,
>>                                    &st_ops->func_models[i],
>>                                    *(void **)(st_ops->cfi_stubs + moff),
>>                                    image, &image_off,
>>                                    st_map->image_pages_cnt < 
>> MAX_TRAMP_IMAGE_PAGES);
>>          if (IS_ERR(ret_image))
>>              goto reset_unlock;
>>
>>          if (image != ret_image) {
>>              image = ret_image;
>>              st_map->image_pages[st_map->image_pages_cnt++] = image;
>>          }
>>
> 
> What I don't like is the memory management code was in two named
> functions, bpf_struct_ops_map_free_image() and
> bpf_struct_ops_map_inc_image().

bpf_struct_ops_map_inc_image() is not needed.

> Now, it falls apart.  Allocate in one place, keep accounting in another
> place, and free yet at the 3rd place.
> 
>>>
>>>
>>> How about pass a struct bpf_struct_ops_map to
>>> bpf_struct_ops_prepare_trampoline(). If the pointer of struct
>>> bpf_struct_ops_map is not NULL, try to allocate new pages for the map?
>>>
>>> For example,
>>>
>>> static int
>>> _bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>>>
>>>                                     struct bpf_tramp_link *link,
>>>
>>>                                     const struct btf_func_model *model,
>>>
>>>                                     void *stub_func, void *image,
>>>                                     void *image_end,
>>>                                     struct bpf_struct_ops_map *st_map)
>>> {
>>>
>>> ...
>>>
>>>      if (!image || size > PAGE_SIZE - *image_off) {
>>>          if (!st_map)
>>
>> Why only limit to st_map != NULL?
>>
>> arch_alloc_bpf_trampoline() is also called in bpf_dummy_ops.
>> If bpf_struct_ops_prepare_trampoline() can do the alloc, it may as well simplify
>> bpf_dummy_ops and just use bpf_struct_ops_prepare_trampoline() to alloc.
> 
> 
> Yes, it can save a few lines from bpf_dummy_ops. But, bpf_dummy_ops
> still need to free the memory. And, it doesn't pair alloc and free in
> the same function. Usually, paring alloc and free in the same function,
> nearby, or the same module is easier to understand.

It is not only about saving a few lines. It just does not make sense to
add all this complexity and another "_"bpf_struct_ops_prepare_trampoline()
variant to make it conform to the alloc/free pair idea. To be clear, I don't
see alloc/free pair is a must have in all cases. There are many situations that
non-alloc named function calls multiple kmalloc() in different places and
one xyz_free() releases everything. Even alloc/free is really preferred,
there has to be a better way or else need to make a trade off.

I suggested the high level ideal on making
bpf_struct_ops_prepare_trampoline() to allocate page. It can sure add a
bpf_struct_ops_free_trampoline() if you see fit to make it match with
bpf_struct_ops_prepare_trampoline() as alloc/free pair, for example,

void bpf_struct_ops_free_trampoline(void *image)
{
	bpf_jit_uncharge_modmem(PAGE_SIZE);
	arch_free_bpf_trampoline(image, PAGE_SIZE);
}

and make bpf_struct_ops_map_free_image() to use
bpf_struct_ops_free_trampoline()

static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map *st_map)
{
	int i;

	for (i = 0; i < st_map->image_pages_cnt; i++) {
		bpf_struct_ops_free_trampoline(st_map->image_pages[i]);
		st_map->image_pages[i] = NULL;
	}
	st_map->image_pages_cnt = 0;
}

Then it should work like alloc/free pair.

