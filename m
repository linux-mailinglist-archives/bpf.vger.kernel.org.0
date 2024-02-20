Return-Path: <bpf+bounces-22352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0F685CBFB
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 00:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484881F23248
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 23:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433D154451;
	Tue, 20 Feb 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TakSAhGp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6A1552E2
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471397; cv=none; b=Na49hbDVoig0FLkJAiDtFVnQL6xg8c+7Jjq42FXeY9sHji1KSZlDBxG0R/YZibXDestigIZzkszUoXS84mWKFoHmp0fmYiv8HVkxFNVOig4yPfWcfRYc30uP7L5PwDWR96Uu15LX7qK9GZkOD8kc4xGXnILFFsDiGyC3C/CZcko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471397; c=relaxed/simple;
	bh=EFheHxVWAooipe/M0e37QmKHbc+jor/Pe9aCh0ynOUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJDdidJkTyrT8tJF/zjkn190kdcIhHFa9L3fiYK/0d0gLKRDdXaNccsd6YMR85fGuCkwJaJkTXefquq0bcKJNt77SoQ8u6J4ccj4oqR4umIuMJJQ4e09I5Qj373Q8nlTnORMlvoWS1Br7DOnXECD8rQ3qFa71G0zwJxC+adlQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TakSAhGp; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so5394876276.3
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 15:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708471394; x=1709076194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSQBf3kkGIAPoUtCJA0aQMfLwy1SKs2AGHjEZf6XuU0=;
        b=TakSAhGp+d1zgkD4kt71pTpyvJTVnwkxUjs01voHFsFrS/GHnhoFSBHoWbb/dY+88s
         jxnAWDSOJ9Qs4Zg4899f3W63tVnhBjrnhPhf28zWikN/9dPLP9csZSOW5VD1rrM3CZrH
         B/RHguHvu6N7Hm4jm8+/cspFwvX46AbXbi7nLGm+O4ttHu1Uctquu8A6MlPWWOGlo+j+
         YKEhSMy3b2sKLgcT7GB0SkPvF+qsdSktjcE721Yd2EeUxz1TS5NchyIVOWSs47egeXkZ
         OMKhzfc69vqQe2xHLlg7k7yWP8i2gGjo09AbCg/Rl7bSKKQPkoHo77He6gHQjfi0UZkV
         sELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471394; x=1709076194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSQBf3kkGIAPoUtCJA0aQMfLwy1SKs2AGHjEZf6XuU0=;
        b=MN4nM8p2YLPrzotDobO7BonrO2aNZy4TPhtSfVA6a/iTAo9Si1Gs4mQS3IElPZU5M7
         6EaVFvMePw8FTbRpj73IvJM/99SNtVECKLKye17Jx3FIC66LC4HvhsfTl+SIvPMhtQB9
         KzR8sVvV6FvTQ3TohrHMPmVDiOjTQuYECx6YenjQWnG4t0SRDjHrMgw7yo+CoH7p1cXf
         UVzFAwSsh/aECiMrlRnGyc3N3Ns/fVhSY+rx34GH5Vb8iXWx65IXRUJqqU3SnM8j4b7w
         vWwPzoU1ZSfgJZzsIajr3w76ch+nn/lY00Jjk1CzkDJNYOlNCxDS8xuBpV3X2cTvhdSb
         qvuw==
X-Forwarded-Encrypted: i=1; AJvYcCVbzT5+kdx4m1N39jzvKyC7jtWPOL1jJYLjgA3M5rtcgyG5m+TQ0KZZXZOHi5awKNwmPuOuYy8bVCUMT8oKajsQc7TS
X-Gm-Message-State: AOJu0Yy9jaUhpY2kXGFYrsyFMIXxS2F+GaTpv1LNXuO6L5NtVBXbKzjS
	CcniF0XH8CuAeHKKUC3FMpCO5HV/MgbA8SVk22ef+5PPdLEhmr7s
