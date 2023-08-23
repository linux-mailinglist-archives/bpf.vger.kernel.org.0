Return-Path: <bpf+bounces-8322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E07784D99
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0451C20B82
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0921919A;
	Wed, 23 Aug 2023 00:05:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEBA7E
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 00:05:13 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4A8133
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:05:11 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso38718471fa.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692749110; x=1693353910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx8omp3xHAfWg0SpZSNhlk1xm1DlFdKVaxxqvOiWg7M=;
        b=BX35un2Ar/wjfo5oBG8LyreKTQlqytuZijuvLsfmDVVck0PHwRTaf+1HVtSPwYjGIF
         emO5eTWo8C9wlQ/grJCLJ7D8sOWT92ZlCisPFEU6+mkzEwookqd68g+x9+8oT+1k+N6B
         ei3T2APnOpaKE4W+J/7LECI0ZP7mRT5KUgCsZXYXCYav20HIqGia0OsSMySybh8L8LEH
         3Vo0Jhxjcd6NYE1fP6uEp58iecZWahQ7UM2HKBkxO07nJTFHzf49xqg0Z4yK4Pr6lQAv
         goOcSQQSj1ypwzH6whupT6aXbeqpWvWL6VFFsxCgWAkBmhJiKKiUzfji16sIYKFVL+WJ
         Xgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692749110; x=1693353910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx8omp3xHAfWg0SpZSNhlk1xm1DlFdKVaxxqvOiWg7M=;
        b=P1febIAwYuC1knkLJYnUPX2JnjL0x1RqmU5e13wnphnHIjehVOfwQCkA/o8DWtuIUy
         NGnFZXzLrEIjqSirqvJstoHKx65zciVnXCaCQuulqRzHW6W420e6pQP0cULKmp6/TIqx
         rgrRgL41JQ699JJ0tx/LeLmCChCua6Kbl39UY8f72Y12TQT13ZiYcwCstjgWYixFeOlJ
         PjHuXric8QDQUXbxKW53EOHUHJcaZDyyQ31EDtIHH11PYXdlUpIM9K4Y6vpjgo/wA/5R
         YtdKN5XS47bBAlcp+jOAlaC3XS+7ovpaP8Z5wEMXi8orEWCNLjdQlHYs47QcURL/V59w
         ZOAg==
X-Gm-Message-State: AOJu0YxHVVrQiTMYwbu2xctHsGqvdqayNt4yFff6qpkIZIEl8dt9mRRB
	75De2VLe8P1sRCQJiwTXu6hr6k56QL2nj0XdJ0RcsYVg
X-Google-Smtp-Source: AGHT+IGyAa6EQPOeSGD5pmMlXp7uYFZQq8ESfPAU9gQVDHlTP0xKE6wJmQACzvQt4+1TIlMneluLQcSwe+9usDiiAFk=
X-Received: by 2002:ac2:5f8b:0:b0:4fb:8ff2:f2d7 with SMTP id
 r11-20020ac25f8b000000b004fb8ff2f2d7mr6684880lfe.45.1692749109312; Tue, 22
 Aug 2023 17:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com> <04626310-a4c3-8192-9aee-11af5d692817@linux.dev>
 <5df1b876-9465-4de2-42d5-a59426d141aa@linux.dev>
In-Reply-To: <5df1b876-9465-4de2-42d5-a59426d141aa@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Aug 2023 17:04:57 -0700
Message-ID: <CAEf4BzZpMe1r43d3wyb78CHzxGYJbQkvGXgQaK0cD2JVsaa9hw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: David Marchevsky <david.marchevsky@linux.dev>
Cc: yonghong.song@linux.dev, Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, sdf@google.com, Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 12:20=E2=80=AFPM David Marchevsky
<david.marchevsky@linux.dev> wrote:
>
> On 8/22/23 1:42 PM, Yonghong Song wrote:
> >
> >
> > On 8/21/23 10:05 PM, Dave Marchevsky wrote:
> >> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allo=
w
> >> creation and manipulation of struct bpf_iter_task_vma in open-coded
> >> iterator style. BPF programs can use these kfuncs directly or through
> >> bpf_for_each macro for natural-looking iteration of all task vmas.
> >>
> >> The implementation borrows heavily from bpf_find_vma helper's locking =
-
> >> differing only in that it holds the mmap_read lock for all iterations
> >> while the helper only executes its provided callback on a maximum of 1
> >> vma. Aside from locking, struct vma_iterator and vma_next do all the
> >> heavy lifting.
> >>
> >> The newly-added struct bpf_iter_task_vma has a name collision with a
> >> selftest for the seq_file task_vma iter's bpf skel, so the selftests/b=
pf/progs
> >> file is renamed in order to avoid the collision.
> >>
> >> A pointer to an inner data struct, struct bpf_iter_task_vma_kern_data,=
 is the
