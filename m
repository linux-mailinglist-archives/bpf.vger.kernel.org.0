Return-Path: <bpf+bounces-56751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6E6A9D482
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827A816AA56
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8B22687A;
	Fri, 25 Apr 2025 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXVu+k+l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BF1FC0FE;
	Fri, 25 Apr 2025 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617895; cv=none; b=WTudG5MfXPWxlU7BMearAWCuzvCnDCorq1UH4u3+zpzEqF1Y/p/BfyWofCtlZxmQRwAaqERe9rKrev6sfXwrDh1CtILiN3nF15ybAYTSrXEh3+kUtcpWpzPNsja5gtmOACczYpzsFLLWkipqC2yzW2wEaIuZhUaypvDy/w2DaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617895; c=relaxed/simple;
	bh=xh1HvSuuUw/U72US+gvLZ4Kex52fTf141EDnd1VUDD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bclAru4UwCn7m7fboBCpUxIIkwxD22+86eMlhTU7rGw59ucZ5vYWyupIl/fJq827hM7CwW5UAg0sW/GXAKMI83qsI591Aw14hd3sPLZWOWpEoe4N5Zt/4MGqkKfUW+2yxq0wvlDpR//T6WxDBsJfP6kdXK5NqrAhEkYgX2SHmZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXVu+k+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9D4C4CEE4;
	Fri, 25 Apr 2025 21:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745617893;
	bh=xh1HvSuuUw/U72US+gvLZ4Kex52fTf141EDnd1VUDD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXVu+k+la7gq52onV+AVCt/AUgAofpFfu4riRWLuEAqy7dlYRVsMixSF3nuFrFLO1
	 cgkHhux3Jt3RRShIOySpWH9teWmMV/x2BO5PwfL4MVTWe6hZlhzX5XwtDTpHHuFtYd
	 0MyTnsJo5qNagQmi6guwSidwRKH27NPBgEEheaYPqCuc7g46F5I/M+fgahVOjw+LEF
	 l2/clbpIjNwvW6o3nevfgYuRLarcYLETJtyvGr34F9rI8I3PXry3wEdLT4rLYBCLzv
	 uM4AlfusDhMZTSE/svCo66iN1s1ej/tlEY6xy5F6zq6E/smYM506DtiuTBt4DDi2RT
	 gRcF1NHQu8GbA==
Date: Fri, 25 Apr 2025 14:51:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 1/2] perf trace: Implement syscall summary in BPF
Message-ID: <aAwD4idaGnTiQ-ld@google.com>
References: <20250326044001.3503432-1-namhyung@kernel.org>
 <CAH0uvojPaZ-byE-quc=sUvXyExaZPU3PUjdTYOzE5iDAT_wNVA@mail.gmail.com>
 <aAkUyFjRFLkS170u@x1>
 <aAkmY0hLXarmCSIA@google.com>
 <aAlSqGN9Sx4x6_sI@x1>
 <aAq16LWBIVr08iSe@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAq16LWBIVr08iSe@x1>

Hi Arnaldo,

