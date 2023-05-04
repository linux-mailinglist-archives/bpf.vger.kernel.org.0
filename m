Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84B66F7308
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 21:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjEDTKm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 15:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjEDTJo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 15:09:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C553A26E;
        Thu,  4 May 2023 12:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FECA634F4;
        Thu,  4 May 2023 19:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A30FC433EF;
        Thu,  4 May 2023 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683227252;
        bh=WHS4UOLzsznF3fRKcLws3qoH3ga9wKIXKHJo1Ux7Bfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjNnyTKp1n8jUiFOxQ+fWo3LMhDBRDqjblYZTj39OxzgMRZxk9/HzDng3cwqs/4Up
         FYbe8FP5bq30vEdTkPtklIO2ulSyOv6pucGAno0o31KDojuY3A8nAMmzBog9EXcWXa
         gPuBuFsi4R4FodQFVOj6A8eE2D+5R1YK8v8F4S10i44fqZnSXwGc/66S8H9ev3hmNQ
         UJJDAtA+e7qIyHUn6snNAMz9IgSlVEV5aQp9xigZv1f6vRgz8Sy6mJBu3KOtonoLsd
         ia5eNMHf+34k0b4l3Xy4Z9r3I4ch4VrR8/jrus49jGkIck5Ze1Vp1fiVhlTagQ8+GE
         PwP3g2fHmIkVw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5FCB2403B5; Thu,  4 May 2023 16:07:29 -0300 (-03)
Date:   Thu, 4 May 2023 16:07:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFQCccsx6GK+gY0j@kernel.org>
References: <20230503211801.897735-1-acme@kernel.org>
 <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> On Thu, May 4, 2023 at 10:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Andrii, can you add some more information about the usage of vmlinux.h
> > instead of using kernel headers?
 
> I'll just say that vmlinux.h is not a hard requirement to build BPF
> programs, it's more a convenience allowing easy access to definitions
> of both UAPI and kernel-internal structures for tracing needs and
> marking them relocatable using BPF CO-RE machinery. Lots of real-world
> applications just check-in pregenerated vmlinux.h to avoid build-time
> dependency on up-to-date host kernel and such.
 
> If vmlinux.h generation and usage is causing issues, though, given
> that perf's BPF programs don't seem to be using many different kernel
> types, it might be a better option to just use UAPI headers for public
> kernel type definitions, and just define CO-RE-relocatable minimal
> definitions locally in perf's BPF code for the other types necessary.
> E.g., if perf needs only pid and tgid from task_struct, this would
> suffice:
 
> struct task_struct {
>     int pid;
>     int tgid;
> } __attribute__((preserve_access_index));

Yeah, that seems like a way better approach, no vmlinux involved, libbpf
CO-RE notices that task_struct changed from this two integers version
(of course) and does the relocation to where it is in the running kernel
by using /sys/kernel/btf/vmlinux.

I looked and the creation of vmlinux.h was introduced in:

commit 944138f048f7d7591ec7568c94b21de8df2724d4
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Thu Jul 1 14:12:27 2021 -0700

    perf stat: Enable BPF counter with --for-each-cgroup

    Recently bperf was added to use BPF to count perf events for various
    purposes.  This is an extension for the approach and targetting to
    cgroup usages.

    Unlike the other bperf, it doesn't share the events with other
    processes but it'd reduces unnecessary events (and the overhead of
    multiplexing) for each monitored cgroup within the perf session.

    When --for-each-cgroup is used with --bpf-counters, it will open
    cgroup-switches event per cpu internally and attach the new BPF
    program to read given perf_events and to aggregate the results for
    cgroups.  It's only called when task is switched to a task in a
    different cgroup.

    Signed-off-by: Namhyung Kim <namhyung@kernel.org>
    Acked-by: Song Liu <songliubraving@fb.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Link: http://lore.kernel.org/lkml/20210701211227.1403788-1-namhyung@kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Which I think was the first BPF skel to access a kernel data structure,
yeah:

tools/perf/util/bpf_skel/bperf_cgroup.bpf.c

For things like:

+static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
+{
+       struct task_struct *p = (void *)bpf_get_current_task();
+       struct cgroup *cgrp;
+       register int i = 0;
+       __u32 *elem;
+       int level;
+       int cnt;
+
+       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
+       level = BPF_CORE_READ(cgrp, level);

So we can completely remove touching vmlinux from the perf building
process.

If we can get the revert of the patches making BPF skels to build by
default for v6.4 then we would do this work, test it thorougly and have
it available for v6.5.

Linus, would that be a way forward?

- Arnaldo

For reference, here is the definition for BPF_CORE_READ() from tools/lib/bpf/bpf_core_read.h

/*
 * BPF_CORE_READ() is used to simplify BPF CO-RE relocatable read, especially
 * when there are few pointer chasing steps.
 * E.g., what in non-BPF world (or in BPF w/ BCC) would be something like:
 *      int x = s->a.b.c->d.e->f->g;
 * can be succinctly achieved using BPF_CORE_READ as:
 *      int x = BPF_CORE_READ(s, a.b.c, d.e, f, g);
 *
 * BPF_CORE_READ will decompose above statement into 4 bpf_core_read (BPF
 * CO-RE relocatable bpf_probe_read_kernel() wrapper) calls, logically
 * equivalent to:
 * 1. const void *__t = s->a.b.c;
 * 2. __t = __t->d.e;
 * 3. __t = __t->f;
 * 4. return __t->g;
 *
 * Equivalence is logical, because there is a heavy type casting/preservation
 * involved, as well as all the reads are happening through
 * bpf_probe_read_kernel() calls using __builtin_preserve_access_index() to
 * emit CO-RE relocations.
 *
 * N.B. Only up to 9 "field accessors" are supported, which should be more
 * than enough for any practical purpose.
 */
#define BPF_CORE_READ(src, a, ...) ({                                       \
        ___type((src), a, ##__VA_ARGS__) __r;                               \
        BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);                  \
        __r;                                                                \
})
