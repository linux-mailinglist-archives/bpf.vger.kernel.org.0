Return-Path: <bpf+bounces-62168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C7AF5FFF
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41ED64E7FCC
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD730114C;
	Wed,  2 Jul 2025 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kZs0Wrk7"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97EB2DCF50
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477318; cv=none; b=r9qWnKYDSztIY1Bw+LdwVAIXuHFd9b9RtxFuoQFKw8a+GQxz+7zx4rm9foMdb9tRHTSpwR+l9a7kXe/9s0qJIpxl5CeyfLvNlmZxGnKFDPqzo4mso2Xaf+dUIdmPEYqE18OjEOxQQtlbC0jc6htONfbpHEwiq9v4uUKC6U5DW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477318; c=relaxed/simple;
	bh=aVxjqW9enX6klxoHjoQm+Lg08L6YH43JJBdNzwpfnn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gm2eZ4YuDRBqnjs96z6MZ+ssBfXHPVAMVWcuaI1hWnOpv8R7j5Gg6iqEvOf6yQog/IWLyC6B/iS31CuVTq1pKr0HSBXR6IHuYp9gpQ/y4lYFADFDaCV0aRszcfE++F8JpVSH3RcNuFRwr7aQ/bqTOl99by9McOyObfxMSC441h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kZs0Wrk7; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1135ef3d-1fec-40f6-b2c1-446325951b2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751477313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GowjxSofReGjCqwXKemjjx3SAKZHxKug5kMTnXiRXc=;
	b=kZs0Wrk7zcmBew89aHvhtR880zl4cXrPFeviGwuq7ET7VRCGS58AjqI2/zylInJCAYa368
	x2+pgb3EtOKzspxBMOFpqdMvucio+po2yIV1ARzrGjaeCJovcEC0q2jXOrpzt8Pf9q+Cxs
	q6s91qjZ63Czz0sUJdC3+jTZaUsDzrI=
Date: Thu, 3 Jul 2025 01:28:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 2/3] bpf, libbpf: Support BPF_F_CPU for
 percpu_array map
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net
References: <20250624165354.27184-1-leon.hwang@linux.dev>
 <20250624165354.27184-3-leon.hwang@linux.dev>
 <CAEf4BzagyjD3LAc3s=w=TbVrqxKWJ=t6Enu6s6BN8cAu3Vmzyw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzagyjD3LAc3s=w=TbVrqxKWJ=t6Enu6s6BN8cAu3Vmzyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/2 04:22, Andrii Nakryiko wrote:
