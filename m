Return-Path: <bpf+bounces-158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28DE6F8BAD
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 23:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5203281088
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70878101D9;
	Fri,  5 May 2023 21:55:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F76C8C5
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 21:55:38 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069AD4C20;
	Fri,  5 May 2023 14:55:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso4419862a12.2;
        Fri, 05 May 2023 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683323734; x=1685915734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igMXY2upF6BHuolza5GTaP180gzi0NqOA7/svwM/uoA=;
        b=MH7xOT8ARsMtmBiHxY4K9VW4lrUK6Bsbhg17pb12VleRO9JqfmR00piqOPtnMcLEWr
         pLi9Z3IK9b0DSzB2gDvzFaIg2Bb/lTtnOnLgHxfb4uePHSC9QeBJrRv/HK4Ts0XgeWUX
         P4WX+N1IH2ZrD/t9ds/u2wKdATQCLvWF3x+jbtZsAeqSXcHyznvUdv9xTo5unoCgnH0O
         7XXpGD1S5yOEMBFC+jyMoW1bp+uohpx/hpPuNRTWto4bnSHPHyRiW5e3J7OGNwY3dGy/
         aYrigr72x3XO4o309Tm99wCItFpit8QEP49MpkeTMOW1a7C5yxJWTAe1b2I3IVmK1uf6
         /zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683323734; x=1685915734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igMXY2upF6BHuolza5GTaP180gzi0NqOA7/svwM/uoA=;
        b=UbCv/eGM9y/xJqBQW2ri3URk2Ri96po5L3x/1s04WIOOOkKWy14FDTYX7B//n3tEb4
         3DDeW4GrymU9wEB1wHM9hVhRz/rD3tIhspGfH+SUrGBI9/+76wwJRtiTQnREcDDnUypW
         p5xNECGX42V6qezQ1wTwPiRd8/qErnho2S8ZNfBOXd5s3KNDIjt7NBua+aK8cNselbLr
         8bjbcMw9Uw0IQzAusfomOE0VIHmXybsoi2u/lr+77ZopjTRIoatbmbSnlgCsAE4Eb9BU
         Pbc3ssziekgxLfSeaVcfmFKMv3b5syudOL1n9BTOJldPSgjR+CpCx9sa8mUhSWYF/yv0
         fbmQ==
X-Gm-Message-State: AC+VfDw34uepbiCeUdG6ugm33v3aBeVAdXPycbJFwZ2ZwbNQ3vk7MhVZ
	yomxpEOw+DFSbuRvYBhHkU9wGJSb5eCTOpaUNN0=
X-Google-Smtp-Source: ACHHUZ6N9niCJzBs5Rqv35FpuFT1+q0PipbyCMZcQrvzBM1PlPMNpIfBg4brgiB1yMTnsLIOS6E5/+ZYO5x6+2EQT1M=
X-Received: by 2002:a17:906:eec5:b0:965:9e78:c579 with SMTP id
 wu5-20020a170906eec500b009659e78c579mr2374695ejb.16.1683323734248; Fri, 05
 May 2023 14:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZFQoQjCNtyMIulp+@kernel.org> <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava> <ZFUFmxDU/6Z/JEsi@kernel.org> <ZFU1PJrn8YtHIqno@kernel.org>
 <CAP-5=fWfmmMCRnEmzj_CXTKacp6gjrzmR49Ge_C5XRyfTegRjg@mail.gmail.com>
 <ZFVqeKLssg7uzxzI@krava> <CAP-5=fVgJdBvjV8S2xKswAFiSZvyCcUvZTO1bsLyUf-wQ0pBuw@mail.gmail.com>
 <ZFVyAap3R9RZ+P6u@krava> <CAEf4BzYYnpD6+GSg+wfL1wUY5YasbN2-9NPJ3QkGZ9o963uYdA@mail.gmail.com>
 <ZFV6hFG/YMiF8vY0@kernel.org>
