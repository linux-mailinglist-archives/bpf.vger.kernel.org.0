Return-Path: <bpf+bounces-10185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56017A2840
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 22:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940432825DF
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 20:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A8718E18;
	Fri, 15 Sep 2023 20:37:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DB11CA0
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 20:37:52 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F687B2;
	Fri, 15 Sep 2023 13:37:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52bcb8b199aso3080375a12.3;
        Fri, 15 Sep 2023 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694810269; x=1695415069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlwYCvNiValFIdZJV91TP0CGm/bPmLsjvUp+RBWRPbI=;
        b=Ea5YJO7HTY0qAZaAzgzFgo2z1mHeKtHIN1Q4N/3zxx1us++DuwChWakEmOOI/IBw2d
         jlBGJtL6EKd6kpQhKnZSzaLbhsGrjNguw3C06H8DRjB3LP0lYtcE3/Ae1pydJEQRC5jP
         1PL07UWrJzhtC15AS5/Vh+G6+4mRMN1NvsgAovosUSEk4OQJY2qj0X6RC1uaL+1yxGBg
         XCPJZqvc9VhHWoyepM/Wj1XRPEohIL3cNkusODlJv2OkLu1KLY2j0jnKyr4UiLc2+PqZ
         qEoDRWVw2GSTOgVev4unR7BcCsvVSyY9TIgiIcPrc+YLRqZnD3FVYRXC0DUeN8o5YpuG
         nOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694810269; x=1695415069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlwYCvNiValFIdZJV91TP0CGm/bPmLsjvUp+RBWRPbI=;
        b=gFL3Jqx3TgOrPeanBUsMq/kk6+oOD9QPH7xC+KztRC4lcU7dgi5npUBAS3Y2vbvv1C
         xLGXwosMjpIQ6/9wV4DONE1Q1PAH2ylkomiPEByjqlPocIRpvY3xFgT0YiL+fDlujXyO
         G0LnZnuJ74l8N6/74XyRwp69XMvS5mSQf67vBxQWNg1YamlMaSbL4E6CEhtweDEOPIvl
         ngkBZcUheDKw7qR35KaCM9RaeBByikghLoaXBxdb3tAjaDRhEC1NZYQGuLEQ7jp/q1ud
         RQXUHMBHa4VA2nKVHeo0S2rO2LgaAMjf3aUzRtUjn2239msoPjpGFo8VbfA22NipZPrd
         xXbQ==
X-Gm-Message-State: AOJu0YywiE98efYWqVQk8pwaUumWzgYje20Vg322nlatyK0rHWhLlhaZ
	lZjaEj/hTz6KmuatAWP9TBsYz/Ya6pjeV+mYuqc=
X-Google-Smtp-Source: AGHT+IH3z1RWP2AOuU4Cis7a6to8hXVq6KWI52v8jgXEfVCmdaGwGilMlm624nhniiCI/NioqZUQrO85rP4bVM984d4=
X-Received: by 2002:aa7:caca:0:b0:523:387d:f5f1 with SMTP id
 l10-20020aa7caca000000b00523387df5f1mr2449282edt.24.1694810268479; Fri, 15
 Sep 2023 13:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-4-zhouchuyi@bytedance.com> <CAEf4BzbsBUGiPJ+_RG3c3WdEWNQy2b6h60kLDREcXDsNp3E0_Q@mail.gmail.com>
 <30eadbff-8340-a721-362b-ff82de03cb9f@bytedance.com>
In-Reply-To: <30eadbff-8340-a721-362b-ff82de03cb9f@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Sep 2023 13:37:36 -0700
Message-ID: <CAEf4BzbM=v9KNtQQNcUSRs7mwwKa7FEsBFXO3T1+7KgpZVZKFw@mail.gmail.com>
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

On Fri, Sep 15, 2023 at 8:03=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
>
>
> =E5=9C=A8 2023/9/15 07:26, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Tue, Sep 12, 2023 at 12:02=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedanc=
e.com> wrote:
> >>
> >> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which allow
> >> creation and manipulation of struct bpf_iter_process in open-coded ite=
rator
> >> style. BPF programs can use these kfuncs or through bpf_for_each macro=
 to
