Return-Path: <bpf+bounces-15507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F385B7F25A5
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 07:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53C5B21DAB
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 06:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146291C6AA;
	Tue, 21 Nov 2023 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u2RBN9ak"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D7299
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 22:12:10 -0800 (PST)
Message-ID: <3dd86df3-0692-42d8-b075-f79c5dc052be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700547123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2T0AsbhpxYvyeFHaUir4AR6gaRxoTMK4aAYLu4cWJQs=;
	b=u2RBN9akbmeCKyV0seiEad5v5xhxiSIUH3h/3UPeEJBJvzP8tbFW+ZapiEtmPitCTCw+eC
	/hmLyVWEy2KIAkCiopzJLy3uKU/4Y73ceNItvNZcRG2NUakm59pxUILmHq49svvRXQKbe/
	TvtRh4Tyehb3DNdsPvOoyohAF+C/Md8=
Date: Tue, 21 Nov 2023 01:11:58 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local
 storage
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Dave Marchevsky <davemarchevsky@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, bpf@vger.kernel.org
References: <20231120175925.733167-1-davemarchevsky@fb.com>
 <20231120175925.733167-2-davemarchevsky@fb.com>
 <9b037dde-e65c-4d1a-8295-68d51ac3ce25@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <9b037dde-e65c-4d1a-8295-68d51ac3ce25@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/20/23 7:42 PM, Martin KaFai Lau wrote:
