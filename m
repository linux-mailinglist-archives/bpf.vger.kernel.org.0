Return-Path: <bpf+bounces-8346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F7785174
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 09:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80D81C20C4C
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 07:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA418F65;
	Wed, 23 Aug 2023 07:26:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93D20EE3
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 07:26:55 +0000 (UTC)
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [IPv6:2001:41d0:203:375::7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4073EE67
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 00:26:48 -0700 (PDT)
Message-ID: <36463876-1370-71d6-78f3-2350278f61c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692775606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8avWgS+vhdcs3wuVqr+M071EGuv1igL4BRZdI9R7ggI=;
	b=wezYMVtmlvHC/ULaTOErn0DdEYjuoXPazKqm9w75AMP+U30SWV+LCNOhah6mJLFPz9V14d
	ou+67qd7TqVbhr3C+Ieq6wtkaA5o/xTDpkIDU/+A3krZWiUREuXGBRqBpX4wt9EvHJV1qw
	D1LN4+85z3sdNzA7T6yp1H3sL9BsmlQ=
Date: Wed, 23 Aug 2023 03:26:40 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 yonghong.song@linux.dev, sdf@google.com,
 Nathan Slingerland <slinger@meta.com>
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com>
 <CAEf4BzZouNbzP7xOPxnU_Xzof2-L0fNE4CcjCcUJpJjAdyPJSw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <CAEf4BzZouNbzP7xOPxnU_Xzof2-L0fNE4CcjCcUJpJjAdyPJSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/22/23 7:52 PM, Andrii Nakryiko wrote:
> On Mon, Aug 21, 2023 at 10:06 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_task_vma in open-coded
>> iterator style. BPF programs can use these kfuncs directly or through
>> bpf_for_each macro for natural-looking iteration of all task vmas.
>>
>> The implementation borrows heavily from bpf_find_vma helper's locking -
>> differing only in that it holds the mmap_read lock for all iterations
>> while the helper only executes its provided callback on a maximum of 1
>> vma. Aside from locking, struct vma_iterator and vma_next do all the
>> heavy lifting.
>>
>> The newly-added struct bpf_iter_task_vma has a name collision with a
>> selftest for the seq_file task_vma iter's bpf skel, so the selftests/bpf/progs
>> file is renamed in order to avoid the collision.
>>
>> A pointer to an inner data struct, struct bpf_iter_task_vma_kern_data, is the
>> only field in struct bpf_iter_task_vma. This is because the inner data
>> struct contains a struct vma_iterator (not ptr), whose size is likely to
>> change under us. If bpf_iter_task_vma_kern contained vma_iterator directly
>> such a change would require change in opaque bpf_iter_task_vma struct's
>> size. So better to allocate vma_iterator using BPF allocator, and since
>> that alloc must already succeed, might as well allocate all iter fields,
>> thereby freezing struct bpf_iter_task_vma size.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> Cc: Nathan Slingerland <slinger@meta.com>
>> ---
>>  include/uapi/linux/bpf.h                      |  4 +
>>  kernel/bpf/helpers.c                          |  3 +
>>  kernel/bpf/task_iter.c                        | 84 +++++++++++++++++++
>>  tools/include/uapi/linux/bpf.h                |  4 +
>>  tools/lib/bpf/bpf_helpers.h                   |  8 ++
>>  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
>>  ...f_iter_task_vma.c => bpf_iter_task_vmas.c} |  0
>>  7 files changed, 116 insertions(+), 13 deletions(-)
>>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c => bpf_iter_task_vmas.c} (100%)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 8790b3962e4b..49fc1989a548 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7311,4 +7311,8 @@ struct bpf_iter_num {
>>         __u64 __opaque[1];
>>  } __attribute__((aligned(8)));
>>
>> +struct bpf_iter_task_vma {
>> +       __u64 __opaque[1]; /* See bpf_iter_num comment above */
>> +} __attribute__((aligned(8)));
>> +
>>  #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index eb91cae0612a..7a06dea749f1 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2482,6 +2482,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>>  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW)
>> +BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
>>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index c4ab9d6cdbe9..51c2dce435c1 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -7,7 +7,9 @@
>>  #include <linux/fs.h>
>>  #include <linux/fdtable.h>
>>  #include <linux/filter.h>
>> +#include <linux/bpf_mem_alloc.h>
>>  #include <linux/btf_ids.h>
>> +#include <linux/mm_types.h>
>>  #include "mmap_unlock_work.h"
>>
>>  static const char * const iter_task_type_names[] = {
>> @@ -823,6 +825,88 @@ const struct bpf_func_proto bpf_find_vma_proto = {
>>         .arg5_type      = ARG_ANYTHING,
>>  };
>>
>> +struct bpf_iter_task_vma_kern_data {
>> +       struct task_struct *task;
>> +       struct mm_struct *mm;
>> +       struct mmap_unlock_irq_work *work;
>> +       struct vma_iterator vmi;
>> +};
>> +
>> +/* Non-opaque version of uapi bpf_iter_task_vma */
>> +struct bpf_iter_task_vma_kern {
>> +       struct bpf_iter_task_vma_kern_data *data;
>> +} __attribute__((aligned(8)));
>> +
> 
> it's a bit worrying that we'll rely on memory allocation inside NMI to
> be able to use this. I'm missing previous email discussion (I declared
> email bankruptcy after long vacation), but I suppose the option to fix
> bpf_iter_task_vma (to 88 bytes: 64 for vma_iterator + 24 for extra
> pointers), or even to 96 to have a bit of headroom in case we need a
> bit more space was rejected? It seems unlikely that vma_iterator will
> have to grow, but if it does, it has 5 bytes of padding right now for
> various flags, plus we can have extra 8 bytes reserved just in case.
> 
> I know it's a big struct and will take a big chunk of the BPF stack,
> but I'm a bit worried about both the performance implication of mem
> alloc under NMI, and allocation failing.
> 
> Maybe the worry is overblown, but I thought I'll bring it up anyways.
> 