On Thu, Apr 24, 2025 at 07:06:32PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 23, 2025 at 05:50:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Apr 23, 2025 at 10:41:55AM -0700, Namhyung Kim wrote:
> > > On Wed, Apr 23, 2025 at 01:26:48PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Fri, Mar 28, 2025 at 06:46:36PM -0700, Howard Chu wrote:
> > > > > On Tue, Mar 25, 2025 at 9:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >      syscall            calls  errors  total       min       avg       max       stddev
> 
> > > > > >      --------------- --------  ------ -------- --------- --------- ---------     ------
> > > > > >      epoll_wait           561      0  4530.843     0.000     8.076   520.941     18.75%
> > > > > >      futex                693     45  4317.231     0.000     6.230   500.077     21.98%
> > > > > >      poll                 300      0  1040.109     0.000     3.467   120.928     17.02%
> > > > > >      clock_nanosleep        1      0  1000.172  1000.172  1000.172  1000.172      0.00%
> > > > > >      ppoll                360      0   872.386     0.001     2.423   253.275     41.91%
> > > > > >      epoll_pwait           14      0   384.349     0.001    27.453   380.002     98.79%
> > > > > >      pselect6              14      0   108.130     7.198     7.724     8.206      0.85%
> > > > > >      nanosleep             39      0    43.378     0.069     1.112    10.084     44.23%
> > > > > >      ...
> 
> > > > I added the following to align sched_[gs]etaffinity,
> 
> > > Thanks for processing the patch and updating this.  But I'm afraid there
> > > are more syscalls with longer names and this is not the only place to
> > > print the syscall names.  Also I think we need to update length of the
> > > time fields.  So I prefer handling them in a separate patch later.
>  
> > Fair enough, I'm leaving the patch as-is.
> 
> But, still have to look at this:
> 
> toolsbuilder@five:~$ time dm
>    1   114.52 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-26) , clang version 18.1.8 (Red Hat 18.1.8-1.module_el8.10.0+3903+ca21d481) flex 2.6.1
>    2   111.09 almalinux:9                   : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5) , clang version 18.1.8 (AlmaLinux OS Foundation 18.1.8-3.el9) flex 2.6.4
>    3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
> WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
>    132.71 almalinux:9-i386              : Ok   gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9) flex 2.6.4
>    4    21.54 alpine:3.16                   : FAIL gcc version 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
>     bpf-trace-summary.c:(.text+0xf0760): undefined reference to `syscalltbl__name'
>     collect2: error: ld returned 1 exit status
>    5    16.50 alpine:3.17                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
>     bpf-trace-summary.c:(.text+0xf2020): undefined reference to `syscalltbl__name'
>     collect2: error: ld returned 1 exit status
> 
> More info:
> 
> perf-6.15.0-rc2/HEAD
> perf-6.15.0-rc2/PERF-VERSION-FILE
> BUILD_TARBALL_HEAD=24c0c35d4640052c61ed539a777bd3bd60d62bbf
> Using built-in specs.
> COLLECT_GCC=gcc
> COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-alpine-linux-musl/12.2.1/lto-wrapper
> Target: x86_64-alpine-linux-musl
> Configured with: /home/buildozer/aports/main/gcc/src/gcc-12-20220924/configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --build=x86_64-alpine-linux-musl --host=x86_64-alpine-linux-musl --target=x86_64-alpine-linux-musl --enable-checking=release --disable-fixed-point --disable-libstdcxx-pch --disable-multilib --disable-nls --disable-werror --disable-symvers --enable-__cxa_atexit --enable-default-pie --enable-default-ssp --enable-languages=c,c++,d,objc,go,fortran,ada --disable-libssp --disable-libsanitizer --enable-shared --enable-threads --enable-tls --with-bugurl=https://gitlab.alpinelinux.org/alpine/aports/-/issues --with-system-zlib --with-linker-hash-style=gnu --with-pkgversion='Alpine 12.2.1_git20220924-r4'
> Thread model: posix
> Supported LTO compression algorithms: zlib
> gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
> + make 'NO_LIBTRACEEVENT=1' 'ARCH=' 'CROSS_COMPILE=' 'EXTRA_CFLAGS=' -C tools/perf 'O=/tmp/build/perf'
> make: Entering directory '/git/perf-6.15.0-rc2/tools/perf'
>   BUILD:   Doing 'make -j28' parallel build
> Warning: Skipped check-headers due to missing ../../include
> Makefile.config:563: No elfutils/debuginfod.h found, no debuginfo server support, please install libdebuginfod-dev/elfutils-debuginfod-client-devel or equivalent
> Makefile.config:605: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
> Makefile.config:1085: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> Makefile.config:1128: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
> Makefile.config:1159: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev
> 
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ OFF ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> 
>   PERF_VERSION = 6.15.rc2.g24c0c35d4640
>   GEN     /tmp/build/perf/common-cmds.h
>   GEN     /tmp/build/perf/arch/arm64/include/generated/asm/sysreg-defs.h
>   GEN     perf-archive
>   GEN     perf-iostat
> <SNIP>
>   CC      /tmp/build/perf/util/bpf-filter-flex.o
>   LD      /tmp/build/perf/util/perf-util-in.o
>   LD      /tmp/build/perf/perf-util-in.o
>   AR      /tmp/build/perf/libperf-util.a
>   CC      /tmp/build/perf/pmu-events/pmu-events.o
>   LD      /tmp/build/perf/pmu-events/pmu-events-in.o
>   AR      /tmp/build/perf/libpmu-events.a
>   LINK    /tmp/build/perf/perf
>   GEN     /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so
> /usr/lib/gcc/x86_64-alpine-linux-musl/12.2.1/../../../../x86_64-alpine-linux-musl/bin/ld: /tmp/build/perf/libperf-util.a(perf-util-in.o): in function `print_common_stats':
> bpf-trace-summary.c:(.text+0xf2020): undefined reference to `syscalltbl__name'
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile.perf:804: /tmp/build/perf/perf] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:290: sub-make] Error 2
> make: *** [Makefile:76: all] Error 2
> make: Leaving directory '/git/perf-6.15.0-rc2/tools/perf'
> + exit 1
> toolsbuilder@five:~$ 
> 
> I'll take a look tomorrow.

Thanks for the report.  I think it's because syscalltbl.c depends on
CONFIG_TRACE but bpf-trace-summary depends on CONFIG_PERF_BPF_SKEL.

In the future, I'd like to get rid of dependency to libtraceevent in
perf trace and make it possible to use BPF/BTF only.

How about this?

Thanks,
Namhyung


---8<---
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4f00cde8c3ea63eb..7ae5b4b9330af0ce 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -173,9 +173,12 @@ perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-flex.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-bison.o
-perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-trace-summary.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += btf.o
 
+ifeq ($(CONFIG_TRACE),y)
+  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-trace-summary.o
+endif
+
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_lock_contention.o
 endif


