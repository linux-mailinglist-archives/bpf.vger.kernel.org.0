Return-Path: <bpf+bounces-13744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8AB7DD5FA
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859651C20CE0
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707DF219FE;
	Tue, 31 Oct 2023 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIJgs0zD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D822307
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:23:29 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC239E6
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:23:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-543923af573so187890a12.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698776606; x=1699381406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxz+2/mOgm5pYak5SZxkp6HJiLSOq8o+WCaAni6dAiQ=;
        b=FIJgs0zDlp8AYTcUwRHkP0m6kIkKJ/SvDqwAMfdV7amwnDC0S9wmYIt1S2VZkRN4av
         EqbSWHmy/fvHL0XmnFrt8vlUMngjr1uunhT8qzxh1W6tyii98/y3OvXFHaVREARE52Dg
         xQrz9hveAfMkHXD6zK+B5c+U6I5nJh7M64VIWgWAYdrzDx0cmAHHAbTnBaHG7gvyfMjO
         fu7wrUeA8FxJjJL0mOJxpL1kGb8O2DCIw6E3f5Ofhn3VwHApdz/zOC6VAvoWFqJ7A9Oc
         Vt41VLlMkW9sVg3IwgrocVg58SOoV1OETm0e80E2FemplJW5C7zscTHoALt1xqvhL5Mp
         Re0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698776606; x=1699381406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxz+2/mOgm5pYak5SZxkp6HJiLSOq8o+WCaAni6dAiQ=;
        b=ogI6cV0pLpbPw9bkc547g+bBRywCvI89IiDF6efR2N8QAq0UFlA/saey2ut05QoeSk
         q3xy/B0qX8rCYeRGwha7vHurfCCTpmlM0ipQT77advMYAQFELQw8hVvfIt+zgPoMR5S+
         thCseZFiv/FYvQQT1GHUSVAAW7O+vNZYVDVEXaS4Hq0EzGAWpzFXb19MYJ1LWd0FPQyB
         5/BtBL0StmJLGsjaVJNa4pPrYwXs4pIt/deaTcfYnkluE+dJOIfEe25ACqGebWKKlM1f
         MaLRTPcjs5xaCUIxBk4N5c9bjgNanqOpuW0L2XTwWLqbdvSuUdPq2wfttuV0Q5o4EV3x
         mBRg==
X-Gm-Message-State: AOJu0YwHVbcynOBv9i4Q+TEEVG0nM+N196+sNwNHdDKhuub42akW8CoU
	N4lVsRUm5qR0oorVf42coKjCXVQ+O3t6GEZxCUM=
X-Google-Smtp-Source: AGHT+IEfBjfCYf2BD0phURE8JrDbtTOjIsNg6M+PDZHP4m2SgsTBKepoySNpj5O5gGea8JRR6ac9LZjuBDwgBV8MOn8=
X-Received: by 2002:a17:907:944e:b0:9ae:4054:5d2a with SMTP id
 dl14-20020a170907944e00b009ae40545d2amr120578ejc.16.1698776606231; Tue, 31
 Oct 2023 11:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030210638.2415306-1-davemarchevsky@fb.com>
 <CALOAHbAUhae1S1XUHNZAkSuOdvjS-ECSuKNoJRLAwtgp85L+dg@mail.gmail.com>
 <CAEf4BzYnDy4=tXX0S-G0dh2fPTXpJ+9PPF1uix-fRK49VA1hEg@mail.gmail.com>
 <CALOAHbC9A+NK6Y-z5L0r2XdaQ-ySuNsYr6A3a8y60WS76ayHPg@mail.gmail.com> <730b42c0-f289-49e6-9456-ca2c69b73a54@linux.dev>
