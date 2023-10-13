Return-Path: <bpf+bounces-12178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD547C8EFE
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 23:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E803F1C208D0
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69B262B0;
	Fri, 13 Oct 2023 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/AxKoPK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE824203
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 21:27:30 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9032195;
	Fri, 13 Oct 2023 14:27:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso4685837a12.3;
        Fri, 13 Oct 2023 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697232447; x=1697837247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWPPM7ugrPseLiYRwOtdD/xnq+Rvdv3Q5WeS0PTLMHw=;
        b=k/AxKoPK+OX26G9xg+Ly4XS9Yvz0g887LGr93qnIqJZijPpuGtgvdvXgYkCog7MVkv
         lDQq8PIy+//ZGDYFu5u60JwS/zWLqqTPO4LCAKfp3SQgdXYKPKFrBvDhRDu7b/dBP0SK
         XJJofzOB5Lr1YzzIK0WAiC6IplcE/hove4QDdmFwnyqxDMauYFy+LpCUI+TkiEUy+yz1
         QMhHanoT3jI9uubwRpZO4Jt80keOlT3KY44fLZMhoCwVQZEME2bR+9h6bCcFMbvp3Cc7
         rl20H6UY/lPyHux1B+LkRSxMdwv6rTbElu1uTpOqhbDCIfw8J/cwU1ou/nDhvnjAT78w
         G8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232447; x=1697837247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWPPM7ugrPseLiYRwOtdD/xnq+Rvdv3Q5WeS0PTLMHw=;
        b=PnPEJdiDnkRPpqEGlnWNZnymY8+Hi0YEizolwGXK5zvfQBNPl82aoZP5S9d79+gMsN
         gjpK+COC4/hOynmwif+Rs+Uv+yfjmOSFIJlSLwlKvKpy3DONDoXwV2Xt3efCiWVRL4er
         tJJNY96GvkhMCYkfj6BV4o4BweejyqphVYFqZPv2/IXayam9e/RbSyYpOLxItrbxorNz
         Km46OCl8hnO8IR9HgaGSFjnXhfmBaPZZOjKMhC/ARfgxh0RRIsZdhcMU8capzQ/5K1ea
         jHYR5u1Hb75GAFvcGV1nwl3XyNfNcb7TGk/yddZuUzA7V7hi+TtHDeJHUMVpTsf2TY2g
         5h9Q==
X-Gm-Message-State: AOJu0Yzd+mpy+lSdOmIy1IuxYnsw1vBTAlGgzES+5oK+9SbVtxxF7DhA
	puximCzxC7qeErNRB3bdWliIW8glUM7heBa/3Wk=
X-Google-Smtp-Source: AGHT+IH+TZ63n+p28wbGqiQiQkOi9tNWdonB3EkqV30IYRgPJhJJisRXiQUfD59go7zv6WjY/y0eFOmIGj81FjMsCC0=
X-Received: by 2002:a05:6402:2550:b0:53e:2371:e4a0 with SMTP id
 l16-20020a056402255000b0053e2371e4a0mr5650570edb.1.1697232446713; Fri, 13 Oct
 2023 14:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011120857.251943-1-zhouchuyi@bytedance.com> <20231011120857.251943-4-zhouchuyi@bytedance.com>
In-Reply-To: <20231011120857.251943-4-zhouchuyi@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Oct 2023 14:27:15 -0700
Message-ID: <CAEf4BzYGZiTUHPkjuF81vWZWPH-x4rxz1s9+T0rh-dsrO5ZwDg@mail.gmail.com>
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

