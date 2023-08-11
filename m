Return-Path: <bpf+bounces-7551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E25A77921B
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FF21C216F7
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D14253B9;
	Fri, 11 Aug 2023 14:43:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8A6FDA;
	Fri, 11 Aug 2023 14:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E595C433C7;
	Fri, 11 Aug 2023 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691765005;
	bh=0YV9JLzrdaQZNSYSCnIv9uVERxeHc6PRHTraRWOMM/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWpbH3qDAcZVVU4UKB+lmyK9eH1iCdTLbNSD0xaCWoJmJE9rY0CndOmuxTnTqTBwc
	 KJBNFeMKYJ1AGowZ696LUFkOu8ypmEmbobnnqMQAYQcyD96Mh3kYdyoeayZIvNyBSB
	 xYXGqnYNT5OtIKsfbpbDS0cxdE4UmWZG81peUettJz6IaflJpVOVKwz2wKUdevKHhd
	 VVsFuptxUi9gWtslXn7JtPr8RJQO4IOmVnnCb/uyWKCxQWSddWfKM6T7uusqKzVaMS
	 YhEhFsO9ZFVL3lYy+7zu6ijNqNRNnQBtSuj1y551MZdQXrvROedH55W6Y/4DoC3i4U
	 pxboXV+h05AMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 02A3D404DF; Fri, 11 Aug 2023 11:43:21 -0300 (-03)
Date: Fri, 11 Aug 2023 11:43:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	James Clark <james.clark@arm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>,
	Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: [PATCH v1 1/4] perf parse-events: Remove BPF event support
