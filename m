Return-Path: <bpf+bounces-53277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EE6A4F480
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EE6188FDE3
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F981459F6;
	Wed,  5 Mar 2025 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8efMz2E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF0DF5C
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140939; cv=none; b=G7b102fZMs2U/V3k3oUk+k1xn/BDKa3CBgl7ZC9FZ2JNa1s7EvjVqkehaRqF+38W/+gmXWNjvT5/+AYkqzv39pZOGlhpYyh9m0jKQncUGzbOEv73j8DhNAXWI8L9lFVnN9SudFh7TkBEcwavzXJPPIdiwPDy/gtpKIby6aKNWxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140939; c=relaxed/simple;
	bh=NlZHdSCdxAEwIwe+z+i7gRmXGjnf5/15MR4L48UbrMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXhPsUYgf0CbkKVPybc1dEBGj+Cfg5z9+52pb+mRgReWhz4XQx5+iPV/X3LLDbpbM1dxKt9AZq8qhnwz5Vvv5u/Sf/KZaxnP0COXkL6/XIOrPupeGXoT+1U3lxg7gmBpoeoyjqbj6eVHOqrhFvQEWs8Kj2frkzY9jgyavWFzlOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8efMz2E; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-abfe7b5fbe8so389539866b.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 18:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741140935; x=1741745735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aodQkwg0VUlVbmedTEzkx7iBTKFtb/sL1zHY1ds70pQ=;
        b=Y8efMz2E9qeFeAcYWn++6IcAsGrDbuqLcq57IJ1xoYQmtNZj9L5xRMwz9JdxgLRouR
         cZ2kmbL43FCjFIyFk6L9v1kotkJnlSHiRboTLihFPgWrEuYo6XAeAylZVgZnGH6bbMPb
         X1AgPeVq9epFO8FrsIuLZ/ZS6Le0ShVWp1Oxephbe2D3gAK8fnkTde8J6ShGoxuI4rrr
         gq8Ta3HTWj3l6sNSXpLoDLtg+LYtOHpw19//z+OHusqKHrIKO2oki7B+nCL2lHPjWtDP
         hywnoNFTGa/7M8Ql444LpSSb9Ov3d+EQg+MIWYPj+UZstwTnrfTwdPzCWR87vGQbq+iS
         Ya5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140935; x=1741745735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aodQkwg0VUlVbmedTEzkx7iBTKFtb/sL1zHY1ds70pQ=;
        b=Rq07U2KyF/vv5tpkONCVY3wpNhe+n004+ULbapaGv3r7M9PrQa9LKWvusOhSi98VL/
         2pmY8m1pTqppmFtZ3PtzdHNeqMZd33JO4JCKcmsXd2e3zUKVUKbaoMp1gbdTUfvkZnBX
         mVlTNsenAVkhX7V0esboYo9+EL+pd99HgvEvhRU3CYOaCzufSJtwWEErAu7372ezSzvF
         mO8uqm+PtlT0eatyfnBCzsN3L/F6sRVG5MV7eFMqg5KCFTK1kZylafS5kHzckf/eEuON
         D94GqVdvBjsBlnWnqjXIf+vDT+A3DF6z0G+APftFu2p6m7oGnZATfzVRN5kKq27AecqE
         6Ifw==
X-Gm-Message-State: AOJu0YyvfMl0yXGcrtY7c4O2jbV1nVBmRfF0ZX6KM8fxrnTzNtfCh1m3
	uXLXBRtINkpVwDTSn8dMTy+kl+OPjpUzUSetM6PFNe0FwCB8YJYuLKjttWwmZ8F4nJ9loo818vW
	NxBuklVoCt/+SMC2qhkX21ZLxrpTTkcT3ZS4=
X-Gm-Gg: ASbGnctd10ydKHUvjeKBFnIQM619ba7b35eb8HlAgEnumPSOKxIC4PdtHbpa7F63rnb
	lDg17DTOJh5dOyvtv7fNiOCEA1ATBKbI8x5dndw3gFksq3XdE02z3XJypP6YNmFH7J8os1wxXLl
	Qdbnlp6cHmSgQLqzfffqpBlPw31eKVK+o2Mnq6EEcIcQFJCt4=