On Wed, Oct 11, 2023 at 5:09=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> This patch adds kfuncs bpf_iter_task_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_task in open-coded iterator
> style. BPF programs can use these kfuncs or through bpf_for_each macro to
> iterate all processes in the system.
>
> The API design keep consistent with SEC("iter/task"). bpf_iter_task_new()
> accepts a specific task and iterating type which allows:
>
> 1. iterating all process in the system(BPF_TASK_ITER_ALL_PROCS)
>
> 2. iterating all threads in the system(BPF_TASK_ITER_ALL_THREADS)
>
> 3. iterating all threads of a specific task(BPF_TASK_ITER_PROC_THREADS)
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  kernel/bpf/helpers.c                          |  3 +
>  kernel/bpf/task_iter.c                        | 82 +++++++++++++++++++
>  .../testing/selftests/bpf/bpf_experimental.h  |  5 ++
>  3 files changed, 90 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cb24c4a916df..690763751f6e 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2555,6 +2555,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DE=
STROY)
>  BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 2cfcb4dd8a37..caeddad3d2f1 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -856,6 +856,88 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bp=
f_iter_css_task *it)
>         bpf_mem_free(&bpf_global_ma, kit->css_it);
>  }
>
> +struct bpf_iter_task {
> +       __u64 __opaque[3];
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_task_kern {
> +       struct task_struct *task;
> +       struct task_struct *pos;
> +       unsigned int flags;
> +} __attribute__((aligned(8)));
> +
> +enum {
> +       BPF_TASK_ITER_ALL_PROCS,
> +       BPF_TASK_ITER_ALL_THREADS,
> +       BPF_TASK_ITER_PROC_THREADS
> +};
> +
> +__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
> +               struct task_struct *task, unsigned int flags)
> +{
> +       struct bpf_iter_task_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) > sizeof(struct bp=
f_iter_task));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=3D
> +                                       __alignof__(struct bpf_iter_task)=
);
> +
> +       kit->task =3D kit->pos =3D NULL;
> +       switch (flags) {
> +       case BPF_TASK_ITER_ALL_THREADS:
> +       case BPF_TASK_ITER_ALL_PROCS:
> +       case BPF_TASK_ITER_PROC_THREADS:
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (flags =3D=3D BPF_TASK_ITER_PROC_THREADS)
> +               kit->task =3D task;
> +       else
> +               kit->task =3D &init_task;
> +       kit->pos =3D kit->task;
> +       kit->flags =3D flags;
> +       return 0;
> +}
> +
> +__bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task =
*it)
> +{
> +       struct bpf_iter_task_kern *kit =3D (void *)it;
> +       struct task_struct *pos;
> +       unsigned int flags;
> +
> +       flags =3D kit->flags;
> +       pos =3D kit->pos;
> +
> +       if (!pos)
> +               goto out;
> +
> +       if (flags =3D=3D BPF_TASK_ITER_ALL_PROCS)
> +               goto get_next_task;
> +
> +       kit->pos =3D next_thread(kit->pos);
> +       if (kit->pos =3D=3D kit->task) {
> +               if (flags =3D=3D BPF_TASK_ITER_PROC_THREADS) {
> +                       kit->pos =3D NULL;
> +                       goto out;
> +               }
> +       } else
> +               goto out;

nit: this should have {} around it to match the other if branch

but actually, why goto out instead of return pos? same above, return
pos instead of goto out?


> +
> +get_next_task:
> +       kit->pos =3D next_task(kit->pos);
> +       kit->task =3D kit->pos;
> +       if (kit->pos =3D=3D &init_task)
> +               kit->pos =3D NULL;
> +
> +out:
> +       return pos;
> +}
> +
> +__bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
> +{
> +}
> +
>  DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>
>  static void do_mmap_read_unlock(struct irq_work *entry)
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index 8b53537e0f27..1ec82997cce7 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -457,5 +457,10 @@ extern int bpf_iter_css_task_new(struct bpf_iter_css=
_task *it,
>  extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_ta=
sk *it) __weak __ksym;
>  extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __we=
ak __ksym;
>
> +struct bpf_iter_task;
> +extern int bpf_iter_task_new(struct bpf_iter_task *it,
> +               struct task_struct *task, unsigned int flags) __weak __ks=
ym;
> +extern struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it) =
__weak __ksym;
> +extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksy=
m;
>
>  #endif
> --
> 2.20.1
>

