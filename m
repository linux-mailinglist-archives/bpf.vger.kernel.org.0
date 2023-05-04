Return-Path: <bpf+bounces-57-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD956F79B3
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 01:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E44B280F78
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 23:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3FD537;
	Thu,  4 May 2023 23:20:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56EFC142
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 23:20:01 +0000 (UTC)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C919212481
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 16:19:59 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33124b0dd85so649385ab.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 16:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683242399; x=1685834399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jleM9mam0jC92K7s5TbbM7NijY+miJheeAbD3LOvDfA=;
        b=J90ITR/r2P88wH3CGkZ5u0W3j8eg6vs8I9cLw/l7YC559zhwlMFqmmhArwcq4/4USL
         s2DYaf7ejAnnO4A2Dmx814A2057D/RDduNBW3AlEsaSLsj8CkxuXzWjyZCiNsuuMxl3Z
         gLZp9aEm6VVRr5d9DFn0z8LiMMWLNftadj6TKQAI/VtsNGBxSqx15wpgOeaTs9XJNqgr
         4iOChk7p9fPxJwE0UcItqEMpE+jqXpkEwgI3WJxsHCnlnzCw1EmyXJNplSisMytsK7iE
         UKkECc/oUuEb789YslJI/ZCtyFBQcymx7EQMM99KeHqNVweuv3K5CmXt4mENHKTH2tWz
         LvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683242399; x=1685834399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jleM9mam0jC92K7s5TbbM7NijY+miJheeAbD3LOvDfA=;
        b=TE50o1V618Kxc2LBcQNIvSBiA/30bO+Q6SJkK48QuglQIdFXCrNr/b/uDgfSzYhaqD
         UjsUdCZVO4Ar7jUQVaoq/bmKpqsDpeCSyozY4u4o66hjY+V0hVu5epCoUqmB++yesMSy
         Z+5NHk/qED1rSVEe5juQz9whXLV7OwRLYcB5W5DMskuZJrglmwduyljEITczCzlctjGY
         3HGNtwuvxVXnveO/spzQzkIOFcsiUVmiCVhRq0jXi+/jj/vClg+yO7H0GuVhCw42vUgh
         nVlxhrPxZfHHkgbW1z8V8vA8VyixOhVBnzTS2Rm2M5djwdmRPT1/Nn8NcDCLniXwehb8
         vuyA==
X-Gm-Message-State: AC+VfDwQmgmMs40itRpu1K9xpOwmnQF9hWPPARYpJ9mrEHUZqpgWzJDY
	pwHIikeusv8Fgdu/QALGARZqZXbtg5aHJhPCk9QDbA==
