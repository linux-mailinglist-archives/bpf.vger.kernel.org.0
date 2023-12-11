Return-Path: <bpf+bounces-17422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FAF80D43E
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 18:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A511F21A21
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93374E634;
	Mon, 11 Dec 2023 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nmaE1o1g"
X-Original-To: bpf@vger.kernel.org
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 09:40:32 PST
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2699110F
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:40:31 -0800 (PST)
Message-ID: <45878586-cc5f-435f-83fb-9a3c39824550@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702315909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arKj2pScXciLPB4FC62c69xlYWgQBEV3vC7GVugQsh8=;
	b=nmaE1o1gBp4Mw2z/NsShDbasXGYN6M6wY4L/GObmys5pRHebg/IJG2Od5xW415GHIRPww/
	wiFOINv/JkrGr8nesveid7Oai8N+9rE/+WyCsfWCUVejOhIk0j10GViD2SexCWcazxRuEM
	25yW8QVUh9QozJWsMOQ+fXtOA6uVaB4=
Date: Mon, 11 Dec 2023 12:31:46 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local
 storage
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>
Cc: David Marchevsky <david.marchevsky@linux.dev>,
 Dave Marchevsky <davemarchevsky@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, bpf <bpf@vger.kernel.org>
References: <20231120175925.733167-1-davemarchevsky@fb.com>
 <20231120175925.733167-2-davemarchevsky@fb.com>
 <9b037dde-e65c-4d1a-8295-68d51ac3ce25@linux.dev>
 <3dd86df3-0692-42d8-b075-f79c5dc052be@linux.dev>
 <f4d7f72d-1ba2-49dc-b4e0-03289393d436@linux.dev>
 <CAADnVQK6c8chC1E6_O8bncncBuiscdFrKk6EgPbBC_WyVoj=9w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <CAADnVQK6c8chC1E6_O8bncncBuiscdFrKk6EgPbBC_WyVoj=9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/21/23 2:49 PM, Alexei Starovoitov wrote:
> On Tue, Nov 21, 2023 at 11:27 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 11/20/23 10:11 PM, David Marchevsky wrote:
>>>
>>>
>>> On 11/20/23 7:42 PM, Martin KaFai Lau wrote:
>>>> On 11/20/23 9:59 AM, Dave Marchevsky wrote:
>>>>> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
>>>>> index 173ec7f43ed1..114973f925ea 100644
>>>>> --- a/include/linux/bpf_local_storage.h
>>>>> +++ b/include/linux/bpf_local_storage.h
>>>>> @@ -69,7 +69,17 @@ struct bpf_local_storage_data {
>>>>>         * the number of cachelines accessed during the cache hit case.
>>>>>         */
>>>>>        struct bpf_local_storage_map __rcu *smap;
>>>>> -    u8 data[] __aligned(8);
>>>>> +    /* Need to duplicate smap's map_flags as smap may be gone when
>>>>> +     * it's time to free bpf_local_storage_data
>>>>> +     */
>>>>> +    u64 smap_map_flags;
>>>>> +    /* If BPF_F_MMAPABLE, this is a void * to separately-alloc'd data
>>>>> +     * Otherwise the actual mapval data lives here
>>>>> +     */
>>>>> +    union {
>>>>> +        DECLARE_FLEX_ARRAY(u8, data) __aligned(8);
>>>>> +        void *actual_data __aligned(8);
>>>>
>>>> The pages (that can be mmap'ed later) feel like a specific kind of kptr.
>>>>
>>>> Have you thought about allowing a kptr (pointing to some pages that can be mmap'ed later) to be stored as one of the members of the map's value as a kptr. bpf_local_storage_map is one of the maps that supports kptr.
>>>>
>>>> struct normal_and_mmap_value {
>>>>      int some_int;
>>>>      int __percpu_kptr *some_cnts;
>>>>
>>>>      struct bpf_mmap_page __kptr *some_stats;
>>>> };
>>>>
>>>> struct mmap_only_value {
>>>>      struct bpf_mmap_page __kptr *some_stats;
>>>> };
>>>>
>>>> [ ... ]
>>>>
>>>
>>> This is an intriguing idea. For conciseness I'll call this specific
>>> kind of kptr 'mmapable kptrs' for the rest of this message. Below is
>>> more of a brainstorming dump than a cohesive response, separate trains
>>> of thought are separated by two newlines.
>>
>> Thanks for bearing with me while some ideas could be crazy. I am trying to see
>> how this would look like for other local storage, sk and inode. Allocating a
>> page for each sk will not be nice for server with half a million sk(s). e.g.
>> half a million sk(s) sharing a few bandwidth policies or a few tuning
>> parameters. Creating something mmap'able to the user space and also sharable
>> among many sk(s) will be useful.
>>
>>>
>>>
>>> My initial thought upon seeing struct normal_and_mmap_value was to note
>>> that we currently don't support mmaping for map_value types with _any_
>>> special fields ('special' as determined by btf_parse_fields). But IIUC
>>> you're actually talking about exposing the some_stats pointee memory via
>>> mmap, not the containing struct with kptr fields. That is, for maps that
>>> support these kptrs, mmap()ing a map with value type struct
>>> normal_and_mmap_value would return the some_stats pointer value, and
>>> likely initialize the pointer similarly to BPF_LOCAL_STORAGE_GET_F_CREATE
>>> logic in this patch. We'd only be able to support one such mmapable kptr
>>> field per mapval type, but that isn't a dealbreaker.
>>>
>>> Some maps, like task_storage, would only support mmap() on a map_value
>>> with mmapable kptr field, as mmap()ing the mapval itself doesn't make
>>> sense or is unsafe. Seems like arraymap would do the opposite, only
>>
>> Changing direction a bit since arraymap is brought up. :)
>>
>> arraymap supports BPF_F_MMAPABLE. If the local storage map's value can store an
>> arraymap as kptr, the bpf prog should be able to access it as a map. More like
>> the current map-in-map setup. The arraymap can be used as regular map in the
>> user space also (like pinning). It may need some btf plumbing to tell the value
>> type of the arrayamp to the verifier.
>>
>> The syscall bpf_map_update_elem(task_storage_map_fd, &task_pidfd, &value, flags)
>> can be used where the value->array_mmap initialized as an arraymap_fd. This will
>> limit the arraymap kptr update only from the syscall side which seems to be your
>> usecase also? Allocating the arraymap from the bpf prog side needs some thoughts
>> and need a whitelist.
>>
>> The same goes for the syscall bpf_map_lookup_elem(task_storage_map_fd,
>> &task_pidfd, &value). The kernel can return a fd in value->array_mmap. May be we
>> can create a libbpf helper to free the fd(s) resources held in the looked-up
>> value by using the value's btf.
>>
>> The bpf_local_storage_map side probably does not need to support mmap() then.
> 
> Martin,
> that's an interesting idea!
> I kinda like it and I think it's worth exploring further.
> 
> I think the main quirk of the proposed mmap-of-task-local-storage
> is using 'current' task as an implicit 'key' in task local storage map.
> It fits here, but I'm not sure it addresses sched-ext use case.
> 
> Tejun, David,
> could you please chime in ?
> Do you think mmap(..., task_local_storage_map_fd, ...)
> that returns a page that belongs to current task only is enough ?
> 
> If not we need to think through how to mmap local storage of other
> tasks. One proposal was to use pgoff to carry the key somehow
> like io-uring does, but if we want to generalize that the pgoff approach
> falls apart if we want __mmapable_kptr to work like Martin is proposing above,
> since the key will not fit in 64-bit of pgoff.
> 
> Maybe we need an office hours slot to discuss. This looks to be a big
> topic. Not sure we can converge over email.
> Just getting everyone on the same page will take a lot of email reading.

Meta BPF folks were all in one place for reasons unrelated to this
thread, and decided to have a design discussion regarding this mmapable
task_local storage implementation and other implementation ideas
discussed in this thread. I will summarize the discussion below. We
didn't arrive at a confident conclusion, though, so plenty of time for
others to chime in and for proper office hours discussion to happen if
necessary. Below, anything attributed to a specific person is
paraphrased from my notes, there will certainly be errors /
misrememberings.



mmapable task_local storage design discussion 11/29

We first summarized approaches that were discussed in this thread:

1) Current implementation in this series

2) pseudo-map_in_map, kptr arraymap type:

  struct mmapable_data_map {
          __uint(type, BPF_MAP_TYPE_ARRAY);
          __uint(map_flags, BPF_F_MMAPABLE);
          __uint(max_entries, 1);
          __type(key, __u32);
          __type(value, __u64);
  };

  struct my_mapval {
    int whatever;
    struct bpf_arraymap __kptr __arraymap_type(mmapable_data_map) *m;
    /* Need special logic to support getting / updating above field from userspace (as fd) */
  };

3) "mmapable page" kptr type, or "mmapable kptr" tag

  struct my_mapval {
    int whatever;
    struct bpf_mmapable_page *m;
  };
  
  struct my_mapval2 { /* Separate approach than my_mapval above */
    struct bpf_spin_lock l;
    int some_int;
    struct my_type __mmapable_kptr *some_stats;
  };

