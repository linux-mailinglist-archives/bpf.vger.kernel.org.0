Return-Path: <bpf+bounces-15584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B033D7F36CC
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D7128239B
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26575B1F3;
	Tue, 21 Nov 2023 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MPTW3RmS"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531A912A
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 11:27:38 -0800 (PST)
Message-ID: <f4d7f72d-1ba2-49dc-b4e0-03289393d436@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700594855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXqyza/cGSamA5v1IajCl/ltMBxck2L1S3FDcsNLS/0=;
	b=MPTW3RmStvqI+4+OePNPic5Px7W1w3Qs+BhYuufv3RHDnhzEFhE02j+OlCNRdXrxAqavS5
	cb2Pg1b6JI6IKcVvo1iOw6Bvc1PcmH2LvfVmDNPH3nWu4dO8b1WC7oO0n8bF49/MYu+npw
	PxZGgnXZvc1csVh7xMH1Py4XJDR1XnU=
Date: Tue, 21 Nov 2023 11:27:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local
 storage
Content-Language: en-US
To: David Marchevsky <david.marchevsky@linux.dev>,
 Dave Marchevsky <davemarchevsky@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, bpf@vger.kernel.org
References: <20231120175925.733167-1-davemarchevsky@fb.com>
 <20231120175925.733167-2-davemarchevsky@fb.com>
 <9b037dde-e65c-4d1a-8295-68d51ac3ce25@linux.dev>
 <3dd86df3-0692-42d8-b075-f79c5dc052be@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <3dd86df3-0692-42d8-b075-f79c5dc052be@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/20/23 10:11 PM, David Marchevsky wrote:
> 
> 
> On 11/20/23 7:42 PM, Martin KaFai Lau wrote:
>> On 11/20/23 9:59 AM, Dave Marchevsky wrote:
>>> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
>>> index 173ec7f43ed1..114973f925ea 100644
>>> --- a/include/linux/bpf_local_storage.h
>>> +++ b/include/linux/bpf_local_storage.h
>>> @@ -69,7 +69,17 @@ struct bpf_local_storage_data {
>>>         * the number of cachelines accessed during the cache hit case.
>>>         */
>>>        struct bpf_local_storage_map __rcu *smap;
>>> -    u8 data[] __aligned(8);
>>> +    /* Need to duplicate smap's map_flags as smap may be gone when
>>> +     * it's time to free bpf_local_storage_data
>>> +     */
>>> +    u64 smap_map_flags;
>>> +    /* If BPF_F_MMAPABLE, this is a void * to separately-alloc'd data
>>> +     * Otherwise the actual mapval data lives here
>>> +     */
>>> +    union {
>>> +        DECLARE_FLEX_ARRAY(u8, data) __aligned(8);
>>> +        void *actual_data __aligned(8);
>>
>> The pages (that can be mmap'ed later) feel like a specific kind of kptr.
>>
>> Have you thought about allowing a kptr (pointing to some pages that can be mmap'ed later) to be stored as one of the members of the map's value as a kptr. bpf_local_storage_map is one of the maps that supports kptr.
>>
>> struct normal_and_mmap_value {
>>      int some_int;
>>      int __percpu_kptr *some_cnts;
>>
>>      struct bpf_mmap_page __kptr *some_stats;
>> };
>>
>> struct mmap_only_value {
>>      struct bpf_mmap_page __kptr *some_stats;
>> };
>>
>> [ ... ]
>>
> 
> This is an intriguing idea. For conciseness I'll call this specific
> kind of kptr 'mmapable kptrs' for the rest of this message. Below is
> more of a brainstorming dump than a cohesive response, separate trains
> of thought are separated by two newlines.

Thanks for bearing with me while some ideas could be crazy. I am trying to see 
how this would look like for other local storage, sk and inode. Allocating a 
page for each sk will not be nice for server with half a million sk(s). e.g. 
half a million sk(s) sharing a few bandwidth policies or a few tuning 
parameters. Creating something mmap'able to the user space and also sharable 
among many sk(s) will be useful.

> 
> 
> My initial thought upon seeing struct normal_and_mmap_value was to note
> that we currently don't support mmaping for map_value types with _any_
> special fields ('special' as determined by btf_parse_fields). But IIUC
> you're actually talking about exposing the some_stats pointee memory via
> mmap, not the containing struct with kptr fields. That is, for maps that
> support these kptrs, mmap()ing a map with value type struct
> normal_and_mmap_value would return the some_stats pointer value, and
> likely initialize the pointer similarly to BPF_LOCAL_STORAGE_GET_F_CREATE
> logic in this patch. We'd only be able to support one such mmapable kptr
> field per mapval type, but that isn't a dealbreaker.
> 
> Some maps, like task_storage, would only support mmap() on a map_value
> with mmapable kptr field, as mmap()ing the mapval itself doesn't make
> sense or is unsafe. Seems like arraymap would do the opposite, only

Changing direction a bit since arraymap is brought up. :)

arraymap supports BPF_F_MMAPABLE. If the local storage map's value can store an 
arraymap as kptr, the bpf prog should be able to access it as a map. More like 
the current map-in-map setup. The arraymap can be used as regular map in the 
user space also (like pinning). It may need some btf plumbing to tell the value 
type of the arrayamp to the verifier.

The syscall bpf_map_update_elem(task_storage_map_fd, &task_pidfd, &value, flags) 
can be used where the value->array_mmap initialized as an arraymap_fd. This will 
limit the arraymap kptr update only from the syscall side which seems to be your 
usecase also? Allocating the arraymap from the bpf prog side needs some thoughts 
and need a whitelist.

The same goes for the syscall bpf_map_lookup_elem(task_storage_map_fd, 
&task_pidfd, &value). The kernel can return a fd in value->array_mmap. May be we 
can create a libbpf helper to free the fd(s) resources held in the looked-up 
value by using the value's btf.

The bpf_local_storage_map side probably does not need to support mmap() then.


> supporting mmap()ing the mapval itself. I'm curious if any map could
> feasibly support both, and if so, might have to do logic like:
> 
>    if (map_val has mmapable kptr)
>       mmap the pointee of mmapable kptr
>    else
>       mmap the map_val itself
> 
> Which is maybe too confusing of a detail to expose to BPF program
> writers. Maybe a little too presumptuous and brainstorm-ey given the
> limited number of mmap()able maps currently, but making this a kptr type
> means maps should either ignore/fail if they don't support it, or have
> consistent semantics amongst maps that do support it.
> 
> 
> Instead of  struct bpf_mmap_page __kptr *some_stats;  I'd prefer
> something like
> 
> struct my_type { long count; long another_count; };
> 
> struct mmap_only_value {
>    struct my_type __mmapable_kptr *some_stats;
> };
> 
> This way the type of mmap()able field is known to BPF programs that
> interact with it. This is all assuming that struct bpf_mmap_page is an
> opaque page-sized blob of bytes.
> 
> 
> We could then support structs like
> 
> struct mmap_value_and_lock {
>    struct bpf_spin_lock l;
>    int some_int;
>    struct my_type __mmapable_kptr *some_stats;
> };
> 
> and have bpf_map_update_elem handler use the spin_lock instead of
> map-internal lock where appropriate. But no way to ensure userspace task
> using the mmap()ed region uses the spin_lock.
> 
>>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>>> index 146824cc9689..9b3becbcc1a3 100644
>>> --- a/kernel/bpf/bpf_local_storage.c
>>> +++ b/kernel/bpf/bpf_local_storage.c
>>> @@ -15,7 +15,8 @@
>>>    #include <linux/rcupdate_trace.h>
>>>    #include <linux/rcupdate_wait.h>
>>>    -#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
>>> +#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK \
>>> +    (BPF_F_NO_PREALLOC | BPF_F_CLONE | BPF_F_MMAPABLE)
>>>      static struct bpf_local_storage_map_bucket *
>>>    select_bucket(struct bpf_local_storage_map *smap,
>>> @@ -24,6 +25,51 @@ select_bucket(struct bpf_local_storage_map *smap,
>>>        return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
>>>    }
>>>    +struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map);
>>> +
>>> +void *alloc_mmapable_selem_value(struct bpf_local_storage_map *smap)
>>> +{
>>> +    struct mem_cgroup *memcg, *old_memcg;
>>> +    void *ptr;
>>> +
>>> +    memcg = bpf_map_get_memcg(&smap->map);
>>> +    old_memcg = set_active_memcg(memcg);
>>> +    ptr = bpf_map_area_mmapable_alloc(PAGE_ALIGN(smap->map.value_size),
>>> +                      NUMA_NO_NODE);
>>> +    set_active_memcg(old_memcg);
>>> +    mem_cgroup_put(memcg);
>>> +
>>> +    return ptr;
>>> +}
>>
>> [ ... ]
>>
>>> @@ -76,10 +122,19 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>>>            void *value, bool charge_mem, gfp_t gfp_flags)
>>>    {
>>>        struct bpf_local_storage_elem *selem;
>>> +    void *mmapable_value = NULL;
>>> +    u32 selem_mem;
>>>    -    if (charge_mem && mem_charge(smap, owner, smap->elem_size))
>>> +    selem_mem = selem_bytes_used(smap);
>>> +    if (charge_mem && mem_charge(smap, owner, selem_mem))
>>>            return NULL;
>>>    +    if (smap->map.map_flags & BPF_F_MMAPABLE) {
>>> +        mmapable_value = alloc_mmapable_selem_value(smap);
>>
>> This probably is not always safe for bpf prog to do. Leaving the gfp_flags was not used aside, the bpf local storage is moving to the bpf's memalloc because of https://lore.kernel.org/bpf/20221118190109.1512674-1-namhyung@kernel.org/
>>
> 
> Minor point: alloc_mmapable_selem_value's bpf_map_area_mmapable_alloc
> call will always call vmalloc under the hood. vmalloc has locks as well,
> so your point stands.
> 
> I think I see how this ties into your 'specific kptr type' proposal
> above. Let me know if this sounds right: if there was a bpf_mem_alloc
> type focused on providing vmalloc'd mmap()able memory, we could use it
> here instead of raw vmalloc and avoid the lock recursion problem linked
> above. Such an allocator could be used in something like bpf_obj_new to
> create the __mmapable_kptr - either from BPF prog or mmap path before
> remap_vmalloc_range.
> 
> re: gfp_flags, looks like verifier is setting this param to either
> GFP_ATOMIC or GFP_KERNEL. Looks like we should not allow GFP_KERNEL
> allocs here?

Going back to this patch, not sure what does it take to make bpf_mem_alloc() 
mmap()able. May be we can limit the blast radius for now, like limit this alloc 
to the user space mmap() call for now. Does it fit your use case? A whitelist 
for bpf prog could also be created later if needed.

> 
>>> +        if (!mmapable_value)
>>> +            goto err_out;
>>> +    }
>>> +
>>


