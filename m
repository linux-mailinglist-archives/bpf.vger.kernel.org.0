Return-Path: <bpf+bounces-10417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA907A6F6C
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 01:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D4F1C209D1
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B938BBD;
	Tue, 19 Sep 2023 23:30:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752F347AE
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 23:30:25 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C61FC0;
	Tue, 19 Sep 2023 16:30:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b974031aeaso102512701fa.0;
        Tue, 19 Sep 2023 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695166221; x=1695771021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfCHX0NYadHxilWRiPDE43IPqx1RrnQk5fFi8TttVsI=;
        b=eF5j9sjQG4s3T4YyVlqfzD6uHAY1huKZ/45XnfSp4EE9ofCEgAoJ0mI6XpZwz5aDyR
         dujUXWtNoHoMDoHl+WxOZml3z5k4hcesih9XrLqw6GCXRs5FIXbo76AG4MP+EnbkSaWm
         p1ik3LWczF/UwW3oYUzh9MV9uJIKRASOUHn5jHlz0wzwMFTnvPBhb58lyOQX6L0TPHI+
         znaolvIi01a91oJHxUIPhpIG98cFzDxbY8wZfHCBt3VdZj3IP3zW6ZtBI8yGPGBBPQrH
         As8jAPwrE7zJh75IW7A6dUudgBIy93Tkg09NIofeFcrUnPPNhEilue2mHhPuCWsGqcni
         w8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695166221; x=1695771021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfCHX0NYadHxilWRiPDE43IPqx1RrnQk5fFi8TttVsI=;
        b=lgnkXB5NEX3Arz4Y7xOxw17/j3hQjADy0fARXvdWp0RP+Ba49lz+hj850HrikFTlSj
         243aIhTy80/pAmyUptauO7xYAYPc83UXsbKcAP0BYew5PDSH5OWnNeZ9J8Rn8gX0askB
         vLG4m/5SpFDRdMb+MtMTHUDTTDv+vM0I3QYlJ6/8eXnhSWC6voCngVDrM2flAi4PY5la
         RtdypoFpfWNVIuiPOF7RCJUPPtixGnj5/iPDyp3X42MmNGFA2blIQVNfvQTYfxgVNq9m
         80599xt+bb9+j3MK7j+CKYB4sOAGsyy4hdtaKS1lFI7XaWzmP1GlUwACUCyOnhXi960T
         Jrtw==
X-Gm-Message-State: AOJu0YwBfdM+PGbHSy3MtRch5dZouWrSAjJDtRB7r5w4hGcvo6rhgBmn
	C44lJmS442PwU3O5uFqRX7cHF30gAdsfQciEGv+eDYwSS+M=
X-Google-Smtp-Source: AGHT+IFGACrAVAK03DuUwFxSX+3ZPHucjR0l6zN0wX+RypeyDYKs86DLEgPEGJCSUTysEq4UamOQnk0uEQG5LeS2dQ0=
X-Received: by 2002:a2e:b616:0:b0:2ba:18e5:1063 with SMTP id
 r22-20020a2eb616000000b002ba18e51063mr616019ljn.50.1695166221039; Tue, 19 Sep
 2023 16:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-4-zhouchuyi@bytedance.com> <CAEf4BzbsBUGiPJ+_RG3c3WdEWNQy2b6h60kLDREcXDsNp3E0_Q@mail.gmail.com>
 <30eadbff-8340-a721-362b-ff82de03cb9f@bytedance.com> <CAEf4BzbM=v9KNtQQNcUSRs7mwwKa7FEsBFXO3T1+7KgpZVZKFw@mail.gmail.com>
 <67d07ab7-8202-4bbd-88d9-587707bd58b1@bytedance.com>
