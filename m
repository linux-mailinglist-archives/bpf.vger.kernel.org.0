Return-Path: <bpf+bounces-11316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793907B73EA
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id EE1BC1F215E3
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F03E474;
	Tue,  3 Oct 2023 22:06:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B33E461
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 22:06:02 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F51AB;
	Tue,  3 Oct 2023 15:06:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdcade7fbso252875666b.1;
        Tue, 03 Oct 2023 15:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696370759; x=1696975559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bb2LqPjMbwJRZLLZfDqFHvEph2LGzkrbcYsXckT8ZG8=;
        b=PkksXR90l+i+ik5ser2+jKb2i0hGdwV1kP52CSOce9uwscfn8E7+K196IWKd/gZoxh
         yUAi7AOqt6NX39TL0VsRdZfZbomdwBB9OfjqVRlb4PrTzR6HuZYSLJ4iN13Msn5gg7LL
         CNgyE6vmzu48X+WNH07THUKirDpJsr4BWDuLb9tMH4hQ/XcN9is11t1UZsQjXN3lD35q
         jNYChRANQPQ7tRvuWY8RPqgKoGiojVuWtHR35G9IRVlC+HbQmuo73h4wZ9x+IAZl9xSN
         mEcSDwvUKS8fGogKo+tKqjMbBUEmCyPgkSJCJQw+oZ6gq1MeWQyqpW6Q0grEAU0Jb6Dh
         AADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696370759; x=1696975559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bb2LqPjMbwJRZLLZfDqFHvEph2LGzkrbcYsXckT8ZG8=;
        b=k5NKmdxqdOHNIKvTbrZxj22kcW8AHa7qekYopuDZU9+KRO1CY27lnHS3pAZVz+MNqS
         0wPmeBXEUg4cpzEWWYaPiM551AFKuvCuq5FwSGQcEBpSz3ew+z9HWsoHnsJzj5zKOoD7
         oo6R80jdi7ZdDdO+nwHvNERBpjJk1N8YeZ/Jwwy+pazVkZApCDxTQ8Z+2gDmEQtmfsdJ
         dqZELcyo/j0nyoT5a/ZNl+A42RTkigcA3cwyjBsc3vG0aBBNQRbS9EfZLxPg5cGyhmx4
         IdNWuR4qOI2+V7GERfbP5C2YSgsHcFWQMqSSAyszuYjHQxetCXqzz2OqsKzW+G6jHrKs
         6Q2Q==
X-Gm-Message-State: AOJu0Yz08ohTU2zLhqPw+YDmJsyYxyN4LRi1vx4UZZigNPCH6E1VU7Yp
	Xru2lQJj9+Gu1N8L3vkOhMjfGs1KMhlsdiGL0g0=
X-Google-Smtp-Source: AGHT+IE9QYjgYTfRgis4+m0quxq+X6/K28YEOygL7f/Rr1xTxrPF4Wv35BwpKls4r+1BZfIGXhyJ7mdx++234ECZv3I=
X-Received: by 2002:a17:907:75f4:b0:9ae:7d2d:f2b1 with SMTP id
 jz20-20020a17090775f400b009ae7d2df2b1mr433380ejc.73.1696370759158; Tue, 03
 Oct 2023 15:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
 <20230925105552.817513-4-zhouchuyi@bytedance.com> <CAEf4BzZFBFPMBs6t4GM7GRt-c-Po9KkQqxQ_Zo9vuG=KuqeLzQ@mail.gmail.com>
 <716adfa5-bd5d-3fe2-108c-ff24b2e81420@bytedance.com> <CAEf4BzaAtybx=Cbb6zD1otgQ-Jm+Xta0_8rwmL_ZYb3GzjSwWg@mail.gmail.com>
 <425309da-ec03-df8b-3565-d226dd1a1715@bytedance.com>
In-Reply-To: <425309da-ec03-df8b-3565-d226dd1a1715@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Oct 2023 15:05:47 -0700
Message-ID: <CAEf4BzZmS7wY5XgzMtXReiTG2RXhu23Ss7Q61OxxaUhQYFK=PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] bpf: Introduce task open coded iterator kfuncs
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

On Sun, Oct 1, 2023 at 1:21=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com>=
 wrote:
>
> Hello, Andrii
>
> =E5=9C=A8 2023/9/30 05:27, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Wed, Sep 27, 2023 at 8:29=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance=
.com> wrote:
> >>
> >> Hello,
> >>
> >> =E5=9C=A8 2023/9/28 07:20, Andrii Nakryiko =E5=86=99=E9=81=93:
> >>> On Mon, Sep 25, 2023 at 3:56=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedan=
ce.com> wrote:
> >>>>
> >>>> This patch adds kfuncs bpf_iter_task_{new,next,destroy} which allow
> >>>> creation and manipulation of struct bpf_iter_task in open-coded iter=
ator
> >>>> style. BPF programs can use these kfuncs or through bpf_for_each mac=
ro to
> >>>> iterate all processes in the system.
> >>>>
> >>>> The API design keep consistent with SEC("iter/task"). bpf_iter_task_=
new()
> >>>> accepts a specific task and iterating type which allows:
> >>>> 1. iterating all process in the system
> >>>>
> >>>> 2. iterating all threads in the system
> >>>>
> >>>> 3. iterating all threads of a specific task
> >>>> Here we also resuse enum bpf_iter_task_type and rename BPF_TASK_ITER=
_TID
> >>>> to BPF_TASK_ITER_THREAD, rename BPF_TASK_ITER_TGID to BPF_TASK_ITER_=
PROC.
> >>>>
> >>>> The newly-added struct bpf_iter_task has a name collision with a sel=
ftest
> >>>> for the seq_file task iter's bpf skel, so the selftests/bpf/progs fi=
le is
> >>>> renamed in order to avoid the collision.
> >>>>
> >>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> >>>> ---
> >>>>    include/linux/bpf.h                           |  8 +-
> >>>>    kernel/bpf/helpers.c                          |  3 +
> >>>>    kernel/bpf/task_iter.c                        | 96 ++++++++++++++=
++---
> >>>>    .../testing/selftests/bpf/bpf_experimental.h  |  5 +
> >>>>    .../selftests/bpf/prog_tests/bpf_iter.c       | 18 ++--
> >>>>    .../{bpf_iter_task.c =3D> bpf_iter_tasks.c}     |  0
> >>>>    6 files changed, 106 insertions(+), 24 deletions(-)
> >>>>    rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c =3D> bp=
f_iter_tasks.c} (100%)
> >>>>
> >>>
>
>
> [...]
>
> >>>> +get_next_task:
> >>>> +       kit->pos =3D next_task(kit->pos);
> >>>> +       kit->task =3D kit->pos;
> >>>> +       if (kit->pos =3D=3D &init_task)
> >>>> +               kit->pos =3D NULL;
> >>>
> >>> I can't say I completely follow the logic (e.g., for
> >>> BPF_TASK_ITER_PROC, why do we do next_task() on first next() call)?
> >>> Can you elabore the expected behavior for various combinations of
> >>> types and starting task argument?
> >>>
> >>
> >> Thanks for the review.
> >>
> >> The expected behavior of current implementation is:
> >>
> >> BPF_TASK_ITER_PROC:
> >>
> >> init_task->first_process->second_process->...->last_process->init_task
> >>
> >> We would exit before visiting init_task again.
> >
> > ah, ok, so in this case it's more like BPF_TASK_ITER_ALL_PROCS, i.e.,
> > we iterate all processes in the system. Input `task` that we provide
> > is ignored/meaningless, right? Maybe we should express it as
> > ALL_PROCS?
> >
> >>
> >> BPF_TASK_ITER_THREAD:
> >>
> >> group_task->first_thread->second_thread->...->last_thread->group_task
> >>
> >> We would exit before visiting group_task again.
> >>
> >
> > And this one is iterating threads of a process specified by given
> > `task`, right?   This is where my confusion comes from. ITER_PROC and
> > ITER_THREAD, by their name, seems to be very similar, but in reality
> > ITER_PROC is more like ITER_ALL (except process vs thread iteration),
> > while ITER_THREAD is parameterized by input `task`.
> >
> > I'm not sure what's the least confusing way to name and organize
> > everything, but I think it's quite confusing right now, unfortunately.
> > I wonder if you or someone else have a better suggestion on making
> > this more straightforward?
> >
>
> Maybe here we can introduce new enums and not reuse or rename
> BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID?

Yep, probably it's cleaner

>
> {
> BPF_TASK_ITER_ALL_PROC,

BPF_TASK_ITER_ALL_PROCS

> BPF_TASK_ITER_ALL_THREAD,

BPF_TASK_ITER_ALL_THREADS

> BPF_TASK_ITER_THREAD

BPF_TASK_ITER_PROC_THREADS ?

> }
>
> BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID are inner flags. Looking at the
> example usage of SEC("iter/task"), unlike
> BPF_CGROUP_ITER_DESCENDANTS_PRE/BPF_CGROUP_ITER_DESCENDANTS_POST, we
> actually don't use BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID directly. When
> using SEC("iter/task"), we just set pid/tid for struct
> bpf_iter_link_info. Exposing new enums to users for open coded
> task_iters will not confuse users.
>
> Thanks.
>

