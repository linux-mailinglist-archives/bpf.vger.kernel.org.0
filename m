Return-Path: <bpf+bounces-22545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBE986084B
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 02:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5004B2245C
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 01:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C732BBA30;
	Fri, 23 Feb 2024 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5LwH0JD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D841FBE7F
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652121; cv=none; b=Ff8PWGbXGmMRh9FG96zjoH8zU74GALNy1iLJIi/+8hEqiMpyMeNTf6vgiiw1SAuxkagek1l19ziUdtmIFv0myE50br/IHzoFWLI2eOzNq8OQrY8CNssnQnNUKqLyyI6GBwyMCdTguD3K4aDkoALSR3yUfMXfteW0ZGzgfRm/OqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652121; c=relaxed/simple;
	bh=naX1FDziU7psCGaYTnhWV4R5EFW/++SVuTfy21E3gSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBPmRqM12XdhGUfODvKUUHfSU/xxnaTEm4apB8FxpEYlktGNYU26ecopSKRAsNVfbc9LaDwoeuP9KON/EiDBfdP64a/6ihrLXDwNLvuDfbZDNREG3GH5kimFoBbS3PSM+V4zhFabbjaIBm5X5lf5eNZcXtQ9gi4ftHIA1zqH26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5LwH0JD; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db3a09e96daso307694276.3
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 17:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708652113; x=1709256913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOLoAisimA82CRNpB3OJRRGC/KSYBAswAr4DJ89sqHE=;
        b=f5LwH0JDP8BQJctZyT5B/OTWA72229t2qK53/I3rJYutS/4W6zwglzefl9VEJLBryg
         VipWGiY09OmfVg8hZgSdJpDfBf4CajOIJWgzwv8Pf2RSUani1Q+O1ii2Va6KcHau2xCG
         1IpZpqKPWIX2BNI16YzkG7pGC6nvdm/7lUatIAEcCjL44YldDKRgfZQFbayiKkPym/Zd
         LTB7SRkMD5WSVoHhw9vKnDQ6b21Ijge6fBlOMFH8GrKPikhdtY9XfLhuYitn//RXXlEy
         mPetwzCh47pWTdbXnC+s23sGStxFD8BBH4qfZ/ZqhJrUiNDDEKVoG/5mL9vwjWoNiteU
         LMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708652113; x=1709256913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOLoAisimA82CRNpB3OJRRGC/KSYBAswAr4DJ89sqHE=;
        b=QDXMLeIEzM6ffYtUuj7ZlsIh9GCLCPGwZyXNbdEyomBpTr1hPw6/Q0HZ5Has8wYBSl
         Y8Fm8oYTMDKQRq+DGv8FPd+qoBktg/9o7U7MzrhPfJGbTGPaBjS9FJ2tAaE3ttJsJSWL
         2MgXmXNJ/+5/8aBvsEWyfjYdIR9Co61VYCOI6YHIsiGrXYsHMoTYGq68jnvNoXvEIdF+
         vPwbBnX4DNpYjLGr4dIDPSZRMOjy2Ygs46mQBdYZVaCuD/GYzvAWwGFDBUn+/mKvLEKy
         mgzQ3SuC+vHIZbMJ14+v2pLYYMiTS6FqMrSUOenBCEjyFW9xRSL1F038doIDqiNzlI9a
         /xqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW28qJWBF8RJFK+FkfDUy+egl8ZfrXtIO3tsBSYjALM/xWQITh78z794j7KsoY2OaojqS+o23eVnaz/VbjhBNVLFhuC
X-Gm-Message-State: AOJu0YzIx9RvDav5QEwXhTpMnUeQyCX/ohIau1ovcKAb50dit84zgieE
	2PbwXH55j8Zny8yyqbmM/wsguVA0Zl51B5BFLJjkRKvKqCj4yzPM
X-Google-Smtp-Source: AGHT+IFTihBeSJrNDMqzDPnMIGIqkX1WWKXPUVukka3JiKP0pwyrDgSFRv1RyjjPn2ZV2VAJ9bSPAQ==
X-Received: by 2002:a25:2b0a:0:b0:dc6:19ea:9204 with SMTP id r10-20020a252b0a000000b00dc619ea9204mr828444ybr.61.1708652113551;
        Thu, 22 Feb 2024 17:35:13 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:34d2:7236:710a:117c? ([2600:1700:6cf8:1240:34d2:7236:710a:117c])
        by smtp.gmail.com with ESMTPSA id w131-20020a253089000000b00dc25d5f4c75sm3149989ybw.10.2024.02.22.17.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 17:35:13 -0800 (PST)
