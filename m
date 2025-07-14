Return-Path: <bpf+bounces-63186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9197FB03EF9
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DFC7A8286
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086BF2451C3;
	Mon, 14 Jul 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ljFSGFAT"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CAA1FCFE7
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497239; cv=none; b=tXBV9TpUyWGyCSRANQ09KJlHm1OIuVyqBKqEyz5U1HAOy3MmKk11pu1Motyykb3ZXPIBUq9QqrSS4SPU3TzjX+vqTPG3v82gpXqKkEjuvhjsQtgtjiqh6+sZ8u21qlpC6StokULHHfK757e/3zvz+aTe5p9X7Nf0wOdZNPwFU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497239; c=relaxed/simple;
	bh=prNXQRkRtUaVGj7/TXRpUFKmuQr8XWbiitiQiRG50Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtgFINYAO69j/Clcjk3ezmEA4ptSbhAXuYx24eOYnH64Ih/2qLg2vjr9vpJLK5WG0RdzlG6H+e/gAjlQhQ+N2RL3nq49DF19WzlBJjFq6CuM/2vQzDjd040Nz5UO4eTRshOKCzGfNp/HUt7/oQwYM40Cl5VRkputvSKCH3BeskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ljFSGFAT; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <592129b2-0442-4b10-8b56-0e15d2ce113e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752497232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MV7LF13fTXZxj0A8E5XIBE9hIekvPavcj+pO/DVSFac=;
	b=ljFSGFATN5XOvGoeROXOU9IT/+RxQQW39xHV9rG98s8PZqIWWlDF/sD/CuLWjpQEkyjN1J
	WhgQ9Ewh46Y0imzVHgRiLzNzmMKnU0bUAyIyAL26Emh1m75PnKCsc0zD+MdcxhNf3Pv8a1
	awFlq9WGWYLXQmtpxNg7qp/ZqaroM7U=
Date: Mon, 14 Jul 2025 20:47:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array map
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net
References: <20250707160404.64933-1-leon.hwang@linux.dev>
 <20250707160404.64933-2-leon.hwang@linux.dev>
 <CAEf4BzZCzd0VGNBoLOd=ENxPnwsynuwvKdNYkKhUc7ARFCudSQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZCzd0VGNBoLOd=ENxPnwsynuwvKdNYkKhUc7ARFCudSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/12 02:10, Andrii Nakryiko wrote:
> On Mon, Jul 7, 2025 at 9:04 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch introduces support for the BPF_F_CPU flag in percpu_array maps
>> to allow updating or looking up values for specified CPUs or for all CPUs
>> with a single value.
>>
> 
> For next revision, please drop RFC tag, so this is tested and reviewed
> as a proper patch set.
> 

Sure. I'll drop it.

