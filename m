Return-Path: <bpf+bounces-8297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09E784B33
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 22:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC99281048
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 20:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB9201A2;
	Tue, 22 Aug 2023 20:14:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414B20180
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 20:14:49 +0000 (UTC)
Received: from out-14.mta1.migadu.com (out-14.mta1.migadu.com [95.215.58.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0763CC
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:14:46 -0700 (PDT)
Message-ID: <c5470820-6e5d-2755-05f9-f932cacd395f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692735285; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqX/lD2j12Na+v64a07wDAHoAO00lDjHpkZiqJrm2Lc=;
	b=s9nFacfKW6cHUx3BeXJDnMKVi63lFniWhKBPHWXf4q9oaV5DBT5X8ORaAJq/gf8+wgrc0Z
	lb4nkVWNWsO3MscXd3Ig5bz/IhXki9NCCgSu1bxfM0iUifQq4FI1Z4b1gUpFdZgsNwSMUl
	68Bd4IIRvVlIq7PBeRBeBwsj0MKX1sA=
Date: Tue, 22 Aug 2023 13:14:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
Content-Language: en-US
To: David Marchevsky <david.marchevsky@linux.dev>,
 Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 sdf@google.com, Nathan Slingerland <slinger@meta.com>
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com>
 <04626310-a4c3-8192-9aee-11af5d692817@linux.dev>
 <5df1b876-9465-4de2-42d5-a59426d141aa@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5df1b876-9465-4de2-42d5-a59426d141aa@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/22/23 12:19 PM, David Marchevsky wrote:
> On 8/22/23 1:42 PM, Yonghong Song wrote:
>>
>>
>> On 8/21/23 10:05 PM, Dave Marchevsky wrote:
>>> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allow
>>> creation and manipulation of struct bpf_iter_task_vma in open-coded
>>> iterator style. BPF programs can use these kfuncs directly or through
>>> bpf_for_each macro for natural-looking iteration of all task vmas.
>>>
>>> The implementation borrows heavily from bpf_find_vma helper's locking -
>>> differing only in that it holds the mmap_read lock for all iterations
>>> while the helper only executes its provided callback on a maximum of 1
>>> vma. Aside from locking, struct vma_iterator and vma_next do all the
>>> heavy lifting.
>>>
>>> The newly-added struct bpf_iter_task_vma has a name collision with a
>>> selftest for the seq_file task_vma iter's bpf skel, so the selftests/bpf/progs
>>> file is renamed in order to avoid the collision.
>>>
>>> A pointer to an inner data struct, struct bpf_iter_task_vma_kern_data, is the
>>> only field in struct bpf_iter_task_vma. This is because the inner data
>>> struct contains a struct vma_iterator (not ptr), whose size is likely to
>>> change under us. If bpf_iter_task_vma_kern contained vma_iterator directly
>>> such a change would require change in opaque bpf_iter_task_vma struct's
>>> size. So better to allocate vma_iterator using BPF allocator, and since
>>> that alloc must already succeed, might as well allocate all iter fields,
>>> thereby freezing struct bpf_iter_task_vma size.
>>>
>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>> Cc: Nathan Slingerland <slinger@meta.com>
>>> ---
>>>    include/uapi/linux/bpf.h                      |  4 +
>>>    kernel/bpf/helpers.c                          |  3 +
>>>    kernel/bpf/task_iter.c                        | 84 +++++++++++++++++++
>>>    tools/include/uapi/linux/bpf.h                |  4 +
>>>    tools/lib/bpf/bpf_helpers.h                   |  8 ++
>>>    .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
>>>    ...f_iter_task_vma.c => bpf_iter_task_vmas.c} |  0
>>>    7 files changed, 116 insertions(+), 13 deletions(-)
>>>    rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c => bpf_iter_task_vmas.c} (100%)
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 8790b3962e4b..49fc1989a548 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -7311,4 +7311,8 @@ struct bpf_iter_num {
>>>        __u64 __opaque[1];
>>>    } __attribute__((aligned(8)));
>>>    +struct bpf_iter_task_vma {
>>> +    __u64 __opaque[1]; /* See bpf_iter_num comment above */
>>> +} __attribute__((aligned(8)));
>>
>> In the future, we might have bpf_iter_cgroup, bpf_iter_task, bpf_iter_cgroup_task, etc. They may all use the same struct
>> like
>>    struct bpf_iter_<...> {
>>      __u64 __opaque[1];
>>    } __attribute__((aligned(8)));
>>
>> Maybe we want a generic one instead of having lots of
>> structs with the same underline definition? For example,
>>    struct bpf_iter_generic
>> ?
>>
> 
> The bpf_for_each macro assumes a consistent naming scheme for opaque iter struct
> and associated kfuncs. Having a 'bpf_iter_generic' shared amongst multiple types
> of iters would break the scheme. We could:
> 
>    * Add bpf_for_each_generic that only uses bpf_iter_generic
>      * This exposes implementation details in an ugly way, though.
>    * Do some macro magic to pick bpf_iter_generic for some types of iters, and
>      use consistent naming pattern for others.
>      * I'm not sure how to do this with preprocessor
>    * Migrate all opaque iter structs to only contain pointer to bpf_mem_alloc'd
>      data struct, and use bpf_iter_generic for all of them
>      * Probably need to see more iter implementation / usage before making such
>        a change
>    * Do 'typedef __u64 __aligned(8) bpf_iter_<...>
>      * BTF_KIND_TYPEDEF intead of BTF_KIND_STRUCT might throw off some verifier
>        logic. Could do similar typedef w/ struct to try to work around
>        it.
> 
> Let me know what you think. Personally I considered doing typedef while
> implementing this, so that's the alternative I'd choose.