Message-ID: <3e4cc350-34c9-42c1-944f-303a466022d2@gmail.com>
Date: Thu, 22 Feb 2024 17:35:10 -0800
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
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c59cc446-531b-4b4a-897d-3b298ac72dd2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/22/24 16:33, Martin KaFai Lau wrote:
> On 2/21/24 2:59 PM, thinker.li@gmail.com wrote:
>> @@ -531,10 +567,10 @@ static long 
>> bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>       const struct btf_type *module_type;
>>       const struct btf_member *member;
>>       const struct btf_type *t = st_ops_desc->type;
>> +    void *image = NULL, *image_end = NULL;
>>       struct bpf_tramp_links *tlinks;
>>       void *udata, *kdata;
>>       int prog_fd, err;
>> -    void *image, *image_end;
>>       u32 i;
>>       if (flags)
>> @@ -573,15 +609,14 @@ static long 
>> bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>       udata = &uvalue->data;
>>       kdata = &kvalue->data;
>> -    image = st_map->image;
>> -    image_end = st_map->image + PAGE_SIZE;
>>       module_type = btf_type_by_id(btf_vmlinux, 
>> st_ops_ids[IDX_MODULE_ID]);
>>       for_each_member(i, t, member) {
>>           const struct btf_type *mtype, *ptype;
>>           struct bpf_prog *prog;
>>           struct bpf_tramp_link *link;
>> -        u32 moff;
>> +        u32 moff, tflags;
>> +        int tsize;
>>           moff = __btf_member_bit_offset(t, member) / 8;
>>           ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
>> @@ -653,10 +688,38 @@ static long 
>> bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>                     &bpf_struct_ops_link_lops, prog);
>>           st_map->links[i] = &link->link;
>> -        err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>> -                            &st_ops->func_models[i],
>> -                            *(void **)(st_ops->cfi_stubs + moff),
>> -                            image, image_end);
>> +        tflags = BPF_TRAMP_F_INDIRECT;
>> +        if (st_ops->func_models[i].ret_size > 0)
>> +            tflags |= BPF_TRAMP_F_RET_FENTRY_RET;
>> +
>> +        /* Compute the size of the trampoline */
>> +        tlinks[BPF_TRAMP_FENTRY].links[0] = link;
>> +        tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
>> +        tsize = arch_bpf_trampoline_size(&st_ops->func_models[i],
>> +                         tflags, tlinks, NULL);
>> +        if (tsize < 0) {
>> +            err = tsize;
>> +            goto reset_unlock;
>> +        }
>> +
>> +        /* Allocate pages */
>> +        if (tsize > (unsigned long)image_end - (unsigned long)image) {
>> +            if (tsize > PAGE_SIZE) {
>> +                err = -E2BIG;
>> +                goto reset_unlock;
>> +            }
>> +            image = bpf_struct_ops_map_inc_image(st_map);
>> +            if (IS_ERR(image)) {
>> +                err = PTR_ERR(image);
>> +                goto reset_unlock;
>> +            }
>> +            image_end = image + PAGE_SIZE;
>> +        }
>> +
>> +        err = arch_prepare_bpf_trampoline(NULL, image, image_end,
>> +                          &st_ops->func_models[i],
>> +                          tflags, tlinks,
>> +                          *(void **)(st_ops->cfi_stubs + moff));
> 
> I don't prefer to copy the BPF_TRAMP_F_* setting on tflags, tlinks, and 
> the arch_*_trampoline_*() logic from bpf_struct_ops_prepare_trampoline() 
> which is used by the bpf_dummy_ops for testing also. Considering 
> struct_ops supports kernel module now, in the future, it is better to 
> move bpf_dummy_ops out to the bpf_testmod somehow and avoid its 
> bpf_struct_ops_prepare_trampoline() usage. For now, it is still better 
> to keep bpf_struct_ops_prepare_trampoline() to be reusable by both.
> 
> Have you thought about the earlier suggestion in v1 to do 
> arch_alloc_bpf_trampoline() in bpf_struct_ops_prepare_trampoline() 
> instead of copying codes from bpf_struct_ops_prepare_trampoline() to 
> bpf_struct_ops_map_update_elem()?
> 
> Something like this (untested code):
> 
> void *bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>                      struct bpf_tramp_link *link,
>                      const struct btf_func_model *model,
>                      void *stub_func, void *image,
>                      u32 *image_off,
>                      bool allow_alloc)


How about pass a struct bpf_struct_ops_map to
bpf_struct_ops_prepare_trampoline(). If the pointer of struct
bpf_struct_ops_map is not NULL, try to allocate new pages for the map?

For example,

static int
_bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks, 
 

                                    struct bpf_tramp_link *link, 
 

                                    const struct btf_func_model *model, 
 

                                    void *stub_func, void *image,
                                    void *image_end,
                                    struct bpf_struct_ops_map *st_map) 

{ 
 

...

     if (!image || size > PAGE_SIZE - *image_off) {
         if (!st_map)
             return -E2BIG;
         image = bpf_struct_ops_map_inc_image(st_map);
         if (IS_ERR(image))
             return PTR_ERR(image);
         image_end = image + PAGE_SIZE;
     }
...
}