In-Reply-To: <730b42c0-f289-49e6-9456-ca2c69b73a54@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 11:23:14 -0700
Message-ID: <CAEf4BzY08k7XRg87GLj5rVU=Oa5EdVmbMKte6s9dCB+Lx97qVA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next] bpf: Add __bpf_kfunc_{start,end}_defs macros
To: David Marchevsky <david.marchevsky@linux.dev>
Cc: Yafang Shao <laoar.shao@gmail.com>, Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 10:04=E2=80=AFAM David Marchevsky
<david.marchevsky@linux.dev> wrote:
>
> On 10/31/23 2:51 AM, Yafang Shao wrote:
> > On Tue, Oct 31, 2023 at 2:23=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Mon, Oct 30, 2023 at 10:56=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> >>>
> >>> On Tue, Oct 31, 2023 at 5:07=E2=80=AFAM Dave Marchevsky <davemarchevs=
ky@fb.com> wrote:
> >>>>
> >>>> BPF kfuncs are meant to be called from BPF programs. Accordingly, mo=
st
> >>>> kfuncs are not called from anywhere in the kernel, which the
> >>>> -Wmissing-prototypes warning is unhappy about. We've peppered
> >>>> __diag_ignore_all("-Wmissing-prototypes", ... everywhere kfuncs are
> >>>> defined in the codebase to suppress this warning.
> >>>>
> >>>> This patch adds two macros meant to bound one or many kfunc definiti=
ons.
> >>>> All existing kfunc definitions which use these __diag calls to suppr=
ess
> >>>> -Wmissing-prototypes are migrated to use the newly-introduced macros=
.
> >>>> A new __diag_ignore_all - for "-Wmissing-declarations" - is added to=
 the
> >>>> __bpf_kfunc_start_defs macro based on feedback from Andrii on an ear=
lier
> >>>> version of this patch [0] and another recent mailing list thread [1]=
.
> >>>>
> >>>> In the future we might need to ignore different warnings or do other
> >>>> kfunc-specific things. This change will make it easier to make such
> >>>> modifications for all kfunc defs.
> >>>>
> >>>>   [0]: https://lore.kernel.org/bpf/CAEf4BzaE5dRWtK6RPLnjTW-MW9sx9K3F=
n6uwqCTChK2Dcb1Xig@mail.gmail.com/
> >>>>   [1]: https://lore.kernel.org/bpf/ZT+2qCc%2FaXep0%2FLf@krava/
> >>>>
> >>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >>>> Cc: Jiri Olsa <olsajiri@gmail.com>
> >>>> ---
> >>>>
> >>>> This patch was submitted earlier as part of task_vma
> >>>> iter series: https://lore.kernel.org/bpf/20231013204426.1074286-6-da=
vemarchevsky@fb.com/
> >>>>
> >>>> This separate submission addresses Andrii's comments from
> >>>> that thread.
> >>>>
> >>>>  include/linux/btf.h              |  9 +++++++++
> >>>>  kernel/bpf/bpf_iter.c            |  6 ++----
> >>>>  kernel/bpf/cpumask.c             |  6 ++----
> >>>>  kernel/bpf/helpers.c             |  6 ++----
> >>>>  kernel/bpf/map_iter.c            |  6 ++----
> >>>>  kernel/bpf/task_iter.c           |  6 ++----
> >>>>  kernel/trace/bpf_trace.c         |  6 ++----
> >>>>  net/bpf/test_run.c               |  7 +++----
> >>>>  net/core/filter.c                | 13 ++++---------
> >>>>  net/core/xdp.c                   |  6 ++----
> >>>>  net/ipv4/fou_bpf.c               |  6 ++----
> >>>>  net/netfilter/nf_conntrack_bpf.c |  6 ++----
> >>>>  net/netfilter/nf_nat_bpf.c       |  6 ++----
> >>>>  net/xfrm/xfrm_interface_bpf.c    |  6 ++----
> >>>>  14 files changed, 38 insertions(+), 57 deletions(-)
> >>>>
> >>>
> >>> Thanks for your work.
> >>>
> >>> By using a simple grep for "__diag_ignore_all(\"-Wmissing-prototypes"=
,
> >>> it appears that the files net/socket.c,
> >>> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c,
> >>> kernel/cgroup/rstat.c and Documentation/bpf/kfuncs.rst are missing. I=
t
> >>> seems that we should also update them.
> >>>
> >>
> >> rstat.c and net/socket.c don't have kfuncs, so those are not relevant
> >> here.
> >
> > The bpf_rstat_flush() and update_socket_protocol() can also trigger
> > the -Wmissing-declarations.
> > These two functions are for BPF only. Shouldn't we better include them =
as well ?
> >
>
> I had this conundrum when writing the patch as well. Since they're not kf=
uncs
> and the macros are meant to wrap kfunc definitions, I felt that it would =
be

yeah, I was going to say the same, it's misleading

> confusing to someone unfamiliar with BPF internals. But I agree that the =
current
> state isn't ideal either.
>
> How about either:
>   * I use the __bpf_kfunc_{start,end}_defs macros in those two places,
>     with comment describing that they're not wrapping kfunc def, but rath=
er
>     BPF hook point that throws the same warnings.
>   * Two additional macros, __bpf_hook_{start,end} are added, just
>     pointing to __bpf_kfunc_{start,end} for now. They're used for
>     these two functions
>
> WDYT?

I like the option #2 best

>
> >> But we are missing changes also in kernel/bpf/task_iter.c and
> >> kernel/bpf/cgroup_iter.c
> >>
> >> And let's update Documentation/bpf/kfuncs.rst to use your new set of m=
acros?
> >>
> >> With the above addressed, please add my ack. Thanks!
> >>
> >> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >>
> >>> --
> >>> Regards
> >>> Yafang
> >
> >
> >

