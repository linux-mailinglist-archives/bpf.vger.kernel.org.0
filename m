Return-Path: <bpf+bounces-20211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3683A5E2
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 10:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7BB1C28851
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59618042;
	Wed, 24 Jan 2024 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsH3usdq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43118035
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089757; cv=none; b=uc0VdS7hdV5T9ZqmVGCUBGM1DrWTACc4a7+mKEaH4e5C10MXdt5ndv7KyqZ4x+k0GyBDTCcaJYbzysoZKBsdQdtn2heREWT0GCEn+p9NdggxFWk+tZZTbFXmSkNBLeuafTBNxOoYgwjN3EqKBog4fz5PJdK168nw/n2SIAOHa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089757; c=relaxed/simple;
	bh=PUmNZfJX8LPVpWJ7330Lf7PbqPvxQkOmFZBQVqO+opo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtOtPoLVn8wO74hVpjIXveppIdGaJbv1ozkt3YVzUhrvyWMc5gV2qhkWJorN1RvyFbZ7YZRLdH/SrixZ6K3j7R2n75bAHxFH0rfb/cYqyYfdl8Z/85ItwlSr9OLbVShcf5CKUGH22Y4rcLTgBDormPCrQQEIYKs96JY7GFdT+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsH3usdq; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6806914dba7so37006406d6.2
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 01:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706089754; x=1706694554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moRrTnRcyimJ0i6nVkig/RwkVdMTvzVsKTfkkprAtGk=;
        b=bsH3usdqOxbWqLcmeOANVdKKh0EE0lQ0XYWEz+9FBamlXmxrsz2jj22a+BfFb/nlQK
         xL+wF58WVhpcYJH69NNynKHDyaboR51ThPEBpnXYHMoUmvyYqVJVoB1XBj7I64dDHclG
         Eiv2Mux/E+M5CvZstxi4CJyqpnCNiNudkZZL305J+eWD2kdswnK0KSb80xb0HV2fizAE
         r8IoNMQLDI+WYf4vyYhJFj3EUsmxKkz0jnir4v9hNsPxcza2VS77PpPoyhVa4v6zhUOX
         1qSmfPIjmGDGRgzHLGNUwFZKojypayiA2GqoOiPi5ZgVPOwto51+UBZvcBQc+vh3/USo
         pcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706089754; x=1706694554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moRrTnRcyimJ0i6nVkig/RwkVdMTvzVsKTfkkprAtGk=;
        b=YvLhdSNZZAT6ELe38R20rXVWCMQuTyQJIOQ/lw5Uhh0ldDq8q6Buj0Aq8jssg0i5Ot
         Max2yyAh6S58cK085gOyw80YDscxq81SGV+uaM2rh9AIpwfvpdUzYMVLy0eEgAh7qnIF
         EiXFLWFbSxsbDl1ItoHkWYDVmCxHdpqR1pxzwv9yPy6htV3HzZZuKu328D9vv9GakFeJ
         FuQQGPfQ5EPzxQFubSMNgaaNtWdcCp9xaIoEKS6K5T5KO4hbFEVIQ46VsDwl/OMYzfAP
         CG7zTZFzOcL6UsMnHa5KhlGkepRfAkXKZUuZ9IaRl+dQhRYmY+x4Wybvu5E7ElVeUqn9
         8VGg==
X-Gm-Message-State: AOJu0YzuVgTvShQvlBa9ulbENjMRwucorTnMikjUDQYzbAxt/n0HsAcf
	7CwpASyXBtRYVTm+dA3jZpOg4sUO9W/SHm7MEwgetkYnUxsjKgddu9JvXQRy65NqkDG8Mc8T3vS
	tCC8PYIpg02F3gPripwYZWfcx3AA=
X-Google-Smtp-Source: AGHT+IGosndrnKa+56TpmEcOwQOa17QjZdgejp6zn56lfnEtEs5YA0jS0ZJLEm9QC0MikdPFNXLRmbfqJib9mhW3fdk=
X-Received: by 2002:ad4:5c6c:0:b0:681:6036:8680 with SMTP id
 i12-20020ad45c6c000000b0068160368680mr2530984qvh.61.1706089754188; Wed, 24
 Jan 2024 01:49:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123152716.5975-1-laoar.shao@gmail.com> <20240123152716.5975-4-laoar.shao@gmail.com>
 <20240123204757.GC30071@maniforge>
