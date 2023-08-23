Return-Path: <bpf+bounces-8391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45018785DF2
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60162810DA
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282F1F166;
	Wed, 23 Aug 2023 16:55:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36998C139
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 16:55:49 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A2AE5C
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 09:55:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5256d74dab9so7277261a12.1
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692809745; x=1693414545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaGL3Z8WpS5sngCKXwS44lnQu7USIL7RYwYYA7tk6Nk=;
        b=YHgF9R1QGkGMs5wcJiAna2YsvcMKu5aH2pRVLQKpxgVSuFlZNG0YndYSL/0eqxRAs4
         4AXMTigyoOeolNeW7bJ73cZPjHZQYifqXNPGfuUntDVNjz1dRgVJ7mq270ckovi039VC
         bCXHY4vMsRoJikvhmntvNLerCBT40Ed3wKI1IPwLuFBayfKaeni5EbrNvKGB+lw9+c52
         EXftikPwCbCg5Iz0jULlEfNkC131csah/08mblqb6iUK1a3zTc3ESi6KbfUGGxqJ7rTe
         2yBmtYDThNK062akk+95yBz832vHN/oe+30IAUSFDWNKAvzgpdCK7cLVXbOt0aexlPi5
         4iAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692809745; x=1693414545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaGL3Z8WpS5sngCKXwS44lnQu7USIL7RYwYYA7tk6Nk=;
        b=WaVpaOEVPb+Fyfw2aXiTWXuIwVqhuCjp7csqFA/MFRUAVW7tSA+y8a5IFry+Tpg6eu
         YVCIxEz2hro2C1RQBzxWZUnyjJ4bGCv+vlQL7LLR57q4sQbtuEgEcalZaZxqFtAF9r4K
         O53OPlI9fKWoYBEsYUPAWzb0IP2FjEivjaB9FeuaJZK7hPISSgCJ7fTOEjsZxeDN0rhS
         lDafW7YYwt1igRCMFDSQX71k6c8Hs8pecORBJL5A8gnFLeplFW/tRRNddbfiwGx1ZTsf
         14mp5zy/Thz8+LghI1gWsuh2J2SZHW6pecrGJogI0xTUEF9ALtBS1RD473UZDXlW3ccT
         vMSg==
X-Gm-Message-State: AOJu0YxY8p12GLXHWmI77k0NwkqkIYL2m7W6W/9uv2c3WaiwprCzje5g
	+1uFah4chTXnhcxVo1+/aiP+Jh2trXf7hkbxfz0cHovh4fw=
X-Google-Smtp-Source: AGHT+IFULkc5BXsri5q+2U8YMRSKq8E2hAYj4X+BmvL2eslJGib7DEZc9vVLoXGdnLeIGWc8+q+jCTjZ9TiRAqSehgk=
X-Received: by 2002:a05:6402:1610:b0:525:5886:2f69 with SMTP id
 f16-20020a056402161000b0052558862f69mr10990595edv.36.1692809745193; Wed, 23
 Aug 2023 09:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com> <04626310-a4c3-8192-9aee-11af5d692817@linux.dev>
 <5df1b876-9465-4de2-42d5-a59426d141aa@linux.dev> <CAEf4BzZpMe1r43d3wyb78CHzxGYJbQkvGXgQaK0cD2JVsaa9hw@mail.gmail.com>
 <0298d7c3-2c49-b1a8-8d16-7a261405aaff@linux.dev> <CAADnVQKAGXvKV7AZdrqy-6SHs_cN40P-KLh31jduBGB-noNmMw@mail.gmail.com>
In-Reply-To: <CAADnVQKAGXvKV7AZdrqy-6SHs_cN40P-KLh31jduBGB-noNmMw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Aug 2023 09:55:33 -0700
Message-ID: <CAEf4BzZsR_Cz7GbA_HmRfhPfL_3Ysmzzh7+46AF=38D=PhJ9hA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Marchevsky <david.marchevsky@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Stanislav Fomichev <sdf@google.com>, 
	Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 7:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 22, 2023 at 10:42=E2=80=AFPM David Marchevsky