Points of consideration regardless of implementation approach:
  * mmap() syscall's return address must be page-aligned. If we want to
    reduce / eliminate wasted memory by supporting packing of multiple
    mapvals onto single page, need to be able to return non-page-aligned
    addr. Using a BPF syscall subcommand in lieu of or in addition to
    mmap() syscall would be a way to support this.
    * Dave wants to avoid implementing packing at all, but having a
      reasonable path forward would be nice in case actual usecase
      arises.
    * Andrii suggested a new actual mmap syscall supporting passing of
      custom params, useful for any subsystem using mmap in
      nontraditional ways. This was initially a response to "use offset
      to pass task id" discussion re: selecting non-current task.

   * How orthogonal is Martin's "kptr to arraymap" suggestion from the
     general mmapable local_storage goal? Is there a world where we
     choose a different approach for this work, and then to "kptr to
     arraymap" independently later?

The above was mostly summary of existing discussion in this thread. Rest
of discussion flowed from there.

Q&A:

- Do we need to be able to query other tasks' mapvals? (for David Vernet
  / Tejun Heo)

TJ had a usecase where this might've been necessary, but rewrote.
David: Being able to do this in general, aside from TJ's specific case,
would be useful. David provided an example from ghOSt project - central
scheduling. Another example: Folly runtime framework, farms out work to
worker threads, might want to tag them.

- Which usecases actually care about avoiding syscall overhead?

Alexei: Most services that would want to use this functionality to tag
their tasks don't need it, as they just set the value once.
Dave: Some tracing usecases (e.g. strobemeta) need it.

- Do we want to use mmap() in current-task-only limited way, or do BPF
  subcommand or something more exotic?

TJ: What if bpf subcommand returns FD that can be mmap'd. fd identifies
which task_local storage elem is mmap'd. Subcommand:
bpf_map_lookup_elem_fd(map *, u64 elem_id).
Alexei: Such a thing should return fd to arbitrary mapval, and should
support other common ops (open, close, etc.).
David: What's the problem w/ having fd that only supports mmap for now?
TJ: 'Dangling' fds exist in some usecases already

Discussion around the bpf_map_lookup_elem_fd idea continued for quite a
while. Folks liked that it avoids the "can only have one mmapable field"
issue from proposal (3) above, without making any implicit assumptions.

Alexei: Can we instead have pointer to userspace blob - similar to rseq
- to avoid wasting most of page?

TJ: My instinct is to stick to something more generic, would rather pay
4k.

Discussion around userspace pointer continued for a while as well,
ending in the conclusion that we should take a look at using
get_user_pages, perhaps wrapping such functionality in a 'guppable' kptr
type. Folks liked the 'guppable' idea as it sort-of avoids the wasted
memory issue, pushing the details to userspace, and punts on working out
a path forward for mmap interface, which other implementation ideas
require.

Action items based on convo, priority order:

  - Think more about / prototype 'guppable' kptr idea
  - If the above has issues, try bpf_map_lookup_elem_fd
  - If both above have issues, consider earlier approaches

I will start tackling these soon.

