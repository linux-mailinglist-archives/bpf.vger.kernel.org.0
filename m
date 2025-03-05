Return-Path: <bpf+bounces-53279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AABEA4F4B0
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F083C1890E74
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF657157A5C;
	Wed,  5 Mar 2025 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaWnq/6q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A88155333
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141502; cv=none; b=Wd37jc3raxwFRK1oLKlgtM2bPpB6JpnDgJc5ktv+GlBrvvW+V9b4YJcQfecKRBx5Fj81DQrrxZfmcxKvWzycfe/3EqvpIhqo027NNEju/UFpo6wAb2vjDnIcP4QglFigDQ5pz993VBalykAMFwOWlG7a+WE+L3FAD7obvEVliRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141502; c=relaxed/simple;
	bh=n1tGxem9wTGlQLpPI+xk7n3L5iG3MSX72Q7z2UigAtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idYSfW+ZR5X042KWSEUT9b7Tn29KeYMeIVqwX3sSZDRMrAWDV0aU5jqAmKjpgH6FbV21zP3Bh8xhpS9DtP/XpE4MpMimZ0yaSk28fTDdv4SEEhXwq50eoqxu2Q/KvHzW7fwzOIJrKIRG2HUA0BxIY6LZ8UY+AnTe5gMlsCZZubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaWnq/6q; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-aaedd529ba1so728038166b.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 18:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741141499; x=1741746299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lgOXmAHv6PkvZ9cyZ1oBVUbFgm9aLu+LqykF3RkDec=;
        b=jaWnq/6q/snJNNx1qKZmMPWmxJXHXTLvEg5GoJU9AsfBOcUobgmxj204+GTrVBaszx
         vDdbeH95Yze6pBbu5SVlwqGj/S8MT/+f3tCV0LAQ7ksb4NWbLOuaRnl/S3xYmjP6VHTE
         3LK6hCAFn2C61t6F5rrzkFiHleHbDvcHXV+kCt3vX44fDQ7/lD7DIp4gWTusmELztqky
         QbTPr7kasOOVcBCzc2K/aEAR8omtE79QC/AxqTvMv0okSMiMAn6Y3QXAHO6ED1EiwCTO
         O1BrfHYJFtZMgW+XwshK0oFqE3C/01FwMPgx5buEZxNmLpu3hoQEoP2IEL2idVC2g1xL
         mzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141499; x=1741746299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lgOXmAHv6PkvZ9cyZ1oBVUbFgm9aLu+LqykF3RkDec=;
        b=jBicZKgHaBkm7PAuDkKp5NT6muqP734dq4ANUQ1z9QwhWLS6WXOybNxzcPnzv4l0Vs
         eCDWpwjUgkq5B23JBICK9d6qFsaz1Co8aVlfIpyRaT5HGGw4kax8JDTiiCG2gVK7GcvD
         Oa6tVpNnqQEHGHk0rR1QXltVHawaWDGJOdvntv+FPDs+WjsPJ1KLaJAJ8uUkY5R+4dW6
         QkdOkUzDWmyiCkf+OhNuxxo9qz72oEy9lukORQ0t7ScMxe9fvedL5rgkJYchU5HHYEBj
         LHXwTirtiJER0muqWwp+AnRLYGdhh1Uv5SJF3nNnt4m7RYhhrJ6O0g2PRusYvCqmeZlC
         411Q==
X-Gm-Message-State: AOJu0Yzt4rEEDwhYT9nlrwmBZBoeJtbZDPCkopyKYCIxe92hcWHVEWHl
	qc8W1lpNx76uCmATtO2n4EYoprbQcrftGPcFqQCI1FLwOEeYtG/Bw8pz3cMCJXdIW8RzuPmDmGP
	RwN2vPxjm4XInCDz15kWWzp82G7Q7VglrkI8=
X-Gm-Gg: ASbGncuogOYQlWDssVTk006qsUwupmNw2ynbgEFhHtTGcJybHDlLJDEkJD1TbH7NOtm
	EZroJz2C8dlxVK/0iSc2mld0DOkX0U72J8LlrbhxUIvLPIx6wepbwbN6lBxjKZGqIASUb3aMNG9
	KbfLG2UbTT7yKvhqbwlMIRQ6cOGdLVN5cZXDqeXdO3rB6VWlg=
