Return-Path: <bpf+bounces-37-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38B56F78B7
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CC11C214D2
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5430CC154;
	Thu,  4 May 2023 22:01:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E67156F9
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E55C433EF;
	Thu,  4 May 2023 22:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683237714;
	bh=/NJ6Cald5+QS56sCAuNzMM1M5flzPChjXCm5ynFJYQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+5424SKbXYqbT0mgsI00job7vX+kMoBhiO6zEcFWD7IKK8dKILH1fbHs5VuovBAB
	 TT+aZ8bt+ofbgNFMY7901FzeEEmZhhlQpf3mA+XLKAaKk+YPxW6ORLw4813s8xQknC
	 TrPO6uxIZpR4r+7g9B2jD5rFVKAzqJske9MVvmWAw47OE8mvSQ3NmTJGYSRCa57V4U
	 KwQTL1tKPgqtiSFVrvoLIKk6pmOSOU6ouKxHb6Lct81LJwB5aloJ2y9/wa29s/1CvN
	 QDLkIFpAMMuNuLaQN5xUwoejsI8JsHYk7HC/GxQKQU2jFbCWBrX6LfyZ0khoKc9RsM
	 ppQjhFyyG26rw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B05B7403B5; Thu,  4 May 2023 19:01:51 -0300 (-03)
Date: Thu, 4 May 2023 19:01:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>,
	Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Roman Lozko <lozko.roma@gmail.com>,
	Stephane Eranian <eranian@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFQrT42SyEbCj4om@kernel.org>
References: <20230503211801.897735-1-acme@kernel.org>
 <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFQoQjCNtyMIulp+@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, May 04, 2023 at 06:48:50PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> > > On Thu, May 4, 2023 at 10:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > Andrii, can you add some more information about the usage of vmlinux.h
> > > > instead of using kernel headers?
> >  
> > > I'll just say that vmlinux.h is not a hard requirement to build BPF
> > > programs, it's more a convenience allowing easy access to definitions
> > > of both UAPI and kernel-internal structures for tracing needs and
> > > marking them relocatable using BPF CO-RE machinery. Lots of real-world
> > > applications just check-in pregenerated vmlinux.h to avoid build-time
> > > dependency on up-to-date host kernel and such.
> >  
> > > If vmlinux.h generation and usage is causing issues, though, given
> > > that perf's BPF programs don't seem to be using many different kernel
> > > types, it might be a better option to just use UAPI headers for public
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
> > Yeah, that seems like a way better approach, no vmlinux involved, libbpf
> > CO-RE notices that task_struct changed from this two integers version
> > (of course) and does the relocation to where it is in the running kernel
> > by using /sys/kernel/btf/vmlinux.
> 
> Doing it for one of the skels, build tested, runtime untested, but not
> using any vmlinux, BTF to help, not that bad, more verbose, but at least
> we state what are the fields we actually use, have those attribute
> documenting that those offsets will be recorded for future use, etc.
> 
> Namhyung, can you please check that this works?

Second case was simpler:

diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
index f193998530d431d8..1ab06f2ff5ad7548 100644
--- a/tools/perf/util/bpf_skel/bperf_follower.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2021 Facebook
-#include "vmlinux.h"
+#include <linux/types.h>
+#include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bperf_u.h"

