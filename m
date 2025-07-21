Return-Path: <bpf+bounces-63930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A4CB0C93A
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 19:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95042545D37
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 17:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD032E090A;
	Mon, 21 Jul 2025 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sgrZtzr8"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AD1E32D3
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117734; cv=none; b=VE8Ot5QqX43hhbKF7Lo/PUTPd3at2yTbHRXIfnQP5fMrfN2/ex3gA8pwcJmGH4+5U8qEO/gRGC/IfIGPh6PDIcIAxNu0WXTiZ5Iw8HpUnVepkr5R/GBQX3Dgt0Q81O61J/IMtSbBQ5r2Xaxlp69pN8k/VSXjHZm78KJITUYCK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117734; c=relaxed/simple;
	bh=Ko/xc3D+TG58NvXnCfe+PmXGQG9nTxC6XR9rR8R1ju8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KE+iflonv2sm1kJs1qriNeBR3D21cZNMw/LgYFCFs0kaCjjMLXshaA3Tk6tzRAsMNW15ogwCTDNBGG61jeVWFo7EWMBz805pY+CRYADLecK6XZotsfqRSf/aHQjnU40BMr8VBuiElhq8eolCecBmGVQUgA/tMcPc47yxoCk/pVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sgrZtzr8; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d8d4cd89-2953-45d1-9f81-ab633aa3e4cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753117727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOdW0w9oBvXZnQYQ+03hKvKX3gIrn5dVgjkzXyJwqUY=;
	b=sgrZtzr8hygPhDeGsGW5hPMfooyfAiYg/7KoTAU0hHxlpuj5KfFHAc0XAwdU3fx6zgFptF
	qvSCGYs1wan+tg41oFNI4ood+Pmg3/IhSObP5QIkfhfvZZOSCAxUGNocU0jCv5JSFP7G3T
	IWQG8Si0MPd1EsO4STbmdkdI4BHJQKI=
Date: Tue, 22 Jul 2025 01:08:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array map
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, kernel-patches-bot@fb.com
References: <20250717193756.37153-1-leon.hwang@linux.dev>
 <20250717193756.37153-2-leon.hwang@linux.dev>
 <CAEf4BzY74tbyzD-4iF1Em9EmKX=2fAN4dTp_k8o+MuN2T3CVqQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzY74tbyzD-4iF1Em9EmKX=2fAN4dTp_k8o+MuN2T3CVqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/18 23:52, Andrii Nakryiko wrote:
> On Thu, Jul 17, 2025 at 12:38 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch introduces support for the BPF_F_CPU flag in percpu_array maps
>> to allow updating or looking up values for specified CPUs or for all CPUs
>> with a single value.
>>
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
>>  kernel/bpf/arraymap.c          | 54 ++++++++++++++++++++++++++--------
>>  kernel/bpf/syscall.c           | 52 ++++++++++++++++++++------------
>>  tools/include/uapi/linux/bpf.h |  7 +++++
>>  5 files changed, 90 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index f9cd2164ed23..faee5710e913 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2671,7 +2671,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
>>                                    struct bpf_func_state *callee);
>>
>>  int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
>> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
>> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
>> +                         u64 flags);
>>  int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
>>                            u64 flags);
>>  int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 233de8677382..4cad3de6899d 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1372,6 +1372,12 @@ enum {
>>         BPF_NOEXIST     = 1, /* create new element if it didn't exist */
>>         BPF_EXIST       = 2, /* update existing element */
>>         BPF_F_LOCK      = 4, /* spin_lock-ed map_lookup/map_update */
>> +       BPF_F_CPU       = 8, /* map_update for percpu_array */
>> +};
>> +
>> +enum {
>> +       /* indicate updating value across all CPUs for percpu maps. */
>> +       BPF_ALL_CPUS    = (__u32)~0,
>>  };
>>
>>  /* flags for BPF_MAP_CREATE command */
>> @@ -1549,6 +1555,7 @@ union bpf_attr {
>>                 __u32           map_fd;
>>                 __u64           elem_flags;
>>                 __u64           flags;
>> +               __u32           cpu;
>>         } batch;
> 
> So you use flags to pass cpu for singular lookup/delete operations,
> but separate cpu field for batch. We need to be consistent here. I
> think I initially suggested a separate cpu field, but given how much
> churn it's causing in API and usage, I guess I'm leaning towards just
> passing it through flags.
> 
> But if someone else has strong preferences, I can be convinced otherwise.
> 

Sure, they should be consistent.

Passing the CPU info through flags was actually my original idea, but I
wasn’t sure how to convince you initially.

Let’s go ahead and pass the CPU through flags to minimize churn.

> Either way, it has to be consistent between batched and non-batched API.
> 
> Other than that and minor formatting needs below, LGTM.
> 
> pw-bot: cr
> 
>>
>>         struct { /* anonymous struct used by BPF_PROG_LOAD command */
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 3d080916faf9..d333663cbe71 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -295,17 +295,24 @@ static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, void *key,
>>         return per_cpu_ptr(array->pptrs[index & array->index_mask], cpu);
>>  }
>>
>> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
>> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags)
>>  {
>>         struct bpf_array *array = container_of(map, struct bpf_array, map);
>>         u32 index = *(u32 *)key;
>>         void __percpu *pptr;
>> -       int cpu, off = 0;
>> -       u32 size;
>> +       u32 size, cpu;
>> +       int off = 0;
>>
>>         if (unlikely(index >= array->map.max_entries))
>>                 return -ENOENT;
>>
>> +       cpu = (u32)(flags >> 32);
>> +       flags &= (u32)~0;
>> +       if (unlikely(flags > BPF_F_CPU))
>> +               return -EINVAL;
>> +       if (unlikely((flags & BPF_F_CPU) && cpu >= num_possible_cpus()))
>> +               return -E2BIG;
> 
> nit: I'd probably do -ERANGE for this one
> 

Ack.

>> +
>>         /* per_cpu areas are zero-filled and bpf programs can only
>>          * access 'value_size' of them, so copying rounded areas
>>          * will not leak any kernel data
> 
> [...]
> 
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
> 
> nit: keep on the single line
> 

Ack.

Btw, how many chars of one line do we allow? 100 chars?

>> +               return -EINVAL;
>> +
>> +       value_size = bpf_map_value_size(map, elem_flags);
>> +       elem_flags |= ((u64)cpu) << 32;
>>
>>         max_count = attr->batch.count;
>>         if (!max_count)
> 
> [...]
> 
>> -       if ((attr->batch.elem_flags & BPF_F_LOCK) &&
>> +       if ((elem_flags & BPF_F_LOCK) &&
>>             !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>>                 return -EINVAL;
>>
>> -       value_size = bpf_map_value_size(map);
>> +       if ((elem_flags & BPF_F_CPU) &&
>> +               map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
>> +               return -EINVAL;
> 
> same, formatting is off, but best to keep it single line
> 

Ack.

[...]

Thanks,
Leon



