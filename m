Return-Path: <bpf+bounces-11141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F47B3BF5
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 23:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id CC9BCB20C3D
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 21:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633796728B;
	Fri, 29 Sep 2023 21:28:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED46669B
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 21:28:08 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2861AE;
	Fri, 29 Sep 2023 14:28:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so3378128a12.0;
        Fri, 29 Sep 2023 14:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696022883; x=1696627683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFB880WFfAT1mE8fTY1Tk7q4pn0pdzGGYYQg292yYHc=;
        b=Lf2S+N0F270sl06RrXOtmdZBLi+Q9BnF2HVf2YZdYyjLhFAga3BzPChJb4WtZF8SV9
         K+cFllxykt1QFGQDwa0Gdx8LkuIW/Pl/omj1V8UAXfxrdNeHmtlzOvQiGO5b6PV/kK8R
         dxinPbNTAYq5E9t/cFyiGu9Abr10ZunvWUhaflRRWTnT+l++XD92zXAkvnExq3xxrwtq
         pgkaQsmSLgvUqbVi6Gg8/V1u4N+Z7abepqnibguvJmz7aLgK+kLfU5fxNRHjWu1DXY9S
         9cBJzx1P8GdH+QUbV+kSOWrWhEmibiFkwX0DPHVJgzhuU8J+4OYsx2PpQADpvU2UYw6H
         jx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696022883; x=1696627683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFB880WFfAT1mE8fTY1Tk7q4pn0pdzGGYYQg292yYHc=;
        b=Wg7Et5QeYQKkD4fqlxNYPulOORx5WOJjNJDEEGXBPGRWtWJX7hEsY6K9of+GWECgFx
         erz/21o4u+kzszWr5Zsc1WgbakIBBDyg1/iDckwCD0DwuAUzLwAx6Lu0lmeDBY+VXPyE
         xjj1p9lQPhtZKX06XaayKxOdWkxy7x23X6ShHApSRMq4E9H0Ux2fw+GQYRdth9uCO84F
         ei2xSqYbWtSEe5Q4r9woavVUoyv4Y1o4HgYR8M043Xgo9hB1HoLeSe+cTkmKDbtxGsLB
         hQhin6ZrJzx8KlgBhlEq4Or4CLYti3gPF2MvUAyfZ/BifxZfwLRc+JicqW4OCAWhwnoW
         EAlg==
X-Gm-Message-State: AOJu0Yz9YKTR4F5dM83JicRU/NqeFr0NxMLwbBhL5ff472uWRvjDxX7y
	1lfms4UvA4nLFrzpSWX+BvHAHVD0fcXK1BB+Djkjmuub
X-Google-Smtp-Source: AGHT+IGe1LZTz4nPtka4gm/86vPqXkgWm5tedG37Vfmb6/QS7KHZ8pZnFnSEcHFj9ceoQZ94ER0YTChbK6B5UnOQYDM=
X-Received: by 2002:aa7:c598:0:b0:531:3c4e:98bc with SMTP id
 g24-20020aa7c598000000b005313c4e98bcmr4751473edq.8.1696022883065; Fri, 29 Sep
 2023 14:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
 <20230925105552.817513-4-zhouchuyi@bytedance.com> <CAEf4BzZFBFPMBs6t4GM7GRt-c-Po9KkQqxQ_Zo9vuG=KuqeLzQ@mail.gmail.com>
 <716adfa5-bd5d-3fe2-108c-ff24b2e81420@bytedance.com>
In-Reply-To: <716adfa5-bd5d-3fe2-108c-ff24b2e81420@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Sep 2023 14:27:51 -0700
Message-ID: <CAEf4BzaAtybx=Cbb6zD1otgQ-Jm+Xta0_8rwmL_ZYb3GzjSwWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] bpf: Introduce task open coded iterator kfuncs
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 8:29=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> Hello,
>
> =E5=9C=A8 2023/9/28 07:20, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Mon, Sep 25, 2023 at 3:56=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance=
.com> wrote:
> >>
> >> This patch adds kfuncs bpf_iter_task_{new,next,destroy} which allow
> >> creation and manipulation of struct bpf_iter_task in open-coded iterat=
or
> >> style. BPF programs can use these kfuncs or through bpf_for_each macro=
 to
