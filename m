Return-Path: <bpf+bounces-19970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6F83543B
	for <lists+bpf@lfdr.de>; Sun, 21 Jan 2024 03:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC6E1C20BF1
	for <lists+bpf@lfdr.de>; Sun, 21 Jan 2024 02:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E912EB1A;
	Sun, 21 Jan 2024 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbHXCfW2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044C25610
	for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705805151; cv=none; b=Eg0r5vtjCOJPPEtacgtqy/pvZZwj2GRJgAoHyJiBWRPsO0sgmhG/TaWjJqmwCbT2DYgwQOMgWh017QGLubWny0q5LNDtnuMBd/lpTGf77ART/aB3i7MHaIRll+2mm0IGcd9fJwjOWYciwQ40WQ2Q91kdLKvhz60F1xFC4TULhHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705805151; c=relaxed/simple;
	bh=+8N500xhiIHQF3aZw7obv4ctHfARwoDsWN4Gs8j5Tsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB7LVuR3jDPibLtJQgCUt4f7XO3XCjDoLzBm0fvPMUhgMN5gcGdIRU6b/+iPjozOUg7mNGCa8ArjwQbvImpwJIzmcsTpV8oL4zlYPsWkZSrjXJ0VPtbVOxJXUE1y6T+460p8nemC3jGLbNJNplmMw97gIsrt+3sZ+KWD3McLdhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbHXCfW2; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68175861f3eso13391166d6.3
        for <bpf@vger.kernel.org>; Sat, 20 Jan 2024 18:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705805148; x=1706409948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJHnqA3/8wt1dWUniH/VhrlqouHHGK+cL42PUR1/DkQ=;
        b=MbHXCfW2p4ZdpZhdmJRHa5HtuqRiLEnVaUEdnl56tpsBCzpAJx/kTq/4y2GuHYzFvX
         wI0911PoDDYBnA9lujw4He0Yj8qWvRfYxcfOS8z9+oxlqlxxW3Xde2vd8Pu1AkZu2sN0
         XcqobE+QD+ExtBH7WSar37uF1ca/Q5RvAvn9ugN1cJALLZHRtn8uEsFX1YU7CmKiOQ/a
         jOYMgTdfkiq2BjXA2RsEpKWXknwGcMklyF3ADqJN2aZpYUWZM/CouGoBseEztKObDoDc
         1m7wNiplhn9jsK01ZxIlPkWP6fA8Ir8D2u2lvoFCxu21bfyjC37MmKLlPsKNmJ08hbFT
         iVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705805148; x=1706409948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJHnqA3/8wt1dWUniH/VhrlqouHHGK+cL42PUR1/DkQ=;
        b=tAWoLa5Y/ls/B89LWgyRb35ytH9vGHkUDgXqiA05v340azU0rSte7+gPW5UjLeQfDN
         AM7RXtYz8ZIZ4l3Wm6zCXvrRkBHsx4OF97YyTM/fICMYp4OJqgTPK+Pi1/8moQlxIlUl
         KNZTwCWAha1t4bvNdTZ0DtFbLP/3Tj0haiCcFdi3ivMrNTjp50ndOeY1nTUGZwTHZUBK
         FJ6l9UIR83nvny4Ql0+MaUgkzaXmsrlP1di4iW4yRKqXTxZc2Cr09U5OmwMuJEXGMOcm
         LMnCT9fNj/g8h0IunTunDs8nn4Tsx9DlT3x3jBsR6ArzHrJ6CxI+tvCWd7vYxxXCZ/6w
         thXQ==
X-Gm-Message-State: AOJu0Yxp+bx03hw6TEhya2TfJBoGLs5BO3bGuLH4EDg85GGCX1dbZWe2
	dkdXdzR1Ei5zclA4RXHDLSsx+KMquFl4wvpzgtIgloCx5hwnma2/m4jBOkWjJxxReW5Fekr+d/J
	h69Oz0I4O22fsaXrlxRzsJ/bfPQo=
