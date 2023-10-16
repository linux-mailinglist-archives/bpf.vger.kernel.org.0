Return-Path: <bpf+bounces-12349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D959E7CB480
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 22:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E773281950
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6F737178;
	Mon, 16 Oct 2023 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceXwOir3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2634CE3
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 20:18:21 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E7783;
	Mon, 16 Oct 2023 13:18:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so8304941a12.3;
        Mon, 16 Oct 2023 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697487498; x=1698092298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1txcMyKL02YN3XqfczPDpjjenESIRV6GuXIGUGvRcWE=;
        b=ceXwOir3f//tCJpb1EV44TC41oVA1eV/oUMO6TpM6tHeLXypmN/scdxmnI8PAQsNeN
         V9HYNCjXOI0Btp34MmzEGQaCamQwjNY/hYneIF1LlKrrMASAsLiTsijfNVNrY0zp/c7v
         FXUGcCk0cYxi6pUMPNU+Vv0fIaCnpLKTdtVstCZD1rL78HaTXthY614D7fi9kGMHo9U6
         N/nUKa2HnxxYXHND5lnd/Wqsbj1xCPPzca2a3zm4EJbb/nSZ1inRRrbkufCRMj3XYddo
         a+NTsxe2cTGBjVDDGIu0NbUJwtnRbUgzSAMi4S4um9OppNCc6KnHR+HIQPzwc+PEJn4u
         OHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487498; x=1698092298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1txcMyKL02YN3XqfczPDpjjenESIRV6GuXIGUGvRcWE=;
        b=jSIzSFIw7cGJM2njocQttfcv9uva6pfokeLikq62AauoVdDCDRbdJ1lIaFBdWsNAuH
         F4txofvJ2wqOH5mPdosiTRunMuDnnLpriPAZmUxQDUeEmxBR00qL6JA2m+t9prD/6We2
         ZrFz+WMUN1mWxhmbAwK8/RfCrvVO/olxlc+5lXHC6kcrv1gNHUUK3Z/Xb535ha9KJRU5
         nJ/cm0JmKnMsnMRPg4osR3Kafa03IuGs1nBAsiPsoH+3VyC0/3HK/ZHSSODGilYZTyo+
         sVrZp+SdBj8DWzQUM/iCqt7pek3PFzbcLxQPksv7I8Nwn1qL7+80uDtshUMOE590w+Z7
         BtDw==
X-Gm-Message-State: AOJu0Yx/3z1PIzy9AymwtiVuvfo8iQIiqIekrK+UVm91oGzp1IBZAvdp
	T/kH4uHL/38kkCIQ4RAG23x/a0IFPj7YPO+EUcs=
X-Google-Smtp-Source: AGHT+IFCFbYRZdexPU4CuY4lsonmCR/F7QA0D2RCZhh0hDza1DObf79NoTjKfTW0LUCUyb3+hlif16gGa+lK53A53T0=
X-Received: by 2002:a50:a6d8:0:b0:53e:37b0:232e with SMTP id
 f24-20020a50a6d8000000b0053e37b0232emr295780edc.13.1697487497748; Mon, 16 Oct
 2023 13:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011120857.251943-1-zhouchuyi@bytedance.com>
 <20231011120857.251943-4-zhouchuyi@bytedance.com> <CAEf4BzYGZiTUHPkjuF81vWZWPH-x4rxz1s9+T0rh-dsrO5ZwDg@mail.gmail.com>
 <0dc492a8-7fc8-4cb4-a770-95906b1f311f@bytedance.com>
In-Reply-To: <0dc492a8-7fc8-4cb4-a770-95906b1f311f@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Oct 2023 13:18:04 -0700
Message-ID: <CAEf4BzaQe7hRmP9w9+=j-H24M8zoN2VT255A5kge+qk-nZT7eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/8] bpf: Introduce task open coded iterator kfuncs
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

On Fri, Oct 13, 2023 at 7:02=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> Hello,
>
> =E5=9C=A8 2023/10/14 05:27, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Wed, Oct 11, 2023 at 5:09=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance=
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
> >>
> >> 1. iterating all process in the system(BPF_TASK_ITER_ALL_PROCS)
> >>
> >> 2. iterating all threads in the system(BPF_TASK_ITER_ALL_THREADS)
> >>
> >> 3. iterating all threads of a specific task(BPF_TASK_ITER_PROC_THREADS=
)
> >>
> >> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> >> ---
> >>   kernel/bpf/helpers.c                          |  3 +
> >>   kernel/bpf/task_iter.c                        | 82 +++++++++++++++++=
++
> >>   .../testing/selftests/bpf/bpf_experimental.h  |  5 ++
> >>   3 files changed, 90 insertions(+)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index cb24c4a916df..690763751f6e 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2555,6 +2555,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER=
_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_A=
RGS)
> >>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NUL=
L)
> >>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >> index 2cfcb4dd8a37..caeddad3d2f1 100644
> >> --- a/kernel/bpf/task_iter.c
> >> +++ b/kernel/bpf/task_iter.c
> >> @@ -856,6 +856,88 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct=
 bpf_iter_css_task *it)
