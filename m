Return-Path: <bpf+bounces-12041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4B87C732A
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FC2282A87
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B20F262B2;
	Thu, 12 Oct 2023 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPd/PmpY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCBA20E5
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 16:37:31 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BC8A9
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:37:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so2087538a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697128649; x=1697733449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg/yVdPTNW+mWbWNMCEbQmFECg0QJFePFEDfwVENIhA=;
        b=BPd/PmpYCj7tf8r1FsTyl3BsH7M8bCpq+u2j4T6M775fGWPNPOttUnyyg7rqDhmJS7
         woSepE7rQzhk2yTGs7IJNxOHZ9gsWasLqV1AZ5iNeGQ8YphFQcrBMIOZ08sLMV7bug+u
         vAZBMfTuBwoTnOab3DXCssavEDo40zBHDVPRIkeAMExG2XvbdakLLfiMVpPhuEjzURNY
         cOWT6QsQbS3jSfDoAEvgTcpYidVA+jUEhRE88ftIsO558wv+3M/TRYHO80+SpwlQWERI
         82wd2ieGHSEkshT/IZaX+PZKA6NpiT9ZKqWpiVBjTV6LRRCeRCHkUJADC2cT07Cvte+D
         W9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128649; x=1697733449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg/yVdPTNW+mWbWNMCEbQmFECg0QJFePFEDfwVENIhA=;
        b=M9qps8kIkTYte5zMIQCBnQRXt/UvoXbzN7m/bZ84e442rU8Uy12Ctib5b/lVztCNCP
         SiGSAPnwJytn6su5SLIqLHM/ELrzbF6UeOnHurfmhobxuh2DLCIyqIPUXC6bjMGGJtNF
         AOM6pxq28bY0/Z8EKz4Buw5VF4DVJ20Ap2tTFSmlyeJipeTPxCqItLWpgrb6O9YJrR7d
         EclvahSGTCq389DOJ1S2M/i2dgP6ZQ4CpdtIDVn3fHRGhW8Nb0RdcrDfhwHofRSDEZlH
         03BK7AjQKmdtCVRWTGOevNH8q7wj8+6IKS6oNShH+klOjBdyAUunWkJhNvjYNwpQYEPJ
         Xq0w==
X-Gm-Message-State: AOJu0YxwsC7BF6E4QvQ6UpyZwsiiSXj1Vsw7d+oO/fjR2wMaP/P3f4WV
	BcKWJ+jJC1ce8HHQDpHMQ+w3ZnpPls2TY2aHXXY=
X-Google-Smtp-Source: AGHT+IHHlFohVcWXLV44poj1IwppeZpxtaO8H+bkjQShP7z2LpMP29Hz9Z48hsNIoonzm9p9N2JyQfHqYP9q+V8Vbc0=
X-Received: by 2002:a05:6402:344a:b0:531:5126:cd5e with SMTP id
 l10-20020a056402344a00b005315126cd5emr22259185edc.34.1697128648722; Thu, 12
 Oct 2023 09:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011223728.3188086-1-andrii@kernel.org> <20231011223728.3188086-2-andrii@kernel.org>
 <CALOAHbDMtn-Z7p6+oJG3D=fDpreDLb7hzRjrbPgiPn30=heDCA@mail.gmail.com>
