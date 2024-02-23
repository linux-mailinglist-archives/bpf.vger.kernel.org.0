Return-Path: <bpf+bounces-22552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634BB860918
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 04:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EB028557C
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 03:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8927DBE7D;
	Fri, 23 Feb 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0qQU99F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC328EB
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657277; cv=none; b=HCh8HdMOYPHn4PakGXffv8vzB2ZxFIRzzjVdA6F+MLQD+XU3nzRajQI4YtRaEWWALXYNPfLsKvXpxoMFSC98Yn5Y1HQpEcMgjBQcGIM2tMpjELWqtDitxP5lId0YXsImcPBZCVVWq4CFujPyVVvA8pCgpiN3Aul+F4Q8Q+MU9rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657277; c=relaxed/simple;
	bh=XSvLz1Him/BPmhMSMHWxpPn68eId66I09vreOaJFJlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ad4YUWAqHCx+1gEorpM+oTTI2I43y9pBBkqlLAiuzrdOI55CD2ar22gqPyQHxijUgSo0Z4tQihreBtI1MnRbHN4DUZ9W8iib4IMFxJ2b89QgHkV8j3m1bIxGJkWcMvMqB7ddycWWjIx4RtpOUMStBeR+MjaLM2ve1BxStSBcuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0qQU99F; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60495209415so4741337b3.3
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 19:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708657274; x=1709262074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzDJVSzmMYfKHorMcRJ6qi6O9jyFCItDuTHV/HhBK9U=;
        b=E0qQU99FozMELKO7Eckt+SHzhA08CFfhcfnNQU+nH0ygwUEa0NnANMde4MbxA9a834
         Fsa1oCPtn0UUUkqONI52U2Y4+i5VUv+210j2hajNX1bc70k0ATHFyStgiqPYuH2nmmzv
         TLfo/oi//xs2btJGw8qgOPOLmSxqsGGGyOCsc2h7cUbtGz2/M6KfOmDaZctsTZQZRHBb
         4KvMASluUxDx/PV+IUQpq38pSnMYfBRNiF33ldnWQ5O7JE3u+31LEG2yH4x5A1z7/gFI
         jWVSpIHUpi4PcAvaQapkj8+G2TN+nfR7eli+dkHTHqBxceaTzsijx6TznojbmzYc/HTd
         uE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708657274; x=1709262074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzDJVSzmMYfKHorMcRJ6qi6O9jyFCItDuTHV/HhBK9U=;
        b=tZ4fnsHsLUyp07cU9te7b3HRgA+Sixoq84qwSYvsN9RHbz7kuDwtgAjr/w0ZxQ8GXk
         4sh0GQhO9xithrt7waI7Yp+K/e9/Qd9wf+Ao6UoBlNAAWZxTky7zcOuIuGk76zF09oOG
         bcpHwapkjD7phaMg+ZaCNcrvGcbTX6ppbdk61BDdMt8F0sVw7F+mgDWdTq+vrInNhMMD
         yp89U+tI3rO8FlVMiIp4AZ+vwX3eiAUKvcCgVmQRTPSkocX0CUqvqQnO+w8iI9EV3BNl
         mN/0F4uAjX6ar30/5rpmFgFQyWYeT18ou3lwCT16zfd/QTelRUeMhVH9f2usWDRpwd9J
         Ogkg==
X-Forwarded-Encrypted: i=1; AJvYcCWczqMfiRWY4D6q5EVmjZjwRLkvvnS+3xBDWB5Co5PBZmLS9mG9eTVyw8Y5iKzpWTkCjXFZ8FflJt7u7KGJ7o+NSSwr
X-Gm-Message-State: AOJu0Ywk31UxEIII/hZcwZt+BbZ49KasrD8cvl/dp4GkaIOz6OqY4EPo
	3Y5vUgaL58mGtkPbBXuk6VtLlN7eE9aQNiDYgBMhpg6xyc6Sd7zN