> >> only field in struct bpf_iter_task_vma. This is because the inner data
> >> struct contains a struct vma_iterator (not ptr), whose size is likely =
to
> >> change under us. If bpf_iter_task_vma_kern contained vma_iterator dire=
ctly
> >> such a change would require change in opaque bpf_iter_task_vma struct'=
s
> >> size. So better to allocate vma_iterator using BPF allocator, and sinc=
e
> >> that alloc must already succeed, might as well allocate all iter field=
s,
> >> thereby freezing struct bpf_iter_task_vma size.
> >>
> >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >> Cc: Nathan Slingerland <slinger@meta.com>
> >> ---
> >>   include/uapi/linux/bpf.h                      |  4 +
> >>   kernel/bpf/helpers.c                          |  3 +
> >>   kernel/bpf/task_iter.c                        | 84 +++++++++++++++++=
++
> >>   tools/include/uapi/linux/bpf.h                |  4 +
> >>   tools/lib/bpf/bpf_helpers.h                   |  8 ++
> >>   .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
> >>   ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
> >>   7 files changed, 116 insertions(+), 13 deletions(-)
> >>   rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D> b=
pf_iter_task_vmas.c} (100%)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 8790b3962e4b..49fc1989a548 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -7311,4 +7311,8 @@ struct bpf_iter_num {
> >>       __u64 __opaque[1];
> >>   } __attribute__((aligned(8)));
> >>   +struct bpf_iter_task_vma {
> >> +    __u64 __opaque[1]; /* See bpf_iter_num comment above */
> >> +} __attribute__((aligned(8)));
> >
> > In the future, we might have bpf_iter_cgroup, bpf_iter_task, bpf_iter_c=
group_task, etc. They may all use the same struct
> > like
> >   struct bpf_iter_<...> {
> >     __u64 __opaque[1];
> >   } __attribute__((aligned(8)));
> >
> > Maybe we want a generic one instead of having lots of
> > structs with the same underline definition? For example,
> >   struct bpf_iter_generic
> > ?
> >
>
> The bpf_for_each macro assumes a consistent naming scheme for opaque iter=
 struct
> and associated kfuncs. Having a 'bpf_iter_generic' shared amongst multipl=
e types
> of iters would break the scheme. We could:
>
>   * Add bpf_for_each_generic that only uses bpf_iter_generic
>     * This exposes implementation details in an ugly way, though.
>   * Do some macro magic to pick bpf_iter_generic for some types of iters,=
 and
>     use consistent naming pattern for others.
>     * I'm not sure how to do this with preprocessor
>   * Migrate all opaque iter structs to only contain pointer to bpf_mem_al=
loc'd
>     data struct, and use bpf_iter_generic for all of them
>     * Probably need to see more iter implementation / usage before making=
 such