> On Tue, Jun 24, 2025 at 9:55 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch adds libbpf support for the BPF_F_CPU flag in percpu_array maps,
>> introducing the following APIs:
>>
>> 1. bpf_map_update_elem_opts(): update with struct bpf_map_update_elem_opts
>> 2. bpf_map_lookup_elem_opts(): lookup with struct bpf_map_lookup_elem_opts
>> 3. bpf_map__update_elem_opts(): high-level wrapper with input validation
>> 4. bpf_map__lookup_elem_opts(): high-level wrapper with input validation
>>
>> Behavior:
>>
>> * If opts->cpu == 0xFFFFFFFF, the update is applied to all CPUs.
>> * Otherwise, it applies only to the specified CPU.
>> * Lookup APIs retrieve values from the target CPU when BPF_F_CPU is used.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/bpf.c           | 37 +++++++++++++++++++++++
>>  tools/lib/bpf/bpf.h           | 35 +++++++++++++++++++++-
>>  tools/lib/bpf/libbpf.c        | 56 +++++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.h        | 45 ++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.map      |  4 +++
>>  tools/lib/bpf/libbpf_common.h | 12 ++++++++
>>  6 files changed, 188 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 6eb421ccf91b..80f7ea041187 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -402,6 +402,24 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
>>         return libbpf_err_errno(ret);
>>  }
>>
>> +int bpf_map_update_elem_opts(int fd, const void *key, const void *value,
>> +                            const struct bpf_map_update_elem_opts *opts)
>> +{
>> +       const size_t attr_sz = offsetofend(union bpf_attr, cpu);
>> +       union bpf_attr attr;
>> +       int ret;
>> +
>> +       memset(&attr, 0, attr_sz);
>> +       attr.map_fd = fd;
>> +       attr.key = ptr_to_u64(key);
>> +       attr.value = ptr_to_u64(value);
>> +       attr.flags = OPTS_GET(opts, flags, 0);
>> +       attr.cpu = OPTS_GET(opts, cpu, BPF_ALL_CPU);
>> +
>> +       ret = sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, attr_sz);
>> +       return libbpf_err_errno(ret);
>> +}
>> +
>>  int bpf_map_lookup_elem(int fd, const void *key, void *value)
>>  {
>>         const size_t attr_sz = offsetofend(union bpf_attr, flags);
>> @@ -433,6 +451,24 @@ int bpf_map_lookup_elem_flags(int fd, const void *key, void *value, __u64 flags)
>>         return libbpf_err_errno(ret);
>>  }
>>
>> +int bpf_map_lookup_elem_opts(int fd, const void *key, void *value,
>> +                            const struct bpf_map_lookup_elem_opts *opts)
>> +{
>> +       const size_t attr_sz = offsetofend(union bpf_attr, cpu);
>> +       union bpf_attr attr;
>> +       int ret;
>> +
>> +       memset(&attr, 0, attr_sz);
>> +       attr.map_fd = fd;
>> +       attr.key = ptr_to_u64(key);
>> +       attr.value = ptr_to_u64(value);
>> +       attr.flags = OPTS_GET(opts, flags, 0);
>> +       attr.cpu = OPTS_GET(opts, cpu, BPF_ALL_CPU);
> 
> can't do that, setting cpu field to 0xffffffff on old kernels will
> cause -EINVAL, immediate backwards compat breakage
> 
> just default it to zero, this field should remain zero and not be used
> unless flags have BPF_F_CPU
> 

Ack.

>> +
>> +       ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, attr_sz);
>> +       return libbpf_err_errno(ret);
>> +}
>> +
>>  int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
>>  {
>>         const size_t attr_sz = offsetofend(union bpf_attr, flags);
>> @@ -542,6 +578,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
>>         attr.batch.count = *count;
>>         attr.batch.elem_flags  = OPTS_GET(opts, elem_flags, 0);
>>         attr.batch.flags = OPTS_GET(opts, flags, 0);
>> +       attr.batch.cpu = OPTS_GET(opts, cpu, BPF_ALL_CPU);
> 
> ditto
> 

Ack.

>>
>>         ret = sys_bpf(cmd, &attr, attr_sz);
>>         *count = attr.batch.count;
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 1342564214c8..7c6a0a3693c9 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -163,12 +163,41 @@ LIBBPF_API int bpf_map_delete_elem_flags(int fd, const void *key, __u64 flags);
>>  LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
>>  LIBBPF_API int bpf_map_freeze(int fd);
>>
>> +/**
>> + * @brief **bpf_map_update_elem_opts** allows for updating percpu map with value
>> + * on specified CPU or on all CPUs.
> 
> IMO, a bit too specific a description. xxx_ops APIs are extended
> versions of original non-opts APIs allowing to pass extra (optional)
> arguments. Keep it generic. cpu field is currently the only "extra",
> but this might grow over time
> 

I'll update it.

>> + *
>> + * @param fd BPF map file descriptor
>> + * @param key pointer to key
>> + * @param value pointer to value
>> + * @param opts options for configuring the way to update percpu map
> 
> again, too specific
> 

Ack.

>> + * @return 0, on success; negative error code, otherwise (errno is also set to
>> + * the error code)
>> + */
>> +LIBBPF_API int bpf_map_update_elem_opts(int fd, const void *key, const void *value,
>> +                                       const struct bpf_map_update_elem_opts *opts);
>> +
>> +/**
>> + * @brief **bpf_map_lookup_elem_opts** allows for looking up the value from
>> + * percpu map on specified CPU.
>> + *
>> + * @param fd BPF map file descriptor
>> + * @param key pointer to key
>> + * @param value pointer to value
>> + * @param opts options for configuring the way to lookup percpu map
>> + * @return 0, on success; negative error code, otherwise (errno is also set to
>> + * the error code)
>> + */
>> +LIBBPF_API int bpf_map_lookup_elem_opts(int fd, const void *key, void *value,
>> +                                       const struct bpf_map_lookup_elem_opts *opts);
>> +
>>  struct bpf_map_batch_opts {
>>         size_t sz; /* size of this struct for forward/backward compatibility */
>>         __u64 elem_flags;
>>         __u64 flags;
>> +       __u32 cpu;
> 
> add size_t: 0 to avoid having non-zeroed padding at the end (see other
> opts structs)
> 

Ack.

>>  };
>> -#define bpf_map_batch_opts__last_field flags
>> +#define bpf_map_batch_opts__last_field cpu
>>
>>
>>  /**
>> @@ -286,6 +315,10 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
>>   *    Update spin_lock-ed map elements. This must be
>>   *    specified if the map value contains a spinlock.
>>   *
>> + * **BPF_F_CPU**
>> + *    As for percpu map, update value on all CPUs if **opts->cpu** is
>> + *    0xFFFFFFFF, or on specified CPU otherwise.
>> + *
>>   * @param fd BPF map file descriptor
>>   * @param keys pointer to an array of *count* keys
>>   * @param values pointer to an array of *count* values
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6445165a24f2..30400bdc20d9 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -10636,6 +10636,34 @@ int bpf_map__lookup_elem(const struct bpf_map *map,
>>         return bpf_map_lookup_elem_flags(map->fd, key, value, flags);
>>  }
>>
>> +int bpf_map__lookup_elem_opts(const struct bpf_map *map, const void *key,
>> +                             size_t key_sz, void *value, size_t value_sz,
>> +                             const struct bpf_map_lookup_elem_opts *opts)
>> +{
>> +       int nr_cpus = libbpf_num_possible_cpus();
>> +       __u32 cpu = OPTS_GET(opts, cpu, nr_cpus);
>> +       __u64 flags = OPTS_GET(opts, flags, 0);
>> +       int err;
>> +
>> +       if (flags & BPF_F_CPU) {
>> +               if (map->def.type != BPF_MAP_TYPE_PERCPU_ARRAY)
>> +                       return -EINVAL;
>> +               if (cpu >= nr_cpus)
>> +                       return -E2BIG;
>> +               if (map->def.value_size != value_sz) {
>> +                       pr_warn("map '%s': unexpected value size %zu provided, expected %u\n",
>> +                               map->name, value_sz, map->def.value_size);
>> +                       return -EINVAL;
>> +               }
> 
> shouldn't this go into validate_map_op?..
> 

It should.

However, to avoid making validate_map_op really complicated, I'd like to
add validate_map_cpu_op to wrap checking cpu and validate_map_op.

>> +       } else {
>> +               err = validate_map_op(map, key_sz, value_sz, true);
>> +               if (err)
>> +                       return libbpf_err(err);
>> +       }
>> +
>> +       return bpf_map_lookup_elem_opts(map->fd, key, value, opts);
>> +}
>> +
>>  int bpf_map__update_elem(const struct bpf_map *map,
>>                          const void *key, size_t key_sz,
>>                          const void *value, size_t value_sz, __u64 flags)
>> @@ -10649,6 +10677,34 @@ int bpf_map__update_elem(const struct bpf_map *map,
>>         return bpf_map_update_elem(map->fd, key, value, flags);
>>  }
>>
>> +int bpf_map__update_elem_opts(const struct bpf_map *map, const void *key,
>> +                             size_t key_sz, const void *value, size_t value_sz,
>> +                             const struct bpf_map_update_elem_opts *opts)
>> +{
>> +       int nr_cpus = libbpf_num_possible_cpus();
>> +       __u32 cpu = OPTS_GET(opts, cpu, nr_cpus);
>> +       __u64 flags = OPTS_GET(opts, flags, 0);
>> +       int err;
>> +
>> +       if (flags & BPF_F_CPU) {
>> +               if (map->def.type != BPF_MAP_TYPE_PERCPU_ARRAY)
>> +                       return -EINVAL;
>> +               if (cpu != BPF_ALL_CPU && cpu >= nr_cpus)
>> +                       return -E2BIG;
>> +               if (map->def.value_size != value_sz) {
>> +                       pr_warn("map '%s': unexpected value size %zu provided, expected %u\n",
>> +                               map->name, value_sz, map->def.value_size);
>> +                       return -EINVAL;
>> +               }
> 
> same, move into validate_map_op
> 

Ack.

>> +       } else {
>> +               err = validate_map_op(map, key_sz, value_sz, true);
>> +               if (err)
>> +                       return libbpf_err(err);
>> +       }
>> +
>> +       return bpf_map_update_elem_opts(map->fd, key, value, opts);
>> +}
>> +
>>  int bpf_map__delete_elem(const struct bpf_map *map,
>>                          const void *key, size_t key_sz, __u64 flags)
>>  {
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index d1cf813a057b..ba0d15028c72 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -1185,6 +1185,28 @@ LIBBPF_API int bpf_map__lookup_elem(const struct bpf_map *map,
>>                                     const void *key, size_t key_sz,
>>                                     void *value, size_t value_sz, __u64 flags);
>>
>> +/**
>> + * @brief **bpf_map__lookup_elem_opts()** allows to lookup BPF map value
>> + * corresponding to provided key with options to lookup percpu map.
>> + * @param map BPF map to lookup element in
>> + * @param key pointer to memory containing bytes of the key used for lookup
>> + * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
>> + * @param value pointer to memory in which looked up value will be stored
>> + * @param value_sz size in byte of value data memory; it has to match BPF map
>> + * definition's **value_size**. For per-CPU BPF maps value size can be
>> + * definition's **value_size** if **BPF_F_CPU** is specified in **opts->flags**,
>> + * or the size described in **bpf_map__lookup_elem()**.
> 
> let's describe all this sizing in one place (either __lookup_elem or
> __lookup_elem_opts) and then refer to that succinctly from another one
> (without BPF_F_CPU exception spread out across two API descriptions)
> 

Let's describe it in __lookup_elem_opts and then refer to that in
__lookup_elem.

>> + * @opts extra options passed to kernel for this operation
>> + * @return 0, on success; negative error, otherwise
>> + *
>> + * **bpf_map__lookup_elem_opts()** is high-level equivalent of
>> + * **bpf_map_lookup_elem_opts()** API with added check for key and value size.
>> + */
>> +LIBBPF_API int bpf_map__lookup_elem_opts(const struct bpf_map *map,
>> +                                        const void *key, size_t key_sz,
>> +                                        void *value, size_t value_sz,
>> +                                        const struct bpf_map_lookup_elem_opts *opts);
>> +
>>  /**
>>   * @brief **bpf_map__update_elem()** allows to insert or update value in BPF
>>   * map that corresponds to provided key.
>> @@ -1209,6 +1231,29 @@ LIBBPF_API int bpf_map__update_elem(const struct bpf_map *map,
>>                                     const void *key, size_t key_sz,
>>                                     const void *value, size_t value_sz, __u64 flags);
>>
>> +/**
>> + * @brief **bpf_map__update_elem_opts()** allows to insert or update value in BPF
>> + * map that corresponds to provided key with options for percpu maps.
>> + * @param map BPF map to insert to or update element in
>> + * @param key pointer to memory containing bytes of the key
>> + * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
>> + * @param value pointer to memory containing bytes of the value
>> + * @param value_sz size in byte of value data memory; it has to match BPF map
>> + * definition's **value_size**. For per-CPU BPF maps value size can be
>> + * definition's **value_size** if **BPF_F_CPU** is specified in **opts->flags**,
>> + * or the size described in **bpf_map__update_elem()**.
>> + * @opts extra options passed to kernel for this operation
>> + * @flags extra flags passed to kernel for this operation
>> + * @return 0, on success; negative error, otherwise
>> + *
>> + * **bpf_map__update_elem_opts()** is high-level equivalent of
>> + * **bpf_map_update_elem_opts()** API with added check for key and value size.
>> + */
>> +LIBBPF_API int bpf_map__update_elem_opts(const struct bpf_map *map,
>> +                                        const void *key, size_t key_sz,
>> +                                        const void *value, size_t value_sz,
>> +                                        const struct bpf_map_update_elem_opts *opts);
>> +
>>  /**
>>   * @brief **bpf_map__delete_elem()** allows to delete element in BPF map that
>>   * corresponds to provided key.
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index c7fc0bde5648..c39814adeae9 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -436,6 +436,10 @@ LIBBPF_1.6.0 {
>>                 bpf_linker__add_buf;
>>                 bpf_linker__add_fd;
>>                 bpf_linker__new_fd;
>> +               bpf_map__lookup_elem_opts;
>> +               bpf_map__update_elem_opts;
>> +               bpf_map_lookup_elem_opts;
>> +               bpf_map_update_elem_opts;
>>                 bpf_object__prepare;
>>                 bpf_program__attach_cgroup_opts;
>>                 bpf_program__func_info;
>> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
>> index 8fe248e14eb6..ef29caf91f9c 100644
>> --- a/tools/lib/bpf/libbpf_common.h
>> +++ b/tools/lib/bpf/libbpf_common.h
>> @@ -89,4 +89,16 @@
>>                 memcpy(&NAME, &___##NAME, sizeof(NAME));                    \
>>         } while (0)
>>
>> +struct bpf_map_update_elem_opts {
>> +       size_t sz; /* size of this struct for forward/backward compatibility */
>> +       __u64 flags;
>> +       __u32 cpu;
> 
> size_t: 0
> 

Ack.

>> +};
>> +
>> +struct bpf_map_lookup_elem_opts {
>> +       size_t sz; /* size of this struct for forward/backward compatibility */
>> +       __u64 flags;
>> +       __u32 cpu;
> 
> size_t: 0
> 

Ack.

Thanks,
Leon