> >>          bpf_mem_free(&bpf_global_ma, kit->css_it);
> >>   }
> >>
> >> +struct bpf_iter_task {
> >> +       __u64 __opaque[3];
> >> +} __attribute__((aligned(8)));
> >> +
> >> +struct bpf_iter_task_kern {
> >> +       struct task_struct *task;
> >> +       struct task_struct *pos;
> >> +       unsigned int flags;
> >> +} __attribute__((aligned(8)));
> >> +
> >> +enum {
> >> +       BPF_TASK_ITER_ALL_PROCS,
> >> +       BPF_TASK_ITER_ALL_THREADS,
> >> +       BPF_TASK_ITER_PROC_THREADS
> >> +};
> >> +
> >> +__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
> >> +               struct task_struct *task, unsigned int flags)
> >> +{
> >> +       struct bpf_iter_task_kern *kit =3D (void *)it;
> >> +
> >> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) > sizeof(struct=
 bpf_iter_task));
> >> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=3D
> >> +                                       __alignof__(struct bpf_iter_ta=
sk));
> >> +
> >> +       kit->task =3D kit->pos =3D NULL;
> >> +       switch (flags) {
> >> +       case BPF_TASK_ITER_ALL_THREADS:
> >> +       case BPF_TASK_ITER_ALL_PROCS:
> >> +       case BPF_TASK_ITER_PROC_THREADS:
> >> +               break;
> >> +       default:
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (flags =3D=3D BPF_TASK_ITER_PROC_THREADS)
> >> +               kit->task =3D task;
> >> +       else
> >> +               kit->task =3D &init_task;
> >> +       kit->pos =3D kit->task;
> >> +       kit->flags =3D flags;
> >> +       return 0;
> >> +}
> >> +
> >> +__bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_ta=
sk *it)
> >> +{
> >> +       struct bpf_iter_task_kern *kit =3D (void *)it;
> >> +       struct task_struct *pos;
> >> +       unsigned int flags;
> >> +
> >> +       flags =3D kit->flags;
> >> +       pos =3D kit->pos;
> >> +
> >> +       if (!pos)
> >> +               goto out;
> >> +
> >> +       if (flags =3D=3D BPF_TASK_ITER_ALL_PROCS)
> >> +               goto get_next_task;
> >> +
> >> +       kit->pos =3D next_thread(kit->pos);
> >> +       if (kit->pos =3D=3D kit->task) {
> >> +               if (flags =3D=3D BPF_TASK_ITER_PROC_THREADS) {
> >> +                       kit->pos =3D NULL;
> >> +                       goto out;
> >> +               }
> >> +       } else
> >> +               goto out;
> >
> > nit: this should have {} around it to match the other if branch
> >
> > but actually, why goto out instead of return pos? same above, return
> > pos instead of goto out?
> >
>
> Thanks for the review.
>
>
> IIUC, do you mean:
>

yes, goto only makes sense when there is some common clean up or error
handling logic, in this case it's a plain return result, so no point.


> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 0772545568f1..b35debf19edb 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -913,7 +913,7 @@ __bpf_kfunc struct task_struct
> *bpf_iter_task_next(struct bpf_iter_task *it)
>          pos =3D kit->pos;
>
>          if (!pos)
> -               goto out;
> +               return pos;
>
>          if (flags =3D=3D BPF_TASK_ITER_ALL_PROCS)
>                  goto get_next_task;
> @@ -922,18 +922,22 @@ __bpf_kfunc struct task_struct
> *bpf_iter_task_next(struct bpf_iter_task *it)
>          if (kit->pos =3D=3D kit->task) {
>                  if (flags =3D=3D BPF_TASK_ITER_PROC_THREADS) {
>                          kit->pos =3D NULL;
> -                       goto out;
> +                       return pos;
>                  }
>          } else
> -               goto out;
> +               return pos;
>
> +       /*
> +        * goto get_next_task means:
> +        * case 1: flags =3D=3D BPF_TASK_ITER_ALL_PROCS
> +        * case 2: kit->pos =3D=3D kit->task && flags =3D=3D
> BPF_TASK_ITER_ALL_THREADS
> +        */
>   get_next_task:
>          kit->pos =3D next_task(kit->pos);
>          kit->task =3D kit->pos;
>          if (kit->pos =3D=3D &init_task)
>                  kit->pos =3D NULL;
>
> -out:
>          return pos;
>
>
>
> BTW, do you have some comments on patch-8 ? or I should send next
> version and pass all the CI first ?
>

I didn't think too hard about changes you are proposing, but yes, CI
should be green on submission, of course

> Thanks.
>
> >
> >> +
> >> +get_next_task:
> >> +       kit->pos =3D next_task(kit->pos);
> >> +       kit->task =3D kit->pos;
> >> +       if (kit->pos =3D=3D &init_task)
> >> +               kit->pos =3D NULL;
> >> +
> >> +out:
> >> +       return pos;
> >> +}
> >> +
> >> +__bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
> >> +{
> >> +}
> >> +
> >>   DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
> >>
> >>   static void do_mmap_read_unlock(struct irq_work *entry)
> >> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/te=
sting/selftests/bpf/bpf_experimental.h
> >> index 8b53537e0f27..1ec82997cce7 100644
> >> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> >> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> >> @@ -457,5 +457,10 @@ extern int bpf_iter_css_task_new(struct bpf_iter_=
css_task *it,
> >>   extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_cs=
s_task *it) __weak __ksym;
> >>   extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) =
__weak __ksym;
> >>
> >> +struct bpf_iter_task;
> >> +extern int bpf_iter_task_new(struct bpf_iter_task *it,
> >> +               struct task_struct *task, unsigned int flags) __weak _=
_ksym;
> >> +extern struct task_struct *bpf_iter_task_next(struct bpf_iter_task *i=
t) __weak __ksym;
> >> +extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __=
ksym;
> >>
> >>   #endif
> >> --
> >> 2.20.1
> >>