X-Google-Smtp-Source: AGHT+IEGTen01MCUHZzd1pcM8sYFJo+ABLzApS0OaDCTFGVhW4UWSa5SqFYPAT7j6bn1pC9XVxLlTYnF6k8lUD/YGXE=
X-Received: by 2002:a05:6402:4409:b0:5e0:8c55:50d with SMTP id
 4fb4d7f45d1cf-5e59f3e84f1mr3123658a12.14.1741141498707; Tue, 04 Mar 2025
 18:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305011849.1168917-1-memxor@gmail.com> <20250305011849.1168917-4-memxor@gmail.com>
 <CAADnVQ+6snJwWne8ub+Fht1zinDxJZhDxfsfAvPz0Ezfe3dSHg@mail.gmail.com> <CAP01T76BgwiWDs-PxW3jrU3Op877oLyVRyrTP96dzNZGUnRquA@mail.gmail.com>
In-Reply-To: <CAP01T76BgwiWDs-PxW3jrU3Op877oLyVRyrTP96dzNZGUnRquA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 5 Mar 2025 03:24:21 +0100
X-Gm-Features: AQ5f1JqP-s97LE4BbxtvHIm_Kqs3bJ3-BpIDLEdr3EwAbrSysbRw4gRK7Uevbh8
Message-ID: <CAP01T756K-BpUQAxdRTKVzzG0UetUOFCnkDoGbrERkiCmnTy+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for arena spin lock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2025 at 03:14, Kumar Kartikeya Dwivedi <memxor@gmail.com> wro=
te:
>
> On Wed, 5 Mar 2025 at 03:04, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Mar 4, 2025 at 5:18=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> > >
> > > Add some basic selftests for qspinlock built over BPF arena using
> > > cond_break_label macro.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  .../bpf/prog_tests/arena_spin_lock.c          | 102 ++++++++++++++++=
++
> > >  .../selftests/bpf/progs/arena_spin_lock.c     |  51 +++++++++
> > >  2 files changed, 153 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin=
_lock.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock=
.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c=
 b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> > > new file mode 100644
> > > index 000000000000..2cc078ed1ddb
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> > > @@ -0,0 +1,102 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > > +#include <test_progs.h>
> > > +#include <network_helpers.h>
> > > +#include <sys/sysinfo.h>
> > > +
> > > +struct qspinlock { int val; };
> > > +typedef struct qspinlock arena_spinlock_t;
> > > +
> > > +struct arena_qnode {
> > > +       unsigned long next;
> > > +       int count;
> > > +       int locked;
> > > +};
> > > +
> > > +#include "arena_spin_lock.skel.h"
> > > +
> > > +static long cpu;
> > > +int *counter;
> > > +
> > > +static void *spin_lock_thread(void *arg)
> > > +{
> > > +       int err, prog_fd =3D *(u32 *)arg;
> > > +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> > > +               .data_in =3D &pkt_v4,
> > > +               .data_size_in =3D sizeof(pkt_v4),
> > > +               .repeat =3D 1,
> > > +       );
> >
> > Why bother with 'tc' prog type?
> > Pick syscall type, and above will be shorter:
> > LIBBPF_OPTS(bpf_test_run_opts, opts);
> >
>
> Ack.

Sadly, syscall prog_test_run doesn't support 'repeat' field, so we'll
have to stick with tc.

>
> > > +       cpu_set_t cpuset;
> > > +
> > > +       CPU_ZERO(&cpuset);
> > > +       CPU_SET(__sync_fetch_and_add(&cpu, 1), &cpuset);
> > > +       ASSERT_OK(pthread_setaffinity_np(pthread_self(), sizeof(cpuse=
t), &cpuset), "cpu affinity");
> > > +
> > > +       while (*READ_ONCE(counter) <=3D 1000) {
> >
> > READ_ONCE(*counter) ?
> >
> > but why add this user->kernel switch overhead.
> > Use .repeat =3D 1000
> > one bpf_prog_test_run_opts()
> > and check at the end that *counter =3D=3D 1000 ?
>
> Ok.
>

One of the reasons to do this was to give other threads time to be
able to catch up with the first threads as it starts storming through
the counter increments.
So in case of short section there is no contention at all and most
code paths don't get triggered.
But I'll use a pthread_barrier instead.

