Return-Path: <bpf+bounces-22602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD1C861A06
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 18:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F5AB20B6E
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEFF13A25E;
	Fri, 23 Feb 2024 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcYr92we"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EF26295
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709805; cv=none; b=F6qyIDYwf48rCd1sEDm0hgu2uSWMAN4OiHgOcmP9cG8pLDasKtiVe+26B/nNkqxISkBfXVNTdEIsAmG7nSF/Ht0yEo3R6KtzKJXgXrtWi379/UG4hunji6cfWBAJCCBF/c0vbZAwk9G7tjWNPaykegARE+npeXj32eQWvb/9bXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709805; c=relaxed/simple;
	bh=SpqbEr35/2XOxveMymfG8myhzzguCYdfipPFM5MDw+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClY4aFeMFvT7DdBC5UJlWq1zhWnrEQ9ysYUHB/qadcIR0XvqC9EMBWOgCadoZEl5eviiV9BHrEBFF4YA3VqpYICC7vFiywJFyHQ5FXH6eDjVWR0Uh6baZWlm3jfqGY2lDUB31DOedRG/XXdq55MEk0SyXWw1j/M7mJnOlgj7g1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcYr92we; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso1091238276.3
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 09:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708709802; x=1709314602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CX7aGxChSQgJMSi/p1HCWF+/H/CQEQ0mdqEJ4HBy2jk=;
        b=FcYr92weFFKFJBctFUM+wpYKQdVAje0Tgkh7Sax0BuFWsJz1y7cqU2epqdiEtZ+Nmu
         AIpzzw7uaqof8jKupwVntHp35wsaC7nzAJDMUFfAhlue0fY5srxgAKM1vptDh/D2Nd7M
         yTHTx4r9uF4e3rH04yDlojOOv6CFsTmxq1vdSbMF86HEFDM+sG9C18mhBddaWd2CdQC4
         AmfTsbpaLFSdk8Hf5g1raYVRtVQ/hiCx0rQ5mf31GFQ4FBAXbYnDTIUciEr7TPzexgjT
         Gw993O3CZ85unySfKbKROqOJK1DOKkVzPDIqWXwW2iXnxbLBNJON5DjW8uNtfCNgQQVc
         oFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709802; x=1709314602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CX7aGxChSQgJMSi/p1HCWF+/H/CQEQ0mdqEJ4HBy2jk=;
        b=Qlf9OatETHQggdi9dSqhfd2fERwg3AHzTZocSJPy14vCS3sYxFZ2NHg1VwoDjqegwG
         kS7ScfqMfSus3DHPd2yksjxHfJ+J37AhD37/X8lGMpNdR1rw3jo8LjySb0xZrrpXtOCU
         5VQCTmyjKkvFKestygOBOgptqABi5EQX15wSKh6NR6bOyI4jW7zh+pBYQCXI5h0Mp1Eg
         3OE7iyg3e/K+9w54f/nOBY/PeeLnBxO+eEFRqfAFYCFb13cI0OQRcpVYAHJqgO70OHsB
         XtrxuEhhkl+4G5hxLDg1g/hEEuZCx9texaMmFXkg4qAQvRr3Ato8r4fA/+5Lu/v7zLCO
         3PCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUgpS2RRGZCMhSKjqVdrX2baO3YlOun3DNe5mv4a0jZzgBoYEI34ZSqbu9ox1yzuyZmqAXD1QTuCTL4Kq6mmROB02K
X-Gm-Message-State: AOJu0YyjThZpXqVjVgPr+VuzE9fYy1PkEuxoQt874CkLvPURuXQE+cul
	APSqapVa/y/jKj2R5f9sgPqa8iuxlEiaiVAcj2f5hGj0xL9xlGdm
