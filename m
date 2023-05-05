Return-Path: <bpf+bounces-119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3356F8557
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 17:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496CB281031
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F37C2D3;
	Fri,  5 May 2023 15:14:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8DDBE7A
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 15:14:31 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFF61BCA;
	Fri,  5 May 2023 08:14:28 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f0108a7d20so2132040e87.3;
        Fri, 05 May 2023 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683299666; x=1685891666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oegoxXyGIHmylmkklaLXWJVdylUtYMRDksZxxgTnY0w=;
        b=p42IIgkZJZdYM019cvt5p4yYWtec7Tl60FHGEnllaoaXvo0XUFGNz0swJdqvcfB0ou
         yQFVtwkPmBXfzuF/3KJHG5DGVGVQJXOm4RKNu2Z2D9Pju7xBrdbslmr71Kr7b1r4bYDo
         262IerPoaHfYHTz0iNOLo1Nd1XNxr8Zt8+nI/QxyudxXzn3TolODVrBjduTMPb0nkU2S
         MVwUccC3Vht/5kWun3NhspGc+YvSEmaMqxX2cJR9pDA+kAKbj81g0iiLnf2pyEc2Z+HV
         cRH5BNaBG5X9wcwQaPgHTr+eHGUVJ0PW6W9LFnnPCSvgG/u5KeorJSGj0r/MJL6LubKs
         0LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683299666; x=1685891666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oegoxXyGIHmylmkklaLXWJVdylUtYMRDksZxxgTnY0w=;
        b=ABBnVJPoCYQ09tQwjD3hyGz0vYWri4O2mwFkn/ilTBQYI0Qw6tjj+ID34a3CrI0nnK
         YhICamATzzIvXA3/xoMf3dX28733UFPMmli6vU4jqZ8Z3CxlkoguugueZTj2yd69iqgQ
         EMGdQ0sB/YfyAfVYanV1M/9KbBQ4qts3MBbfQfDKOhJ+9hxok86nKmHEgeoLyVoRcx+O
         k7RDq97P2RXGx0J4vusNMiCocTQR4Z+C3GzQl1xugw8sa6Aj4/Tj304jPm/fmkz0Laj8
         qPeZZUsTPWmV5GVCmzYEP5aElr6/hNKOiS/dQwFKxQGFjJN+JZ7w7VCo0bfo7iwn2wIJ
         BtbA==
X-Gm-Message-State: AC+VfDyysFkD09urdnaLMnQo4MsoHoadZBLYQwtCREEGjCxWdNMYr0tN
	SadRQVHMugD6O+1dfaweXd/a9Qj0rFmOrYWeoSo=
X-Google-Smtp-Source: ACHHUZ6Nudfg9QFfCNejF73wLcnsuJ+BQGNiIFuQ+8BtnxjcgXU6SXZHYJdANmtPcNFLdrsU9lzdE8aYtSBwE9ju0uY=
X-Received: by 2002:a05:6512:21ac:b0:4f1:3716:ab34 with SMTP id
 c12-20020a05651221ac00b004f13716ab34mr531680lft.60.1683299666246; Fri, 05 May
 2023 08:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org> <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org> <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org> <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava> <ZFUFmxDU/6Z/JEsi@kernel.org>
In-Reply-To: <ZFUFmxDU/6Z/JEsi@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 May 2023 08:14:14 -0700
Message-ID: <CAADnVQLe2HK8GN44fXJgKm+pr=JmK8LC_YU3i1fgyVfS+nQxDA@mail.gmail.com>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Quentin Monnet <quentin@isovalent.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Song Liu <song@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Roman Lozko <lozko.roma@gmail.com>, Stephane Eranian <eranian@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 5, 2023 at 6:33=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreveu:
> > On Thu, May 04, 2023 at 03:03:42PM -0700, Ian Rogers wrote:
> > > On Thu, May 4, 2023 at 2:48=E2=80=AFPM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > >
> > > > Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo =
escreveu:
> > > > > Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreve=
u:
> > > > > > On Thu, May 4, 2023 at 10:52=E2=80=AFAM Arnaldo Carvalho de Mel=
o <acme@kernel.org> wrote:
> > > > > > > Andrii, can you add some more information about the usage of =
vmlinux.h
> > > > > > > instead of using kernel headers?
> > > > >
> > > > > > I'll just say that vmlinux.h is not a hard requirement to build=
 BPF
> > > > > > programs, it's more a convenience allowing easy access to defin=
itions
> > > > > > of both UAPI and kernel-internal structures for tracing needs a=
nd
> > > > > > marking them relocatable using BPF CO-RE machinery. Lots of rea=
l-world
> > > > > > applications just check-in pregenerated vmlinux.h to avoid buil=
d-time
> > > > > > dependency on up-to-date host kernel and such.
> > > > >
> > > > > > If vmlinux.h generation and usage is causing issues, though, gi=
ven
> > > > > > that perf's BPF programs don't seem to be using many different =
kernel
> > > > > > types, it might be a better option to just use UAPI headers for=
 public