> >> iterate all processes in the system.
> >>
> >> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> >> ---
> >>   include/uapi/linux/bpf.h       |  4 ++++
> >>   kernel/bpf/helpers.c           |  3 +++
> >>   kernel/bpf/task_iter.c         | 29 +++++++++++++++++++++++++++++
> >>   tools/include/uapi/linux/bpf.h |  4 ++++
> >>   tools/lib/bpf/bpf_helpers.h    |  5 +++++
> >>   5 files changed, 45 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index de02c0971428..befa55b52e29 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -7322,4 +7322,8 @@ struct bpf_iter_css_task {
> >>          __u64 __opaque[1];
> >>   } __attribute__((aligned(8)));
> >>
> >> +struct bpf_iter_process {
> >> +       __u64 __opaque[1];
> >> +} __attribute__((aligned(8)));
> >> +
> >>   #endif /* _UAPI__LINUX_BPF_H__ */
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index d6a16becfbb9..9b7d2c6f99d1 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2507,6 +2507,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER=
_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
> >>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NUL=
L)
> >>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> >> +BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
> >> +BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
> >> +BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >> index d8539cc05ffd..9d1927dc3a06 100644
> >> --- a/kernel/bpf/task_iter.c
> >> +++ b/kernel/bpf/task_iter.c
> >> @@ -851,6 +851,35 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct=
 bpf_iter_css_task *it)
> >>          kfree(kit->css_it);
> >>   }
> >>
> >> +struct bpf_iter_process_kern {
> >> +       struct task_struct *tsk;
> >> +} __attribute__((aligned(8)));
> >> +
> >
> > Few high level thoughts. I think it would be good to follow
> > SEC("iter/task") naming and approach. Open-coded iterators in many
> > ways are in-kernel counterpart to iterator programs, so keeping them
> > close enough within reason is useful for knowledge transfer.
> >
> > SEC("iter/task") allows to:
> > a) iterate all threads in the system
> > b) iterate all threads for a given TGID
> > c) it also allows to "iterate" a single thread or process, but that's
> > a bit less relevant for in-kernel iterator, but we can still support
> > them, why not?
> >
> > I'm not sure if it supports iterating all processes (as in group
> > leaders of each task group) in the system, but if it's possible I
> > think we should support it at least for open-coded iterator, seems
> > like a very useful functionality.
> >
> > So to that end, let's design a small set of input arguments for
> > bpf_iter_process_new() that would allow to specify this as flags +
> > either (optional) struct task_struct * pointer to represent
> > task/process or PID/TGID.
> >
>
> Another concern from Alexei was the readability of the API of open-coded
> in BPF Program[1].
>
> bpf_for_each(task, curr) is straightforward. Users can easily understand
> that this API does the same thing as 'for_each_process' in kernel.

In general, users might have no idea about for_each_process macro in
the kernel, so I don't find this particular argument very convincing.

We can add a separate set of iterator kfuncs for every useful
combination of conditions, of course, but it's a double-edged sword.
Needing to use a different iterator just to specify a different
direction of cgroup iteration (from the example you referred in [1])
also means that it's now harder to write some generic function that
needs to do something for all cgroups matching some criteria where the
order might be coming as an argument.

Similarly for task iterators. It's not hard to imagine some processing
that can be equivalently done per thread or per process in the system,
or on each thread of the process, depending on some conditions or
external configuration. Having to do three different
bpf_for_each(task_xxx, task, ...) for this seems suboptimal. If the
nature of the thing that is iterated over is the same, and it's just a
different set of filters to specify which subset of those items should
be iterated, I think it's better to try to stick to the same iterator
with few simple arguments. IMO, of course, there is no objectively
best approach.

>
> However, if we keep the approach of SEC("iter/task")
>
> enum ITER_ITEM {
>         ITER_TASK,
>         ITER_THREAD,
> }
>
> __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_process *it, struct
> task_struct *group_task, enum ITER_ITEM type)
>
> the API have to chang:
>
>
> bpf_for_each(task, curr, NULL, ITERATE_TASK) // iterate all process in
> the  system
> bpf_for_each(task, curr, group_leader, ITERATE_THREAD) // iterate all
> thread of group_leader
> bpf_for_each(task, curr, NULL, ITERATE_THREAD) //iterate all threads of
> all the process in the system
>
> Useres may guess what are this API actually doing....

I'd expect users to consult documentation before trying to use an
unfamiliar cutting-edge functionality. So let's try to keep
documentation clear and up to the point. Extra flag argument doesn't
seem to be a big deal.


>
> So, I'm thinking if we can add a layer of abstraction to hide the
> details from the users:
>
> #define bpf_for_each_process(task) \
>         bpf_for_each(task, curr, NULL, ITERATE_TASK)
>
>
> It would be nice if you could give me some better suggestions.

No, please no. This macro wrapper is useless and just obfuscates what
is going on. If users think it's helpful for them, they can trivially
define it for their own code.

>
> Thanks!
>
> [1]
> https://lore.kernel.org/lkml/CAADnVQLbDWUxFen-RS67C86sOE5DykEPD8xyihJ2RnG=
1WEnTQg@mail.gmail.com/

