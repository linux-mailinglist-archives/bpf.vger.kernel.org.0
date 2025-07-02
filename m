Return-Path: <bpf+bounces-62157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21279AF5F59
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3073A4E1A9D
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A52EB5DE;
	Wed,  2 Jul 2025 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wgl4jUDw"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C82F50AA
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475728; cv=none; b=LiLXWkDYUimaDxoqmIhtrgjc7w3DjfSRSL54hFQyzJ06eFRJ7XLBz2mM0ztICBpkfMlKrSm4WoQhvud5DmubKdqn9EnY1AffCC+G1iybXnThZa4zNzXGm8wYJyZa9/sy36iBKz1JEwmWrkVTvY0qfx7F+KKFV5hcL9h9u+ekHxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475728; c=relaxed/simple;
	bh=c6hr2PJBCwdkeoG+j+FC1nS5xWyzE8+ENJh1mN4nZNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7nuHuN/w/AZPkrrKPFzUvXSfydEwCtvjlNDCgZzl6RaGIsfAaoRRy7tx4ayfZLhWK/pDOvk3llvFqwAMqhN+iyCIQxg/yilmDoY2YLof9cQ+YFnzqAxoQAW6A3lpFzUgmrRpzRQ4icktkySZm4xEdTIvq8PZ7Umo3Hfg2vNYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wgl4jUDw; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4a808630-176b-424c-a5e3-24db1b70f5c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751475722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5ANAEIGisTySmfzQhiF7MRG2U5fvK3ajO7Uv8qqQuQ=;
	b=wgl4jUDw1yMZXU4qcGHHeMPEHZZtEz+4gYjKGJGLt1wLRsJTATo0mEySEm13YcRsMd8HQs
	lfm95FCiSeDwPWRqfcV4qqa3EGJVJMj9XNzOW2K2Ufo1BHaMqPzb+npD5dqldkv1d1GmAo
	QcEmuR0DQe8MylrugyAu9U5yNENOj5Q=
Date: Thu, 3 Jul 2025 01:01:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array map
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net
References: <20250624165354.27184-1-leon.hwang@linux.dev>
 <20250624165354.27184-2-leon.hwang@linux.dev>
 <CAEf4BzYFjKEdpf9xHfeW8hs+zzmppvw2-RzJELrRc=QfKfga1A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYFjKEdpf9xHfeW8hs+zzmppvw2-RzJELrRc=QfKfga1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/2 04:22, Andrii Nakryiko wrote:
> On Tue, Jun 24, 2025 at 9:54 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch introduces support for the BPF_F_CPU flag in percpu_array maps
>> to allow updating or looking up values for specific CPUs or for all CPUs
>> with a single value.
>>
>> This enhancement enables:
>>
>> * Efficient update of all CPUs using a single value when cpu == 0xFFFFFFFF.
>> * Targeted update or lookup for a specific CPU otherwise.
>>
>> The flag is passed via:
>>
>> * map_flags in bpf_percpu_array_update() along with the cpu field.
>> * elem_flags in generic_map_update_batch() along with the cpu field.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h            |  5 +--
>>  include/uapi/linux/bpf.h       |  6 ++++
>>  kernel/bpf/arraymap.c          | 46 ++++++++++++++++++++++++----
>>  kernel/bpf/syscall.c           | 56 ++++++++++++++++++++++------------
>>  tools/include/uapi/linux/bpf.h |  6 ++++
>>  5 files changed, 92 insertions(+), 27 deletions(-)
>>
> 
> [...]
> 
>> #define BPF_ALL_CPU    0xFFFFFFFF
> 
> at the very least we have to make it an enum, IMO. but I'm in general
> unsure if we need it at all... and in any case, should it be named
> "BPF_ALL_CPUS" (plural)?
> 

To avoid using such special value, would it be better to update value
across all CPUs when the cpu equals to num_possible_cpus()?