In-Reply-To: <ZFV6hFG/YMiF8vY0@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 May 2023 14:55:21 -0700
Message-ID: <CAEf4BzYjzj_Q+D39EM6ZggquB7YN1+iPE0rG_82NMXXd215vDg@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT] perf bpf skels: Stop using vmlinux.h generated
 from BTF, use subset of used structs + CO-RE. was Re: BPF skels in perf .Re:
 [GIT PULL] perf tools changes for v6.4
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Namhyung Kim <namhyung@kernel.org>, 
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Roman Lozko <lozko.roma@gmail.com>, Stephane Eranian <eranian@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yang Jihong <yangjihong1@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Clarke <pc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 5, 2023 at 2:52=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Fri, May 05, 2023 at 02:21:56PM -0700, Andrii Nakryiko escreveu:
> > On Fri, May 5, 2023 at 2:15=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Fri, May 05, 2023 at 01:46:30PM -0700, Ian Rogers wrote:
> > > > On Fri, May 5, 2023 at 1:43=E2=80=AFPM Jiri Olsa <olsajiri@gmail.co=
m> wrote:
> > > > >
> > > > > On Fri, May 05, 2023 at 10:04:47AM -0700, Ian Rogers wrote:
> > > > > > On Fri, May 5, 2023 at 9:56=E2=80=AFAM Arnaldo Carvalho de Melo=
 <acme@kernel.org> wrote:
> > > > > > >
> > > > > > > Em Fri, May 05, 2023 at 10:33:15AM -0300, Arnaldo Carvalho de=
 Melo escreveu:
> > > > > > > > Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreve=
u:
> > > > > > > > That with the preserve_access_index isn't needed, we need j=
ust the
> > > > > > > > fields that we access in the tools, right?
> > > > > > >
> > > > > > > I'm now doing build test this in many distro containers, with=
out the two
> > > > > > > reverts, i.e. BPF skels continue as opt-out as in my pull req=
uest, to
> > > > > > > test build and also for the functionality tests on the tools =
using such
> > > > > > > bpf skels, see below, no touching of vmlinux nor BTF data dur=
ing the
> > > > > > > build.
> > > > > > >
> > > > > > > - Arnaldo
> > > > > > >
> > > > > > > From 882adaee50bc27f85374aeb2fbaa5b76bef60d05 Mon Sep 17 00:0=
0:00 2001
> > > > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > > > Date: Thu, 4 May 2023 19:03:51 -0300
> > > > > > > Subject: [PATCH 1/1] perf bpf skels: Stop using vmlinux.h gen=
erated from BTF,
> > > > > > >  use subset of used structs + CO-RE
> > > > > > >
> > > > > > > Linus reported a build break due to using a vmlinux without a=
 BTF elf
> > > > > > > section to generate the vmlinux.h header with bpftool for use=
 in the BPF
