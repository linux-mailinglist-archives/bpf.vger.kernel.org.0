Return-Path: <bpf+bounces-50753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38108A2BFDF
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 10:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AA47A2B22
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95C71CDFCC;
	Fri,  7 Feb 2025 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QT6nko6+"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C259B32C8B
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921728; cv=none; b=ZWlG4pHyq/EPlRwxPKpQI/DfMHye0xk13qtEpytJpEVEhiJBSB3Dfm/F4aFpSQY5wSyeKIC0A7b8FyRyqNJFpGmBD7cS18k76T8kk8nfMw/+13UTFdrAz11ODdbLiuj9y/Sr2weiQSy3XMN6AQEIKSXcE92LBZWyaIGrDGV8Qkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921728; c=relaxed/simple;
	bh=TmOPvMqQ/ax1tySsuvP4m6E3HMMOyU/0AUWDPYrIEC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIDI7sBRRhr4xzpQFJtebbXaoIEsE3UVCOtfd42PzuwG6yTa5Jnq5K+iW1LkCdgk31HiaNKTBG96P96TdUMnFpWfJ0w/WSfn0zSHtD5pJzactIEL4zP4t0KhtQm5XQK9fG+6yDd5yF+Vo9Y3tZ+qHHyNxpv5BodR24uFZABTyT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QT6nko6+; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d4b3d0eb-3a04-44f6-b714-01f3f4396052@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738921722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDCRNcoqV9r1uDOiyq0aYBCLbOzT0M5FMCRa3naRIvI=;
	b=QT6nko6+clY8xVGix3NSCVWVTtUZ+49XnvGV+C+g8RKaXs05FD65u+ONEKhVE21LR4NaXZ
	DiQcvqpgI6PVX0IHtrUfVldQZ6DZ53WVrUEWGDWA0b9iMlTo8VUJiuwYmyj9TNfoHm5Hzi
	zzaBRMxIXvYJxZcH0VPWwlUgPUmMClw=
Date: Fri, 7 Feb 2025 17:48:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] bpf, libbpf: Support global percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250127162158.84906-1-leon.hwang@linux.dev>
 <20250127162158.84906-3-leon.hwang@linux.dev>
 <CAEf4Bza87kazAf2HfMZdqLCw4RfXRF+zMmfQs4cO_PYE2zKjOQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bza87kazAf2HfMZdqLCw4RfXRF+zMmfQs4cO_PYE2zKjOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/2/25 08:09, Andrii Nakryiko wrote:
> On Mon, Jan 27, 2025 at 8:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch introduces support for global percpu data in libbpf. A new
>> section named ".percpu" is added, similar to the existing ".data" section.
>> Internal maps are created for ".percpu" sections, which are then
>> initialized and populated accordingly.
>>
>> The changes include:
>>
>> * Introduction of the ".percpu" section in libbpf.
>> * Creation of internal maps for percpu data.
>> * Initialization and population of these maps.
>>
>> This enhancement allows BPF programs to efficiently manage and access
>> percpu global data, improving performance for use cases that require
>> percpu buffer.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/libbpf.c | 172 ++++++++++++++++++++++++++++++++---------
>>  1 file changed, 135 insertions(+), 37 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 194809da51725..6da6004c5c84d 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -516,6 +516,7 @@ struct bpf_struct_ops {
>>  };
>>
>>  #define DATA_SEC ".data"
>> +#define PERCPU_DATA_SEC ".percpu"
>>  #define BSS_SEC ".bss"
>>  #define RODATA_SEC ".rodata"
>>  #define KCONFIG_SEC ".kconfig"
>> @@ -530,6 +531,7 @@ enum libbpf_map_type {
>>         LIBBPF_MAP_BSS,
>>         LIBBPF_MAP_RODATA,
>>         LIBBPF_MAP_KCONFIG,
>> +       LIBBPF_MAP_PERCPU_DATA,
> 
> nit: let's keep it shorter: LIBBPF_MAP_PERCPU
> 

Ack.

>>  };
>>
>>  struct bpf_map_def {
>> @@ -562,6 +564,7 @@ struct bpf_map {
>>         __u32 btf_value_type_id;
>>         __u32 btf_vmlinux_value_type_id;
>>         enum libbpf_map_type libbpf_type;
>> +       void *data;
>>         void *mmaped;
>>         struct bpf_struct_ops *st_ops;
>>         struct bpf_map *inner_map;
>> @@ -640,6 +643,7 @@ enum sec_type {
>>         SEC_DATA,
>>         SEC_RODATA,
>>         SEC_ST_OPS,
>> +       SEC_PERCPU_DATA,
> 
> ditto, just SEC_PERCPU?
> 

Ack.

>>  };
>>
>>  struct elf_sec_desc {
>> @@ -1923,13 +1927,24 @@ static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
>>         return false;
>>  }
>>
>> +static void map_copy_data(struct bpf_map *map, const void *data)
>> +{
>> +       bool is_percpu_data = map->libbpf_type == LIBBPF_MAP_PERCPU_DATA;
>> +       size_t data_sz = map->def.value_size;
>> +
>> +       if (data)
>> +               memcpy(is_percpu_data ? map->data : map->mmaped, data, data_sz);
>> +}
>> +
>>  static int
>>  bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>>                               const char *real_name, int sec_idx, void *data, size_t data_sz)
>>  {
>> +       bool is_percpu_data = type == LIBBPF_MAP_PERCPU_DATA;
>>         struct bpf_map_def *def;
>>         struct bpf_map *map;
>>         size_t mmap_sz;
>> +       size_t elem_sz;
> 
> nit: just:
> 
> size_t mmap_sz, elem_sz;
> 
>>         int err;
>>
>>         map = bpf_object__add_map(obj);
>> @@ -1948,7 +1963,8 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>>         }
>>
>>         def = &map->def;
>> -       def->type = BPF_MAP_TYPE_ARRAY;
>> +       def->type = is_percpu_data ? BPF_MAP_TYPE_PERCPU_ARRAY
>> +                                  : BPF_MAP_TYPE_ARRAY;
> 
> nit: single line
> 
>>         def->key_size = sizeof(int);
>>         def->value_size = data_sz;
>>         def->max_entries = 1;
> 
> [...]
> 
>> +               if (map_is_mmapable(obj, map))
>> +                       def->map_flags |= BPF_F_MMAPABLE;
>> +
>> +               mmap_sz = bpf_map_mmap_sz(map);
>> +               map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
>> +                                  MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>> +               if (map->mmaped == MAP_FAILED) {
>> +                       err = -errno;
>> +                       map->mmaped = NULL;
>> +                       pr_warn("map '%s': failed to alloc content buffer: %s\n",
>> +                               map->name, errstr(err));
>> +                       goto free_name;
>> +               }
>> +
>> +               map_copy_data(map, data);
> 
> why not memcpy() here? you know it's not percpu map, so why obscuring
> that memcpy?
> 
> 
>> +       }
>>
>>         pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
>>         return 0;
> 
> [...]
> 
>> @@ -5125,23 +5180,54 @@ static int
>>  bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>>  {
>>         enum libbpf_map_type map_type = map->libbpf_type;
>> -       int err, zero = 0;
>> +       bool is_percpu_data = map_type == LIBBPF_MAP_PERCPU_DATA;
>> +       int err = 0, zero = 0;
>> +       void *data = NULL;
>> +       int num_cpus, i;
>> +       size_t data_sz;
>> +       size_t elem_sz;
>>         size_t mmap_sz;
> 
> nit: keep those size_t variables grouped: `size_t mmap_sz, data_sz, elem_sz;`
> 

Ack.

>>
>> +       data_sz = map->def.value_size;
>> +       if (is_percpu_data) {
>> +               num_cpus = libbpf_num_possible_cpus();
>> +               if (num_cpus < 0) {
>> +                       err = libbpf_err_errno(num_cpus);
> 
> why? num_cpus *IS* error code if num_cpus < 0
> 

Ack. Thanks for pointing this out.

>> +                       pr_warn("map '%s': failed to get num_cpus: %s\n",
>> +                               bpf_map__name(map), errstr(err));
> 
> this is unlikely to happen, I'd drop pr_warn()
> 

Ack.

>> +                       return err;
>> +               }
>> +
>> +               elem_sz = roundup(data_sz, 8);
>> +               data_sz = elem_sz * num_cpus;
>> +               data = malloc(data_sz);
>> +               if (!data) {
>> +                       err = -ENOMEM;
>> +                       pr_warn("map '%s': failed to malloc memory: %s\n",
>> +                               bpf_map__name(map), errstr(err));
> 
> -ENOMEM is rather self-descriptive (and generally not expected), so
> don't add pr_warn() for such cases
> 

Ack.

>> +                       return err;
>> +               }
>> +
>> +               for (i = 0; i < num_cpus; i++)
>> +                       memcpy(data + i * elem_sz, map->data, elem_sz);
>> +       } else {
>> +               data = map->mmaped;
>> +       }
>> +
> 
> [...]
> 
>>  static void bpf_map__destroy(struct bpf_map *map);
>> @@ -8120,7 +8209,9 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
>>         struct bpf_map *m;
>>
>>         bpf_object__for_each_map(m, obj) {
>> -               if (!bpf_map__is_internal(m))
>> +               if (!bpf_map__is_internal(m) ||
>> +                   /* percpu data map is internal and not-mmapable. */
>> +                   m->libbpf_type == LIBBPF_MAP_PERCPU_DATA)
> 
> original logic would work anyways, no? let's not add unnecessary
> special casing here
> 

The original logic works for it. I'll remove it.

>>                         continue;
>>                 if (!kernel_supports(obj, FEAT_ARRAY_MMAP))
>>                         m->def.map_flags &= ~BPF_F_MMAPABLE;
>> @@ -9041,6 +9132,8 @@ static void bpf_map__destroy(struct bpf_map *map)
>>         if (map->mmaped && map->mmaped != map->obj->arena_data)
>>                 munmap(map->mmaped, bpf_map_mmap_sz(map));
>>         map->mmaped = NULL;
>> +       if (map->data)
>> +               zfree(&map->data);
>>
> 
> this whole map->mmaped and map->data duality and duplication seems not
> worth it, tbh. Maybe we should keep using map->mmaped (we probably
> could name it more generically at some point, but I don't want to
> start bike shedding now) even for malloc'ed memory? After all, we
> already have ARENA as another special case? WDYT, can your changes be
> implemented by reusing map->mmaped, taking into account a type of map?
> 

It is better to reuse map->mmaped. I'll take a try.

> pw-bot: cr
> 
>>         if (map->st_ops) {
>>                 zfree(&map->st_ops->data);
>> @@ -10132,14 +10225,18 @@ int bpf_map__fd(const struct bpf_map *map)
>>
>>  static bool map_uses_real_name(const struct bpf_map *map)
>>  {
>> -       /* Since libbpf started to support custom .data.* and .rodata.* maps,
>> -        * their user-visible name differs from kernel-visible name. Users see
>> -        * such map's corresponding ELF section name as a map name.
>> -        * This check distinguishes .data/.rodata from .data.* and .rodata.*
>> -        * maps to know which name has to be returned to the user.
>> +       /* Since libbpf started to support custom .data.*, .percpu.* and
>> +        * .rodata.* maps, their user-visible name differs from kernel-visible
>> +        * name. Users see such map's corresponding ELF section name as a map
>> +        * name. This check distinguishes .data/.percpu/.rodata from .data.*,
>> +        * .percpu.* and .rodata.* maps to know which name has to be returned to
>> +        * the user.
>>          */
>>         if (map->libbpf_type == LIBBPF_MAP_DATA && strcmp(map->real_name, DATA_SEC) != 0)
>>                 return true;
>> +       if (map->libbpf_type == LIBBPF_MAP_PERCPU_DATA &&
>> +           strcmp(map->real_name, PERCPU_DATA_SEC) != 0)
>> +               return true;
> 
> nit: shorten LIBBPF_MAP_PERCPU_DATA and keep single line, please
> 

Ack.

>>         if (map->libbpf_type == LIBBPF_MAP_RODATA && strcmp(map->real_name, RODATA_SEC) != 0)
>>                 return true;
>>         return false;
>> @@ -10348,7 +10445,8 @@ int bpf_map__set_initial_value(struct bpf_map *map,
>>         if (map->obj->loaded || map->reused)
>>                 return libbpf_err(-EBUSY);
>>
>> -       if (!map->mmaped || map->libbpf_type == LIBBPF_MAP_KCONFIG)
>> +       if ((!map->mmaped && !map->data) ||
>> +           map->libbpf_type == LIBBPF_MAP_KCONFIG)
>>                 return libbpf_err(-EINVAL);
>>
>>         if (map->def.type == BPF_MAP_TYPE_ARENA)
>> @@ -10358,7 +10456,7 @@ int bpf_map__set_initial_value(struct bpf_map *map,
>>         if (size != actual_sz)
>>                 return libbpf_err(-EINVAL);
>>
>> -       memcpy(map->mmaped, data, size);
>> +       map_copy_data(map, data);
>>         return 0;
>>  }
>>
>> @@ -10370,7 +10468,7 @@ void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
>>                 return map->st_ops->data;
>>         }
>>
>> -       if (!map->mmaped)
>> +       if (!map->mmaped && !map->data)
>>                 return NULL;
>>
>>         if (map->def.type == BPF_MAP_TYPE_ARENA)
>> @@ -10378,7 +10476,7 @@ void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
>>         else
>>                 *psize = map->def.value_size;
>>
>> -       return map->mmaped;
>> +       return map->libbpf_type == LIBBPF_MAP_PERCPU_DATA ? map->data : map->mmaped;
> 
> Good chunk of changes like this wouldn't be necessary if we just reuse
> map->mmaped.
> 

Yes. you're right. It's unnecessary to change it if reuse map->mmaped.

> 
>>  }
>>
>>  bool bpf_map__is_internal(const struct bpf_map *map)
>> --
>> 2.47.1
>>


Thanks,
Leon