Okay, since we have naming convention restriction, typedef probably the
best option, something like
   typedef struct bpf_iter_num bpf_iter_task_vma
?

Verifier might need to be changed if verifier strips all modifiers
(including tyypedef) to find the struct name.

> 
>>> +
>>>    #endif /* _UAPI__LINUX_BPF_H__ */
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index eb91cae0612a..7a06dea749f1 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -2482,6 +2482,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
>>>    BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>>>    BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>>>    BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>>> +BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW)
>>> +BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
>>> +BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
>>>    BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>>>    BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>>    BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>>> index c4ab9d6cdbe9..51c2dce435c1 100644
>>> --- a/kernel/bpf/task_iter.c
>>> +++ b/kernel/bpf/task_iter.c
>>> @@ -7,7 +7,9 @@
>>>    #include <linux/fs.h>
>>>    #include <linux/fdtable.h>
>>>    #include <linux/filter.h>
>>> +#include <linux/bpf_mem_alloc.h>
>>>    #include <linux/btf_ids.h>
>>> +#include <linux/mm_types.h>
>>>    #include "mmap_unlock_work.h"
>>>      static const char * const iter_task_type_names[] = {
>>> @@ -823,6 +825,88 @@ const struct bpf_func_proto bpf_find_vma_proto = {
>>>        .arg5_type    = ARG_ANYTHING,
>>>    };
>>>    +struct bpf_iter_task_vma_kern_data {
>>> +    struct task_struct *task;
>>> +    struct mm_struct *mm;
>>> +    struct mmap_unlock_irq_work *work;
>>> +    struct vma_iterator vmi;
>>> +};
>>> +
>>> +/* Non-opaque version of uapi bpf_iter_task_vma */
>>> +struct bpf_iter_task_vma_kern {
>>> +    struct bpf_iter_task_vma_kern_data *data;
>>> +} __attribute__((aligned(8)));
>>> +
>>> +__bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>>> +                      struct task_struct *task, u64 addr)
>>> +{
>>> +    struct bpf_iter_task_vma_kern *kit = (void *)it;
>>> +    bool irq_work_busy = false;
>>> +    int err;
>>> +
>>> +    BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
>>> +    BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) != __alignof__(struct bpf_iter_task_vma));
>>> +
>>> +    /* is_iter_reg_valid_uninit guarantees that kit hasn't been initialized
>>> +     * before, so non-NULL kit->data doesn't point to previously
>>> +     * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
>>> +     */
>>> +    kit->data = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_iter_task_vma_kern_data));
>>> +    if (!kit->data)
>>> +        return -ENOMEM;
>>> +    kit->data->task = NULL;
>>> +
>>> +    if (!task) {
>>> +        err = -ENOENT;
>>> +        goto err_cleanup_iter;
>>> +    }
>>> +
>>> +    kit->data->task = get_task_struct(task);
>>
>> The above is not safe. Since there is no restriction on 'task',
>> the 'task' could be in a state for destruction with 'usage' count 0
>> and then get_task_struct(task) won't work since it unconditionally
>> tries to increase 'usage' count from 0 to 1.
>>
>> Or, 'task' may be valid at the entry of the funciton, but when
>> 'task' is in get_task_struct(), 'task' may have been destroyed
>> and 'task' memory is reused by somebody else.
>>
>> I suggest that we check input parameter 'task' must be
>> PTR_TRUSTED or MEM_RCU. This way, the above !task checking
>> is not necessary and get_task_struct() can correctly
>> hold a reference to 'task'.
>>
> 
> Adding a PTR_TRUSTED or MEM_RCU check seems reasonable. I'm curious
> whether there's any way to feed a 'plain' struct task_struct PTR_TO_BTF_ID
> to this kfunc currently.
> 
> * bpf_get_current_task_btf helper returns PTR_TRUSTED | PTR_TO_BTF_ID
> * ptr hop from trusted task_struct to 'real_parent' or similar should
>    yield MEM_RCU (due to BTF_TYPE_SAFE_RCU(struct task_struct) def

This is true.

> * if task kptr is in map_val, direct reference to it should result
>    in PTR_UNTRUSTED PTR_TO_BTF_ID, must kptr_xchg it or acquire again
>    using bpf_task_from_pid (?)

If in the rcu region, direct access of the task kptr can be marked
with MEM_RCU | PTR_MAYBE_NULL. After a null ptr check, you will
get a rcu protected task ptr.

> 
> But regardless, better to be explicit. Will change.
> 
>>> +    kit->data->mm = task->mm;
>>> +    if (!kit->data->mm) {
>>> +        err = -ENOENT;
>>> +        goto err_cleanup_iter;
>>> +    }
>>> +
>>> +    /* kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work */
>>> +    irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
>>> +    if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
>>> +        err = -EBUSY;
>>> +        goto err_cleanup_iter;
>>> +    }
>>> +
>>> +    vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
>>> +    return 0;
>>> +
>>> +err_cleanup_iter:
>>> +    if (kit->data->task)
>>> +        put_task_struct(kit->data->task);
>>> +    bpf_mem_free(&bpf_global_ma, kit->data);
>>> +    /* NULL kit->data signals failed bpf_iter_task_vma initialization */
>>> +    kit->data = NULL;
>>> +    return err;
>>> +}
>>> +
>> [...]

