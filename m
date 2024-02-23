Return-Path: <bpf+bounces-22550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104278608BF
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 03:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CAD1C21845
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 02:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35480BA30;
	Fri, 23 Feb 2024 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O5SwGZcM"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179148F47
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708654594; cv=none; b=bC2X2I01y7E375ZeTHyY40VLUaBFr7iKWvPu7Qdo+lHyfm+3+7j/BlclGnXqNiaGfc+SLldib4PR1ZMLYYAqdTdCmWQtWPyG4vb/LtVc/YKxBxqmiOdJ6YBdHSh1AabhsvTQbuw8WCwu1k+lRm3diIXl2pGmHgsigymLbsprarE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708654594; c=relaxed/simple;
	bh=gCrfoN7QZKBzZ1AL4QQv4DTfYwsyLWBOJh8j5m0bmvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mz/hskxWy1PdfchFZ3J+7hQ1ii/ZGesnqbEawkLyoe6IFflaPCIu9Vp6TjFkU+qij7FHowwNWJ/q7rRJW2+NeZSGq+cGgTCvYHiNbVxKYx03LN11Ow/61XpOmY1GBfVqt7IuyQYxOBqFHRBrdZgI+jeRgInpaGIGrmMNr8K9Fr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O5SwGZcM; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7402facf-5f2e-4506-a381-6a84fe1ba841@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708654590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smGjkzJ4zxlA8NVAVZ4GQSIl8niLdYeZcjWt+WqR1TA=;
	b=O5SwGZcM3AC3FwH5y8vLkhxETFvFZWLo0fnhyMgQBIHeAQtF1/iv402kJTta1r4cYxaLCj
	cMTqHpoQXlSmlgRSUQetL7BnJjC0ga3oUl3vcKYWkctUuzZfI4PM8DBPEMhAsZ/teanlnY
	LrkKK3ys6sbOgQPmQJFy/8xGAfjlZDU=
