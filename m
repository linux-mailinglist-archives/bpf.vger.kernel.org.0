Return-Path: <bpf+bounces-13695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79217DC6BC
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84975B20ED3
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCA2D304;
	Tue, 31 Oct 2023 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaUQX1t1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB36AB7
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:52:03 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465FC1
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:52:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67131800219so17751696d6.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698735121; x=1699339921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXuRYJVR2VTH7fYRUfPlsqkOlguB8OXVx83qbYLbTDE=;
        b=SaUQX1t1Ftkc+96o7QLejAyHX7RaZf7UDw643ETQxS5//AeEjyesDx89C54hqn79g6
         bqeKGc/e2hoPyxvbcgLhmoTGTnBsSDF2ZBPlZD7rXrSlvAMaLj+2q1kcCoLhp4VJl7vV
         upZrKfH4kgo+wccgAhv9DbU1rQyNiWwWdxY0kwU3SyTkQAeXzE/xuDE2QXHVfBYTiLIo
         wus1AUNN+EP92+MmUaIlmI9d+5b/IdQxF0p89eNnGQLWbw3p+vOdseHh4nto/tMBlDZj
         D+RxqTLYEazr4pdFHNxGKjyC1WrUiPwxxfu1lYzzeu1q4sAmicSxV0vXYp88ptKz1Mc5
         /LYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698735121; x=1699339921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXuRYJVR2VTH7fYRUfPlsqkOlguB8OXVx83qbYLbTDE=;
        b=IwsaEBHxUnBfscMjNd0Qy75mJviA4MyEOIslnqzfdVUr/W8qzAVXROw4vs5UBHZRnN
         2MBBqGqV6yPZOXflzZf4JcMXwBS05nN0b5iLdvyc7vonmlT+RmJaqHsHxdUJatLLhNnP
         cSDi/Q3c11qgEk77TNZJYyv3LkTdHKUlNIvMB3p3NoctBWui4YoQ8SwysCQ8JpInLxPA
         y2XrTFJqdlaGvLSmLHQE3otXfH8AehLTU7LKSrqlFBFc1161ffD9U/PlIoJH6Saw9C9x
         KICt7QFjGkVNW+xO/AA02lZrywU1a3+8jNYUbM6+0EfjDojqvhq9HBacRHnU3mtljqDX
         8agw==
X-Gm-Message-State: AOJu0Yyw7qB8Fe9J2sakex2TSNiFJCnW/IpvisetvQ2M+sKaR3Xlv0GU
	Horq8TOykKokIS5kFR+PDZojLv3znxIJ+jICWl8=
X-Google-Smtp-Source: AGHT+IEq5tA4QpIYbyoapoimvGcMC0l9uCeV3Hxb+3Uod07SqkAaHFFqf3VscTff/5KXvpyWU9niE92x+trQiirzG5Y=
X-Received: by 2002:a05:6214:20ad:b0:66c:fbae:1eb1 with SMTP id
 13-20020a05621420ad00b0066cfbae1eb1mr15876437qvd.55.1698735121323; Mon, 30
 Oct 2023 23:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030210638.2415306-1-davemarchevsky@fb.com>
 <CALOAHbAUhae1S1XUHNZAkSuOdvjS-ECSuKNoJRLAwtgp85L+dg@mail.gmail.com> <CAEf4BzYnDy4=tXX0S-G0dh2fPTXpJ+9PPF1uix-fRK49VA1hEg@mail.gmail.com>
