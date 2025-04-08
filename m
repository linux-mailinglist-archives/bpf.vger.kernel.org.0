Return-Path: <bpf+bounces-55435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A374A7F2C5
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 04:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D9D3AEC78
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 02:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D0122DF86;
	Tue,  8 Apr 2025 02:44:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEEB79CF
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744080256; cv=none; b=qTNs3+3kM7WzFTYlmFHSySmEL2tOr18NA9HqoDQ13s8fv9HRtuL5Q2sFBIMQKDGW55cE+KfG1eAAb5vE1RjK9yW/VkF6yxNjSYgJepfQKyT6XeGRrj9FgCMnIRrA1+fKMxyBZmYIDR71RSqGy8IVqR7za6MwsvwUR+Gz2LzMXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744080256; c=relaxed/simple;
	bh=K1LGMJQaJ7ApXKauwn5a3xvNDFDD8avwimG51g6dRH4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GCi/BwCvGu7FGZ1EWsUnkyMkPxRMg+8291uGtb8z81GKTpCebcd/PrV8hdWX2rwM7mjxn+ydKMOosacauvCeh0U3qULBOI0qOuwmcBSue7iSc0AfvxH0EaK2F1ZyWmdhH9W9N+WgZwbLptv05c7Cx1hkeEBUxtVhVZkb2blbXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZWqdx00dQz4f3knr
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 10:24:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 664E01A0D1C
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 10:24:44 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDn8GPoiPRnhEcdIw--.62984S2;
	Tue, 08 Apr 2025 10:24:44 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 15/16] selftests/bpf: Add test cases for hash
 map with dynptr key
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20250327083455.848708-1-houtao@huaweicloud.com>
 <20250327083455.848708-16-houtao@huaweicloud.com>
 <CAEf4BzY6Y=40NHs12r3Jb7u_N8CVapwRuF09+dmxBH85J2t88w@mail.gmail.com>
 <34a1d3a2-0b63-7f11-9da2-5966b24e179b@huaweicloud.com>
 <CAEf4BzZY5OSBs3xEdhgC7hjwjQ9C4j+uyLxjjqAjc-ek_pJRog@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <07052375-1923-9a3e-2eee-a3bb9eae372d@huaweicloud.com>
Date: Tue, 8 Apr 2025 10:24:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZY5OSBs3xEdhgC7hjwjQ9C4j+uyLxjjqAjc-ek_pJRog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgDn8GPoiPRnhEcdIw--.62984S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tFWfKFyfKw15Jry3ur4Durg_yoW8GFW8Ko
	WfWrsxAa1rGr17C34DJ34kGryfuw18KryDJr4YgwnxGF1jq3yava4UG3yxJay0ga18Ww48
	Jas8J3sYvFZ2gFn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYv7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI
	62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 4/8/2025 12:05 AM, Andrii Nakryiko wrote:
> On Sun, Apr 6, 2025 at 7:47 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 4/5/2025 1:58 AM, Andrii Nakryiko wrote:
>>> On Thu, Mar 27, 2025 at 1:23 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Add three positive test cases to test the basic operations on the
>>>> dynptr-keyed hash map. The basic operations include lookup, update,
>>>> delete and get_next_key. These operations are exercised both through
>>>> bpf syscall and bpf program. These three test cases use different map
>>>> keys. The first test case uses both bpf_dynptr and a struct with only
>>>> bpf_dynptr as map key, the second one uses a struct with an integer and
>>>> a bpf_dynptr as map key, and the last one use a struct with two
>>>> bpf_dynptr as map key: one in the struct itself and another is nested in
>>>> another struct.
>>>>
>>>> Also add multiple negative test cases for dynptr-keyed hash map. These
>>>> test cases mainly check whether the layout of dynptr and non-dynptr in
>>>> the stack is matched with the definition of map->key_record.
>>>>
>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>> ---
>>>>  .../bpf/prog_tests/htab_dynkey_test.c         | 446 ++++++++++++++++++
>>>>  .../bpf/progs/htab_dynkey_test_failure.c      | 266 +++++++++++
>>>>  .../bpf/progs/htab_dynkey_test_success.c      | 382 +++++++++++++++
>>>>  3 files changed, 1094 insertions(+)
>>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_dynkey_test.c
>>>>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_failure.c
>>>>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
>>>>
>>> [...]
>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
>>>> new file mode 100644
>>>> index 0000000000000..84e6931cc19c0
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
>>>> @@ -0,0 +1,382 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
>>>> +#include <linux/types.h>
>>>> +#include <linux/bpf.h>
>>>> +#include <bpf/bpf_helpers.h>
>>>> +#include <bpf/bpf_tracing.h>
>>>> +#include <errno.h>
>>>> +
>>>> +#include "bpf_misc.h"
>>>> +
>>>> +char _license[] SEC("license") = "GPL";
>>>> +
>>>> +struct pure_dynptr_key {
>>>> +       struct bpf_dynptr name;
>>>> +};
>>>> +
>>>> +struct mixed_dynptr_key {
>>>> +       int id;
>>>> +       struct bpf_dynptr name;
>>>> +};
>>>> +
>>>> +struct multiple_dynptr_key {
>>>> +       struct pure_dynptr_key f_1;
>>>> +       unsigned long f_2;
>>>> +       struct mixed_dynptr_key f_3;
>>>> +       unsigned long f_4;
>>>> +};
>>>> +
>>> [...]
>>>
>>>> +       /* Delete the newly-inserted key */
>>>> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(systemd_name), 0, &key.f_3.name);
>>>> +       err = bpf_dynptr_write(&key.f_3.name, 0, (void *)systemd_name, sizeof(systemd_name), 0);
>>>> +       if (err) {
>>>> +               bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
>>>> +               err = 10;
>>>> +               goto out;
>>>> +       }
>>>> +       err = bpf_map_delete_elem(htab, &key);
>>>> +       if (err) {
>>>> +               bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
>>>> +               err = 11;
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       /* Lookup it again */
>>>> +       value = bpf_map_lookup_elem(htab, &key);
>>>> +       bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
>>>> +       if (value) {
>>>> +               err = 12;
>>>> +               goto out;
>>>> +       }
>>>> +out:
>>>> +       return err;
>>>> +}
>>> So, I'm not a big fan of this approach of literally embedding struct
>>> bpf_dynptr into map key type and actually initializing and working
>>> with it directly, like you do here with
>>> bpf_ringbuf_reserve_dynptr(..., &key.f_3.name).
>>>
>>> Here's why. This approach only works for *map keys* (not map values)
>>> and only when **the copy of the key** is on the stack (i.e., for map
>>> lookups/updates/deletes). This approach won't work for having dynptrs
>>> inside map value (for variable sized map values), nor does it really
>>> work when you get a direct pointer to map key in
>>> bpf_for_each_map_elem().
>> Yes. The reason why the key should be on the stack is due to the
>> limitation (or the design) of bpf_dynptr. However I didn't understand
>> why it doesn't work for map value just like other special field in the
>> map value (e.g., bpf_timer) ?
> bpf_timer and other special things that go into map_value have to
> painfully and carefully handle simultaneous access and modification of
> map value. So they either do locking (and thus are not compatible or
> reliable under NMI), or would need to be implemented locklessly.
>
> Dynptr is by design assumed to not be dealing with concurrent
> modifications, so bpf_dynptr_adjust(), for instance, can just update
> offset in place without any locking. Reliably and quickly.