X-Google-Smtp-Source: AGHT+IE4qQYCCDvOGKh7/4Fia+zI9yler1wFFwgDHzM4ZEHPrpSxI0AEyptR5TggmzBH5cArRyjr/Sb/qFaRDAnIuto=
X-Received: by 2002:a05:6402:2714:b0:5dc:6e27:e6e8 with SMTP id
 4fb4d7f45d1cf-5e59f47ced8mr2342497a12.24.1741140935348; Tue, 04 Mar 2025
 18:15:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305011849.1168917-1-memxor@gmail.com> <20250305011849.1168917-4-memxor@gmail.com>
 <CAADnVQ+6snJwWne8ub+Fht1zinDxJZhDxfsfAvPz0Ezfe3dSHg@mail.gmail.com>
In-Reply-To: <CAADnVQ+6snJwWne8ub+Fht1zinDxJZhDxfsfAvPz0Ezfe3dSHg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 5 Mar 2025 03:14:59 +0100
X-Gm-Features: AQ5f1JonKzp9nc9P9XH_Abb4gsklqsm7UaJsEhRhtLYfVu0ccN5ggb-ShAU6ZBI
Message-ID: <CAP01T76BgwiWDs-PxW3jrU3Op877oLyVRyrTP96dzNZGUnRquA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for arena spin lock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2025 at 03:04, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 4, 2025 at 5:18=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > Add some basic selftests for qspinlock built over BPF arena using
> > cond_break_label macro.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../bpf/prog_tests/arena_spin_lock.c          | 102 ++++++++++++++++++
> >  .../selftests/bpf/progs/arena_spin_lock.c     |  51 +++++++++
> >  2 files changed, 153 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_l=
ock.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b=
/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> > new file mode 100644
> > index 000000000000..2cc078ed1ddb
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> > @@ -0,0 +1,102 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > +#include <test_progs.h>
> > +#include <network_helpers.h>
> > +#include <sys/sysinfo.h>
> > +
> > +struct qspinlock { int val; };
> > +typedef struct qspinlock arena_spinlock_t;
> > +
> > +struct arena_qnode {
> > +       unsigned long next;
> > +       int count;
> > +       int locked;
> > +};
> > +
> > +#include "arena_spin_lock.skel.h"
> > +
> > +static long cpu;
> > +int *counter;
> > +
> > +static void *spin_lock_thread(void *arg)
> > +{
> > +       int err, prog_fd =3D *(u32 *)arg;
> > +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> > +               .data_in =3D &pkt_v4,
> > +               .data_size_in =3D sizeof(pkt_v4),
> > +               .repeat =3D 1,
> > +       );
>
> Why bother with 'tc' prog type?
> Pick syscall type, and above will be shorter:
> LIBBPF_OPTS(bpf_test_run_opts, opts);
>

Ack.