>> This enhancement enables:
>>
>> * Efficient update of all CPUs using a single value when cpu == (u32)~0.
>> * Targeted update or lookup for a specified CPU otherwise.
>>
>> The flag is passed via:
>>
>> * map_flags in bpf_percpu_array_update() along with embedded cpu field.
>> * elem_flags in generic_map_update_batch() along with separated cpu field.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h            |  3 +-
>>  include/uapi/linux/bpf.h       |  7 +++++
>>  kernel/bpf/arraymap.c          | 56 ++++++++++++++++++++++++++--------
>>  kernel/bpf/syscall.c           | 52 +++++++++++++++++++------------
>>  tools/include/uapi/linux/bpf.h |  7 +++++
>>  5 files changed, 92 insertions(+), 33 deletions(-)
>>
> 
> [...]
> 
>>
>> +       cpu = (u32)(flags >> 32);
>> +       flags &= (u32)~0;
>> +       if (unlikely(flags > BPF_F_CPU))
>> +               return -EINVAL;
>> +       if (unlikely((flags & BPF_F_CPU) && cpu >= num_possible_cpus()))
>> +               return -E2BIG;
>> +
>>         /* per_cpu areas are zero-filled and bpf programs can only
>>          * access 'value_size' of them, so copying rounded areas
>>          * will not leak any kernel data
>> @@ -313,10 +320,15 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
>>         size = array->elem_size;
>>         rcu_read_lock();
>>         pptr = array->pptrs[index & array->index_mask];
>> -       for_each_possible_cpu(cpu) {
>> -               copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
>> -               check_and_init_map_value(map, value + off);
>> -               off += size;
>> +       if (flags & BPF_F_CPU) {
>> +               copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
>> +               check_and_init_map_value(map, value);
>> +       } else {
>> +               for_each_possible_cpu(cpu) {
>> +                       copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
>> +                       check_and_init_map_value(map, value + off);
>> +                       off += size;
>> +               }
>>         }
>>         rcu_read_unlock();
>>         return 0;
>> @@ -387,13 +399,21 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>         struct bpf_array *array = container_of(map, struct bpf_array, map);
>>         u32 index = *(u32 *)key;
>>         void __percpu *pptr;
>> -       int cpu, off = 0;
>> -       u32 size;
>> +       bool reuse_value;
>> +       u32 size, cpu;
>> +       int off = 0;
>>
>> -       if (unlikely(map_flags > BPF_EXIST))
>> +       cpu = (u32)(map_flags >> 32);
>> +       map_flags = map_flags & (u32)~0;
> 
> be consistent, use &= approach as above
> 

Ack.

>> +       if (unlikely(map_flags > BPF_F_CPU))
>>                 /* unknown flags */
>>                 return -EINVAL;
>>
>> +       if (unlikely((map_flags & BPF_F_CPU) && cpu != BPF_ALL_CPUS &&
>> +                    cpu >= num_possible_cpus()))
>> +               /* invalid cpu */
>> +               return -E2BIG;
>> +
>>         if (unlikely(index >= array->map.max_entries))
>>                 /* all elements were pre-allocated, cannot insert a new one */
>>                 return -E2BIG;
>> @@ -409,12 +429,22 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>          * so no kernel data leaks possible
>>          */
>>         size = array->elem_size;
>> +       reuse_value = (map_flags & BPF_F_CPU) && cpu == BPF_ALL_CPUS;
> 
> I find "reuse_value" name extremely misleading, I stumble upon this
> every time (because "value" is ambiguous, is it the source value or
> map value we are updating?). Please drop it, there is no need for it,
> just do `map_flags & BPF_F_CPU` check in that for_each_possible_cpu
> loop below
> 

Ack.

>>         rcu_read_lock();
>>         pptr = array->pptrs[index & array->index_mask];
>> -       for_each_possible_cpu(cpu) {
>> -               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
>> +       if ((map_flags & BPF_F_CPU) && cpu != BPF_ALL_CPUS) {
>> +               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
>>                 bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
>> -               off += size;
>> +       } else {
>> +               for_each_possible_cpu(cpu) {
>> +                       if (!reuse_value) {
>> +                               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
>> +                               off += size;
>> +                       } else {
>> +                               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
>> +                       }
> 
> simpler and less duplication:
> 
> copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
> /*
>  * same user-provided value is used if BPF_F_CPU is specified,
>  * otherwise value is an array of per-cpu values
>  */
> if (!(map_flags & BPF_F_CPU))
>     off += size;
> 

LGTM.

>> +                       bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
>> +               }
>>         }
>>         rcu_read_unlock();
>>         return 0;
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 7db7182a3057..a3ce0cdecb3c 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -129,8 +129,12 @@ bool bpf_map_write_active(const struct bpf_map *map)
>>         return atomic64_read(&map->writecnt) != 0;
>>  }
>>
>> -static u32 bpf_map_value_size(const struct bpf_map *map)
>> +static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
>>  {
>> +       if ((flags & BPF_F_CPU) &&
>> +               map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
> 
> formatting is off, keep single line
> 

Ack.

>> +               return round_up(map->value_size, 8);
>> +
>>         if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
>>             map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
>>             map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
>> @@ -312,7 +316,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
>>             map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
>>                 err = bpf_percpu_hash_copy(map, key, value);
>>         } else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
>> -               err = bpf_percpu_array_copy(map, key, value);
>> +               err = bpf_percpu_array_copy(map, key, value, flags);
>>         } else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
>>                 err = bpf_percpu_cgroup_storage_copy(map, key, value);
>>         } else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
>> @@ -1662,7 +1666,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>>         if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
>>                 return -EINVAL;
>>
>> -       if (attr->flags & ~BPF_F_LOCK)
>> +       if ((attr->flags & (u32)~0) & ~(BPF_F_LOCK | BPF_F_CPU))
> 
> nit: this whole `attr->flags & (u32)~0` looks like an over-engineered
> `(u32)attr->flags`...
> 
>>                 return -EINVAL;
> 
> we should probably also have a condition checking that upper 32 bits
> are zero if BPF_F_CPU is not set?
> 