X-Google-Smtp-Source: AGHT+IHX/R4l5znSyPxGzKMswdQtFAxmxNhxTpWCcTJqu07lnz0rRHtlyrl0ZZUTJ8aeEqR3WIR5HQ==
X-Received: by 2002:a25:949:0:b0:dc7:4800:c758 with SMTP id u9-20020a250949000000b00dc74800c758mr515672ybm.10.1708709802190;
        Fri, 23 Feb 2024 09:36:42 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:3e23:8885:4bfd:23ef? ([2600:1700:6cf8:1240:3e23:8885:4bfd:23ef])
        by smtp.gmail.com with ESMTPSA id y23-20020a25ad17000000b00dcd512855d4sm3438362ybi.58.2024.02.23.09.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 09:36:41 -0800 (PST)
Message-ID: <33c2317c-fde0-4503-991b-314f20d9e7f7@gmail.com>
Date: Fri, 23 Feb 2024 09:36:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] bpf: struct_ops supports more than one
 page for trampolines.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240221225911.757861-1-thinker.li@gmail.com>
 <20240221225911.757861-3-thinker.li@gmail.com>
 <c59cc446-531b-4b4a-897d-3b298ac72dd2@linux.dev>
 <3e4cc350-34c9-42c1-944f-303a466022d2@gmail.com>
 <7402facf-5f2e-4506-a381-6a84fe1ba841@linux.dev>
 <25982f53-732e-4ce8-bbb2-3354f5684296@gmail.com>
 <b8bac273-27c7-485a-8e45-8825251d6d5a@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <b8bac273-27c7-485a-8e45-8825251d6d5a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/22/24 21:25, Martin KaFai Lau wrote:
> On 2/22/24 7:01 PM, Kui-Feng Lee wrote:
>>
>>
>>
>> On 2/22/24 18:16, Martin KaFai Lau wrote:
>>> On 2/22/24 5:35 PM, Kui-Feng Lee wrote:
>>>>
>>>>
>>>> On 2/22/24 16:33, Martin KaFai Lau wrote:
>>>>> On 2/21/24 2:59 PM, thinker.li@gmail.com wrote:
>>>>>> @@ -531,10 +567,10 @@ static long 
>>>>>> bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>>>>>       const struct btf_type *module_type;
>>>>>>       const struct btf_member *member;
>>>>>>       const struct btf_type *t = st_ops_desc->type;
>>>>>> +    void *image = NULL, *image_end = NULL;
>>>>>>       struct bpf_tramp_links *tlinks;
>>>>>>       void *udata, *kdata;
>>>>>>       int prog_fd, err;
>>>>>> -    void *image, *image_end;
>>>>>>       u32 i;
>>>>>>       if (flags)
>>>>>> @@ -573,15 +609,14 @@ static long 
>>>>>> bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>>>>>       udata = &uvalue->data;
>>>>>>       kdata = &kvalue->data;
>>>>>> -    image = st_map->image;
>>>>>> -    image_end = st_map->image + PAGE_SIZE;
>>>>>>       module_type = btf_type_by_id(btf_vmlinux, 
>>>>>> st_ops_ids[IDX_MODULE_ID]);
>>>>>>       for_each_member(i, t, member) {
>>>>>>           const struct btf_type *mtype, *ptype;
>>>>>>           struct bpf_prog *prog;
>>>>>>           struct bpf_tramp_link *link;
>>>>>> -        u32 moff;
>>>>>> +        u32 moff, tflags;
>>>>>> +        int tsize;
>>>>>>           moff = __btf_member_bit_offset(t, member) / 8;
>>>>>>           ptype = btf_type_resolve_ptr(st_map->btf, member->type, 
>>>>>> NULL);
>>>>>> @@ -653,10 +688,38 @@ static long 
>>>>>> bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>>>>>                     &bpf_struct_ops_link_lops, prog);
>>>>>>           st_map->links[i] = &link->link;
>>>>>> -        err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>>>>>> -                            &st_ops->func_models[i],
>>>>>> -                            *(void **)(st_ops->cfi_stubs + moff),
>>>>>> -                            image, image_end);
>>>>>> +        tflags = BPF_TRAMP_F_INDIRECT;
>>>>>> +        if (st_ops->func_models[i].ret_size > 0)
>>>>>> +            tflags |= BPF_TRAMP_F_RET_FENTRY_RET;
>>>>>> +
>>>>>> +        /* Compute the size of the trampoline */
>>>>>> +        tlinks[BPF_TRAMP_FENTRY].links[0] = link;
>>>>>> +        tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
>>>>>> +        tsize = arch_bpf_trampoline_size(&st_ops->func_models[i],
>>>>>> +                         tflags, tlinks, NULL);
>>>>>> +        if (tsize < 0) {
>>>>>> +            err = tsize;
>>>>>> +            goto reset_unlock;
>>>>>> +        }
>>>>>> +
>>>>>> +        /* Allocate pages */
>>>>>> +        if (tsize > (unsigned long)image_end - (unsigned 
>>>>>> long)image) {
>>>>>> +            if (tsize > PAGE_SIZE) {
>>>>>> +                err = -E2BIG;
>>>>>> +                goto reset_unlock;
>>>>>> +            }
>>>>>> +            image = bpf_struct_ops_map_inc_image(st_map);
>>>>>> +            if (IS_ERR(image)) {
>>>>>> +                err = PTR_ERR(image);
>>>>>> +                goto reset_unlock;
>>>>>> +            }
>>>>>> +            image_end = image + PAGE_SIZE;
>>>>>> +        }
>>>>>> +
>>>>>> +        err = arch_prepare_bpf_trampoline(NULL, image, image_end,
>>>>>> +                          &st_ops->func_models[i],
>>>>>> +                          tflags, tlinks,
>>>>>> +                          *(void **)(st_ops->cfi_stubs + moff));
>>>>>
>>>>> I don't prefer to copy the BPF_TRAMP_F_* setting on tflags, tlinks, 
>>>>> and the arch_*_trampoline_*() logic from 
>>>>> bpf_struct_ops_prepare_trampoline() which is used by the 
>>>>> bpf_dummy_ops for testing also. Considering struct_ops supports 
>>>>> kernel module now, in the future, it is better to move 
>>>>> bpf_dummy_ops out to the bpf_testmod somehow and avoid its 
>>>>> bpf_struct_ops_prepare_trampoline() usage. For now, it is still 
>>>>> better to keep bpf_struct_ops_prepare_trampoline() to be reusable 
>>>>> by both.
>>>>>
>>>>> Have you thought about the earlier suggestion in v1 to do 
>>>>> arch_alloc_bpf_trampoline() in bpf_struct_ops_prepare_trampoline() 
>>>>> instead of copying codes from bpf_struct_ops_prepare_trampoline() 
>>>>> to bpf_struct_ops_map_update_elem()?
>>>>>
>>>>> Something like this (untested code):
>>>>>
>>>>> void *bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links 
>>>>> *tlinks,
>>>>>                      struct bpf_tramp_link *link,
>>>>>                      const struct btf_func_model *model,
>>>>>                      void *stub_func, void *image,
>>>>>                      u32 *image_off,
>>>>>                      bool allow_alloc)
>>>
>>> To be a little more specific, the changes in 
>>> bpf_struct_ops_map_update_elem()
>>> could be mostly like this (untested):
>>>
>>>          ret_image = bpf_struct_ops_prepare_trampoline(tlinks, link,
>>>                                    &st_ops->func_models[i],
>>>                                    *(void **)(st_ops->cfi_stubs + moff),
>>>                                    image, &image_off,
>>>                                    st_map->image_pages_cnt < 
>>> MAX_TRAMP_IMAGE_PAGES);
>>>          if (IS_ERR(ret_image))
>>>              goto reset_unlock;
>>>
>>>          if (image != ret_image) {
>>>              image = ret_image;
>>>              st_map->image_pages[st_map->image_pages_cnt++] = image;
>>>          }
>>>
>>
>> What I don't like is the memory management code was in two named
>> functions, bpf_struct_ops_map_free_image() and
>> bpf_struct_ops_map_inc_image().
> 
> bpf_struct_ops_map_inc_image() is not needed.
> 
>> Now, it falls apart.  Allocate in one place, keep accounting in another
>> place, and free yet at the 3rd place.
>>
>>>>
>>>>
>>>> How about pass a struct bpf_struct_ops_map to
>>>> bpf_struct_ops_prepare_trampoline(). If the pointer of struct
>>>> bpf_struct_ops_map is not NULL, try to allocate new pages for the map?
>>>>
>>>> For example,
>>>>
>>>> static int
>>>> _bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>>>>
>>>>                                     struct bpf_tramp_link *link,
>>>>
>>>>                                     const struct btf_func_model *model,
>>>>
>>>>                                     void *stub_func, void *image,
>>>>                                     void *image_end,
>>>>                                     struct bpf_struct_ops_map *st_map)
>>>> {
>>>>
>>>> ...
>>>>
>>>>      if (!image || size > PAGE_SIZE - *image_off) {
>>>>          if (!st_map)
>>>
>>> Why only limit to st_map != NULL?
>>>
>>> arch_alloc_bpf_trampoline() is also called in bpf_dummy_ops.
>>> If bpf_struct_ops_prepare_trampoline() can do the alloc, it may as 
>>> well simplify
>>> bpf_dummy_ops and just use bpf_struct_ops_prepare_trampoline() to alloc.
>>
>>
>> Yes, it can save a few lines from bpf_dummy_ops. But, bpf_dummy_ops
>> still need to free the memory. And, it doesn't pair alloc and free in
>> the same function. Usually, paring alloc and free in the same function,
>> nearby, or the same module is easier to understand.
> 
> It is not only about saving a few lines. It just does not make sense to
> add all this complexity and another "_"bpf_struct_ops_prepare_trampoline()
> variant to make it conform to the alloc/free pair idea. To be clear, I 
> don't

To be clear, we are not talking computation or memory complexity here.
I consider the complexity in another way. When I look at the code of
bpf_dummy_ops, and see it free the memory at the very end of a function.
I have to guess who allocate the memory by looking around without a
clear sign or hint if we move the allocation to
bpf_struct_ops_prepare_trampoline(). It is a source of complexity.
Very often, a duplication is much more simple and easy to understand.
Especially, when the duplication is in a very well know/recognized
pattern. Here will create a unusual way to replace a well recognized one
to simplify the code.

My reason of duplicating the code from
bpf_struct_ops_prepare_trampoline() was we don't need
bpf_struct_ops_prepare_trampoline() in future if we were going to move
bpf_dummy_ops out. But, just like you said, we still have bpf_dummy_ops
now, so it is a good trade of to move memory allocation into
bpf_struct_ops_prepare_trampoline() to avoid the duplication the code
about flags and tlinks. But, the trade off we are talking here goes to
an opposite way.

By the way, I am not insisting on these tiny details. I am just trying
to explain what I don't like here.

> see alloc/free pair is a must have in all cases. There are many 
> situations that
> non-alloc named function calls multiple kmalloc() in different places and
> one xyz_free() releases everything. Even alloc/free is really preferred,
> there has to be a better way or else need to make a trade off.
> 
> I suggested the high level ideal on making
> bpf_struct_ops_prepare_trampoline() to allocate page. It can sure add a
> bpf_struct_ops_free_trampoline() if you see fit to make it match with
> bpf_struct_ops_prepare_trampoline() as alloc/free pair, for example,
> 
> void bpf_struct_ops_free_trampoline(void *image)
> {
>      bpf_jit_uncharge_modmem(PAGE_SIZE);
>      arch_free_bpf_trampoline(image, PAGE_SIZE);
> }
> 
> and make bpf_struct_ops_map_free_image() to use
> bpf_struct_ops_free_trampoline()
> 
> static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map 
> *st_map)
> {
>      int i;
> 
>      for (i = 0; i < st_map->image_pages_cnt; i++) {
>          bpf_struct_ops_free_trampoline(st_map->image_pages[i]);
>          st_map->image_pages[i] = NULL;
>      }
>      st_map->image_pages_cnt = 0;
> }
> 
> Then it should work like alloc/free pair.