In-Reply-To: <67d07ab7-8202-4bbd-88d9-587707bd58b1@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Sep 2023 16:30:09 -0700
Message-ID: <CAEf4Bzb_hMRbDU_0ibpzsf4eZ3mR4D=0SLu9E2dLHsP8=-ALiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Introduce process open coded
 iterator kfuncs
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 7:03=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> Hello.
>
> =E5=9C=A8 2023/9/16 04:37, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Fri, Sep 15, 2023 at 8:03=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance=
.com> wrote:
> >> =E5=9C=A8 2023/9/15 07:26, Andrii Nakryiko =E5=86=99=E9=81=93:
> >>> On Tue, Sep 12, 2023 at 12:02=E2=80=AFAM Chuyi Zhou <zhouchuyi@byteda=
nce.com> wrote:
> >>>>
> >>>> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which all=
ow
> >>>> creation and manipulation of struct bpf_iter_process in open-coded i=
terator
> >>>> style. BPF programs can use these kfuncs or through bpf_for_each mac=
ro to
> >>>> iterate all processes in the system.
> >>>>
> [...cut...]
> >>>
> >>> Few high level thoughts. I think it would be good to follow
> >>> SEC("iter/task") naming and approach. Open-coded iterators in many
> >>> ways are in-kernel counterpart to iterator programs, so keeping them
> >>> close enough within reason is useful for knowledge transfer.
> >>>
> >>> SEC("iter/task") allows to:
> >>> a) iterate all threads in the system
> >>> b) iterate all threads for a given TGID
> >>> c) it also allows to "iterate" a single thread or process, but that's
> >>> a bit less relevant for in-kernel iterator, but we can still support
> >>> them, why not?
> >>>
> >>> I'm not sure if it supports iterating all processes (as in group
> >>> leaders of each task group) in the system, but if it's possible I
> >>> think we should support it at least for open-coded iterator, seems
> >>> like a very useful functionality.
> >>>
> >>> So to that end, let's design a small set of input arguments for
> >>> bpf_iter_process_new() that would allow to specify this as flags +
> >>> either (optional) struct task_struct * pointer to represent
> >>> task/process or PID/TGID.
> >>>
> >>
> >> Another concern from Alexei was the readability of the API of open-cod=
ed
> >> in BPF Program[1].
> >>
> >> bpf_for_each(task, curr) is straightforward. Users can easily understa=
nd
> >> that this API does the same thing as 'for_each_process' in kernel.
> >
> > In general, users might have no idea about for_each_process macro in
> > the kernel, so I don't find this particular argument very convincing.
> >
> > We can add a separate set of iterator kfuncs for every useful
> > combination of conditions, of course, but it's a double-edged sword.
> > Needing to use a different iterator just to specify a different
> > direction of cgroup iteration (from the example you referred in [1])
> > also means that it's now harder to write some generic function that
> > needs to do something for all cgroups matching some criteria where the
> > order might be coming as an argument.
> >
> > Similarly for task iterators. It's not hard to imagine some processing
> > that can be equivalently done per thread or per process in the system,
> > or on each thread of the process, depending on some conditions or
> > external configuration. Having to do three different
> > bpf_for_each(task_xxx, task, ...) for this seems suboptimal. If the
> > nature of the thing that is iterated over is the same, and it's just a
> > different set of filters to specify which subset of those items should
> > be iterated, I think it's better to try to stick to the same iterator
> > with few simple arguments. IMO, of course, there is no objectively
> > best approach.
> >
> >>
> >> However, if we keep the approach of SEC("iter/task")
> >>
> >> enum ITER_ITEM {
> >>          ITER_TASK,
> >>          ITER_THREAD,
> >> }
> >>
> >> __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_process *it, struct
> >> task_struct *group_task, enum ITER_ITEM type)
> >>
> >> the API have to chang:
> >>
> >>
> >> bpf_for_each(task, curr, NULL, ITERATE_TASK) // iterate all process in
> >> the  system
> >> bpf_for_each(task, curr, group_leader, ITERATE_THREAD) // iterate all
> >> thread of group_leader
> >> bpf_for_each(task, curr, NULL, ITERATE_THREAD) //iterate all threads o=
f
> >> all the process in the system
> >>
> >> Useres may guess what are this API actually doing....
> >
> > I'd expect users to consult documentation before trying to use an
> > unfamiliar cutting-edge functionality. So let's try to keep
> > documentation clear and up to the point. Extra flag argument doesn't
> > seem to be a big deal.
>
> Thanks for your suggestion!
>
> Before we begin working on the next version, I have outlined a detailed
> API design here:
>
> 1.task_iter
>
> It will be used to iterate process/threads like SEC("iter/task"). Here
> we should better to follow the naming and approach SEC("iter/task"):
>
> enum {
>         ITERATE_PROCESS,
>         ITERATE_THREAD,
> }
>
> __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct
> task_struct *task, int flag);
>
> If we want to iterate all processes in the system, the iteration will
> start from the *task* which is passed from user.(since process in the
> system are connected through a linked list)