> <david.marchevsky@linux.dev> wrote:
> >
> > On 8/22/23 8:04 PM, Andrii Nakryiko wrote:
> > > On Tue, Aug 22, 2023 at 12:20=E2=80=AFPM David Marchevsky
> > > <david.marchevsky@linux.dev> wrote:
> > >>
> > >> On 8/22/23 1:42 PM, Yonghong Song wrote:
> > >>>
> > >>>
> > >>> On 8/21/23 10:05 PM, Dave Marchevsky wrote:
> > >>>> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which =
allow
> > >>>> creation and manipulation of struct bpf_iter_task_vma in open-code=
d
> > >>>> iterator style. BPF programs can use these kfuncs directly or thro=
ugh
> > >>>> bpf_for_each macro for natural-looking iteration of all task vmas.
> > >>>>
> > >>>> The implementation borrows heavily from bpf_find_vma helper's lock=
ing -
> > >>>> differing only in that it holds the mmap_read lock for all iterati=
ons
> > >>>> while the helper only executes its provided callback on a maximum =
of 1
> > >>>> vma. Aside from locking, struct vma_iterator and vma_next do all t=
he
> > >>>> heavy lifting.
> > >>>>
> > >>>> The newly-added struct bpf_iter_task_vma has a name collision with=
 a
> > >>>> selftest for the seq_file task_vma iter's bpf skel, so the selftes=
ts/bpf/progs
> > >>>> file is renamed in order to avoid the collision.
> > >>>>
> > >>>> A pointer to an inner data struct, struct bpf_iter_task_vma_kern_d=
ata, is the
> > >>>> only field in struct bpf_iter_task_vma. This is because the inner =
data
> > >>>> struct contains a struct vma_iterator (not ptr), whose size is lik=
ely to
> > >>>> change under us. If bpf_iter_task_vma_kern contained vma_iterator =
directly
> > >>>> such a change would require change in opaque bpf_iter_task_vma str=
uct's
> > >>>> size. So better to allocate vma_iterator using BPF allocator, and =
since
> > >>>> that alloc must already succeed, might as well allocate all iter f=
ields,
> > >>>> thereby freezing struct bpf_iter_task_vma size.
> > >>>>
> > >>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > >>>> Cc: Nathan Slingerland <slinger@meta.com>
> > >>>> ---
> > >>>>   include/uapi/linux/bpf.h                      |  4 +
> > >>>>   kernel/bpf/helpers.c                          |  3 +
> > >>>>   kernel/bpf/task_iter.c                        | 84 +++++++++++++=
++++++
> > >>>>   tools/include/uapi/linux/bpf.h                |  4 +
> > >>>>   tools/lib/bpf/bpf_helpers.h                   |  8 ++
> > >>>>   .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
> > >>>>   ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
> > >>>>   7 files changed, 116 insertions(+), 13 deletions(-)
> > >>>>   rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =
=3D> bpf_iter_task_vmas.c} (100%)
> > >>>>
> > >>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > >>>> index 8790b3962e4b..49fc1989a548 100644
> > >>>> --- a/include/uapi/linux/bpf.h
> > >>>> +++ b/include/uapi/linux/bpf.h
> > >>>> @@ -7311,4 +7311,8 @@ struct bpf_iter_num {
> > >>>>       __u64 __opaque[1];
> > >>>>   } __attribute__((aligned(8)));
> > >>>>   +struct bpf_iter_task_vma {
> > >>>> +    __u64 __opaque[1]; /* See bpf_iter_num comment above */
> > >>>> +} __attribute__((aligned(8)));
> > >>>
> > >>> In the future, we might have bpf_iter_cgroup, bpf_iter_task, bpf_it=
er_cgroup_task, etc. They may all use the same struct
> > >>> like
> > >>>   struct bpf_iter_<...> {
> > >>>     __u64 __opaque[1];
> > >>>   } __attribute__((aligned(8)));
> > >>>
> > >>> Maybe we want a generic one instead of having lots of
> > >>> structs with the same underline definition? For example,
> > >>>   struct bpf_iter_generic
> > >>> ?
> > >>>
> > >>
> > >> The bpf_for_each macro assumes a consistent naming scheme for opaque=
 iter struct