> 
>> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
>> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
>> +                         u64 flags, u32 cpu)
>>  {
>>         struct bpf_array *array = container_of(map, struct bpf_array, map);
>>         u32 index = *(u32 *)key;
>>         void __percpu *pptr;
>> -       int cpu, off = 0;
>> +       int off = 0;
>>         u32 size;
>>
>>         if (unlikely(index >= array->map.max_entries))
>>                 return -ENOENT;
>>
>> +       if (unlikely(flags > BPF_F_CPU))
>> +               /* unknown flags */
>> +               return -EINVAL;
>> +
>>         /* per_cpu areas are zero-filled and bpf programs can only
>>          * access 'value_size' of them, so copying rounded areas
>>          * will not leak any kernel data
>>          */
>>         size = array->elem_size;
>> +
>> +       if (flags & BPF_F_CPU) {
>> +               if (cpu >= num_possible_cpus())
>> +                       return -E2BIG;
>> +
>> +               rcu_read_lock();
>> +               pptr = array->pptrs[index & array->index_mask];
>> +               copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
>> +               check_and_init_map_value(map, value);
>> +               rcu_read_unlock();
>> +               return 0;
>> +       }
>> +
> 
> nit: it seems a bit cleaner to me to not duplicate
> rcu_read_{lock,unlock} and pptr fetching
> 
> I'd probably add `if ((flags & BPF_F_CPU) && cpu >=
> num_possible_cpus())` check, and then within rcu region
> 
> if (flags & BPF_F_CPU) {
>     copy_map_value_long(...);
>     check_and_init_map_value(...);
> } else {
>     for_each_possible_cpu(cpu) {
>        copy_map_value_long(...);
>        check_and_init_map_value(...);
>     }
> }
> 
> 
> This to me is more explicitly showing that locking/data fetching isn't
> different, and it's only about singular CPU vs all CPUs
> 
> (oh, and move int off inside the else branch then as well)
> 

LGTM, I'll do it.

> 
>>         rcu_read_lock();
>>         pptr = array->pptrs[index & array->index_mask];
>>         for_each_possible_cpu(cpu) {
>> @@ -382,15 +400,16 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
>>  }
>>
>>  int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>> -                           u64 map_flags)
>> +                           u64 map_flags, u32 cpu)
>>  {
>>         struct bpf_array *array = container_of(map, struct bpf_array, map);
>>         u32 index = *(u32 *)key;
>>         void __percpu *pptr;
>> -       int cpu, off = 0;
>> +       bool reuse_value;
>> +       int off = 0;
>>         u32 size;
>>
>> -       if (unlikely(map_flags > BPF_EXIST))
>> +       if (unlikely(map_flags > BPF_F_CPU))
>>                 /* unknown flags */
>>                 return -EINVAL;
>>
>> @@ -409,10 +428,25 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>          * so no kernel data leaks possible
>>          */
>>         size = array->elem_size;
>> +
>> +       if ((map_flags & BPF_F_CPU) && cpu != BPF_ALL_CPU) {
>> +               if (cpu >= num_possible_cpus())
>> +                       return -E2BIG;
>> +
>> +               rcu_read_lock();
>> +               pptr = array->pptrs[index & array->index_mask];
>> +               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
>> +               bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
>> +               rcu_read_unlock();
>> +               return 0;
>> +       }
>> +
>> +       reuse_value = (map_flags & BPF_F_CPU) && cpu == BPF_ALL_CPU;
>>         rcu_read_lock();
>>         pptr = array->pptrs[index & array->index_mask];
>>         for_each_possible_cpu(cpu) {
>> -               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
>> +               copy_map_value_long(map, per_cpu_ptr(pptr, cpu),
>> +                                   reuse_value ? value : value + off);
>>                 bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
>>                 off += size;
> 
> 
> ditto here, I'd not touch rcu locking and bpf_obj_free_fields. The
> difference would be singular vs all CPUs, and then for all CPUs with
> BPF_F_CPU we just don't update off, getting desired behavior without
> extra reuse_value variable?
> 

Ack.

> [...]
> 
>> @@ -1941,19 +1941,27 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>>  {
>>         void __user *values = u64_to_user_ptr(attr->batch.values);
>>         void __user *keys = u64_to_user_ptr(attr->batch.keys);
>> +       u64 elem_flags = attr->batch.elem_flags;
>>         u32 value_size, cp, max_count;
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
>> +       if (elem_flags & BPF_F_CPU) {
>> +               if (map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
>> +                       return -EINVAL;
>> +
>> +               value_size = round_up(map->value_size, 8);
>> +       } else {
>> +               value_size = bpf_map_value_size(map);
>> +       }
> 
> why not roll this into bpf_map_value_size() helper? it's internal,
> should be fine
> 

It's to avoid updating value_size by pointer like

err = bpf_map_value_size(map, elem_flags, &value_size);

However, it's OK for me to do so.

> pw-bot: cr
> 
>>
>>         max_count = attr->batch.count;
>>         if (!max_count)
>> @@ -1980,7 +1988,8 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>>                         break;
>>
>>                 err = bpf_map_update_value(map, map_file, key, value,
>> -                                          attr->batch.elem_flags);
>> +                                          attr->batch.elem_flags,
>> +                                          attr->batch.cpu);
> 
> So I think we discussed cpu as a separate field vs embedded into flags
> field, right? I don't remember what I argued for, but looking at this
> patch, it seems like it would be more convenient to have cpu come as
> part of flags, no? And I don't mean UAPI-side, there separate cpu
> field I think makes most sense. But internally I'd roll it into flags
> as ((cpu << 32) | flags), instead of dragging it around everywhere. It
> feels unclean to have "cpu" argument to generic
> bpf_map_copy_value()...
> 
> (and looking at how much code we add just to pass that extra cpu
> argument through libbpf API, maybe combining cpu and flags is actually
> a way to go?..)
> 
> WDYT?
> 

I'd like to embed it into flags field in RFC v2.

Thereafter, we can discuss them clearly.

Thanks,
Leon


