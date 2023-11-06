Return-Path: <bpf+bounces-14335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8297E3021
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 23:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB879280DD9
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 22:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE382C842;
	Mon,  6 Nov 2023 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoWzvN1a"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC311D528
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 22:46:12 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F096B10D2
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 14:46:01 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so8621304a12.3
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699310760; x=1699915560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGjpTRoA2OrfZbr9B39mLiQwQWhKMy2utFRRA9nKvyo=;
        b=NoWzvN1aWt4zp/FufcqSu6ghf7IlMoQMD+zbT2/viyIde9R0VA6ib37MFxyp1bYhHN
         tdXhA2QZNWzzwI/oI8H8PQD3+kmuQgV9GRzJ1okDrK9ar4Wq9vFhYcH+jA2sfUeSLUY3
         Qy/cepFOB7XnI/llQXDNWD9FgJqksTshByRWj3UpWyQPU3ufneL985TSI++KXenMzIcX
         lYbCU7ksoYvoEbHi6zVXs3hstk4lYWBLaTt1FSU+avciU0ZrkmVsqBfLoM8vfY8Y+Fku
         wqAyRCeyKn7xVTYnn2vPFiZ7N/puw3eY8CS3IQwSzf+2CUr0m975jTDOAx7E9gsJXWII
         AwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310760; x=1699915560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGjpTRoA2OrfZbr9B39mLiQwQWhKMy2utFRRA9nKvyo=;
        b=DmFKRG8GTUy8rhThya2rZjZUKFrA8vQg2OZr1aOAkk0Iom5fkdAlYmGKgNElmWYmaR
         teWtR7IXHS1K4fA9nYtM6+hLCu00YbFTeWHHXUTTa75121j7VR4l7/NZgpBGFnWT+ixa
         IJ0+0zPYpuwKPBxxQji4qmjs7SQGupa7hEwDqj9A35vBvT4X+1DJ1/tXM+lx5jr/HOCu
         BVX1/IdI8Kp803yoywKMQID3S1kK58acF5a792N0p1gRZsNApUQo9LkWVcGRn8886z5F
         FLPsnc7TM78iKTxonMCxV/sKyzvg48V4ruiztS7TnSvrNPuSEh8ESg29SCs8lZeq1CUj
         kl/w==
X-Gm-Message-State: AOJu0Yxet2iynT/DX+bOkOwMbqE4NkqMLfYYeB2NrafR63kPfTLl9p6/
	VqAmooPZji6iWYw/hBk2d08vBppZxf2r4R52riI=
X-Google-Smtp-Source: AGHT+IH2YEocr3T78Shw061iOeu5i45mRaOxbhKQufQrfWmIwgSPTvMQGr7t/4wVjuBQSg3ZL+LludxwBuHfB66IgAQ=
X-Received: by 2002:a17:906:ee85:b0:9d4:2080:61d7 with SMTP id
 wt5-20020a170906ee8500b009d4208061d7mr16200573ejb.51.1699310760027; Mon, 06
 Nov 2023 14:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106221423.564362-1-jordalgo@meta.com>
In-Reply-To: <20231106221423.564362-1-jordalgo@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Nov 2023 14:45:48 -0800
Message-ID: <CAEf4BzaUeSrgvWw7HiMDr1uF0KKSgyz+_19r03nQm+JU7WPkag@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: stackmap: add crosstask check to `__bpf_get_stack`
To: Jordan Rome <jordalgo@meta.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 2:15=E2=80=AFPM Jordan Rome <jordalgo@meta.com> wrot=
e:
>
> Currently `get_perf_callchain` only supports user stack walking for
> the current task. Passing the correct *crosstask* param will return
> -EFAULT if the task passed to `__bpf_get_stack` isn't the current
> one instead of a single incorrect frame/address.
>
> This issue was found using `bpf_get_task_stack` inside a BPF
> iterator ("iter/task"), which iterates over all tasks.
> `bpf_get_task_stack` works fine for fetching kernel stacks
> but because `get_perf_callchain` relies on the caller to know
> if the requested *task* is the current one (via *crosstask*)
> it wasn't returning an error.
>
> It might be possible to get user stacks for all tasks utilizing
> something like `access_process_vm` but that requires the bpf
> program calling `bpf_get_task_stack` to be sleepable and would
> therefore be a breaking change.
>
> Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
> Signed-off-by: Jordan Rome <jordalgo@meta.com>
> ---
>  include/uapi/linux/bpf.h                                | 3 +++
>  kernel/bpf/stackmap.c                                   | 3 ++-
>  tools/include/uapi/linux/bpf.h                          | 3 +++
>  tools/testing/selftests/bpf/prog_tests/bpf_iter.c       | 3 +++
>  tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c | 5 +++++
>  5 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0f6cdf52b1da..da2871145274 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4517,6 +4517,8 @@ union bpf_attr {
>   * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size=
, u64 flags)
>   *     Description
>   *             Return a user or a kernel stack in bpf program provided b=
uffer.
> + *             Note: the user stack will only be populated if the *task*=
 is
