Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7E5660605
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 18:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjAFRz7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 12:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjAFRzw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 12:55:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46DB7667;
        Fri,  6 Jan 2023 09:55:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42FFF61EFF;
        Fri,  6 Jan 2023 17:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46341C433D2;
        Fri,  6 Jan 2023 17:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673027748;
        bh=yDyqLQk8mIt7ffKbCLjmkWCABDE/Fg4/y5YAaOe4z48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LieclIEGffkCerR+zY0KpnC0MdSLjPn2M+JIZlIGqm2sT7m20b6Typ+pB+51z9qbU
         4B6tf5JnFFH/tcKwgdvTsdwbiu4/nIPNqU0Ys/DBFenX737CERY3xMppl0GpJj3yLf
         P8tEpLOH3V+QF5rxUfHvexh04bGpacLOdfseONoMq4iZYN8/SAA7ZfzLCOVJWcQCFG
         UYDo+LEvUxKpdCXrwVW8fAt7DCw89Vn1exHVbtuCiur5Ch/JQ9BHrWXtdA+/4mQxu9
         5kY91p/6jT+CYsF9qmWUJ38+LCpL9XO6AA251WJdcZlzMSQs62f5Y0K0V+J/joEK6m
         EQzUNty8RP+0A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D373340468; Fri,  6 Jan 2023 14:55:45 -0300 (-03)
Date:   Fri, 6 Jan 2023 14:55:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
Message-ID: <Y7hgoVKBoulCbA4l@kernel.org>
References: <20230106151320.619514-1-irogers@google.com>
 <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
 <Y7hZccgOiueB31a+@kernel.org>
 <Y7hgKMDGzQlankL1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7hgKMDGzQlankL1@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jan 06, 2023 at 02:53:44PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jan 06, 2023 at 02:25:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Jan 06, 2023 at 03:28:03PM +0000, Mike Leach escreveu:
> > > On Fri, 6 Jan 2023 at 15:13, Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > Including libbpf header files should be guarded by
> > > > HAVE_LIBBPF_SUPPORT. In bpf_counter.h, move the skeleton utilities
> > > > under HAVE_BPF_SKEL.
> > > >
> > > > Fixes: d6a735ef3277 ("perf bpf_counter: Move common functions to bpf_counter.h")
> > > > Reported-by: Mike Leach <mike.leach@linaro.org>
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > 
> > Thanks, applied.
> 
> Failing on 'make -C tools/perf build-test', please run it before sending
> patches,

Its one of the two patches, I just removed the last one to try without
it.
 