> > +       cpu_set_t cpuset;
> > +
> > +       CPU_ZERO(&cpuset);
> > +       CPU_SET(__sync_fetch_and_add(&cpu, 1), &cpuset);
> > +       ASSERT_OK(pthread_setaffinity_np(pthread_self(), sizeof(cpuset)=
, &cpuset), "cpu affinity");
> > +
> > +       while (*READ_ONCE(counter) <=3D 1000) {
>
> READ_ONCE(*counter) ?
>
> but why add this user->kernel switch overhead.
> Use .repeat =3D 1000
> one bpf_prog_test_run_opts()
> and check at the end that *counter =3D=3D 1000 ?

Ok.

>
> > +               err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> > +               if (!ASSERT_OK(err, "test_run err"))
> > +                       break;
> > +               if (!ASSERT_EQ((int)topts.retval, 0, "test_run retval")=
)
> > +                       break;
> > +       }
> > +       pthread_exit(arg);
> > +}
> > +
> > +static void test_arena_spin_lock_size(int size)
> > +{
> > +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +       struct arena_spin_lock *skel;
> > +       pthread_t thread_id[16];
> > +       int prog_fd, i, err;
> > +       void *ret;
> > +
> > +       if (get_nprocs() < 2) {
> > +               test__skip();
> > +               return;
> > +       }
> > +
> > +       skel =3D arena_spin_lock__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open_and_load"))
> > +               return;
> > +       if (skel->data->test_skip =3D=3D 2) {
> > +               test__skip();
> > +               goto end;
> > +       }
> > +       counter =3D &skel->bss->counter;
> > +       skel->bss->cs_count =3D size;
> > +
> > +       prog_fd =3D bpf_program__fd(skel->progs.prog);
> > +       for (i =3D 0; i < 16; i++) {
> > +               err =3D pthread_create(&thread_id[i], NULL, &spin_lock_=
thread, &prog_fd);
> > +               if (!ASSERT_OK(err, "pthread_create"))
> > +                       goto end;
> > +       }
> > +
> > +       for (i =3D 0; i < 16; i++) {
> > +               if (!ASSERT_OK(pthread_join(thread_id[i], &ret), "pthre=
ad_join"))
> > +                       goto end;
> > +               if (!ASSERT_EQ(ret, &prog_fd, "ret =3D=3D prog_fd"))
> > +                       goto end;
> > +       }
> > +end:
> > +       arena_spin_lock__destroy(skel);
> > +       return;
> > +}
> > +
> > +void test_arena_spin_lock(void)
> > +{
> > +       if (test__start_subtest("arena_spin_lock_1"))
> > +               test_arena_spin_lock_size(1);
> > +       cpu =3D 0;
> > +       if (test__start_subtest("arena_spin_lock_1000"))
> > +               test_arena_spin_lock_size(1000);
> > +       cpu =3D 0;
> > +       if (test__start_subtest("arena_spin_lock_10000"))
> > +               test_arena_spin_lock_size(10000);
> > +       cpu =3D 0;
> > +       if (test__start_subtest("arena_spin_lock_100000"))
> > +               test_arena_spin_lock_size(100000);
> > +       cpu =3D 0;
> > +       if (test__start_subtest("arena_spin_lock_500000"))
> > +               test_arena_spin_lock_size(500000);
>
> Do 10k and 500k make a difference?
> I suspect 1, 1k and 100k would cover the interesting range.

They do make a difference inside a VM, but not on bare-metal.
I can stick to three sizes though.

>
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tool=
s/testing/selftests/bpf/progs/arena_spin_lock.c
> > new file mode 100644
> > index 000000000000..3e8ce807e028
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +#include "bpf_arena_spin_lock.h"
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_ARENA);
> > +       __uint(map_flags, BPF_F_MMAPABLE);
> > +       __uint(max_entries, 100); /* number of pages */
> > +#ifdef __TARGET_ARCH_arm64
> > +       __ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
> > +#else
> > +       __ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
> > +#endif
> > +} arena SEC(".maps");
> > +
> > +int cs_count;
> > +
> > +#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_=
CAST)
> > +arena_spinlock_t __arena lock;
> > +void *ptr;
> > +int test_skip =3D 1;
> > +#else
> > +int test_skip =3D 2;
> > +#endif
> > +
> > +int counter;
> > +
> > +SEC("tc")
> > +int prog(void *ctx)
> > +{
> > +       int ret =3D -2;
> > +
> > +#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_=
CAST)
> > +       unsigned long flags;
> > +
> > +       ptr =3D &arena;
>
> Is it really necessary?

Probably a remnant from previous versions, but sometimes if you don't do th=
is
it gives you an error saying addr_space_cast cannot be used in a
program with no associated arena.

Probably if it never sees the arena map reference anywhere in the
program. This is a way to do that.
But in this case I dropped it and it works.

>
> > +       if ((ret =3D arena_spin_lock_irqsave(&lock, flags)))
> > +               return ret;
> > +       WRITE_ONCE(counter, READ_ONCE(counter) + 1);
> > +       bpf_repeat(cs_count);
> > +       ret =3D 0;
> > +       arena_spin_unlock_irqrestore(&lock, flags);
> > +#endif
> > +       return ret;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > --
> > 2.47.1
> >