X-Google-Smtp-Source: AGHT+IHj9uFp3SaFRdyl4qxFZV+lSTKVfHwoqbft5b7IV/ExK0X2lkRgYNpaaJ6vovnLy6Tsa1RQv8j+eW91iDYOuKg=
X-Received: by 2002:a05:6214:2581:b0:682:54df:4d31 with SMTP id
 fq1-20020a056214258100b0068254df4d31mr3052879qvb.71.1705805148704; Sat, 20
 Jan 2024 18:45:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117024823.4186-1-laoar.shao@gmail.com> <20240117024823.4186-4-laoar.shao@gmail.com>
 <7e1e4aec-c33f-4d71-9add-5f15849f9075@linux.dev>
In-Reply-To: <7e1e4aec-c33f-4d71-9add-5f15849f9075@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 21 Jan 2024 10:45:11 +0800
Message-ID: <CALOAHbC-hw=tSKCjPPhqxWrsDEu_2+VxULzRZ_-oKTQMWrXxwQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: Add selftests for cpumask iter
To: Yonghong Song <yonghong.song@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org, 
	bpf@vger.kernel.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 7:46=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 1/16/24 6:48 PM, Yafang Shao wrote:
> > Within the BPF program, we leverage the cgroup iterator to iterate thro=
ugh
> > percpu runqueue data, specifically the 'nr_running' metric. Subsequentl=
y
> >   we expose this data to userspace by means of a sequence file.
> >
> > The CPU affinity for the cpumask is determined by the PID of a task:
> >
> > - PID of the init task (PID 1)
> >    We typically don't set CPU affinity for init task and thus we can it=
erate
> >    across all possible CPUs. However, in scenarios where you've set CPU
> >    affinity for the init task, you should set the cpumask of your curre=
nt
> >    task to full-F. Then proceed to iterate through all possible CPUs us=
ing
>
> Wat is full-F? It would be good if you can clarify in the commit message.

I mean set all available CPUs for the task.
Will clarify it in the next version.