In-Reply-To: <CALOAHbDMtn-Z7p6+oJG3D=fDpreDLb7hzRjrbPgiPn30=heDCA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 09:37:17 -0700
Message-ID: <CAEf4BzaC6SHtJ_-GEoDqVWk5QMVM8OinhCrPg9-SwSVw7piM2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: improve percpu_alloc test robustness
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 11:04=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Thu, Oct 12, 2023 at 6:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > Make these non-serial tests filter BPF programs by intended PID of
> > a test runner process. This makes it isolated from other parallel tests
> > that might interfere accidentally.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/percpu_alloc.c      | 3 +++
> >  tools/testing/selftests/bpf/progs/percpu_alloc_array.c     | 7 +++++++
> >  .../selftests/bpf/progs/percpu_alloc_cgrp_local_storage.c  | 4 ++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/to=
ols/testing/selftests/bpf/prog_tests/percpu_alloc.c
> > index 9541e9b3a034..343da65864d6 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> > @@ -19,6 +19,7 @@ static void test_array(void)
> >         bpf_program__set_autoload(skel->progs.test_array_map_3, true);
> >         bpf_program__set_autoload(skel->progs.test_array_map_4, true);
> >
> > +       skel->bss->my_pid =3D getpid();
> >         skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
> >
> >         err =3D percpu_alloc_array__load(skel);
> > @@ -51,6 +52,7 @@ static void test_array_sleepable(void)
> >
> >         bpf_program__set_autoload(skel->progs.test_array_map_10, true);
> >
> > +       skel->bss->my_pid =3D getpid();
> >         skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
> >
> >         err =3D percpu_alloc_array__load(skel);
> > @@ -85,6 +87,7 @@ static void test_cgrp_local_storage(void)
> >         if (!ASSERT_OK_PTR(skel, "percpu_alloc_cgrp_local_storage__open=
"))
> >                 goto close_fd;
> >
> > +       skel->bss->my_pid =3D getpid();
> >         skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
> >
> >         err =3D percpu_alloc_cgrp_local_storage__load(skel);
> > diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c b/t=
ools/testing/selftests/bpf/progs/percpu_alloc_array.c
> > index bbc45346e006..37c2d2608ec0 100644
> > --- a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
> > +++ b/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
> > @@ -71,6 +71,7 @@ int BPF_PROG(test_array_map_2)
> >  }
> >
> >  int cpu0_field_d, sum_field_c;
> > +int my_pid;
> >
> >  /* Summarize percpu data */
> >  SEC("?fentry/bpf_fentry_test3")
> > @@ -81,6 +82,9 @@ int BPF_PROG(test_array_map_3)
> >         struct val_t *v;
> >         struct elem *e;
> >
> > +       if ((bpf_get_current_pid_tgid() >> 32) !=3D my_pid)
> > +               return 0;
> > +
> >         e =3D bpf_map_lookup_elem(&array, &index);
> >         if (!e)
> >                 return 0;
> > @@ -130,6 +134,9 @@ int BPF_PROG(test_array_map_10)
> >         struct val_t *v;
> >         struct elem *e;
> >
> > +       if ((bpf_get_current_pid_tgid() >> 32) !=3D my_pid)
> > +               return 0;
> > +
> >         e =3D bpf_map_lookup_elem(&array, &index);
> >         if (!e)
> >                 return 0;
> > diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_=
storage.c b/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_stora=
ge.c
> > index 1c36a241852c..a2acf9aa6c24 100644
> > --- a/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_storage=
.c
> > +++ b/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_storage=
.c
> > @@ -70,6 +70,7 @@ int BPF_PROG(test_cgrp_local_storage_2)
> >  }
> >
> >  int cpu0_field_d, sum_field_c;
> > +int my_pid;
> >
> >  /* Summarize percpu data collection */
> >  SEC("fentry/bpf_fentry_test3")
> > @@ -81,6 +82,9 @@ int BPF_PROG(test_cgrp_local_storage_3)
> >         struct elem *e;
> >         int i;
> >
> > +       if ((bpf_get_current_pid_tgid() >> 32) !=3D my_pid)
> > +               return 0;
> > +
> >         task =3D bpf_get_current_task_btf();
>
> a small nit.
>
> We have already got the current task. Should we better use
>
>     if (task->pid !=3D my_pid)
>
> instead ?
>

doesn't matter, it's a standard snippet of code we have in all the
tests that might have interference from parallel tests

> >         e =3D bpf_cgrp_storage_get(&cgrp, task->cgroups->dfl_cgrp, 0, 0=
);
> >         if (!e)
> > --
> > 2.34.1
> >
> >
>
>
> --
> Regards
> Yafang

