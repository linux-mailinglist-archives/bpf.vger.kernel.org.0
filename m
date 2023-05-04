Return-Path: <bpf+bounces-38-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1195C6F78BD
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519171C2147C
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ECFC154;
	Thu,  4 May 2023 22:03:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE90156F9
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:03:57 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD6611542
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:03:54 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-330ec047d3bso625235ab.0
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683237834; x=1685829834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7bLFaBk+AsNDu0ODTBux2M1KBKt5c2mYEVbpjQy60g=;
        b=nENAvQ5ancWcjOrA4OXXuf+DrX8Gx3i9JycAeWyJpf6ChIAWiuIeVUPaafDfKJc4v2
         B8wBBHDTOvHxLpuaJSJJKntrnaR3eAm40dtFkAIDO8UsE4Iz57CA2tA/t2qlMZPf8l9Z
         OK8X8Dk/2hBYEiVynuwLYR7sSZrz1JlBj31SvaseY3axQiUBOts9bjOaEvhXF6pTDoJQ
         OP52OSk1fpcZ2FWjD6Rl3bcABv1fQTUSY/RamXaPjcMYnI50P/2LKh0z7HnpRiictZSM
         5Ln2Aiv19HMZFLzoGv7kN0YEwi5vYwbxJ1InELD6KgiX8ycIB1tDELz4m7cq9DoomF0X
         /Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683237834; x=1685829834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7bLFaBk+AsNDu0ODTBux2M1KBKt5c2mYEVbpjQy60g=;
        b=bBOAiqbMZnruO4xHAJHs+JVQ3xsbNapAC3qFENNvaD1aexRKoqr/CpKSW0v4C68ad2
         G/zl51JmfnVLuqCFulHaV+bv3Akirh9VST4qoayJPVgQhdOBSWGzYIUyBTBYNEtmZV4Y
         H8W9keKNW1OyAA3MmeZ6QVLGWoBjzbt7yeRsymtKFWP6i/Hc+1wKIuCCXDR86fKUzB07
         We/QLPrmkZFLYcAjpGkbIhnEdnzXvfNN5leee+wiGsCWgkLxbxf844cuO0107R0XTEkF
         CUKODU2pdXTzQICEGGTsCLH8xNOP2LgFngKpjSbnEteEPQjP14ugOy8lopptQzvL3JxO
         Sbog==
X-Gm-Message-State: AC+VfDxP6kSm6oycpbuGwScC+G2XWieAVaajCgRXg0PMd/YoCM71eT6z
	XjtdQVvxZiUCz/XOxAnDjG9M93/E4RiKbfM1SrK+WA==
X-Google-Smtp-Source: ACHHUZ4odwXa0x/65IY9PZ8UXNqyORQsJMFvBGUM9RU413iClbA2a94/4gebb273ier0fLsIQ+abd56IotJJlpusyXw=
X-Received: by 2002:a05:6e02:188e:b0:32b:1332:3d08 with SMTP id
 o14-20020a056e02188e00b0032b13323d08mr19679ilu.0.1683237833632; Thu, 04 May
 2023 15:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230503211801.897735-1-acme@kernel.org> <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org> <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org> <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org> <ZFQoQjCNtyMIulp+@kernel.org>