>
> >    the current task.
> > - PID of a task with defined CPU affinity
> >    The aim here is to iterate through a specific cpumask. This scenario
> >    aligns with tasks residing within a cpuset cgroup.
> > - Invalid PID (e.g., PID -1)
> >    No cpumask is available in this case.
> >
> > The result as follows,
> >    #65/1    cpumask_iter/init_pid:OK
> >    #65/2    cpumask_iter/invalid_pid:OK
> >    #65/3    cpumask_iter/self_pid_one_cpu:OK
> >    #65/4    cpumask_iter/self_pid_multi_cpus:OK
> >    #65      cpumask_iter:OK
> >    Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> >
> > CONFIG_PSI=3Dy is required for this testcase.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   tools/testing/selftests/bpf/config            |   1 +
> >   .../selftests/bpf/prog_tests/cpumask_iter.c   | 134 +++++++++++++++++=
+
> >   .../selftests/bpf/progs/cpumask_common.h      |   3 +
> >   .../selftests/bpf/progs/test_cpumask_iter.c   |  56 ++++++++
> >   4 files changed, 194 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask_ite=
r.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/test_cpumask_ite=
r.c
> >
> > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftes=
ts/bpf/config
> > index c125c441abc7..9c42568ed376 100644
> > --- a/tools/testing/selftests/bpf/config
> > +++ b/tools/testing/selftests/bpf/config
> > @@ -78,6 +78,7 @@ CONFIG_NF_CONNTRACK_MARK=3Dy
> >   CONFIG_NF_DEFRAG_IPV4=3Dy
> >   CONFIG_NF_DEFRAG_IPV6=3Dy
> >   CONFIG_NF_NAT=3Dy
> > +CONFIG_PSI=3Dy
> >   CONFIG_RC_CORE=3Dy
> >   CONFIG_SECURITY=3Dy
> >   CONFIG_SECURITYFS=3Dy
> > diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c b/to=
ols/testing/selftests/bpf/prog_tests/cpumask_iter.c
> > new file mode 100644
> > index 000000000000..984d01d09d79
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
> > @@ -0,0 +1,134 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> > +
> > +#define _GNU_SOURCE
> > +#include <sched.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +
> > +#include <test_progs.h>
> > +#include "cgroup_helpers.h"
> > +#include "test_cpumask_iter.skel.h"
> > +
> > +static void verify_percpu_data(struct bpf_link *link, int nr_cpu_exp, =
int nr_running_exp)
> > +{
> > +     int iter_fd, len, item, nr_running, psi_running, nr_cpus;
> > +     static char buf[128];
>
> why static?

Will remove it.

>
> > +     size_t left;
> > +     char *p;
> > +
> > +     iter_fd =3D bpf_iter_create(bpf_link__fd(link));
> > +     if (!ASSERT_GE(iter_fd, 0, "iter_fd"))
> > +             return;
> > +
> > +     memset(buf, 0, sizeof(buf));
> > +     left =3D ARRAY_SIZE(buf);
> > +     p =3D buf;
> > +     while ((len =3D read(iter_fd, p, left)) > 0) {
> > +             p +=3D len;
> > +             left -=3D len;
> > +     }
> > +
> > +     item =3D sscanf(buf, "nr_running %u nr_cpus %u psi_running %u\n",
> > +                   &nr_running, &nr_cpus, &psi_running);
> > +     if (nr_cpu_exp =3D=3D -1) {
> > +             ASSERT_EQ(item, -1, "seq_format");
> > +             goto out;
> > +     }
> > +
> > +     ASSERT_EQ(item, 3, "seq_format");
> > +     ASSERT_GE(nr_running, nr_running_exp, "nr_running");
> > +     ASSERT_GE(psi_running, nr_running_exp, "psi_running");
> > +     ASSERT_EQ(nr_cpus, nr_cpu_exp, "nr_cpus");
> > +
> > +     /* read() after iter finishes should be ok. */
> > +     if (len =3D=3D 0)
> > +             ASSERT_OK(read(iter_fd, buf, sizeof(buf)), "second_read")=
;
>
> The above 'if' statement is irrelevant to the main purpose of this test
> and can be removed.

Will remove it.

>
> > +
> > +out:
> > +     close(iter_fd);
> > +}
> > +
> > +void test_cpumask_iter(void)
> > +{
> > +     DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> > +     int nr_possible, cgrp_fd, pid, err, cnt, i;
> > +     struct test_cpumask_iter *skel =3D NULL;
>
> =3D NULL is not needed.

Will change it.

>
> > +     union bpf_iter_link_info linfo;
> > +     int cpu_ids[] =3D {1, 3, 4, 5};
> > +     struct bpf_link *link;
> > +     cpu_set_t set;
> > +
> > +     skel =3D test_cpumask_iter__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "test_for_each_cpu__open_and_load"))
> > +             return;
> > +
> > +     if (setup_cgroup_environment())
> > +             goto destroy;
> > +
> > +     /* Utilize the cgroup iter */
> > +     cgrp_fd =3D get_root_cgroup();
> > +     if (!ASSERT_GE(cgrp_fd, 0, "create cgrp"))
> > +             goto cleanup;
> > +
> > +     memset(&linfo, 0, sizeof(linfo));
> > +     linfo.cgroup.cgroup_fd =3D cgrp_fd;
> > +     linfo.cgroup.order =3D BPF_CGROUP_ITER_SELF_ONLY;
> > +     opts.link_info =3D &linfo;
> > +     opts.link_info_len =3D sizeof(linfo);
> > +
> > +     link =3D bpf_program__attach_iter(skel->progs.cpu_cgroup, &opts);
> > +     if (!ASSERT_OK_PTR(link, "attach_iter"))
> > +             goto close_fd;
> > +
> > +     skel->bss->target_pid =3D 1;
> > +     /* In case init task is set CPU affinity */
> > +     err =3D sched_getaffinity(1, sizeof(set), &set);
> > +     if (!ASSERT_OK(err, "setaffinity"))
> > +             goto close_fd;
>
> goto free_link.

Nice catch. will change it.

>
> > +
> > +     cnt =3D CPU_COUNT(&set);
> > +     nr_possible =3D bpf_num_possible_cpus();
> > +     if (test__start_subtest("init_pid"))
> > +             /* curent task is running. */
> > +             verify_percpu_data(link, cnt, cnt =3D=3D nr_possible ? 1 =
: 0);
> [...]



--=20
Regards
Yafang