Correct. We should check the upper 32 bits if BPF_F_CPU is not set. It
should check the flags like
`(attr->flags & ~BPF_F_LOCK) && !(attr->flags & BPF_F_CPU)`.

>>
>>         CLASS(fd, f)(attr->map_fd);
>> @@ -1680,7 +1684,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>>         if (IS_ERR(key))
>>                 return PTR_ERR(key);
>>
>> -       value_size = bpf_map_value_size(map);
>> +       value_size = bpf_map_value_size(map, attr->flags);
>>
>>         err = -ENOMEM;
>>         value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
>> @@ -1749,7 +1753,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>>                 goto err_put;
>>         }
>>
>> -       value_size = bpf_map_value_size(map);
>> +       value_size = bpf_map_value_size(map, attr->flags);
>>         value = kvmemdup_bpfptr(uvalue, value_size);
>>         if (IS_ERR(value)) {
>>                 err = PTR_ERR(value);
>> @@ -1941,19 +1945,25 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>>  {
>>         void __user *values = u64_to_user_ptr(attr->batch.values);
>>         void __user *keys = u64_to_user_ptr(attr->batch.keys);
>> -       u32 value_size, cp, max_count;
>> +       u32 value_size, cp, max_count, cpu = attr->batch.cpu;
>> +       u64 elem_flags = attr->batch.elem_flags;
>>         void *key, *value;
>>         int err = 0;
>>
>> -       if (attr->batch.elem_flags & ~BPF_F_LOCK)
>> +       if (elem_flags & ~(BPF_F_LOCK | BPF_F_CPU))
>>                 return -EINVAL;
>>
>> -       if ((attr->batch.elem_flags & BPF_F_LOCK) &&
>> +       if ((elem_flags & BPF_F_LOCK) &&
>>             !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
>>                 return -EINVAL;
>>         }
>>
>> -       value_size = bpf_map_value_size(map);
>> +       if ((elem_flags & BPF_F_CPU) &&
>> +               map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
>> +               return -EINVAL;
>> +
>> +       value_size = bpf_map_value_size(map, elem_flags);
>> +       elem_flags = (((u64)cpu) << 32) | elem_flags;
> 
> nit: elem_flags |= (u64)cpu << 32;
> 
> same effect, but a bit more explicitly stating "we are just adding
> stuff to elem_flags"
> 

Ack.

>>
>>         max_count = attr->batch.count;
>>         if (!max_count)
>> @@ -1979,8 +1989,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>>                     copy_from_user(value, values + cp * value_size, value_size))
>>                         break;
>>
>> -               err = bpf_map_update_value(map, map_file, key, value,
>> -                                          attr->batch.elem_flags);
>> +               err = bpf_map_update_value(map, map_file, key, value, elem_flags);
>>
>>                 if (err)
>>                         break;
>> @@ -2004,18 +2013,24 @@ int generic_map_lookup_batch(struct bpf_map *map,
>>         void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
>>         void __user *values = u64_to_user_ptr(attr->batch.values);
>>         void __user *keys = u64_to_user_ptr(attr->batch.keys);
>> +       u32 value_size, cp, max_count, cpu = attr->batch.cpu;
>>         void *buf, *buf_prevkey, *prev_key, *key, *value;
>> -       u32 value_size, cp, max_count;
>> +       u64 elem_flags = attr->batch.elem_flags;
>>         int err;
>>
>> -       if (attr->batch.elem_flags & ~BPF_F_LOCK)
>> +       if (elem_flags & ~(BPF_F_LOCK | BPF_F_CPU))
>>                 return -EINVAL;
>>
>> -       if ((attr->batch.elem_flags & BPF_F_LOCK) &&
>> +       if ((elem_flags & BPF_F_LOCK) &&
>>             !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>>                 return -EINVAL;
>>
>> -       value_size = bpf_map_value_size(map);
>> +       if ((elem_flags & BPF_F_CPU) &&
>> +               map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
>> +               return -EINVAL;
>> +
>> +       value_size = bpf_map_value_size(map, elem_flags);
>> +       elem_flags = (((u64)cpu) << 32) | elem_flags;
>>
> 
> ditto
> 

Ack.

>>         max_count = attr->batch.count;
>>         if (!max_count)
> 
> [...]


