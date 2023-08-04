Return-Path: <bpf+bounces-7023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE7577054B
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 17:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7FA28276E
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6745B1805F;
	Fri,  4 Aug 2023 15:53:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38097BE7B
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 15:52:59 +0000 (UTC)
Received: from out-104.mta0.migadu.com (out-104.mta0.migadu.com [91.218.175.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B474EE0
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 08:52:45 -0700 (PDT)
Message-ID: <a2a3bd2e-a254-997f-a437-cc95e4482b5e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691164362; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04bz/lLp1mN3/sJ1RwJUlFCdDbNah/HJ6PDbfNdfz1g=;
	b=EZOvx/WwuYhJommlqcZVn/24LT672D1GjCrTULGeViQj5n2OmgJk//JM92JY0HRv8TW7bk
	0S3lTMShWNCMCWVrN2LQKAShpUVXb2eSLsCToH1SvrhjfiXW0YXGp0NZhRHzkrj5FExXPa
	u8w2IpG53VFj95+OuZ1BqqYod8V9K/o=
Date: Fri, 4 Aug 2023 08:52:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v1 bpf-next 1/2] [RFC] bpf: Introduce BPF_F_VMA_NEXT flag
 for bpf_find_vma helper
Content-Language: en-US
To: David Marchevsky <david.marchevsky@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Nathan Slingerland <slinger@meta.com>
References: <20230801145414.418145-1-davemarchevsky@fb.com>
 <CAADnVQKo5VTkmS+DdYc5a8Hns4meptn7g76dOjxmJCHgpo29hQ@mail.gmail.com>
 <a07132a2-9828-a84a-af5b-ab660678157d@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a07132a2-9828-a84a-af5b-ab660678157d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 11:59 PM, David Marchevsky wrote:
> On 8/1/23 4:41 PM, Alexei Starovoitov wrote:
>> On Tue, Aug 1, 2023 at 7:54 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>>
>>> At Meta we have a profiling daemon which periodically collects
>>> information on many hosts. This collection usually involves grabbing
>>> stacks (user and kernel) using perf_event BPF progs and later symbolicating
>>> them. For user stacks we try to use BPF_F_USER_BUILD_ID and rely on
>>> remote symbolication, but BPF_F_USER_BUILD_ID doesn't always succeed. In
>>> those cases we must fall back to digging around in /proc/PID/maps to map
>>> virtual address to (binary, offset). The /proc/PID/maps digging does not
>>> occur synchronously with stack collection, so the process might already
>>> be gone, in which case it won't have /proc/PID/maps and we will fail to
>>> symbolicate.
>>>
>>> This 'exited process problem' doesn't occur very often as
>>> most of the prod services we care to profile are long-lived daemons,
>>> there are enough usecases to warrant a workaround: a BPF program which
>>> can be optionally loaded at data collection time and essentially walks
>>> /proc/PID/maps. Currently this is done by walking the vma list:
>>>
>>>    struct vm_area_struct* mmap = BPF_CORE_READ(mm, mmap);
>>>    mmap_next = BPF_CORE_READ(rmap, vm_next); /* in a loop */
>>>
>>> Since commit 763ecb035029 ("mm: remove the vma linked list") there's no
>>> longer a vma linked list to walk. Walking the vma maple tree is not as
>>> simple as hopping struct vm_area_struct->vm_next. That commit replaces
>>> vm_next hopping with calls to find_vma(mm, addr) helper function, which
>>> returns the vma containing addr, or if no vma contains addr,
>>> the closest vma with higher start addr.
>>>
>>> The BPF helper bpf_find_vma is unsurprisingly a thin wrapper around
>>> find_vma, with the major difference that no 'closest vma' is returned if
>>> there is no VMA containing a particular address. This prevents BPF
>>> programs from being able to use bpf_find_vma to iterate all vmas in a
>>> task in a reasonable way.
>>>
>>> This patch adds a BPF_F_VMA_NEXT flag to bpf_find_vma which restores
>>> 'closest vma' behavior when used. Because this is find_vma's default
>>> behavior it's as straightforward as nerfing a 'vma contains addr' check
>>> on find_vma retval.
>>>
>>> Also, change bpf_find_vma's address parameter to 'addr' instead of
>>> 'start'. The former is used in documentation and more accurately
>>> describes the param.
>>>
>>> [
>>>    RFC: This isn't an ideal solution for iteration of all vmas in a task
>>>         in the long term for a few reasons:
>>>
>>>       * In nmi context, second call to bpf_find_vma will fail because
>>>         irq_work is busy, so can't iterate all vmas
>>>       * Repeatedly taking and releasing mmap_read lock when a dedicated
>>>         iterate_all_vmas(task) kfunc could just take it once and hold for
>>>         all vmas
>>>
>>>      My specific usecase doesn't do vma iteration in nmi context and I
>>>      think the 'closest vma' behavior can be useful here despite locking
>>>      inefficiencies.
>>>
>>>      When Alexei and I discussed this offline, two alternatives to
>>>      provide similar functionality while addressing above issues seemed
>>>      reasonable:
>>>
>>>        * open-coded iterator for task vma. Similar to existing
>>>          task_vma bpf_iter, but no need to create a bpf_link and read
>>>          bpf_iter fd from userspace.
>>>        * New kfunc taking callback similar bpf_find_vma, but iterating
>>>          over all vmas in one go
>>>
>>>       I think this patch is useful on its own since it's a fairly minimal
>>>       change and fixes my usecase. Sending for early feedback and to
>>>       solicit further thought about whether this should be dropped in
>>>       favor of one of the above options.
>>
>> - In theory this patch can work, but patch 2 didn't attempt to actually
>> use it in a loop to iterate all vma-s.
>> Which is a bit of red flag whether such iteration is practical
>> (either via bpf_loop or bpf_for).
>>
>> - This behavior of bpf_find_vma() feels too much implementation detail.
>> find_vma will probably stay this way, since different parts of the kernel
>> rely on it, but exposing it like BPF_F_VMA_NEXT leaks implementation too much.
>>
>> - Looking at task_vma_seq_get_next().. that's how vma iter should be done and
>> I don't think bpf prog can do it on its own.
>> Because with bpf_find_vma() the lock will drop at every step the problems
>> described at that large comment will be hit sooner or later.
>>
>> All concerns combined I feel we better provide a new kfunc that iterates vma
>> and drops the lock before invoking callback.
>> It can be much simpler than task_vma_seq_get_next() if we don't drop the lock.
>> Maybe it's ok.
>> Doing it open coded iterators style is likely better.
>> bpf_iter_vma_new() kfunc will do
>> bpf_mmap_unlock_get_irq_work+mmap_read_trylock
>> while bpf_iter_vma_destroy() will bpf_mmap_unlock_mm.
>>
>> I'd try to do open-code-iter first. It's a good test for the iter infra.
>> bpf_iter_testmod_seq_new is an example of how to add a new iter.
>>
>> Another issue with bpf_find_vma is .arg1_type = ARG_PTR_TO_BTF_ID.
>> It's not a trusted arg. We better move away from this legacy pointer.
>> bpf_iter_vma_new() should accept only trusted ptr to task_struct.
>> fwiw bpf_get_current_task_btf_proto has
>> .ret_type = RET_PTR_TO_BTF_ID_TRUSTED and it matters here.
>> The bpf prog might look like:
>> task = bpf_get_current_task_btf();
>> err = bpf_iter_vma_new(&it, task);
>> while ((vma = bpf_iter_vma_next(&it))) ...;
>> assuming lock is not dropped by _next.
> 
> The only concern here that doesn't seem reasonable to me is the
> "too much implementation detail". I agree with the rest, though,
> so will send a different series with new implementation and point
>   to this discussion.

For reference, this is another use case for traversing
vma's in the bpf program reported from bcc mailing list:
   https://github.com/iovisor/bcc/pull/4679

The use case is for that the application may not have frame pointer
so bpf program will just scan stack's and find potential
user text region pointers and report them. This is similar
to what current arch (e.g., x86) code reporting crash stack.