In-Reply-To: <ZFQoQjCNtyMIulp+@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 May 2023 15:03:42 -0700
Message-ID: <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Song Liu <song@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Roman Lozko <lozko.roma@gmail.com>, Stephane Eranian <eranian@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 2:48=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> > > On Thu, May 4, 2023 at 10:52=E2=80=AFAM Arnaldo Carvalho de Melo <acm=
e@kernel.org> wrote:
> > > > Andrii, can you add some more information about the usage of vmlinu=
x.h
> > > > instead of using kernel headers?
> >
> > > I'll just say that vmlinux.h is not a hard requirement to build BPF
> > > programs, it's more a convenience allowing easy access to definitions
> > > of both UAPI and kernel-internal structures for tracing needs and
> > > marking them relocatable using BPF CO-RE machinery. Lots of real-worl=
d
> > > applications just check-in pregenerated vmlinux.h to avoid build-time
> > > dependency on up-to-date host kernel and such.
> >
> > > If vmlinux.h generation and usage is causing issues, though, given
> > > that perf's BPF programs don't seem to be using many different kernel
> > > types, it might be a better option to just use UAPI headers for publi=
c
> > > kernel type definitions, and just define CO-RE-relocatable minimal
> > > definitions locally in perf's BPF code for the other types necessary.
> > > E.g., if perf needs only pid and tgid from task_struct, this would
> > > suffice:
> >
> > > struct task_struct {
> > >     int pid;
> > >     int tgid;
> > > } __attribute__((preserve_access_index));
> >
> > Yeah, that seems like a way better approach, no vmlinux involved, libbp=
f
> > CO-RE notices that task_struct changed from this two integers version
> > (of course) and does the relocation to where it is in the running kerne=
l
> > by using /sys/kernel/btf/vmlinux.
>
> Doing it for one of the skels, build tested, runtime untested, but not
> using any vmlinux, BTF to help, not that bad, more verbose, but at least
> we state what are the fields we actually use, have those attribute
> documenting that those offsets will be recorded for future use, etc.
>
> Namhyung, can you please check that this works?
>
> Thanks,
>
> - Arnaldo
>
> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/uti=
l/bpf_skel/bperf_cgroup.bpf.c
> index 6a438e0102c5a2cb..f376d162549ebd74 100644
> --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> @@ -1,11 +1,40 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  // Copyright (c) 2021 Facebook
>  // Copyright (c) 2021 Google
> -#include "vmlinux.h"
> +#include <linux/types.h>
> +#include <linux/bpf.h>

Compared to vmlinux.h here be dragons. It is easy to start dragging in
all of libc and that may not work due to missing #ifdefs, etc.. Could
we check in a vmlinux.h like libbpf-tools does?
https://github.com/iovisor/bcc/tree/master/libbpf-tools#vmlinuxh-generation
https://github.com/iovisor/bcc/tree/master/libbpf-tools/arm64

This would also remove some of the errors that could be introduced by
copy+pasting enums, etc. and also highlight issues with things being
renamed as build time rather than runtime failures.
Could this be some shared resource for the different linux tools
projects using a vmlinux.h? e.g. tools/lib/vmlinuxh with an
install_headers target that builds a vmlinux.h.

Thanks,
Ian

>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_core_read.h>
>
> +// libbpf's CO-RE will take care of the relocations so that these fields=
 match
> +// the layout of these structs in the kernel where this ends up running =
on.
> +
> +struct cgroup_subsys_state {
> +       struct cgroup *cgroup;
> +} __attribute__((preserve_access_index));
> +
> +struct css_set {
> +       struct cgroup_subsys_state *subsys[13];
> +} __attribute__((preserve_access_index));
> +
> +struct task_struct {
> +       struct css_set *cgroups;
> +} __attribute__((preserve_access_index));
> +
> +struct kernfs_node {
> +       __u64 id;
> +}  __attribute__((preserve_access_index));
> +
> +struct cgroup {
> +       struct kernfs_node *kn;
> +       int                level;
> +}  __attribute__((preserve_access_index));
> +
> +enum cgroup_subsys_id {
> +       perf_event_cgrp_id  =3D 8,
> +};
> +
>  #define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
>  #define MAX_EVENTS  32  // max events per cgroup: arbitrary
>
> @@ -52,7 +81,7 @@ struct cgroup___new {
>  /* old kernel cgroup definition */
>  struct cgroup___old {
>         int level;
> -       u64 ancestor_ids[];
> +       __u64 ancestor_ids[];
>  } __attribute__((preserve_access_index));
>
>  const volatile __u32 num_events =3D 1;

