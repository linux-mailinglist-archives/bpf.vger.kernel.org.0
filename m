Return-Path: <bpf+bounces-13688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F303E7DC676
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2B51F22165
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B810780;
	Tue, 31 Oct 2023 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSpUMRt/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3720E0
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:23:18 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70182A2
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:23:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9be3b66f254so779197966b.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698733396; x=1699338196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9bA7xD54k0sbvFDUcslapwdbQV9KbbmeYvvXUCJn7U=;
        b=KSpUMRt/oZ0aTH9o+gz5ujjysgsDim+d3qBF7rCOmIHQHZh++ZTajveqn7VlXzckp4
         74QY+olI1f+amcIyuuw+iKg9X5UToQxR3FEgJ/lA6j65nS5DJzDzzVMHxO5hxCnp58Eq
         q+H+KuxRk6z+enDNPFpYYkrJagW1Y9wjJLS9qTYpZN8VoZmHl0/8bsRIPLdRTQcHYBJS
         0W4rxuUjUXPC423cfwd74stq0tzh1a9B0EhQY5qI0YeDNMMegb2CrVFlkPHL46dbCCQk
         T/EYS/9Wb1e1VaXFh3jumojrRYFovkfyRNJoUod3U2dYEVC5dedlivJAjEEpUW9AKq6q
         U5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698733396; x=1699338196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9bA7xD54k0sbvFDUcslapwdbQV9KbbmeYvvXUCJn7U=;
        b=AmlC8qBPDw7srWCjm1IR6TjX+5zJkTqMPVmhR+DOYKmhDWm3v33aI80+hyQG62VPtM
         FhGfZWJHr1Kxl60wb36qQTsutyXOH3+HjCEf13H2hralNVRHSOI0Cl6L6U1Lgkn4AZ2f
         CRk73jQFTRNyv9SsMFyqAQpIbkA43c//84hgTBvckYwpSwS7AZO6ywWNawv69z4X/qLw
         sDRDsoX2oiK492XLFW85wd1vjSxdsv4seL2MOKeVvWjhD3YJZ+x3luHwTActkbTPla7D
         HBdLbOrG9qUxlecrDp1ljNh+pcsoJX9cXVqVtdNqUEMWR0G4KJM1TSqfjyxVZAnRF4xe
         oa3Q==
X-Gm-Message-State: AOJu0YwILZUj45lDWNr5N9ZqnxuuL7kYJUe/nVlrtTU3cjYo7Y6MOolU
	F/FGKNuc12i13V0Xrn7FhzI6FJeXSrxTXUcI+NJsRmo1xGM=
X-Google-Smtp-Source: AGHT+IGSKFGBNhgjWYoOQ0Hf7UDdRxt2hHTCoC1N7X01s5YTscQfpVi0b8SP9bteLEbCZtsKqZNq2dO3zeWkGQrHbTA=
X-Received: by 2002:a17:907:968c:b0:9be:bf31:335f with SMTP id
 hd12-20020a170907968c00b009bebf31335fmr10796087ejc.46.1698733395623; Mon, 30
 Oct 2023 23:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030210638.2415306-1-davemarchevsky@fb.com> <CALOAHbAUhae1S1XUHNZAkSuOdvjS-ECSuKNoJRLAwtgp85L+dg@mail.gmail.com>
In-Reply-To: <CALOAHbAUhae1S1XUHNZAkSuOdvjS-ECSuKNoJRLAwtgp85L+dg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Oct 2023 23:23:04 -0700
Message-ID: <CAEf4BzYnDy4=tXX0S-G0dh2fPTXpJ+9PPF1uix-fRK49VA1hEg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next] bpf: Add __bpf_kfunc_{start,end}_defs macros
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 10:56=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Tue, Oct 31, 2023 at 5:07=E2=80=AFAM Dave Marchevsky <davemarchevsky@f=
b.com> wrote:
> >
> > BPF kfuncs are meant to be called from BPF programs. Accordingly, most
> > kfuncs are not called from anywhere in the kernel, which the
> > -Wmissing-prototypes warning is unhappy about. We've peppered
> > __diag_ignore_all("-Wmissing-prototypes", ... everywhere kfuncs are
> > defined in the codebase to suppress this warning.
> >
> > This patch adds two macros meant to bound one or many kfunc definitions=
.
> > All existing kfunc definitions which use these __diag calls to suppress
> > -Wmissing-prototypes are migrated to use the newly-introduced macros.
> > A new __diag_ignore_all - for "-Wmissing-declarations" - is added to th=
e
> > __bpf_kfunc_start_defs macro based on feedback from Andrii on an earlie=
r
> > version of this patch [0] and another recent mailing list thread [1].
> >
> > In the future we might need to ignore different warnings or do other
> > kfunc-specific things. This change will make it easier to make such
> > modifications for all kfunc defs.
> >
> >   [0]: https://lore.kernel.org/bpf/CAEf4BzaE5dRWtK6RPLnjTW-MW9sx9K3Fn6u=
wqCTChK2Dcb1Xig@mail.gmail.com/
> >   [1]: https://lore.kernel.org/bpf/ZT+2qCc%2FaXep0%2FLf@krava/
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Jiri Olsa <olsajiri@gmail.com>
> > ---
> >
> > This patch was submitted earlier as part of task_vma
> > iter series: https://lore.kernel.org/bpf/20231013204426.1074286-6-davem=
archevsky@fb.com/
> >
> > This separate submission addresses Andrii's comments from
> > that thread.
> >
> >  include/linux/btf.h              |  9 +++++++++
> >  kernel/bpf/bpf_iter.c            |  6 ++----
> >  kernel/bpf/cpumask.c             |  6 ++----
> >  kernel/bpf/helpers.c             |  6 ++----
> >  kernel/bpf/map_iter.c            |  6 ++----
> >  kernel/bpf/task_iter.c           |  6 ++----
> >  kernel/trace/bpf_trace.c         |  6 ++----
> >  net/bpf/test_run.c               |  7 +++----
> >  net/core/filter.c                | 13 ++++---------
> >  net/core/xdp.c                   |  6 ++----
> >  net/ipv4/fou_bpf.c               |  6 ++----
> >  net/netfilter/nf_conntrack_bpf.c |  6 ++----
> >  net/netfilter/nf_nat_bpf.c       |  6 ++----
> >  net/xfrm/xfrm_interface_bpf.c    |  6 ++----
> >  14 files changed, 38 insertions(+), 57 deletions(-)
> >
>
> Thanks for your work.
>
> By using a simple grep for "__diag_ignore_all(\"-Wmissing-prototypes",
> it appears that the files net/socket.c,
> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c,
> kernel/cgroup/rstat.c and Documentation/bpf/kfuncs.rst are missing. It
> seems that we should also update them.
>

rstat.c and net/socket.c don't have kfuncs, so those are not relevant
here. But we are missing changes also in kernel/bpf/task_iter.c and
kernel/bpf/cgroup_iter.c

And let's update Documentation/bpf/kfuncs.rst to use your new set of macros=
?

With the above addressed, please add my ack. Thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> --
> Regards
> Yafang

