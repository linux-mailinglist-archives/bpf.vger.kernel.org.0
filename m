Return-Path: <bpf+bounces-157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B206F8BA1
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 23:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7EF1C21988
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63688101D6;
	Fri,  5 May 2023 21:52:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2CC8C5
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 21:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FE0C433EF;
	Fri,  5 May 2023 21:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683323527;
	bh=LBfqOVw4Z6GuC13VItNamLAOjDe39tStvarVotopRwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nok614urewGKxx3mZLQ/3JFXst8YbvkWMLPAmAn9CWcdDQ/FzIJ6nHeDT3Cajoj00
	 CpFtyY+cEijzqw0scykBhuSuCFqmN1Svg3TNehoyBYgVBX30BskZBqRRen/BtFJMoZ
	 2cpS/QqWAB2lBlUniu3jVyrZ4TGZD9LqmW52FeNlwdsraQ6KLZDdGNDZo2U4UPR0yG
	 AuGXuIBNtwIbRMe2hcSa1nXroMfNf+JmAjWe2Y65llfDHd8CSL2dD5UTF+Y9VfwcBc
	 bPgmJyZOIsfiK4VwVckWcMIPtj6C/hUwbJax6GZJrHKWhPoWeC3PJEtG9Yi1/LnTpO
	 WGg+c20r6DZbw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 1C043403B5; Fri,  5 May 2023 18:52:04 -0300 (-03)