In-Reply-To: <CAEf4BzYnDy4=tXX0S-G0dh2fPTXpJ+9PPF1uix-fRK49VA1hEg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 31 Oct 2023 14:51:25 +0800
Message-ID: <CALOAHbC9A+NK6Y-z5L0r2XdaQ-ySuNsYr6A3a8y60WS76ayHPg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next] bpf: Add __bpf_kfunc_{start,end}_defs macros
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 2:23=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 30, 2023 at 10:56=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > On Tue, Oct 31, 2023 at 5:07=E2=80=AFAM Dave Marchevsky <davemarchevsky=
@fb.com> wrote:
> > >
> > > BPF kfuncs are meant to be called from BPF programs. Accordingly, mos=
t
> > > kfuncs are not called from anywhere in the kernel, which the
> > > -Wmissing-prototypes warning is unhappy about. We've peppered
> > > __diag_ignore_all("-Wmissing-prototypes", ... everywhere kfuncs are
> > > defined in the codebase to suppress this warning.
> > >
> > > This patch adds two macros meant to bound one or many kfunc definitio=
ns.
> > > All existing kfunc definitions which use these __diag calls to suppre=
ss
> > > -Wmissing-prototypes are migrated to use the newly-introduced macros.
> > > A new __diag_ignore_all - for "-Wmissing-declarations" - is added to =
the
> > > __bpf_kfunc_start_defs macro based on feedback from Andrii on an earl=
ier
> > > version of this patch [0] and another recent mailing list thread [1].
> > >
> > > In the future we might need to ignore different warnings or do other
> > > kfunc-specific things. This change will make it easier to make such
> > > modifications for all kfunc defs.
> > >
> > >   [0]: https://lore.kernel.org/bpf/CAEf4BzaE5dRWtK6RPLnjTW-MW9sx9K3Fn=
6uwqCTChK2Dcb1Xig@mail.gmail.com/
> > >   [1]: https://lore.kernel.org/bpf/ZT+2qCc%2FaXep0%2FLf@krava/
> > >
> > > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Jiri Olsa <olsajiri@gmail.com>
> > > ---
> > >
> > > This patch was submitted earlier as part of task_vma
> > > iter series: https://lore.kernel.org/bpf/20231013204426.1074286-6-dav=
emarchevsky@fb.com/
> > >
> > > This separate submission addresses Andrii's comments from
> > > that thread.
> > >
> > >  include/linux/btf.h              |  9 +++++++++
> > >  kernel/bpf/bpf_iter.c            |  6 ++----
> > >  kernel/bpf/cpumask.c             |  6 ++----
> > >  kernel/bpf/helpers.c             |  6 ++----
> > >  kernel/bpf/map_iter.c            |  6 ++----
> > >  kernel/bpf/task_iter.c           |  6 ++----
> > >  kernel/trace/bpf_trace.c         |  6 ++----
> > >  net/bpf/test_run.c               |  7 +++----
> > >  net/core/filter.c                | 13 ++++---------
> > >  net/core/xdp.c                   |  6 ++----
> > >  net/ipv4/fou_bpf.c               |  6 ++----
> > >  net/netfilter/nf_conntrack_bpf.c |  6 ++----
> > >  net/netfilter/nf_nat_bpf.c       |  6 ++----
> > >  net/xfrm/xfrm_interface_bpf.c    |  6 ++----
> > >  14 files changed, 38 insertions(+), 57 deletions(-)
> > >
> >
> > Thanks for your work.
> >
> > By using a simple grep for "__diag_ignore_all(\"-Wmissing-prototypes",
> > it appears that the files net/socket.c,
> > tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c,
> > kernel/cgroup/rstat.c and Documentation/bpf/kfuncs.rst are missing. It
> > seems that we should also update them.
> >
>
> rstat.c and net/socket.c don't have kfuncs, so those are not relevant
> here.

The bpf_rstat_flush() and update_socket_protocol() can also trigger
the -Wmissing-declarations.
These two functions are for BPF only. Shouldn't we better include them as w=
ell ?

> But we are missing changes also in kernel/bpf/task_iter.c and
> kernel/bpf/cgroup_iter.c
>
> And let's update Documentation/bpf/kfuncs.rst to use your new set of macr=
os?
>
> With the above addressed, please add my ack. Thanks!
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> > --
> > Regards
> > Yafang



--=20
Regards
Yafang

