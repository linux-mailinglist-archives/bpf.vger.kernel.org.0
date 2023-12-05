Return-Path: <bpf+bounces-16703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC7804877
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 05:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8AB01C20DA9
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 04:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE91CA57;
	Tue,  5 Dec 2023 04:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QKq9xSec"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3729C
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 20:15:46 -0800 (PST)
Message-ID: <513bafac-03fa-4c2f-ba7f-67de96f79a10@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701749744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyRjn2Gji22WYd4PCXjxR32nNU0sr98QJFMVEQeXFZU=;
	b=QKq9xSecQI2y/B0C634Hfr1aD8KJ++F4m8vU98T8XMDJq4rImwZvQNY3UBM5luwqRFC8Nt
	zsI5wMEj9BJPxMqBQH1YY3QEvjTPxhCqriAwhW7JESRhWAb8rLTV/Lgwy1nCq4jOM7oBhE
	78uF3SmIBlqtKbX+Oxvm8CXLlFFyEOc=
Date: Mon, 4 Dec 2023 20:15:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix a race condition between btf_put() and
 map_free()
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231204173946.3066377-1-yonghong.song@linux.dev>
 <CAEf4BzbPtSZxJ16E+gQnw7sgfqwJVYsnkUZaxdk=c+65KWgnTg@mail.gmail.com>
 <81d00866-7824-18e5-af71-e0a15a03e84f@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <81d00866-7824-18e5-af71-e0a15a03e84f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/4/23 8:31 PM, Hou Tao wrote:
> Hi,
>
> On 12/5/2023 8:42 AM, Andrii Nakryiko wrote:
>> On Mon, Dec 4, 2023 at 9:40 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> When running `./test_progs -j` in my local vm with latest kernel,
>>> I once hit a kasan error like below:
> SNIP
>>>
>>> So the problem is at rec->refcount_off in the above.
>>>
>>> I did some source code analysis and find the reason.
>>>                                    CPU A                        CPU B
>>>    bpf_map_put:
>>>      ...
>>>      btf_put with rcu callback
>>>      ...
>>>      bpf_map_free_deferred
>>>        with system_unbound_wq
>>>      ...                          ...                           ...
>>>      ...                          btf_free_rcu:                 ...
>>>      ...                          ...                           bpf_map_free_deferred:
>>>      ...                          ...
>>>      ...         --------->       btf_struct_metas_free()
>>>      ...         | race condition ...
>>>      ...         --------->                                     map->ops->map_free()
>>>      ...
>>>      ...                          btf->struct_meta_tab = NULL
>>>
>>> In the above, map_free() corresponds to array_map_free() and eventually
>>> calling bpf_rb_root_free() which calls:
>>>    ...
>>>    __bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
>>>    ...
>>>
>>> Here, 'value_rec' is assigned in btf_check_and_fixup_fields() with following code:
>>>
>>>    meta = btf_find_struct_meta(btf, btf_id);
>>>    if (!meta)
>>>      return -EFAULT;
>>>    rec->fields[i].graph_root.value_rec = meta->record;
>>>
>>> So basically, 'value_rec' is a pointer to the record in struct_metas_tab.
>>> And it is possible that that particular record has been freed by
>>> btf_struct_metas_free() and hence we have a kasan error here.
>>>
>>> Actually it is very hard to reproduce the failure with current bpf/bpf-next
>>> code, I only got the above error once. To increase reproducibility, I added
>>> a delay in bpf_map_free_deferred() to delay map->ops->map_free(), which
>>> significantly increased reproducibility.
> Also found the problem when developing the "fix the release of inner
> map" patch-set. I have written a selftest which could reliably reproduce
> the problem by using map-in-map + bpf_list_head. The reason of using
> map-in-map is to delay the release of inner map by using call_rcu() as
> well, so the free of bpf_map happens after the release of btf. Will post
> it later.
>>>    diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>    index 5e43ddd1b83f..aae5b5213e93 100644
>>>    --- a/kernel/bpf/syscall.c
>>>    +++ b/kernel/bpf/syscall.c
>>>    @@ -695,6 +695,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
>>>          struct bpf_map *map = container_of(work, struct bpf_map, work);
>>>          struct btf_record *rec = map->record;
>>>
>>>    +     mdelay(100);
>>>          security_bpf_map_free(map);
>>>          bpf_map_release_memcg(map);
>>>          /* implementation dependent freeing */
>>>
>>> To fix the problem, I moved btf_put() after map->ops->map_free() to ensure
>>> struct_metas available during map_free(). Rerun './test_progs -j' with the
>>> above mdelay() hack for a couple of times and didn't observe the error.
>>>
>>> Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   kernel/bpf/syscall.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 0ed286b8a0f0..9c6c3738adfe 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -694,11 +694,16 @@ static void bpf_map_free_deferred(struct work_struct *work)
>>>   {
>>>          struct bpf_map *map = container_of(work, struct bpf_map, work);
>>>          struct btf_record *rec = map->record;
>>> +       struct btf *btf = map->btf;
>>>
>>>          security_bpf_map_free(map);
>>>          bpf_map_release_memcg(map);
>>>          /* implementation dependent freeing */
>>>          map->ops->map_free(map);
>>> +       /* Delay freeing of btf for maps, as map_free callback may need
>>> +        * struct_meta info which will be freed with btf_put().
>>> +        */
>>> +       btf_put(btf);
>> The change makes sense to me, but logically I'd put it after
>> btf_record_free(rec), just in case if some of btf records ever refer
>> back to map's BTF or something (and just in general to keep it the
>> very last thing that's happening).
>>
>>
>> But it also seems like CI is not happy ([0]), please take a look, thanks!
>>
>>    [0] https://github.com/kernel-patches/bpf/actions/runs/7090474333/job/19297672532
> The patch delays the release of BTF id of bpf map, so test_btf_id
> failed. Can we fix the problem by optionally pinning the btf in
> btf_field_graph_root just like btf_field_kptr, so the map BTF will still
> be alive before the invocation of btf_record_free() ? We need to do the
> pinning optionally, because btf_record may be contained in btf directly
> (namely btf->struct_meta_tab) and is freed through btf_free().

Thanks for suggestion, I guess you want two cases:
   - if map->record won't access any btf data (e.g., btf->struct_meta_tab),
     we should keep current btf_put() workflow,
   - if map->record accesses some btf data, we should call btf_put()
     immediately before or after btf_record_free().

This could be done but we need to be careful to find all cases
btf data might be accessed in map->record. The current approach
is simpler. I will post v2 with the change Andrii suggested and
fixed the failed test.

If people really want to fine tune this like the above two cases, I can
investigate too.

>>
>>>          /* Delay freeing of btf_record for maps, as map_free
>>>           * callback usually needs access to them. It is better to do it here
>>>           * than require each callback to do the free itself manually.
>>> @@ -727,7 +732,6 @@ void bpf_map_put(struct bpf_map *map)
>>>          if (atomic64_dec_and_test(&map->refcnt)) {
>>>                  /* bpf_map_free_id() must be called first */
>>>                  bpf_map_free_id(map);
>>> -               btf_put(map->btf);
>>>                  INIT_WORK(&map->work, bpf_map_free_deferred);
>>>                  /* Avoid spawning kworkers, since they all might contend
>>>                   * for the same mutex like slab_mutex.
>>> --
>>> 2.34.1
>>>
>> .