int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks, 
 

                                       struct bpf_tramp_link *link, 
 

                                       const struct 
btf_func_model*model, 

                                       void *stub_func, void *image,
                                       void *image_end)
{
     return _bpf_struct_ops_prepare_trampoline(tlinks, link, model,
                                               stub_func, image,
                                               image_end, NULL);
}

> {
>      u32 flags = BPF_TRAMP_F_INDIRECT;
>      void *new_image = NULL;
>      int size;
> 
>      tlinks[BPF_TRAMP_FENTRY].links[0] = link;
>      tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
> 
>      if (model->ret_size > 0)
>          flags |= BPF_TRAMP_F_RET_FENTRY_RET;
> 
>      size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
>      if (size < 0)
>          return ERR_PTR(size);
>      if (!image || size > PAGE_SIZE - *image_off) {
>          int err;
> 
>          if (!allow_alloc)
>              return ERR_PTR(-E2BIG);
> 
>          err = bpf_jit_charge_modmem(PAGE_SIZE);
>          if (err)
>              return ERR_PTR(err);
> 
>          new_image = image = arch_alloc_bpf_trampoline(PAGE_SIZE);
>          if (!new_image) {
>              bpf_jit_uncharge_modmem(PAGE_SIZE);
>              return ERR_PTR(-ENOMEM);
>          }
>          *image_off = 0;
>      }
> 
> 
>      size = arch_prepare_bpf_trampoline(NULL, image + *image_off,
>                         image + PAGE_SIZE,
>                         model, flags, tlinks, stub_func);
>      if (size >= 0) {
>          *image_off += size;
>          return image;
>      }
> 
>      if (new_image) {
>          bpf_jit_uncharge_modmem(PAGE_SIZE);
>          arch_free_bpf_trampoline(new_image, PAGE_SIZE);
>      }
> 
>      return ERR_PTR(size);
> }
> 
> ----
> 
> pw-bot: cr
> 
>>           if (err < 0)
>>               goto reset_unlock;
>> @@ -672,10 +735,11 @@ static long 
>> bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>           if (err)
>>               goto reset_unlock;
>>       }
>> +    for (i = 0; i < st_map->image_pages_cnt; i++)
>> +        arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
>>       if (st_map->map.map_flags & BPF_F_LINK) {
>>           err = 0;
>> -        arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
>>           /* Let bpf_link handle registration & unregistration.
>>            *
>>            * Pair with smp_load_acquire() during lookup_elem().
>> @@ -684,7 +748,6 @@ static long bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           goto unlock;
>>       }
>> -    arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
>>       err = st_ops->reg(kdata);
>>       if (likely(!err)) {
>>           /* This refcnt increment on the map here after
>> @@ -707,9 +770,9 @@ static long bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>        * there was a race in registering the struct_ops (under the 
>> same name) to
>>        * a sub-system through different struct_ops's maps.
>>        */
>> -    arch_unprotect_bpf_trampoline(st_map->image, PAGE_SIZE);
>>   reset_unlock:
>> +    bpf_struct_ops_map_free_image(st_map);
>>       bpf_struct_ops_map_put_progs(st_map);
>>       memset(uvalue, 0, map->value_size);
>>       memset(kvalue, 0, map->value_size);
>> @@ -776,10 +839,7 @@ static void __bpf_struct_ops_map_free(struct 
>> bpf_map *map)
>>       if (st_map->links)
>>           bpf_struct_ops_map_put_progs(st_map);
>>       bpf_map_area_free(st_map->links);
>> -    if (st_map->image) {
>> -        arch_free_bpf_trampoline(st_map->image, PAGE_SIZE);
>> -        bpf_jit_uncharge_modmem(PAGE_SIZE);
>> -    }
>> +    bpf_struct_ops_map_free_image(st_map);
>>       bpf_map_area_free(st_map->uvalue);
>>       bpf_map_area_free(st_map);
>>   }
>> @@ -889,20 +949,6 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       st_map->st_ops_desc = st_ops_desc;
>>       map = &st_map->map;
>> -    ret = bpf_jit_charge_modmem(PAGE_SIZE);
>> -    if (ret)
>> -        goto errout_free;
>> -
>> -    st_map->image = arch_alloc_bpf_trampoline(PAGE_SIZE);
>> -    if (!st_map->image) {
>> -        /* __bpf_struct_ops_map_free() uses st_map->image as flag
>> -         * for "charged or not". In this case, we need to unchange
>> -         * here.
>> -         */
>> -        bpf_jit_uncharge_modmem(PAGE_SIZE);
>> -        ret = -ENOMEM;
>> -        goto errout_free;
>> -    }
>>       st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
>>       st_map->links_cnt = btf_type_vlen(t);
>>       st_map->links =
> 