> + *             the current task; all other tasks will return -EFAULT.

I thought that you were not getting an error even for a non-current
task with BPF_F_USER_STACK? Shouldn't we make sure to return error
(-ENOTSUP?) for such cases? Taking a quick look at
get_perf_callchain(), it doesn't seem to return NULL in such cases.

>   *             To achieve this, the helper needs *task*, which is a vali=
d
>   *             pointer to **struct task_struct**. To store the stacktrac=
e, the
>   *             bpf program provides *buf* with a nonnegative *size*.
> @@ -4528,6 +4530,7 @@ union bpf_attr {
>   *
>   *             **BPF_F_USER_STACK**
>   *                     Collect a user space stack instead of a kernel st=
ack.
> + *                     The *task* must be the current task.
>   *             **BPF_F_USER_BUILD_ID**
>   *                     Collect buildid+offset instead of ips for user st=
ack,
>   *                     only valid if **BPF_F_USER_STACK** is also specif=
ied.
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index d6b277482085..96641766e90c 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -388,6 +388,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>  {
>         u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
>         bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
> +       bool crosstask =3D task && task !=3D current;
>         u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
>         bool user =3D flags & BPF_F_USER_STACK;
>         struct perf_callchain_entry *trace;
> @@ -421,7 +422,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>                 trace =3D get_callchain_entry_for_task(task, max_depth);
>         else
>                 trace =3D get_perf_callchain(regs, 0, kernel, user, max_d=
epth,
> -                                          false, false);
> +                                          crosstask, false);
>         if (unlikely(!trace))
>                 goto err_fault;
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 0f6cdf52b1da..da2871145274 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4517,6 +4517,8 @@ union bpf_attr {
>   * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size=
, u64 flags)
>   *     Description
>   *             Return a user or a kernel stack in bpf program provided b=
uffer.
> + *             Note: the user stack will only be populated if the *task*=
 is
> + *             the current task; all other tasks will return -EFAULT.
>   *             To achieve this, the helper needs *task*, which is a vali=
d
>   *             pointer to **struct task_struct**. To store the stacktrac=
e, the
>   *             bpf program provides *buf* with a nonnegative *size*.
> @@ -4528,6 +4530,7 @@ union bpf_attr {
>   *
>   *             **BPF_F_USER_STACK**
>   *                     Collect a user space stack instead of a kernel st=
ack.
> + *                     The *task* must be the current task.
>   *             **BPF_F_USER_BUILD_ID**
>   *                     Collect buildid+offset instead of ips for user st=
ack,
>   *                     only valid if **BPF_F_USER_STACK** is also specif=
ied.
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
> index 4e02093c2cbe..757635145510 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -332,6 +332,9 @@ static void test_task_stack(void)
>         do_dummy_read(skel->progs.dump_task_stack);
>         do_dummy_read(skel->progs.get_task_user_stacks);
>
> +       ASSERT_EQ(skel->bss->num_user_stacks, 1,
> +                 "num_user_stacks");
> +

please split selftests into a separate patch

>         bpf_iter_task_stack__destroy(skel);
>  }
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c b/to=
ols/testing/selftests/bpf/progs/bpf_iter_task_stack.c
> index f2b8167b72a8..442f4ca39fd7 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
> @@ -35,6 +35,8 @@ int dump_task_stack(struct bpf_iter__task *ctx)
>         return 0;
>  }
>
> +int num_user_stacks =3D 0;
> +
>  SEC("iter/task")
>  int get_task_user_stacks(struct bpf_iter__task *ctx)
>  {
> @@ -51,6 +53,9 @@ int get_task_user_stacks(struct bpf_iter__task *ctx)
>         if (res <=3D 0)
>                 return 0;
>
> +       /* Only one task, the current one, should succeed */
> +       ++num_user_stacks;
> +
>         buf_sz +=3D res;
>
>         /* If the verifier doesn't refine bpf_get_task_stack res, and ins=
tead
> --
> 2.39.3
>