> - Arnaldo
> 
>       make_libbpf_dynamic_O: cd . && make LIBBPF_DYNAMIC=1 FEATURES_DUMP=/var/home/acme/git/perf-urgent/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.ZVxz3l2AAH DESTDIR=/tmp/tmp.PDlsV7dzQr
> ldd: /tmp/tmp.ZVxz3l2AAH/perf: No such file or directory
> cd . && make LIBBPF_DYNAMIC=1 FEATURES_DUMP=/var/home/acme/git/perf-urgent/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.ZVxz3l2AAH DESTDIR=/tmp/tmp.PDlsV7dzQr
>   BUILD:   Doing 'make -j32' parallel build
>   HOSTCC  /tmp/tmp.ZVxz3l2AAH/fixdep.o
>   HOSTLD  /tmp/tmp.ZVxz3l2AAH/fixdep-in.o
>   LINK    /tmp/tmp.ZVxz3l2AAH/fixdep
> Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
> diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
> diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
> diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
> diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
> Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' differs from latest version at 'arch/arm64/include/asm/cputype.h'
> diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> Warning: Kernel ABI header at 'tools/include/linux/build_bug.h' differs from latest version at 'include/linux/build_bug.h'
> diff -u tools/include/linux/build_bug.h include/linux/build_bug.h
> Warning: Kernel ABI header at 'tools/perf/trace/beauty/include/linux/socket.h' differs from latest version at 'include/linux/socket.h'
> diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h
> Makefile.config:1147: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> 
>   GEN     /tmp/tmp.ZVxz3l2AAH/common-cmds.h
>   CC      /tmp/tmp.ZVxz3l2AAH/perf-read-vdso32
>   CC      /tmp/tmp.ZVxz3l2AAH/dlfilters/dlfilter-test-api-v0.o
>   CC      /tmp/tmp.ZVxz3l2AAH/dlfilters/dlfilter-show-cycles.o
>   LINK    /tmp/tmp.ZVxz3l2AAH/dlfilters/dlfilter-show-cycles.so
>   LINK    /tmp/tmp.ZVxz3l2AAH/dlfilters/dlfilter-test-api-v0.so
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libsubcmd/include/subcmd/exec-cmd.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libsubcmd/include/subcmd/help.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libsubcmd/include/subcmd/pager.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libsubcmd/include/subcmd/parse-options.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libsubcmd/include/subcmd/run-command.h
>   CC      /tmp/tmp.ZVxz3l2AAH/libsubcmd/exec-cmd.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libsubcmd/help.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libsubcmd/pager.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libsubcmd/parse-options.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libsubcmd/run-command.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libsubcmd/sigchain.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libsubcmd/subcmd-config.o
>   INSTALL libsubcmd_headers
>   PERF_VERSION = 6.2.rc2.g449a50dbf82a
>   GEN     perf-archive
>   GEN     perf-iostat
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/perf/bpf_perf.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/perf/core.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/perf/cpumap.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libsymbol/include/symbol/kallsyms.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libapi/include/api/cpu.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/perf/threadmap.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libapi/include/api/debug.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/perf/evlist.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libapi/include/api/io.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/perf/evsel.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libapi/include/api/fd/array.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/perf/event.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libapi/include/api/fs/fs.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/perf/mmap.h
>   CC      /tmp/tmp.ZVxz3l2AAH/libperf/core.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libsymbol/kallsyms.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libperf/cpumap.o
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/internal/cpumap.h
>   CC      /tmp/tmp.ZVxz3l2AAH/libperf/threadmap.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/libapi/fd/
>   CC      /tmp/tmp.ZVxz3l2AAH/libperf/evsel.o
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/internal/evlist.h
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/internal/evsel.h
>   CC      /tmp/tmp.ZVxz3l2AAH/libapi/cpu.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libperf/evlist.o
>   INSTALL libsymbol_headers
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libapi/include/api/fs/tracing_path.h
>   CC      /tmp/tmp.ZVxz3l2AAH/libapi/debug.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libperf/mmap.o
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/internal/lib.h
>   CC      /tmp/tmp.ZVxz3l2AAH/libapi/str_error_r.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libperf/zalloc.o
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/internal/mmap.h
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/libapi/fs/
>   CC      /tmp/tmp.ZVxz3l2AAH/libperf/xyarray.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libperf/lib.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libapi/fd/array.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/libapi/fs/
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/libapi/fs/
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/internal/threadmap.h
>   INSTALL libapi_headers
>   INSTALL /tmp/tmp.ZVxz3l2AAH/libperf/include/internal/xyarray.h
>   CC      /tmp/tmp.ZVxz3l2AAH/libapi/fs/fs.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libapi/fs/tracing_path.o
>   CC      /tmp/tmp.ZVxz3l2AAH/libapi/fs/cgroup.o
>   INSTALL libperf_headers
>   LD      /tmp/tmp.ZVxz3l2AAH/libapi/fd/libapi-in.o
>   LD      /tmp/tmp.ZVxz3l2AAH/libsymbol/libsymbol-in.o
>   AR      /tmp/tmp.ZVxz3l2AAH/libsymbol/libsymbol.a
>   LD      /tmp/tmp.ZVxz3l2AAH/libapi/fs/libapi-in.o
>   LD      /tmp/tmp.ZVxz3l2AAH/libapi/libapi-in.o
>   AR      /tmp/tmp.ZVxz3l2AAH/libapi/libapi.a
>   LD      /tmp/tmp.ZVxz3l2AAH/libperf/libperf-in.o
>   AR      /tmp/tmp.ZVxz3l2AAH/libperf/libperf.a
>   GEN     /tmp/tmp.ZVxz3l2AAH/python/perf.cpython-310-x86_64-linux-gnu.so
>   LD      /tmp/tmp.ZVxz3l2AAH/libsubcmd/libsubcmd-in.o
>   AR      /tmp/tmp.ZVxz3l2AAH/libsubcmd/libsubcmd.a
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-bench.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-annotate.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-config.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-diff.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-evlist.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-ftrace.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-help.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-buildid-list.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-buildid-cache.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-kallsyms.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-list.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-record.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-report.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-stat.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-top.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-script.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-kvm.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-inject.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-mem.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/pmu-events/
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-data.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-version.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-c2c.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-daemon.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-kmem.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-kwork.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-lock.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-sched.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-timechart.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-trace.o
>   GEN     /tmp/tmp.ZVxz3l2AAH/pmu-events/pmu-events.c
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/clone.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/fcntl.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/flock.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/fsmount.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/fspick.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/ioctl.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/bench/
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/sched-messaging.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/bench/
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/syscall.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/sched-pipe.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/mem-functions.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/futex-hash.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/futex-wake.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/futex-wake-parallel.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/kcmp.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/futex-requeue.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/futex-lock-pi.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/tests/
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/builtin-test.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/tests/
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/builtin-test-list.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/mount_flags.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/util/
>   CC      /tmp/tmp.ZVxz3l2AAH/util/arm64-frame-pointer-unwind-support.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/move_mount.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/pkey_alloc.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/common.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/parse-events.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/arch/x86/util/
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/header.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/arch/x86/tests/
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/dso-data.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/attr.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/arch/x86/tests/
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/tests/regs_load.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/tests/dwarf-unwind.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/arch/x86/util/
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/tsc.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/epoll-wait.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/arch_prctl.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/epoll-ctl.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/prctl.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/util/
>   CC      /tmp/tmp.ZVxz3l2AAH/util/block-info.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/annotate.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/arch/x86/tests/
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/tests/arch-tests.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/tests/sample-parsing.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/renameat.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/sockaddr.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/socket.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/vmlinux-kallsyms.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/openat-syscall.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/openat-syscall-all-cpus.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/kallsyms-parse.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/synthesize.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/ui/
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/scripts/perl/Perf-Trace-Util/
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/setup.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/pmu.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/kvm-stat.o
>   CC      /tmp/tmp.ZVxz3l2AAH/scripts/perl/Perf-Trace-Util/Context.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/perf_regs.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/tests/insn-x86.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/tests/intel-pt-test.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/tests/bp-modify.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/statx.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/openat-syscall-tp-fields.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/block-range.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/sync_file_range.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/mmap-basic.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/perf-record.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/topdown.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/machine.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/evsel-roundtrip-name.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/evsel-tp-sched.o
>   CC      /tmp/tmp.ZVxz3l2AAH/builtin-probe.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/fdarray.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/pmu.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/event.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/evlist.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/mem-events.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/ui/
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/timespec.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/helpline.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/progress.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/find-bit-bench.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/inject-buildid.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/scripts/python/Perf-Trace-Util/
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/util.o
>   CC      /tmp/tmp.ZVxz3l2AAH/scripts/python/Perf-Trace-Util/Context.o
>   LD      /tmp/tmp.ZVxz3l2AAH/arch/x86/tests/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/hist.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/build-id.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/pmu-events.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/cacheline.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/trace/beauty/tracepoints/
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/trace/beauty/tracepoints/
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/hists_common.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/evsel.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/evlist-open-close.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/tracepoints/x86_irq_vectors.o
>   CC      /tmp/tmp.ZVxz3l2AAH/trace/beauty/tracepoints/x86_msr.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/breakpoint.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/mem-memcpy-x86-64-asm.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/mem-memset-x86-64-asm.o
>   CC      /tmp/tmp.ZVxz3l2AAH/bench/numa.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/ui/stdio/
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/iostat.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/browser.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/stdio/hist.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/ui/browsers/
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/ui/browsers/
>   CC      /tmp/tmp.ZVxz3l2AAH/util/config.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/browsers/annotate.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/ui/browsers/
>   CC      /tmp/tmp.ZVxz3l2AAH/util/copyfile.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/browsers/hists.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/browsers/map.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/ctype.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/db-export.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/browsers/scripts.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/browsers/header.o
>   LD      /tmp/tmp.ZVxz3l2AAH/trace/beauty/tracepoints/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/browsers/res_sample.o
>   LD      /tmp/tmp.ZVxz3l2AAH/trace/beauty/perf-in.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/ui/tui/
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/tui/setup.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/hists_link.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/hists_filter.o
>   CC      /tmp/tmp.ZVxz3l2AAH/perf.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/dwarf-regs.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/ui/tui/
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/tui/util.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/tui/helpline.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/unwind-libunwind.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/auxtrace.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/env.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/hists_output.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/hists_cumulate.o
>   LD      /tmp/tmp.ZVxz3l2AAH/scripts/perl/Perf-Trace-Util/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/ui/tui/progress.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/python-use.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/bp_signal.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/bp_signal_overflow.o
>   LD      /tmp/tmp.ZVxz3l2AAH/scripts/python/Perf-Trace-Util/perf-in.o
>   LD      /tmp/tmp.ZVxz3l2AAH/scripts/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/bp_account.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/event.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/evlist.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/wp.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/task-exit.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/sw-clock.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/archinsn.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/intel-pt.o
>   CC      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/intel-bts.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/mmap-thread-lookup.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/thread-maps-share.o
>   LD      /tmp/tmp.ZVxz3l2AAH/ui/tui/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/evlist-hybrid.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/sideband_evlist.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/switch-tracking.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/evsel.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/keep-tracking.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/code-reading.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/evsel_fprintf.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/sample-parsing.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/parse-no-sample-id-all.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/kmod-path.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/perf_event_attr_fprintf.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/evswitch.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/find_bit.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/get_current_dir_name.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/thread-map.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/levenshtein.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/llvm-utils.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/llvm.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/mmap.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/memswap.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/bpf.o
>   BISON   /tmp/tmp.ZVxz3l2AAH/util/parse-events-bison.c
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/topology.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/mem.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/parse-events-hybrid.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/print-events.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/tracepoint.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/cpumap.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/stat.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/perf_regs.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/event_update.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/event-times.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/path.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/expr.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/print_binary.o
>   LD      /tmp/tmp.ZVxz3l2AAH/bench/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/rlimit.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/backward-ring-buffer.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/argv_split.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/rbtree.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/libstring.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/bitmap.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/hweight.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/smt.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/strbuf.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/sdt.o
>   LD      /tmp/tmp.ZVxz3l2AAH/arch/x86/util/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/is_printable_array.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/string.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/strlist.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/bitmap.o
>   LD      /tmp/tmp.ZVxz3l2AAH/arch/x86/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/strfilter.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/perf-hooks.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/clang.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/unit_number__scnprintf.o
>   LD      /tmp/tmp.ZVxz3l2AAH/arch/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/mem2node.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/maps.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/time-utils-test.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/genelf.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/api-io.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/demangle-java-test.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/top.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/demangle-ocaml-test.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/usage.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/pfm.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/dso.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/dsos.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/parse-metric.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/symbol.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/symbol_fprintf.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/pe-file-parsing.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/color.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/color_config.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/expand-cgroup.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/perf-time-to-tsc.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/dlfilter-test.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/metricgroup.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/header.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/callchain.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/values.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/sigtrap.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/debug.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/fncache.o
>   CC      /tmp/tmp.ZVxz3l2AAH/pmu-events/pmu-events.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/machine.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/event_groups.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/dwarf-unwind.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/tests/workloads/
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/workloads/noploop.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/tests/workloads/
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/workloads/thloop.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/map.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/workloads/leafloop.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/maps.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/llvm-src-base.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/pstack.o
>   LD      /tmp/tmp.ZVxz3l2AAH/ui/browsers/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/session.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/sample-raw.o
>   LD      /tmp/tmp.ZVxz3l2AAH/ui/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/llvm-src-kbuild.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/s390-sample-raw.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/llvm-src-prologue.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/workloads/sqrtloop.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/llvm-src-relocation.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/workloads/brstack.o
>   CC      /tmp/tmp.ZVxz3l2AAH/tests/workloads/datasym.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/amd-sample-raw.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/syscalltbl.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/ordered-events.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/namespaces.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/comm.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/thread.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/thread_map.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/parse-events-bison.o
>   BISON   /tmp/tmp.ZVxz3l2AAH/util/pmu-bison.c
>   CC      /tmp/tmp.ZVxz3l2AAH/util/pmus.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/pmu-hybrid.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/svghelper.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/trace-event-info.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/trace-event-scripting.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/trace-event.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/trace-event-parse.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/trace-event-read.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/sort.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/hist.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/util.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/cpumap.o
>   LD      /tmp/tmp.ZVxz3l2AAH/tests/workloads/perf-in.o
>   LD      /tmp/tmp.ZVxz3l2AAH/tests/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/affinity.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/cputopo.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/cgroup.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/target.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/rblist.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/intlist.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/vdso.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/counts.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/stat.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/stat-shadow.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/stat-display.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/perf_api_probe.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/record.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/srcline.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/srccode.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/synthetic-events.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/data.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/tsc.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/cloexec.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/call-path.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/rwsem.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/thread-stack.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/spark.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/topdown.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/iostat.o
>   LD      /tmp/tmp.ZVxz3l2AAH/pmu-events/pmu-events-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/auxtrace.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/stream.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/util/intel-pt-decoder/
>   CC      /tmp/tmp.ZVxz3l2AAH/util/intel-pt.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/util/arm-spe-decoder/
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/util/arm-spe-decoder/
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/util/scripting-engines/
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/util/hisi-ptt-decoder/
>   CC      /tmp/tmp.ZVxz3l2AAH/util/intel-pt-decoder/intel-pt-pkt-decoder.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/arm-spe-decoder/arm-spe-decoder.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/scripting-engines/trace-event-perl.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/arm-spe-decoder/arm-spe-pkt-decoder.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/util/scripting-engines/
>   MKDIR   /tmp/tmp.ZVxz3l2AAH/util/intel-pt-decoder/
>   CC      /tmp/tmp.ZVxz3l2AAH/util/intel-bts.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/intel-pt-decoder/intel-pt-log.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/scripting-engines/trace-event-python.o
>   GEN     /tmp/tmp.ZVxz3l2AAH/util/intel-pt-decoder/inat-tables.c
>   CC      /tmp/tmp.ZVxz3l2AAH/util/intel-pt-decoder/intel-pt-decoder.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/arm-spe.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/hisi-ptt.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/s390-cpumsf.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/cs-etm-base.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/parse-branch-options.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/dump-insn.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/parse-regs-options.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/intel-pt-decoder/intel-pt-insn-decoder.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/parse-sublevel-options.o
>   LD      /tmp/tmp.ZVxz3l2AAH/util/hisi-ptt-decoder/perf-in.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/term.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/help-unknown-cmd.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/dlfilter.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/mem-events.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/vsprintf.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/units.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/time-utils.o
>   LD      /tmp/tmp.ZVxz3l2AAH/util/arm-spe-decoder/perf-in.o
>   BISON   /tmp/tmp.ZVxz3l2AAH/util/expr-bison.c
>   CC      /tmp/tmp.ZVxz3l2AAH/util/branch.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/mem2node.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/clockid.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/list_sort.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/mutex.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/bpf-loader.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/bpf_map.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/bpf-prologue.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/symbol-elf.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/probe-file.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/probe-event.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/hashmap.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/probe-finder.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/dwarf-aux.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/dwarf-regs.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/unwind-libunwind-local.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/unwind-libunwind.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/data-convert-bt.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/data-convert-json.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/zlib.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/lzma.o
>   CC      /tmp/tmp.ZVxz3l2AAH/util/zstd.o
> util/bpf-loader.c:36:5: error: no previous prototype for ‘bpf_program__set_insns’ [-Werror=missing-prototypes]
>    36 | int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
>       |     ^~~~~~~~~~~~~~~~~~~~~~
> util/bpf-loader.c:46:47: error: ‘struct libbpf_prog_handler_opts’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>    46 |                                  const struct libbpf_prog_handler_opts *opts __maybe_unused)
>       |                                               ^~~~~~~~~~~~~~~~~~~~~~~~
> util/bpf-loader.c:43:5: error: no previous prototype for ‘libbpf_register_prog_handler’ [-Werror=missing-prototypes]
>    43 | int libbpf_register_prog_handler(const char *sec __maybe_unused,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /usr/include/bpf/libbpf.h:20,
>                  from util/bpf-loader.c:10:
> util/bpf-loader.c: In function ‘libbpf_init’:
> util/bpf-loader.c:179:21: error: variable ‘handler_opts’ has initializer but incomplete type
>   179 |         LIBBPF_OPTS(libbpf_prog_handler_opts, handler_opts,
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~
> util/bpf-loader.c:179:9: error: invalid application of ‘sizeof’ to incomplete type ‘struct libbpf_prog_handler_opts’
>   179 |         LIBBPF_OPTS(libbpf_prog_handler_opts, handler_opts,
>       |         ^~~~~~~~~~~
> util/bpf-loader.c:179:9: error: ‘struct libbpf_prog_handler_opts’ has no member named ‘sz’
>   179 |         LIBBPF_OPTS(libbpf_prog_handler_opts, handler_opts,
>       |         ^~~~~~~~~~~
> util/bpf-loader.c:179:9: error: invalid application of ‘sizeof’ to incomplete type ‘struct libbpf_prog_handler_opts’
>   179 |         LIBBPF_OPTS(libbpf_prog_handler_opts, handler_opts,
>       |         ^~~~~~~~~~~
> util/bpf-loader.c:179:9: error: excess elements in struct initializer [-Werror]
>   179 |         LIBBPF_OPTS(libbpf_prog_handler_opts, handler_opts,
>       |         ^~~~~~~~~~~
> util/bpf-loader.c:179:9: note: (near initialization for ‘(anonymous)’)
> util/bpf-loader.c:180:18: error: ‘struct libbpf_prog_handler_opts’ has no member named ‘prog_prepare_load_fn’
>   180 |                 .prog_prepare_load_fn = libbpf_prog_prepare_load_fn,
>       |                  ^~~~~~~~~~~~~~~~~~~~
> util/bpf-loader.c:180:41: error: excess elements in struct initializer [-Werror]
>   180 |                 .prog_prepare_load_fn = libbpf_prog_prepare_load_fn,
>       |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/bpf-loader.c:180:41: note: (near initialization for ‘(anonymous)’)
> util/bpf-loader.c:179:9: error: invalid use of undefined type ‘struct libbpf_prog_handler_opts’
>   179 |         LIBBPF_OPTS(libbpf_prog_handler_opts, handler_opts,
>       |         ^~~~~~~~~~~
> util/bpf-loader.c:179:47: error: storage size of ‘handler_opts’ isn’t known
>   179 |         LIBBPF_OPTS(libbpf_prog_handler_opts, handler_opts,
>       |                                               ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [/var/home/acme/git/perf-urgent/tools/build/Makefile.build:97: /tmp/tmp.ZVxz3l2AAH/util/bpf-loader.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
>   LD      /tmp/tmp.ZVxz3l2AAH/util/scripting-engines/perf-in.o
>   LD      /tmp/tmp.ZVxz3l2AAH/util/intel-pt-decoder/perf-in.o
> make[5]: *** [/var/home/acme/git/perf-urgent/tools/build/Makefile.build:139: util] Error 2
> make[4]: *** [Makefile.perf:673: /tmp/tmp.ZVxz3l2AAH/perf-in.o] Error 2
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [Makefile.perf:236: sub-make] Error 2
> make[2]: *** [Makefile:70: all] Error 2
> make[1]: *** [tests/make:337: make_libbpf_dynamic_O] Error 1
> make: *** [Makefile:103: build-test] Error 2
> make: Leaving directory '/var/home/acme/git/perf-urgent/tools/perf'
> 
> real	4m10.450s
> user	40m3.640s
> sys	9m30.945s
> ⬢[acme@toolbox perf-urgent]$
> 

-- 

- Arnaldo
