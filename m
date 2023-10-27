Return-Path: <bpf+bounces-13384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762937D8DC7
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227E22822C7
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 04:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1615249;
	Fri, 27 Oct 2023 04:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPlNb377"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC85229
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 04:35:30 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896D31B1
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:35:28 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59b5484fbe6so12673857b3.1
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698381328; x=1698986128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SiwFk+gtJdctFMhDaUo/35oqw8ImmVuQCyaoTcUHc3A=;
        b=LPlNb377simU6JpiwiGWX6qxmfNY/qMh+zjM0i6EdqMAmW0dYiP25fVg0/EuwO72DZ
         BQuGIFP//+WDhQvsZhcvEtM9W6zVomE10/Ioo4JRiKJCkSEWa7NwF8xZQfHCYKzrbgNz
         sujPBsIB/Hp5IYWE2RyXcP/xZblbrIh+SaXYsVe1Af/Jq4bKGhPEyMnkQ/NIaey/TtBM
         yMyuK8CafpWVwkwRJ+LzRUDJBPYqUZrNeqPQH/IZxHXh2dyFfo+NcP/fWo3fCVONaX8y
         TyP5E2KDg+BelcoGRH5OqLtk7KSgLSQgsI/SR9Ne1x0n9lTH3NyNCdV7nOyWCp0LlTIz
         xxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698381328; x=1698986128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SiwFk+gtJdctFMhDaUo/35oqw8ImmVuQCyaoTcUHc3A=;
        b=lRvM8QDRfCVG3BaiGjhdUPZX0wuVhLUoiy9X9hjln9docrYNRJ/eidU4Gxor7NzTjW
         HIGm8svfR27PRf8B+m+8dqeKAsNRZ2vSnLK7uWQigZF1QV/VFl/G2ae/CIAvGAUwYOO+
         q+ydrrP5/Rodtbz3K8fi8vDzETAvpy1EO8NTMX4l8oPUv/WRnF/utJRXk4wCOTh4WldF
         u3qqf3i3ViO/4RxkWW4NjcaLMub91UvZq4CEGF8ysaTwqyBfX/NJlF6eJNx3TAmhpMkj
         /4+8xf74Lz+LUG8DdS8tBwnYKqsrEHULYixU7TZnqaB0eJc2ayHD29IfrUCUzHIX/FFF
         r0MA==
X-Gm-Message-State: AOJu0YyZs02pXW6X699BbS2twHytGDWRhCtprEGconJqjGWJap5HsoZ+
	moZe9//NpgQsnmUTB00vGRg=
X-Google-Smtp-Source: AGHT+IG1zArQf8BWL5WfgNiV6dNjCaMG67/6hZt6f3A2sHQwNPziSmflLoZRbmbmWUl4k7uIzzhk1g==
X-Received: by 2002:a81:79d1:0:b0:583:3c7e:7749 with SMTP id u200-20020a8179d1000000b005833c7e7749mr1299241ywc.41.1698381327690;
        Thu, 26 Oct 2023 21:35:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ed69:fa3e:676a:4a7a? ([2600:1700:6cf8:1240:ed69:fa3e:676a:4a7a])
        by smtp.gmail.com with ESMTPSA id s143-20020a819b95000000b0059f650f46b2sm370975ywg.7.2023.10.26.21.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 21:35:27 -0700 (PDT)
Message-ID: <a57d72c9-ca37-4eea-89b9-2271042fecdc@gmail.com>
Date: Thu, 26 Oct 2023 21:35:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 04/10] bpf: hold module for
 bpf_struct_ops_map.
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, thinker.li@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
Cc: kuifeng@meta.com
References: <20231022050335.2579051-1-thinker.li@gmail.com>
 <20231022050335.2579051-5-thinker.li@gmail.com>
 <fe10e843372f3100419da42a047e0b8ae6967fb6.camel@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <fe10e843372f3100419da42a047e0b8ae6967fb6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/23 14:11, Eduard Zingerman wrote:
> On Sat, 2023-10-21 at 22:03 -0700, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> To ensure that a module remains accessible whenever a struct_ops object of
>> a struct_ops type provided by the module is still in use.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/bpf.h         |  1 +
>>   include/linux/btf.h         |  2 +-
>>   kernel/bpf/bpf_struct_ops.c | 70 ++++++++++++++++++++++++++++++-------
>>   3 files changed, 60 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 4f3b67932ded..26feb8a2da4f 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1626,6 +1626,7 @@ struct bpf_struct_ops {
>>   	void (*unreg)(void *kdata);
>>   	int (*update)(void *kdata, void *old_kdata);
>>   	int (*validate)(void *kdata);
>> +	struct module *owner;
>>   	const char *name;
>>   	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
>>   };
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 8e37f7eb02c7..6a64b372b7a0 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -575,7 +575,7 @@ struct bpf_struct_ops;
>>   struct bpf_struct_ops_desc;
>>   
>>   struct bpf_struct_ops_desc *
>> -btf_add_struct_ops(struct bpf_struct_ops *st_ops);
>> +btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops);
>>   const struct bpf_struct_ops_desc *
>>   btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
>>   
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 0bc21a39257d..413a3f8b26ba 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -388,6 +388,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>   	const struct btf_member *member;
>>   	const struct btf_type *t = st_ops_desc->type;
>>   	struct bpf_tramp_links *tlinks;
>> +	struct module *mod = NULL;
>>   	void *udata, *kdata;
>>   	int prog_fd, err;
>>   	void *image, *image_end;
>> @@ -425,6 +426,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>   		goto unlock;
>>   	}
>>   
>> +	if (st_ops_desc->btf != btf_vmlinux) {
>> +		mod = btf_try_get_module(st_ops_desc->btf);
>> +		if (!mod) {
>> +			err = -EBUSY;
> 
> Nit: there is a disagreement about error code returned for
>       failing btf_try_get_module() across verifier code base:
>       - EINVAL is used 2 times;
>       - ENXIO is used 3 times;
>       - ENOTSUPP is used once.
>       Are you sure EBUSY is a good choice here?


You are right. I think EINVAL is better or this case.


> 
>> +			goto unlock;
>> +		}
>> +	}
>> +
>>   	memcpy(uvalue, value, map->value_size);
>>   
>>   	udata = &uvalue->data;
>> @@ -552,6 +561,10 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>   		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
>>   		 */
>>   		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
>> +		/* Hold the owner module until the struct_ops is
>> +		 * unregistered
>> +		 */
>> +		mod = NULL;
>>   		goto unlock;
>>   	}
>>   
>> @@ -568,6 +581,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>   	memset(uvalue, 0, map->value_size);
>>   	memset(kvalue, 0, map->value_size);
>>   unlock:
>> +	module_put(mod);
>>   	kfree(tlinks);
>>   	mutex_unlock(&st_map->lock);
>>   	return err;
>> @@ -588,6 +602,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
>>   	switch (prev_state) {
>>   	case BPF_STRUCT_OPS_STATE_INUSE:
>>   		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
>> +		module_put(st_map->st_ops_desc->st_ops->owner);
>>   		bpf_map_put(map);
>>   		return 0;
>>   	case BPF_STRUCT_OPS_STATE_TOBEFREE:
>> @@ -674,6 +689,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>   	size_t st_map_size;
>>   	struct bpf_struct_ops_map *st_map;
>>   	const struct btf_type *t, *vt;
>> +	struct module *mod = NULL;
>>   	struct bpf_map *map;
>>   	int ret;
>>   
>> @@ -681,9 +697,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>   	if (!st_ops_desc)
>>   		return ERR_PTR(-ENOTSUPP);
>>   
>> +	if (st_ops_desc->btf != btf_vmlinux) {
>> +		mod = btf_try_get_module(st_ops_desc->btf);
>> +		if (!mod)
>> +			return ERR_PTR(-EINVAL);
>> +	}
>> +
>>   	vt = st_ops_desc->value_type;
>> -	if (attr->value_size != vt->size)
>> -		return ERR_PTR(-EINVAL);
>> +	if (attr->value_size != vt->size) {
>> +		ret = -EINVAL;
>> +		goto errout;
>> +	}
>>   
>>   	t = st_ops_desc->type;
>>   
>> @@ -694,17 +718,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>   		(vt->size - sizeof(struct bpf_struct_ops_value));
>>   
>>   	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
>> -	if (!st_map)
>> -		return ERR_PTR(-ENOMEM);
>> +	if (!st_map) {
>> +		ret = -ENOMEM;
>> +		goto errout;
>> +	}
>>   
>>   	st_map->st_ops_desc = st_ops_desc;
>>   	map = &st_map->map;
>>   
>>   	ret = bpf_jit_charge_modmem(PAGE_SIZE);
>> -	if (ret) {
>> -		__bpf_struct_ops_map_free(map);
>> -		return ERR_PTR(ret);
>> -	}
>> +	if (ret)
>> +		goto errout_free;
>>   
>>   	st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
>>   	if (!st_map->image) {
>> @@ -713,23 +737,32 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>   		 * here.
>>   		 */
>>   		bpf_jit_uncharge_modmem(PAGE_SIZE);
>> -		__bpf_struct_ops_map_free(map);
>> -		return ERR_PTR(-ENOMEM);
>> +		ret = -ENOMEM;
>> +		goto errout_free;
>>   	}
>>   	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
>>   	st_map->links =
>>   		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
>>   				   NUMA_NO_NODE);
>>   	if (!st_map->uvalue || !st_map->links) {
>> -		__bpf_struct_ops_map_free(map);
>> -		return ERR_PTR(-ENOMEM);
>> +		ret = -ENOMEM;
>> +		goto errout_free;
>>   	}
>>   
>>   	mutex_init(&st_map->lock);
>>   	set_vm_flush_reset_perms(st_map->image);
>>   	bpf_map_init_from_attr(map, attr);
>>   
>> +	module_put(mod);
>> +
>>   	return map;
>> +
>> +errout_free:
>> +	__bpf_struct_ops_map_free(map);
>> +	btf = NULL;		/* has been released */
>> +errout:
>> +	module_put(mod);
>> +	return ERR_PTR(ret);
>>   }
>>   
>>   static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
>> @@ -811,6 +844,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>>   		 * bpf_struct_ops_link_create() fails to register.
>>   		 */
>>   		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
>> +		module_put(st_map->st_ops_desc->st_ops->owner);
>>   		bpf_map_put(&st_map->map);
>>   	}
>>   	kfree(st_link);
>> @@ -857,6 +891,10 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>>   	if (!bpf_struct_ops_valid_to_reg(new_map))
>>   		return -EINVAL;
>>   
>> +	/* The old map is holding the refcount for the owner module.  The
>> +	 * ownership of the owner module refcount is going to be
>> +	 * transferred from the old map to the new map.
>> +	 */
>>   	if (!st_map->st_ops_desc->st_ops->update)
>>   		return -EOPNOTSUPP;
>>   
>> @@ -902,6 +940,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>>   	struct bpf_link_primer link_primer;
>>   	struct bpf_struct_ops_map *st_map;
>>   	struct bpf_map *map;
>> +	struct btf *btf;
>>   	int err;
>>   
>>   	map = bpf_map_get(attr->link_create.map_fd);
>> @@ -926,8 +965,15 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>>   	if (err)
>>   		goto err_out;
>>   
>> +	/* Hold the owner module until the struct_ops is unregistered. */
>> +	btf = st_map->st_ops_desc->btf;
>> +	if (btf != btf_vmlinux && !btf_try_get_module(btf)) {
>> +		err = -EINVAL;
>> +		goto err_out;
>> +	}
>>   	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data);
>>   	if (err) {
>> +		module_put(st_map->st_ops_desc->st_ops->owner);
>>   		bpf_link_cleanup(&link_primer);
>>   		link = NULL;
>>   		goto err_out;
> 