Message-ID: <ZNZJCWi9MT/HZdQ/@kernel.org>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810184853.2860737-2-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Thu, Aug 10, 2023 at 11:48:50AM -0700, Ian Rogers escreveu:
> New features like the BPF --filter support in perf record have made
> the BPF event functionality somewhat redundant. As shown by commit
> fcb027c1a4f6 ("perf tools: Revert enable indices setting syntax for
> BPF map") and commit 14e4b9f4289a ("perf trace: Raw augmented syscalls
> fix libbpf 1.0+ compatibility") the BPF event support hasn't been well
> maintained and it adds considerable complexity in areas like event
> parsing, not least as '/' is a separator for event modifiers as well
> as in paths.
 
> The BPF events also motivate llvm and clang libraries as dependencies
> (to compile BPF events that are BPF C code) that have build and
> distribution complexity. For this reason they are only enabled with
> the build option LIBLLVMCLANG=1 which isn't done on major
> distributions like Debian, Fedora and Gentoo. Removing BPF events
> means we can also remove libclang and libllvm dependencies.

As we discussed, libclang and libllvm are not needed for turning .c BPF
events into .o nor for loading the .o files.

For instance, using the perf binary shipped on Fedora, i.e. the default
build for perf when libbpf is available:

root@quaco ~]# type perf
perf is /usr/bin/perf
[root@quaco ~]# rpm -qf /usr/bin/perf
perf-6.4.4-200.fc38.x86_64
[root@quaco ~]# ldd which perf | grep llvm
[root@quaco ~]# ldd which perf | grep clang
[root@quaco ~]# set -o vi
[root@quaco ~]# perf trace --call-graph=dwarf --max-stack=3 --max-events=2 -e /home/acme/git/perf-tools-next/tools/perf/examples/bpf/augmented_raw_syscalls.c,open*
addr2line: addr2line configuration failed
addr2line: addr2line configuration failed
     0.000 cgroupify/24006 openat(dfd: 4, filename: ".", flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 5
                                       syscall_exit_to_user_mode_prepare ([kernel.kallsyms])
                                       syscall_exit_to_user_mode_prepare ([kernel.kallsyms])
                                       syscall_exit_to_user_mode ([kernel.kallsyms])
                                       __openat_nocancel (/usr/lib64/libc.so.6)
                                       __opendirat (/usr/lib64/libc.so.6)
                                       scandirat (/usr/lib64/libc.so.6)
     0.235 cgroupify/24006 openat(dfd: 4, filename: "176965/cgroup.procs") = 5
                                       syscall_exit_to_user_mode_prepare ([kernel.kallsyms])
                                       syscall_exit_to_user_mode_prepare ([kernel.kallsyms])
                                       syscall_exit_to_user_mode ([kernel.kallsyms])
                                       __GI___openat (/usr/lib64/libc.so.6)
                                       [0x2c5d] (/usr/libexec/cgroupify)
                                       [0x2d4d] (/usr/libexec/cgroupify)
[root@quaco ~]#
[root@quaco ~]# cat ~/.perfconfig
# this file is auto-generated.
[llvm]
    dump-obj = true
    clang-opt = -g
[trace]
    show_zeros = no
    show_duration = no
    no_inherit = yes
    args_alignment = 40
[annotate]
    hide_src_code = true
[root@quaco ~]# ls -la /home/acme/git/perf-tools-next/tools/perf/examples/bpf/augmented_raw_syscalls.o
-rw-r--r--. 1 root root 34664 Aug 10 15:17 /home/acme/git/perf-tools-next/tools/perf/examples/bpf/augmented_raw_syscalls.o
[root@quaco ~]# file /home/acme/git/perf-tools-next/tools/perf/examples/bpf/augmented_raw_syscalls.o
/home/acme/git/perf-tools-next/tools/perf/examples/bpf/augmented_raw_syscalls.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped
[root@quaco ~]# perf trace -e /home/acme/git/perf-tools-next/tools/perf/examples/bpf/augmented_raw_syscalls.o,open* --max-events=5
     0.000 DNS Res~ver #1/109960 openat(dfd: CWD, filename: "/etc/hosts", flags: RDONLY|CLOEXEC) = 1020
     0.262 systemd-resolv/960 openat(dfd: CWD, filename: "/proc/sys/net/ipv6/conf/all/disable_ipv6", flags: RDONLY|CLOEXEC|NOCTTY) = 24
     0.323 systemd-resolv/960 openat(dfd: CWD, filename: "/proc/sys/net/ipv6/conf/all/disable_ipv6", flags: RDONLY|CLOEXEC|NOCTTY) = 24
    23.583 cgroupify/24006 openat(dfd: 4, filename: ".", flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 5
    23.719 cgroupify/24006 openat(dfd: 4, filename: "176965/cgroup.procs") ...

that llvm.dump-obj=true will keep the generated .o and then you can use
it perf calls clang to turn the .c into .o and then loads it if you pass
it a .o it skips compilation and uses it directly

I agree we have to remove the linking with libclang and libllvm and I
thank you for doing this work. Particularly I liked the conversion of
the augmented_raw_syscalls.c to be a BPF skeleton that gets build when
we use BUILD_BPF_SKEL=1, which will be the default when what is needed
is available, skipped when not.

That patch keeps the whole infrastructure in 'perf trace' to use the
pointer contents collected by the augmented_raw_syscalls.c that became
augmented_raw_syscalls.bpf.c, really cool.

Right now it is not applying due to some clash with other changes and
when I tried to apply it manually there were some formatting issues:

⬢[acme@toolbox perf-tools-next]$ head ~/wb/1.patch
From SRS0=EALy=D3=flex--irogers.bounces.google.com=3IDHVZAcKBAUnwtljwxlttlqj.htrfhrjpjwsjq.twl@kernel.org Thu Aug 10 17:53:46 2023
Delivered-To: arnaldo.melo@gmail.com
Received: from imap.gmail.com [64.233.186.109]
	by quaco with IMAP (fetchmail-6.4.37)
	for <acme@localhost> (single-drop); Thu, 10 Aug 2023 17:53:46 -0300 (-03)
Received: by 2002:a0c:ab03:0:b0:63d:780e:9480 with SMTP id h3csp908198qvb;
 Thu, 10 Aug 2023 11:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9N/knUCyQ0tQ2Q0XBH0gqf8A8DB8/37YHWAJDKBmz7AGSV9CvCKYDuE3EwxriZFBwtZMs
X-Received: by 2002:a4a:6b4f:0:b0:56c:b2ab:9820 with SMTP id
 h15-20020a4a6b4f000000b0056cb2ab9820mr2695332oof.8.1691693392493; Thu, 10 Aug
⬢[acme@toolbox perf-tools-next]$ patch -p1 < ~/wb/1.patch
patching file tools/perf/Documentation/perf-config.txt
patch: **** malformed patch at line 234: ith

⬢[acme@toolbox perf-tools-next]$

I'm trying to apply it manually.

- Arnaldo

 
> This patch removes support in the event parser for BPF events and then
> the associated functions are removed. This leads to the removal of
> whole source files like bpf-loader.c.  Removing support means that
> augmented syscalls in perf trace is broken, this will be fixed in a
> later commit adding support using BPF skeletons.
> 
> The removal of BPF events causes an unused label warning from flex
> generated code, so update build to ignore it:
> ```
> util/parse-events-flex.c:2704:1: error: label ‘find_rule’ defined but not used [-Werror=unused-label]
> 2704 | find_rule: /* we branch to this label when backing up */
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-config.txt      |   33 -
>  tools/perf/Documentation/perf-record.txt      |   22 -
>  tools/perf/Makefile.config                    |   43 -
>  tools/perf/Makefile.perf                      |   13 -
>  tools/perf/builtin-record.c                   |   45 -
>  tools/perf/builtin-trace.c                    |  146 +-
>  tools/perf/perf.c                             |    2 -
>  tools/perf/tests/.gitignore                   |    5 -
>  tools/perf/tests/Build                        |   31 -
>  tools/perf/tests/bpf-script-example.c         |   60 -
>  tools/perf/tests/bpf-script-test-kbuild.c     |   21 -
>  tools/perf/tests/bpf-script-test-prologue.c   |   49 -
>  tools/perf/tests/bpf-script-test-relocation.c |   51 -
>  tools/perf/tests/bpf.c                        |  390 ----
>  tools/perf/tests/builtin-test.c               |    3 -
>  tools/perf/tests/clang.c                      |   32 -
>  tools/perf/tests/llvm.c                       |  219 --
>  tools/perf/tests/llvm.h                       |   31 -
>  tools/perf/tests/make                         |    2 -
>  tools/perf/tests/tests.h                      |    2 -
>  tools/perf/util/Build                         |    8 +-
>  tools/perf/util/bpf-loader.c                  | 2006 -----------------
>  tools/perf/util/bpf-loader.h                  |  216 --
>  tools/perf/util/c++/Build                     |    5 -
>  tools/perf/util/c++/clang-c.h                 |   43 -
>  tools/perf/util/c++/clang-test.cpp            |   67 -
>  tools/perf/util/c++/clang.cpp                 |  225 --
>  tools/perf/util/c++/clang.h                   |   27 -
>  tools/perf/util/config.c                      |    4 -
>  tools/perf/util/llvm-utils.c                  |  612 -----
>  tools/perf/util/llvm-utils.h                  |   69 -
>  tools/perf/util/parse-events.c                |  268 ---
>  tools/perf/util/parse-events.h                |   15 -
>  tools/perf/util/parse-events.l                |   31 -
>  tools/perf/util/parse-events.y                |   44 +-
>  35 files changed, 3 insertions(+), 4837 deletions(-)
>  delete mode 100644 tools/perf/tests/.gitignore
>  delete mode 100644 tools/perf/tests/bpf-script-example.c
>  delete mode 100644 tools/perf/tests/bpf-script-test-kbuild.c
>  delete mode 100644 tools/perf/tests/bpf-script-test-prologue.c
>  delete mode 100644 tools/perf/tests/bpf-script-test-relocation.c
>  delete mode 100644 tools/perf/tests/bpf.c
>  delete mode 100644 tools/perf/tests/clang.c
>  delete mode 100644 tools/perf/tests/llvm.c
>  delete mode 100644 tools/perf/tests/llvm.h
>  delete mode 100644 tools/perf/util/bpf-loader.c
>  delete mode 100644 tools/perf/util/bpf-loader.h
>  delete mode 100644 tools/perf/util/c++/Build
>  delete mode 100644 tools/perf/util/c++/clang-c.h
>  delete mode 100644 tools/perf/util/c++/clang-test.cpp
>  delete mode 100644 tools/perf/util/c++/clang.cpp
>  delete mode 100644 tools/perf/util/c++/clang.h
>  delete mode 100644 tools/perf/util/llvm-utils.c
>  delete mode 100644 tools/perf/util/llvm-utils.h
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 1478068ad5dd..0b4e79dbd3f6 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -125,9 +125,6 @@ Given a $HOME/.perfconfig like this:
>  		group = true
>  		skip-empty = true
>  
> -	[llvm]
> -		dump-obj = true
> -		clang-opt = -g
>  
>  You can hide source code of annotate feature setting the config to false with
>  
> @@ -657,36 +654,6 @@ ftrace.*::
>  		-F option is not specified. Possible values are 'function' and
>  		'function_graph'.
>  
> -llvm.*::
> -	llvm.clang-path::
> -		Path to clang. If omit, search it from $PATH.
> -
> -	llvm.clang-bpf-cmd-template::
> -		Cmdline template. Below lines show its default value. Environment
> -		variable is used to pass options.
> -		"$CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS "\
> -		"-DLINUX_VERSION_CODE=$LINUX_VERSION_CODE "	\
> -		"$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
> -		"-Wno-unused-value -Wno-pointer-sign "		\
> -		"-working-directory $WORKING_DIR "		\
> -		"-c \"$CLANG_SOURCE\" --target=bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
> -
> -	llvm.clang-opt::
> -		Options passed to clang.
> -
> -	llvm.kbuild-dir::
> -		kbuild directory. If not set, use /lib/modules/`uname -r`/build.
> -		If set to "" deliberately, skip kernel header auto-detector.
> -
> -	llvm.kbuild-opts::
> -		Options passed to 'make' when detecting kernel header options.
> -
> -	llvm.dump-obj::
> -		Enable perf dump BPF object files compiled by LLVM.
> -
> -	llvm.opts::
> -		Options passed to llc.
> -
>  samples.*::
>  
>  	samples.context::
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 680396c56bd1..7d362407fb39 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -99,20 +99,6 @@ OPTIONS
>            If you want to profile write accesses in [0x1000~1008), just set
>            'mem:0x1000/8:w'.
>  
> -        - a BPF source file (ending in .c) or a precompiled object file (ending
> -          in .o) selects one or more BPF events.
> -          The BPF program can attach to various perf events based on the ELF section
> -          names.
> -
> -          When processing a '.c' file, perf searches an installed LLVM to compile it
> -          into an object file first. Optional clang options can be passed via the
> -          '--clang-opt' command line option, e.g.:
> -
> -            perf record --clang-opt "-DLINUX_VERSION_CODE=0x50000" \
> -                        -e tests/bpf-script-example.c
> -
> -          Note: '--clang-opt' must be placed before '--event/-e'.
> -
>  	- a group of events surrounded by a pair of brace ("{event1,event2,...}").
>  	  Each event is separated by commas and the group should be quoted to
>  	  prevent the shell interpretation.  You also need to use --group on
> @@ -547,14 +533,6 @@ PERF_RECORD_SWITCH_CPU_WIDE. In some cases (e.g. Intel PT, CoreSight or Arm SPE)
>  switch events will be enabled automatically, which can be suppressed by
>  by the option --no-switch-events.
>  
> ---clang-path=PATH::
> -Path to clang binary to use for compiling BPF scriptlets.
> -(enabled when BPF support is on)
> -
> ---clang-opt=OPTIONS::
> -Options passed to clang when compiling BPF scriptlets.
> -(enabled when BPF support is on)
> -
>  --vmlinux=PATH::
>  Specify vmlinux path which has debuginfo.
>  (enabled when BPF prologue is on)
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 1bf8dc53641f..d66b52407e19 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -589,18 +589,6 @@ ifndef NO_LIBELF
>  	LIBBPF_STATIC := 1
>        endif
>      endif
> -
> -    ifndef NO_DWARF
> -      ifdef PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
> -        CFLAGS += -DHAVE_BPF_PROLOGUE
> -        $(call detected,CONFIG_BPF_PROLOGUE)
> -      else
> -        msg := $(warning BPF prologue is not supported by architecture $(SRCARCH), missing regs_query_register_offset());
> -      endif
> -    else
> -      msg := $(warning DWARF support is off, BPF prologue is disabled);
> -    endif
> -
>    endif # NO_LIBBPF
>  endif # NO_LIBELF
>  
> @@ -1127,37 +1115,6 @@ ifndef NO_JVMTI
>    endif
>  endif
>  
> -USE_CXX = 0
> -USE_CLANGLLVM = 0
> -ifdef LIBCLANGLLVM
> -  $(call feature_check,cxx)
> -  ifneq ($(feature-cxx), 1)
> -    msg := $(warning No g++ found, disable clang and llvm support. Please install g++)
> -  else
> -    $(call feature_check,llvm)
> -    $(call feature_check,llvm-version)
> -    ifneq ($(feature-llvm), 1)
> -      msg := $(warning No suitable libLLVM found, disabling builtin clang and LLVM support. Please install llvm-dev(el) (>= 3.9.0))
> -    else
> -      $(call feature_check,clang)
> -      ifneq ($(feature-clang), 1)
> -        msg := $(warning No suitable libclang found, disabling builtin clang and LLVM support. Please install libclang-dev(el) (>= 3.9.0))
> -      else
> -        CFLAGS += -DHAVE_LIBCLANGLLVM_SUPPORT
> -        CXXFLAGS += -DHAVE_LIBCLANGLLVM_SUPPORT -I$(shell $(LLVM_CONFIG) --includedir)
> -        $(call detected,CONFIG_CXX)
> -        $(call detected,CONFIG_CLANGLLVM)
> -	USE_CXX = 1
> -	USE_LLVM = 1
> -	USE_CLANG = 1
> -        ifneq ($(feature-llvm-version),1)
> -          msg := $(warning This version of LLVM is not tested. May cause build errors)
> -        endif
> -      endif
> -    endif
> -  endif
> -endif
> -
>  ifndef NO_LIBPFM4
>    $(call feature_check,libpfm4)
>    ifeq ($(feature-libpfm4), 1)
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 0ed7ee0c1665..6ec5079fd697 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -425,19 +425,6 @@ endif
>  EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
>  LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
>  
> -ifeq ($(USE_CLANG), 1)
> -  LIBS += -L$(shell $(LLVM_CONFIG) --libdir) -lclang-cpp
> -endif
> -
> -ifeq ($(USE_LLVM), 1)
> -  LIBLLVM = $(shell $(LLVM_CONFIG) --libs all) $(shell $(LLVM_CONFIG) --system-libs)
> -  LIBS += -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM)
> -endif
> -
> -ifeq ($(USE_CXX), 1)
> -  LIBS += -lstdc++
> -endif
> -
>  export INSTALL SHELL_PATH
>  
>  ### Build rules
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index aec18db7ff23..34bb31f08bb5 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -37,8 +37,6 @@
>  #include "util/parse-branch-options.h"
>  #include "util/parse-regs-options.h"
>  #include "util/perf_api_probe.h"
> -#include "util/llvm-utils.h"
> -#include "util/bpf-loader.h"
>  #include "util/trigger.h"
>  #include "util/perf-hooks.h"
>  #include "util/cpu-set-sched.h"
> @@ -2465,16 +2463,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		}
>  	}
>  
> -	err = bpf__apply_obj_config();
> -	if (err) {
> -		char errbuf[BUFSIZ];
> -
> -		bpf__strerror_apply_obj_config(err, errbuf, sizeof(errbuf));
> -		pr_err("ERROR: Apply config to BPF failed: %s\n",
> -			 errbuf);
> -		goto out_free_threads;
> -	}
> -
>  	/*
>  	 * Normally perf_session__new would do this, but it doesn't have the
>  	 * evlist.
> @@ -3486,10 +3474,6 @@ static struct option __record_options[] = {
>  		    "collect kernel callchains"),
>  	OPT_BOOLEAN(0, "user-callchains", &record.opts.user_callchains,
>  		    "collect user callchains"),
> -	OPT_STRING(0, "clang-path", &llvm_param.clang_path, "clang path",
> -		   "clang binary to use for compiling BPF scriptlets"),
> -	OPT_STRING(0, "clang-opt", &llvm_param.clang_opt, "clang options",
> -		   "options passed to clang when compiling BPF scriptlets"),
>  	OPT_STRING(0, "vmlinux", &symbol_conf.vmlinux_name,
>  		   "file", "vmlinux pathname"),
>  	OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
> @@ -3967,27 +3951,6 @@ int cmd_record(int argc, const char **argv)
>  
>  	setlocale(LC_ALL, "");
>  
> -#ifndef HAVE_LIBBPF_SUPPORT
> -# define set_nobuild(s, l, c) set_option_nobuild(record_options, s, l, "NO_LIBBPF=1", c)
> -	set_nobuild('\0', "clang-path", true);
> -	set_nobuild('\0', "clang-opt", true);
> -# undef set_nobuild
> -#endif
> -
> -#ifndef HAVE_BPF_PROLOGUE
> -# if !defined (HAVE_DWARF_SUPPORT)
> -#  define REASON  "NO_DWARF=1"
> -# elif !defined (HAVE_LIBBPF_SUPPORT)
> -#  define REASON  "NO_LIBBPF=1"
> -# else
> -#  define REASON  "this architecture doesn't support BPF prologue"
> -# endif
> -# define set_nobuild(s, l, c) set_option_nobuild(record_options, s, l, REASON, c)
> -	set_nobuild('\0', "vmlinux", true);
> -# undef set_nobuild
> -# undef REASON
> -#endif
> -
>  #ifndef HAVE_BPF_SKEL
>  # define set_nobuild(s, l, m, c) set_option_nobuild(record_options, s, l, m, c)
>  	set_nobuild('\0', "off-cpu", "no BUILD_BPF_SKEL=1", true);
> @@ -4116,14 +4079,6 @@ int cmd_record(int argc, const char **argv)
>  	if (dry_run)
>  		goto out;
>  
> -	err = bpf__setup_stdout(rec->evlist);
> -	if (err) {
> -		bpf__strerror_setup_stdout(rec->evlist, err, errbuf, sizeof(errbuf));
> -		pr_err("ERROR: Setup BPF stdout failed: %s\n",
> -			 errbuf);
> -		goto out;
> -	}
> -
>  	err = -ENOMEM;
>  
>  	if (rec->no_buildid_cache || rec->no_buildid) {
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 7ece2521efb6..59862467e781 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -18,6 +18,7 @@
>  #include <api/fs/tracing_path.h>
>  #ifdef HAVE_LIBBPF_SUPPORT
>  #include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
>  #endif
>  #include "util/bpf_map.h"
>  #include "util/rlimit.h"
> @@ -53,7 +54,6 @@
>  #include "trace/beauty/beauty.h"
>  #include "trace-event.h"
>  #include "util/parse-events.h"
> -#include "util/bpf-loader.h"
>  #include "util/tracepoint.h"
>  #include "callchain.h"
>  #include "print_binary.h"
> @@ -3287,17 +3287,6 @@ static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const ch
>  	return bpf_object__find_map_by_name(trace->bpf_obj, name);
>  }
>  
> -static void trace__set_bpf_map_filtered_pids(struct trace *trace)
> -{
> -	trace->filter_pids.map = trace__find_bpf_map_by_name(trace, "pids_filtered");
> -}
> -
> -static void trace__set_bpf_map_syscalls(struct trace *trace)
> -{
> -	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
> -	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
> -}
> -
>  static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
>  {
>  	struct bpf_program *pos, *prog = NULL;
> @@ -3553,25 +3542,6 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
>  	return err;
>  }
>  
> -static void trace__delete_augmented_syscalls(struct trace *trace)
> -{
> -	struct evsel *evsel, *tmp;
> -
> -	evlist__remove(trace->evlist, trace->syscalls.events.augmented);
> -	evsel__delete(trace->syscalls.events.augmented);
> -	trace->syscalls.events.augmented = NULL;
> -
> -	evlist__for_each_entry_safe(trace->evlist, tmp, evsel) {
> -		if (evsel->bpf_obj == trace->bpf_obj) {
> -			evlist__remove(trace->evlist, evsel);
> -			evsel__delete(evsel);
> -		}
> -
> -	}
> -
> -	bpf_object__close(trace->bpf_obj);
> -	trace->bpf_obj = NULL;
> -}
>  #else // HAVE_LIBBPF_SUPPORT
>  static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace __maybe_unused,
>  						   const char *name __maybe_unused)
> @@ -3579,45 +3549,12 @@ static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace __maybe_u
>  	return NULL;
>  }
>  
> -static void trace__set_bpf_map_filtered_pids(struct trace *trace __maybe_unused)
> -{
> -}
> -
> -static void trace__set_bpf_map_syscalls(struct trace *trace __maybe_unused)
> -{
> -}
> -
> -static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace __maybe_unused,
> -							    const char *name __maybe_unused)
> -{
> -	return NULL;
> -}
> -
>  static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace __maybe_unused)
>  {
>  	return 0;
>  }
> -
> -static void trace__delete_augmented_syscalls(struct trace *trace __maybe_unused)
> -{
> -}
>  #endif // HAVE_LIBBPF_SUPPORT
>  
> -static bool trace__only_augmented_syscalls_evsels(struct trace *trace)
> -{
> -	struct evsel *evsel;
> -
> -	evlist__for_each_entry(trace->evlist, evsel) {
> -		if (evsel == trace->syscalls.events.augmented ||
> -		    evsel->bpf_obj == trace->bpf_obj)
> -			continue;
> -
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  static int trace__set_ev_qualifier_filter(struct trace *trace)
>  {
>  	if (trace->syscalls.events.sys_enter)
> @@ -3981,16 +3918,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	if (err < 0)
>  		goto out_error_open;
>  
> -	err = bpf__apply_obj_config();
> -	if (err) {
> -		char errbuf[BUFSIZ];
> -
> -		bpf__strerror_apply_obj_config(err, errbuf, sizeof(errbuf));
> -		pr_err("ERROR: Apply config to BPF failed: %s\n",
> -			 errbuf);
> -		goto out_error_open;
> -	}
> -
>  	err = trace__set_filter_pids(trace);
>  	if (err < 0)
>  		goto out_error_mem;
> @@ -4922,77 +4849,6 @@ int cmd_trace(int argc, const char **argv)
>  				       "cgroup monitoring only available in system-wide mode");
>  	}
>  
> -	evsel = bpf__setup_output_event(trace.evlist, "__augmented_syscalls__");
> -	if (IS_ERR(evsel)) {
> -		bpf__strerror_setup_output_event(trace.evlist, PTR_ERR(evsel), bf, sizeof(bf));
> -		pr_err("ERROR: Setup trace syscalls enter failed: %s\n", bf);
> -		goto out;
> -	}
> -
> -	if (evsel) {
> -		trace.syscalls.events.augmented = evsel;
> -
> -		evsel = evlist__find_tracepoint_by_name(trace.evlist, "raw_syscalls:sys_enter");
> -		if (evsel == NULL) {
> -			pr_err("ERROR: raw_syscalls:sys_enter not found in the augmented BPF object\n");
> -			goto out;
> -		}
> -
> -		if (evsel->bpf_obj == NULL) {
> -			pr_err("ERROR: raw_syscalls:sys_enter not associated to a BPF object\n");
> -			goto out;
> -		}
> -
> -		trace.bpf_obj = evsel->bpf_obj;
> -
> -		/*
> -		 * If we have _just_ the augmenter event but don't have a
> -		 * explicit --syscalls, then assume we want all strace-like
> -		 * syscalls:
> -		 */
> -		if (!trace.trace_syscalls && trace__only_augmented_syscalls_evsels(&trace))
> -			trace.trace_syscalls = true;
> -		/*
> -		 * So, if we have a syscall augmenter, but trace_syscalls, aka
> -		 * strace-like syscall tracing is not set, then we need to trow
> -		 * away the augmenter, i.e. all the events that were created
> -		 * from that BPF object file.
> -		 *
> -		 * This is more to fix the current .perfconfig trace.add_events
> -		 * style of setting up the strace-like eBPF based syscall point
> -		 * payload augmenter.
> -		 *
> -		 * All this complexity will be avoided by adding an alternative
> -		 * to trace.add_events in the form of
> -		 * trace.bpf_augmented_syscalls, that will be only parsed if we
> -		 * need it.
> -		 *
> -		 * .perfconfig trace.add_events is still useful if we want, for
> -		 * instance, have msr_write.msr in some .perfconfig profile based
> -		 * 'perf trace --config determinism.profile' mode, where for some
> -		 * particular goal/workload type we want a set of events and
> -		 * output mode (with timings, etc) instead of having to add
> -		 * all via the command line.
> -		 *
> -		 * Also --config to specify an alternate .perfconfig file needs
> -		 * to be implemented.
> -		 */
> -		if (!trace.trace_syscalls) {
> -			trace__delete_augmented_syscalls(&trace);
> -		} else {
> -			trace__set_bpf_map_filtered_pids(&trace);
> -			trace__set_bpf_map_syscalls(&trace);
> -			trace.syscalls.unaugmented_prog = trace__find_bpf_program_by_title(&trace, "!raw_syscalls:unaugmented");
> -		}
> -	}
> -
> -	err = bpf__setup_stdout(trace.evlist);
> -	if (err) {
> -		bpf__strerror_setup_stdout(trace.evlist, err, bf, sizeof(bf));
> -		pr_err("ERROR: Setup BPF stdout failed: %s\n", bf);
> -		goto out;
> -	}
> -
>  	err = -1;
>  
>  	if (map_dump_str) {
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 38cae4721583..d3fc8090413c 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -18,7 +18,6 @@
>  #include <subcmd/run-command.h>
>  #include "util/parse-events.h"
>  #include <subcmd/parse-options.h>
> -#include "util/bpf-loader.h"
>  #include "util/debug.h"
>  #include "util/event.h"
>  #include "util/util.h" // usage()
> @@ -324,7 +323,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  	perf_config__exit();
>  	exit_browser(status);
>  	perf_env__exit(&perf_env);
> -	bpf__clear();
>  
>  	if (status)
>  		return status & 0xff;
> diff --git a/tools/perf/tests/.gitignore b/tools/perf/tests/.gitignore
> deleted file mode 100644
> index d053b325f728..000000000000
> --- a/tools/perf/tests/.gitignore
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -llvm-src-base.c
> -llvm-src-kbuild.c
> -llvm-src-prologue.c
> -llvm-src-relocation.c
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index fb9ac5dc4079..63d5e6d5f165 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -37,8 +37,6 @@ perf-y += sample-parsing.o
>  perf-y += parse-no-sample-id-all.o
>  perf-y += kmod-path.o
>  perf-y += thread-map.o
> -perf-y += llvm.o llvm-src-base.o llvm-src-kbuild.o llvm-src-prologue.o llvm-src-relocation.o
> -perf-y += bpf.o
>  perf-y += topology.o
>  perf-y += mem.o
>  perf-y += cpumap.o
> @@ -51,7 +49,6 @@ perf-y += sdt.o
>  perf-y += is_printable_array.o
>  perf-y += bitmap.o
>  perf-y += perf-hooks.o
> -perf-y += clang.o
>  perf-y += unit_number__scnprintf.o
>  perf-y += mem2node.o
>  perf-y += maps.o
> @@ -70,34 +67,6 @@ perf-y += sigtrap.o
>  perf-y += event_groups.o
>  perf-y += symbols.o
>  
> -$(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
> -	$(call rule_mkdir)
> -	$(Q)echo '#include <tests/llvm.h>' > $@
> -	$(Q)echo 'const char test_llvm__bpf_base_prog[] =' >> $@
> -	$(Q)sed -e 's/"/\\"/g' -e 's/\(.*\)/"\1\\n"/g' $< >> $@
> -	$(Q)echo ';' >> $@
> -
> -$(OUTPUT)tests/llvm-src-kbuild.c: tests/bpf-script-test-kbuild.c tests/Build
> -	$(call rule_mkdir)
> -	$(Q)echo '#include <tests/llvm.h>' > $@
> -	$(Q)echo 'const char test_llvm__bpf_test_kbuild_prog[] =' >> $@
> -	$(Q)sed -e 's/"/\\"/g' -e 's/\(.*\)/"\1\\n"/g' $< >> $@
> -	$(Q)echo ';' >> $@
> -
> -$(OUTPUT)tests/llvm-src-prologue.c: tests/bpf-script-test-prologue.c tests/Build
> -	$(call rule_mkdir)
> -	$(Q)echo '#include <tests/llvm.h>' > $@
> -	$(Q)echo 'const char test_llvm__bpf_test_prologue_prog[] =' >> $@
> -	$(Q)sed -e 's/"/\\"/g' -e 's/\(.*\)/"\1\\n"/g' $< >> $@
> -	$(Q)echo ';' >> $@
> -
> -$(OUTPUT)tests/llvm-src-relocation.c: tests/bpf-script-test-relocation.c tests/Build
> -	$(call rule_mkdir)
> -	$(Q)echo '#include <tests/llvm.h>' > $@
> -	$(Q)echo 'const char test_llvm__bpf_test_relocation[] =' >> $@
> -	$(Q)sed -e 's/"/\\"/g' -e 's/\(.*\)/"\1\\n"/g' $< >> $@
> -	$(Q)echo ';' >> $@
> -
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
>  perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>  endif
> diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
> deleted file mode 100644
> index b638cc99d5ae..000000000000
> --- a/tools/perf/tests/bpf-script-example.c
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * bpf-script-example.c
> - * Test basic LLVM building
> - */
> -#ifndef LINUX_VERSION_CODE
> -# error Need LINUX_VERSION_CODE
> -# error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
> -#endif
> -#define BPF_ANY 0
> -#define BPF_MAP_TYPE_ARRAY 2
> -#define BPF_FUNC_map_lookup_elem 1
> -#define BPF_FUNC_map_update_elem 2
> -
> -static void *(*bpf_map_lookup_elem)(void *map, void *key) =
> -	(void *) BPF_FUNC_map_lookup_elem;
> -static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
> -	(void *) BPF_FUNC_map_update_elem;
> -
> -/*
> - * Following macros are taken from tools/lib/bpf/bpf_helpers.h,
> - * and are used to create BTF defined maps. It is easier to take
> - * 2 simple macros, than being able to include above header in
> - * runtime.
> - *
> - * __uint - defines integer attribute of BTF map definition,
> - * Such attributes are represented using a pointer to an array,
> - * in which dimensionality of array encodes specified integer
> - * value.
> - *
> - * __type - defines pointer variable with typeof(val) type for
> - * attributes like key or value, which will be defined by the
> - * size of the type.
> - */
> -#define __uint(name, val) int (*name)[val]
> -#define __type(name, val) typeof(val) *name
> -
> -#define SEC(NAME) __attribute__((section(NAME), used))
> -struct {
> -	__uint(type, BPF_MAP_TYPE_ARRAY);
> -	__uint(max_entries, 1);
> -	__type(key, int);
> -	__type(value, int);
> -} flip_table SEC(".maps");
> -
> -SEC("syscalls:sys_enter_epoll_pwait")
> -int bpf_func__SyS_epoll_pwait(void *ctx)
> -{
> -	int ind =0;
> -	int *flag = bpf_map_lookup_elem(&flip_table, &ind);
> -	int new_flag;
> -	if (!flag)
> -		return 0;
> -	/* flip flag and store back */
> -	new_flag = !*flag;
> -	bpf_map_update_elem(&flip_table, &ind, &new_flag, BPF_ANY);
> -	return new_flag;
> -}
> -char _license[] SEC("license") = "GPL";
> -int _version SEC("version") = LINUX_VERSION_CODE;
> diff --git a/tools/perf/tests/bpf-script-test-kbuild.c b/tools/perf/tests/bpf-script-test-kbuild.c
> deleted file mode 100644
> index 219673aa278f..000000000000
> --- a/tools/perf/tests/bpf-script-test-kbuild.c
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * bpf-script-test-kbuild.c
> - * Test include from kernel header
> - */
> -#ifndef LINUX_VERSION_CODE
> -# error Need LINUX_VERSION_CODE
> -# error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
> -#endif
> -#define SEC(NAME) __attribute__((section(NAME), used))
> -
> -#include <uapi/linux/fs.h>
> -
> -SEC("func=vfs_llseek")
> -int bpf_func__vfs_llseek(void *ctx)
> -{
> -	return 0;
> -}
> -
> -char _license[] SEC("license") = "GPL";
> -int _version SEC("version") = LINUX_VERSION_CODE;
> diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
> deleted file mode 100644
> index 91778b5c6125..000000000000
> --- a/tools/perf/tests/bpf-script-test-prologue.c
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * bpf-script-test-prologue.c
> - * Test BPF prologue
> - */
> -#ifndef LINUX_VERSION_CODE
> -# error Need LINUX_VERSION_CODE
> -# error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
> -#endif
> -#define SEC(NAME) __attribute__((section(NAME), used))
> -
> -#include <uapi/linux/fs.h>
> -
> -/*
> - * If CONFIG_PROFILE_ALL_BRANCHES is selected,
> - * 'if' is redefined after include kernel header.
> - * Recover 'if' for BPF object code.
> - */
> -#ifdef if
> -# undef if
> -#endif
> -
> -typedef unsigned int __bitwise fmode_t;
> -
> -#define FMODE_READ		0x1
> -#define FMODE_WRITE		0x2
> -
> -static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
> -	(void *) 6;
> -
> -SEC("func=null_lseek file->f_mode offset orig")
> -int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
> -			 unsigned long offset, unsigned long orig)
> -{
> -	fmode_t f_mode = (fmode_t)_f_mode;
> -
> -	if (err)
> -		return 0;
> -	if (f_mode & FMODE_WRITE)
> -		return 0;
> -	if (offset & 1)
> -		return 0;
> -	if (orig == SEEK_CUR)
> -		return 0;
> -	return 1;
> -}
> -
> -char _license[] SEC("license") = "GPL";
> -int _version SEC("version") = LINUX_VERSION_CODE;
> diff --git a/tools/perf/tests/bpf-script-test-relocation.c b/tools/perf/tests/bpf-script-test-relocation.c
> deleted file mode 100644
> index 74006e4b2d24..000000000000
> --- a/tools/perf/tests/bpf-script-test-relocation.c
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * bpf-script-test-relocation.c
> - * Test BPF loader checking relocation
> - */
> -#ifndef LINUX_VERSION_CODE
> -# error Need LINUX_VERSION_CODE
> -# error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
> -#endif
> -#define BPF_ANY 0
> -#define BPF_MAP_TYPE_ARRAY 2
> -#define BPF_FUNC_map_lookup_elem 1
> -#define BPF_FUNC_map_update_elem 2
> -
> -static void *(*bpf_map_lookup_elem)(void *map, void *key) =
> -	(void *) BPF_FUNC_map_lookup_elem;
> -static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
> -	(void *) BPF_FUNC_map_update_elem;
> -
> -struct bpf_map_def {
> -	unsigned int type;
> -	unsigned int key_size;
> -	unsigned int value_size;
> -	unsigned int max_entries;
> -};
> -
> -#define SEC(NAME) __attribute__((section(NAME), used))
> -struct bpf_map_def SEC("maps") my_table = {
> -	.type = BPF_MAP_TYPE_ARRAY,
> -	.key_size = sizeof(int),
> -	.value_size = sizeof(int),
> -	.max_entries = 1,
> -};
> -
> -int this_is_a_global_val;
> -
> -SEC("func=sys_write")
> -int bpf_func__sys_write(void *ctx)
> -{
> -	int key = 0;
> -	int value = 0;
> -
> -	/*
> -	 * Incorrect relocation. Should not allow this program be
> -	 * loaded into kernel.
> -	 */
> -	bpf_map_update_elem(&this_is_a_global_val, &key, &value, 0);
> -	return 0;
> -}
> -char _license[] SEC("license") = "GPL";
> -int _version SEC("version") = LINUX_VERSION_CODE;
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> deleted file mode 100644
> index 9ccecd873ecd..000000000000
> --- a/tools/perf/tests/bpf.c
> +++ /dev/null
> @@ -1,390 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <errno.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <sys/epoll.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <util/record.h>
> -#include <util/util.h>
> -#include <util/bpf-loader.h>
> -#include <util/evlist.h>
> -#include <linux/filter.h>
> -#include <linux/kernel.h>
> -#include <linux/string.h>
> -#include <api/fs/fs.h>
> -#include <perf/mmap.h>
> -#include "tests.h"
> -#include "llvm.h"
> -#include "debug.h"
> -#include "parse-events.h"
> -#include "util/mmap.h"
> -#define NR_ITERS       111
> -#define PERF_TEST_BPF_PATH "/sys/fs/bpf/perf_test"
> -
> -#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> -#include <linux/bpf.h>
> -#include <bpf/bpf.h>
> -
> -static int epoll_pwait_loop(void)
> -{
> -	struct epoll_event events;
> -	int i;
> -
> -	/* Should fail NR_ITERS times */
> -	for (i = 0; i < NR_ITERS; i++)
> -		epoll_pwait(-(i + 1), &events, 0, 0, NULL);
> -	return 0;
> -}
> -
> -#ifdef HAVE_BPF_PROLOGUE
> -
> -static int llseek_loop(void)
> -{
> -	int fds[2], i;
> -
> -	fds[0] = open("/dev/null", O_RDONLY);
> -	fds[1] = open("/dev/null", O_RDWR);
> -
> -	if (fds[0] < 0 || fds[1] < 0)
> -		return -1;
> -
> -	for (i = 0; i < NR_ITERS; i++) {
> -		lseek(fds[i % 2], i, (i / 2) % 2 ? SEEK_CUR : SEEK_SET);
> -		lseek(fds[(i + 1) % 2], i, (i / 2) % 2 ? SEEK_CUR : SEEK_SET);
> -	}
> -	close(fds[0]);
> -	close(fds[1]);
> -	return 0;
> -}
> -
> -#endif
> -
> -static struct {
> -	enum test_llvm__testcase prog_id;
> -	const char *name;
> -	const char *msg_compile_fail;
> -	const char *msg_load_fail;
> -	int (*target_func)(void);
> -	int expect_result;
> -	bool	pin;
> -} bpf_testcase_table[] = {
> -	{
> -		.prog_id	  = LLVM_TESTCASE_BASE,
> -		.name		  = "[basic_bpf_test]",
> -		.msg_compile_fail = "fix 'perf test LLVM' first",
> -		.msg_load_fail	  = "load bpf object failed",
> -		.target_func	  = &epoll_pwait_loop,
> -		.expect_result	  = (NR_ITERS + 1) / 2,
> -	},
> -	{
> -		.prog_id	  = LLVM_TESTCASE_BASE,
> -		.name		  = "[bpf_pinning]",
> -		.msg_compile_fail = "fix kbuild first",
> -		.msg_load_fail	  = "check your vmlinux setting?",
> -		.target_func	  = &epoll_pwait_loop,
> -		.expect_result	  = (NR_ITERS + 1) / 2,
> -		.pin		  = true,
> -	},
> -#ifdef HAVE_BPF_PROLOGUE
> -	{
> -		.prog_id	  = LLVM_TESTCASE_BPF_PROLOGUE,
> -		.name		  = "[bpf_prologue_test]",
> -		.msg_compile_fail = "fix kbuild first",
> -		.msg_load_fail	  = "check your vmlinux setting?",
> -		.target_func	  = &llseek_loop,
> -		.expect_result	  = (NR_ITERS + 1) / 4,
> -	},
> -#endif
> -};
> -
> -static int do_test(struct bpf_object *obj, int (*func)(void),
> -		   int expect)
> -{
> -	struct record_opts opts = {
> -		.target = {
> -			.uid = UINT_MAX,
> -			.uses_mmap = true,
> -		},
> -		.freq	      = 0,
> -		.mmap_pages   = 256,
> -		.default_interval = 1,
> -	};
> -
> -	char pid[16];
> -	char sbuf[STRERR_BUFSIZE];
> -	struct evlist *evlist;
> -	int i, ret = TEST_FAIL, err = 0, count = 0;
> -
> -	struct parse_events_state parse_state;
> -	struct parse_events_error parse_error;
> -
> -	parse_events_error__init(&parse_error);
> -	bzero(&parse_state, sizeof(parse_state));
> -	parse_state.error = &parse_error;
> -	INIT_LIST_HEAD(&parse_state.list);
> -
> -	err = parse_events_load_bpf_obj(&parse_state, &parse_state.list, obj, NULL, NULL);
> -	parse_events_error__exit(&parse_error);
> -	if (err == -ENODATA) {
> -		pr_debug("Failed to add events selected by BPF, debuginfo package not installed\n");
> -		return TEST_SKIP;
> -	}
> -	if (err || list_empty(&parse_state.list)) {
> -		pr_debug("Failed to add events selected by BPF\n");
> -		return TEST_FAIL;
> -	}
> -
> -	snprintf(pid, sizeof(pid), "%d", getpid());
> -	pid[sizeof(pid) - 1] = '\0';
> -	opts.target.tid = opts.target.pid = pid;
> -
> -	/* Instead of evlist__new_default, don't add default events */
> -	evlist = evlist__new();
> -	if (!evlist) {
> -		pr_debug("Not enough memory to create evlist\n");
> -		return TEST_FAIL;
> -	}
> -
> -	err = evlist__create_maps(evlist, &opts.target);
> -	if (err < 0) {
> -		pr_debug("Not enough memory to create thread/cpu maps\n");
> -		goto out_delete_evlist;
> -	}
> -
> -	evlist__splice_list_tail(evlist, &parse_state.list);
> -
> -	evlist__config(evlist, &opts, NULL);
> -
> -	err = evlist__open(evlist);
> -	if (err < 0) {
> -		pr_debug("perf_evlist__open: %s\n",
> -			 str_error_r(errno, sbuf, sizeof(sbuf)));
> -		goto out_delete_evlist;
> -	}
> -
> -	err = evlist__mmap(evlist, opts.mmap_pages);
> -	if (err < 0) {
> -		pr_debug("evlist__mmap: %s\n",
> -			 str_error_r(errno, sbuf, sizeof(sbuf)));
> -		goto out_delete_evlist;
> -	}
> -
> -	evlist__enable(evlist);
> -	(*func)();
> -	evlist__disable(evlist);
> -
> -	for (i = 0; i < evlist->core.nr_mmaps; i++) {
> -		union perf_event *event;
> -		struct mmap *md;
> -
> -		md = &evlist->mmap[i];
> -		if (perf_mmap__read_init(&md->core) < 0)
> -			continue;
> -
> -		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
> -			const u32 type = event->header.type;
> -
> -			if (type == PERF_RECORD_SAMPLE)
> -				count ++;
> -		}
> -		perf_mmap__read_done(&md->core);
> -	}
> -
> -	if (count != expect * evlist->core.nr_entries) {
> -		pr_debug("BPF filter result incorrect, expected %d, got %d samples\n", expect * evlist->core.nr_entries, count);
> -		goto out_delete_evlist;
> -	}
> -
> -	ret = TEST_OK;
> -
> -out_delete_evlist:
> -	evlist__delete(evlist);
> -	return ret;
> -}
> -
> -static struct bpf_object *
> -prepare_bpf(void *obj_buf, size_t obj_buf_sz, const char *name)
> -{
> -	struct bpf_object *obj;
> -
> -	obj = bpf__prepare_load_buffer(obj_buf, obj_buf_sz, name);
> -	if (IS_ERR(obj)) {
> -		pr_debug("Compile BPF program failed.\n");
> -		return NULL;
> -	}
> -	return obj;
> -}
> -
> -static int __test__bpf(int idx)
> -{
> -	int ret;
> -	void *obj_buf;
> -	size_t obj_buf_sz;
> -	struct bpf_object *obj;
> -
> -	ret = test_llvm__fetch_bpf_obj(&obj_buf, &obj_buf_sz,
> -				       bpf_testcase_table[idx].prog_id,
> -				       false, NULL);
> -	if (ret != TEST_OK || !obj_buf || !obj_buf_sz) {
> -		pr_debug("Unable to get BPF object, %s\n",
> -			 bpf_testcase_table[idx].msg_compile_fail);
> -		if ((idx == 0) || (ret == TEST_SKIP))
> -			return TEST_SKIP;
> -		else
> -			return TEST_FAIL;
> -	}
> -
> -	obj = prepare_bpf(obj_buf, obj_buf_sz,
> -			  bpf_testcase_table[idx].name);
> -	if ((!!bpf_testcase_table[idx].target_func) != (!!obj)) {
> -		if (!obj)
> -			pr_debug("Fail to load BPF object: %s\n",
> -				 bpf_testcase_table[idx].msg_load_fail);
> -		else
> -			pr_debug("Success unexpectedly: %s\n",
> -				 bpf_testcase_table[idx].msg_load_fail);
> -		ret = TEST_FAIL;
> -		goto out;
> -	}
> -
> -	if (obj) {
> -		ret = do_test(obj,
> -			      bpf_testcase_table[idx].target_func,
> -			      bpf_testcase_table[idx].expect_result);
> -		if (ret != TEST_OK)
> -			goto out;
> -		if (bpf_testcase_table[idx].pin) {
> -			int err;
> -
> -			if (!bpf_fs__mount()) {
> -				pr_debug("BPF filesystem not mounted\n");
> -				ret = TEST_FAIL;
> -				goto out;
> -			}
> -			err = mkdir(PERF_TEST_BPF_PATH, 0777);
> -			if (err && errno != EEXIST) {
> -				pr_debug("Failed to make perf_test dir: %s\n",
> -					 strerror(errno));
> -				ret = TEST_FAIL;
> -				goto out;
> -			}
> -			if (bpf_object__pin(obj, PERF_TEST_BPF_PATH))
> -				ret = TEST_FAIL;
> -			if (rm_rf(PERF_TEST_BPF_PATH))
> -				ret = TEST_FAIL;
> -		}
> -	}
> -
> -out:
> -	free(obj_buf);
> -	bpf__clear();
> -	return ret;
> -}
> -
> -static int check_env(void)
> -{
> -	LIBBPF_OPTS(bpf_prog_load_opts, opts);
> -	int err;
> -	char license[] = "GPL";
> -
> -	struct bpf_insn insns[] = {
> -		BPF_MOV64_IMM(BPF_REG_0, 1),
> -		BPF_EXIT_INSN(),
> -	};
> -
> -	err = fetch_kernel_version(&opts.kern_version, NULL, 0);
> -	if (err) {
> -		pr_debug("Unable to get kernel version\n");
> -		return err;
> -	}
> -	err = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, license, insns,
> -			    ARRAY_SIZE(insns), &opts);
> -	if (err < 0) {
> -		pr_err("Missing basic BPF support, skip this test: %s\n",
> -		       strerror(errno));
> -		return err;
> -	}
> -	close(err);
> -
> -	return 0;
> -}
> -
> -static int test__bpf(int i)
> -{
> -	int err;
> -
> -	if (i < 0 || i >= (int)ARRAY_SIZE(bpf_testcase_table))
> -		return TEST_FAIL;
> -
> -	if (geteuid() != 0) {
> -		pr_debug("Only root can run BPF test\n");
> -		return TEST_SKIP;
> -	}
> -
> -	if (check_env())
> -		return TEST_SKIP;
> -
> -	err = __test__bpf(i);
> -	return err;
> -}
> -#endif
> -
> -static int test__basic_bpf_test(struct test_suite *test __maybe_unused,
> -				int subtest __maybe_unused)
> -{
> -#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> -	return test__bpf(0);
> -#else
> -	pr_debug("Skip BPF test because BPF or libtraceevent support is not compiled\n");
> -	return TEST_SKIP;
> -#endif
> -}
> -
> -static int test__bpf_pinning(struct test_suite *test __maybe_unused,
> -			     int subtest __maybe_unused)
> -{
> -#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> -	return test__bpf(1);
> -#else
> -	pr_debug("Skip BPF test because BPF or libtraceevent support is not compiled\n");
> -	return TEST_SKIP;
> -#endif
> -}
> -
> -static int test__bpf_prologue_test(struct test_suite *test __maybe_unused,
> -				   int subtest __maybe_unused)
> -{
> -#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_BPF_PROLOGUE) && defined(HAVE_LIBTRACEEVENT)
> -	return test__bpf(2);
> -#else
> -	pr_debug("Skip BPF test because BPF or libtraceevent support is not compiled\n");
> -	return TEST_SKIP;
> -#endif
> -}
> -
> -
> -static struct test_case bpf_tests[] = {
> -#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> -	TEST_CASE("Basic BPF filtering", basic_bpf_test),
> -	TEST_CASE_REASON("BPF pinning", bpf_pinning,
> -			"clang isn't installed or environment missing BPF support"),
> -#ifdef HAVE_BPF_PROLOGUE
> -	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test,
> -			"clang/debuginfo isn't installed or environment missing BPF support"),
> -#else
> -	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
> -#endif
> -#else
> -	TEST_CASE_REASON("Basic BPF filtering", basic_bpf_test, "not compiled in or missing libtraceevent support"),
> -	TEST_CASE_REASON("BPF pinning", bpf_pinning, "not compiled in or missing libtraceevent support"),
> -	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in or missing libtraceevent support"),
> -#endif
> -	{ .name = NULL, }
> -};
> -
> -struct test_suite suite__bpf = {
> -	.desc = "BPF filter",
> -	.test_cases = bpf_tests,
> -};
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 6accb5442a73..0ad18cf6dd22 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -92,9 +92,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__fdarray__add,
>  	&suite__kmod_path__parse,
>  	&suite__thread_map,
> -	&suite__llvm,
>  	&suite__session_topology,
> -	&suite__bpf,
>  	&suite__thread_map_synthesize,
>  	&suite__thread_map_remove,
>  	&suite__cpu_map,
> @@ -108,7 +106,6 @@ static struct test_suite *generic_tests[] = {
>  	&suite__is_printable_array,
>  	&suite__bitmap_print,
>  	&suite__perf_hooks,
> -	&suite__clang,
>  	&suite__unit_number__scnprint,
>  	&suite__mem2node,
>  	&suite__time_utils,
> diff --git a/tools/perf/tests/clang.c b/tools/perf/tests/clang.c
> deleted file mode 100644
> index a7111005d5b9..000000000000
> --- a/tools/perf/tests/clang.c
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "tests.h"
> -#include "c++/clang-c.h"
> -#include <linux/kernel.h>
> -
> -#ifndef HAVE_LIBCLANGLLVM_SUPPORT
> -static int test__clang_to_IR(struct test_suite *test __maybe_unused,
> -			     int subtest __maybe_unused)
> -{
> -	return TEST_SKIP;
> -}
> -
> -static int test__clang_to_obj(struct test_suite *test __maybe_unused,
> -			      int subtest __maybe_unused)
> -{
> -	return TEST_SKIP;
> -}
> -#endif
> -
> -static struct test_case clang_tests[] = {
> -	TEST_CASE_REASON("builtin clang compile C source to IR", clang_to_IR,
> -			 "not compiled in"),
> -	TEST_CASE_REASON("builtin clang compile C source to ELF object",
> -			 clang_to_obj,
> -			 "not compiled in"),
> -	{ .name = NULL, }
> -};
> -
> -struct test_suite suite__clang = {
> -	.desc = "builtin clang support",
> -	.test_cases = clang_tests,
> -};
> diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
> deleted file mode 100644
> index 0bc25a56cfef..000000000000
> --- a/tools/perf/tests/llvm.c
> +++ /dev/null
> @@ -1,219 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include "tests.h"
> -#include "debug.h"
> -
> -#ifdef HAVE_LIBBPF_SUPPORT
> -#include <bpf/libbpf.h>
> -#include <util/llvm-utils.h>
> -#include "llvm.h"
> -static int test__bpf_parsing(void *obj_buf, size_t obj_buf_sz)
> -{
> -	struct bpf_object *obj;
> -
> -	obj = bpf_object__open_mem(obj_buf, obj_buf_sz, NULL);
> -	if (libbpf_get_error(obj))
> -		return TEST_FAIL;
> -	bpf_object__close(obj);
> -	return TEST_OK;
> -}
> -
> -static struct {
> -	const char *source;
> -	const char *desc;
> -	bool should_load_fail;
> -} bpf_source_table[__LLVM_TESTCASE_MAX] = {
> -	[LLVM_TESTCASE_BASE] = {
> -		.source = test_llvm__bpf_base_prog,
> -		.desc = "Basic BPF llvm compile",
> -	},
> -	[LLVM_TESTCASE_KBUILD] = {
> -		.source = test_llvm__bpf_test_kbuild_prog,
> -		.desc = "kbuild searching",
> -	},
> -	[LLVM_TESTCASE_BPF_PROLOGUE] = {
> -		.source = test_llvm__bpf_test_prologue_prog,
> -		.desc = "Compile source for BPF prologue generation",
> -	},
> -	[LLVM_TESTCASE_BPF_RELOCATION] = {
> -		.source = test_llvm__bpf_test_relocation,
> -		.desc = "Compile source for BPF relocation",
> -		.should_load_fail = true,
> -	},
> -};
> -
> -int
> -test_llvm__fetch_bpf_obj(void **p_obj_buf,
> -			 size_t *p_obj_buf_sz,
> -			 enum test_llvm__testcase idx,
> -			 bool force,
> -			 bool *should_load_fail)
> -{
> -	const char *source;
> -	const char *desc;
> -	const char *tmpl_old, *clang_opt_old;
> -	char *tmpl_new = NULL, *clang_opt_new = NULL;
> -	int err, old_verbose, ret = TEST_FAIL;
> -
> -	if (idx >= __LLVM_TESTCASE_MAX)
> -		return TEST_FAIL;
> -
> -	source = bpf_source_table[idx].source;
> -	desc = bpf_source_table[idx].desc;
> -	if (should_load_fail)
> -		*should_load_fail = bpf_source_table[idx].should_load_fail;
> -
> -	/*
> -	 * Skip this test if user's .perfconfig doesn't set [llvm] section
> -	 * and clang is not found in $PATH
> -	 */
> -	if (!force && (!llvm_param.user_set_param &&
> -		       llvm__search_clang())) {
> -		pr_debug("No clang, skip this test\n");
> -		return TEST_SKIP;
> -	}
> -
> -	/*
> -	 * llvm is verbosity when error. Suppress all error output if
> -	 * not 'perf test -v'.
> -	 */
> -	old_verbose = verbose;
> -	if (verbose == 0)
> -		verbose = -1;
> -
> -	*p_obj_buf = NULL;
> -	*p_obj_buf_sz = 0;
> -
> -	if (!llvm_param.clang_bpf_cmd_template)
> -		goto out;
> -
> -	if (!llvm_param.clang_opt)
> -		llvm_param.clang_opt = strdup("");
> -
> -	err = asprintf(&tmpl_new, "echo '%s' | %s%s", source,
> -		       llvm_param.clang_bpf_cmd_template,
> -		       old_verbose ? "" : " 2>/dev/null");
> -	if (err < 0)
> -		goto out;
> -	err = asprintf(&clang_opt_new, "-xc %s", llvm_param.clang_opt);
> -	if (err < 0)
> -		goto out;
> -
> -	tmpl_old = llvm_param.clang_bpf_cmd_template;
> -	llvm_param.clang_bpf_cmd_template = tmpl_new;
> -	clang_opt_old = llvm_param.clang_opt;
> -	llvm_param.clang_opt = clang_opt_new;
> -
> -	err = llvm__compile_bpf("-", p_obj_buf, p_obj_buf_sz);
> -
> -	llvm_param.clang_bpf_cmd_template = tmpl_old;
> -	llvm_param.clang_opt = clang_opt_old;
> -
> -	verbose = old_verbose;
> -	if (err)
> -		goto out;
> -
> -	ret = TEST_OK;
> -out:
> -	free(tmpl_new);
> -	free(clang_opt_new);
> -	if (ret != TEST_OK)
> -		pr_debug("Failed to compile test case: '%s'\n", desc);
> -	return ret;
> -}
> -
> -static int test__llvm(int subtest)
> -{
> -	int ret;
> -	void *obj_buf = NULL;
> -	size_t obj_buf_sz = 0;
> -	bool should_load_fail = false;
> -
> -	if ((subtest < 0) || (subtest >= __LLVM_TESTCASE_MAX))
> -		return TEST_FAIL;
> -
> -	ret = test_llvm__fetch_bpf_obj(&obj_buf, &obj_buf_sz,
> -				       subtest, false, &should_load_fail);
> -
> -	if (ret == TEST_OK && !should_load_fail) {
> -		ret = test__bpf_parsing(obj_buf, obj_buf_sz);
> -		if (ret != TEST_OK) {
> -			pr_debug("Failed to parse test case '%s'\n",
> -				 bpf_source_table[subtest].desc);
> -		}
> -	}
> -	free(obj_buf);
> -
> -	return ret;
> -}
> -#endif //HAVE_LIBBPF_SUPPORT
> -
> -static int test__llvm__bpf_base_prog(struct test_suite *test __maybe_unused,
> -				     int subtest __maybe_unused)
> -{
> -#ifdef HAVE_LIBBPF_SUPPORT
> -	return test__llvm(LLVM_TESTCASE_BASE);
> -#else
> -	pr_debug("Skip LLVM test because BPF support is not compiled\n");
> -	return TEST_SKIP;
> -#endif
> -}
> -
> -static int test__llvm__bpf_test_kbuild_prog(struct test_suite *test __maybe_unused,
> -					    int subtest __maybe_unused)
> -{
> -#ifdef HAVE_LIBBPF_SUPPORT
> -	return test__llvm(LLVM_TESTCASE_KBUILD);
> -#else
> -	pr_debug("Skip LLVM test because BPF support is not compiled\n");
> -	return TEST_SKIP;
> -#endif
> -}
> -
> -static int test__llvm__bpf_test_prologue_prog(struct test_suite *test __maybe_unused,
> -					      int subtest __maybe_unused)
> -{
> -#ifdef HAVE_LIBBPF_SUPPORT
> -	return test__llvm(LLVM_TESTCASE_BPF_PROLOGUE);
> -#else
> -	pr_debug("Skip LLVM test because BPF support is not compiled\n");
> -	return TEST_SKIP;
> -#endif
> -}
> -
> -static int test__llvm__bpf_test_relocation(struct test_suite *test __maybe_unused,
> -					   int subtest __maybe_unused)
> -{
> -#ifdef HAVE_LIBBPF_SUPPORT
> -	return test__llvm(LLVM_TESTCASE_BPF_RELOCATION);
> -#else
> -	pr_debug("Skip LLVM test because BPF support is not compiled\n");
> -	return TEST_SKIP;
> -#endif
> -}
> -
> -
> -static struct test_case llvm_tests[] = {
> -#ifdef HAVE_LIBBPF_SUPPORT
> -	TEST_CASE("Basic BPF llvm compile", llvm__bpf_base_prog),
> -	TEST_CASE("kbuild searching", llvm__bpf_test_kbuild_prog),
> -	TEST_CASE("Compile source for BPF prologue generation",
> -		  llvm__bpf_test_prologue_prog),
> -	TEST_CASE("Compile source for BPF relocation", llvm__bpf_test_relocation),
> -#else
> -	TEST_CASE_REASON("Basic BPF llvm compile", llvm__bpf_base_prog, "not compiled in"),
> -	TEST_CASE_REASON("kbuild searching", llvm__bpf_test_kbuild_prog, "not compiled in"),
> -	TEST_CASE_REASON("Compile source for BPF prologue generation",
> -			llvm__bpf_test_prologue_prog, "not compiled in"),
> -	TEST_CASE_REASON("Compile source for BPF relocation",
> -			llvm__bpf_test_relocation, "not compiled in"),
> -#endif
> -	{ .name = NULL, }
> -};
> -
> -struct test_suite suite__llvm = {
> -	.desc = "LLVM search and compile",
> -	.test_cases = llvm_tests,
> -};
> diff --git a/tools/perf/tests/llvm.h b/tools/perf/tests/llvm.h
> deleted file mode 100644
> index f68b0d9b8ae2..000000000000
> --- a/tools/perf/tests/llvm.h
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef PERF_TEST_LLVM_H
> -#define PERF_TEST_LLVM_H
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif
> -
> -#include <stddef.h> /* for size_t */
> -#include <stdbool.h> /* for bool */
> -
> -extern const char test_llvm__bpf_base_prog[];
> -extern const char test_llvm__bpf_test_kbuild_prog[];
> -extern const char test_llvm__bpf_test_prologue_prog[];
> -extern const char test_llvm__bpf_test_relocation[];
> -
> -enum test_llvm__testcase {
> -	LLVM_TESTCASE_BASE,
> -	LLVM_TESTCASE_KBUILD,
> -	LLVM_TESTCASE_BPF_PROLOGUE,
> -	LLVM_TESTCASE_BPF_RELOCATION,
> -	__LLVM_TESTCASE_MAX,
> -};
> -
> -int test_llvm__fetch_bpf_obj(void **p_obj_buf, size_t *p_obj_buf_sz,
> -			     enum test_llvm__testcase index, bool force,
> -			     bool *should_load_fail);
> -#ifdef __cplusplus
> -}
> -#endif
> -#endif
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 58cf96d762d0..220dd08c0560 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -95,7 +95,6 @@ make_with_babeltrace:= LIBBABELTRACE=1
>  make_with_coresight := CORESIGHT=1
>  make_no_sdt	    := NO_SDT=1
>  make_no_syscall_tbl := NO_SYSCALL_TABLE=1
> -make_with_clangllvm := LIBCLANGLLVM=1
>  make_no_libpfm4     := NO_LIBPFM4=1
>  make_with_gtk2      := GTK2=1
>  make_refcnt_check   := EXTRA_CFLAGS="-DREFCNT_CHECKING=1"
> @@ -163,7 +162,6 @@ run += make_no_sdt
>  run += make_no_syscall_tbl
>  run += make_with_babeltrace
>  run += make_with_coresight
> -run += make_with_clangllvm
>  run += make_no_libpfm4
>  run += make_refcnt_check
>  run += make_help
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index f424c0b7f43f..f33cfc3c19a4 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -113,7 +113,6 @@ DECLARE_SUITE(fdarray__filter);
>  DECLARE_SUITE(fdarray__add);
>  DECLARE_SUITE(kmod_path__parse);
>  DECLARE_SUITE(thread_map);
> -DECLARE_SUITE(llvm);
>  DECLARE_SUITE(bpf);
>  DECLARE_SUITE(session_topology);
>  DECLARE_SUITE(thread_map_synthesize);
> @@ -129,7 +128,6 @@ DECLARE_SUITE(sdt_event);
>  DECLARE_SUITE(is_printable_array);
>  DECLARE_SUITE(bitmap_print);
>  DECLARE_SUITE(perf_hooks);
> -DECLARE_SUITE(clang);
>  DECLARE_SUITE(unit_number__scnprint);
>  DECLARE_SUITE(mem2node);
>  DECLARE_SUITE(maps__merge_in);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index d487aec0b458..e7d2e780f9d2 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -22,7 +22,6 @@ perf-y += evswitch.o
>  perf-y += find_bit.o
>  perf-y += get_current_dir_name.o
>  perf-y += levenshtein.o
> -perf-y += llvm-utils.o
>  perf-y += mmap.o
>  perf-y += memswap.o
>  perf-y += parse-events.o
> @@ -149,7 +148,6 @@ perf-y += list_sort.o
>  perf-y += mutex.o
>  perf-y += sharded_mutex.o
>  
> -perf-$(CONFIG_LIBBPF) += bpf-loader.o
>  perf-$(CONFIG_LIBBPF) += bpf_map.o
>  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
>  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
> @@ -167,7 +165,6 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    perf-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork.o
>  endif
>  
> -perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
>  perf-$(CONFIG_LIBELF) += symbol-elf.o
>  perf-$(CONFIG_LIBELF) += probe-file.o
>  perf-$(CONFIG_LIBELF) += probe-event.o
> @@ -231,12 +228,9 @@ perf-y += perf-hooks.o
>  perf-$(CONFIG_LIBBPF) += bpf-event.o
>  perf-$(CONFIG_LIBBPF) += bpf-utils.o
>  
> -perf-$(CONFIG_CXX) += c++/
> -
>  perf-$(CONFIG_LIBPFM4) += pfm.o
>  
>  CFLAGS_config.o   += -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
> -CFLAGS_llvm-utils.o += -DLIBBPF_INCLUDE_DIR="BUILD_STR($(libbpf_include_dir_SQ))"
>  
>  # avoid compiler warnings in 32-bit mode
>  CFLAGS_genelf_debug.o  += -Wno-packed
> @@ -301,7 +295,7 @@ else
>    flex_flags := -w
>  endif
>  
> -CFLAGS_parse-events-flex.o  += $(flex_flags)
> +CFLAGS_parse-events-flex.o  += $(flex_flags) -Wno-unused-label
>  CFLAGS_pmu-flex.o           += $(flex_flags)
>  CFLAGS_expr-flex.o          += $(flex_flags)
>  CFLAGS_bpf-filter-flex.o    += $(flex_flags)
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> deleted file mode 100644
> index 50e42698cbb7..000000000000
> --- a/tools/perf/util/bpf-loader.c
> +++ /dev/null
> @@ -1,2006 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * bpf-loader.c
> - *
> - * Copyright (C) 2015 Wang Nan <wangnan0@huawei.com>
> - * Copyright (C) 2015 Huawei Inc.
> - */
> -
> -#include <linux/bpf.h>
> -#include <bpf/libbpf.h>
> -#include <bpf/bpf.h>
> -#include <linux/filter.h>
> -#include <linux/err.h>
> -#include <linux/kernel.h>
> -#include <linux/string.h>
> -#include <linux/zalloc.h>
> -#include <errno.h>
> -#include <stdlib.h>
> -#include "debug.h"
> -#include "evlist.h"
> -#include "bpf-loader.h"
> -#include "bpf-prologue.h"
> -#include "probe-event.h"
> -#include "probe-finder.h" // for MAX_PROBES
> -#include "parse-events.h"
> -#include "strfilter.h"
> -#include "util.h"
> -#include "llvm-utils.h"
> -#include "c++/clang-c.h"
> -#include "util/hashmap.h"
> -#include "asm/bug.h"
> -
> -#include <internal/xyarray.h>
> -
> -static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
> -			      const char *fmt, va_list args)
> -{
> -	return veprintf(1, verbose, pr_fmt(fmt), args);
> -}
> -
> -struct bpf_prog_priv {
> -	bool is_tp;
> -	char *sys_name;
> -	char *evt_name;
> -	struct perf_probe_event pev;
> -	bool need_prologue;
> -	struct bpf_insn *insns_buf;
> -	int nr_types;
> -	int *type_mapping;
> -	int *prologue_fds;
> -};
> -
> -struct bpf_perf_object {
> -	struct list_head list;
> -	struct bpf_object *obj;
> -};
> -
> -struct bpf_preproc_result {
> -	struct bpf_insn *new_insn_ptr;
> -	int new_insn_cnt;
> -};
> -
> -static LIST_HEAD(bpf_objects_list);
> -static struct hashmap *bpf_program_hash;
> -static struct hashmap *bpf_map_hash;
> -
> -static struct bpf_perf_object *
> -bpf_perf_object__next(struct bpf_perf_object *prev)
> -{
> -	if (!prev) {
> -		if (list_empty(&bpf_objects_list))
> -			return NULL;
> -
> -		return list_first_entry(&bpf_objects_list, struct bpf_perf_object, list);
> -	}
> -	if (list_is_last(&prev->list, &bpf_objects_list))
> -		return NULL;
> -
> -	return list_next_entry(prev, list);
> -}
> -
> -#define bpf_perf_object__for_each(perf_obj, tmp)	\
> -	for ((perf_obj) = bpf_perf_object__next(NULL),	\
> -	     (tmp) = bpf_perf_object__next(perf_obj);	\
> -	     (perf_obj) != NULL;			\
> -	     (perf_obj) = (tmp), (tmp) = bpf_perf_object__next(tmp))
> -
> -static bool libbpf_initialized;
> -static int libbpf_sec_handler;
> -
> -static int bpf_perf_object__add(struct bpf_object *obj)
> -{
> -	struct bpf_perf_object *perf_obj = zalloc(sizeof(*perf_obj));
> -
> -	if (perf_obj) {
> -		INIT_LIST_HEAD(&perf_obj->list);
> -		perf_obj->obj = obj;
> -		list_add_tail(&perf_obj->list, &bpf_objects_list);
> -	}
> -	return perf_obj ? 0 : -ENOMEM;
> -}
> -
> -static void *program_priv(const struct bpf_program *prog)
> -{
> -	void *priv;
> -
> -	if (IS_ERR_OR_NULL(bpf_program_hash))
> -		return NULL;
> -	if (!hashmap__find(bpf_program_hash, prog, &priv))
> -		return NULL;
> -	return priv;
> -}
> -
> -static struct bpf_insn prologue_init_insn[] = {
> -	BPF_MOV64_IMM(BPF_REG_2, 0),
> -	BPF_MOV64_IMM(BPF_REG_3, 0),
> -	BPF_MOV64_IMM(BPF_REG_4, 0),
> -	BPF_MOV64_IMM(BPF_REG_5, 0),
> -};
> -
> -static int libbpf_prog_prepare_load_fn(struct bpf_program *prog,
> -				       struct bpf_prog_load_opts *opts __maybe_unused,
> -				       long cookie __maybe_unused)
> -{
> -	size_t init_size_cnt = ARRAY_SIZE(prologue_init_insn);
> -	size_t orig_insn_cnt, insn_cnt, init_size, orig_size;
> -	struct bpf_prog_priv *priv = program_priv(prog);
> -	const struct bpf_insn *orig_insn;
> -	struct bpf_insn *insn;
> -
> -	if (IS_ERR_OR_NULL(priv)) {
> -		pr_debug("bpf: failed to get private field\n");
> -		return -BPF_LOADER_ERRNO__INTERNAL;
> -	}
> -
> -	if (!priv->need_prologue)
> -		return 0;
> -
> -	/* prepend initialization code to program instructions */
> -	orig_insn = bpf_program__insns(prog);
> -	orig_insn_cnt = bpf_program__insn_cnt(prog);
> -	init_size = init_size_cnt * sizeof(*insn);
> -	orig_size = orig_insn_cnt * sizeof(*insn);
> -
> -	insn_cnt = orig_insn_cnt + init_size_cnt;
> -	insn = malloc(insn_cnt * sizeof(*insn));
> -	if (!insn)
> -		return -ENOMEM;
> -
> -	memcpy(insn, prologue_init_insn, init_size);
> -	memcpy((char *) insn + init_size, orig_insn, orig_size);
> -	bpf_program__set_insns(prog, insn, insn_cnt);
> -	return 0;
> -}
> -
> -static int libbpf_init(void)
> -{
> -	LIBBPF_OPTS(libbpf_prog_handler_opts, handler_opts,
> -		.prog_prepare_load_fn = libbpf_prog_prepare_load_fn,
> -	);
> -
> -	if (libbpf_initialized)
> -		return 0;
> -
> -	libbpf_set_print(libbpf_perf_print);
> -	libbpf_sec_handler = libbpf_register_prog_handler(NULL, BPF_PROG_TYPE_KPROBE,
> -							  0, &handler_opts);
> -	if (libbpf_sec_handler < 0) {
> -		pr_debug("bpf: failed to register libbpf section handler: %d\n",
> -			 libbpf_sec_handler);
> -		return -BPF_LOADER_ERRNO__INTERNAL;
> -	}
> -	libbpf_initialized = true;
> -	return 0;
> -}
> -
> -struct bpf_object *
> -bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz, const char *name)
> -{
> -	LIBBPF_OPTS(bpf_object_open_opts, opts, .object_name = name);
> -	struct bpf_object *obj;
> -	int err;
> -
> -	err = libbpf_init();
> -	if (err)
> -		return ERR_PTR(err);
> -
> -	obj = bpf_object__open_mem(obj_buf, obj_buf_sz, &opts);
> -	if (IS_ERR_OR_NULL(obj)) {
> -		pr_debug("bpf: failed to load buffer\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> -	if (bpf_perf_object__add(obj)) {
> -		bpf_object__close(obj);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	return obj;
> -}
> -
> -static void bpf_perf_object__close(struct bpf_perf_object *perf_obj)
> -{
> -	list_del(&perf_obj->list);
> -	bpf_object__close(perf_obj->obj);
> -	free(perf_obj);
> -}
> -
> -struct bpf_object *bpf__prepare_load(const char *filename, bool source)
> -{
> -	LIBBPF_OPTS(bpf_object_open_opts, opts, .object_name = filename);
> -	struct bpf_object *obj;
> -	int err;
> -
> -	err = libbpf_init();
> -	if (err)
> -		return ERR_PTR(err);
> -
> -	if (source) {
> -		void *obj_buf;
> -		size_t obj_buf_sz;
> -
> -		perf_clang__init();
> -		err = perf_clang__compile_bpf(filename, &obj_buf, &obj_buf_sz);
> -		perf_clang__cleanup();
> -		if (err) {
> -			pr_debug("bpf: builtin compilation failed: %d, try external compiler\n", err);
> -			err = llvm__compile_bpf(filename, &obj_buf, &obj_buf_sz);
> -			if (err)
> -				return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
> -		} else
> -			pr_debug("bpf: successful builtin compilation\n");
> -		obj = bpf_object__open_mem(obj_buf, obj_buf_sz, &opts);
> -
> -		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
> -			llvm__dump_obj(filename, obj_buf, obj_buf_sz);
> -
> -		free(obj_buf);
> -	} else {
> -		obj = bpf_object__open(filename);
> -	}
> -
> -	if (IS_ERR_OR_NULL(obj)) {
> -		pr_debug("bpf: failed to load %s\n", filename);
> -		return obj;
> -	}
> -
> -	if (bpf_perf_object__add(obj)) {
> -		bpf_object__close(obj);
> -		return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
> -	}
> -
> -	return obj;
> -}
> -
> -static void close_prologue_programs(struct bpf_prog_priv *priv)
> -{
> -	struct perf_probe_event *pev;
> -	int i, fd;
> -
> -	if (!priv->need_prologue)
> -		return;
> -	pev = &priv->pev;
> -	for (i = 0; i < pev->ntevs; i++) {
> -		fd = priv->prologue_fds[i];
> -		if (fd != -1)
> -			close(fd);
> -	}
> -}
> -
> -static void
> -clear_prog_priv(const struct bpf_program *prog __maybe_unused,
> -		void *_priv)
> -{
> -	struct bpf_prog_priv *priv = _priv;
> -
> -	close_prologue_programs(priv);
> -	cleanup_perf_probe_events(&priv->pev, 1);
> -	zfree(&priv->insns_buf);
> -	zfree(&priv->prologue_fds);
> -	zfree(&priv->type_mapping);
> -	zfree(&priv->sys_name);
> -	zfree(&priv->evt_name);
> -	free(priv);
> -}
> -
> -static void bpf_program_hash_free(void)
> -{
> -	struct hashmap_entry *cur;
> -	size_t bkt;
> -
> -	if (IS_ERR_OR_NULL(bpf_program_hash))
> -		return;
> -
> -	hashmap__for_each_entry(bpf_program_hash, cur, bkt)
> -		clear_prog_priv(cur->pkey, cur->pvalue);
> -
> -	hashmap__free(bpf_program_hash);
> -	bpf_program_hash = NULL;
> -}
> -
> -static void bpf_map_hash_free(void);
> -
> -void bpf__clear(void)
> -{
> -	struct bpf_perf_object *perf_obj, *tmp;
> -
> -	bpf_perf_object__for_each(perf_obj, tmp) {
> -		bpf__unprobe(perf_obj->obj);
> -		bpf_perf_object__close(perf_obj);
> -	}
> -
> -	bpf_program_hash_free();
> -	bpf_map_hash_free();
> -}
> -
> -static size_t ptr_hash(const long __key, void *ctx __maybe_unused)
> -{
> -	return __key;
> -}
> -
> -static bool ptr_equal(long key1, long key2, void *ctx __maybe_unused)
> -{
> -	return key1 == key2;
> -}
> -
> -static int program_set_priv(struct bpf_program *prog, void *priv)
> -{
> -	void *old_priv;
> -
> -	/*
> -	 * Should not happen, we warn about it in the
> -	 * caller function - config_bpf_program
> -	 */
> -	if (IS_ERR(bpf_program_hash))
> -		return PTR_ERR(bpf_program_hash);
> -
> -	if (!bpf_program_hash) {
> -		bpf_program_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
> -		if (IS_ERR(bpf_program_hash))
> -			return PTR_ERR(bpf_program_hash);
> -	}
> -
> -	old_priv = program_priv(prog);
> -	if (old_priv) {
> -		clear_prog_priv(prog, old_priv);
> -		return hashmap__set(bpf_program_hash, prog, priv, NULL, NULL);
> -	}
> -	return hashmap__add(bpf_program_hash, prog, priv);
> -}
> -
> -static int
> -prog_config__exec(const char *value, struct perf_probe_event *pev)
> -{
> -	pev->uprobes = true;
> -	pev->target = strdup(value);
> -	if (!pev->target)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
> -static int
> -prog_config__module(const char *value, struct perf_probe_event *pev)
> -{
> -	pev->uprobes = false;
> -	pev->target = strdup(value);
> -	if (!pev->target)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
> -static int
> -prog_config__bool(const char *value, bool *pbool, bool invert)
> -{
> -	int err;
> -	bool bool_value;
> -
> -	if (!pbool)
> -		return -EINVAL;
> -
> -	err = strtobool(value, &bool_value);
> -	if (err)
> -		return err;
> -
> -	*pbool = invert ? !bool_value : bool_value;
> -	return 0;
> -}
> -
> -static int
> -prog_config__inlines(const char *value,
> -		     struct perf_probe_event *pev __maybe_unused)
> -{
> -	return prog_config__bool(value, &probe_conf.no_inlines, true);
> -}
> -
> -static int
> -prog_config__force(const char *value,
> -		   struct perf_probe_event *pev __maybe_unused)
> -{
> -	return prog_config__bool(value, &probe_conf.force_add, false);
> -}
> -
> -static struct {
> -	const char *key;
> -	const char *usage;
> -	const char *desc;
> -	int (*func)(const char *, struct perf_probe_event *);
> -} bpf_prog_config_terms[] = {
> -	{
> -		.key	= "exec",
> -		.usage	= "exec=<full path of file>",
> -		.desc	= "Set uprobe target",
> -		.func	= prog_config__exec,
> -	},
> -	{
> -		.key	= "module",
> -		.usage	= "module=<module name>    ",
> -		.desc	= "Set kprobe module",
> -		.func	= prog_config__module,
> -	},
> -	{
> -		.key	= "inlines",
> -		.usage	= "inlines=[yes|no]        ",
> -		.desc	= "Probe at inline symbol",
> -		.func	= prog_config__inlines,
> -	},
> -	{
> -		.key	= "force",
> -		.usage	= "force=[yes|no]          ",
> -		.desc	= "Forcibly add events with existing name",
> -		.func	= prog_config__force,
> -	},
> -};
> -
> -static int
> -do_prog_config(const char *key, const char *value,
> -	       struct perf_probe_event *pev)
> -{
> -	unsigned int i;
> -
> -	pr_debug("config bpf program: %s=%s\n", key, value);
> -	for (i = 0; i < ARRAY_SIZE(bpf_prog_config_terms); i++)
> -		if (strcmp(key, bpf_prog_config_terms[i].key) == 0)
> -			return bpf_prog_config_terms[i].func(value, pev);
> -
> -	pr_debug("BPF: ERROR: invalid program config option: %s=%s\n",
> -		 key, value);
> -
> -	pr_debug("\nHint: Valid options are:\n");
> -	for (i = 0; i < ARRAY_SIZE(bpf_prog_config_terms); i++)
> -		pr_debug("\t%s:\t%s\n", bpf_prog_config_terms[i].usage,
> -			 bpf_prog_config_terms[i].desc);
> -	pr_debug("\n");
> -
> -	return -BPF_LOADER_ERRNO__PROGCONF_TERM;
> -}
> -
> -static const char *
> -parse_prog_config_kvpair(const char *config_str, struct perf_probe_event *pev)
> -{
> -	char *text = strdup(config_str);
> -	char *sep, *line;
> -	const char *main_str = NULL;
> -	int err = 0;
> -
> -	if (!text) {
> -		pr_debug("Not enough memory: dup config_str failed\n");
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	line = text;
> -	while ((sep = strchr(line, ';'))) {
> -		char *equ;
> -
> -		*sep = '\0';
> -		equ = strchr(line, '=');
> -		if (!equ) {
> -			pr_warning("WARNING: invalid config in BPF object: %s\n",
> -				   line);
> -			pr_warning("\tShould be 'key=value'.\n");
> -			goto nextline;
> -		}
> -		*equ = '\0';
> -
> -		err = do_prog_config(line, equ + 1, pev);
> -		if (err)
> -			break;
> -nextline:
> -		line = sep + 1;
> -	}
> -
> -	if (!err)
> -		main_str = config_str + (line - text);
> -	free(text);
> -
> -	return err ? ERR_PTR(err) : main_str;
> -}
> -
> -static int
> -parse_prog_config(const char *config_str, const char **p_main_str,
> -		  bool *is_tp, struct perf_probe_event *pev)
> -{
> -	int err;
> -	const char *main_str = parse_prog_config_kvpair(config_str, pev);
> -
> -	if (IS_ERR(main_str))
> -		return PTR_ERR(main_str);
> -
> -	*p_main_str = main_str;
> -	if (!strchr(main_str, '=')) {
> -		/* Is a tracepoint event? */
> -		const char *s = strchr(main_str, ':');
> -
> -		if (!s) {
> -			pr_debug("bpf: '%s' is not a valid tracepoint\n",
> -				 config_str);
> -			return -BPF_LOADER_ERRNO__CONFIG;
> -		}
> -
> -		*is_tp = true;
> -		return 0;
> -	}
> -
> -	*is_tp = false;
> -	err = parse_perf_probe_command(main_str, pev);
> -	if (err < 0) {
> -		pr_debug("bpf: '%s' is not a valid config string\n",
> -			 config_str);
> -		/* parse failed, don't need clear pev. */
> -		return -BPF_LOADER_ERRNO__CONFIG;
> -	}
> -	return 0;
> -}
> -
> -static int
> -config_bpf_program(struct bpf_program *prog)
> -{
> -	struct perf_probe_event *pev = NULL;
> -	struct bpf_prog_priv *priv = NULL;
> -	const char *config_str, *main_str;
> -	bool is_tp = false;
> -	int err;
> -
> -	/* Initialize per-program probing setting */
> -	probe_conf.no_inlines = false;
> -	probe_conf.force_add = false;
> -
> -	priv = calloc(sizeof(*priv), 1);
> -	if (!priv) {
> -		pr_debug("bpf: failed to alloc priv\n");
> -		return -ENOMEM;
> -	}
> -	pev = &priv->pev;
> -
> -	config_str = bpf_program__section_name(prog);
> -	pr_debug("bpf: config program '%s'\n", config_str);
> -	err = parse_prog_config(config_str, &main_str, &is_tp, pev);
> -	if (err)
> -		goto errout;
> -
> -	if (is_tp) {
> -		char *s = strchr(main_str, ':');
> -
> -		priv->is_tp = true;
> -		priv->sys_name = strndup(main_str, s - main_str);
> -		priv->evt_name = strdup(s + 1);
> -		goto set_priv;
> -	}
> -
> -	if (pev->group && strcmp(pev->group, PERF_BPF_PROBE_GROUP)) {
> -		pr_debug("bpf: '%s': group for event is set and not '%s'.\n",
> -			 config_str, PERF_BPF_PROBE_GROUP);
> -		err = -BPF_LOADER_ERRNO__GROUP;
> -		goto errout;
> -	} else if (!pev->group)
> -		pev->group = strdup(PERF_BPF_PROBE_GROUP);
> -
> -	if (!pev->group) {
> -		pr_debug("bpf: strdup failed\n");
> -		err = -ENOMEM;
> -		goto errout;
> -	}
> -
> -	if (!pev->event) {
> -		pr_debug("bpf: '%s': event name is missing. Section name should be 'key=value'\n",
> -			 config_str);
> -		err = -BPF_LOADER_ERRNO__EVENTNAME;
> -		goto errout;
> -	}
> -	pr_debug("bpf: config '%s' is ok\n", config_str);
> -
> -set_priv:
> -	err = program_set_priv(prog, priv);
> -	if (err) {
> -		pr_debug("Failed to set priv for program '%s'\n", config_str);
> -		goto errout;
> -	}
> -
> -	return 0;
> -
> -errout:
> -	if (pev)
> -		clear_perf_probe_event(pev);
> -	free(priv);
> -	return err;
> -}
> -
> -static int bpf__prepare_probe(void)
> -{
> -	static int err = 0;
> -	static bool initialized = false;
> -
> -	/*
> -	 * Make err static, so if init failed the first, bpf__prepare_probe()
> -	 * fails each time without calling init_probe_symbol_maps multiple
> -	 * times.
> -	 */
> -	if (initialized)
> -		return err;
> -
> -	initialized = true;
> -	err = init_probe_symbol_maps(false);
> -	if (err < 0)
> -		pr_debug("Failed to init_probe_symbol_maps\n");
> -	probe_conf.max_probes = MAX_PROBES;
> -	return err;
> -}
> -
> -static int
> -preproc_gen_prologue(struct bpf_program *prog, int n,
> -		     const struct bpf_insn *orig_insns, int orig_insns_cnt,
> -		     struct bpf_preproc_result *res)
> -{
> -	struct bpf_prog_priv *priv = program_priv(prog);
> -	struct probe_trace_event *tev;
> -	struct perf_probe_event *pev;
> -	struct bpf_insn *buf;
> -	size_t prologue_cnt = 0;
> -	int i, err;
> -
> -	if (IS_ERR_OR_NULL(priv) || priv->is_tp)
> -		goto errout;
> -
> -	pev = &priv->pev;
> -
> -	if (n < 0 || n >= priv->nr_types)
> -		goto errout;
> -
> -	/* Find a tev belongs to that type */
> -	for (i = 0; i < pev->ntevs; i++) {
> -		if (priv->type_mapping[i] == n)
> -			break;
> -	}
> -
> -	if (i >= pev->ntevs) {
> -		pr_debug("Internal error: prologue type %d not found\n", n);
> -		return -BPF_LOADER_ERRNO__PROLOGUE;
> -	}
> -
> -	tev = &pev->tevs[i];
> -
> -	buf = priv->insns_buf;
> -	err = bpf__gen_prologue(tev->args, tev->nargs,
> -				buf, &prologue_cnt,
> -				BPF_MAXINSNS - orig_insns_cnt);
> -	if (err) {
> -		const char *title;
> -
> -		title = bpf_program__section_name(prog);
> -		pr_debug("Failed to generate prologue for program %s\n",
> -			 title);
> -		return err;
> -	}
> -
> -	memcpy(&buf[prologue_cnt], orig_insns,
> -	       sizeof(struct bpf_insn) * orig_insns_cnt);
> -
> -	res->new_insn_ptr = buf;
> -	res->new_insn_cnt = prologue_cnt + orig_insns_cnt;
> -	return 0;
> -
> -errout:
> -	pr_debug("Internal error in preproc_gen_prologue\n");
> -	return -BPF_LOADER_ERRNO__PROLOGUE;
> -}
> -
> -/*
> - * compare_tev_args is reflexive, transitive and antisymmetric.
> - * I can proof it but this margin is too narrow to contain.
> - */
> -static int compare_tev_args(const void *ptev1, const void *ptev2)
> -{
> -	int i, ret;
> -	const struct probe_trace_event *tev1 =
> -		*(const struct probe_trace_event **)ptev1;
> -	const struct probe_trace_event *tev2 =
> -		*(const struct probe_trace_event **)ptev2;
> -
> -	ret = tev2->nargs - tev1->nargs;
> -	if (ret)
> -		return ret;
> -
> -	for (i = 0; i < tev1->nargs; i++) {
> -		struct probe_trace_arg *arg1, *arg2;
> -		struct probe_trace_arg_ref *ref1, *ref2;
> -
> -		arg1 = &tev1->args[i];
> -		arg2 = &tev2->args[i];
> -
> -		ret = strcmp(arg1->value, arg2->value);
> -		if (ret)
> -			return ret;
> -
> -		ref1 = arg1->ref;
> -		ref2 = arg2->ref;
> -
> -		while (ref1 && ref2) {
> -			ret = ref2->offset - ref1->offset;
> -			if (ret)
> -				return ret;
> -
> -			ref1 = ref1->next;
> -			ref2 = ref2->next;
> -		}
> -
> -		if (ref1 || ref2)
> -			return ref2 ? 1 : -1;
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * Assign a type number to each tevs in a pev.
> - * mapping is an array with same slots as tevs in that pev.
> - * nr_types will be set to number of types.
> - */
> -static int map_prologue(struct perf_probe_event *pev, int *mapping,
> -			int *nr_types)
> -{
> -	int i, type = 0;
> -	struct probe_trace_event **ptevs;
> -
> -	size_t array_sz = sizeof(*ptevs) * pev->ntevs;
> -
> -	ptevs = malloc(array_sz);
> -	if (!ptevs) {
> -		pr_debug("Not enough memory: alloc ptevs failed\n");
> -		return -ENOMEM;
> -	}
> -
> -	pr_debug("In map_prologue, ntevs=%d\n", pev->ntevs);
> -	for (i = 0; i < pev->ntevs; i++)
> -		ptevs[i] = &pev->tevs[i];
> -
> -	qsort(ptevs, pev->ntevs, sizeof(*ptevs),
> -	      compare_tev_args);
> -
> -	for (i = 0; i < pev->ntevs; i++) {
> -		int n;
> -
> -		n = ptevs[i] - pev->tevs;
> -		if (i == 0) {
> -			mapping[n] = type;
> -			pr_debug("mapping[%d]=%d\n", n, type);
> -			continue;
> -		}
> -
> -		if (compare_tev_args(ptevs + i, ptevs + i - 1) == 0)
> -			mapping[n] = type;
> -		else
> -			mapping[n] = ++type;
> -
> -		pr_debug("mapping[%d]=%d\n", n, mapping[n]);
> -	}
> -	free(ptevs);
> -	*nr_types = type + 1;
> -
> -	return 0;
> -}
> -
> -static int hook_load_preprocessor(struct bpf_program *prog)
> -{
> -	struct bpf_prog_priv *priv = program_priv(prog);
> -	struct perf_probe_event *pev;
> -	bool need_prologue = false;
> -	int i;
> -
> -	if (IS_ERR_OR_NULL(priv)) {
> -		pr_debug("Internal error when hook preprocessor\n");
> -		return -BPF_LOADER_ERRNO__INTERNAL;
> -	}
> -
> -	if (priv->is_tp) {
> -		priv->need_prologue = false;
> -		return 0;
> -	}
> -
> -	pev = &priv->pev;
> -	for (i = 0; i < pev->ntevs; i++) {
> -		struct probe_trace_event *tev = &pev->tevs[i];
> -
> -		if (tev->nargs > 0) {
> -			need_prologue = true;
> -			break;
> -		}
> -	}
> -
> -	/*
> -	 * Since all tevs don't have argument, we don't need generate
> -	 * prologue.
> -	 */
> -	if (!need_prologue) {
> -		priv->need_prologue = false;
> -		return 0;
> -	}
> -
> -	priv->need_prologue = true;
> -	priv->insns_buf = malloc(sizeof(struct bpf_insn) * BPF_MAXINSNS);
> -	if (!priv->insns_buf) {
> -		pr_debug("Not enough memory: alloc insns_buf failed\n");
> -		return -ENOMEM;
> -	}
> -
> -	priv->prologue_fds = malloc(sizeof(int) * pev->ntevs);
> -	if (!priv->prologue_fds) {
> -		pr_debug("Not enough memory: alloc prologue fds failed\n");
> -		return -ENOMEM;
> -	}
> -	memset(priv->prologue_fds, -1, sizeof(int) * pev->ntevs);
> -
> -	priv->type_mapping = malloc(sizeof(int) * pev->ntevs);
> -	if (!priv->type_mapping) {
> -		pr_debug("Not enough memory: alloc type_mapping failed\n");
> -		return -ENOMEM;
> -	}
> -	memset(priv->type_mapping, -1,
> -	       sizeof(int) * pev->ntevs);
> -
> -	return map_prologue(pev, priv->type_mapping, &priv->nr_types);
> -}
> -
> -int bpf__probe(struct bpf_object *obj)
> -{
> -	int err = 0;
> -	struct bpf_program *prog;
> -	struct bpf_prog_priv *priv;
> -	struct perf_probe_event *pev;
> -
> -	err = bpf__prepare_probe();
> -	if (err) {
> -		pr_debug("bpf__prepare_probe failed\n");
> -		return err;
> -	}
> -
> -	bpf_object__for_each_program(prog, obj) {
> -		err = config_bpf_program(prog);
> -		if (err)
> -			goto out;
> -
> -		priv = program_priv(prog);
> -		if (IS_ERR_OR_NULL(priv)) {
> -			if (!priv)
> -				err = -BPF_LOADER_ERRNO__INTERNAL;
> -			else
> -				err = PTR_ERR(priv);
> -			goto out;
> -		}
> -
> -		if (priv->is_tp) {
> -			bpf_program__set_type(prog, BPF_PROG_TYPE_TRACEPOINT);
> -			continue;
> -		}
> -
> -		bpf_program__set_type(prog, BPF_PROG_TYPE_KPROBE);
> -		pev = &priv->pev;
> -
> -		err = convert_perf_probe_events(pev, 1);
> -		if (err < 0) {
> -			pr_debug("bpf_probe: failed to convert perf probe events\n");
> -			goto out;
> -		}
> -
> -		err = apply_perf_probe_events(pev, 1);
> -		if (err < 0) {
> -			pr_debug("bpf_probe: failed to apply perf probe events\n");
> -			goto out;
> -		}
> -
> -		/*
> -		 * After probing, let's consider prologue, which
> -		 * adds program fetcher to BPF programs.
> -		 *
> -		 * hook_load_preprocessor() hooks pre-processor
> -		 * to bpf_program, let it generate prologue
> -		 * dynamically during loading.
> -		 */
> -		err = hook_load_preprocessor(prog);
> -		if (err)
> -			goto out;
> -	}
> -out:
> -	return err < 0 ? err : 0;
> -}
> -
> -#define EVENTS_WRITE_BUFSIZE  4096
> -int bpf__unprobe(struct bpf_object *obj)
> -{
> -	int err, ret = 0;
> -	struct bpf_program *prog;
> -
> -	bpf_object__for_each_program(prog, obj) {
> -		struct bpf_prog_priv *priv = program_priv(prog);
> -		int i;
> -
> -		if (IS_ERR_OR_NULL(priv) || priv->is_tp)
> -			continue;
> -
> -		for (i = 0; i < priv->pev.ntevs; i++) {
> -			struct probe_trace_event *tev = &priv->pev.tevs[i];
> -			char name_buf[EVENTS_WRITE_BUFSIZE];
> -			struct strfilter *delfilter;
> -
> -			snprintf(name_buf, EVENTS_WRITE_BUFSIZE,
> -				 "%s:%s", tev->group, tev->event);
> -			name_buf[EVENTS_WRITE_BUFSIZE - 1] = '\0';
> -
> -			delfilter = strfilter__new(name_buf, NULL);
> -			if (!delfilter) {
> -				pr_debug("Failed to create filter for unprobing\n");
> -				ret = -ENOMEM;
> -				continue;
> -			}
> -
> -			err = del_perf_probe_events(delfilter);
> -			strfilter__delete(delfilter);
> -			if (err) {
> -				pr_debug("Failed to delete %s\n", name_buf);
> -				ret = err;
> -				continue;
> -			}
> -		}
> -	}
> -	return ret;
> -}
> -
> -static int bpf_object__load_prologue(struct bpf_object *obj)
> -{
> -	int init_cnt = ARRAY_SIZE(prologue_init_insn);
> -	const struct bpf_insn *orig_insns;
> -	struct bpf_preproc_result res;
> -	struct perf_probe_event *pev;
> -	struct bpf_program *prog;
> -	int orig_insns_cnt;
> -
> -	bpf_object__for_each_program(prog, obj) {
> -		struct bpf_prog_priv *priv = program_priv(prog);
> -		int err, i, fd;
> -
> -		if (IS_ERR_OR_NULL(priv)) {
> -			pr_debug("bpf: failed to get private field\n");
> -			return -BPF_LOADER_ERRNO__INTERNAL;
> -		}
> -
> -		if (!priv->need_prologue)
> -			continue;
> -
> -		/*
> -		 * For each program that needs prologue we do following:
> -		 *
> -		 * - take its current instructions and use them
> -		 *   to generate the new code with prologue
> -		 * - load new instructions with bpf_prog_load
> -		 *   and keep the fd in prologue_fds
> -		 * - new fd will be used in bpf__foreach_event
> -		 *   to connect this program with perf evsel
> -		 */
> -		orig_insns = bpf_program__insns(prog);
> -		orig_insns_cnt = bpf_program__insn_cnt(prog);
> -
> -		pev = &priv->pev;
> -		for (i = 0; i < pev->ntevs; i++) {
> -			/*
> -			 * Skipping artificall prologue_init_insn instructions
> -			 * (init_cnt), so the prologue can be generated instead
> -			 * of them.
> -			 */
> -			err = preproc_gen_prologue(prog, i,
> -						   orig_insns + init_cnt,
> -						   orig_insns_cnt - init_cnt,
> -						   &res);
> -			if (err)
> -				return err;
> -
> -			fd = bpf_prog_load(bpf_program__get_type(prog),
> -					   bpf_program__name(prog), "GPL",
> -					   res.new_insn_ptr,
> -					   res.new_insn_cnt, NULL);
> -			if (fd < 0) {
> -				char bf[128];
> -
> -				libbpf_strerror(-errno, bf, sizeof(bf));
> -				pr_debug("bpf: load objects with prologue failed: err=%d: (%s)\n",
> -					 -errno, bf);
> -				return -errno;
> -			}
> -			priv->prologue_fds[i] = fd;
> -		}
> -		/*
> -		 * We no longer need the original program,
> -		 * we can unload it.
> -		 */
> -		bpf_program__unload(prog);
> -	}
> -	return 0;
> -}
> -
> -int bpf__load(struct bpf_object *obj)
> -{
> -	int err;
> -
> -	err = bpf_object__load(obj);
> -	if (err) {
> -		char bf[128];
> -		libbpf_strerror(err, bf, sizeof(bf));
> -		pr_debug("bpf: load objects failed: err=%d: (%s)\n", err, bf);
> -		return err;
> -	}
> -	return bpf_object__load_prologue(obj);
> -}
> -
> -int bpf__foreach_event(struct bpf_object *obj,
> -		       bpf_prog_iter_callback_t func,
> -		       void *arg)
> -{
> -	struct bpf_program *prog;
> -	int err;
> -
> -	bpf_object__for_each_program(prog, obj) {
> -		struct bpf_prog_priv *priv = program_priv(prog);
> -		struct probe_trace_event *tev;
> -		struct perf_probe_event *pev;
> -		int i, fd;
> -
> -		if (IS_ERR_OR_NULL(priv)) {
> -			pr_debug("bpf: failed to get private field\n");
> -			return -BPF_LOADER_ERRNO__INTERNAL;
> -		}
> -
> -		if (priv->is_tp) {
> -			fd = bpf_program__fd(prog);
> -			err = (*func)(priv->sys_name, priv->evt_name, fd, obj, arg);
> -			if (err) {
> -				pr_debug("bpf: tracepoint call back failed, stop iterate\n");
> -				return err;
> -			}
> -			continue;
> -		}
> -
> -		pev = &priv->pev;
> -		for (i = 0; i < pev->ntevs; i++) {
> -			tev = &pev->tevs[i];
> -
> -			if (priv->need_prologue)
> -				fd = priv->prologue_fds[i];
> -			else
> -				fd = bpf_program__fd(prog);
> -
> -			if (fd < 0) {
> -				pr_debug("bpf: failed to get file descriptor\n");
> -				return fd;
> -			}
> -
> -			err = (*func)(tev->group, tev->event, fd, obj, arg);
> -			if (err) {
> -				pr_debug("bpf: call back failed, stop iterate\n");
> -				return err;
> -			}
> -		}
> -	}
> -	return 0;
> -}
> -
> -enum bpf_map_op_type {
> -	BPF_MAP_OP_SET_VALUE,
> -	BPF_MAP_OP_SET_EVSEL,
> -};
> -
> -enum bpf_map_key_type {
> -	BPF_MAP_KEY_ALL,
> -};
> -
> -struct bpf_map_op {
> -	struct list_head list;
> -	enum bpf_map_op_type op_type;
> -	enum bpf_map_key_type key_type;
> -	union {
> -		u64 value;
> -		struct evsel *evsel;
> -	} v;
> -};
> -
> -struct bpf_map_priv {
> -	struct list_head ops_list;
> -};
> -
> -static void
> -bpf_map_op__delete(struct bpf_map_op *op)
> -{
> -	if (!list_empty(&op->list))
> -		list_del_init(&op->list);
> -	free(op);
> -}
> -
> -static void
> -bpf_map_priv__purge(struct bpf_map_priv *priv)
> -{
> -	struct bpf_map_op *pos, *n;
> -
> -	list_for_each_entry_safe(pos, n, &priv->ops_list, list) {
> -		list_del_init(&pos->list);
> -		bpf_map_op__delete(pos);
> -	}
> -}
> -
> -static void
> -bpf_map_priv__clear(const struct bpf_map *map __maybe_unused,
> -		    void *_priv)
> -{
> -	struct bpf_map_priv *priv = _priv;
> -
> -	bpf_map_priv__purge(priv);
> -	free(priv);
> -}
> -
> -static void *map_priv(const struct bpf_map *map)
> -{
> -	void *priv;
> -
> -	if (IS_ERR_OR_NULL(bpf_map_hash))
> -		return NULL;
> -	if (!hashmap__find(bpf_map_hash, map, &priv))
> -		return NULL;
> -	return priv;
> -}
> -
> -static void bpf_map_hash_free(void)
> -{
> -	struct hashmap_entry *cur;
> -	size_t bkt;
> -
> -	if (IS_ERR_OR_NULL(bpf_map_hash))
> -		return;
> -
> -	hashmap__for_each_entry(bpf_map_hash, cur, bkt)
> -		bpf_map_priv__clear(cur->pkey, cur->pvalue);
> -
> -	hashmap__free(bpf_map_hash);
> -	bpf_map_hash = NULL;
> -}
> -
> -static int map_set_priv(struct bpf_map *map, void *priv)
> -{
> -	void *old_priv;
> -
> -	if (WARN_ON_ONCE(IS_ERR(bpf_map_hash)))
> -		return PTR_ERR(bpf_program_hash);
> -
> -	if (!bpf_map_hash) {
> -		bpf_map_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
> -		if (IS_ERR(bpf_map_hash))
> -			return PTR_ERR(bpf_map_hash);
> -	}
> -
> -	old_priv = map_priv(map);
> -	if (old_priv) {
> -		bpf_map_priv__clear(map, old_priv);
> -		return hashmap__set(bpf_map_hash, map, priv, NULL, NULL);
> -	}
> -	return hashmap__add(bpf_map_hash, map, priv);
> -}
> -
> -static int
> -bpf_map_op_setkey(struct bpf_map_op *op, struct parse_events_term *term)
> -{
> -	op->key_type = BPF_MAP_KEY_ALL;
> -	if (!term)
> -		return 0;
> -
> -	return 0;
> -}
> -
> -static struct bpf_map_op *
> -bpf_map_op__new(struct parse_events_term *term)
> -{
> -	struct bpf_map_op *op;
> -	int err;
> -
> -	op = zalloc(sizeof(*op));
> -	if (!op) {
> -		pr_debug("Failed to alloc bpf_map_op\n");
> -		return ERR_PTR(-ENOMEM);
> -	}
> -	INIT_LIST_HEAD(&op->list);
> -
> -	err = bpf_map_op_setkey(op, term);
> -	if (err) {
> -		free(op);
> -		return ERR_PTR(err);
> -	}
> -	return op;
> -}
> -
> -static struct bpf_map_op *
> -bpf_map_op__clone(struct bpf_map_op *op)
> -{
> -	struct bpf_map_op *newop;
> -
> -	newop = memdup(op, sizeof(*op));
> -	if (!newop) {
> -		pr_debug("Failed to alloc bpf_map_op\n");
> -		return NULL;
> -	}
> -
> -	INIT_LIST_HEAD(&newop->list);
> -	return newop;
> -}
> -
> -static struct bpf_map_priv *
> -bpf_map_priv__clone(struct bpf_map_priv *priv)
> -{
> -	struct bpf_map_priv *newpriv;
> -	struct bpf_map_op *pos, *newop;
> -
> -	newpriv = zalloc(sizeof(*newpriv));
> -	if (!newpriv) {
> -		pr_debug("Not enough memory to alloc map private\n");
> -		return NULL;
> -	}
> -	INIT_LIST_HEAD(&newpriv->ops_list);
> -
> -	list_for_each_entry(pos, &priv->ops_list, list) {
> -		newop = bpf_map_op__clone(pos);
> -		if (!newop) {
> -			bpf_map_priv__purge(newpriv);
> -			return NULL;
> -		}
> -		list_add_tail(&newop->list, &newpriv->ops_list);
> -	}
> -
> -	return newpriv;
> -}
> -
> -static int
> -bpf_map__add_op(struct bpf_map *map, struct bpf_map_op *op)
> -{
> -	const char *map_name = bpf_map__name(map);
> -	struct bpf_map_priv *priv = map_priv(map);
> -
> -	if (IS_ERR(priv)) {
> -		pr_debug("Failed to get private from map %s\n", map_name);
> -		return PTR_ERR(priv);
> -	}
> -
> -	if (!priv) {
> -		priv = zalloc(sizeof(*priv));
> -		if (!priv) {
> -			pr_debug("Not enough memory to alloc map private\n");
> -			return -ENOMEM;
> -		}
> -		INIT_LIST_HEAD(&priv->ops_list);
> -
> -		if (map_set_priv(map, priv)) {
> -			free(priv);
> -			return -BPF_LOADER_ERRNO__INTERNAL;
> -		}
> -	}
> -
> -	list_add_tail(&op->list, &priv->ops_list);
> -	return 0;
> -}
> -
> -static struct bpf_map_op *
> -bpf_map__add_newop(struct bpf_map *map, struct parse_events_term *term)
> -{
> -	struct bpf_map_op *op;
> -	int err;
> -
> -	op = bpf_map_op__new(term);
> -	if (IS_ERR(op))
> -		return op;
> -
> -	err = bpf_map__add_op(map, op);
> -	if (err) {
> -		bpf_map_op__delete(op);
> -		return ERR_PTR(err);
> -	}
> -	return op;
> -}
> -
> -static int
> -__bpf_map__config_value(struct bpf_map *map,
> -			struct parse_events_term *term)
> -{
> -	struct bpf_map_op *op;
> -	const char *map_name = bpf_map__name(map);
> -
> -	if (!map) {
> -		pr_debug("Map '%s' is invalid\n", map_name);
> -		return -BPF_LOADER_ERRNO__INTERNAL;
> -	}
> -
> -	if (bpf_map__type(map) != BPF_MAP_TYPE_ARRAY) {
> -		pr_debug("Map %s type is not BPF_MAP_TYPE_ARRAY\n",
> -			 map_name);
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_TYPE;
> -	}
> -	if (bpf_map__key_size(map) < sizeof(unsigned int)) {
> -		pr_debug("Map %s has incorrect key size\n", map_name);
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_KEYSIZE;
> -	}
> -	switch (bpf_map__value_size(map)) {
> -	case 1:
> -	case 2:
> -	case 4:
> -	case 8:
> -		break;
> -	default:
> -		pr_debug("Map %s has incorrect value size\n", map_name);
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_VALUESIZE;
> -	}
> -
> -	op = bpf_map__add_newop(map, term);
> -	if (IS_ERR(op))
> -		return PTR_ERR(op);
> -	op->op_type = BPF_MAP_OP_SET_VALUE;
> -	op->v.value = term->val.num;
> -	return 0;
> -}
> -
> -static int
> -bpf_map__config_value(struct bpf_map *map,
> -		      struct parse_events_term *term,
> -		      struct evlist *evlist __maybe_unused)
> -{
> -	if (!term->err_val) {
> -		pr_debug("Config value not set\n");
> -		return -BPF_LOADER_ERRNO__OBJCONF_CONF;
> -	}
> -
> -	if (term->type_val != PARSE_EVENTS__TERM_TYPE_NUM) {
> -		pr_debug("ERROR: wrong value type for 'value'\n");
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_VALUE;
> -	}
> -
> -	return __bpf_map__config_value(map, term);
> -}
> -
> -static int
> -__bpf_map__config_event(struct bpf_map *map,
> -			struct parse_events_term *term,
> -			struct evlist *evlist)
> -{
> -	struct bpf_map_op *op;
> -	const char *map_name = bpf_map__name(map);
> -	struct evsel *evsel = evlist__find_evsel_by_str(evlist, term->val.str);
> -
> -	if (!evsel) {
> -		pr_debug("Event (for '%s') '%s' doesn't exist\n",
> -			 map_name, term->val.str);
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_NOEVT;
> -	}
> -
> -	if (!map) {
> -		pr_debug("Map '%s' is invalid\n", map_name);
> -		return PTR_ERR(map);
> -	}
> -
> -	/*
> -	 * No need to check key_size and value_size:
> -	 * kernel has already checked them.
> -	 */
> -	if (bpf_map__type(map) != BPF_MAP_TYPE_PERF_EVENT_ARRAY) {
> -		pr_debug("Map %s type is not BPF_MAP_TYPE_PERF_EVENT_ARRAY\n",
> -			 map_name);
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_TYPE;
> -	}
> -
> -	op = bpf_map__add_newop(map, term);
> -	if (IS_ERR(op))
> -		return PTR_ERR(op);
> -	op->op_type = BPF_MAP_OP_SET_EVSEL;
> -	op->v.evsel = evsel;
> -	return 0;
> -}
> -
> -static int
> -bpf_map__config_event(struct bpf_map *map,
> -		      struct parse_events_term *term,
> -		      struct evlist *evlist)
> -{
> -	if (!term->err_val) {
> -		pr_debug("Config value not set\n");
> -		return -BPF_LOADER_ERRNO__OBJCONF_CONF;
> -	}
> -
> -	if (term->type_val != PARSE_EVENTS__TERM_TYPE_STR) {
> -		pr_debug("ERROR: wrong value type for 'event'\n");
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_VALUE;
> -	}
> -
> -	return __bpf_map__config_event(map, term, evlist);
> -}
> -
> -struct bpf_obj_config__map_func {
> -	const char *config_opt;
> -	int (*config_func)(struct bpf_map *, struct parse_events_term *,
> -			   struct evlist *);
> -};
> -
> -struct bpf_obj_config__map_func bpf_obj_config__map_funcs[] = {
> -	{"value", bpf_map__config_value},
> -	{"event", bpf_map__config_event},
> -};
> -
> -static int
> -bpf__obj_config_map(struct bpf_object *obj,
> -		    struct parse_events_term *term,
> -		    struct evlist *evlist,
> -		    int *key_scan_pos)
> -{
> -	/* key is "map:<mapname>.<config opt>" */
> -	char *map_name = strdup(term->config + sizeof("map:") - 1);
> -	struct bpf_map *map;
> -	int err = -BPF_LOADER_ERRNO__OBJCONF_OPT;
> -	char *map_opt;
> -	size_t i;
> -
> -	if (!map_name)
> -		return -ENOMEM;
> -
> -	map_opt = strchr(map_name, '.');
> -	if (!map_opt) {
> -		pr_debug("ERROR: Invalid map config: %s\n", map_name);
> -		goto out;
> -	}
> -
> -	*map_opt++ = '\0';
> -	if (*map_opt == '\0') {
> -		pr_debug("ERROR: Invalid map option: %s\n", term->config);
> -		goto out;
> -	}
> -
> -	map = bpf_object__find_map_by_name(obj, map_name);
> -	if (!map) {
> -		pr_debug("ERROR: Map %s doesn't exist\n", map_name);
> -		err = -BPF_LOADER_ERRNO__OBJCONF_MAP_NOTEXIST;
> -		goto out;
> -	}
> -
> -	for (i = 0; i < ARRAY_SIZE(bpf_obj_config__map_funcs); i++) {
> -		struct bpf_obj_config__map_func *func =
> -				&bpf_obj_config__map_funcs[i];
> -
> -		if (strcmp(map_opt, func->config_opt) == 0) {
> -			err = func->config_func(map, term, evlist);
> -			goto out;
> -		}
> -	}
> -
> -	pr_debug("ERROR: Invalid map config option '%s'\n", map_opt);
> -	err = -BPF_LOADER_ERRNO__OBJCONF_MAP_OPT;
> -out:
> -	if (!err)
> -		*key_scan_pos += strlen(map_opt);
> -
> -	free(map_name);
> -	return err;
> -}
> -
> -int bpf__config_obj(struct bpf_object *obj,
> -		    struct parse_events_term *term,
> -		    struct evlist *evlist,
> -		    int *error_pos)
> -{
> -	int key_scan_pos = 0;
> -	int err;
> -
> -	if (!obj || !term || !term->config)
> -		return -EINVAL;
> -
> -	if (strstarts(term->config, "map:")) {
> -		key_scan_pos = sizeof("map:") - 1;
> -		err = bpf__obj_config_map(obj, term, evlist, &key_scan_pos);
> -		goto out;
> -	}
> -	err = -BPF_LOADER_ERRNO__OBJCONF_OPT;
> -out:
> -	if (error_pos)
> -		*error_pos = key_scan_pos;
> -	return err;
> -
> -}
> -
> -typedef int (*map_config_func_t)(const char *name, int map_fd,
> -				 const struct bpf_map *map,
> -				 struct bpf_map_op *op,
> -				 void *pkey, void *arg);
> -static int
> -foreach_key_array_all(map_config_func_t func,
> -		      void *arg, const char *name,
> -		      int map_fd, const struct bpf_map *map,
> -		      struct bpf_map_op *op)
> -{
> -	unsigned int i;
> -	int err;
> -
> -	for (i = 0; i < bpf_map__max_entries(map); i++) {
> -		err = func(name, map_fd, map, op, &i, arg);
> -		if (err) {
> -			pr_debug("ERROR: failed to insert value to %s[%u]\n",
> -				 name, i);
> -			return err;
> -		}
> -	}
> -	return 0;
> -}
> -
> -
> -static int
> -bpf_map_config_foreach_key(struct bpf_map *map,
> -			   map_config_func_t func,
> -			   void *arg)
> -{
> -	int err, map_fd, type;
> -	struct bpf_map_op *op;
> -	const char *name = bpf_map__name(map);
> -	struct bpf_map_priv *priv = map_priv(map);
> -
> -	if (IS_ERR(priv)) {
> -		pr_debug("ERROR: failed to get private from map %s\n", name);
> -		return -BPF_LOADER_ERRNO__INTERNAL;
> -	}
> -	if (!priv || list_empty(&priv->ops_list)) {
> -		pr_debug("INFO: nothing to config for map %s\n", name);
> -		return 0;
> -	}
> -
> -	if (!map) {
> -		pr_debug("Map '%s' is invalid\n", name);
> -		return -BPF_LOADER_ERRNO__INTERNAL;
> -	}
> -	map_fd = bpf_map__fd(map);
> -	if (map_fd < 0) {
> -		pr_debug("ERROR: failed to get fd from map %s\n", name);
> -		return map_fd;
> -	}
> -
> -	type = bpf_map__type(map);
> -	list_for_each_entry(op, &priv->ops_list, list) {
> -		switch (type) {
> -		case BPF_MAP_TYPE_ARRAY:
> -		case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
> -			switch (op->key_type) {
> -			case BPF_MAP_KEY_ALL:
> -				err = foreach_key_array_all(func, arg, name,
> -							    map_fd, map, op);
> -				break;
> -			default:
> -				pr_debug("ERROR: keytype for map '%s' invalid\n",
> -					 name);
> -				return -BPF_LOADER_ERRNO__INTERNAL;
> -			}
> -			if (err)
> -				return err;
> -			break;
> -		default:
> -			pr_debug("ERROR: type of '%s' incorrect\n", name);
> -			return -BPF_LOADER_ERRNO__OBJCONF_MAP_TYPE;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int
> -apply_config_value_for_key(int map_fd, void *pkey,
> -			   size_t val_size, u64 val)
> -{
> -	int err = 0;
> -
> -	switch (val_size) {
> -	case 1: {
> -		u8 _val = (u8)(val);
> -		err = bpf_map_update_elem(map_fd, pkey, &_val, BPF_ANY);
> -		break;
> -	}
> -	case 2: {
> -		u16 _val = (u16)(val);
> -		err = bpf_map_update_elem(map_fd, pkey, &_val, BPF_ANY);
> -		break;
> -	}
> -	case 4: {
> -		u32 _val = (u32)(val);
> -		err = bpf_map_update_elem(map_fd, pkey, &_val, BPF_ANY);
> -		break;
> -	}
> -	case 8: {
> -		err = bpf_map_update_elem(map_fd, pkey, &val, BPF_ANY);
> -		break;
> -	}
> -	default:
> -		pr_debug("ERROR: invalid value size\n");
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_VALUESIZE;
> -	}
> -	if (err && errno)
> -		err = -errno;
> -	return err;
> -}
> -
> -static int
> -apply_config_evsel_for_key(const char *name, int map_fd, void *pkey,
> -			   struct evsel *evsel)
> -{
> -	struct xyarray *xy = evsel->core.fd;
> -	struct perf_event_attr *attr;
> -	unsigned int key, events;
> -	bool check_pass = false;
> -	int *evt_fd;
> -	int err;
> -
> -	if (!xy) {
> -		pr_debug("ERROR: evsel not ready for map %s\n", name);
> -		return -BPF_LOADER_ERRNO__INTERNAL;
> -	}
> -
> -	if (xy->row_size / xy->entry_size != 1) {
> -		pr_debug("ERROR: Dimension of target event is incorrect for map %s\n",
> -			 name);
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_EVTDIM;
> -	}
> -
> -	attr = &evsel->core.attr;
> -	if (attr->inherit) {
> -		pr_debug("ERROR: Can't put inherit event into map %s\n", name);
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_EVTINH;
> -	}
> -
> -	if (evsel__is_bpf_output(evsel))
> -		check_pass = true;
> -	if (attr->type == PERF_TYPE_RAW)
> -		check_pass = true;
> -	if (attr->type == PERF_TYPE_HARDWARE)
> -		check_pass = true;
> -	if (!check_pass) {
> -		pr_debug("ERROR: Event type is wrong for map %s\n", name);
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_EVTTYPE;
> -	}
> -
> -	events = xy->entries / (xy->row_size / xy->entry_size);
> -	key = *((unsigned int *)pkey);
> -	if (key >= events) {
> -		pr_debug("ERROR: there is no event %d for map %s\n",
> -			 key, name);
> -		return -BPF_LOADER_ERRNO__OBJCONF_MAP_MAPSIZE;
> -	}
> -	evt_fd = xyarray__entry(xy, key, 0);
> -	err = bpf_map_update_elem(map_fd, pkey, evt_fd, BPF_ANY);
> -	if (err && errno)
> -		err = -errno;
> -	return err;
> -}
> -
> -static int
> -apply_obj_config_map_for_key(const char *name, int map_fd,
> -			     const struct bpf_map *map,
> -			     struct bpf_map_op *op,
> -			     void *pkey, void *arg __maybe_unused)
> -{
> -	int err;
> -
> -	switch (op->op_type) {
> -	case BPF_MAP_OP_SET_VALUE:
> -		err = apply_config_value_for_key(map_fd, pkey,
> -						 bpf_map__value_size(map),
> -						 op->v.value);
> -		break;
> -	case BPF_MAP_OP_SET_EVSEL:
> -		err = apply_config_evsel_for_key(name, map_fd, pkey,
> -						 op->v.evsel);
> -		break;
> -	default:
> -		pr_debug("ERROR: unknown value type for '%s'\n", name);
> -		err = -BPF_LOADER_ERRNO__INTERNAL;
> -	}
> -	return err;
> -}
> -
> -static int
> -apply_obj_config_map(struct bpf_map *map)
> -{
> -	return bpf_map_config_foreach_key(map,
> -					  apply_obj_config_map_for_key,
> -					  NULL);
> -}
> -
> -static int
> -apply_obj_config_object(struct bpf_object *obj)
> -{
> -	struct bpf_map *map;
> -	int err;
> -
> -	bpf_object__for_each_map(map, obj) {
> -		err = apply_obj_config_map(map);
> -		if (err)
> -			return err;
> -	}
> -	return 0;
> -}
> -
> -int bpf__apply_obj_config(void)
> -{
> -	struct bpf_perf_object *perf_obj, *tmp;
> -	int err;
> -
> -	bpf_perf_object__for_each(perf_obj, tmp) {
> -		err = apply_obj_config_object(perf_obj->obj);
> -		if (err)
> -			return err;
> -	}
> -
> -	return 0;
> -}
> -
> -#define bpf__perf_for_each_map(map, pobj, tmp)			\
> -	bpf_perf_object__for_each(pobj, tmp)			\
> -		bpf_object__for_each_map(map, pobj->obj)
> -
> -#define bpf__perf_for_each_map_named(map, pobj, pobjtmp, name)	\
> -	bpf__perf_for_each_map(map, pobj, pobjtmp)		\
> -		if (bpf_map__name(map) && (strcmp(name, bpf_map__name(map)) == 0))
> -
> -struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
> -{
> -	struct bpf_map_priv *tmpl_priv = NULL;
> -	struct bpf_perf_object *perf_obj, *tmp;
> -	struct evsel *evsel = NULL;
> -	struct bpf_map *map;
> -	int err;
> -	bool need_init = false;
> -
> -	bpf__perf_for_each_map_named(map, perf_obj, tmp, name) {
> -		struct bpf_map_priv *priv = map_priv(map);
> -
> -		if (IS_ERR(priv))
> -			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
> -
> -		/*
> -		 * No need to check map type: type should have been
> -		 * verified by kernel.
> -		 */
> -		if (!need_init && !priv)
> -			need_init = !priv;
> -		if (!tmpl_priv && priv)
> -			tmpl_priv = priv;
> -	}
> -
> -	if (!need_init)
> -		return NULL;
> -
> -	if (!tmpl_priv) {
> -		char *event_definition = NULL;
> -
> -		if (asprintf(&event_definition, "bpf-output/no-inherit=1,name=%s/", name) < 0)
> -			return ERR_PTR(-ENOMEM);
> -
> -		err = parse_event(evlist, event_definition);
> -		free(event_definition);
> -
> -		if (err) {
> -			pr_debug("ERROR: failed to create the \"%s\" bpf-output event\n", name);
> -			return ERR_PTR(-err);
> -		}
> -
> -		evsel = evlist__last(evlist);
> -	}
> -
> -	bpf__perf_for_each_map_named(map, perf_obj, tmp, name) {
> -		struct bpf_map_priv *priv = map_priv(map);
> -
> -		if (IS_ERR(priv))
> -			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
> -		if (priv)
> -			continue;
> -
> -		if (tmpl_priv) {
> -			priv = bpf_map_priv__clone(tmpl_priv);
> -			if (!priv)
> -				return ERR_PTR(-ENOMEM);
> -
> -			err = map_set_priv(map, priv);
> -			if (err) {
> -				bpf_map_priv__clear(map, priv);
> -				return ERR_PTR(err);
> -			}
> -		} else if (evsel) {
> -			struct bpf_map_op *op;
> -
> -			op = bpf_map__add_newop(map, NULL);
> -			if (IS_ERR(op))
> -				return ERR_CAST(op);
> -			op->op_type = BPF_MAP_OP_SET_EVSEL;
> -			op->v.evsel = evsel;
> -		}
> -	}
> -
> -	return evsel;
> -}
> -
> -int bpf__setup_stdout(struct evlist *evlist)
> -{
> -	struct evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
> -	return PTR_ERR_OR_ZERO(evsel);
> -}
> -
> -#define ERRNO_OFFSET(e)		((e) - __BPF_LOADER_ERRNO__START)
> -#define ERRCODE_OFFSET(c)	ERRNO_OFFSET(BPF_LOADER_ERRNO__##c)
> -#define NR_ERRNO	(__BPF_LOADER_ERRNO__END - __BPF_LOADER_ERRNO__START)
> -
> -static const char *bpf_loader_strerror_table[NR_ERRNO] = {
> -	[ERRCODE_OFFSET(CONFIG)]	= "Invalid config string",
> -	[ERRCODE_OFFSET(GROUP)]		= "Invalid group name",
> -	[ERRCODE_OFFSET(EVENTNAME)]	= "No event name found in config string",
> -	[ERRCODE_OFFSET(INTERNAL)]	= "BPF loader internal error",
> -	[ERRCODE_OFFSET(COMPILE)]	= "Error when compiling BPF scriptlet",
> -	[ERRCODE_OFFSET(PROGCONF_TERM)]	= "Invalid program config term in config string",
> -	[ERRCODE_OFFSET(PROLOGUE)]	= "Failed to generate prologue",
> -	[ERRCODE_OFFSET(PROLOGUE2BIG)]	= "Prologue too big for program",
> -	[ERRCODE_OFFSET(PROLOGUEOOB)]	= "Offset out of bound for prologue",
> -	[ERRCODE_OFFSET(OBJCONF_OPT)]	= "Invalid object config option",
> -	[ERRCODE_OFFSET(OBJCONF_CONF)]	= "Config value not set (missing '=')",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_OPT)]	= "Invalid object map config option",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_NOTEXIST)]	= "Target map doesn't exist",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_VALUE)]	= "Incorrect value type for map",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_TYPE)]	= "Incorrect map type",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_KEYSIZE)]	= "Incorrect map key size",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_VALUESIZE)]	= "Incorrect map value size",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_NOEVT)]	= "Event not found for map setting",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_MAPSIZE)]	= "Invalid map size for event setting",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_EVTDIM)]	= "Event dimension too large",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_EVTINH)]	= "Doesn't support inherit event",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_EVTTYPE)]	= "Wrong event type for map",
> -	[ERRCODE_OFFSET(OBJCONF_MAP_IDX2BIG)]	= "Index too large",
> -};
> -
> -static int
> -bpf_loader_strerror(int err, char *buf, size_t size)
> -{
> -	char sbuf[STRERR_BUFSIZE];
> -	const char *msg;
> -
> -	if (!buf || !size)
> -		return -1;
> -
> -	err = err > 0 ? err : -err;
> -
> -	if (err >= __LIBBPF_ERRNO__START)
> -		return libbpf_strerror(err, buf, size);
> -
> -	if (err >= __BPF_LOADER_ERRNO__START && err < __BPF_LOADER_ERRNO__END) {
> -		msg = bpf_loader_strerror_table[ERRNO_OFFSET(err)];
> -		snprintf(buf, size, "%s", msg);
> -		buf[size - 1] = '\0';
> -		return 0;
> -	}
> -
> -	if (err >= __BPF_LOADER_ERRNO__END)
> -		snprintf(buf, size, "Unknown bpf loader error %d", err);
> -	else
> -		snprintf(buf, size, "%s",
> -			 str_error_r(err, sbuf, sizeof(sbuf)));
> -
> -	buf[size - 1] = '\0';
> -	return -1;
> -}
> -
> -#define bpf__strerror_head(err, buf, size) \
> -	char sbuf[STRERR_BUFSIZE], *emsg;\
> -	if (!size)\
> -		return 0;\
> -	if (err < 0)\
> -		err = -err;\
> -	bpf_loader_strerror(err, sbuf, sizeof(sbuf));\
> -	emsg = sbuf;\
> -	switch (err) {\
> -	default:\
> -		scnprintf(buf, size, "%s", emsg);\
> -		break;
> -
> -#define bpf__strerror_entry(val, fmt...)\
> -	case val: {\
> -		scnprintf(buf, size, fmt);\
> -		break;\
> -	}
> -
> -#define bpf__strerror_end(buf, size)\
> -	}\
> -	buf[size - 1] = '\0';
> -
> -int bpf__strerror_prepare_load(const char *filename, bool source,
> -			       int err, char *buf, size_t size)
> -{
> -	size_t n;
> -	int ret;
> -
> -	n = snprintf(buf, size, "Failed to load %s%s: ",
> -			 filename, source ? " from source" : "");
> -	if (n >= size) {
> -		buf[size - 1] = '\0';
> -		return 0;
> -	}
> -	buf += n;
> -	size -= n;
> -
> -	ret = bpf_loader_strerror(err, buf, size);
> -	buf[size - 1] = '\0';
> -	return ret;
> -}
> -
> -int bpf__strerror_probe(struct bpf_object *obj __maybe_unused,
> -			int err, char *buf, size_t size)
> -{
> -	bpf__strerror_head(err, buf, size);
> -	case BPF_LOADER_ERRNO__PROGCONF_TERM: {
> -		scnprintf(buf, size, "%s (add -v to see detail)", emsg);
> -		break;
> -	}
> -	bpf__strerror_entry(EEXIST, "Probe point exist. Try 'perf probe -d \"*\"' and set 'force=yes'");
> -	bpf__strerror_entry(EACCES, "You need to be root");
> -	bpf__strerror_entry(EPERM, "You need to be root, and /proc/sys/kernel/kptr_restrict should be 0");
> -	bpf__strerror_entry(ENOENT, "You need to check probing points in BPF file");
> -	bpf__strerror_end(buf, size);
> -	return 0;
> -}
> -
> -int bpf__strerror_load(struct bpf_object *obj,
> -		       int err, char *buf, size_t size)
> -{
> -	bpf__strerror_head(err, buf, size);
> -	case LIBBPF_ERRNO__KVER: {
> -		unsigned int obj_kver = bpf_object__kversion(obj);
> -		unsigned int real_kver;
> -
> -		if (fetch_kernel_version(&real_kver, NULL, 0)) {
> -			scnprintf(buf, size, "Unable to fetch kernel version");
> -			break;
> -		}
> -
> -		if (obj_kver != real_kver) {
> -			scnprintf(buf, size,
> -				  "'version' ("KVER_FMT") doesn't match running kernel ("KVER_FMT")",
> -				  KVER_PARAM(obj_kver),
> -				  KVER_PARAM(real_kver));
> -			break;
> -		}
> -
> -		scnprintf(buf, size, "Failed to load program for unknown reason");
> -		break;
> -	}
> -	bpf__strerror_end(buf, size);
> -	return 0;
> -}
> -
> -int bpf__strerror_config_obj(struct bpf_object *obj __maybe_unused,
> -			     struct parse_events_term *term __maybe_unused,
> -			     struct evlist *evlist __maybe_unused,
> -			     int *error_pos __maybe_unused, int err,
> -			     char *buf, size_t size)
> -{
> -	bpf__strerror_head(err, buf, size);
> -	bpf__strerror_entry(BPF_LOADER_ERRNO__OBJCONF_MAP_TYPE,
> -			    "Can't use this config term with this map type");
> -	bpf__strerror_end(buf, size);
> -	return 0;
> -}
> -
> -int bpf__strerror_apply_obj_config(int err, char *buf, size_t size)
> -{
> -	bpf__strerror_head(err, buf, size);
> -	bpf__strerror_entry(BPF_LOADER_ERRNO__OBJCONF_MAP_EVTDIM,
> -			    "Cannot set event to BPF map in multi-thread tracing");
> -	bpf__strerror_entry(BPF_LOADER_ERRNO__OBJCONF_MAP_EVTINH,
> -			    "%s (Hint: use -i to turn off inherit)", emsg);
> -	bpf__strerror_entry(BPF_LOADER_ERRNO__OBJCONF_MAP_EVTTYPE,
> -			    "Can only put raw, hardware and BPF output event into a BPF map");
> -	bpf__strerror_end(buf, size);
> -	return 0;
> -}
> -
> -int bpf__strerror_setup_output_event(struct evlist *evlist __maybe_unused,
> -				     int err, char *buf, size_t size)
> -{
> -	bpf__strerror_head(err, buf, size);
> -	bpf__strerror_end(buf, size);
> -	return 0;
> -}
> diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
> deleted file mode 100644
> index 5d1c725cea29..000000000000
> --- a/tools/perf/util/bpf-loader.h
> +++ /dev/null
> @@ -1,216 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2015, Wang Nan <wangnan0@huawei.com>
> - * Copyright (C) 2015, Huawei Inc.
> - */
> -#ifndef __BPF_LOADER_H
> -#define __BPF_LOADER_H
> -
> -#include <linux/compiler.h>
> -#include <linux/err.h>
> -
> -#ifdef HAVE_LIBBPF_SUPPORT
> -#include <bpf/libbpf.h>
> -
> -enum bpf_loader_errno {
> -	__BPF_LOADER_ERRNO__START = __LIBBPF_ERRNO__START - 100,
> -	/* Invalid config string */
> -	BPF_LOADER_ERRNO__CONFIG = __BPF_LOADER_ERRNO__START,
> -	BPF_LOADER_ERRNO__GROUP,	/* Invalid group name */
> -	BPF_LOADER_ERRNO__EVENTNAME,	/* Event name is missing */
> -	BPF_LOADER_ERRNO__INTERNAL,	/* BPF loader internal error */
> -	BPF_LOADER_ERRNO__COMPILE,	/* Error when compiling BPF scriptlet */
> -	BPF_LOADER_ERRNO__PROGCONF_TERM,/* Invalid program config term in config string */
> -	BPF_LOADER_ERRNO__PROLOGUE,	/* Failed to generate prologue */
> -	BPF_LOADER_ERRNO__PROLOGUE2BIG,	/* Prologue too big for program */
> -	BPF_LOADER_ERRNO__PROLOGUEOOB,	/* Offset out of bound for prologue */
> -	BPF_LOADER_ERRNO__OBJCONF_OPT,	/* Invalid object config option */
> -	BPF_LOADER_ERRNO__OBJCONF_CONF,	/* Config value not set (lost '=')) */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_OPT,	/* Invalid object map config option */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_NOTEXIST,	/* Target map not exist */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_VALUE,	/* Incorrect value type for map */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_TYPE,	/* Incorrect map type */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_KEYSIZE,	/* Incorrect map key size */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_VALUESIZE,/* Incorrect map value size */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_NOEVT,	/* Event not found for map setting */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_MAPSIZE,	/* Invalid map size for event setting */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_EVTDIM,	/* Event dimension too large */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_EVTINH,	/* Doesn't support inherit event */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_EVTTYPE,	/* Wrong event type for map */
> -	BPF_LOADER_ERRNO__OBJCONF_MAP_IDX2BIG,	/* Index too large */
> -	__BPF_LOADER_ERRNO__END,
> -};
> -#endif // HAVE_LIBBPF_SUPPORT
> -
> -struct evsel;
> -struct evlist;
> -struct bpf_object;
> -struct parse_events_term;
> -#define PERF_BPF_PROBE_GROUP "perf_bpf_probe"
> -
> -typedef int (*bpf_prog_iter_callback_t)(const char *group, const char *event,
> -					int fd, struct bpf_object *obj, void *arg);
> -
> -#ifdef HAVE_LIBBPF_SUPPORT
> -struct bpf_object *bpf__prepare_load(const char *filename, bool source);
> -int bpf__strerror_prepare_load(const char *filename, bool source,
> -			       int err, char *buf, size_t size);
> -
> -struct bpf_object *bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz,
> -					    const char *name);
> -
> -void bpf__clear(void);
> -
> -int bpf__probe(struct bpf_object *obj);
> -int bpf__unprobe(struct bpf_object *obj);
> -int bpf__strerror_probe(struct bpf_object *obj, int err,
> -			char *buf, size_t size);
> -
> -int bpf__load(struct bpf_object *obj);
> -int bpf__strerror_load(struct bpf_object *obj, int err,
> -		       char *buf, size_t size);
> -int bpf__foreach_event(struct bpf_object *obj,
> -		       bpf_prog_iter_callback_t func, void *arg);
> -
> -int bpf__config_obj(struct bpf_object *obj, struct parse_events_term *term,
> -		    struct evlist *evlist, int *error_pos);
> -int bpf__strerror_config_obj(struct bpf_object *obj,
> -			     struct parse_events_term *term,
> -			     struct evlist *evlist,
> -			     int *error_pos, int err, char *buf,
> -			     size_t size);
> -int bpf__apply_obj_config(void);
> -int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
> -
> -int bpf__setup_stdout(struct evlist *evlist);
> -struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name);
> -int bpf__strerror_setup_output_event(struct evlist *evlist, int err, char *buf, size_t size);
> -#else
> -#include <errno.h>
> -#include <string.h>
> -#include "debug.h"
> -
> -static inline struct bpf_object *
> -bpf__prepare_load(const char *filename __maybe_unused,
> -		  bool source __maybe_unused)
> -{
> -	pr_debug("ERROR: eBPF object loading is disabled during compiling.\n");
> -	return ERR_PTR(-ENOTSUP);
> -}
> -
> -static inline struct bpf_object *
> -bpf__prepare_load_buffer(void *obj_buf __maybe_unused,
> -					   size_t obj_buf_sz __maybe_unused)
> -{
> -	return ERR_PTR(-ENOTSUP);
> -}
> -
> -static inline void bpf__clear(void) { }
> -
> -static inline int bpf__probe(struct bpf_object *obj __maybe_unused) { return 0;}
> -static inline int bpf__unprobe(struct bpf_object *obj __maybe_unused) { return 0;}
> -static inline int bpf__load(struct bpf_object *obj __maybe_unused) { return 0; }
> -
> -static inline int
> -bpf__foreach_event(struct bpf_object *obj __maybe_unused,
> -		   bpf_prog_iter_callback_t func __maybe_unused,
> -		   void *arg __maybe_unused)
> -{
> -	return 0;
> -}
> -
> -static inline int
> -bpf__config_obj(struct bpf_object *obj __maybe_unused,
> -		struct parse_events_term *term __maybe_unused,
> -		struct evlist *evlist __maybe_unused,
> -		int *error_pos __maybe_unused)
> -{
> -	return 0;
> -}
> -
> -static inline int
> -bpf__apply_obj_config(void)
> -{
> -	return 0;
> -}
> -
> -static inline int
> -bpf__setup_stdout(struct evlist *evlist __maybe_unused)
> -{
> -	return 0;
> -}
> -
> -static inline struct evsel *
> -bpf__setup_output_event(struct evlist *evlist __maybe_unused, const char *name __maybe_unused)
> -{
> -	return NULL;
> -}
> -
> -static inline int
> -__bpf_strerror(char *buf, size_t size)
> -{
> -	if (!size)
> -		return 0;
> -	strncpy(buf,
> -		"ERROR: eBPF object loading is disabled during compiling.\n",
> -		size);
> -	buf[size - 1] = '\0';
> -	return 0;
> -}
> -
> -static inline
> -int bpf__strerror_prepare_load(const char *filename __maybe_unused,
> -			       bool source __maybe_unused,
> -			       int err __maybe_unused,
> -			       char *buf, size_t size)
> -{
> -	return __bpf_strerror(buf, size);
> -}
> -
> -static inline int
> -bpf__strerror_probe(struct bpf_object *obj __maybe_unused,
> -		    int err __maybe_unused,
> -		    char *buf, size_t size)
> -{
> -	return __bpf_strerror(buf, size);
> -}
> -
> -static inline int bpf__strerror_load(struct bpf_object *obj __maybe_unused,
> -				     int err __maybe_unused,
> -				     char *buf, size_t size)
> -{
> -	return __bpf_strerror(buf, size);
> -}
> -
> -static inline int
> -bpf__strerror_config_obj(struct bpf_object *obj __maybe_unused,
> -			 struct parse_events_term *term __maybe_unused,
> -			 struct evlist *evlist __maybe_unused,
> -			 int *error_pos __maybe_unused,
> -			 int err __maybe_unused,
> -			 char *buf, size_t size)
> -{
> -	return __bpf_strerror(buf, size);
> -}
> -
> -static inline int
> -bpf__strerror_apply_obj_config(int err __maybe_unused,
> -			       char *buf, size_t size)
> -{
> -	return __bpf_strerror(buf, size);
> -}
> -
> -static inline int
> -bpf__strerror_setup_output_event(struct evlist *evlist __maybe_unused,
> -				 int err __maybe_unused, char *buf, size_t size)
> -{
> -	return __bpf_strerror(buf, size);
> -}
> -
> -#endif
> -
> -static inline int bpf__strerror_setup_stdout(struct evlist *evlist, int err, char *buf, size_t size)
> -{
> -	return bpf__strerror_setup_output_event(evlist, err, buf, size);
> -}
> -#endif
> diff --git a/tools/perf/util/c++/Build b/tools/perf/util/c++/Build
> deleted file mode 100644
> index 8610d032ac19..000000000000
> --- a/tools/perf/util/c++/Build
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -perf-$(CONFIG_CLANGLLVM) += clang.o
> -perf-$(CONFIG_CLANGLLVM) += clang-test.o
> -
> -CXXFLAGS_clang.o += -Wno-unused-parameter
> -CXXFLAGS_clang-test.o += -Wno-unused-parameter
> diff --git a/tools/perf/util/c++/clang-c.h b/tools/perf/util/c++/clang-c.h
> deleted file mode 100644
> index d3731a876b6c..000000000000
> --- a/tools/perf/util/c++/clang-c.h
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef PERF_UTIL_CLANG_C_H
> -#define PERF_UTIL_CLANG_C_H
> -
> -#include <stddef.h>	/* for size_t */
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif
> -
> -#ifdef HAVE_LIBCLANGLLVM_SUPPORT
> -extern void perf_clang__init(void);
> -extern void perf_clang__cleanup(void);
> -
> -struct test_suite;
> -extern int test__clang_to_IR(struct test_suite *test, int subtest);
> -extern int test__clang_to_obj(struct test_suite *test, int subtest);
> -
> -extern int perf_clang__compile_bpf(const char *filename,
> -				   void **p_obj_buf,
> -				   size_t *p_obj_buf_sz);
> -#else
> -
> -#include <errno.h>
> -#include <linux/compiler.h>	/* for __maybe_unused */
> -
> -static inline void perf_clang__init(void) { }
> -static inline void perf_clang__cleanup(void) { }
> -
> -static inline int
> -perf_clang__compile_bpf(const char *filename __maybe_unused,
> -			void **p_obj_buf __maybe_unused,
> -			size_t *p_obj_buf_sz __maybe_unused)
> -{
> -	return -ENOTSUP;
> -}
> -
> -#endif
> -
> -#ifdef __cplusplus
> -}
> -#endif
> -#endif
> diff --git a/tools/perf/util/c++/clang-test.cpp b/tools/perf/util/c++/clang-test.cpp
> deleted file mode 100644
> index a4683ca53697..000000000000
> --- a/tools/perf/util/c++/clang-test.cpp
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "clang.h"
> -#include "clang-c.h"
> -extern "C" {
> -#include "../util.h"
> -}
> -#include "llvm/IR/Function.h"
> -#include "llvm/IR/LLVMContext.h"
> -
> -#include <tests/llvm.h>
> -#include <string>
> -
> -class perf_clang_scope {
> -public:
> -	explicit perf_clang_scope() {perf_clang__init();}
> -	~perf_clang_scope() {perf_clang__cleanup();}
> -};
> -
> -static std::unique_ptr<llvm::Module>
> -__test__clang_to_IR(void)
> -{
> -	unsigned int kernel_version;
> -
> -	if (fetch_kernel_version(&kernel_version, NULL, 0))
> -		return std::unique_ptr<llvm::Module>(nullptr);
> -
> -	std::string cflag_kver("-DLINUX_VERSION_CODE=" +
> -				std::to_string(kernel_version));
> -
> -	std::unique_ptr<llvm::Module> M =
> -		perf::getModuleFromSource({cflag_kver.c_str()},
> -					  "perf-test.c",
> -					  test_llvm__bpf_base_prog);
> -	return M;
> -}
> -
> -extern "C" {
> -int test__clang_to_IR(struct test_suite *test __maybe_unused,
> -                      int subtest __maybe_unused)
> -{
> -	perf_clang_scope _scope;
> -
> -	auto M = __test__clang_to_IR();
> -	if (!M)
> -		return -1;
> -	for (llvm::Function& F : *M)
> -		if (F.getName() == "bpf_func__SyS_epoll_pwait")
> -			return 0;
> -	return -1;
> -}
> -
> -int test__clang_to_obj(struct test_suite *test __maybe_unused,
> -                       int subtest __maybe_unused)
> -{
> -	perf_clang_scope _scope;
> -
> -	auto M = __test__clang_to_IR();
> -	if (!M)
> -		return -1;
> -
> -	auto Buffer = perf::getBPFObjectFromModule(&*M);
> -	if (!Buffer)
> -		return -1;
> -	return 0;
> -}
> -
> -}
> diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
> deleted file mode 100644
> index 1aad7d6d34aa..000000000000
> --- a/tools/perf/util/c++/clang.cpp
> +++ /dev/null
> @@ -1,225 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llvm C frontend for perf. Support dynamically compile C file
> - *
> - * Inspired by clang example code:
> - * http://llvm.org/svn/llvm-project/cfe/trunk/examples/clang-interpreter/main.cpp
> - *
> - * Copyright (C) 2016 Wang Nan <wangnan0@huawei.com>
> - * Copyright (C) 2016 Huawei Inc.
> - */
> -
> -#include "clang/Basic/Version.h"
> -#include "clang/CodeGen/CodeGenAction.h"
> -#include "clang/Frontend/CompilerInvocation.h"
> -#include "clang/Frontend/CompilerInstance.h"
> -#include "clang/Frontend/TextDiagnosticPrinter.h"
> -#include "clang/Tooling/Tooling.h"
> -#include "llvm/IR/LegacyPassManager.h"
> -#include "llvm/IR/Module.h"
> -#include "llvm/Option/Option.h"
> -#include "llvm/Support/FileSystem.h"
> -#include "llvm/Support/ManagedStatic.h"
> -#if CLANG_VERSION_MAJOR >= 14
> -#include "llvm/MC/TargetRegistry.h"
> -#else
> -#include "llvm/Support/TargetRegistry.h"
> -#endif
> -#include "llvm/Support/TargetSelect.h"
> -#include "llvm/Target/TargetMachine.h"
> -#include "llvm/Target/TargetOptions.h"
> -#include <memory>
> -
> -#include "clang.h"
> -#include "clang-c.h"
> -
> -namespace perf {
> -
> -static std::unique_ptr<llvm::LLVMContext> LLVMCtx;
> -
> -using namespace clang;
> -
> -static CompilerInvocation *
> -createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
> -			 DiagnosticsEngine& Diags)
> -{
> -	llvm::opt::ArgStringList CCArgs {
> -		"-cc1",
> -		"-triple", "bpf-pc-linux",
> -		"-fsyntax-only",
> -		"-O2",
> -		"-nostdsysteminc",
> -		"-nobuiltininc",
> -		"-vectorize-loops",
> -		"-vectorize-slp",
> -		"-Wno-unused-value",
> -		"-Wno-pointer-sign",
> -		"-x", "c"};
> -
> -	CCArgs.append(CFlags.begin(), CFlags.end());
> -	CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs
> -#if CLANG_VERSION_MAJOR >= 11
> -                                                        ,/*BinaryName=*/nullptr
> -#endif
> -                                                        );
> -
> -	FrontendOptions& Opts = CI->getFrontendOpts();
> -	Opts.Inputs.clear();
> -	Opts.Inputs.emplace_back(Path,
> -			FrontendOptions::getInputKindForExtension("c"));
> -	return CI;
> -}
> -
> -static std::unique_ptr<llvm::Module>
> -getModuleFromSource(llvm::opt::ArgStringList CFlags,
> -		    StringRef Path, IntrusiveRefCntPtr<vfs::FileSystem> VFS)
> -{
> -	CompilerInstance Clang;
> -	Clang.createDiagnostics();
> -
> -#if CLANG_VERSION_MAJOR < 9
> -	Clang.setVirtualFileSystem(&*VFS);
> -#else
> -	Clang.createFileManager(&*VFS);
> -#endif
> -
> -#if CLANG_VERSION_MAJOR < 4
> -	IntrusiveRefCntPtr<CompilerInvocation> CI =
> -		createCompilerInvocation(std::move(CFlags), Path,
> -					 Clang.getDiagnostics());
> -	Clang.setInvocation(&*CI);
> -#else
> -	std::shared_ptr<CompilerInvocation> CI(
> -		createCompilerInvocation(std::move(CFlags), Path,
> -					 Clang.getDiagnostics()));
> -	Clang.setInvocation(CI);
> -#endif
> -
> -	std::unique_ptr<CodeGenAction> Act(new EmitLLVMOnlyAction(&*LLVMCtx));
> -	if (!Clang.ExecuteAction(*Act))
> -		return std::unique_ptr<llvm::Module>(nullptr);
> -
> -	return Act->takeModule();
> -}
> -
> -std::unique_ptr<llvm::Module>
> -getModuleFromSource(llvm::opt::ArgStringList CFlags,
> -		    StringRef Name, StringRef Content)
> -{
> -	using namespace vfs;
> -
> -	llvm::IntrusiveRefCntPtr<OverlayFileSystem> OverlayFS(
> -			new OverlayFileSystem(getRealFileSystem()));
> -	llvm::IntrusiveRefCntPtr<InMemoryFileSystem> MemFS(
> -			new InMemoryFileSystem(true));
> -
> -	/*
> -	 * pushOverlay helps setting working dir for MemFS. Must call
> -	 * before addFile.
> -	 */
> -	OverlayFS->pushOverlay(MemFS);
> -	MemFS->addFile(Twine(Name), 0, llvm::MemoryBuffer::getMemBuffer(Content));
> -
> -	return getModuleFromSource(std::move(CFlags), Name, OverlayFS);
> -}
> -
> -std::unique_ptr<llvm::Module>
> -getModuleFromSource(llvm::opt::ArgStringList CFlags, StringRef Path)
> -{
> -	IntrusiveRefCntPtr<vfs::FileSystem> VFS(vfs::getRealFileSystem());
> -	return getModuleFromSource(std::move(CFlags), Path, VFS);
> -}
> -
> -std::unique_ptr<llvm::SmallVectorImpl<char>>
> -getBPFObjectFromModule(llvm::Module *Module)
> -{
> -	using namespace llvm;
> -
> -	std::string TargetTriple("bpf-pc-linux");
> -	std::string Error;
> -	const Target* Target = TargetRegistry::lookupTarget(TargetTriple, Error);
> -	if (!Target) {
> -		llvm::errs() << Error;
> -		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
> -	}
> -
> -	llvm::TargetOptions Opt;
> -	TargetMachine *TargetMachine =
> -		Target->createTargetMachine(TargetTriple,
> -					    "generic", "",
> -					    Opt, Reloc::Static);
> -
> -	Module->setDataLayout(TargetMachine->createDataLayout());
> -	Module->setTargetTriple(TargetTriple);
> -
> -	std::unique_ptr<SmallVectorImpl<char>> Buffer(new SmallVector<char, 0>());
> -	raw_svector_ostream ostream(*Buffer);
> -
> -	legacy::PassManager PM;
> -	bool NotAdded;
> -	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream
> -#if CLANG_VERSION_MAJOR >= 7
> -                                                      , /*DwoOut=*/nullptr
> -#endif
> -#if CLANG_VERSION_MAJOR < 10
> -                                                      , TargetMachine::CGFT_ObjectFile
> -#else
> -                                                      , llvm::CGFT_ObjectFile
> -#endif
> -                                                      );
> -	if (NotAdded) {
> -		llvm::errs() << "TargetMachine can't emit a file of this type\n";
> -		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
> -	}
> -	PM.run(*Module);
> -
> -	return Buffer;
> -}
> -
> -}
> -
> -extern "C" {
> -void perf_clang__init(void)
> -{
> -	perf::LLVMCtx.reset(new llvm::LLVMContext());
> -	LLVMInitializeBPFTargetInfo();
> -	LLVMInitializeBPFTarget();
> -	LLVMInitializeBPFTargetMC();
> -	LLVMInitializeBPFAsmPrinter();
> -}
> -
> -void perf_clang__cleanup(void)
> -{
> -	perf::LLVMCtx.reset(nullptr);
> -	llvm::llvm_shutdown();
> -}
> -
> -int perf_clang__compile_bpf(const char *filename,
> -			    void **p_obj_buf,
> -			    size_t *p_obj_buf_sz)
> -{
> -	using namespace perf;
> -
> -	if (!p_obj_buf || !p_obj_buf_sz)
> -		return -EINVAL;
> -
> -	llvm::opt::ArgStringList CFlags;
> -	auto M = getModuleFromSource(std::move(CFlags), filename);
> -	if (!M)
> -		return  -EINVAL;
> -	auto O = getBPFObjectFromModule(&*M);
> -	if (!O)
> -		return -EINVAL;
> -
> -	size_t size = O->size_in_bytes();
> -	void *buffer;
> -
> -	buffer = malloc(size);
> -	if (!buffer)
> -		return -ENOMEM;
> -	memcpy(buffer, O->data(), size);
> -	*p_obj_buf = buffer;
> -	*p_obj_buf_sz = size;
> -	return 0;
> -}
> -}
> diff --git a/tools/perf/util/c++/clang.h b/tools/perf/util/c++/clang.h
> deleted file mode 100644
> index 6ce33e22f23c..000000000000
> --- a/tools/perf/util/c++/clang.h
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef PERF_UTIL_CLANG_H
> -#define PERF_UTIL_CLANG_H
> -
> -#include "llvm/ADT/StringRef.h"
> -#include "llvm/IR/LLVMContext.h"
> -#include "llvm/IR/Module.h"
> -#include "llvm/Option/Option.h"
> -#include <memory>
> -
> -namespace perf {
> -
> -using namespace llvm;
> -
> -std::unique_ptr<Module>
> -getModuleFromSource(opt::ArgStringList CFlags,
> -		    StringRef Name, StringRef Content);
> -
> -std::unique_ptr<Module>
> -getModuleFromSource(opt::ArgStringList CFlags,
> -		    StringRef Path);
> -
> -std::unique_ptr<llvm::SmallVectorImpl<char>>
> -getBPFObjectFromModule(llvm::Module *Module);
> -
> -}
> -#endif
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 46f144c46827..7a650de0db83 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -16,7 +16,6 @@
>  #include <subcmd/exec-cmd.h>
>  #include "util/event.h"  /* proc_map_timeout */
>  #include "util/hist.h"  /* perf_hist_config */
> -#include "util/llvm-utils.h"   /* perf_llvm_config */
>  #include "util/stat.h"  /* perf_stat__set_big_num */
>  #include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
>  #include "util/srcline.h"  /* addr2line_timeout_ms */
> @@ -486,9 +485,6 @@ int perf_default_config(const char *var, const char *value,
>  	if (strstarts(var, "call-graph."))
>  		return perf_callchain_config(var, value);
>  
> -	if (strstarts(var, "llvm."))
> -		return perf_llvm_config(var, value);
> -
>  	if (strstarts(var, "buildid."))
>  		return perf_buildid_config(var, value);
>  
> diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> deleted file mode 100644
> index c6c9c2228578..000000000000
> --- a/tools/perf/util/llvm-utils.c
> +++ /dev/null
> @@ -1,612 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2015, Wang Nan <wangnan0@huawei.com>
> - * Copyright (C) 2015, Huawei Inc.
> - */
> -
> -#include <errno.h>
> -#include <limits.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <linux/err.h>
> -#include <linux/string.h>
> -#include <linux/zalloc.h>
> -#include "debug.h"
> -#include "llvm-utils.h"
> -#include "config.h"
> -#include "util.h"
> -#include <sys/wait.h>
> -#include <subcmd/exec-cmd.h>
> -
> -#define CLANG_BPF_CMD_DEFAULT_TEMPLATE				\
> -		"$CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS "\
> -		"-DLINUX_VERSION_CODE=$LINUX_VERSION_CODE "	\
> -		"$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
> -		"-Wno-unused-value -Wno-pointer-sign "		\
> -		"-working-directory $WORKING_DIR "		\
> -		"-c \"$CLANG_SOURCE\" --target=bpf $CLANG_EMIT_LLVM -g -O2 -o - $LLVM_OPTIONS_PIPE"
> -
> -struct llvm_param llvm_param = {
> -	.clang_path = "clang",
> -	.llc_path = "llc",
> -	.clang_bpf_cmd_template = CLANG_BPF_CMD_DEFAULT_TEMPLATE,
> -	.clang_opt = NULL,
> -	.opts = NULL,
> -	.kbuild_dir = NULL,
> -	.kbuild_opts = NULL,
> -	.user_set_param = false,
> -};
> -
> -static void version_notice(void);
> -
> -int perf_llvm_config(const char *var, const char *value)
> -{
> -	if (!strstarts(var, "llvm."))
> -		return 0;
> -	var += sizeof("llvm.") - 1;
> -
> -	if (!strcmp(var, "clang-path"))
> -		llvm_param.clang_path = strdup(value);
> -	else if (!strcmp(var, "clang-bpf-cmd-template"))
> -		llvm_param.clang_bpf_cmd_template = strdup(value);
> -	else if (!strcmp(var, "clang-opt"))
> -		llvm_param.clang_opt = strdup(value);
> -	else if (!strcmp(var, "kbuild-dir"))
> -		llvm_param.kbuild_dir = strdup(value);
> -	else if (!strcmp(var, "kbuild-opts"))
> -		llvm_param.kbuild_opts = strdup(value);
> -	else if (!strcmp(var, "dump-obj"))
> -		llvm_param.dump_obj = !!perf_config_bool(var, value);
> -	else if (!strcmp(var, "opts"))
> -		llvm_param.opts = strdup(value);
> -	else {
> -		pr_debug("Invalid LLVM config option: %s\n", value);
> -		return -1;
> -	}
> -	llvm_param.user_set_param = true;
> -	return 0;
> -}
> -
> -static int
> -search_program(const char *def, const char *name,
> -	       char *output)
> -{
> -	char *env, *path, *tmp = NULL;
> -	char buf[PATH_MAX];
> -	int ret;
> -
> -	output[0] = '\0';
> -	if (def && def[0] != '\0') {
> -		if (def[0] == '/') {
> -			if (access(def, F_OK) == 0) {
> -				strlcpy(output, def, PATH_MAX);
> -				return 0;
> -			}
> -		} else if (def[0] != '\0')
> -			name = def;
> -	}
> -
> -	env = getenv("PATH");
> -	if (!env)
> -		return -1;
> -	env = strdup(env);
> -	if (!env)
> -		return -1;
> -
> -	ret = -ENOENT;
> -	path = strtok_r(env, ":",  &tmp);
> -	while (path) {
> -		scnprintf(buf, sizeof(buf), "%s/%s", path, name);
> -		if (access(buf, F_OK) == 0) {
> -			strlcpy(output, buf, PATH_MAX);
> -			ret = 0;
> -			break;
> -		}
> -		path = strtok_r(NULL, ":", &tmp);
> -	}
> -
> -	free(env);
> -	return ret;
> -}
> -
> -static int search_program_and_warn(const char *def, const char *name,
> -				   char *output)
> -{
> -	int ret = search_program(def, name, output);
> -
> -	if (ret) {
> -		pr_err("ERROR:\tunable to find %s.\n"
> -		       "Hint:\tTry to install latest clang/llvm to support BPF. Check your $PATH\n"
> -		       "     \tand '%s-path' option in [llvm] section of ~/.perfconfig.\n",
> -		       name, name);
> -		version_notice();
> -	}
> -	return ret;
> -}
> -
> -#define READ_SIZE	4096
> -static int
> -read_from_pipe(const char *cmd, void **p_buf, size_t *p_read_sz)
> -{
> -	int err = 0;
> -	void *buf = NULL;
> -	FILE *file = NULL;
> -	size_t read_sz = 0, buf_sz = 0;
> -	char serr[STRERR_BUFSIZE];
> -
> -	file = popen(cmd, "r");
> -	if (!file) {
> -		pr_err("ERROR: unable to popen cmd: %s\n",
> -		       str_error_r(errno, serr, sizeof(serr)));
> -		return -EINVAL;
> -	}
> -
> -	while (!feof(file) && !ferror(file)) {
> -		/*
> -		 * Make buf_sz always have obe byte extra space so we
> -		 * can put '\0' there.
> -		 */
> -		if (buf_sz - read_sz < READ_SIZE + 1) {
> -			void *new_buf;
> -
> -			buf_sz = read_sz + READ_SIZE + 1;
> -			new_buf = realloc(buf, buf_sz);
> -
> -			if (!new_buf) {
> -				pr_err("ERROR: failed to realloc memory\n");
> -				err = -ENOMEM;
> -				goto errout;
> -			}
> -
> -			buf = new_buf;
> -		}
> -		read_sz += fread(buf + read_sz, 1, READ_SIZE, file);
> -	}
> -
> -	if (buf_sz - read_sz < 1) {
> -		pr_err("ERROR: internal error\n");
> -		err = -EINVAL;
> -		goto errout;
> -	}
> -
> -	if (ferror(file)) {
> -		pr_err("ERROR: error occurred when reading from pipe: %s\n",
> -		       str_error_r(errno, serr, sizeof(serr)));
> -		err = -EIO;
> -		goto errout;
> -	}
> -
> -	err = WEXITSTATUS(pclose(file));
> -	file = NULL;
> -	if (err) {
> -		err = -EINVAL;
> -		goto errout;
> -	}
> -
> -	/*
> -	 * If buf is string, give it terminal '\0' to make our life
> -	 * easier. If buf is not string, that '\0' is out of space
> -	 * indicated by read_sz so caller won't even notice it.
> -	 */
> -	((char *)buf)[read_sz] = '\0';
> -
> -	if (!p_buf)
> -		free(buf);
> -	else
> -		*p_buf = buf;
> -
> -	if (p_read_sz)
> -		*p_read_sz = read_sz;
> -	return 0;
> -
> -errout:
> -	if (file)
> -		pclose(file);
> -	free(buf);
> -	if (p_buf)
> -		*p_buf = NULL;
> -	if (p_read_sz)
> -		*p_read_sz = 0;
> -	return err;
> -}
> -
> -static inline void
> -force_set_env(const char *var, const char *value)
> -{
> -	if (value) {
> -		setenv(var, value, 1);
> -		pr_debug("set env: %s=%s\n", var, value);
> -	} else {
> -		unsetenv(var);
> -		pr_debug("unset env: %s\n", var);
> -	}
> -}
> -
> -static void
> -version_notice(void)
> -{
> -	pr_err(
> -"     \tLLVM 3.7 or newer is required. Which can be found from http://llvm.org\n"
> -"     \tYou may want to try git trunk:\n"
> -"     \t\tgit clone http://llvm.org/git/llvm.git\n"
> -"     \t\t     and\n"
> -"     \t\tgit clone http://llvm.org/git/clang.git\n\n"
> -"     \tOr fetch the latest clang/llvm 3.7 from pre-built llvm packages for\n"
> -"     \tdebian/ubuntu:\n"
> -"     \t\thttps://apt.llvm.org/\n\n"
> -"     \tIf you are using old version of clang, change 'clang-bpf-cmd-template'\n"
> -"     \toption in [llvm] section of ~/.perfconfig to:\n\n"
> -"     \t  \"$CLANG_EXEC $CLANG_OPTIONS $KERNEL_INC_OPTIONS $PERF_BPF_INC_OPTIONS \\\n"
> -"     \t     -working-directory $WORKING_DIR -c $CLANG_SOURCE \\\n"
> -"     \t     -emit-llvm -o - | /path/to/llc -march=bpf -filetype=obj -o -\"\n"
> -"     \t(Replace /path/to/llc with path to your llc)\n\n"
> -);
> -}
> -
> -static int detect_kbuild_dir(char **kbuild_dir)
> -{
> -	const char *test_dir = llvm_param.kbuild_dir;
> -	const char *prefix_dir = "";
> -	const char *suffix_dir = "";
> -
> -	/* _UTSNAME_LENGTH is 65 */
> -	char release[128];
> -
> -	char *autoconf_path;
> -
> -	int err;
> -
> -	if (!test_dir) {
> -		err = fetch_kernel_version(NULL, release,
> -					   sizeof(release));
> -		if (err)
> -			return -EINVAL;
> -
> -		test_dir = release;
> -		prefix_dir = "/lib/modules/";
> -		suffix_dir = "/build";
> -	}
> -
> -	err = asprintf(&autoconf_path, "%s%s%s/include/generated/autoconf.h",
> -		       prefix_dir, test_dir, suffix_dir);
> -	if (err < 0)
> -		return -ENOMEM;
> -
> -	if (access(autoconf_path, R_OK) == 0) {
> -		free(autoconf_path);
> -
> -		err = asprintf(kbuild_dir, "%s%s%s", prefix_dir, test_dir,
> -			       suffix_dir);
> -		if (err < 0)
> -			return -ENOMEM;
> -		return 0;
> -	}
> -	pr_debug("%s: Couldn't find \"%s\", missing kernel-devel package?.\n",
> -		 __func__, autoconf_path);
> -	free(autoconf_path);
> -	return -ENOENT;
> -}
> -
> -static const char *kinc_fetch_script =
> -"#!/usr/bin/env sh\n"
> -"if ! test -d \"$KBUILD_DIR\"\n"
> -"then\n"
> -"	exit 1\n"
> -"fi\n"
> -"if ! test -f \"$KBUILD_DIR/include/generated/autoconf.h\"\n"
> -"then\n"
> -"	exit 1\n"
> -"fi\n"
> -"TMPDIR=`mktemp -d`\n"
> -"if test -z \"$TMPDIR\"\n"
> -"then\n"
> -"    exit 1\n"
> -"fi\n"
> -"cat << EOF > $TMPDIR/Makefile\n"
> -"obj-y := dummy.o\n"
> -"\\$(obj)/%.o: \\$(src)/%.c\n"
> -"\t@echo -n \"\\$(NOSTDINC_FLAGS) \\$(LINUXINCLUDE) \\$(EXTRA_CFLAGS)\"\n"
> -"\t\\$(CC) -c -o \\$@ \\$<\n"
> -"EOF\n"
> -"touch $TMPDIR/dummy.c\n"
> -"make -s -C $KBUILD_DIR M=$TMPDIR $KBUILD_OPTS dummy.o 2>/dev/null\n"
> -"RET=$?\n"
> -"rm -rf $TMPDIR\n"
> -"exit $RET\n";
> -
> -void llvm__get_kbuild_opts(char **kbuild_dir, char **kbuild_include_opts)
> -{
> -	static char *saved_kbuild_dir;
> -	static char *saved_kbuild_include_opts;
> -	int err;
> -
> -	if (!kbuild_dir || !kbuild_include_opts)
> -		return;
> -
> -	*kbuild_dir = NULL;
> -	*kbuild_include_opts = NULL;
> -
> -	if (saved_kbuild_dir && saved_kbuild_include_opts &&
> -	    !IS_ERR(saved_kbuild_dir) && !IS_ERR(saved_kbuild_include_opts)) {
> -		*kbuild_dir = strdup(saved_kbuild_dir);
> -		*kbuild_include_opts = strdup(saved_kbuild_include_opts);
> -
> -		if (*kbuild_dir && *kbuild_include_opts)
> -			return;
> -
> -		zfree(kbuild_dir);
> -		zfree(kbuild_include_opts);
> -		/*
> -		 * Don't fall through: it may breaks saved_kbuild_dir and
> -		 * saved_kbuild_include_opts if detect them again when
> -		 * memory is low.
> -		 */
> -		return;
> -	}
> -
> -	if (llvm_param.kbuild_dir && !llvm_param.kbuild_dir[0]) {
> -		pr_debug("[llvm.kbuild-dir] is set to \"\" deliberately.\n");
> -		pr_debug("Skip kbuild options detection.\n");
> -		goto errout;
> -	}
> -
> -	err = detect_kbuild_dir(kbuild_dir);
> -	if (err) {
> -		pr_warning(
> -"WARNING:\tunable to get correct kernel building directory.\n"
> -"Hint:\tSet correct kbuild directory using 'kbuild-dir' option in [llvm]\n"
> -"     \tsection of ~/.perfconfig or set it to \"\" to suppress kbuild\n"
> -"     \tdetection.\n\n");
> -		goto errout;
> -	}
> -
> -	pr_debug("Kernel build dir is set to %s\n", *kbuild_dir);
> -	force_set_env("KBUILD_DIR", *kbuild_dir);
> -	force_set_env("KBUILD_OPTS", llvm_param.kbuild_opts);
> -	err = read_from_pipe(kinc_fetch_script,
> -			     (void **)kbuild_include_opts,
> -			     NULL);
> -	if (err) {
> -		pr_warning(
> -"WARNING:\tunable to get kernel include directories from '%s'\n"
> -"Hint:\tTry set clang include options using 'clang-bpf-cmd-template'\n"
> -"     \toption in [llvm] section of ~/.perfconfig and set 'kbuild-dir'\n"
> -"     \toption in [llvm] to \"\" to suppress this detection.\n\n",
> -			*kbuild_dir);
> -
> -		zfree(kbuild_dir);
> -		goto errout;
> -	}
> -
> -	pr_debug("include option is set to %s\n", *kbuild_include_opts);
> -
> -	saved_kbuild_dir = strdup(*kbuild_dir);
> -	saved_kbuild_include_opts = strdup(*kbuild_include_opts);
> -
> -	if (!saved_kbuild_dir || !saved_kbuild_include_opts) {
> -		zfree(&saved_kbuild_dir);
> -		zfree(&saved_kbuild_include_opts);
> -	}
> -	return;
> -errout:
> -	saved_kbuild_dir = ERR_PTR(-EINVAL);
> -	saved_kbuild_include_opts = ERR_PTR(-EINVAL);
> -}
> -
> -int llvm__get_nr_cpus(void)
> -{
> -	static int nr_cpus_avail = 0;
> -	char serr[STRERR_BUFSIZE];
> -
> -	if (nr_cpus_avail > 0)
> -		return nr_cpus_avail;
> -
> -	nr_cpus_avail = sysconf(_SC_NPROCESSORS_CONF);
> -	if (nr_cpus_avail <= 0) {
> -		pr_err(
> -"WARNING:\tunable to get available CPUs in this system: %s\n"
> -"        \tUse 128 instead.\n", str_error_r(errno, serr, sizeof(serr)));
> -		nr_cpus_avail = 128;
> -	}
> -	return nr_cpus_avail;
> -}
> -
> -void llvm__dump_obj(const char *path, void *obj_buf, size_t size)
> -{
> -	char *obj_path = strdup(path);
> -	FILE *fp;
> -	char *p;
> -
> -	if (!obj_path) {
> -		pr_warning("WARNING: Not enough memory, skip object dumping\n");
> -		return;
> -	}
> -
> -	p = strrchr(obj_path, '.');
> -	if (!p || (strcmp(p, ".c") != 0)) {
> -		pr_warning("WARNING: invalid llvm source path: '%s', skip object dumping\n",
> -			   obj_path);
> -		goto out;
> -	}
> -
> -	p[1] = 'o';
> -	fp = fopen(obj_path, "wb");
> -	if (!fp) {
> -		pr_warning("WARNING: failed to open '%s': %s, skip object dumping\n",
> -			   obj_path, strerror(errno));
> -		goto out;
> -	}
> -
> -	pr_debug("LLVM: dumping %s\n", obj_path);
> -	if (fwrite(obj_buf, size, 1, fp) != 1)
> -		pr_debug("WARNING: failed to write to file '%s': %s, skip object dumping\n", obj_path, strerror(errno));
> -	fclose(fp);
> -out:
> -	free(obj_path);
> -}
> -
> -int llvm__compile_bpf(const char *path, void **p_obj_buf,
> -		      size_t *p_obj_buf_sz)
> -{
> -	size_t obj_buf_sz;
> -	void *obj_buf = NULL;
> -	int err, nr_cpus_avail;
> -	unsigned int kernel_version;
> -	char linux_version_code_str[64];
> -	const char *clang_opt = llvm_param.clang_opt;
> -	char clang_path[PATH_MAX], llc_path[PATH_MAX], abspath[PATH_MAX], nr_cpus_avail_str[64];
> -	char serr[STRERR_BUFSIZE];
> -	char *kbuild_dir = NULL, *kbuild_include_opts = NULL,
> -	     *perf_bpf_include_opts = NULL;
> -	const char *template = llvm_param.clang_bpf_cmd_template;
> -	char *pipe_template = NULL;
> -	const char *opts = llvm_param.opts;
> -	char *command_echo = NULL, *command_out;
> -	char *libbpf_include_dir = system_path(LIBBPF_INCLUDE_DIR);
> -
> -	if (path[0] != '-' && realpath(path, abspath) == NULL) {
> -		err = errno;
> -		pr_err("ERROR: problems with path %s: %s\n",
> -		       path, str_error_r(err, serr, sizeof(serr)));
> -		return -err;
> -	}
> -
> -	if (!template)
> -		template = CLANG_BPF_CMD_DEFAULT_TEMPLATE;
> -
> -	err = search_program_and_warn(llvm_param.clang_path,
> -			     "clang", clang_path);
> -	if (err)
> -		return -ENOENT;
> -
> -	/*
> -	 * This is an optional work. Even it fail we can continue our
> -	 * work. Needn't check error return.
> -	 */
> -	llvm__get_kbuild_opts(&kbuild_dir, &kbuild_include_opts);
> -
> -	nr_cpus_avail = llvm__get_nr_cpus();
> -	snprintf(nr_cpus_avail_str, sizeof(nr_cpus_avail_str), "%d",
> -		 nr_cpus_avail);
> -
> -	if (fetch_kernel_version(&kernel_version, NULL, 0))
> -		kernel_version = 0;
> -
> -	snprintf(linux_version_code_str, sizeof(linux_version_code_str),
> -		 "0x%x", kernel_version);
> -	if (asprintf(&perf_bpf_include_opts, "-I%s/", libbpf_include_dir) < 0)
> -		goto errout;
> -	force_set_env("NR_CPUS", nr_cpus_avail_str);
> -	force_set_env("LINUX_VERSION_CODE", linux_version_code_str);
> -	force_set_env("CLANG_EXEC", clang_path);
> -	force_set_env("CLANG_OPTIONS", clang_opt);
> -	force_set_env("KERNEL_INC_OPTIONS", kbuild_include_opts);
> -	force_set_env("PERF_BPF_INC_OPTIONS", perf_bpf_include_opts);
> -	force_set_env("WORKING_DIR", kbuild_dir ? : ".");
> -
> -	if (opts) {
> -		err = search_program_and_warn(llvm_param.llc_path, "llc", llc_path);
> -		if (err)
> -			goto errout;
> -
> -		err = -ENOMEM;
> -		if (asprintf(&pipe_template, "%s -emit-llvm | %s -march=bpf %s -filetype=obj -o -",
> -			      template, llc_path, opts) < 0) {
> -			pr_err("ERROR:\tnot enough memory to setup command line\n");
> -			goto errout;
> -		}
> -
> -		template = pipe_template;
> -
> -	}
> -
> -	/*
> -	 * Since we may reset clang's working dir, path of source file
> -	 * should be transferred into absolute path, except we want
> -	 * stdin to be source file (testing).
> -	 */
> -	force_set_env("CLANG_SOURCE",
> -		      (path[0] == '-') ? path : abspath);
> -
> -	pr_debug("llvm compiling command template: %s\n", template);
> -
> -	/*
> -	 * Below, substitute control characters for values that can cause the
> -	 * echo to misbehave, then substitute the values back.
> -	 */
> -	err = -ENOMEM;
> -	if (asprintf(&command_echo, "echo -n \a%s\a", template) < 0)
> -		goto errout;
> -
> -#define SWAP_CHAR(a, b) do { if (*p == a) *p = b; } while (0)
> -	for (char *p = command_echo; *p; p++) {
> -		SWAP_CHAR('<', '\001');
> -		SWAP_CHAR('>', '\002');
> -		SWAP_CHAR('"', '\003');
> -		SWAP_CHAR('\'', '\004');
> -		SWAP_CHAR('|', '\005');
> -		SWAP_CHAR('&', '\006');
> -		SWAP_CHAR('\a', '"');
> -	}
> -	err = read_from_pipe(command_echo, (void **) &command_out, NULL);
> -	if (err)
> -		goto errout;
> -
> -	for (char *p = command_out; *p; p++) {
> -		SWAP_CHAR('\001', '<');
> -		SWAP_CHAR('\002', '>');
> -		SWAP_CHAR('\003', '"');
> -		SWAP_CHAR('\004', '\'');
> -		SWAP_CHAR('\005', '|');
> -		SWAP_CHAR('\006', '&');
> -	}
> -#undef SWAP_CHAR
> -	pr_debug("llvm compiling command : %s\n", command_out);
> -
> -	err = read_from_pipe(template, &obj_buf, &obj_buf_sz);
> -	if (err) {
> -		pr_err("ERROR:\tunable to compile %s\n", path);
> -		pr_err("Hint:\tCheck error message shown above.\n");
> -		pr_err("Hint:\tYou can also pre-compile it into .o using:\n");
> -		pr_err("     \t\tclang --target=bpf -O2 -c %s\n", path);
> -		pr_err("     \twith proper -I and -D options.\n");
> -		goto errout;
> -	}
> -
> -	free(command_echo);
> -	free(command_out);
> -	free(kbuild_dir);
> -	free(kbuild_include_opts);
> -	free(perf_bpf_include_opts);
> -	free(libbpf_include_dir);
> -
> -	if (!p_obj_buf)
> -		free(obj_buf);
> -	else
> -		*p_obj_buf = obj_buf;
> -
> -	if (p_obj_buf_sz)
> -		*p_obj_buf_sz = obj_buf_sz;
> -	return 0;
> -errout:
> -	free(command_echo);
> -	free(kbuild_dir);
> -	free(kbuild_include_opts);
> -	free(obj_buf);
> -	free(perf_bpf_include_opts);
> -	free(libbpf_include_dir);
> -	free(pipe_template);
> -	if (p_obj_buf)
> -		*p_obj_buf = NULL;
> -	if (p_obj_buf_sz)
> -		*p_obj_buf_sz = 0;
> -	return err;
> -}
> -
> -int llvm__search_clang(void)
> -{
> -	char clang_path[PATH_MAX];
> -
> -	return search_program_and_warn(llvm_param.clang_path, "clang", clang_path);
> -}
> diff --git a/tools/perf/util/llvm-utils.h b/tools/perf/util/llvm-utils.h
> deleted file mode 100644
> index 7878a0e3fa98..000000000000
> --- a/tools/perf/util/llvm-utils.h
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2015, Wang Nan <wangnan0@huawei.com>
> - * Copyright (C) 2015, Huawei Inc.
> - */
> -#ifndef __LLVM_UTILS_H
> -#define __LLVM_UTILS_H
> -
> -#include <stdbool.h>
> -
> -struct llvm_param {
> -	/* Path of clang executable */
> -	const char *clang_path;
> -	/* Path of llc executable */
> -	const char *llc_path;
> -	/*
> -	 * Template of clang bpf compiling. 5 env variables
> -	 * can be used:
> -	 *   $CLANG_EXEC:		Path to clang.
> -	 *   $CLANG_OPTIONS:		Extra options to clang.
> -	 *   $KERNEL_INC_OPTIONS:	Kernel include directories.
> -	 *   $WORKING_DIR:		Kernel source directory.
> -	 *   $CLANG_SOURCE:		Source file to be compiled.
> -	 */
> -	const char *clang_bpf_cmd_template;
> -	/* Will be filled in $CLANG_OPTIONS */
> -	const char *clang_opt;
> -	/*
> -	 * If present it'll add -emit-llvm to $CLANG_OPTIONS to pipe
> -	 * the clang output to llc, useful for new llvm options not
> -	 * yet selectable via 'clang -mllvm option', such as -mattr=dwarfris
> -	 * in clang 6.0/llvm 7
> -	 */
> -	const char *opts;
> -	/* Where to find kbuild system */
> -	const char *kbuild_dir;
> -	/*
> -	 * Arguments passed to make, like 'ARCH=arm' if doing cross
> -	 * compiling. Should not be used for dynamic compiling.
> -	 */
> -	const char *kbuild_opts;
> -	/*
> -	 * Default is false. If set to true, write compiling result
> -	 * to object file.
> -	 */
> -	bool dump_obj;
> -	/*
> -	 * Default is false. If one of the above fields is set by user
> -	 * explicitly then user_set_llvm is set to true. This is used
> -	 * for perf test. If user doesn't set anything in .perfconfig
> -	 * and clang is not found, don't trigger llvm test.
> -	 */
> -	bool user_set_param;
> -};
> -
> -extern struct llvm_param llvm_param;
> -int perf_llvm_config(const char *var, const char *value);
> -
> -int llvm__compile_bpf(const char *path, void **p_obj_buf, size_t *p_obj_buf_sz);
> -
> -/* This function is for test__llvm() use only */
> -int llvm__search_clang(void);
> -
> -/* Following functions are reused by builtin clang support */
> -void llvm__get_kbuild_opts(char **kbuild_dir, char **kbuild_include_opts);
> -int llvm__get_nr_cpus(void);
> -
> -void llvm__dump_obj(const char *path, void *obj_buf, size_t size);
> -#endif
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 0b5075ef00c8..00a8ec94f5b2 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -14,7 +14,6 @@
>  #include "parse-events.h"
>  #include "string2.h"
>  #include "strlist.h"
> -#include "bpf-loader.h"
>  #include "debug.h"
>  #include <api/fs/tracing_path.h>
>  #include <perf/cpumap.h>
> @@ -648,272 +647,6 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
>  }
>  #endif /* HAVE_LIBTRACEEVENT */
>  
> -#ifdef HAVE_LIBBPF_SUPPORT
> -struct __add_bpf_event_param {
> -	struct parse_events_state *parse_state;
> -	struct list_head *list;
> -	struct list_head *head_config;
> -	YYLTYPE *loc;
> -};
> -
> -static int add_bpf_event(const char *group, const char *event, int fd, struct bpf_object *obj,
> -			 void *_param)
> -{
> -	LIST_HEAD(new_evsels);
> -	struct __add_bpf_event_param *param = _param;
> -	struct parse_events_state *parse_state = param->parse_state;
> -	struct list_head *list = param->list;
> -	struct evsel *pos;
> -	int err;
> -	/*
> -	 * Check if we should add the event, i.e. if it is a TP but starts with a '!',
> -	 * then don't add the tracepoint, this will be used for something else, like
> -	 * adding to a BPF_MAP_TYPE_PROG_ARRAY.
> -	 *
> -	 * See tools/perf/examples/bpf/augmented_raw_syscalls.c
> -	 */
> -	if (group[0] == '!')
> -		return 0;
> -
> -	pr_debug("add bpf event %s:%s and attach bpf program %d\n",
> -		 group, event, fd);
> -
> -	err = parse_events_add_tracepoint(&new_evsels, &parse_state->idx, group,
> -					  event, parse_state->error,
> -					  param->head_config, param->loc);
> -	if (err) {
> -		struct evsel *evsel, *tmp;
> -
> -		pr_debug("Failed to add BPF event %s:%s\n",
> -			 group, event);
> -		list_for_each_entry_safe(evsel, tmp, &new_evsels, core.node) {
> -			list_del_init(&evsel->core.node);
> -			evsel__delete(evsel);
> -		}
> -		return err;
> -	}
> -	pr_debug("adding %s:%s\n", group, event);
> -
> -	list_for_each_entry(pos, &new_evsels, core.node) {
> -		pr_debug("adding %s:%s to %p\n",
> -			 group, event, pos);
> -		pos->bpf_fd = fd;
> -		pos->bpf_obj = obj;
> -	}
> -	list_splice(&new_evsels, list);
> -	return 0;
> -}
> -
> -int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
> -			      struct list_head *list,
> -			      struct bpf_object *obj,
> -			      struct list_head *head_config,
> -			      void *loc)
> -{
> -	int err;
> -	char errbuf[BUFSIZ];
> -	struct __add_bpf_event_param param = {parse_state, list, head_config, loc};
> -	static bool registered_unprobe_atexit = false;
> -	YYLTYPE test_loc = {.first_column = -1};
> -
> -	if (IS_ERR(obj) || !obj) {
> -		snprintf(errbuf, sizeof(errbuf),
> -			 "Internal error: load bpf obj with NULL");
> -		err = -EINVAL;
> -		goto errout;
> -	}
> -
> -	/*
> -	 * Register atexit handler before calling bpf__probe() so
> -	 * bpf__probe() don't need to unprobe probe points its already
> -	 * created when failure.
> -	 */
> -	if (!registered_unprobe_atexit) {
> -		atexit(bpf__clear);
> -		registered_unprobe_atexit = true;
> -	}
> -
> -	err = bpf__probe(obj);
> -	if (err) {
> -		bpf__strerror_probe(obj, err, errbuf, sizeof(errbuf));
> -		goto errout;
> -	}
> -
> -	err = bpf__load(obj);
> -	if (err) {
> -		bpf__strerror_load(obj, err, errbuf, sizeof(errbuf));
> -		goto errout;
> -	}
> -
> -	if (!param.loc)
> -		param.loc = &test_loc;
> -
> -	err = bpf__foreach_event(obj, add_bpf_event, &param);
> -	if (err) {
> -		snprintf(errbuf, sizeof(errbuf),
> -			 "Attach events in BPF object failed");
> -		goto errout;
> -	}
> -
> -	return 0;
> -errout:
> -	parse_events_error__handle(parse_state->error, param.loc ? param.loc->first_column : 0,
> -				strdup(errbuf), strdup("(add -v to see detail)"));
> -	return err;
> -}
> -
> -static int
> -parse_events_config_bpf(struct parse_events_state *parse_state,
> -			struct bpf_object *obj,
> -			struct list_head *head_config)
> -{
> -	struct parse_events_term *term;
> -	int error_pos = 0;
> -
> -	if (!head_config || list_empty(head_config))
> -		return 0;
> -
> -	list_for_each_entry(term, head_config, list) {
> -		int err;
> -
> -		if (term->type_term != PARSE_EVENTS__TERM_TYPE_USER) {
> -			parse_events_error__handle(parse_state->error, term->err_term,
> -						strdup("Invalid config term for BPF object"),
> -						NULL);
> -			return -EINVAL;
> -		}
> -
> -		err = bpf__config_obj(obj, term, parse_state->evlist, &error_pos);
> -		if (err) {
> -			char errbuf[BUFSIZ];
> -			int idx;
> -
> -			bpf__strerror_config_obj(obj, term, parse_state->evlist,
> -						 &error_pos, err, errbuf,
> -						 sizeof(errbuf));
> -
> -			if (err == -BPF_LOADER_ERRNO__OBJCONF_MAP_VALUE)
> -				idx = term->err_val;
> -			else
> -				idx = term->err_term + error_pos;
> -
> -			parse_events_error__handle(parse_state->error, idx,
> -						strdup(errbuf),
> -						NULL);
> -			return err;
> -		}
> -	}
> -	return 0;
> -}
> -
> -/*
> - * Split config terms:
> - * perf record -e bpf.c/call-graph=fp,map:array.value[0]=1/ ...
> - *  'call-graph=fp' is 'evt config', should be applied to each
> - *  events in bpf.c.
> - * 'map:array.value[0]=1' is 'obj config', should be processed
> - * with parse_events_config_bpf.
> - *
> - * Move object config terms from the first list to obj_head_config.
> - */
> -static void
> -split_bpf_config_terms(struct list_head *evt_head_config,
> -		       struct list_head *obj_head_config)
> -{
> -	struct parse_events_term *term, *temp;
> -
> -	/*
> -	 * Currently, all possible user config term
> -	 * belong to bpf object. parse_events__is_hardcoded_term()
> -	 * happens to be a good flag.
> -	 *
> -	 * See parse_events_config_bpf() and
> -	 * config_term_tracepoint().
> -	 */
> -	list_for_each_entry_safe(term, temp, evt_head_config, list)
> -		if (!parse_events__is_hardcoded_term(term))
> -			list_move_tail(&term->list, obj_head_config);
> -}
> -
> -int parse_events_load_bpf(struct parse_events_state *parse_state,
> -			  struct list_head *list,
> -			  char *bpf_file_name,
> -			  bool source,
> -			  struct list_head *head_config,
> -			  void *loc_)
> -{
> -	int err;
> -	struct bpf_object *obj;
> -	LIST_HEAD(obj_head_config);
> -	YYLTYPE *loc = loc_;
> -
> -	if (head_config)
> -		split_bpf_config_terms(head_config, &obj_head_config);
> -
> -	obj = bpf__prepare_load(bpf_file_name, source);
> -	if (IS_ERR(obj)) {
> -		char errbuf[BUFSIZ];
> -
> -		err = PTR_ERR(obj);
> -
> -		if (err == -ENOTSUP)
> -			snprintf(errbuf, sizeof(errbuf),
> -				 "BPF support is not compiled");
> -		else
> -			bpf__strerror_prepare_load(bpf_file_name,
> -						   source,
> -						   -err, errbuf,
> -						   sizeof(errbuf));
> -
> -		parse_events_error__handle(parse_state->error, loc->first_column,
> -					strdup(errbuf), strdup("(add -v to see detail)"));
> -		return err;
> -	}
> -
> -	err = parse_events_load_bpf_obj(parse_state, list, obj, head_config, loc);
> -	if (err)
> -		return err;
> -	err = parse_events_config_bpf(parse_state, obj, &obj_head_config);
> -
> -	/*
> -	 * Caller doesn't know anything about obj_head_config,
> -	 * so combine them together again before returning.
> -	 */
> -	if (head_config)
> -		list_splice_tail(&obj_head_config, head_config);
> -	return err;
> -}
> -#else // HAVE_LIBBPF_SUPPORT
> -int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
> -			      struct list_head *list __maybe_unused,
> -			      struct bpf_object *obj __maybe_unused,
> -			      struct list_head *head_config __maybe_unused,
> -			      void *loc_)
> -{
> -	YYLTYPE *loc = loc_;
> -
> -	parse_events_error__handle(parse_state->error, loc->first_column,
> -				   strdup("BPF support is not compiled"),
> -				   strdup("Make sure libbpf-devel is available at build time."));
> -	return -ENOTSUP;
> -}
> -
> -int parse_events_load_bpf(struct parse_events_state *parse_state,
> -			  struct list_head *list __maybe_unused,
> -			  char *bpf_file_name __maybe_unused,
> -			  bool source __maybe_unused,
> -			  struct list_head *head_config __maybe_unused,
> -			  void *loc_)
> -{
> -	YYLTYPE *loc = loc_;
> -
> -	parse_events_error__handle(parse_state->error, loc->first_column,
> -				   strdup("BPF support is not compiled"),
> -				   strdup("Make sure libbpf-devel is available at build time."));
> -	return -ENOTSUP;
> -}
> -#endif // HAVE_LIBBPF_SUPPORT
> -
>  static int
>  parse_breakpoint_type(const char *type, struct perf_event_attr *attr)
>  {
> @@ -2274,7 +2007,6 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
>  		.list	  = LIST_HEAD_INIT(parse_state.list),
>  		.idx	  = evlist->core.nr_entries,
>  		.error	  = err,
> -		.evlist	  = evlist,
>  		.stoken	  = PE_START_EVENTS,
>  		.fake_pmu = fake_pmu,
>  		.pmu_filter = pmu_filter,
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index b77ff619a623..411f69b2ac3a 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -118,8 +118,6 @@ struct parse_events_state {
>  	int			   idx;
>  	/* Error information. */
>  	struct parse_events_error *error;
> -	/* Used by BPF event creation. */
> -	struct evlist		  *evlist;
>  	/* Holds returned terms for term parsing. */
>  	struct list_head	  *terms;
>  	/* Start token. */
> @@ -160,19 +158,6 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
>  				const char *sys, const char *event,
>  				struct parse_events_error *error,
>  				struct list_head *head_config, void *loc);
> -int parse_events_load_bpf(struct parse_events_state *parse_state,
> -			  struct list_head *list,
> -			  char *bpf_file_name,
> -			  bool source,
> -			  struct list_head *head_config,
> -			  void *loc);
> -/* Provide this function for perf test */
> -struct bpf_object;
> -int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
> -			      struct list_head *list,
> -			      struct bpf_object *obj,
> -			      struct list_head *head_config,
> -			      void *loc);
>  int parse_events_add_numeric(struct parse_events_state *parse_state,
>  			     struct list_head *list,
>  			     u32 type, u64 config,
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index d7d084cc4140..1147084b2c76 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -68,31 +68,6 @@ static int lc_str(yyscan_t scanner, const struct parse_events_state *state)
>  	return str(scanner, state->match_legacy_cache_terms ? PE_LEGACY_CACHE : PE_NAME);
>  }
>  
> -static bool isbpf_suffix(char *text)
> -{
> -	int len = strlen(text);
> -
> -	if (len < 2)
> -		return false;
> -	if ((text[len - 1] == 'c' || text[len - 1] == 'o') &&
> -	    text[len - 2] == '.')
> -		return true;
> -	if (len > 4 && !strcmp(text + len - 4, ".obj"))
> -		return true;
> -	return false;
> -}
> -
> -static bool isbpf(yyscan_t scanner)
> -{
> -	char *text = parse_events_get_text(scanner);
> -	struct stat st;
> -
> -	if (!isbpf_suffix(text))
> -		return false;
> -
> -	return stat(text, &st) == 0;
> -}
> -
>  /*
>   * This function is called when the parser gets two kind of input:
>   *
> @@ -179,8 +154,6 @@ do {							\
>  group		[^,{}/]*[{][^}]*[}][^,{}/]*
>  event_pmu	[^,{}/]+[/][^/]*[/][^,{}/]*
>  event		[^,{}/]+
> -bpf_object	[^,{}]+\.(o|bpf)[a-zA-Z0-9._]*
> -bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
>  
>  num_dec		[0-9]+
>  num_hex		0x[a-fA-F0-9]+
> @@ -233,8 +206,6 @@ non_digit	[^0-9]
>  		}
>  
>  {event_pmu}	|
> -{bpf_object}	|
> -{bpf_source}	|
>  {event}		{
>  			BEGIN(INITIAL);
>  			REWIND(1);
> @@ -363,8 +334,6 @@ r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
>  {num_hex}		{ return value(yyscanner, 16); }
>  
>  {modifier_event}	{ return str(yyscanner, PE_MODIFIER_EVENT); }
> -{bpf_object}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_OBJECT); }
> -{bpf_source}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_SOURCE); }
>  {name}			{ return str(yyscanner, PE_NAME); }
>  {name_tag}		{ return str(yyscanner, PE_NAME); }
>  "/"			{ BEGIN(config); return '/'; }
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index c3517e3498d7..00da1f8c0baf 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -60,7 +60,6 @@ static void free_list_evsel(struct list_head* list_evsel)
>  %token PE_VALUE_SYM_TOOL
>  %token PE_EVENT_NAME
>  %token PE_RAW PE_NAME
> -%token PE_BPF_OBJECT PE_BPF_SOURCE
>  %token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
>  %token PE_LEGACY_CACHE
>  %token PE_PREFIX_MEM
> @@ -75,8 +74,6 @@ static void free_list_evsel(struct list_head* list_evsel)
>  %type <num> value_sym
>  %type <str> PE_RAW
>  %type <str> PE_NAME
> -%type <str> PE_BPF_OBJECT
> -%type <str> PE_BPF_SOURCE
>  %type <str> PE_LEGACY_CACHE
>  %type <str> PE_MODIFIER_EVENT
>  %type <str> PE_MODIFIER_BP
> @@ -97,7 +94,6 @@ static void free_list_evsel(struct list_head* list_evsel)
>  %type <list_evsel> event_legacy_tracepoint
>  %type <list_evsel> event_legacy_numeric
>  %type <list_evsel> event_legacy_raw
> -%type <list_evsel> event_bpf_file
>  %type <list_evsel> event_def
>  %type <list_evsel> event_mod
>  %type <list_evsel> event_name
> @@ -271,8 +267,7 @@ event_def: event_pmu |
>  	   event_legacy_mem sep_dc |
>  	   event_legacy_tracepoint sep_dc |
>  	   event_legacy_numeric sep_dc |
> -	   event_legacy_raw sep_dc |
> -	   event_bpf_file
> +	   event_legacy_raw sep_dc
>  
>  event_pmu:
>  PE_NAME opt_pmu_config
> @@ -620,43 +615,6 @@ PE_RAW opt_event_config
>  	$$ = list;
>  }
>  
> -event_bpf_file:
> -PE_BPF_OBJECT opt_event_config
> -{
> -	struct parse_events_state *parse_state = _parse_state;
> -	struct list_head *list;
> -	int err;
> -
> -	list = alloc_list();
> -	if (!list)
> -		YYNOMEM;
> -	err = parse_events_load_bpf(parse_state, list, $1, false, $2, &@1);
> -	parse_events_terms__delete($2);
> -	free($1);
> -	if (err) {
> -		free(list);
> -		PE_ABORT(err);
> -	}
> -	$$ = list;
> -}
> -|
> -PE_BPF_SOURCE opt_event_config
> -{
> -	struct list_head *list;
> -	int err;
> -
> -	list = alloc_list();
> -	if (!list)
> -		YYNOMEM;
> -	err = parse_events_load_bpf(_parse_state, list, $1, true, $2, &@1);
> -	parse_events_terms__delete($2);
> -	if (err) {
> -		free(list);
> -		PE_ABORT(err);
> -	}
> -	$$ = list;
> -}
> -
>  opt_event_config:
>  '/' event_config '/'
>  {
> -- 
> 2.41.0.640.ga95def55d0-goog
> 

-- 

- Arnaldo