> >> iterate all processes in the system.
> >>
> >> The API design keep consistent with SEC("iter/task"). bpf_iter_task_ne=
w()
> >> accepts a specific task and iterating type which allows:
> >> 1. iterating all process in the system
> >>
> >> 2. iterating all threads in the system
> >>
> >> 3. iterating all threads of a specific task
> >> Here we also resuse enum bpf_iter_task_type and rename BPF_TASK_ITER_T=
ID
> >> to BPF_TASK_ITER_THREAD, rename BPF_TASK_ITER_TGID to BPF_TASK_ITER_PR=
OC.
> >>
> >> The newly-added struct bpf_iter_task has a name collision with a selft=
est
> >> for the seq_file task iter's bpf skel, so the selftests/bpf/progs file=
 is
> >> renamed in order to avoid the collision.
> >>
> >> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> >> ---
> >>   include/linux/bpf.h                           |  8 +-
> >>   kernel/bpf/helpers.c                          |  3 +
> >>   kernel/bpf/task_iter.c                        | 96 ++++++++++++++++-=
--
> >>   .../testing/selftests/bpf/bpf_experimental.h  |  5 +
> >>   .../selftests/bpf/prog_tests/bpf_iter.c       | 18 ++--
> >>   .../{bpf_iter_task.c =3D> bpf_iter_tasks.c}     |  0
> >>   6 files changed, 106 insertions(+), 24 deletions(-)
> >>   rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c =3D> bpf_i=
ter_tasks.c} (100%)
> >>
> >
> > [...]
> >
> >> @@ -692,9 +692,9 @@ static int bpf_iter_fill_link_info(const struct bp=
f_iter_aux_info *aux, struct b
> >>   static void bpf_iter_task_show_fdinfo(const struct bpf_iter_aux_info=
 *aux, struct seq_file *seq)
> >>   {
> >>          seq_printf(seq, "task_type:\t%s\n", iter_task_type_names[aux-=
>task.type]);
> >> -       if (aux->task.type =3D=3D BPF_TASK_ITER_TID)
> >> +       if (aux->task.type =3D=3D BPF_TASK_ITER_THREAD)
> >>                  seq_printf(seq, "tid:\t%u\n", aux->task.pid);
> >> -       else if (aux->task.type =3D=3D BPF_TASK_ITER_TGID)
> >> +       else if (aux->task.type =3D=3D BPF_TASK_ITER_PROC)
> >>                  seq_printf(seq, "pid:\t%u\n", aux->task.pid);
> >>   }
> >>
> >> @@ -856,6 +856,80 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct=
 bpf_iter_css_task *it)
