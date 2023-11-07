Return-Path: <bpf+bounces-14448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E4D7E4B53
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 23:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622B3B20FA8
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 22:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D42F865;
	Tue,  7 Nov 2023 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz0+q1Ux"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907D92F85E
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:01:16 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B7D35B4
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 14:01:15 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso240706466b.2
        for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 14:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699394474; x=1699999274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJVdu3v+ltjm3lypTLwHE0RlVBDbCOOhl8PVZS7j31U=;
        b=Nz0+q1UxxXwbTsaMJbw9JIH9i9XDVthWt3MX5yiWGU1gu1y2+fEIVw/qx1OBMHq2tC
         Ffqoes+Fr390nYQT89XMkA/OoUdhCINl2yYhIPiJs5UCPqjriCURu+sNY6RDleA2Pgmj
         XqR5Pe3+xuxpcowJTFn5gYqaj9keSdVP0fNAwHIfjF3Z+6BQ5d78VsN5zYXXDFFo9Pb+
         FRpvUGwtJyMOxCQYXk6hnrDA4HCA4KzBC9WyCasZYKUoizdkzzS2XpbrXdz0YihopgcL
         Tj4zDL5nIWE9RvJ7fo0zhcM73EcTNVuD5HLa3L7+r6e/Kb9vlMOEFx4dhJ+dVKehxUy6
         9Cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699394474; x=1699999274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJVdu3v+ltjm3lypTLwHE0RlVBDbCOOhl8PVZS7j31U=;
        b=cz4L/KMuTC0moQSUcDB7sd9zAfXOdBEm3KtsDQVmbq3T+7FXd/rhdS65f3K+Y0C8QS
         3ADlDENYGWChOu4Pau/wgoZj+yFAlEy0+7g1IWJ7qMjzS7cG/c2VKGfxCrXo+hzCUozr
         OREJmTbbTXehF1EA+LvP5HbD992o3zMw3nJF0WJSNA0ilKh8hhw+sdL8Z/HLJbuoUgLM
         3/jPK/AgBwaKP6MPzaCgNdZLtZ97kGq5AWW8+53qvmwpf+dr07gdeMlVPm6UaDSPdj3X
         x2fmycqOyNVs6sjkN6nFZDQ5PWw9vd9lkxqbK9xpvTb0oZkJGHRGcHBDIzbHeUIBmH5t
         27IQ==
X-Gm-Message-State: AOJu0Yy8mGjZj7cH9Tj1bBo5CivRN5b5Tulb4eJfUyg3EyR7XA9pYN+A
	hzqqjrvdvRa2/F75ULEdGSQ2Z9ADNktLqxTcnV4=
X-Google-Smtp-Source: AGHT+IGpV4LMpRVsYeJt/cF+Rys7LoqUnizMNG/Qjw3gs77WEtd5M9Ub5g7jQjdWQAQeIMRdMJP1pZR/29qVq8tQjRI=
X-Received: by 2002:a17:907:1b22:b0:9c2:a072:78c4 with SMTP id
 mp34-20020a1709071b2200b009c2a07278c4mr16583942ejc.25.1699394473880; Tue, 07
 Nov 2023 14:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106221423.564362-1-jordalgo@meta.com> <CAEf4BzaUeSrgvWw7HiMDr1uF0KKSgyz+_19r03nQm+JU7WPkag@mail.gmail.com>
 <37feefda-1a65-445e-8f92-01160b1f1ea7@meta.com> <CAEf4BzaSzfJvn==NfUvMmg6sg6N6+iZLAT8he+ayrBDnAW75Og@mail.gmail.com>
 <8d83c573-789f-48cf-8911-88bbe6a379c8@meta.com>
