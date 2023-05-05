Return-Path: <bpf+bounces-115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F096A6F83B8
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 15:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDCD280E41
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343FAC12F;
	Fri,  5 May 2023 13:18:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95431156DA
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 13:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E735C433EF;
	Fri,  5 May 2023 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683292688;
	bh=iWuVMtbZc8fX58fKAMNGGbRV6grNa+1PwhlQF6nB89w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S35fn3fxmBi+6jrRNiFXaSAC30eGZPm5Rkh1QJQgPtnF7tFmgi7tb6ddOydiLE6om
	 7Gjv4ZuG4WmfLsZ0dSiVV8a7v0Zp2DcKKYCBtGTsWyrgsFeaSk0f8CYsO+0iewbAMM
	 Ahb6wb5/sTjdVBBzRJ0NJSfJu8TIqhiVuv7Lrm6oketO3vo+F5bEP6dwpZS5E4Zzfe
	 ZaXHWQwCesJhtU23Y1DWwYZWwfPmyobsrXya4D5V5eZLZO1N3CUObCjj8oclaO46VB
	 A7mcIl9HDHQydU25b2IdCirzsW4I79Klrut2T+5xqyTFsVWbwTDH4fFupjaIhnuic4
	 5GR2x18K4OHlQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 4BA9E403B5; Fri,  5 May 2023 10:18:05 -0300 (-03)
Date: Fri, 5 May 2023 10:18:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
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
Message-ID: <ZFUCDVpqXkpGjXBK@kernel.org>
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

Yang, can you please check that this works?


From bd6289bc3ffc89aecad3bd8798d76626c8c16d39 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 5 May 2023 10:13:09 -0300
Subject: [PATCH 1/1] perf kwork_trace.bpf: Stop using vmlinux.h, grab copies
 of used structs

And mark them with __attribute__((preserve_access_index)) so that
libbpf's CO-RE code can fixup offsets if they differ with the kernel
data structure.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_skel/kwork_trace.bpf.c | 70 +++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/kwork_trace.bpf.c b/tools/perf/util/bpf_skel/kwork_trace.bpf.c
index 063c124e099938ed..e38fe54c7667fa74 100644
--- a/tools/perf/util/bpf_skel/kwork_trace.bpf.c
+++ b/tools/perf/util/bpf_skel/kwork_trace.bpf.c
@@ -1,13 +1,81 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2022, Huawei
 
-#include "vmlinux.h"
+#include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
 #define KWORK_COUNT 100
 #define MAX_KWORKNAME 128
 
+
+// non-UAPI kernel data structures, just the fields used in this tool,
+// preserving the access index so that libbpf can fixup offsets with the ones
+// used in the kernel when loading the BPF bytecode, if they differ from what
+// is used here.
+
+enum {
+	HI_SOFTIRQ = 0,
+	TIMER_SOFTIRQ,
+	NET_TX_SOFTIRQ,
+	NET_RX_SOFTIRQ,
+	BLOCK_SOFTIRQ,
+	IRQ_POLL_SOFTIRQ,
+	TASKLET_SOFTIRQ,
+	SCHED_SOFTIRQ,
+	HRTIMER_SOFTIRQ,
+	RCU_SOFTIRQ,    /* Preferable RCU should always be the last softirq */
+
+	NR_SOFTIRQS
+};
+
+struct trace_entry {
+	short unsigned int type;
+	unsigned char	   flags;
+	unsigned char	   preempt_count;
+	int		   pid;
+} __attribute__((preserve_access_index));
+
+struct trace_event_raw_irq_handler_entry {
+	struct trace_entry ent;
+	int		   irq;
+	__u32		   __data_loc_name;
+	char		   __data[];
+} __attribute__((preserve_access_index));
+
+struct trace_event_raw_irq_handler_exit {
+	struct trace_entry ent;
+	int		   irq;
+	int		   ret;
+	char		   __data[];
+} __attribute__((preserve_access_index));
+
+struct trace_event_raw_softirq {
+	struct trace_entry ent;
+	unsigned int	   vec;
+	char		   __data[];
+} __attribute__((preserve_access_index));
+
+struct trace_event_raw_workqueue_execute_start {
+	struct trace_entry ent;
+	void		   *work;
+	void		   *function;
+	char		   __data[];
+} __attribute__((preserve_access_index));
+
+struct trace_event_raw_workqueue_execute_end {
+	struct trace_entry ent;
+	void		   *work;
+	void		   *function;
+	char		  __data[];
+} __attribute__((preserve_access_index));
+
+struct trace_event_raw_workqueue_activate_work {
+	struct trace_entry ent;
+	void		   *work;
+	char		   __data[];
+} __attribute__((preserve_access_index));
+
 /*
  * This should be in sync with "util/kwork.h"
  */
-- 
2.39.2


