Return-Path: <bpf+bounces-65215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5AB1DBA0
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCCD189A09C
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142226F443;
	Thu,  7 Aug 2025 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XcXjQNB2"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABCF49641
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754584031; cv=none; b=S+Noj+1OnM7lFf5SomAs20Gg2mGYbyRWI01z6AIwUZyKMD9zdUVNn03hzoBkypot2lucyMWMh4QaB+FL8/YW+ln/vdxXYoGNeXZSaeoDzABlbAe95+1vRAXX0nhS6ghgzghSJL1++bn9widmYhrN1sZTUL5Wl6Xd5DN/8yJFIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754584031; c=relaxed/simple;
	bh=nUSxJm/LNMc4C2uX6Cb8HQoAVTESS9YA5tozIbjcdkQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nm35WGrw/wUI1UOv0dXnzo2iYlveFUtpJnXIOrtic7RbJgH/d9p4/qDYemI3u0P7eqW+hOYPK2ngvmBgCY3zZofT/yLbiNe9LPThQ/3NgsZTeVD/8GNTFpyIf5xeMtIMTDH2d8byjZJz8b0inloDwMmcb1YD0H2a+Mu2bHZVsNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XcXjQNB2; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754584024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHolgX4o8DZgie1zdgMFHjJ/F6GrKnIK0AaG68O7sb0=;
	b=XcXjQNB2IXDAMiidz6vyVsQvXt8emBiO2gE4OEz7iU6VHcKAj67FBD8kcyHGgfhPN/5oah
	MvjhJds1RGAPs6x/FO3M0xaaz8/JDjEh7ApvWTLuENJ9T9GOwlvdFQSNShndivpKWLnFMc
	qv7yYs9IBPmal3MPRo3MQpFTD1WYCgA=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Aug 2025 00:26:55 +0800
Message-Id: <DBWC4H7DD274.1UTL72GTCJ355@linux.dev>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <yonghong.song@linux.dev>, <song@kernel.org>,
 <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Jiri Olsa" <olsajiri@gmail.com>
References: <20250805163017.17015-1-leon.hwang@linux.dev>
 <20250805163017.17015-2-leon.hwang@linux.dev> <aJRlKj0UjdtDM6SU@krava>
In-Reply-To: <aJRlKj0UjdtDM6SU@krava>
X-Migadu-Flow: FLOW_OUT

On Thu Aug 7, 2025 at 4:34 PM +08, Jiri Olsa wrote:
> On Wed, Aug 06, 2025 at 12:30:15AM +0800, Leon Hwang wrote:
>> Introduce support for the BPF_F_CPU flag in percpu_array maps to allow
>> updating values for specified CPU or for all CPUs with a single value.
>>

[...]

