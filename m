Return-Path: <bpf+bounces-116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA226F83CF
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 15:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FF01C218B3
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F1FC13E;
	Fri,  5 May 2023 13:20:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEEC1FB3
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 13:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58040C433EF;
	Fri,  5 May 2023 13:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683292840;
	bh=1tIXs2qrQIkUsmb/r+/EjrPd2vRi0DVKFZc6hOpHua0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsO0Qsl4rH4ZK0mnu5QCJzz0ti4NCFYq2SRFKkroDjxrXU+3PZNRq7qnUMyIpbVwJ
	 k1E2CTvz1Uhhk9lbMEgn9EmSSiNTr2msESUGLL3RSI/prmW+m1Tbrj8r+jb2AJbG/B
	 L8ls+7GZBtoKdjszRDtbcxUMnmV41xn+XNFE2pa2LkN23ZU5FvyGGx0cc+co/03hQm
	 zAxhiJGOmO3NfRqYP0EEWP1IWMyn7alV652KyRu8PqOCFUxNmru4gr80kjsth01iEM
	 dh3iYtCJsq05V2RzCQnUaT+Tu9+ux5ikFuT1VsBU/WZGml8W8czcMhFAjEbvVy/YhK
	 OeE8Evuwm8SOA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B0600403B5; Fri,  5 May 2023 10:20:37 -0300 (-03)
Date: Fri, 5 May 2023 10:20:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
Message-ID: <ZFUCpepjOfFZjETL@kernel.org>
References: <20230503211801.897735-1-acme@kernel.org>
 <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
 <ZFQrT42SyEbCj4om@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFQrT42SyEbCj4om@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, May 04, 2023 at 07:01:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, May 04, 2023 at 06:48:50PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> > > > On Thu, May 4, 2023 at 10:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > Andrii, can you add some more information about the usage of vmlinux.h
> > > > > instead of using kernel headers?
> > >  
> > > > I'll just say that vmlinux.h is not a hard requirement to build BPF
> > > > programs, it's more a convenience allowing easy access to definitions
> > > > of both UAPI and kernel-internal structures for tracing needs and
> > > > marking them relocatable using BPF CO-RE machinery. Lots of real-world
> > > > applications just check-in pregenerated vmlinux.h to avoid build-time
> > > > dependency on up-to-date host kernel and such.
> > >  
> > > > If vmlinux.h generation and usage is causing issues, though, given
> > > > that perf's BPF programs don't seem to be using many different kernel
> > > > types, it might be a better option to just use UAPI headers for public
> > > > kernel type definitions, and just define CO-RE-relocatable minimal
> > > > definitions locally in perf's BPF code for the other types necessary.
> > > > E.g., if perf needs only pid and tgid from task_struct, this would
> > > > suffice:
> > >  
> > > > struct task_struct {
> > > >     int pid;
> > > >     int tgid;
> > > > } __attribute__((preserve_access_index));
> > > 
> > > Yeah, that seems like a way better approach, no vmlinux involved, libbpf
> > > CO-RE notices that task_struct changed from this two integers version
> > > (of course) and does the relocation to where it is in the running kernel
> > > by using /sys/kernel/btf/vmlinux.
> > 
> > Doing it for one of the skels, build tested, runtime untested, but not
> > using any vmlinux, BTF to help, not that bad, more verbose, but at least
> > we state what are the fields we actually use, have those attribute
> > documenting that those offsets will be recorded for future use, etc.
> > 

Namhyung, can you please check that this one for the recent sample works?

From c6972dae6c962d7be5ba006ab90c9955268debc5 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 5 May 2023 09:55:18 -0300
Subject: [PATCH 1/2] perf sample_filter.bpf: Stop using vmlinux.h generated by
 bpftool, use CO-RE

Including linux/bpf.h and linux/perf_events.h we get the UAPI structs
and then define a subset  'struct perf_sample_data' with the fields we
use in this tool while using __attribute__((preserve_access_index)) so
that at libbpf load time it can fixup the offsets according to the
'struct perf_data_sample' obtained from the running kernel BTF
(/sys/kernel/btf/vmlinux).

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 37 +++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index cffe493af1ed5f31..045532c2366d74ef 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -1,12 +1,47 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2023 Google
-#include "vmlinux.h"
+#include <linux/bpf.h>
+#include <linux/perf_event.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
 #include "sample-filter.h"
 
+// non-UAPI kernel data structures, just the fields used in this tool,
+// preserving the access index so that libbpf can fixup offsets with the ones
+// used in the kernel when loading the BPF bytecode, if they differ from what
+// is used here.
+
+struct perf_sample_data {
+	__u64			 addr;
+	__u64			 period;
+	union perf_sample_weight weight;
+	__u64			 txn;
+	union perf_mem_data_src  data_src;
+	__u64			 ip;
+	struct {
+		__u32		 pid;
+		__u32		 tid;
+	} tid_entry;
+	__u64			 time;
+	__u64			 id;
+	struct {
+		__u32		 cpu;
+	} cpu_entry;
+	__u64			 phys_addr;
+	__u64			 data_page_size;
+	__u64			 code_page_size;
+} __attribute__((__aligned__(64))) __attribute__((preserve_access_index));
+
+struct bpf_perf_event_data_kern {
+	struct perf_sample_data *  data;
+	struct perf_event *        event;
+
+	/* size: 24, cachelines: 1, members: 3 */
+	/* last cacheline: 24 bytes */
+} __attribute__((preserve_access_index));
+
 /* BPF map that will be filled by user space */
 struct filters {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-- 
2.39.2