Thanks for the explanation here and below. I got it now: multiple bpf
program could get the same map value through lookup and modify it
concurrently through helpers or kfuncs. A bit of slow for me to figure
out by myself. However, I think there is a big difference between
bpf_dynptr and bpf_timer or other special fields. For bpf_timer, we
could not update it through bpf_map_update_elem, so extra helpers or
kfuncs are needed. However, for bpf_dynptr in map key/value, it could be
updated through bpf_map_{update|delete}_elem(). Therefore, for dynptr in
map key or map value, does it really need to allow update through
non-map-update helpers and kfuncs ? Will it be enough to make the dynptr
in map key/value be read-only ? If the dynptr in map key could be
modified by bpf_dyptr_adjust(),  the lookup procedure may fail to find
the target map element.
>>> Curiously, you do have bpf_for_each_map_elem() "example" in patch #16
>>> in benchmarks, but you are carefully avoiding actually touching the
>>> `void *key` passed to your callback. Instead you create a local key,
>>> do lookup, and then compare the pointers to value to know that you
>>> "guessed" the key right.
>>>
>>> This doesn't seem to be how bpf_for_each_map_elem() is really meant to
>>> work: you'd want to be able to work with that key for real, get its
>>> data, etc. Not guess and confirm, like you do.
>> Er, bpf_for_each_map_elem() for dynptr-keyed hash map has not been
>> implemented yet (as said in the cover letter), so I used the values in
>> the array map as the lookup key for the hash map.
> It would be interesting to see an example on how you were thinking to
> implement dynptr inside map key. Can you provide a hypothetical
> example on how you were thinking to approach this?

Haven't started it yet. The early thoughts were:
1) support using map key of dynptr-keyed map as the map key for other
dynptr-keyed map
2) support using dynptr in dynptr-keyed map key as dynptr directly

so the following code snippet could work:

struct dynkey_key {
        int cookie;
        struct bpf_dynptr desc;
};

struct {
        __uint(type, BPF_MAP_TYPE_HASH);
        __type(key, struct bpf_dynptr);
        __type(value, unsigned int);
        __uint(map_flags, BPF_F_NO_PREALLOC);
}  htab_1 SEC(".maps");

struct {
        __uint(type, BPF_MAP_TYPE_HASH);
        __type(key, struct dynkey_key);
        __type(value, unsigned int);
        __uint(map_flags, BPF_F_NO_PREALLOC);
} htab_2 SEC(".maps");

int lookup_dynkey_htab(void *map, void *key, void *val, void *ctx)
{
         struct dynkey_key *dkey = key;

         bpf_map_lookup_elem(map, dkey);
         bpf_map_lookup_elem(&htab_1, &dkey->desc);
        
         bpf_dynptr_read(buf, sizeof(buf), &dkey->desc, 0, 0);

         return 0;
}

bpf_for_each_map_elem(&htab_2, lookup_dynkey_htab, NULL, 0);

>
>>> And in case it's not obvious why this approach won't work when dynptrs
>>> are stored inside map value. Dynptr itself relies on not being
>>> modified concurrently. We achieve that through *always* keeping it on
>>> BPF programs stack, guaranteeing that no concurrently running BPF
>>> program (BPF program sharing the map, or same program on different
>>> CPU) can touch the dynptr. This is pretty fundamental. And I don't
>>> think we should add more locking to dynptr itself just to enable this.
>> I didn't follow that. Even dynptr is kept in map value, how will it be
>> modified concurrently ? When there are special fields in the map value,
>> the update of the map value will be out-of-place update and the old
>> dynptr will be kept as intact.
> Easy. bpf_map_lookup_elem() for the same key from two concurrent CPUs.
> You get a pointer to the same map value, which BPF programs can modify
> without any locking absolutely concurrently and in parallel.
>
> So you don't even have to do bpf_map_update_elem() to run into troubles.
>
>
>
> So I have an alternative proposal that will extend to map values and
> real map keys (not they local copy on the stack).
>
> I say, we stop pretending that it's an actual dynptr that is stored in
> the key. It should be some sort of "dynptr impression" (I don't want
> to bikeshed right now), and user would have to put it into map key for
> lookup/update/delete through a special kfunc (let's call this
> "bpf_dynptr_stash" for now). When working with an existing map key
> (and map value in the future), we need to create a local real dynptr
> from its map key/value "impression", say, with "bpf_dynptr_unstash".
>
> bpf_dynptr_stash() is effectively bpf_dynptr_clone() (so all the
> mechanics is already supported by verifier). bpf_dynptr_unstash() is
> effectively bpf_dynptr_from_mem(). But they might need a slight change
> to accommodate a different actual struct type we'll use for that
> stashed dynptr.
>
> So just to show what I mean on pseudo example:
>
>
> struct bpf_stashed_dynptr {
>    __bpf_md_ptr(void *, data);
>    __u32 size;
>    __u32 reserved;
> }
>> It will be an ABI for both bpf program and bpf syscall just like
>> bpf_dynptr, right ? Therefore, when bpf_stashed_dynptr is used in the
>> bpf program, we need to implement something similar for the struct just
>> like dynptr, because we need to ensure both ->data and ->size are valid,
> Yes, direct BPF program (or user space) access to this
> bpf_stashed_dynptr has to be restricted, of course, just like for any
> other embedded special struct (timer, wq, lock). Only the kernel and
> stashing/unstashing API should be able to access this data directly
> (and very carefully, of course).