> >>          bpf_mem_free(&bpf_global_ma, kit->css_it);
> >>   }
> >>
> >> +struct bpf_iter_task {
> >> +       __u64 __opaque[2];
> >> +       __u32 __opaque_int[1];
> >
> > this should be __u64 __opaque[3], because struct takes full 24 bytes
> >
> >> +} __attribute__((aligned(8)));
> >> +
> >> +struct bpf_iter_task_kern {
> >> +       struct task_struct *task;
> >> +       struct task_struct *pos;
> >> +       unsigned int type;
> >> +} __attribute__((aligned(8)));
> >> +
> >> +__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct ta=
sk_struct *task, unsigned int type)
> >
> > nit: type -> flags, so we can add a bit more stuff, if necessary
> >
> >> +{
> >> +       struct bpf_iter_task_kern *kit =3D (void *)it;
> >
> > empty line after variable declarations
> >
> >> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) !=3D sizeof(str=
uct bpf_iter_task));
> >> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=3D
> >> +                                       __alignof__(struct bpf_iter_ta=
sk));
> >
> > and I'd add empty line here to keep BUILD_BUG_ON block separate
> >
> >> +       kit->task =3D kit->pos =3D NULL;
> >> +       switch (type) {
> >> +       case BPF_TASK_ITER_ALL:
> >> +       case BPF_TASK_ITER_PROC:
> >> +       case BPF_TASK_ITER_THREAD:
> >> +               break;
> >> +       default:
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (type =3D=3D BPF_TASK_ITER_THREAD)
> >> +               kit->task =3D task;
> >> +       else
> >> +               kit->task =3D &init_task;
> >> +       kit->pos =3D kit->task;
> >> +       kit->type =3D type;
> >> +       return 0;
> >> +}
> >> +
> >> +__bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_ta=
sk *it)
> >> +{
> >> +       struct bpf_iter_task_kern *kit =3D (void *)it;
> >> +       struct task_struct *pos;
> >> +       unsigned int type;
> >> +
> >> +       type =3D kit->type;
> >> +       pos =3D kit->pos;
> >> +
> >> +       if (!pos)
> >> +               goto out;
> >> +
> >> +       if (type =3D=3D BPF_TASK_ITER_PROC)
> >> +               goto get_next_task;
> >> +
> >> +       kit->pos =3D next_thread(kit->pos);
> >> +       if (kit->pos =3D=3D kit->task) {
> >> +               if (type =3D=3D BPF_TASK_ITER_THREAD) {
> >> +                       kit->pos =3D NULL;
> >> +                       goto out;
> >> +               }
> >> +       } else
> >> +               goto out;
> >> +
> >> +get_next_task:
> >> +       kit->pos =3D next_task(kit->pos);
> >> +       kit->task =3D kit->pos;
> >> +       if (kit->pos =3D=3D &init_task)
> >> +               kit->pos =3D NULL;
> >
> > I can't say I completely follow the logic (e.g., for
> > BPF_TASK_ITER_PROC, why do we do next_task() on first next() call)?
> > Can you elabore the expected behavior for various combinations of
> > types and starting task argument?
> >
>
> Thanks for the review.
>
> The expected behavior of current implementation is:
>
> BPF_TASK_ITER_PROC:
>
> init_task->first_process->second_process->...->last_process->init_task
>
> We would exit before visiting init_task again.

ah, ok, so in this case it's more like BPF_TASK_ITER_ALL_PROCS, i.e.,
we iterate all processes in the system. Input `task` that we provide
is ignored/meaningless, right? Maybe we should express it as
ALL_PROCS?

>
> BPF_TASK_ITER_THREAD:
>
> group_task->first_thread->second_thread->...->last_thread->group_task
>
> We would exit before visiting group_task again.
>

And this one is iterating threads of a process specified by given
`task`, right?   This is where my confusion comes from. ITER_PROC and
ITER_THREAD, by their name, seems to be very similar, but in reality
ITER_PROC is more like ITER_ALL (except process vs thread iteration),
while ITER_THREAD is parameterized by input `task`.

I'm not sure what's the least confusing way to name and organize
everything, but I think it's quite confusing right now, unfortunately.
I wonder if you or someone else have a better suggestion on making
this more straightforward?


> BPF_TASK_ITER_ALL:
>
> init_task -> first_process -> second_process -> ...
>                  |                    |
>                 -> first_thread..    |
>                                      -> first_thread
>

Ok, and this one is "all threads in the system". So
BPF_TASK_ITER_ALL_THREADS would describe it more precisely, right?

> Actually, every next() call, we would return the "pos" which was
> prepared by previous next() call, and use next_task()/next_thread() to
> update kit->pos. Once we meet the exit condition (next_task() return
> init_task or next_thread() return group_task), we would update kit->pos
> to NULL. In this way, when next() is called again, we will terminate the
> iteration.
>
> Here "kit->pos =3D NULL;" means we would return the last valid "pos" and
> will return NULL in next call to exit from the iteration.
>
> Am I miss something important?

No, it's my bad. I did check, but somehow concluded that you are
returning kit->pos, but you are returning locally cached previous
value of kit->pos. All good here, I think.

>
> Thanks.
>
>
>