Date: Fri, 5 May 2023 18:52:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
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
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Yang Jihong <yangjihong1@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH RFC/RFT] perf bpf skels: Stop using vmlinux.h generated
 from BTF, use subset of used structs + CO-RE. was Re: BPF skels in perf .Re:
 [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFV6hFG/YMiF8vY0@kernel.org>
References: <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava>
 <ZFUFmxDU/6Z/JEsi@kernel.org>
 <ZFU1PJrn8YtHIqno@kernel.org>
 <CAP-5=fWfmmMCRnEmzj_CXTKacp6gjrzmR49Ge_C5XRyfTegRjg@mail.gmail.com>
 <ZFVqeKLssg7uzxzI@krava>
 <CAP-5=fVgJdBvjV8S2xKswAFiSZvyCcUvZTO1bsLyUf-wQ0pBuw@mail.gmail.com>
 <ZFVyAap3R9RZ+P6u@krava>
 <CAEf4BzYYnpD6+GSg+wfL1wUY5YasbN2-9NPJ3QkGZ9o963uYdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYYnpD6+GSg+wfL1wUY5YasbN2-9NPJ3QkGZ9o963uYdA@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, May 05, 2023 at 02:21:56PM -0700, Andrii Nakryiko escreveu:
> On Fri, May 5, 2023 at 2:15 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, May 05, 2023 at 01:46:30PM -0700, Ian Rogers wrote:
> > > On Fri, May 5, 2023 at 1:43 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Fri, May 05, 2023 at 10:04:47AM -0700, Ian Rogers wrote:
> > > > > On Fri, May 5, 2023 at 9:56 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > >
> > > > > > Em Fri, May 05, 2023 at 10:33:15AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > > Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreveu:
> > > > > > > That with the preserve_access_index isn't needed, we need just the
> > > > > > > fields that we access in the tools, right?
> > > > > >
> > > > > > I'm now doing build test this in many distro containers, without the two
> > > > > > reverts, i.e. BPF skels continue as opt-out as in my pull request, to
> > > > > > test build and also for the functionality tests on the tools using such
> > > > > > bpf skels, see below, no touching of vmlinux nor BTF data during the
> > > > > > build.
> > > > > >
> > > > > > - Arnaldo
> > > > > >
> > > > > > From 882adaee50bc27f85374aeb2fbaa5b76bef60d05 Mon Sep 17 00:00:00 2001
> > > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > > Date: Thu, 4 May 2023 19:03:51 -0300
> > > > > > Subject: [PATCH 1/1] perf bpf skels: Stop using vmlinux.h generated from BTF,
> > > > > >  use subset of used structs + CO-RE
> > > > > >
> > > > > > Linus reported a build break due to using a vmlinux without a BTF elf
> > > > > > section to generate the vmlinux.h header with bpftool for use in the BPF
> > > > > > tools in tools/perf/util/bpf_skel/*.bpf.c.
> > > > > >
> > > > > > Instead add a vmlinux.h file with the structs needed with the fields the
> > > > > > tools need, marking the structs with __attribute__((preserve_access_index)),
> > > > > > so that libbpf's CO-RE code can fixup the struct field offsets.
> > > > > >
> > > > > > In some cases the vmlinux.h file that was being generated by bpftool
> > > > > > from the kernel BTF information was not needed at all, just including
> > > > > > linux/bpf.h, sometimes linux/perf_event.h was enough as non-UAPI
> > > > > > types were not being used.
> > > > > >
> > > > > > To keep te patch small, include those UAPI headers from the trimmed down
> > > > > > vmlinux.h file, that then provides the tools with just the structs and
> > > > > > the subset of its fields needed for them.
> > > > > >
> > > > > > Testing it:
> > > > > >
> > > > > >   # perf lock contention -b find / > /dev/null
> > > >
> > > > I tested perf lock con -abv -L rcu_state sleep 1
> > > > and needed fix below
> > > >
> > > > jirka
> > >
> > > I thought this was fixed by:
> > > https://lore.kernel.org/lkml/20230427234833.1576130-1-namhyung@kernel.org/
> > > but I think that is just in perf-tools-next.
> >
> > ah ok, missed that one
> 
> Please try validating with veristat to check if all of perf's .bpf.o
> files are successful. Veristat is part of selftests and can be built
> with just `make -C tools/testing/selftests/bpf veristat`. After that;
> 
>  sudo ~/bin/veristat tools/perf/util/bpf_skel/.tmp/*.bpf.o
> 
> This is a surer way to check that BPF object files are ok at least on
> your currently running kernel, than trying to exercise each BPF
> program through perf commands.

[acme@quaco perf-tools]$ sudo tools/testing/selftests/bpf/veristat /tmp/build/perf-tools/util/bpf_skel/.tmp/*.bpf.o
Processing 'bperf_cgroup.bpf.o'...
Processing 'bperf_follower.bpf.o'...
Processing 'bperf_leader.bpf.o'...
Processing 'bpf_prog_profiler.bpf.o'...
Processing 'func_latency.bpf.o'...
Processing 'kwork_trace.bpf.o'...
Processing 'lock_contention.bpf.o'...
Processing 'off_cpu.bpf.o'...
Processing 'sample_filter.bpf.o'...
File                     Program                          Verdict  Duration (us)   Insns  States  Peak states
-----------------------  -------------------------------  -------  -------------  ------  ------  -----------
bperf_cgroup.bpf.o       on_cgrp_switch                   success           6479   17025     417          174
bperf_cgroup.bpf.o       trigger_read                     success           6370   17025     417          174
bperf_follower.bpf.o     fexit_XXX                        failure              0       0       0            0
bperf_leader.bpf.o       on_switch                        success            360      49       3            3
bpf_prog_profiler.bpf.o  fentry_XXX                       failure              0       0       0            0
bpf_prog_profiler.bpf.o  fexit_XXX                        failure              0       0       0            0
func_latency.bpf.o       func_begin                       success            351      69       6            6
func_latency.bpf.o       func_end                         success            318     158      15           15
kwork_trace.bpf.o        latency_softirq_entry            success            334     108      10           10
kwork_trace.bpf.o        latency_softirq_raise            success            896    1993      34           34
kwork_trace.bpf.o        latency_workqueue_activate_work  success            333      46       4            4
kwork_trace.bpf.o        latency_workqueue_execute_start  success           1112    2219      41           41
kwork_trace.bpf.o        report_irq_handler_entry         success           1067    2118      34           34
kwork_trace.bpf.o        report_irq_handler_exit          success            334     110      10           10
kwork_trace.bpf.o        report_softirq_entry             success            897    1993      34           34
kwork_trace.bpf.o        report_softirq_exit              success            329     108      10           10
kwork_trace.bpf.o        report_workqueue_execute_end     success           1124    2219      41           41
kwork_trace.bpf.o        report_workqueue_execute_start   success            295      46       4            4
lock_contention.bpf.o    collect_lock_syms                failure              0       0       0            0
lock_contention.bpf.o    contention_begin                 failure              0       0       0            0
lock_contention.bpf.o    contention_end                   failure              0       0       0            0
off_cpu.bpf.o            on_newtask                       success            387      37       3            3
off_cpu.bpf.o            on_switch                        success            536     220      20           20
sample_filter.bpf.o      perf_sample_filter               success         190443  190237   11173          923
-----------------------  -------------------------------  -------  -------------  ------  ------  -----------
Done. Processed 9 files, 0 programs. Skipped 24 files, 0 programs.
[acme@quaco perf-tools]$

What extra info can we get from these "failure" lines?

- Arnaldo

