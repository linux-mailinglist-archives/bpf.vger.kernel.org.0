Return-Path: <bpf+bounces-65186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC59DB1D44E
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 10:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F084E582BE0
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF644254849;
	Thu,  7 Aug 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy6gI8XJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521761F09A8
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555697; cv=none; b=IZTjUIeKvCB6yE31GPxpjHsP0QBp10gf2ONcJ4I5+zh3rLYUfvy/cd08d6HXsXmQ7KI5Sn/6vmH866hElyr8JMq+D0Oo1hJDA4eI+AULB9CCKEcDneNQp9MrbsMuzLUsIPpq5s/mb7qlkK1qLBz3BhOBpSjzx1jTbgCx6KLek08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555697; c=relaxed/simple;
	bh=uWhVeVke7mp28LVw7O2Q08aNSn1p+JkEi1AW6TCBYlg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0asCOtEjK9QfDCmPRDlZ4sYpDlINGKt/XvsAE9AAbkAcbKNUtIri4IJMPi7e775YApIfLeHaGLAm7wxOZlVF1dVmiC3Df1txoTtV+SVcRCmneQIWxGvRcJ6gwRYI61jN1ZSDcDiw6+7n6nkXE5YSgKsjKoXGN2CTbFdUb9fiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy6gI8XJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af93150f7c2so109460266b.3
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754555693; x=1755160493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PuNyaJBvVgn+Zo+4qQQ4pr1y7L8DXjhSM01pJ0T4TY=;
        b=Gy6gI8XJEXSZ4AmqKWnddpY6aDbzkYC5uaBykVYflW9SwAFBAf8rkJYZy9fgGkvgMo
         aVO+navmmOIjYb2PbN76WEHUGYF4s6lJRdEtygaXEae03xm41bzhwAIekpgj7nVQx4bX
         mQD25DliZ0bLcu9LbfjmA2P3RnzVO0Hf1ixDZZNZ7tfo3ASoioX6D5/8W8r25HZCSw8J
         8r3mc79chvKPBcwbx3hyOdX6aK08Gh9Dtb2zsAvSWcFHAUhGbeet58QwOOtvdMKZBarm
         ay5ueeEj2oYhPXUiOqoMLW46iILG+aun6mpzYeqrrg9s53Zt6bZjygGnMIdUc7ESzd3C
         Tweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754555693; x=1755160493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PuNyaJBvVgn+Zo+4qQQ4pr1y7L8DXjhSM01pJ0T4TY=;
        b=hCbIBTY0/Bmf93M6Wfr1DWdqF+vaL9sjcARtAPQV9zInIIJaEUN8XofMRgvAIiVB7p
         5XQDSiw9KoLlQfx6PjgopN4HadqR0m17+/yUA1YlXChG9uuJO8F70fsZ3eZ+zAF092GW
         CRlNjkQAHdLiBIGZ4M1VloFKpTyqLpLypZGH4D2yC67k1y2qFtMmtuG8jJhm//jo2CO2
         5pyFRWxByKgPfCt1QV61jqziPrctDDONkUB2vtY85LkTmdqVh8w3JrxQT2cM/7KoS6Ns
         HEXCPot/MsJ5xZft727nowvGcOyMKQjNEI1Og/gNqI2K3xlwKScLpKIKB984aicNn2hm
         yyNg==
X-Gm-Message-State: AOJu0YxDaSTkK5w8buXYDALljYiHIZX5zkvQsn6c2NZjxrbM4vaDU+mu
	jaOmuVNosOPCsmKfRMNk77e+g/vRIq96lLUACh9/vh7WprGUq8oIVgWx
X-Gm-Gg: ASbGncsgUmvxAEBdphZwd19zWxN5H32JrMQllCSwmiSxxV+YWkUSRw2swgwjV5bNgNM
	UGF3RuuWmh6BOoa7VMXkMwgH7WUc/swfSzGHrnFvw0cCD8ZaS1LcrdfLURkptIVHkqnkvcwCoJL
	7upbOUL+LS0kXlmKwTMwTsIV7wvE6xwj3+k4LC85l16f7BZfo0giz0ghO379osgbApRNmpNwa+I
	QP1L7o5P13emXny+oyCsqOFCuoLCN2Xw/UnBn17KEUBHVq8fFti5teEpMpwkNDSRd+4yW3iptBf
	OgirFhFASL3Z7ozOCClQ6sS65+9Utd5T7c/jf2EHZ9t8i3r4dvnP1lEpFG22g5yAlR4UD0fA4sx
	LzVYLhHkR