Date: Thu, 22 Feb 2024 18:16:24 -0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <3e4cc350-34c9-42c1-944f-303a466022d2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/22/24 5:35 PM, Kui-Feng Lee wrote:
> 
> 
> On 2/22/24 16:33, Martin KaFai Lau wrote:
>> On 2/21/24 2:59 PM, thinker.li@gmail.com wrote:
>>> @@ -531,10 +567,10 @@ static long bpf_struct_ops_map_update_elem(struct 
>>> bpf_map *map, void *key,
>>>       const struct btf_type *module_type;
>>>       const struct btf_member *member;
>>>       const struct btf_type *t = st_ops_desc->type;
>>> +    void *image = NULL, *image_end = NULL;
>>>       struct bpf_tramp_links *tlinks;
>>>       void *udata, *kdata;
>>>       int prog_fd, err;
>>> -    void *image, *image_end;
>>>       u32 i;
>>>       if (flags)
>>> @@ -573,15 +609,14 @@ static long bpf_struct_ops_map_update_elem(struct 
>>> bpf_map *map, void *key,
>>>       udata = &uvalue->data;
>>>       kdata = &kvalue->data;
>>> -    image = st_map->image;
>>> -    image_end = st_map->image + PAGE_SIZE;
>>>       module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
>>>       for_each_member(i, t, member) {
>>>           const struct btf_type *mtype, *ptype;
>>>           struct bpf_prog *prog;
>>>           struct bpf_tramp_link *link;
>>> -        u32 moff;
>>> +        u32 moff, tflags;
>>> +        int tsize;
>>>           moff = __btf_member_bit_offset(t, member) / 8;
>>>           ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
>>> @@ -653,10 +688,38 @@ static long bpf_struct_ops_map_update_elem(struct 
>>> bpf_map *map, void *key,
>>>                     &bpf_struct_ops_link_lops, prog);
>>>           st_map->links[i] = &link->link;
>>> -        err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>>> -                            &st_ops->func_models[i],
>>> -                            *(void **)(st_ops->cfi_stubs + moff),
>>> -                            image, image_end);
>>> +        tflags = BPF_TRAMP_F_INDIRECT;
>>> +        if (st_ops->func_models[i].ret_size > 0)
>>> +            tflags |= BPF_TRAMP_F_RET_FENTRY_RET;
>>> +
>>> +        /* Compute the size of the trampoline */
>>> +        tlinks[BPF_TRAMP_FENTRY].links[0] = link;
>>> +        tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
>>> +        tsize = arch_bpf_trampoline_size(&st_ops->func_models[i],
>>> +                         tflags, tlinks, NULL);
>>> +        if (tsize < 0) {
>>> +            err = tsize;
>>> +            goto reset_unlock;
>>> +        }
>>> +
>>> +        /* Allocate pages */
>>> +        if (tsize > (unsigned long)image_end - (unsigned long)image) {
>>> +            if (tsize > PAGE_SIZE) {
>>> +                err = -E2BIG;
>>> +                goto reset_unlock;
>>> +            }
>>> +            image = bpf_struct_ops_map_inc_image(st_map);
>>> +            if (IS_ERR(image)) {
>>> +                err = PTR_ERR(image);
>>> +                goto reset_unlock;
>>> +            }
>>> +            image_end = image + PAGE_SIZE;
>>> +        }
>>> +
>>> +        err = arch_prepare_bpf_trampoline(NULL, image, image_end,
>>> +                          &st_ops->func_models[i],
>>> +                          tflags, tlinks,
>>> +                          *(void **)(st_ops->cfi_stubs + moff));
>>
>> I don't prefer to copy the BPF_TRAMP_F_* setting on tflags, tlinks, and the 
>> arch_*_trampoline_*() logic from bpf_struct_ops_prepare_trampoline() which is 
>> used by the bpf_dummy_ops for testing also. Considering struct_ops supports 
>> kernel module now, in the future, it is better to move bpf_dummy_ops out to 
>> the bpf_testmod somehow and avoid its bpf_struct_ops_prepare_trampoline() 
>> usage. For now, it is still better to keep bpf_struct_ops_prepare_trampoline() 
>> to be reusable by both.
>>
>> Have you thought about the earlier suggestion in v1 to do 
>> arch_alloc_bpf_trampoline() in bpf_struct_ops_prepare_trampoline() instead of 
>> copying codes from bpf_struct_ops_prepare_trampoline() to 
>> bpf_struct_ops_map_update_elem()?
>>
>> Something like this (untested code):
>>
>> void *bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>>                      struct bpf_tramp_link *link,
>>                      const struct btf_func_model *model,
>>                      void *stub_func, void *image,
>>                      u32 *image_off,
>>                      bool allow_alloc)

To be a little more specific, the changes in bpf_struct_ops_map_update_elem()
could be mostly like this (untested):

		ret_image = bpf_struct_ops_prepare_trampoline(tlinks, link,
							      &st_ops->func_models[i],
							      *(void **)(st_ops->cfi_stubs + moff),
							      image, &image_off,
							      st_map->image_pages_cnt < MAX_TRAMP_IMAGE_PAGES);
		if (IS_ERR(ret_image))
			goto reset_unlock;

		if (image != ret_image) {
			image = ret_image;
			st_map->image_pages[st_map->image_pages_cnt++] = image;
		}

> 
> 
> How about pass a struct bpf_struct_ops_map to
> bpf_struct_ops_prepare_trampoline(). If the pointer of struct
> bpf_struct_ops_map is not NULL, try to allocate new pages for the map?
> 
> For example,
> 
> static int
> _bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
> 
>                                     struct bpf_tramp_link *link,
> 
>                                     const struct btf_func_model *model,
> 
>                                     void *stub_func, void *image,
>                                     void *image_end,
>                                     struct bpf_struct_ops_map *st_map)
> {
> 
> ...
> 
>      if (!image || size > PAGE_SIZE - *image_off) {
>          if (!st_map)

Why only limit to st_map != NULL?

arch_alloc_bpf_trampoline() is also called in bpf_dummy_ops.
If bpf_struct_ops_prepare_trampoline() can do the alloc, it may as well simplify
bpf_dummy_ops and just use bpf_struct_ops_prepare_trampoline() to alloc.

>              return -E2BIG;
>          image = bpf_struct_ops_map_inc_image(st_map);
>          if (IS_ERR(image))
>              return PTR_ERR(image);
>          image_end = image + PAGE_SIZE;
>      }
> ...
> }
> 
> int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
> 
>                                        struct bpf_tramp_link *link,
> 
>                                        const struct btf_func_model*model,
>                                        void *stub_func, void *image,
>                                        void *image_end)
> {
>      return _bpf_struct_ops_prepare_trampoline(tlinks, link, model,
>                                                stub_func, image,
>                                                image_end, NULL);
> }
> 
>> {
>>      u32 flags = BPF_TRAMP_F_INDIRECT;
>>      void *new_image = NULL;
>>      int size;
>>
>>      tlinks[BPF_TRAMP_FENTRY].links[0] = link;
>>      tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
>>
>>      if (model->ret_size > 0)
>>          flags |= BPF_TRAMP_F_RET_FENTRY_RET;
>>
>>      size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
>>      if (size < 0)
>>          return ERR_PTR(size);
>>      if (!image || size > PAGE_SIZE - *image_off) {
>>          int err;
>>
>>          if (!allow_alloc)
>>              return ERR_PTR(-E2BIG);
>>
>>          err = bpf_jit_charge_modmem(PAGE_SIZE);
>>          if (err)
>>              return ERR_PTR(err);
>>
>>          new_image = image = arch_alloc_bpf_trampoline(PAGE_SIZE);
>>          if (!new_image) {
>>              bpf_jit_uncharge_modmem(PAGE_SIZE);
>>              return ERR_PTR(-ENOMEM);
>>          }
>>          *image_off = 0;
>>      }
>>
>>
>>      size = arch_prepare_bpf_trampoline(NULL, image + *image_off,
>>                         image + PAGE_SIZE,
>>                         model, flags, tlinks, stub_func);
>>      if (size >= 0) {
>>          *image_off += size;
>>          return image;
>>      }
>>
>>      if (new_image) {
>>          bpf_jit_uncharge_modmem(PAGE_SIZE);
>>          arch_free_bpf_trampoline(new_image, PAGE_SIZE);
>>      }
>>
>>      return ERR_PTR(size);
>> }
>>
>> ----
>>
>> pw-bot: cr
>>
>>>           if (err < 0)
>>>               goto reset_unlock;
>>> @@ -672,10 +735,11 @@ static long bpf_struct_ops_map_update_elem(struct 
>>> bpf_map *map, void *key,
>>>           if (err)
>>>               goto reset_unlock;
>>>       }
>>> +    for (i = 0; i < st_map->image_pages_cnt; i++)
>>> +        arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
>>>       if (st_map->map.map_flags & BPF_F_LINK) {
>>>           err = 0;
>>> -        arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
>>>           /* Let bpf_link handle registration & unregistration.
>>>            *
>>>            * Pair with smp_load_acquire() during lookup_elem().
>>> @@ -684,7 +748,6 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map 
>>> *map, void *key,
>>>           goto unlock;
>>>       }
>>> -    arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
>>>       err = st_ops->reg(kdata);
>>>       if (likely(!err)) {
>>>           /* This refcnt increment on the map here after
>>> @@ -707,9 +770,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map 
>>> *map, void *key,
>>>        * there was a race in registering the struct_ops (under the same name) to
>>>        * a sub-system through different struct_ops's maps.
>>>        */
>>> -    arch_unprotect_bpf_trampoline(st_map->image, PAGE_SIZE);
>>>   reset_unlock:
>>> +    bpf_struct_ops_map_free_image(st_map);
>>>       bpf_struct_ops_map_put_progs(st_map);
>>>       memset(uvalue, 0, map->value_size);
>>>       memset(kvalue, 0, map->value_size);
>>> @@ -776,10 +839,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>>>       if (st_map->links)
>>>           bpf_struct_ops_map_put_progs(st_map);
>>>       bpf_map_area_free(st_map->links);
>>> -    if (st_map->image) {
>>> -        arch_free_bpf_trampoline(st_map->image, PAGE_SIZE);
>>> -        bpf_jit_uncharge_modmem(PAGE_SIZE);
>>> -    }
>>> +    bpf_struct_ops_map_free_image(st_map);
>>>       bpf_map_area_free(st_map->uvalue);
>>>       bpf_map_area_free(st_map);
>>>   }
>>> @@ -889,20 +949,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union 
>>> bpf_attr *attr)
>>>       st_map->st_ops_desc = st_ops_desc;
>>>       map = &st_map->map;
>>> -    ret = bpf_jit_charge_modmem(PAGE_SIZE);
>>> -    if (ret)
>>> -        goto errout_free;
>>> -
>>> -    st_map->image = arch_alloc_bpf_trampoline(PAGE_SIZE);
>>> -    if (!st_map->image) {
>>> -        /* __bpf_struct_ops_map_free() uses st_map->image as flag
>>> -         * for "charged or not". In this case, we need to unchange
>>> -         * here.
>>> -         */
>>> -        bpf_jit_uncharge_modmem(PAGE_SIZE);
>>> -        ret = -ENOMEM;
>>> -        goto errout_free;
>>> -    }
>>>       st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
>>>       st_map->links_cnt = btf_type_vlen(t);
>>>       st_map->links =
>>