> On 11/20/23 9:59 AM, Dave Marchevsky wrote:
>> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
>> index 173ec7f43ed1..114973f925ea 100644
>> --- a/include/linux/bpf_local_storage.h
>> +++ b/include/linux/bpf_local_storage.h
>> @@ -69,7 +69,17 @@ struct bpf_local_storage_data {
>>        * the number of cachelines accessed during the cache hit case.
>>        */
>>       struct bpf_local_storage_map __rcu *smap;
>> -    u8 data[] __aligned(8);
>> +    /* Need to duplicate smap's map_flags as smap may be gone when
>> +     * it's time to free bpf_local_storage_data
>> +     */
>> +    u64 smap_map_flags;
>> +    /* If BPF_F_MMAPABLE, this is a void * to separately-alloc'd data
>> +     * Otherwise the actual mapval data lives here
>> +     */
>> +    union {
>> +        DECLARE_FLEX_ARRAY(u8, data) __aligned(8);
>> +        void *actual_data __aligned(8);
> 
> The pages (that can be mmap'ed later) feel like a specific kind of kptr.
> 
> Have you thought about allowing a kptr (pointing to some pages that can be mmap'ed later) to be stored as one of the members of the map's value as a kptr. bpf_local_storage_map is one of the maps that supports kptr.
> 
> struct normal_and_mmap_value {
>     int some_int;
>     int __percpu_kptr *some_cnts;
> 
>     struct bpf_mmap_page __kptr *some_stats;
> };
> 
> struct mmap_only_value {
>     struct bpf_mmap_page __kptr *some_stats;
> };
> 
> [ ... ]
> 

This is an intriguing idea. For conciseness I'll call this specific
kind of kptr 'mmapable kptrs' for the rest of this message. Below is
more of a brainstorming dump than a cohesive response, separate trains
of thought are separated by two newlines.


My initial thought upon seeing struct normal_and_mmap_value was to note
that we currently don't support mmaping for map_value types with _any_
special fields ('special' as determined by btf_parse_fields). But IIUC
you're actually talking about exposing the some_stats pointee memory via
mmap, not the containing struct with kptr fields. That is, for maps that
support these kptrs, mmap()ing a map with value type struct
normal_and_mmap_value would return the some_stats pointer value, and
likely initialize the pointer similarly to BPF_LOCAL_STORAGE_GET_F_CREATE
logic in this patch. We'd only be able to support one such mmapable kptr
field per mapval type, but that isn't a dealbreaker.

Some maps, like task_storage, would only support mmap() on a map_value
with mmapable kptr field, as mmap()ing the mapval itself doesn't make
sense or is unsafe. Seems like arraymap would do the opposite, only
supporting mmap()ing the mapval itself. I'm curious if any map could
feasibly support both, and if so, might have to do logic like:

  if (map_val has mmapable kptr)
     mmap the pointee of mmapable kptr
  else
     mmap the map_val itself

Which is maybe too confusing of a detail to expose to BPF program
writers. Maybe a little too presumptuous and brainstorm-ey given the
limited number of mmap()able maps currently, but making this a kptr type
means maps should either ignore/fail if they don't support it, or have
consistent semantics amongst maps that do support it.


Instead of  struct bpf_mmap_page __kptr *some_stats;  I'd prefer
something like

struct my_type { long count; long another_count; };

struct mmap_only_value {
  struct my_type __mmapable_kptr *some_stats;
};

This way the type of mmap()able field is known to BPF programs that
interact with it. This is all assuming that struct bpf_mmap_page is an
opaque page-sized blob of bytes.


We could then support structs like

struct mmap_value_and_lock {
  struct bpf_spin_lock l;
  int some_int;
  struct my_type __mmapable_kptr *some_stats;
};

and have bpf_map_update_elem handler use the spin_lock instead of
map-internal lock where appropriate. But no way to ensure userspace task
using the mmap()ed region uses the spin_lock.

>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>> index 146824cc9689..9b3becbcc1a3 100644
>> --- a/kernel/bpf/bpf_local_storage.c
>> +++ b/kernel/bpf/bpf_local_storage.c
>> @@ -15,7 +15,8 @@
>>   #include <linux/rcupdate_trace.h>
>>   #include <linux/rcupdate_wait.h>
>>   -#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
>> +#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK \
>> +    (BPF_F_NO_PREALLOC | BPF_F_CLONE | BPF_F_MMAPABLE)
>>     static struct bpf_local_storage_map_bucket *
>>   select_bucket(struct bpf_local_storage_map *smap,
>> @@ -24,6 +25,51 @@ select_bucket(struct bpf_local_storage_map *smap,
>>       return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
>>   }
>>   +struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map);
>> +
>> +void *alloc_mmapable_selem_value(struct bpf_local_storage_map *smap)
>> +{
>> +    struct mem_cgroup *memcg, *old_memcg;
>> +    void *ptr;
>> +
>> +    memcg = bpf_map_get_memcg(&smap->map);
>> +    old_memcg = set_active_memcg(memcg);
>> +    ptr = bpf_map_area_mmapable_alloc(PAGE_ALIGN(smap->map.value_size),
>> +                      NUMA_NO_NODE);
>> +    set_active_memcg(old_memcg);
>> +    mem_cgroup_put(memcg);
>> +
>> +    return ptr;
>> +}
> 
> [ ... ]
> 
>> @@ -76,10 +122,19 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>>           void *value, bool charge_mem, gfp_t gfp_flags)
>>   {
>>       struct bpf_local_storage_elem *selem;
>> +    void *mmapable_value = NULL;
>> +    u32 selem_mem;
>>   -    if (charge_mem && mem_charge(smap, owner, smap->elem_size))
>> +    selem_mem = selem_bytes_used(smap);
>> +    if (charge_mem && mem_charge(smap, owner, selem_mem))
>>           return NULL;
>>   +    if (smap->map.map_flags & BPF_F_MMAPABLE) {
>> +        mmapable_value = alloc_mmapable_selem_value(smap);
> 
> This probably is not always safe for bpf prog to do. Leaving the gfp_flags was not used aside, the bpf local storage is moving to the bpf's memalloc because of https://lore.kernel.org/bpf/20221118190109.1512674-1-namhyung@kernel.org/
> 

Minor point: alloc_mmapable_selem_value's bpf_map_area_mmapable_alloc
call will always call vmalloc under the hood. vmalloc has locks as well,
so your point stands.

I think I see how this ties into your 'specific kptr type' proposal
above. Let me know if this sounds right: if there was a bpf_mem_alloc
type focused on providing vmalloc'd mmap()able memory, we could use it
here instead of raw vmalloc and avoid the lock recursion problem linked
above. Such an allocator could be used in something like bpf_obj_new to
create the __mmapable_kptr - either from BPF prog or mmap path before
remap_vmalloc_range.

re: gfp_flags, looks like verifier is setting this param to either
GFP_ATOMIC or GFP_KERNEL. Looks like we should not allow GFP_KERNEL
allocs here?

>> +        if (!mmapable_value)
>> +            goto err_out;
>> +    }
>> +
> 