X-Google-Smtp-Source: ACHHUZ7owDID/HQFBwNWNr+6addwdGscj9GPolKRD+c7/uHSaXyISjdRbsy5/0EXV3MMukoUvjf2WGcMhBLZEiLvL/4=
X-Received: by 2002:a92:cdac:0:b0:32a:dc6a:3b97 with SMTP id
 g12-20020a92cdac000000b0032adc6a3b97mr10344ild.0.1683242398875; Thu, 04 May
 2023 16:19:58 -0700 (PDT)
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
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com> <ZFQ5sjjtfEYzvHNP@krava>
In-Reply-To: <ZFQ5sjjtfEYzvHNP@krava>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 May 2023 16:19:47 -0700
Message-ID: <CAP-5=fXgtNQ5KQv_M+b-mR-dm_s8AAgRkotXifFiTqBo9FHJzA@mail.gmail.com>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
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
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 4:03=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, May 04, 2023 at 03:03:42PM -0700, Ian Rogers wrote:
> > On Thu, May 4, 2023 at 2:48=E2=80=AFPM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo es=
creveu:
> > > > Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> > > > > On Thu, May 4, 2023 at 10:52=E2=80=AFAM Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
> > > > > > Andrii, can you add some more information about the usage of vm=
linux.h
> > > > > > instead of using kernel headers?
> > > >
> > > > > I'll just say that vmlinux.h is not a hard requirement to build B=
PF
> > > > > programs, it's more a convenience allowing easy access to definit=
ions
> > > > > of both UAPI and kernel-internal structures for tracing needs and
> > > > > marking them relocatable using BPF CO-RE machinery. Lots of real-=
world
> > > > > applications just check-in pregenerated vmlinux.h to avoid build-=
time
> > > > > dependency on up-to-date host kernel and such.
> > > >
> > > > > If vmlinux.h generation and usage is causing issues, though, give=
n
> > > > > that perf's BPF programs don't seem to be using many different ke=
rnel
> > > > > types, it might be a better option to just use UAPI headers for p=
ublic
> > > > > kernel type definitions, and just define CO-RE-relocatable minima=
l
> > > > > definitions locally in perf's BPF code for the other types necess=
ary.
> > > > > E.g., if perf needs only pid and tgid from task_struct, this woul=
d
> > > > > suffice:
> > > >
> > > > > struct task_struct {
> > > > >     int pid;
> > > > >     int tgid;
> > > > > } __attribute__((preserve_access_index));
> > > >
> > > > Yeah, that seems like a way better approach, no vmlinux involved, l=
ibbpf
> > > > CO-RE notices that task_struct changed from this two integers versi=
on
> > > > (of course) and does the relocation to where it is in the running k=
ernel
> > > > by using /sys/kernel/btf/vmlinux.
> > >
> > > Doing it for one of the skels, build tested, runtime untested, but no=
t
> > > using any vmlinux, BTF to help, not that bad, more verbose, but at le=
ast
> > > we state what are the fields we actually use, have those attribute
> > > documenting that those offsets will be recorded for future use, etc.
> > >
> > > Namhyung, can you please check that this works?
> > >
> > > Thanks,
> > >
> > > - Arnaldo
> > >
> > > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf=
/util/bpf_skel/bperf_cgroup.bpf.c
> > > index 6a438e0102c5a2cb..f376d162549ebd74 100644
> > > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > @@ -1,11 +1,40 @@
> > >  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >  // Copyright (c) 2021 Facebook
> > >  // Copyright (c) 2021 Google
> > > -#include "vmlinux.h"
> > > +#include <linux/types.h>
> > > +#include <linux/bpf.h>
> >
> > Compared to vmlinux.h here be dragons. It is easy to start dragging in
> > all of libc and that may not work due to missing #ifdefs, etc.. Could
> > we check in a vmlinux.h like libbpf-tools does?
> > https://github.com/iovisor/bcc/tree/master/libbpf-tools#vmlinuxh-genera=
tion
> > https://github.com/iovisor/bcc/tree/master/libbpf-tools/arm64
> >
> > This would also remove some of the errors that could be introduced by
> > copy+pasting enums, etc. and also highlight issues with things being
> > renamed as build time rather than runtime failures.
>
> we already have to deal with that, right? doing checks on fields in
> structs like mm_struct___old

We do, but the way I detected the problems in the first place was by
building against older kernels. Now the build will always succeed but
fail at runtime.

> > Could this be some shared resource for the different linux tools
> > projects using a vmlinux.h? e.g. tools/lib/vmlinuxh with an
> > install_headers target that builds a vmlinux.h.
>
> I tried to do the minimal header and it's not too big,
> I pushed it in here:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=
=3Dperf/vmlinux_h
>
> compile tested so far
>
> jirka

Cool, could we just call it vmlinux.h rather than perf-defs.h?

I notice cgroup_subsys_id is in there which is called out in Andrii's
CO-RE  guide/blog:
https://nakryiko.com/posts/bpf-core-reference-guide/#relocatable-enums
perhaps we can do something with names/types to make sure a helper is
being used for these enum values.

Thanks,
Ian