>       a change
>   * Do 'typedef __u64 __aligned(8) bpf_iter_<...>
>     * BTF_KIND_TYPEDEF intead of BTF_KIND_STRUCT might throw off some ver=
ifier
>       logic. Could do similar typedef w/ struct to try to work around
>       it.
>
> Let me know what you think. Personally I considered doing typedef while
> implementing this, so that's the alternative I'd choose.
>
> >> +
> >>   #endif /* _UAPI__LINUX_BPF_H__ */
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index eb91cae0612a..7a06dea749f1 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2482,6 +2482,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET=
_NULL)
> >>   BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> >>   BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> >>   BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL=
)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >> index c4ab9d6cdbe9..51c2dce435c1 100644
> >> --- a/kernel/bpf/task_iter.c
> >> +++ b/kernel/bpf/task_iter.c
> >> @@ -7,7 +7,9 @@
> >>   #include <linux/fs.h>
> >>   #include <linux/fdtable.h>
> >>   #include <linux/filter.h>
> >> +#include <linux/bpf_mem_alloc.h>
> >>   #include <linux/btf_ids.h>
> >> +#include <linux/mm_types.h>
> >>   #include "mmap_unlock_work.h"
> >>     static const char * const iter_task_type_names[] =3D {
> >> @@ -823,6 +825,88 @@ const struct bpf_func_proto bpf_find_vma_proto =
=3D {
> >>       .arg5_type    =3D ARG_ANYTHING,
> >>   };
> >>   +struct bpf_iter_task_vma_kern_data {
> >> +    struct task_struct *task;
> >> +    struct mm_struct *mm;
> >> +    struct mmap_unlock_irq_work *work;
> >> +    struct vma_iterator vmi;
> >> +};
> >> +
> >> +/* Non-opaque version of uapi bpf_iter_task_vma */
> >> +struct bpf_iter_task_vma_kern {
> >> +    struct bpf_iter_task_vma_kern_data *data;
> >> +} __attribute__((aligned(8)));
> >> +
> >> +__bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
> >> +                      struct task_struct *task, u64 addr)
> >> +{
> >> +    struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> >> +    bool irq_work_busy =3D false;
> >> +    int err;
> >> +
> >> +    BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeof(st=
ruct bpf_iter_task_vma));
> >> +    BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D __al=
ignof__(struct bpf_iter_task_vma));
> >> +
> >> +    /* is_iter_reg_valid_uninit guarantees that kit hasn't been initi=
alized
> >> +     * before, so non-NULL kit->data doesn't point to previously
> >> +     * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
> >> +     */
> >> +    kit->data =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_ite=
r_task_vma_kern_data));
> >> +    if (!kit->data)
> >> +        return -ENOMEM;
> >> +    kit->data->task =3D NULL;
> >> +
> >> +    if (!task) {
> >> +        err =3D -ENOENT;
> >> +        goto err_cleanup_iter;
> >> +    }
> >> +
> >> +    kit->data->task =3D get_task_struct(task);
> >
> > The above is not safe. Since there is no restriction on 'task',
> > the 'task' could be in a state for destruction with 'usage' count 0
> > and then get_task_struct(task) won't work since it unconditionally
> > tries to increase 'usage' count from 0 to 1.
> >
> > Or, 'task' may be valid at the entry of the funciton, but when
> > 'task' is in get_task_struct(), 'task' may have been destroyed
> > and 'task' memory is reused by somebody else.
> >
> > I suggest that we check input parameter 'task' must be
> > PTR_TRUSTED or MEM_RCU. This way, the above !task checking
> > is not necessary and get_task_struct() can correctly
> > hold a reference to 'task'.
> >
>
> Adding a PTR_TRUSTED or MEM_RCU check seems reasonable. I'm curious
> whether there's any way to feed a 'plain' struct task_struct PTR_TO_BTF_I=
D
> to this kfunc currently.
>
> * bpf_get_current_task_btf helper returns PTR_TRUSTED | PTR_TO_BTF_ID
> * ptr hop from trusted task_struct to 'real_parent' or similar should
>   yield MEM_RCU (due to BTF_TYPE_SAFE_RCU(struct task_struct) def
> * if task kptr is in map_val, direct reference to it should result
>   in PTR_UNTRUSTED PTR_TO_BTF_ID, must kptr_xchg it or acquire again
>   using bpf_task_from_pid (?)
>
> But regardless, better to be explicit. Will change.

How horrible would it be to base an interface on TID/PID (i.e., int)
as input argument to specify a task? I'm just thinking it might be
more generic and easy to use in more situations:
   - for all the cases where we have struct task_struct, getting its
pid is trivial: `task->pid`;
   - but in some situations PID might be coming from outside: either
as an argument to CLI tool, or from old-style tracepoint (e.g.,
context_switch where we have prev/next task pid), etc.

The downside is that we'd need to look up a task, right? But on the
other hand we get more generality and won't have to rely on having
PTR_TRUSTED task_struct.

Thoughts?

>
> >> +    kit->data->mm =3D task->mm;
> >> +    if (!kit->data->mm) {
> >> +        err =3D -ENOENT;
> >> +        goto err_cleanup_iter;
> >> +    }
> >> +
> >> +    /* kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock_get=
_irq_work */
> >> +    irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->data->work);
> >> +    if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
> >> +        err =3D -EBUSY;
> >> +        goto err_cleanup_iter;
> >> +    }
> >> +
> >> +    vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
> >> +    return 0;
> >> +
> >> +err_cleanup_iter:
> >> +    if (kit->data->task)
> >> +        put_task_struct(kit->data->task);
> >> +    bpf_mem_free(&bpf_global_ma, kit->data);
> >> +    /* NULL kit->data signals failed bpf_iter_task_vma initialization=
 */
> >> +    kit->data =3D NULL;
> >> +    return err;
> >> +}
> >> +
> > [...]