X-Google-Smtp-Source: AGHT+IGYmIxni7J3HYI1/dzRR+DY/8OvEX/XsNssTFs1nIOCP+lW0HgPQ9wHIykHWaIMtETv2lfoCQ==
X-Received: by 2002:a17:907:94d6:b0:af2:5229:bd74 with SMTP id a640c23a62f3a-af990344c44mr486719866b.26.1754555693205;
        Thu, 07 Aug 2025 01:34:53 -0700 (PDT)
Received: from krava ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af9383590desm1050023866b.76.2025.08.07.01.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 01:34:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 7 Aug 2025 10:34:50 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org,
	eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array maps
Message-ID: <aJRlKj0UjdtDM6SU@krava>
References: <20250805163017.17015-1-leon.hwang@linux.dev>
 <20250805163017.17015-2-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805163017.17015-2-leon.hwang@linux.dev>

On Wed, Aug 06, 2025 at 12:30:15AM +0800, Leon Hwang wrote:
> Introduce support for the BPF_F_CPU flag in percpu_array maps to allow
> updating values for specified CPU or for all CPUs with a single value.
> 
> This enhancement enables:
> 
> * Efficient update of all CPUs using a single value when cpu == (u32)~0.
> * Targeted update or lookup for a specified CPU otherwise.
> 
> The flag is passed via:
> 
> * map_flags in bpf_percpu_array_update() along with embedded cpu field.
> * elem_flags in generic_map_update_batch() along with embedded cpu field.
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h            |  3 +-
>  include/uapi/linux/bpf.h       |  6 +++
>  kernel/bpf/arraymap.c          | 54 ++++++++++++++++++------
>  kernel/bpf/syscall.c           | 77 +++++++++++++++++++++-------------
>  tools/include/uapi/linux/bpf.h |  6 +++
>  5 files changed, 103 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cc700925b802f..c17c45f797ed9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2691,7 +2691,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
>  				   struct bpf_func_state *callee);
>  
>  int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
> +			  u64 flags);
>  int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
>  			   u64 flags);
>  int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 233de8677382e..67bc35e4d6a8d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1372,6 +1372,12 @@ enum {
>  	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
>  	BPF_EXIST	= 2, /* update existing element */
>  	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
> +	BPF_F_CPU	= 8, /* map_update for percpu_array */
> +};
> +
> +enum {
> +	/* indicate updating value across all CPUs for percpu maps. */
> +	BPF_ALL_CPUS	= (__u32)~0,
>  };
>  
>  /* flags for BPF_MAP_CREATE command */
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 3d080916faf97..98759f0b22397 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -295,17 +295,24 @@ static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, void *key,
>  	return per_cpu_ptr(array->pptrs[index & array->index_mask], cpu);
>  }
>  
> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags)
>  {
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
>  	u32 index = *(u32 *)key;
>  	void __percpu *pptr;
> -	int cpu, off = 0;
> -	u32 size;
> +	u32 size, cpu;
> +	int off = 0;
>  
>  	if (unlikely(index >= array->map.max_entries))
>  		return -ENOENT;
>  
> +	cpu = flags >> 32;
> +	flags &= (u32)~0;

is this necessary?

> +	if (unlikely(flags > BPF_F_CPU))
> +		return -EINVAL;
> +	if (unlikely((flags & BPF_F_CPU) && cpu >= num_possible_cpus()))
> +		return -ERANGE;

should we check cpu != BPF_ALL_CPUS in here?

> +
>  	/* per_cpu areas are zero-filled and bpf programs can only
>  	 * access 'value_size' of them, so copying rounded areas
>  	 * will not leak any kernel data
> @@ -313,10 +320,15 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
>  	size = array->elem_size;
>  	rcu_read_lock();
>  	pptr = array->pptrs[index & array->index_mask];
> -	for_each_possible_cpu(cpu) {
> -		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
> -		check_and_init_map_value(map, value + off);
> -		off += size;
> +	if (flags & BPF_F_CPU) {
> +		copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
> +		check_and_init_map_value(map, value);
> +	} else {
> +		for_each_possible_cpu(cpu) {
> +			copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
> +			check_and_init_map_value(map, value + off);
> +			off += size;
> +		}
>  	}
>  	rcu_read_unlock();
>  	return 0;
> @@ -387,13 +399,20 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
>  	u32 index = *(u32 *)key;
>  	void __percpu *pptr;
> -	int cpu, off = 0;
> -	u32 size;
> +	u32 size, cpu;
> +	int off = 0;
>  
> -	if (unlikely(map_flags > BPF_EXIST))
> +	cpu = map_flags >> 32;
> +	map_flags &= (u32)~0;
> +	if (unlikely(map_flags > BPF_F_CPU))
>  		/* unknown flags */
>  		return -EINVAL;
>  
> +	if (unlikely((map_flags & BPF_F_CPU) && cpu != BPF_ALL_CPUS &&
> +		     cpu >= num_possible_cpus()))
> +		/* invalid cpu */
> +		return -ERANGE;

looks like same check as in bpf_percpu_array_copy, maybe we could add
some helper function for that?

> +
>  	if (unlikely(index >= array->map.max_entries))
>  		/* all elements were pre-allocated, cannot insert a new one */
>  		return -E2BIG;
> @@ -411,10 +430,19 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>  	size = array->elem_size;
>  	rcu_read_lock();
>  	pptr = array->pptrs[index & array->index_mask];
> -	for_each_possible_cpu(cpu) {
> -		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
> +	if ((map_flags & BPF_F_CPU) && cpu != BPF_ALL_CPUS) {
> +		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
>  		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
> -		off += size;
> +	} else {
> +		for_each_possible_cpu(cpu) {
> +			copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
> +			/* same user-provided value is used if BPF_F_CPU is specified,
> +			 * otherwise value is an array of per-cpu values.
> +			 */
> +			if (!(map_flags & BPF_F_CPU))
> +				off += size;
> +			bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
> +		}
>  	}
>  	rcu_read_unlock();
>  	return 0;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0fbfa8532c392..43f19d02bc5ce 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -131,8 +131,11 @@ bool bpf_map_write_active(const struct bpf_map *map)
>  	return atomic64_read(&map->writecnt) != 0;
>  }
>  
> -static u32 bpf_map_value_size(const struct bpf_map *map)
> +static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
>  {
> +	if ((flags & BPF_F_CPU) && map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
> +		return round_up(map->value_size, 8);
> +

nit, maybe we could keep the same style like below and check the map
type first:

	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY && (flags & BPF_F_CPU))
		return round_up(map->value_size, 8);
	else if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||

>  	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
>  	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
> @@ -314,7 +317,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
>  	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
>  		err = bpf_percpu_hash_copy(map, key, value);
>  	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
> -		err = bpf_percpu_array_copy(map, key, value);
> +		err = bpf_percpu_array_copy(map, key, value, flags);
>  	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
>  		err = bpf_percpu_cgroup_storage_copy(map, key, value);
>  	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
> @@ -1669,7 +1672,10 @@ static int map_lookup_elem(union bpf_attr *attr)
>  	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
>  		return -EINVAL;
>  
> -	if (attr->flags & ~BPF_F_LOCK)
> +	if ((u32)attr->flags & ~(BPF_F_LOCK | BPF_F_CPU))
> +		return -EINVAL;

I understand the u32 cast in here..

> +
> +	if (!((u32)attr->flags & BPF_F_CPU) && attr->flags >> 32)
>  		return -EINVAL;

.. but do we need it in here and other similar places below?

>  
>  	CLASS(fd, f)(attr->map_fd);
> @@ -1679,7 +1685,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>  	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
>  		return -EPERM;
>  
> -	if ((attr->flags & BPF_F_LOCK) &&
> +	if (((u32)attr->flags & BPF_F_LOCK) &&
>  	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>  		return -EINVAL;
>  
> @@ -1687,7 +1693,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>  	if (IS_ERR(key))
>  		return PTR_ERR(key);
>  
> -	value_size = bpf_map_value_size(map);
> +	value_size = bpf_map_value_size(map, attr->flags);
>  
>  	err = -ENOMEM;
>  	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> @@ -1744,19 +1750,24 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>  		goto err_put;
>  	}
>  
> -	if ((attr->flags & BPF_F_LOCK) &&
> +	if (((u32)attr->flags & BPF_F_LOCK) &&
>  	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
>  		err = -EINVAL;
>  		goto err_put;
>  	}
>  
> +	if (!((u32)attr->flags & BPF_F_CPU) && attr->flags >> 32) {
> +		err = -EINVAL;
> +		goto err_put;
> +	}
> +
>  	key = ___bpf_copy_key(ukey, map->key_size);
>  	if (IS_ERR(key)) {
>  		err = PTR_ERR(key);
>  		goto err_put;
>  	}
>  
> -	value_size = bpf_map_value_size(map);
> +	value_size = bpf_map_value_size(map, attr->flags);
>  	value = kvmemdup_bpfptr(uvalue, value_size);
>  	if (IS_ERR(value)) {
>  		err = PTR_ERR(value);
> @@ -1942,6 +1953,25 @@ int generic_map_delete_batch(struct bpf_map *map,
>  	return err;
>  }
>  
> +static int check_map_batch_elem_flags(struct bpf_map *map, u64 elem_flags)
> +{
> +	u32 flags = elem_flags;
> +
> +	if (flags & ~(BPF_F_LOCK | BPF_F_CPU))
> +		return -EINVAL;
> +
> +	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
> +		return -EINVAL;
> +
> +	if (!(flags & BPF_F_CPU) && elem_flags >> 32)
> +		return -EINVAL;
> +
> +	if ((flags & BPF_F_CPU) && map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
> +		return -EINVAL;
> +
> +	return 0;
> +}

it seems like this check could be used also for non-batch functions as well?

also it might be more readable if we factor some check_flags function in
separate patch and then add BPF_F_CPU support


> +
>  int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>  			     const union bpf_attr *attr,
>  			     union bpf_attr __user *uattr)
> @@ -1952,15 +1982,11 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>  	void *key, *value;
>  	int err = 0;
>  
> -	if (attr->batch.elem_flags & ~BPF_F_LOCK)
> -		return -EINVAL;
> -
> -	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> -	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
> -		return -EINVAL;
> -	}
> +	err = check_map_batch_elem_flags(map, attr->batch.elem_flags);
> +	if (err)
> +		return err;
>  
> -	value_size = bpf_map_value_size(map);
> +	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
>  
>  	max_count = attr->batch.count;
>  	if (!max_count)
> @@ -1986,9 +2012,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>  		    copy_from_user(value, values + cp * value_size, value_size))
>  			break;
>  
> -		err = bpf_map_update_value(map, map_file, key, value,
> -					   attr->batch.elem_flags);
> -
> +		err = bpf_map_update_value(map, map_file, key, value, attr->batch.elem_flags);

there's no change in here right? I'd keep it as it is

>  		if (err)
>  			break;
>  		cond_resched();
> @@ -2015,14 +2039,11 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  	u32 value_size, cp, max_count;
>  	int err;
>  
> -	if (attr->batch.elem_flags & ~BPF_F_LOCK)
> -		return -EINVAL;
> -
> -	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> -	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
> -		return -EINVAL;
> +	err = check_map_batch_elem_flags(map, attr->batch.elem_flags);
> +	if (err)
> +		return err;
>  
> -	value_size = bpf_map_value_size(map);
> +	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
>  
>  	max_count = attr->batch.count;
>  	if (!max_count)
> @@ -2056,9 +2077,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  		rcu_read_unlock();
>  		if (err)
>  			break;
> -		err = bpf_map_copy_value(map, key, value,
> -					 attr->batch.elem_flags);
> -
> +		err = bpf_map_copy_value(map, key, value, attr->batch.elem_flags);

ditto


thanks,
jirka

>  		if (err == -ENOENT)
>  			goto next_key;
>  
> @@ -2144,7 +2163,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>  		goto err_put;
>  	}
>  
> -	value_size = bpf_map_value_size(map);
> +	value_size = bpf_map_value_size(map, 0);
>  
>  	err = -ENOMEM;
>  	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 233de8677382e..67bc35e4d6a8d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1372,6 +1372,12 @@ enum {
>  	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
>  	BPF_EXIST	= 2, /* update existing element */
>  	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
> +	BPF_F_CPU	= 8, /* map_update for percpu_array */
> +};
> +
> +enum {
> +	/* indicate updating value across all CPUs for percpu maps. */
> +	BPF_ALL_CPUS	= (__u32)~0,
>  };
>  
>  /* flags for BPF_MAP_CREATE command */
> -- 
> 2.50.1
> 
> 