> > > > > > kernel type definitions, and just define CO-RE-relocatable mini=
mal
> > > > > > definitions locally in perf's BPF code for the other types nece=
ssary.
> > > > > > E.g., if perf needs only pid and tgid from task_struct, this wo=
uld
> > > > > > suffice:
> > > > >
> > > > > > struct task_struct {
> > > > > >     int pid;
> > > > > >     int tgid;
> > > > > > } __attribute__((preserve_access_index));
> > > > >
> > > > > Yeah, that seems like a way better approach, no vmlinux involved,=
 libbpf
> > > > > CO-RE notices that task_struct changed from this two integers ver=
sion
> > > > > (of course) and does the relocation to where it is in the running=
 kernel
> > > > > by using /sys/kernel/btf/vmlinux.
> > > >
> > > > Doing it for one of the skels, build tested, runtime untested, but =
not
> > > > using any vmlinux, BTF to help, not that bad, more verbose, but at =
least
> > > > we state what are the fields we actually use, have those attribute
> > > > documenting that those offsets will be recorded for future use, etc=
.
> > > >
> > > > Namhyung, can you please check that this works?
> > > >
> > > > Thanks,
> > > >
> > > > - Arnaldo
> > > >
> > > > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/pe=
rf/util/bpf_skel/bperf_cgroup.bpf.c
> > > > index 6a438e0102c5a2cb..f376d162549ebd74 100644
> > > > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > > @@ -1,11 +1,40 @@
> > > >  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > >  // Copyright (c) 2021 Facebook
> > > >  // Copyright (c) 2021 Google
> > > > -#include "vmlinux.h"
> > > > +#include <linux/types.h>
> > > > +#include <linux/bpf.h>
> > >
> > > Compared to vmlinux.h here be dragons. It is easy to start dragging i=
n
> > > all of libc and that may not work due to missing #ifdefs, etc.. Could
> > > we check in a vmlinux.h like libbpf-tools does?
> > > https://github.com/iovisor/bcc/tree/master/libbpf-tools#vmlinuxh-gene=
ration
> > > https://github.com/iovisor/bcc/tree/master/libbpf-tools/arm64
> > >
> > > This would also remove some of the errors that could be introduced by
> > > copy+pasting enums, etc. and also highlight issues with things being
> > > renamed as build time rather than runtime failures.
> >
> > we already have to deal with that, right? doing checks on fields in
> > structs like mm_struct___old
> >
> > > Could this be some shared resource for the different linux tools
> > > projects using a vmlinux.h? e.g. tools/lib/vmlinuxh with an
> > > install_headers target that builds a vmlinux.h.
> >
> > I tried to do the minimal header and it's not too big,
> > I pushed it in here:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=
=3Dperf/vmlinux_h
> >
> > compile tested so far
>
> I see it and it makes the change to be minimal, which is good at the
> current stage, but I wonder if it wouldn't be better for us to define
> just the ones not in UAPI and use the #include <linux/bpf.h>,
> <linux/perf_event.h> as I did in the patches I posted here and Namhyung
> tested at least one, this way the added vmlinux.h file get even smaller
> by not including things like:
>
> [acme@quaco perf-tools]$ egrep -w '(perf_event_sample_format|bpf_perf_eve=
nt_value|perf_sample_weight|perf_mem_data_src) {' include/uapi/linux/*.h
> include/uapi/linux/bpf.h:struct bpf_perf_event_value {
> include/uapi/linux/perf_event.h:enum perf_event_sample_format {
> include/uapi/linux/perf_event.h:union perf_mem_data_src {
> include/uapi/linux/perf_event.h:union perf_mem_data_src {
> include/uapi/linux/perf_event.h:union perf_sample_weight {
> [acme@quaco perf-tools]$
>
> Also why do we need these:
>
> +struct mm_struct {
> +} __attribute__((preserve_access_index));
> +
> +struct raw_spinlock {
> +} __attribute__((preserve_access_index));
> +
> +typedef struct raw_spinlock raw_spinlock_t;
> +
> +struct spinlock {
> +} __attribute__((preserve_access_index));
> +
> +typedef struct spinlock spinlock_t;
> +
> +struct sighand_struct {
> +       spinlock_t siglock;
> +} __attribute__((preserve_access_index));
>
> We don't use them, they're just pointers you kept on:
>
> +struct task_struct {
> +       struct css_set *cgroups;
> +       pid_t pid;
> +       pid_t tgid;
> +       char comm[16];
> +       struct mm_struct *mm;
> +       struct sighand_struct *sighand;
> +       unsigned int flags;
> +} __attribute__((preserve_access_index));
>
> That with the preserve_access_index isn't needed, we need just the
> fields that we access in the tools, right?

Aside from that you probably want to take a look at BTFgen.
Old doc:
https://github.com/aquasecurity/btfhub/blob/main/docs/btfgen-internals.md
which landed as
"bpftool gen min_core_btf"
man bpftool-gen

It addresses the use case for kernels _without_ CONFIG_DEBUG_INFO_BTF.