>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 3d080916faf97..98759f0b22397 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -295,17 +295,24 @@ static void *percpu_array_map_lookup_percpu_elem(s=
truct bpf_map *map, void *key,
>>  	return per_cpu_ptr(array->pptrs[index & array->index_mask], cpu);
>>  }
>>
>> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
>> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, =
u64 flags)
>>  {
>>  	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
>>  	u32 index =3D *(u32 *)key;
>>  	void __percpu *pptr;
>> -	int cpu, off =3D 0;
>> -	u32 size;
>> +	u32 size, cpu;
>> +	int off =3D 0;
>>
>>  	if (unlikely(index >=3D array->map.max_entries))
>>  		return -ENOENT;
>>
>> +	cpu =3D flags >> 32;
>> +	flags &=3D (u32)~0;
>
> is this necessary?
>

It is unnecessary.

I'll remove it and update

    if (unlikely((u32)flags > BPF_F_CPU))
        return -EINVAL;

>> +	if (unlikely(flags > BPF_F_CPU))
>> +		return -EINVAL;
>> +	if (unlikely((flags & BPF_F_CPU) && cpu >=3D num_possible_cpus()))
>> +		return -ERANGE;
>
> should we check cpu !=3D BPF_ALL_CPUS in here?
>

No. It is meaningless to support cpu =3D=3D BPF_ALL_CPUS, because
(flags & BPF_F_CPU) && cpu =3D=3D BPF_ALL_CPUS is same as ~BPF_F_CPU.

>> +
>>  	/* per_cpu areas are zero-filled and bpf programs can only
>>  	 * access 'value_size' of them, so copying rounded areas
>>  	 * will not leak any kernel data
>> @@ -313,10 +320,15 @@ int bpf_percpu_array_copy(struct bpf_map *map, voi=
d *key, void *value)
>>  	size =3D array->elem_size;
>>  	rcu_read_lock();
>>  	pptr =3D array->pptrs[index & array->index_mask];
>> -	for_each_possible_cpu(cpu) {
>> -		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
>> -		check_and_init_map_value(map, value + off);
>> -		off +=3D size;
>> +	if (flags & BPF_F_CPU) {
>> +		copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
>> +		check_and_init_map_value(map, value);
>> +	} else {
>> +		for_each_possible_cpu(cpu) {
>> +			copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
>> +			check_and_init_map_value(map, value + off);
>> +			off +=3D size;
>> +		}
>>  	}
>>  	rcu_read_unlock();
>>  	return 0;
>> @@ -387,13 +399,20 @@ int bpf_percpu_array_update(struct bpf_map *map, v=
oid *key, void *value,
>>  	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
>>  	u32 index =3D *(u32 *)key;
>>  	void __percpu *pptr;
>> -	int cpu, off =3D 0;
>> -	u32 size;
>> +	u32 size, cpu;
>> +	int off =3D 0;
>>
>> -	if (unlikely(map_flags > BPF_EXIST))
>> +	cpu =3D map_flags >> 32;
>> +	map_flags &=3D (u32)~0;
>> +	if (unlikely(map_flags > BPF_F_CPU))
>>  		/* unknown flags */
>>  		return -EINVAL;
>>
>> +	if (unlikely((map_flags & BPF_F_CPU) && cpu !=3D BPF_ALL_CPUS &&
>> +		     cpu >=3D num_possible_cpus()))
>> +		/* invalid cpu */
>> +		return -ERANGE;
>
> looks like same check as in bpf_percpu_array_copy, maybe we could add
> some helper function for that?
>

If they are same, I'd like to add a helper function.

>> +
>>  	if (unlikely(index >=3D array->map.max_entries))
>>  		/* all elements were pre-allocated, cannot insert a new one */
>>  		return -E2BIG;
>> @@ -411,10 +430,19 @@ int bpf_percpu_array_update(struct bpf_map *map, v=
oid *key, void *value,
>>  	size =3D array->elem_size;
>>  	rcu_read_lock();
>>  	pptr =3D array->pptrs[index & array->index_mask];
>> -	for_each_possible_cpu(cpu) {
>> -		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
>> +	if ((map_flags & BPF_F_CPU) && cpu !=3D BPF_ALL_CPUS) {
>> +		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
>>  		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
>> -		off +=3D size;
>> +	} else {
>> +		for_each_possible_cpu(cpu) {
>> +			copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
>> +			/* same user-provided value is used if BPF_F_CPU is specified,
>> +			 * otherwise value is an array of per-cpu values.
>> +			 */
>> +			if (!(map_flags & BPF_F_CPU))
>> +				off +=3D size;
>> +			bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
>> +		}
>>  	}
>>  	rcu_read_unlock();
>>  	return 0;
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 0fbfa8532c392..43f19d02bc5ce 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -131,8 +131,11 @@ bool bpf_map_write_active(const struct bpf_map *map=
)
>>  	return atomic64_read(&map->writecnt) !=3D 0;
>>  }
>>
>> -static u32 bpf_map_value_size(const struct bpf_map *map)
>> +static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
>>  {
>> +	if ((flags & BPF_F_CPU) && map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_AR=
RAY)
>> +		return round_up(map->value_size, 8);
>> +
>
> nit, maybe we could keep the same style like below and check the map
> type first:
>
> 	if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY && (flags & BPF_F_CPU=
))
> 		return round_up(map->value_size, 8);
> 	else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
>

Ack.

>>  	    map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
>>  	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
>> @@ -314,7 +317,7 @@ static int bpf_map_copy_value(struct bpf_map *map, v=
oid *key, void *value,
>>  	    map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH) {
>>  		err =3D bpf_percpu_hash_copy(map, key, value);
>>  	} else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
>> -		err =3D bpf_percpu_array_copy(map, key, value);
>> +		err =3D bpf_percpu_array_copy(map, key, value, flags);
>>  	} else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
>>  		err =3D bpf_percpu_cgroup_storage_copy(map, key, value);
>>  	} else if (map->map_type =3D=3D BPF_MAP_TYPE_STACK_TRACE) {
>> @@ -1669,7 +1672,10 @@ static int map_lookup_elem(union bpf_attr *attr)
>>  	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
>>  		return -EINVAL;
>>
>> -	if (attr->flags & ~BPF_F_LOCK)
>> +	if ((u32)attr->flags & ~(BPF_F_LOCK | BPF_F_CPU))
>> +		return -EINVAL;
>
> I understand the u32 cast in here..
>
>> +
>> +	if (!((u32)attr->flags & BPF_F_CPU) && attr->flags >> 32)
>>  		return -EINVAL;
>
> .. but do we need it in here and other similar places below?
>

You are right. They are unnecessary.

I will remove them in next revision.

>>
>>  	CLASS(fd, f)(attr->map_fd);
>> @@ -1679,7 +1685,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>>  	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
>>  		return -EPERM;
>>
>> -	if ((attr->flags & BPF_F_LOCK) &&
>> +	if (((u32)attr->flags & BPF_F_LOCK) &&
>>  	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>>  		return -EINVAL;
>>
>> @@ -1687,7 +1693,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>>  	if (IS_ERR(key))
>>  		return PTR_ERR(key);
>>
>> -	value_size =3D bpf_map_value_size(map);
>> +	value_size =3D bpf_map_value_size(map, attr->flags);
>>
>>  	err =3D -ENOMEM;
>>  	value =3D kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
>> @@ -1744,19 +1750,24 @@ static int map_update_elem(union bpf_attr *attr,=
 bpfptr_t uattr)
>>  		goto err_put;
>>  	}
>>
>> -	if ((attr->flags & BPF_F_LOCK) &&
>> +	if (((u32)attr->flags & BPF_F_LOCK) &&
>>  	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
>>  		err =3D -EINVAL;
>>  		goto err_put;
>>  	}
>>
>> +	if (!((u32)attr->flags & BPF_F_CPU) && attr->flags >> 32) {
>> +		err =3D -EINVAL;
>> +		goto err_put;
>> +	}
>> +
>>  	key =3D ___bpf_copy_key(ukey, map->key_size);
>>  	if (IS_ERR(key)) {
>>  		err =3D PTR_ERR(key);
>>  		goto err_put;
>>  	}
>>
>> -	value_size =3D bpf_map_value_size(map);
>> +	value_size =3D bpf_map_value_size(map, attr->flags);
>>  	value =3D kvmemdup_bpfptr(uvalue, value_size);
>>  	if (IS_ERR(value)) {
>>  		err =3D PTR_ERR(value);
>> @@ -1942,6 +1953,25 @@ int generic_map_delete_batch(struct bpf_map *map,
>>  	return err;
>>  }
>>
>> +static int check_map_batch_elem_flags(struct bpf_map *map, u64 elem_fla=
gs)
>> +{
>> +	u32 flags =3D elem_flags;
>> +
>> +	if (flags & ~(BPF_F_LOCK | BPF_F_CPU))
>> +		return -EINVAL;
>> +
>> +	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPI=
N_LOCK))
>> +		return -EINVAL;
>> +
>> +	if (!(flags & BPF_F_CPU) && elem_flags >> 32)
>> +		return -EINVAL;
>> +
>> +	if ((flags & BPF_F_CPU) && map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRA=
Y)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>
> it seems like this check could be used also for non-batch functions as we=
ll?
>
> also it might be more readable if we factor some check_flags function in
> separate patch and then add BPF_F_CPU support
>

Sure. After doing a poc of adding check_flags helper function, this
check can be used also for non-batch functions.

>
>> +
>>  int generic_map_update_batch(struct bpf_map *map, struct file *map_file=
,
>>  			     const union bpf_attr *attr,
>>  			     union bpf_attr __user *uattr)
>> @@ -1952,15 +1982,11 @@ int generic_map_update_batch(struct bpf_map *map=
, struct file *map_file,
>>  	void *key, *value;
>>  	int err =3D 0;
>>
>> -	if (attr->batch.elem_flags & ~BPF_F_LOCK)
>> -		return -EINVAL;
>> -
>> -	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
>> -	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
>> -		return -EINVAL;
>> -	}
>> +	err =3D check_map_batch_elem_flags(map, attr->batch.elem_flags);
>> +	if (err)
>> +		return err;
>>
>> -	value_size =3D bpf_map_value_size(map);
>> +	value_size =3D bpf_map_value_size(map, attr->batch.elem_flags);
>>
>>  	max_count =3D attr->batch.count;
>>  	if (!max_count)
>> @@ -1986,9 +2012,7 @@ int generic_map_update_batch(struct bpf_map *map, =
struct file *map_file,
>>  		    copy_from_user(value, values + cp * value_size, value_size))
>>  			break;
>>
>> -		err =3D bpf_map_update_value(map, map_file, key, value,
>> -					   attr->batch.elem_flags);
>> -
>> +		err =3D bpf_map_update_value(map, map_file, key, value, attr->batch.e=
lem_flags);
>
> there's no change in here right? I'd keep it as it is
>

Ack.

>>  		if (err)
>>  			break;
>>  		cond_resched();
>> @@ -2015,14 +2039,11 @@ int generic_map_lookup_batch(struct bpf_map *map=
,
>>  	u32 value_size, cp, max_count;
>>  	int err;
>>
>> -	if (attr->batch.elem_flags & ~BPF_F_LOCK)
>> -		return -EINVAL;
>> -
>> -	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
>> -	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>> -		return -EINVAL;
>> +	err =3D check_map_batch_elem_flags(map, attr->batch.elem_flags);
>> +	if (err)
>> +		return err;
>>
>> -	value_size =3D bpf_map_value_size(map);
>> +	value_size =3D bpf_map_value_size(map, attr->batch.elem_flags);
>>
>>  	max_count =3D attr->batch.count;
>>  	if (!max_count)
>> @@ -2056,9 +2077,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>>  		rcu_read_unlock();
>>  		if (err)
>>  			break;
>> -		err =3D bpf_map_copy_value(map, key, value,
>> -					 attr->batch.elem_flags);
>> -
>> +		err =3D bpf_map_copy_value(map, key, value, attr->batch.elem_flags);
>
> ditto
>

Ack.

>
> thanks,
> jirka
>

Thanks,
Leon

[...]