In-Reply-To: <20240123204757.GC30071@maniforge>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 24 Jan 2024 17:48:38 +0800
Message-ID: <CALOAHbAThCKRk5h1icu_vgSgcxUZJi_ZdKGndrhwvXxeLoT6+A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: Add selftests for cpumask iter
To: David Vernet <void@manifault.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 4:48=E2=80=AFAM David Vernet <void@manifault.com> w=
rote:
>
> On Tue, Jan 23, 2024 at 11:27:16PM +0800, Yafang Shao wrote:
> > Within the BPF program, we leverage the cgroup iterator to iterate thro=
ugh
> > percpu runqueue data, specifically the 'nr_running' metric. Subsequentl=
y
> >  we expose this data to userspace by means of a sequence file.
> >
> > The CPU affinity for the cpumask is determined by the PID of a task:
> >
> > - PID of the init task (PID 1)
> >   We typically don't set CPU affinity for init task and thus we can ite=
rate
> >   across all possible CPUs using the init task. However, in scenarios w=
here
> >   you've set CPU affinity for the init task, you should set your
> >   current-task's cpu affinity to all possible CPUs and then proceed to
> >   iterate through all possible CPUs using the current task.
> > - PID of a task with defined CPU affinity
> >   The aim here is to iterate through a specific cpumask. This scenario
> >   aligns with tasks residing within a cpuset cgroup.
> > - Invalid PID (e.g., PID -1)
> >   No cpumask is available in this case.
> >
> > The result as follows,
> >   #65/1    cpumask_iter/init_pid:OK
> >   #65/2    cpumask_iter/invalid_pid:OK
> >   #65/3    cpumask_iter/self_pid_one_cpu:OK
> >   #65/4    cpumask_iter/self_pid_multi_cpus:OK
> >   #65      cpumask_iter:OK
> >   Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> >
> > CONFIG_PSI=3Dy is required for this testcase.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/config            |   1 +
> >  .../selftests/bpf/prog_tests/cpumask_iter.c   | 130 ++++++++++++++++++
> >  .../selftests/bpf/progs/cpumask_common.h      |   3 +
> >  .../selftests/bpf/progs/test_cpumask_iter.c   |  56 ++++++++
> >  4 files changed, 190 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask_iter=
.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_cpumask_iter=
.c
> >
> > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftes=
ts/bpf/config
> > index c125c441abc7..9c42568ed376 100644
> > --- a/tools/testing/selftests/bpf/config
> > +++ b/tools/testing/selftests/bpf/config
> > @@ -78,6 +78,7 @@ CONFIG_NF_CONNTRACK_MARK=3Dy
> >  CONFIG_NF_DEFRAG_IPV4=3Dy
> >  CONFIG_NF_DEFRAG_IPV6=3Dy
> >  CONFIG_NF_NAT=3Dy
> > +CONFIG_PSI=3Dy
> >  CONFIG_RC_CORE=3Dy
> >  CONFIG_SECURITY=3Dy
> >  CONFIG_SECURITYFS=3Dy
> > diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c b/to=
ols/testing/selftests/bpf/prog_tests/cpumask_iter.c
> > new file mode 100644
> > index 000000000000..1db4efc57c5f
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
> > @@ -0,0 +1,130 @@
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
>
> In general it seems wrong for this to be void. If we fail to verify
> something, why would we want to keep chugging along in the caller? That
> seems like it would just add a bunch of test failure noise for all the
> stuff that fails after.

makes sense.

>
> > +{
> > +     int iter_fd, len, item, nr_running, psi_running, nr_cpus;
> > +     char buf[128];
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
>
> I don't think there's any reason we should need to do string parsing
> like this. We can set all of these variables from BPF and then check
> them in the skeleton from user space.


I agree with your point about the simplification achieved through
skeleton variables. However, it's worth noting that a seq file in this
context serves to demonstrate how we expose the data through a seq
file.

>
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
> > +out:
> > +     close(iter_fd);
> > +}
> > +
> > +void test_cpumask_iter(void)
>
> We should also have negative testcases that verify that we fail to load
> with bogus / unsafe inputs. See e.g. [0].

will add it.