X-Google-Smtp-Source: AGHT+IGT1xVFScxMAjyIAHuYw8Kjpl+dHGRLHGT0LrjYWt+Lv80lhrfhRvx6DvAp0UkbESJkqcQU/A==
X-Received: by 2002:a81:a104:0:b0:608:bc78:94b7 with SMTP id y4-20020a81a104000000b00608bc7894b7mr152528ywg.49.1708657274266;
        Thu, 22 Feb 2024 19:01:14 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:34d2:7236:710a:117c? ([2600:1700:6cf8:1240:34d2:7236:710a:117c])
        by smtp.gmail.com with ESMTPSA id s66-20020a0dd045000000b0060447768630sm3385585ywd.124.2024.02.22.19.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 19:01:13 -0800 (PST)
Message-ID: <25982f53-732e-4ce8-bbb2-3354f5684296@gmail.com>
Date: Thu, 22 Feb 2024 19:01:12 -0800
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
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <7402facf-5f2e-4506-a381-6a84fe1ba841@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 2/22/24 18:16, Martin KaFai Lau wrote:
> On 2/22/24 5:35 PM, Kui-Feng Lee wrote:
>>
>>
>> On 2/22/24 16:33, Martin KaFai Lau wrote:
>>> On 2/21/24 2:59 PM, thinker.li@gmail.com wrote:
>>>> @@ -531,10 +567,10 @@ static long 
>>>> bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>>>       const struct btf_type *module_type;
>>>>       const struct btf_member *member;
>>>>       const struct btf_type *t = st_ops_desc->type;
>>>> +    void *image = NULL, *image_end = NULL;
>>>>       struct bpf_tramp_links *tlinks;
>>>>       void *udata, *kdata;
>>>>       int prog_fd, err;
>>>> -    void *image, *image_end;
>>>>       u32 i;
>>>>       if (flags)
>>>> @@ -573,15 +609,14 @@ static long 
>>>> bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>>>       udata = &uvalue->data;
>>>>       kdata = &kvalue->data;
>>>> -    image = st_map->image;
>>>> -    image_end = st_map->image + PAGE_SIZE;
>>>>       module_type = btf_type_by_id(btf_vmlinux, 
>>>> st_ops_ids[IDX_MODULE_ID]);
>>>>       for_each_member(i, t, member) {
>>>>           const struct btf_type *mtype, *ptype;
>>>>           struct bpf_prog *prog;
>>>>           struct bpf_tramp_link *link;
>>>> -        u32 moff;
>>>> +        u32 moff, tflags;
>>>> +        int tsize;
>>>>           moff = __btf_member_bit_offset(t, member) / 8;
>>>>           ptype = btf_type_resolve_ptr(st_map->btf, member->type, 
>>>> NULL);
>>>> @@ -653,10 +688,38 @@ static long 
>>>> bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>>>                     &bpf_struct_ops_link_lops, prog);
>>>>           st_map->links[i] = &link->link;
>>>> -        err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>>>> -                            &st_ops->func_models[i],
>>>> -                            *(void **)(st_ops->cfi_stubs + moff),
>>>> -                            image, image_end);
>>>> +        tflags = BPF_TRAMP_F_INDIRECT;
>>>> +        if (st_ops->func_models[i].ret_size > 0)
>>>> +            tflags |= BPF_TRAMP_F_RET_FENTRY_RET;
>>>> +
>>>> +        /* Compute the size of the trampoline */
>>>> +        tlinks[BPF_TRAMP_FENTRY].links[0] = link;
>>>> +        tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
>>>> +        tsize = arch_bpf_trampoline_size(&st_ops->func_models[i],
>>>> +                         tflags, tlinks, NULL);
>>>> +        if (tsize < 0) {
>>>> +            err = tsize;
>>>> +            goto reset_unlock;
>>>> +        }
>>>> +
>>>> +        /* Allocate pages */
>>>> +        if (tsize > (unsigned long)image_end - (unsigned long)image) {
>>>> +            if (tsize > PAGE_SIZE) {
>>>> +                err = -E2BIG;
>>>> +                goto reset_unlock;
>>>> +            }
>>>> +            image = bpf_struct_ops_map_inc_image(st_map);
>>>> +            if (IS_ERR(image)) {
>>>> +                err = PTR_ERR(image);
>>>> +                goto reset_unlock;
>>>> +            }
>>>> +            image_end = image + PAGE_SIZE;
>>>> +        }
>>>> +
>>>> +        err = arch_prepare_bpf_trampoline(NULL, image, image_end,
>>>> +                          &st_ops->func_models[i],
>>>> +                          tflags, tlinks,
>>>> +                          *(void **)(st_ops->cfi_stubs + moff));
>>>
>>> I don't prefer to copy the BPF_TRAMP_F_* setting on tflags, tlinks, 
>>> and the arch_*_trampoline_*() logic from 
>>> bpf_struct_ops_prepare_trampoline() which is used by the 
>>> bpf_dummy_ops for testing also. Considering struct_ops supports 
>>> kernel module now, in the future, it is better to move bpf_dummy_ops 
>>> out to the bpf_testmod somehow and avoid its 
>>> bpf_struct_ops_prepare_trampoline() usage. For now, it is still 
>>> better to keep bpf_struct_ops_prepare_trampoline() to be reusable by 
>>> both.
>>>
>>> Have you thought about the earlier suggestion in v1 to do 
>>> arch_alloc_bpf_trampoline() in bpf_struct_ops_prepare_trampoline() 
>>> instead of copying codes from bpf_struct_ops_prepare_trampoline() to 
>>> bpf_struct_ops_map_update_elem()?
>>>
>>> Something like this (untested code):
>>>
>>> void *bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>>>                      struct bpf_tramp_link *link,
>>>                      const struct btf_func_model *model,
>>>                      void *stub_func, void *image,
>>>                      u32 *image_off,
>>>                      bool allow_alloc)
> 
> To be a little more specific, the changes in 
> bpf_struct_ops_map_update_elem()
> could be mostly like this (untested):
> 
>          ret_image = bpf_struct_ops_prepare_trampoline(tlinks, link,
>                                    &st_ops->func_models[i],
>                                    *(void **)(st_ops->cfi_stubs + moff),
>                                    image, &image_off,
>                                    st_map->image_pages_cnt < 
> MAX_TRAMP_IMAGE_PAGES);
>          if (IS_ERR(ret_image))
>              goto reset_unlock;
> 
>          if (image != ret_image) {
>              image = ret_image;
>              st_map->image_pages[st_map->image_pages_cnt++] = image;
>          }
> 