> > > > > > > tools in tools/perf/util/bpf_skel/*.bpf.c.
> > > > > > >
> > > > > > > Instead add a vmlinux.h file with the structs needed with the=
 fields the
> > > > > > > tools need, marking the structs with __attribute__((preserve_=
access_index)),
> > > > > > > so that libbpf's CO-RE code can fixup the struct field offset=
s.
> > > > > > >
> > > > > > > In some cases the vmlinux.h file that was being generated by =
bpftool
> > > > > > > from the kernel BTF information was not needed at all, just i=
ncluding
> > > > > > > linux/bpf.h, sometimes linux/perf_event.h was enough as non-U=
API
> > > > > > > types were not being used.
> > > > > > >
> > > > > > > To keep te patch small, include those UAPI headers from the t=
rimmed down
> > > > > > > vmlinux.h file, that then provides the tools with just the st=
ructs and
> > > > > > > the subset of its fields needed for them.
> > > > > > >
> > > > > > > Testing it:
> > > > > > >
> > > > > > >   # perf lock contention -b find / > /dev/null
> > > > >
> > > > > I tested perf lock con -abv -L rcu_state sleep 1
> > > > > and needed fix below
> > > > >
> > > > > jirka
> > > >
> > > > I thought this was fixed by:
> > > > https://lore.kernel.org/lkml/20230427234833.1576130-1-namhyung@kern=
el.org/
> > > > but I think that is just in perf-tools-next.
> > >
> > > ah ok, missed that one
> >
> > Please try validating with veristat to check if all of perf's .bpf.o
> > files are successful. Veristat is part of selftests and can be built
> > with just `make -C tools/testing/selftests/bpf veristat`. After that;
> >
> >  sudo ~/bin/veristat tools/perf/util/bpf_skel/.tmp/*.bpf.o
> >
> > This is a surer way to check that BPF object files are ok at least on
> > your currently running kernel, than trying to exercise each BPF
> > program through perf commands.
>
> [acme@quaco perf-tools]$ sudo tools/testing/selftests/bpf/veristat /tmp/b=
uild/perf-tools/util/bpf_skel/.tmp/*.bpf.o
> Processing 'bperf_cgroup.bpf.o'...
> Processing 'bperf_follower.bpf.o'...
> Processing 'bperf_leader.bpf.o'...
> Processing 'bpf_prog_profiler.bpf.o'...
> Processing 'func_latency.bpf.o'...
> Processing 'kwork_trace.bpf.o'...
> Processing 'lock_contention.bpf.o'...
> Processing 'off_cpu.bpf.o'...
> Processing 'sample_filter.bpf.o'...
> File                     Program                          Verdict  Durati=
on (us)   Insns  States  Peak states
> -----------------------  -------------------------------  -------  ------=
-------  ------  ------  -----------
> bperf_cgroup.bpf.o       on_cgrp_switch                   success        =
   6479   17025     417          174
> bperf_cgroup.bpf.o       trigger_read                     success        =
   6370   17025     417          174
> bperf_follower.bpf.o     fexit_XXX                        failure        =
      0       0       0            0
> bperf_leader.bpf.o       on_switch                        success        =
    360      49       3            3
> bpf_prog_profiler.bpf.o  fentry_XXX                       failure        =
      0       0       0            0
> bpf_prog_profiler.bpf.o  fexit_XXX                        failure        =
      0       0       0            0
> func_latency.bpf.o       func_begin                       success        =
    351      69       6            6
> func_latency.bpf.o       func_end                         success        =
    318     158      15           15
> kwork_trace.bpf.o        latency_softirq_entry            success        =
    334     108      10           10
> kwork_trace.bpf.o        latency_softirq_raise            success        =
    896    1993      34           34
> kwork_trace.bpf.o        latency_workqueue_activate_work  success        =
    333      46       4            4
> kwork_trace.bpf.o        latency_workqueue_execute_start  success        =
   1112    2219      41           41
> kwork_trace.bpf.o        report_irq_handler_entry         success        =
   1067    2118      34           34
> kwork_trace.bpf.o        report_irq_handler_exit          success        =
    334     110      10           10
> kwork_trace.bpf.o        report_softirq_entry             success        =
    897    1993      34           34
> kwork_trace.bpf.o        report_softirq_exit              success        =
    329     108      10           10
> kwork_trace.bpf.o        report_workqueue_execute_end     success        =
   1124    2219      41           41
> kwork_trace.bpf.o        report_workqueue_execute_start   success        =
    295      46       4            4
> lock_contention.bpf.o    collect_lock_syms                failure        =
      0       0       0            0
> lock_contention.bpf.o    contention_begin                 failure        =
      0       0       0            0
> lock_contention.bpf.o    contention_end                   failure        =
      0       0       0            0
> off_cpu.bpf.o            on_newtask                       success        =
    387      37       3            3
> off_cpu.bpf.o            on_switch                        success        =
    536     220      20           20
> sample_filter.bpf.o      perf_sample_filter               success        =
 190443  190237   11173          923
> -----------------------  -------------------------------  -------  ------=
-------  ------  ------  -----------
> Done. Processed 9 files, 0 programs. Skipped 24 files, 0 programs.
> [acme@quaco perf-tools]$
>
> What extra info can we get from these "failure" lines?

you can ask for verifier log with -v (or very detailed verifier log
with -vl2). And you can narrow down to single program at a time with
-f <prog_name>:

sudo ./veristat -v <path-to-bpf.o> -f <prog_name>

Not every possible program can be correctly loaded by veristat (e.g.,
if fentry/fexit doesn't specify target function). But in the above
case everything from lock_contention.bpf.o is definitely worth
checking.

>
> - Arnaldo