In-Reply-To: <8d83c573-789f-48cf-8911-88bbe6a379c8@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 Nov 2023 14:01:02 -0800
Message-ID: <CAEf4BzYoV0Zr0quXkUMk6gDvn98fVvjB_E9yi-M14pXehd6pvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: stackmap: add crosstask check to `__bpf_get_stack`
To: Jordan Rome <jordalgo@meta.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 1:15=E2=80=AFPM Jordan Rome <jordalgo@meta.com> wrot=
e:
>
>
>
> On 11/7/23 4:03 PM, Andrii Nakryiko wrote:
> > >
> > On Tue, Nov 7, 2023 at 1:01=E2=80=AFPM Jordan Rome <jordalgo@meta.com> =
wrote:
> >>
> >>
> >>
> >> On 11/6/23 5:45 PM, Andrii Nakryiko wrote:
> >>>>
> >>> On Mon, Nov 6, 2023 at 2:15=E2=80=AFPM Jordan Rome <jordalgo@meta.com=
> wrote:
> >>>>
> >>>> Currently `get_perf_callchain` only supports user stack walking for
> >>>> the current task. Passing the correct *crosstask* param will return
> >>>> -EFAULT if the task passed to `__bpf_get_stack` isn't the current
> >>>> one instead of a single incorrect frame/address.
> >>>>
> >>>> This issue was found using `bpf_get_task_stack` inside a BPF
> >>>> iterator ("iter/task"), which iterates over all tasks.
> >>>> `bpf_get_task_stack` works fine for fetching kernel stacks
> >>>> but because `get_perf_callchain` relies on the caller to know
> >>>> if the requested *task* is the current one (via *crosstask*)
> >>>> it wasn't returning an error.
> >>>>
> >>>> It might be possible to get user stacks for all tasks utilizing
> >>>> something like `access_process_vm` but that requires the bpf
> >>>> program calling `bpf_get_task_stack` to be sleepable and would
> >>>> therefore be a breaking change.
> >>>>
> >>>> Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
> >>>> Signed-off-by: Jordan Rome <jordalgo@meta.com>
> >>>> ---
> >>>>    include/uapi/linux/bpf.h                                | 3 +++
> >>>>    kernel/bpf/stackmap.c                                   | 3 ++-
> >>>>    tools/include/uapi/linux/bpf.h                          | 3 +++
> >>>>    tools/testing/selftests/bpf/prog_tests/bpf_iter.c       | 3 +++
> >>>>    tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c | 5 +++++
> >>>>    5 files changed, 16 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>>> index 0f6cdf52b1da..da2871145274 100644
> >>>> --- a/include/uapi/linux/bpf.h
> >>>> +++ b/include/uapi/linux/bpf.h
> >>>> @@ -4517,6 +4517,8 @@ union bpf_attr {
> >>>>     * long bpf_get_task_stack(struct task_struct *task, void *buf, u=
32 size, u64 flags)
> >>>>     *     Description
> >>>>     *             Return a user or a kernel stack in bpf program pro=
vided buffer.
> >>>> + *             Note: the user stack will only be populated if the *=
task* is
> >>>> + *             the current task; all other tasks will return -EFAUL=
T.
> >>>
> >>> I thought that you were not getting an error even for a non-current
> >>> task with BPF_F_USER_STACK? Shouldn't we make sure to return error
> >>> (-ENOTSUP?) for such cases? Taking a quick look at
> >>> get_perf_callchain(), it doesn't seem to return NULL in such cases.
> >>
> >> You're right. `get_perf_callchain` does not return -EFAULT. I misread.
> >> This change will make `__bpf_get_stack` return 0 instead of 1 frame.
> >> We could return `-ENOTSUP` but then we're adding additional crosstask
> >> checking in `__bpf_get_stack` instead of just passing the correct
> >> `crosstask` param value to `get_perf_callchain` and letting it
> >> check. If then, in the future, `get_perf_callchain` does support
> >> crosstask user stack walking then `__bpf_get_stack` would still be
> >> returning -ENOTSUP.
> >
> > Yes, but current behavior is worse. So we either return -ENOTSUP from
> > BPF helper for conditions we now are not supported right now. Or we
> > change get_perf_callchain() to return NULL, and then return just
> > generic error (-EINVAL?), which is not bad, but not as meaningful as
> > -ENOSUP.
> >
> > So I'd say let's add -ENOTSUP, but also return NULL from
> > get_perf_callchain? For the latter change, though, please CC relevant
> > perf list/folks, so that they are aware (and maybe they can suggest
> > the best way to add support for this).
> >
>
> Ok, I'll have `__bpf_get_stack` return -ENOTSUP and submit a separate
> patch for `get_perf_callchain` to make this cleaner. Sound good?

yep, thanks

>
> >>
> >>>
> >>>>     *             To achieve this, the helper needs *task*, which is=
 a valid
> >>>>     *             pointer to **struct task_struct**. To store the st=
acktrace, the
> >>>>     *             bpf program provides *buf* with a nonnegative *siz=
e*.
> >>>> @@ -4528,6 +4530,7 @@ union bpf_attr {
> >>>>     *
> >>>>     *             **BPF_F_USER_STACK**
> >>>>     *                     Collect a user space stack instead of a ke=
rnel stack.
> >>>> + *                     The *task* must be the current task.
> >>>>     *             **BPF_F_USER_BUILD_ID**
> >>>>     *                     Collect buildid+offset instead of ips for =
user stack,
> >>>>     *                     only valid if **BPF_F_USER_STACK** is also=
 specified.
> >>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >>>> index d6b277482085..96641766e90c 100644
> >>>> --- a/kernel/bpf/stackmap.c
> >>>> +++ b/kernel/bpf/stackmap.c
> >>>> @@ -388,6 +388,7 @@ static long __bpf_get_stack(struct pt_regs *regs=
, struct task_struct *task,
> >>>>    {
> >>>>           u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
> >>>>           bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
> >>>> +       bool crosstask =3D task && task !=3D current;
> >>>>           u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> >>>>           bool user =3D flags & BPF_F_USER_STACK;
> >>>>           struct perf_callchain_entry *trace;
> >>>> @@ -421,7 +422,7 @@ static long __bpf_get_stack(struct pt_regs *regs=
, struct task_struct *task,
> >>>>                   trace =3D get_callchain_entry_for_task(task, max_d=
epth);
> >>>>           else
> >>>>                   trace =3D get_perf_callchain(regs, 0, kernel, user=
, max_depth,
> >>>> -                                          false, false);
> >>>> +                                          crosstask, false);
> >>>>           if (unlikely(!trace))
> >>>>                   goto err_fault;
> >>>>
> >>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/lin=
ux/bpf.h
> >>>> index 0f6cdf52b1da..da2871145274 100644
> >>>> --- a/tools/include/uapi/linux/bpf.h
> >>>> +++ b/tools/include/uapi/linux/bpf.h
> >>>> @@ -4517,6 +4517,8 @@ union bpf_attr {
> >>>>     * long bpf_get_task_stack(struct task_struct *task, void *buf, u=
32 size, u64 flags)
> >>>>     *     Description
> >>>>     *             Return a user or a kernel stack in bpf program pro=
vided buffer.
> >>>> + *             Note: the user stack will only be populated if the *=
task* is
> >>>> + *             the current task; all other tasks will return -EFAUL=
T.
> >>>>     *             To achieve this, the helper needs *task*, which is=
 a valid
> >>>>     *             pointer to **struct task_struct**. To store the st=
acktrace, the
> >>>>     *             bpf program provides *buf* with a nonnegative *siz=
e*.
> >>>> @@ -4528,6 +4530,7 @@ union bpf_attr {
> >>>>     *
> >>>>     *             **BPF_F_USER_STACK**
> >>>>     *                     Collect a user space stack instead of a ke=
rnel stack.
> >>>> + *                     The *task* must be the current task.
> >>>>     *             **BPF_F_USER_BUILD_ID**
> >>>>     *                     Collect buildid+offset instead of ips for =
user stack,
> >>>>     *                     only valid if **BPF_F_USER_STACK** is also=
 specified.
> >>>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_iter.c
> >>>> index 4e02093c2cbe..757635145510 100644
> >>>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> >>>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> >>>> @@ -332,6 +332,9 @@ static void test_task_stack(void)
> >>>>           do_dummy_read(skel->progs.dump_task_stack);
> >>>>           do_dummy_read(skel->progs.get_task_user_stacks);
> >>>>
> >>>> +       ASSERT_EQ(skel->bss->num_user_stacks, 1,
> >>>> +                 "num_user_stacks");
> >>>> +
> >>>
> >>> please split selftests into a separate patch
> >>>
> >>
> >> Will do.
> >>
> >>>>           bpf_iter_task_stack__destroy(skel);
> >>>>    }
> >>>>
> >>>> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c=
 b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
> >>>> index f2b8167b72a8..442f4ca39fd7 100644
> >>>> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
> >>>> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
> >>>> @@ -35,6 +35,8 @@ int dump_task_stack(struct bpf_iter__task *ctx)
> >>>>           return 0;
> >>>>    }
> >>>>
> >>>> +int num_user_stacks =3D 0;
> >>>> +
> >>>>    SEC("iter/task")
> >>>>    int get_task_user_stacks(struct bpf_iter__task *ctx)
> >>>>    {
> >>>> @@ -51,6 +53,9 @@ int get_task_user_stacks(struct bpf_iter__task *ct=
x)
> >>>>           if (res <=3D 0)
> >>>>                   return 0;
> >>>>
> >>>> +       /* Only one task, the current one, should succeed */
> >>>> +       ++num_user_stacks;
> >>>> +
> >>>>           buf_sz +=3D res;
> >>>>
> >>>>           /* If the verifier doesn't refine bpf_get_task_stack res, =
and instead
> >>>> --
> >>>> 2.39.3
> >>>>