OK.
>
>> right ? If it may be not safe to keep dynptr in the map key/value, how
>> will it be safe to keep bpf_stashed_dynptr in the map key/value ?
> Because you'll have a carefully written two APIs to stash/unstash BPF
> dynptr into/out of map value. Those two will do this operation
> atomically in the face of concurrent map value modifications. But once
> you have a local dynptr, all existing dynptr APIs (including
> bpf_dynptr_adjust) will deal with local dynptr that is safe to modify.
>
>
> You can't really achieve the same with dynptr even if you restrict
> what kind of API can be called on dynptr-in-map-value. Because even
> read-only APIs like bpf_dynptr_slice() assume that underlying dynptr
> can be accessed without locking and won't be concurrently modified.
> This is not true at least for per-CPU maps, isn't it? So user space
> can update per-CPU map value while it is being accessed from the BPF
> program. This will inevitably lead to problems when working with
> dynptr inside map value directly.

Thanks for the explanation. So let me summarize the reasons for choosing
(and not choosing) `bpf_stashed_dynptr`:

1) always keep bpf_dynptr in the stack to keep its design be simple (no
concurrent update)
However, we could make the bpf_dynptr in map key and value be read-only.

2) need to support concurrent update through non-bpf_map_update_elem helpers
However, if the dynptr in map key and value is read-only, there will be
no concurrent update. The update could be done through
bpf_map_update_elem helper.

3) need to support in-place update through bpf_map_update_elem helper 
(e.g., for per-CPU map)
However, if we need to support dynptr in map value, maybe we should
change the in-place update to out-of-place update.

Hope I didn't miss any point.

>
>>> struct id_dname_key {
>>>        int id;
>>>        struct bpf_stashed_dynptr name;
>>> };
>>>
> [...]
>
>>> /* FOR_EACH_MAP_ELEM_KEY READING */
>>> static int cb(void *map, void *key, void *value, void *ctx)
>>> {
>>>     struct id_dname_key *k = key;
>>>     struct bpf_dynptr dptr;
>>>     const void *name;
>>>
>>>     /* create local real dynptr from stashed one in the key in the map */
>>>     bpf_dynptr_unstash(&k->name, &dptr);
>>>
>>>     /* get direct memory access to the data stored in the key, NO COPIES! */
>>>     name = bpf_dynptr_slice(&dptr, ....);
>>>     if (name)
>>>         bpf_printk("my_key.name: %s", name);
>>> }
>> The point here is to avoid keeping bpf_dynptr in the map key and to save
>> it in the stack instead, right ?
> yes
>
>>> ...
>>>
>>> bpf_for_each_map_elem(&htab, cb, NULL, 0); /* iterate */
>>>
>>>
>>>
>>> And I'm too lazy to write this for hypothetical map value use case.
>>> Map value has an extra challenge of making sure stashing/unstashing
>>> handle racy updates from other CPUs, which I believe you can do with
>>> seqcount-like approach (no heavy-weight locking).
>>>
>>> BTW, this dedicated `struct bpf_stashed_dynptr` completely avoids that
>>> double-defined `struct bpf_dynptr` you do in patch #6. Kernel will
>>> know it's something like a real dynptr when doing update/lookup/delete
>>> from on-the-stack key copy, and that it's a completely different thing
>>> when it's actually stored inside the map in the key (and, eventually,
>>> in the value). And in user space it will be a still different
>>> definition, which kernel will provide when doing lookups from user
>>> space.
>>>
>>> Hope this makes sense.
>> Thanks for the suggestion.
>>> [...]


