Return-Path: <bpf+bounces-11993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0708B7C6514
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06E22827E1
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C5AD280;
	Thu, 12 Oct 2023 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoThQ1Jv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A21D274
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:04:39 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332C8A9
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:04:38 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66cfd874520so3851426d6.2
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697090677; x=1697695477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGffhN/kq3nYZQ0UQR3oRJAdEa3CCgMAsQ84VBfGP4E=;
        b=NoThQ1JvbLDcuTt7i5RgCAJvg2z8lojkkGmFJs3lU5p7R0xijrSLPJ8ATU1SXu8QxO
         VmoBisuMVcwSupubhtGsiLDMVIxfpEY2iDnfsrYPZlJeR59kOwftUgNjvG0P9UcY3hEw
         n78qEVvxIscNtqpbHm69kd7m5q6Jm3KdiUNvdGhL6C+BeCCTykTB7KU0j+h68OpoVkPV
         eel9U+qQmCSlso+X0iN7doBkGthv4M8qxiW6FbNuIxa0TY7VJbHMRKfS7rjil2UzKNri
         a1eKCwsV3Yc6gUgKICTV9+7IEvtR9t7NkAuFpP1Sv9sAN0zzCJDmX069e3f2gXsWRPjk
         LckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697090677; x=1697695477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGffhN/kq3nYZQ0UQR3oRJAdEa3CCgMAsQ84VBfGP4E=;
        b=AZ/s8ZfE+ijkLrwHZj4FGN2CYOrmDLZC/x8a/A+5LTDfFx96FyvZJFvh+xT7C0ovLl
         SLmq4hZHBRR2NFaS4RPsFYldTwGOXsdstfExKsK4b7X3VH8IytW2eph1bhG59HwgxTcQ
         Ft7D6YXYyoEgJJcJxOeNvDCWE9fJX64wSc8zo7NLgJNyVNCe0JnWvBquPZk5ud+UZyy2
         uIc+QNIW6RTuxQuteC09js+mUL7/8IpTwevfqcahRksW9gY86ImTFZjfxjEU3jkBjZ/q
         zu7d1uXpEew7AyvuQOmTL8cBWILxsobMdjrEP9FhQRNVCGhxtG8o0ndLTUUPIWgkBqQj
         Q+aA==
X-Gm-Message-State: AOJu0Yx1Kl5mm1q+J/oBzK05Ti2y7QtLW8RTlSSleg7WUp11VnKAnr7m
	6Ey4LEVupMREhQIPY0GgmUF/SBdlcIovgdg/Jlg=
X-Google-Smtp-Source: AGHT+IFdNdOlXDK9YZneYtDEaV1PQvgL9bfFbyaUyQcOGyIidesXbrZe2STB3c+zgUFBiLqY6rzbNF6Bk9QigVkMQn4=
X-Received: by 2002:a05:6214:4285:b0:658:708c:4d56 with SMTP id
 og5-20020a056214428500b00658708c4d56mr23048987qvb.17.1697090677260; Wed, 11
 Oct 2023 23:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011223728.3188086-1-andrii@kernel.org> <20231011223728.3188086-2-andrii@kernel.org>
In-Reply-To: <20231011223728.3188086-2-andrii@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 12 Oct 2023 14:04:01 +0800
Message-ID: <CALOAHbDMtn-Z7p6+oJG3D=fDpreDLb7hzRjrbPgiPn30=heDCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: improve percpu_alloc test robustness
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 6:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Make these non-serial tests filter BPF programs by intended PID of
> a test runner process. This makes it isolated from other parallel tests
> that might interfere accidentally.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/percpu_alloc.c      | 3 +++
>  tools/testing/selftests/bpf/progs/percpu_alloc_array.c     | 7 +++++++
>  .../selftests/bpf/progs/percpu_alloc_cgrp_local_storage.c  | 4 ++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tool=
s/testing/selftests/bpf/prog_tests/percpu_alloc.c
> index 9541e9b3a034..343da65864d6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> @@ -19,6 +19,7 @@ static void test_array(void)
>         bpf_program__set_autoload(skel->progs.test_array_map_3, true);
>         bpf_program__set_autoload(skel->progs.test_array_map_4, true);
>
> +       skel->bss->my_pid =3D getpid();
>         skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
>
>         err =3D percpu_alloc_array__load(skel);
> @@ -51,6 +52,7 @@ static void test_array_sleepable(void)
>
>         bpf_program__set_autoload(skel->progs.test_array_map_10, true);
>
> +       skel->bss->my_pid =3D getpid();
>         skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
>
>         err =3D percpu_alloc_array__load(skel);
> @@ -85,6 +87,7 @@ static void test_cgrp_local_storage(void)
>         if (!ASSERT_OK_PTR(skel, "percpu_alloc_cgrp_local_storage__open")=
)
>                 goto close_fd;
>
> +       skel->bss->my_pid =3D getpid();
>         skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
>
>         err =3D percpu_alloc_cgrp_local_storage__load(skel);
> diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c b/too=
ls/testing/selftests/bpf/progs/percpu_alloc_array.c
> index bbc45346e006..37c2d2608ec0 100644
> --- a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
> +++ b/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
> @@ -71,6 +71,7 @@ int BPF_PROG(test_array_map_2)
>  }
>
>  int cpu0_field_d, sum_field_c;
> +int my_pid;
>
>  /* Summarize percpu data */
>  SEC("?fentry/bpf_fentry_test3")
> @@ -81,6 +82,9 @@ int BPF_PROG(test_array_map_3)
>         struct val_t *v;
>         struct elem *e;
>
> +       if ((bpf_get_current_pid_tgid() >> 32) !=3D my_pid)
> +               return 0;
> +
>         e =3D bpf_map_lookup_elem(&array, &index);
>         if (!e)
>                 return 0;
> @@ -130,6 +134,9 @@ int BPF_PROG(test_array_map_10)
>         struct val_t *v;
>         struct elem *e;
>
> +       if ((bpf_get_current_pid_tgid() >> 32) !=3D my_pid)
> +               return 0;
> +
>         e =3D bpf_map_lookup_elem(&array, &index);
>         if (!e)
>                 return 0;
> diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_st=
orage.c b/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_storage=
.c
> index 1c36a241852c..a2acf9aa6c24 100644
> --- a/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_storage.c
> +++ b/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_storage.c
> @@ -70,6 +70,7 @@ int BPF_PROG(test_cgrp_local_storage_2)
>  }
>
>  int cpu0_field_d, sum_field_c;
> +int my_pid;
>
>  /* Summarize percpu data collection */
>  SEC("fentry/bpf_fentry_test3")
> @@ -81,6 +82,9 @@ int BPF_PROG(test_cgrp_local_storage_3)
>         struct elem *e;
>         int i;
>
> +       if ((bpf_get_current_pid_tgid() >> 32) !=3D my_pid)
> +               return 0;
> +
>         task =3D bpf_get_current_task_btf();

a small nit.

We have already got the current task. Should we better use

    if (task->pid !=3D my_pid)

instead ?

>         e =3D bpf_cgrp_storage_get(&cgrp, task->cgroups->dfl_cgrp, 0, 0);
>         if (!e)
> --
> 2.34.1
>
>


--=20
Regards
Yafang