> > >> and associated kfuncs. Having a 'bpf_iter_generic' shared amongst mu=
ltiple types
> > >> of iters would break the scheme. We could:
> > >>
> > >>   * Add bpf_for_each_generic that only uses bpf_iter_generic
> > >>     * This exposes implementation details in an ugly way, though.
> > >>   * Do some macro magic to pick bpf_iter_generic for some types of i=
ters, and
> > >>     use consistent naming pattern for others.
> > >>     * I'm not sure how to do this with preprocessor
> > >>   * Migrate all opaque iter structs to only contain pointer to bpf_m=
em_alloc'd
> > >>     data struct, and use bpf_iter_generic for all of them
> > >>     * Probably need to see more iter implementation / usage before m=
aking such
> > >>       a change
> > >>   * Do 'typedef __u64 __aligned(8) bpf_iter_<...>
> > >>     * BTF_KIND_TYPEDEF intead of BTF_KIND_STRUCT might throw off som=
e verifier
> > >>       logic. Could do similar typedef w/ struct to try to work aroun=
d
> > >>       it.
> > >>
> > >> Let me know what you think. Personally I considered doing typedef wh=
ile
> > >> implementing this, so that's the alternative I'd choose.
> > >>
> > >>>> +
> > >>>>   #endif /* _UAPI__LINUX_BPF_H__ */
> > >>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > >>>> index eb91cae0612a..7a06dea749f1 100644
> > >>>> --- a/kernel/bpf/helpers.c
> > >>>> +++ b/kernel/bpf/helpers.c
> > >>>> @@ -2482,6 +2482,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF=
_RET_NULL)
> > >>>>   BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> > >>>>   BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL=
)
> > >>>>   BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > >>>> +BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW)
> > >>>> +BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_=
NULL)
> > >>>> +BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
> > >>>>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> > >>>>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> > >>>>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> > >>>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > >>>> index c4ab9d6cdbe9..51c2dce435c1 100644
> > >>>> --- a/kernel/bpf/task_iter.c
> > >>>> +++ b/kernel/bpf/task_iter.c
> > >>>> @@ -7,7 +7,9 @@
> > >>>>   #include <linux/fs.h>
> > >>>>   #include <linux/fdtable.h>
> > >>>>   #include <linux/filter.h>
> > >>>> +#include <linux/bpf_mem_alloc.h>
> > >>>>   #include <linux/btf_ids.h>
> > >>>> +#include <linux/mm_types.h>
> > >>>>   #include "mmap_unlock_work.h"
> > >>>>     static const char * const iter_task_type_names[] =3D {
> > >>>> @@ -823,6 +825,88 @@ const struct bpf_func_proto bpf_find_vma_prot=
o =3D {
> > >>>>       .arg5_type    =3D ARG_ANYTHING,
> > >>>>   };
> > >>>>   +struct bpf_iter_task_vma_kern_data {
> > >>>> +    struct task_struct *task;
> > >>>> +    struct mm_struct *mm;
> > >>>> +    struct mmap_unlock_irq_work *work;
> > >>>> +    struct vma_iterator vmi;
> > >>>> +};
> > >>>> +
> > >>>> +/* Non-opaque version of uapi bpf_iter_task_vma */
> > >>>> +struct bpf_iter_task_vma_kern {
> > >>>> +    struct bpf_iter_task_vma_kern_data *data;
> > >>>> +} __attribute__((aligned(8)));
> > >>>> +
> > >>>> +__bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *i=
t,
> > >>>> +                      struct task_struct *task, u64 addr)
> > >>>> +{
> > >>>> +    struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > >>>> +    bool irq_work_busy =3D false;
> > >>>> +    int err;
> > >>>> +
> > >>>> +    BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeo=
f(struct bpf_iter_task_vma));
> > >>>> +    BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D =
__alignof__(struct bpf_iter_task_vma));
> > >>>> +
> > >>>> +    /* is_iter_reg_valid_uninit guarantees that kit hasn't been i=
nitialized
> > >>>> +     * before, so non-NULL kit->data doesn't point to previously
> > >>>> +     * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
> > >>>> +     */
> > >>>> +    kit->data =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf=
_iter_task_vma_kern_data));
> > >>>> +    if (!kit->data)
> > >>>> +        return -ENOMEM;
> > >>>> +    kit->data->task =3D NULL;
> > >>>> +
> > >>>> +    if (!task) {
> > >>>> +        err =3D -ENOENT;
> > >>>> +        goto err_cleanup_iter;
> > >>>> +    }
> > >>>> +
> > >>>> +    kit->data->task =3D get_task_struct(task);
> > >>>
> > >>> The above is not safe. Since there is no restriction on 'task',
> > >>> the 'task' could be in a state for destruction with 'usage' count 0
> > >>> and then get_task_struct(task) won't work since it unconditionally
> > >>> tries to increase 'usage' count from 0 to 1.
> > >>>
> > >>> Or, 'task' may be valid at the entry of the funciton, but when
> > >>> 'task' is in get_task_struct(), 'task' may have been destroyed
> > >>> and 'task' memory is reused by somebody else.
> > >>>
> > >>> I suggest that we check input parameter 'task' must be
> > >>> PTR_TRUSTED or MEM_RCU. This way, the above !task checking
> > >>> is not necessary and get_task_struct() can correctly
> > >>> hold a reference to 'task'.
> > >>>
> > >>
> > >> Adding a PTR_TRUSTED or MEM_RCU check seems reasonable. I'm curious
> > >> whether there's any way to feed a 'plain' struct task_struct PTR_TO_=
BTF_ID
> > >> to this kfunc currently.
> > >>
> > >> * bpf_get_current_task_btf helper returns PTR_TRUSTED | PTR_TO_BTF_I=
D
> > >> * ptr hop from trusted task_struct to 'real_parent' or similar shoul=
d
> > >>   yield MEM_RCU (due to BTF_TYPE_SAFE_RCU(struct task_struct) def
> > >> * if task kptr is in map_val, direct reference to it should result
> > >>   in PTR_UNTRUSTED PTR_TO_BTF_ID, must kptr_xchg it or acquire again
> > >>   using bpf_task_from_pid (?)
> > >>
> > >> But regardless, better to be explicit. Will change.
> > >
> > > How horrible would it be to base an interface on TID/PID (i.e., int)
> > > as input argument to specify a task? I'm just thinking it might be
> > > more generic and easy to use in more situations:
> > >    - for all the cases where we have struct task_struct, getting its
> > > pid is trivial: `task->pid`;
> > >    - but in some situations PID might be coming from outside: either
> > > as an argument to CLI tool, or from old-style tracepoint (e.g.,
> > > context_switch where we have prev/next task pid), etc.
> > >
> > > The downside is that we'd need to look up a task, right? But on the
> > > other hand we get more generality and won't have to rely on having
> > > PTR_TRUSTED task_struct.
> > >
> > > Thoughts?
> > >
> >
> > Meh, taking tid here feels like the 'old-school' approach, before recen=
t
> > efforts to teach the verifier more about resource acquisition, locking,
> > iteration, trustedness, etc. All allowing us to push more important log=
ic
> > out of 'opaque' helper impl and into BPF programs.
> >
> > In this tid -> struct task_struct case I think the provided resource ac=
quisition
> > is sufficient. Using your examples:
> >
> >   * We have a TRUSTED or RCU struct task_struct
> >     * No need to do anything, can pass to bpf_iter_task_vma_new
> >
> >   * We have a struct task_struct, but it's UNTRUSTED or has no trustedn=
ess
> >     type flags
> >     * Use bpf_task_acquire or bpf_task_from_pid
> >
> >   * We just have a pid ('coming from outside')
> >     * Use bpf_task_from_pid
> >
> > If there is some scenario where we can't get from pid to properly acqui=
red task
> > in the BPF program, let's improve the resource acquisition instead of p=
ushing
> > it into the kfunc impl.
> >
> > Also, should we look up (and refcount incr) the task using task->rcu_us=
ers
> > refcount w/ bpf_task_{acquire,release}, or using task->usage refcount w=
/
> > {get,put}_task_struct ? More generally, if there are >1 valid ways to a=
cquire
> > task_struct or some other resource, pushing acquisition to the BPF prog=
ram
> > gives us the benefit of not having to pick one (or do possibly ugly / c=
omplex
> > flags). As long as type flags express that the resource will not go awa=
y,
> > this kfunc impl can ignore the details of how that property came about.
>
> Agree with above reasoning. pid->task should be separate set of kfunc.
> It's not a trivial task either. there are pid namespaces. there is u32 pi=
d
> and there is 'struct pid'. u32_pid->struct_pid->task has to be designed f=
irst.
> Probably in some case the trusted task pointer is ready to be accessed,
> but context could be such that pid->task cannot be done.

makes sense, having bpf_task_from_pid() removes my concerns, I forgot about=
 it.