but will go through all of them anyways, right? it's kind of
surprising from usability standpoint to have to pass some task_struct
to iterate all of them, tbh. I wonder if it's hard to adjust kfunc
validation to allow "nullable" pointers? We can look at that
separately, of course.

>
> Additionally, the *task* can allow users to specify iterating all
> threads within a task group.
>
> SEC("xxx")
> int xxxx(void *ctx)
> {
>         struct task_struct *pos;
>         struct task_struct *cur_task =3D bpf_get_current_task_btf();
>
>         bpf_rcu_read_lock();
>
>         // iterating all process in the system start from cur_task
>         bpf_for_each(task, pos, cur_task, ITERATE_PROCESS) {
>
>         }
>
>         // iterate all thread belongs to cur_task group.
>         bpf_for_each(task, pos, cur_task, ITERATE_THREAD) {
>
>         }
>
>         bpf_rcu_read_unlock();
>         return 0;
> }
>
> Iterating all thread of each process is great=EF=BC=88ITERATE_ALL=EF=BC=
=89. But maybe
> let's break it down step by step and implement
> ITERATE_PROCESS/ITERATE_THREAD first? (I'm little worried about the cpu
> overhead of ITERATE_ALL, since we are doing a heavy job in BPF Prog)
>

Hm... but if it was a sleepable BPF program and
bpf_rcu_read_{lock,unlock}() was only per task, then it shouldn't be
the problem? See enum bpf_cgroup_iter_order.


> I wanted to reuse BPF_TASK_ITER_ALL/BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID
> insted of new enums like ITERATE_PROCESS/ITERATE_THREAD. But it seems
> necessary. In BPF Prog, we usually operate task_struct directly instead
> of pid/tgid. It's a little weird to use
> BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID here:

enum bpf_iter_task_type is internal type, so we can rename
BPF_TASK_ITER_TID to BPF_TASK_ITER_THREAD and BPF_TASK_ITER_PROC (or
add them as aliases). At the very least, we should use consistent
BPF_TASK_ITER_xxx naming, instead of just ITERATE_PROCESS. See

>
> bpf_for_each(task, pos, cur_task, BPF_TASK_ITER_TID) {
> }
>
> On the other hand,
> BPF_TASK_ITER_ALL/BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID are inner flags
> that are hidden from the users.
> Exposing ITERATE_PROCESS/ITERATE_THREAD will not cause confusion to user.
>

inner types are not a problem when used with vmlinux.h


>
> 2. css_iter.
>
> css_iter will be used to:
> (1) iterating subsystem, like
> for_each_mem_cgroup_tree/cpuset_for_each_descendant_pre in kernel.
> (2) iterating cgroup. (patch-6's selfetest has a basic example)
>
> css(cgroup_subsys_state) is more fundamental than struct cgroup. I think
> we'd better operating css rather than cgroup, since it's can be hard for
> cgroup_iter to achive (2). So here we keep the name of "css_iter",
> BPF_CGROUP_ITER_DESCENDANTS_PRE/BPF_CGROUP_ITER_DESCENDANTS_POST/BPF_CGRO=
UP_ITER_ANCESTORS_UP
> can be reused.
>
>
> __bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
>                 struct cgroup_subsys_state *root, unsigned int flag)
>
> bpf_for_each(css, root, BPF_CGROUP_ITER_DESCENDANTS_PRE)
>

Makes sense, yep, thanks.

> Thanks.
>
>
>
>