X-Google-Smtp-Source: AGHT+IGUR+HwS/GOhnP+zr4ysKDCm9mB3wEdPU1Ugf6t0rSyV99U8gxOiUuDp3oP2YWIHTJNj5qomw==
X-Received: by 2002:a05:690c:87:b0:607:df1d:7cf2 with SMTP id be7-20020a05690c008700b00607df1d7cf2mr14329492ywb.25.1708471394426;
        Tue, 20 Feb 2024 15:23:14 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:26eb:2942:8151:a089? ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id s4-20020a817704000000b0060788326365sm2343977ywc.0.2024.02.20.15.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:23:14 -0800 (PST)
Message-ID: <20e72bdb-a34d-4392-9362-067dc1af24d6@gmail.com>
Date: Tue, 20 Feb 2024 15:23:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: struct_ops supports more than one page
 for trampolines.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240216182828.201727-1-thinker.li@gmail.com>
 <20240216182828.201727-2-thinker.li@gmail.com>
 <a639c697-bc7d-4a1b-8fcd-7c7ac8dabc7f@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <a639c697-bc7d-4a1b-8fcd-7c7ac8dabc7f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/20/24 13:47, Martin KaFai Lau wrote:
> On 2/16/24 10:28 AM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> The BPF struct_ops previously only allowed for one page to be used for 
>> the
>> trampolines of all links in a map. However, we have recently run out of
>> space due to the large number of BPF program links. By allocating
>> additional pages when we exhaust an existing page, we can accommodate 
>> more
>> links in a single map.
>>
>> The variable st_map->image has been changed to st_map->image_pages, 
>> and its
>> type has been changed to an array of pointers to buffers of PAGE_SIZE. 
>> The
>> array is dynamically resized and additional pages are allocated when all
>> existing pages are exhausted.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/bpf_struct_ops.c | 99 ++++++++++++++++++++++++++++++-------
>>   1 file changed, 80 insertions(+), 19 deletions(-)
>>
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 0d7be97a2411..bb7ae665006a 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -30,12 +30,11 @@ struct bpf_struct_ops_map {
>>        */
>>       struct bpf_link **links;
>>       u32 links_cnt;
>> -    /* image is a page that has all the trampolines
>> +    u32 image_pages_cnt;
>> +    /* image_pages is an array of pages that has all the trampolines
>>        * that stores the func args before calling the bpf_prog.
>> -     * A PAGE_SIZE "image" is enough to store all trampoline for
>> -     * "links[]".
>>        */
>> -    void *image;
>> +    void **image_pages;
>>       /* The owner moduler's btf. */
>>       struct btf *btf;
>>       /* uvalue->data stores the kernel struct
>> @@ -535,7 +534,8 @@ static long bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>       void *udata, *kdata;
>>       int prog_fd, err;
>>       void *image, *image_end;
>> -    u32 i;
>> +    void **image_pages;
>> +    u32 i, next_page = 0;
>>       if (flags)
>>           return -EINVAL;
>> @@ -573,8 +573,8 @@ static long bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>       udata = &uvalue->data;
>>       kdata = &kvalue->data;
>> -    image = st_map->image;
>> -    image_end = st_map->image + PAGE_SIZE;
>> +    image = st_map->image_pages[next_page++];
>> +    image_end = image + PAGE_SIZE;
>>       module_type = btf_type_by_id(btf_vmlinux, 
>> st_ops_ids[IDX_MODULE_ID]);
>>       for_each_member(i, t, member) {
>> @@ -657,6 +657,43 @@ static long bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>                               &st_ops->func_models[i],
>>                               *(void **)(st_ops->cfi_stubs + moff),
>>                               image, image_end);
>> +        if (err == -E2BIG) {
>> +            /* Use an additional page to try again.
>> +             *
>> +             * It may reuse pages allocated for the previous
>> +             * failed calls.
>> +             */
>> +            if (next_page >= st_map->image_pages_cnt) {
> 
> This check (more on this later) ...
> 
>> +                /* Allocate an additional page */
>> +                image_pages = krealloc(st_map->image_pages,
>> +                               (st_map->image_pages_cnt + 1) * 
>> sizeof(void *),
>> +                               GFP_KERNEL);
> 
>  From the patch 2 test, one page is enough for at least 20 ops. How 
> about keep it simple and allow a max 8 pages which should be much more 
> than enough for sane usage. (i.e. add "void 
> *images[MAX_STRUCT_OPS_PAGES];" to "struct bpf_struct_ops_map").

Ok!

> 
>> +                if (!image_pages) {
>> +                    err = -ENOMEM;
>> +                    goto reset_unlock;
>> +                }
>> +                st_map->image_pages = image_pages;
>> +
>> +                err = bpf_jit_charge_modmem(PAGE_SIZE);
>> +                if (err)
>> +                    goto reset_unlock;
>> +
>> +                image = arch_alloc_bpf_trampoline(PAGE_SIZE);
>> +                if (!image) {
>> +                    bpf_jit_uncharge_modmem(PAGE_SIZE);
>> +                    err = -ENOMEM;
>> +                    goto reset_unlock;
>> +                }
>> +                st_map->image_pages[st_map->image_pages_cnt++] = image;
>> +            }
>> +            image = st_map->image_pages[next_page++];
>> +            image_end = image + PAGE_SIZE;
>> +
>> +            err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>> +                                &st_ops->func_models[i],
>> +                                *(void **)(st_ops->cfi_stubs + moff),
>> +                                image, image_end);
>> +        }
>>           if (err < 0)
>>               goto reset_unlock;
>> @@ -667,6 +704,18 @@ static long bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>>       }
>> +    while (next_page < st_map->image_pages_cnt) {
> 
> This check and the above "if (next_page >= st_map->image_pages_cnt)" 
> should not happen for the common case?
> 
> Together with the new comment after the above "if (err == -E2BIG)", is 
> it trying to optimize to reuse the pages allocated in the previous 
> error-ed out map_update_elem() call?
> 
> How about keep it simple for the common case and always free all pages 
> when map_update_elem() failed?

Yes, it is an optimization. So, together with max 8 pages and free all
pages when fails, we can remove all these code.

> 
> Also, after this patch, the same calls are used in different places.
> 
> arch_alloc_bpf_trampoline() is done in two different places, one in 
> map_alloc() and one in map_update_elem(). How about do all the page 
> alloc in map_update_elem()?
> 
> bpf_struct_ops_prepare_trampoline() is also called in two different 
> places within the same map_update_elem(). When looking inside the 
> bpf_struct_ops_prepare_trampoline(), it does call 
> arch_bpf_trampoline_size() to learn the required size first. 
> bpf_struct_ops_prepare_trampoline() should be a better place to call 
> arch_alloc_bpf_trampoline() when needed. Then there is no need to retry 
> bpf_struct_ops_prepare_trampoline() in map_update_elem()?

Agree!
> 
> 
>> +        /* Free unused pages
>> +         *
>> +         * The value can not be updated anymore if the value is not
>> +         * rejected by st_ops->validate() or st_ops->reg().  So,
>> +         * there is no reason to keep the unused pages.
>> +         */
>> +        bpf_jit_uncharge_modmem(PAGE_SIZE);
>> +        image = st_map->image_pages[--st_map->image_pages_cnt];
>> +        arch_free_bpf_trampoline(image, PAGE_SIZE);
>> +    }
>> +
>>       if (st_map->map.map_flags & BPF_F_LINK) {
>>           err = 0;
>>           if (st_ops->validate) {
>> @@ -674,7 +723,9 @@ static long bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>               if (err)
>>                   goto reset_unlock;
>>           }
>> -        arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
>> +        for (i = 0; i < next_page; i++)
>> +            arch_protect_bpf_trampoline(st_map->image_pages[i],
>> +                            PAGE_SIZE);
> 
> arch_protect_bpf_trampoline() is called here for BPF_F_LINK.
> 
>>           /* Let bpf_link handle registration & unregistration.
>>            *
>>            * Pair with smp_load_acquire() during lookup_elem().
>> @@ -683,7 +734,8 @@ static long bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           goto unlock;
>>       }
>> -    arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
>> +    for (i = 0; i < next_page; i++)
>> +        arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
> 
> arch_protect_bpf_trampoline() is called here also in the same function 
> for non BPF_F_LINK.
> 
> Can this be cleaned up a bit? For example, "st_ops->validate(kdata);" 
> should not be specific to BPF_F_LINK which had been brought up earlier 
> when making the "->validate" optional. It is a good time to clean this 
> up also.

Ok

> 
> ----
> pw-bot: cr
> 
>>       err = st_ops->reg(kdata);
>>       if (likely(!err)) {
>>           /* This refcnt increment on the map here after
>> @@ -706,7 +758,8 @@ static long bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>        * there was a race in registering the struct_ops (under the 
>> same name) to
>>        * a sub-system through different struct_ops's maps.
>>        */
>> -    arch_unprotect_bpf_trampoline(st_map->image, PAGE_SIZE);
>> +    for (i = 0; i < next_page; i++)
>> +        arch_unprotect_bpf_trampoline(st_map->image_pages[i], 
>> PAGE_SIZE);
>>   reset_unlock:
>>       bpf_struct_ops_map_put_progs(st_map);
>> @@ -771,14 +824,15 @@ static void 
>> bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
>>   static void __bpf_struct_ops_map_free(struct bpf_map *map)
>>   {
>>       struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map 
>> *)map;
>> +    int i;
>>       if (st_map->links)
>>           bpf_struct_ops_map_put_progs(st_map);
>>       bpf_map_area_free(st_map->links);
>> -    if (st_map->image) {
>> -        arch_free_bpf_trampoline(st_map->image, PAGE_SIZE);
>> -        bpf_jit_uncharge_modmem(PAGE_SIZE);
>> -    }
>> +    for (i = 0; i < st_map->image_pages_cnt; i++)
>> +        arch_free_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
>> +    bpf_jit_uncharge_modmem(PAGE_SIZE * st_map->image_pages_cnt);
>> +    kfree(st_map->image_pages);
>>       bpf_map_area_free(st_map->uvalue);
>>       bpf_map_area_free(st_map);
>>   }
>> @@ -888,20 +942,27 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       st_map->st_ops_desc = st_ops_desc;
>>       map = &st_map->map;
>> +    st_map->image_pages = kcalloc(1, sizeof(void *), GFP_KERNEL);
>> +    if (!st_map->image_pages) {
>> +        ret = -ENOMEM;
>> +        goto errout_free;
>> +    }
>> +
>>       ret = bpf_jit_charge_modmem(PAGE_SIZE);
>>       if (ret)
>>           goto errout_free;
>> -    st_map->image = arch_alloc_bpf_trampoline(PAGE_SIZE);
>> -    if (!st_map->image) {
>> -        /* __bpf_struct_ops_map_free() uses st_map->image as flag
>> -         * for "charged or not". In this case, we need to unchange
>> -         * here.
>> +    st_map->image_pages[0] = arch_alloc_bpf_trampoline(PAGE_SIZE);
>> +    if (!st_map->image_pages[0]) {
>> +        /* __bpf_struct_ops_map_free() uses st_map->image_pages_cnt
>> +         * to for uncharging a number of pages.  In this case, we
>> +         * need to uncharge here.
>>            */
>>           bpf_jit_uncharge_modmem(PAGE_SIZE);
>>           ret = -ENOMEM;
>>           goto errout_free;
>>       }
>> +    st_map->image_pages_cnt = 1;
>>       st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
>>       st_map->links_cnt = btf_type_vlen(t);
>>       st_map->links =
> 

