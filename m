Return-Path: <bpf+bounces-117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7CC6F8419
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 15:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA9D1C21888
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 13:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9F6C156;
	Fri,  5 May 2023 13:33:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5738BE0
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 13:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37100C433D2;
	Fri,  5 May 2023 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683293598;
	bh=lYgIx4LtUAxSTE+FLYMqSKn8Xm5Kd/760J8cWkFOZxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzrZXGlhPUqc1ZlQh22FixMA6wnYqukcQ6wxPquyf+B7LZzPbxcq/0svrb0WjXFT0
	 UYMzCVd9a5crtktP5peVmOBMBJ0GCtYfd7ILFh4R8Xt2/gfZwbJ1Na808To+OMaJ7X
	 EKmtLuy5EM0sFzGtSmODdaiDlNMZTTPiiKA79QRV+aBaTEB1i1PPUIkIoiLFJ07Wj5
	 oR0Wn7YqxOOWBg+9jRVpSn3M/QJj/j17bBinDDdUZ7IRnwpyDyrGlmp2iN4LV5jSYZ
	 PTUevltLdI+e2qv9TKZ7+rrp4w3laRTvif7c8uzwHdPmOj6bC3GPR5HjwQeIR+q2yq
	 F/FavQkiGYKhw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id ACD31403B5; Fri,  5 May 2023 10:33:15 -0300 (-03)
Date: Fri, 5 May 2023 10:33:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Ian Rogers <irogers@google.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Roman Lozko <lozko.roma@gmail.com>,
	Stephane Eranian <eranian@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFUFmxDU/6Z/JEsi@kernel.org>
References: <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFQ5sjjtfEYzvHNP@krava>
X-Url: http://acmel.wordpress.com

Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreveu:
> On Thu, May 04, 2023 at 03:03:42PM -0700, Ian Rogers wrote:
> > On Thu, May 4, 2023 at 2:48 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >
> > > Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> > > > > On Thu, May 4, 2023 at 10:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > > Andrii, can you add some more information about the usage of vmlinux.h
> > > > > > instead of using kernel headers?
> > > >
> > > > > I'll just say that vmlinux.h is not a hard requirement to build BPF
> > > > > programs, it's more a convenience allowing easy access to definitions
> > > > > of both UAPI and kernel-internal structures for tracing needs and
> > > > > marking them relocatable using BPF CO-RE machinery. Lots of real-world
> > > > > applications just check-in pregenerated vmlinux.h to avoid build-time
> > > > > dependency on up-to-date host kernel and such.
> > > >
> > > > > If vmlinux.h generation and usage is causing issues, though, given
> > > > > that perf's BPF programs don't seem to be using many different kernel
> > > > > types, it might be a better option to just use UAPI headers for public
> > > > > kernel type definitions, and just define CO-RE-relocatable minimal
> > > > > definitions locally in perf's BPF code for the other types necessary.
> > > > > E.g., if perf needs only pid and tgid from task_struct, this would
> > > > > suffice:
> > > >
> > > > > struct task_struct {
> > > > >     int pid;
> > > > >     int tgid;
> > > > > } __attribute__((preserve_access_index));
> > > >
> > > > Yeah, that seems like a way better approach, no vmlinux involved, libbpf
> > > > CO-RE notices that task_struct changed from this two integers version
> > > > (of course) and does the relocation to where it is in the running kernel
> > > > by using /sys/kernel/btf/vmlinux.
> > >
> > > Doing it for one of the skels, build tested, runtime untested, but not
> > > using any vmlinux, BTF to help, not that bad, more verbose, but at least
> > > we state what are the fields we actually use, have those attribute
> > > documenting that those offsets will be recorded for future use, etc.
> > >
> > > Namhyung, can you please check that this works?
> > >
> > > Thanks,
> > >
> > > - Arnaldo
> > >
> > > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
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
> > https://github.com/iovisor/bcc/tree/master/libbpf-tools#vmlinuxh-generation
> > https://github.com/iovisor/bcc/tree/master/libbpf-tools/arm64
> > 
> > This would also remove some of the errors that could be introduced by
> > copy+pasting enums, etc. and also highlight issues with things being
> > renamed as build time rather than runtime failures.
> 
> we already have to deal with that, right? doing checks on fields in
> structs like mm_struct___old
> 
> > Could this be some shared resource for the different linux tools
> > projects using a vmlinux.h? e.g. tools/lib/vmlinuxh with an
> > install_headers target that builds a vmlinux.h.
> 
> I tried to do the minimal header and it's not too big,
> I pushed it in here:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=perf/vmlinux_h
> 
> compile tested so far

I see it and it makes the change to be minimal, which is good at the
current stage, but I wonder if it wouldn't be better for us to define
just the ones not in UAPI and use the #include <linux/bpf.h>,
<linux/perf_event.h> as I did in the patches I posted here and Namhyung
tested at least one, this way the added vmlinux.h file get even smaller
by not including things like:

[acme@quaco perf-tools]$ egrep -w '(perf_event_sample_format|bpf_perf_event_value|perf_sample_weight|perf_mem_data_src) {' include/uapi/linux/*.h
include/uapi/linux/bpf.h:struct bpf_perf_event_value {
include/uapi/linux/perf_event.h:enum perf_event_sample_format {
include/uapi/linux/perf_event.h:union perf_mem_data_src {
include/uapi/linux/perf_event.h:union perf_mem_data_src {
include/uapi/linux/perf_event.h:union perf_sample_weight {
[acme@quaco perf-tools]$

Also why do we need these:

+struct mm_struct {
+} __attribute__((preserve_access_index));
+
+struct raw_spinlock {
+} __attribute__((preserve_access_index));
+
+typedef struct raw_spinlock raw_spinlock_t;
+
+struct spinlock {
+} __attribute__((preserve_access_index));
+
+typedef struct spinlock spinlock_t;
+
+struct sighand_struct {
+	spinlock_t siglock;
+} __attribute__((preserve_access_index));

We don't use them, they're just pointers you kept on:

+struct task_struct {
+	struct css_set *cgroups;
+	pid_t pid;
+	pid_t tgid;
+	char comm[16];
+	struct mm_struct *mm;
+	struct sighand_struct *sighand;
+	unsigned int flags;
+} __attribute__((preserve_access_index));

That with the preserve_access_index isn't needed, we need just the
fields that we access in the tools, right?

- Arnaldo