>
> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tre=
e/tools/testing/selftests/bpf/progs/cpumask_failure.c
>
> > +{
> > +     DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> > +     int nr_possible, cgrp_fd, pid, err, cnt, i;
> > +     struct test_cpumask_iter *skel;
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
> > +             goto free_link;
> > +
> > +     cnt =3D CPU_COUNT(&set);
> > +     nr_possible =3D bpf_num_possible_cpus();
> > +     if (test__start_subtest("init_pid"))
>
> Can you instead please do what we do in [1] and have each testcase be
> self contained and separately invoked? Doing things the way you have it
> in this patch has a few drawbacks:
>
> 1. The testcases are now all interdependent. If one fails we continue
>    onto others even though we may or may not have any reason to believe
>    that the system state is sane or what we expect. If the later
>    testcases fail, what does it even mean? Or if they pass, is that
>    expected? We should be setting up and tearing down whatever state we
>    need between testcases to have confidence that the signal from each
>    testcase is independent of whatever signal was in the previous one.
>
> 2. This is also confusing because we're doing a bunch of validation and
>    testing even if test__start_subtest() returns false.  It's unclear
>    what the expecations are in such a case, and I think it's a lot more
>    logical if you just don't do anything and skip the testcase.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tre=
e/tools/testing/selftests/bpf/prog_tests/cpumask.c#n8

Will check it. Appreciate your insights. Thank you.

>
> > +             /* current task is running. */
> > +             verify_percpu_data(link, cnt, cnt =3D=3D nr_possible ? 1 =
: 0);
> > +
> > +     skel->bss->target_pid =3D -1;
> > +     if (test__start_subtest("invalid_pid"))
> > +             verify_percpu_data(link, -1, -1);
> > +
> > +     pid =3D getpid();
> > +     skel->bss->target_pid =3D pid;
> > +     CPU_ZERO(&set);
> > +     CPU_SET(0, &set);
> > +     err =3D sched_setaffinity(pid, sizeof(set), &set);
> > +     if (!ASSERT_OK(err, "setaffinity"))
> > +             goto free_link;
> > +
> > +     if (test__start_subtest("self_pid_one_cpu"))
> > +             verify_percpu_data(link, 1, 1);
> > +
> > +     /* Assume there are at least 8 CPUs on the testbed */
> > +     if (nr_possible < 8)
> > +             goto free_link;
> > +
> > +     CPU_ZERO(&set);
> > +     /* Set the CPU affinitiy: 1,3-5 */
> > +     for (i =3D 0; i < ARRAY_SIZE(cpu_ids); i++)
> > +             CPU_SET(cpu_ids[i], &set);
> > +     err =3D sched_setaffinity(pid, sizeof(set), &set);
> > +     if (!ASSERT_OK(err, "setaffinity"))
> > +             goto free_link;
> > +
> > +     if (test__start_subtest("self_pid_multi_cpus"))
> > +             verify_percpu_data(link, ARRAY_SIZE(cpu_ids), 1);
> > +
> > +free_link:
> > +     bpf_link__destroy(link);
> > +close_fd:
> > +     close(cgrp_fd);
> > +cleanup:
> > +     cleanup_cgroup_environment();
> > +destroy:
> > +     test_cpumask_iter__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools=
/testing/selftests/bpf/progs/cpumask_common.h
> > index 0cd4aebb97cf..cdb9dc95e9d9 100644
> > --- a/tools/testing/selftests/bpf/progs/cpumask_common.h
> > +++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
> > @@ -55,6 +55,9 @@ void bpf_cpumask_copy(struct bpf_cpumask *dst, const =
struct cpumask *src) __ksym
> >  u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym;
> >  u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1, const s=
truct cpumask *src2) __ksym;
> >  u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
> > +int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const struct cpu=
mask *mask) __ksym;
> > +int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it) __ksym;
> > +void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it) __ksym;
> >
> >  void bpf_rcu_read_lock(void) __ksym;
> >  void bpf_rcu_read_unlock(void) __ksym;
> > diff --git a/tools/testing/selftests/bpf/progs/test_cpumask_iter.c b/to=
ols/testing/selftests/bpf/progs/test_cpumask_iter.c
> > new file mode 100644
> > index 000000000000..cb8b8359516b
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_cpumask_iter.c
> > @@ -0,0 +1,56 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +#include "task_kfunc_common.h"
> > +#include "cpumask_common.h"
> > +
> > +extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
> > +extern const struct rq runqueues __ksym __weak;
> > +
> > +int target_pid;
> > +
> > +SEC("iter.s/cgroup")
> > +int BPF_PROG(cpu_cgroup, struct bpf_iter_meta *meta, struct cgroup *cg=
rp)
> > +{
> > +     u32 nr_running =3D 0, psi_nr_running =3D 0, nr_cpus =3D 0;
> > +     struct psi_group_cpu *groupc;
> > +     struct task_struct *p;
> > +     struct rq *rq;
> > +     int *cpu;
> > +
> > +     /* epilogue */
> > +     if (cgrp =3D=3D NULL)
> > +             return 0;
> > +
> > +     bpf_rcu_read_lock();
>
> Why is this required? p->cpus_ptr should be trusted given that @p is
> trusted, no? Does this fail to load if you don't have all of this in an
> RCU read region?

It is a sleepable prog iter.s, so we must explicitly add a rcu lock,
otherwise the load will fail.

>
> > +     p =3D bpf_task_from_pid(target_pid);
> > +     if (!p) {
> > +             bpf_rcu_read_unlock();
> > +             return 1;
> > +     }
> > +
> > +     bpf_for_each(cpumask, cpu, p->cpus_ptr) {
> > +             rq =3D (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
> > +             if (!rq)
> > +                     continue;
>
> If this happens we should set an error code and check it in user space.

sure, will do it.

>
> > +             nr_running +=3D rq->nr_running;
> > +             nr_cpus +=3D 1;
> > +
> > +             groupc =3D (struct psi_group_cpu *)bpf_per_cpu_ptr(&syste=
m_group_pcpu, *cpu);
> > +             if (!groupc)
> > +                     continue;
>
> Same here.

will do it.

>
> > +             psi_nr_running +=3D groupc->tasks[NR_RUNNING];
> > +     }
> > +     BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %=
u\n",
> > +                    nr_running, nr_cpus, psi_nr_running);
> > +
> > +     bpf_task_release(p);
> > +     bpf_rcu_read_unlock();
> > +     return 0;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
>
> Can you please move this to the top of the file?

will do it.

--=20
Regards
Yafang