Few tangential trains of thought here, separated by multiple newlines
for easier reading.


IIUC the any-context BPF allocator will not actually allocate memory in NMI
context, instead relying on its existing pre-filled caches.

Alexei's patch adding the allocator says ([0]):

  The allocators are NMI-safe from bpf programs only. They are not NMI-safe in general.

So sounds bpf_mem_alloc in a kfunc called by a BPF program is NMI-safe.


That's not to say that I'm happy about adding a fallible bpf_mem_alloc call here
before the kfunc can do anything useful. But it seems like the best way to
guarantee that we never see a mailing list message like:

  Hello, I just added a field to 'struct ma_state' in my subsystem and it seems
  I've triggered a BUILD_BUG_ON in this far-away BPF subsystem. It looks like
  you're making stability guarantees based on the size of my internal struct.
  What the hell?

Sure, after I remove the kfuncs and struct bpf_iter_task_vma fwd decl from
bpf_helpers.h - per your other comment below - we can do the whole "kfuncs
aren't uapi and this struct bpf_iter_task_vma is coming from vmlinux.h,
not some stable header" spiel and convince this hypothetical person. Not having
to do the spiel here reinforces the more general "Modern BPF exposes
functionality w/ kfuncs and kptrs, which are inherently _unstable_" messaging
more effectively than having to explain.


If we go back to putting struct vma_iterator on the BPF stack, I think we
definitely want to keep the BUILD_BUG_ON. If it were removed and vma_iterator
size changes, that would affect portability of BPF programs that assume the old
size of bpf_iter_task_vma, no? Which bpf_for_each is doing since it puts
bpf_iter_task_vma on the stack.

Is there some CO-RE technique that would handle above scenario portably? I
can't think of anything straightforward. Maybe if BPF prog BTF only had
a fwd decl for bpf_iter_task_vma, and size thus had to be taken from
vmlinux BTF. But that would fail to compile since it the struct goes
on the stack. Maybe use some placeholder size for compilation and use
BTF tag to tell libbpf to patch insns w/ vmlinux's size for this struct?


Re: padding bytes, seems worse to me than not using them. Have to make
assumptions about far-away struct, specifically vma_iterator
which landed quite recently as part of maple tree series. The assumptions
don't prevent my hypothetical mailing list confusion from happening, increases
the confusion if it does happen ("I added a small field recently, why didn't
this break then? If it's explicitly and intentionally unstable, why add
padding bytes?")

  [0]: https://lore.kernel.org/bpf/20220902211058.60789-2-alexei.starovoitov@gmail.com

>> +__bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>> +                                     struct task_struct *task, u64 addr)
>> +{
>> +       struct bpf_iter_task_vma_kern *kit = (void *)it;
>> +       bool irq_work_busy = false;
>> +       int err;
>> +
> 
> [...]
> 
>>  static void do_mmap_read_unlock(struct irq_work *entry)
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 8790b3962e4b..49fc1989a548 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -7311,4 +7311,8 @@ struct bpf_iter_num {
>>         __u64 __opaque[1];
>>  } __attribute__((aligned(8)));
>>
>> +struct bpf_iter_task_vma {
>> +       __u64 __opaque[1]; /* See bpf_iter_num comment above */
>> +} __attribute__((aligned(8)));
>> +
>>  #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> index bbab9ad9dc5a..d885ffee4d88 100644
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -302,6 +302,14 @@ extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak
>>  extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
>>  extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
>>
>> +struct bpf_iter_task_vma;
>> +
>> +extern int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>> +                                struct task_struct *task,
>> +                                unsigned long addr) __weak __ksym;
>> +extern struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it) __weak __ksym;
>> +extern void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it) __weak __ksym;
> 
> my intent wasn't to add all open-coded iterators to bpf_helpers.h. I
> think bpf_iter_num_* is rather an exception and isn't supposed to ever
> change or be removed, while other iterators should be allowed to be
> changed.
> 
> The goal is for all such kfuncs (and struct bpf_iter_task_vma state
> itself, probably) to come from vmlinux.h, eventually, so let's leave
> it out of libbpf's stable bpf_helpers.h header.
> 
> 
> [...]

As alluded to in my long response above, this sounds reasonable, will
remove from here.

> 
>> @@ -1533,7 +1533,7 @@ static void test_task_vma_dead_task(void)
>>  out:
>>         waitpid(child_pid, &wstatus, 0);
>>         close(iter_fd);
>> -       bpf_iter_task_vma__destroy(skel);
>> +       bpf_iter_task_vmas__destroy(skel);
>>  }
>>
>>  void test_bpf_sockmap_map_iter_fd(void)
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
>> similarity index 100%
>> rename from tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
>> rename to tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
>> --
>> 2.34.1
>>