What I don't like is the memory management code was in two named
functions, bpf_struct_ops_map_free_image() and
bpf_struct_ops_map_inc_image().
Now, it falls apart.  Allocate in one place, keep accounting in another
place, and free yet at the 3rd place.

>>
>>
>> How about pass a struct bpf_struct_ops_map to
>> bpf_struct_ops_prepare_trampoline(). If the pointer of struct
>> bpf_struct_ops_map is not NULL, try to allocate new pages for the map?
>>
>> For example,
>>
>> static int
>> _bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>>
>>                                     struct bpf_tramp_link *link,
>>
>>                                     const struct btf_func_model *model,
>>
>>                                     void *stub_func, void *image,
>>                                     void *image_end,
>>                                     struct bpf_struct_ops_map *st_map)
>> {
>>
>> ...
>>
>>      if (!image || size > PAGE_SIZE - *image_off) {
>>          if (!st_map)
> 
> Why only limit to st_map != NULL?
> 
> arch_alloc_bpf_trampoline() is also called in bpf_dummy_ops.
> If bpf_struct_ops_prepare_trampoline() can do the alloc, it may as well 
> simplify
> bpf_dummy_ops and just use bpf_struct_ops_prepare_trampoline() to alloc.


Yes, it can save a few lines from bpf_dummy_ops. But, bpf_dummy_ops
still need to free the memory. And, it doesn't pair alloc and free in
the same function. Usually, paring alloc and free in the same function,
nearby, or the same module is easier to understand.


[ skip ]

