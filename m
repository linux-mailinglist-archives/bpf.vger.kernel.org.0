Return-Path: <bpf+bounces-56273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DAFA9418E
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 06:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EAD8189D1A9
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 04:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D784A3C;
	Sat, 19 Apr 2025 04:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RIPN2OC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE85082C60
	for <bpf@vger.kernel.org>; Sat, 19 Apr 2025 04:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745036594; cv=none; b=imKUtwoptSNg3yzsuaSvlFUyvTdEqf+0PDzFyDYdPIDoQ9oXxEmSXKBtLklf8RFndOUIiPgMA2z8VTdvCIn/TRorjpkNZorwNtjVNGwvWbepyQfPGq+/ylWXYzUp1s9TAW1hbGdk7Sig73k4X9mgF4lq5MqbULGGjff12Jn4d5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745036594; c=relaxed/simple;
	bh=nP/QhC3w7mQaSInEmwFIMYDLQgI/u5s2r4bSZ3vV89k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSHyh4F7bhFADmhbLB0WjTJC+W1ou2jRS3s7jWnG8uvHKikCQAs47FP0csMy2IxyBCjiXG2hyVFFebK15KeEGt6FBbiAnEYR9HgEQqzxguSxvVmSgiuowVk2cmEbKSWtFQZAHB9EMamRj8X5xn+76sEHuZNl7oXWP+hGWbuXtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RIPN2OC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2263428c8baso305305ad.1
        for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 21:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745036590; x=1745641390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfLkCnYTrHKMOQcFJb4VeD8S/gJx4+VD0tvI+NK1p64=;
        b=2RIPN2OCmXB6toBPEeiAe1DY/5qE1DK7pbyZ2Rb+M+eUSEOzQFnsECSc94MkWD1qDh
         eX03+7aHKzPaXA2JrIaeojHOrkzxdIZompWpXYQq4myWcDWAz3Gzlf8nTxNPjPJQ7Gug
         1h8+0CKfgLi1fL0RFj+IEw5wLC1nKH+llsY7nMN8QMYj1ChlojWJqQyB/RXOA/MAZ5J+
         hkAyKmrwO9QXUeujjmUrNAu8TatiHouEhjA2gaFxx0QRXZZGqYxCTTWSvHBQ+Wfhd2T7
         TWIKJRcFUcF5k7QLUTGiQlxt6fsScXC0eD+V3AmzPgVzfZOsSMaqzSz01tHmuAaMpV8k
         VyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745036590; x=1745641390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfLkCnYTrHKMOQcFJb4VeD8S/gJx4+VD0tvI+NK1p64=;
        b=hmo6ffLoi1fWer/e8XiReqbSXXZVdEV9SM8m7ktlm9nboU+vC5DF+YEig2L4UkhWTC
         3T2ZeHs6DpAe5RYCWuRtjZcYYxufTNgAyUUYhM5cKxYrcprvvHeey2KSTvaHBBNoazJ0
         hM7ioc/IRC8zAjU5bZmQKRb9Qub8tiWa7HBk6F8Gnz5IOjcZdHEjZVl4wvxn0fRa3YVF
         CYsW+4uL16UZWpEcAuj9lL6e8tffdgbN3CmoXG/BWrmigTcMkyzbYWNVDPX3MCvKU6cF
         +6zJJvwPZhFODOoUxodLPotinzyzLncHzbFCnZBi45CqUg5gKUIBWQ7d1ofmmeYebRqh
         eGAg==
X-Forwarded-Encrypted: i=1; AJvYcCUjj8IL/RNomBLjqGP1P8fa5y51ggE1Wk+gsrya5G3roVR5lYF9XmYgDeDWNFIFdhlj9mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZPF5efYJI8e0kaHuvcv7WcWfd7rhdipgv6iwuqKoYEtqo2g+4
	mp/0g/MhAnqbbFvDx7grRHSH6g6p+hI6HAt6q8FSqAmq2DHEOk3jsiMpmRLPejPUYhxQFAIWC+X
	M8wzZywcuOzHRSZ9w5UTeiihOCjd3XzQK2c7H
X-Gm-Gg: ASbGncsv6Taj6nA63+7x3+jsoywXPYrEJlGoVEFAFgb1BD+0NT9cB0y4uQxGUcgCPRY
	UNBO4seZUc0NM0Jf9itwvFWRUzohWt7tTquOXlYD8y9V5E7IKOmqbMu38weCDEWkdSi64uDDIHg
	hLXxf0sDa3IIhtPBuHVCjJaVVt/SrLvdFsEg==
X-Google-Smtp-Source: AGHT+IGJm3xZzrXVFDNJ/cyaiBskTwB3H/vlqDuAv310sNtQ5TylC2DGwgecgjCEWB1GUODF12Wp9LsfWiy+B+5Y1HA=
X-Received: by 2002:a17:903:2408:b0:215:aca2:dc04 with SMTP id
 d9443c01a7336-22c52a93f9fmr4107945ad.26.1745036589273; Fri, 18 Apr 2025
 21:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com> <aALEI7glqsWmUygQ@x1>
In-Reply-To: <aALEI7glqsWmUygQ@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Apr 2025 21:22:57 -0700
X-Gm-Features: ATxdqUGd_tYrco7uecRAC9CnWOEAE-hz-KFBJG7P7sfnJQas7rcnqDXz3uLigLQ
Message-ID: <CAP-5=fVk7=XFeRRSmYLqHHvExe1fFoQCGd+Q66ocx2qgBCKQQA@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 2:29=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Apr 17, 2025 at 04:07:21PM -0700, Ian Rogers wrote:
> > Linking against libcapstone and libLLVM can be a significant increase
> > in dependencies and file size if building statically. For something
> > like `perf record` the disassembler and addr2line functionality won't
> > be used. Support dynamically loading these libraries using dlopen and
> > then calling the appropriate functions found using dlsym.
> >
> > BUILD_NONDISTRO is used to build perf against the license incompatible
> > libbfd and libiberty libraries. As this has been opt-in for nearly 2
> > years, commit dd317df07207 ("perf build: Make binutil libraries opt
> > in"), remove the code to simplify the code base.
> >
> > The patch series:
> > 1) does some initial clean up;
> > 2) moves the capstone and LLVM code to their own C files,
> > 3) simplifies a little the capstone code;
> > 4) adds perf_ variants of the functions that will either directly call
> >    the function or use dlsym to discover it;
> > 5) adds BPF JIT disassembly support to LLVM and capstone disassembly;
> > 6) removes the BUILD_NONDISTRO code, reduces scope and removes what's p=
ossible;
> > 7) adds fallback to srcline's addr2line so that llvm_addr2line is
> >    tried first and then the forked command tried next, moving the code
> >    for forking out of the main srcline.c file in the process.
> >
> > The addr2line LLVM functionality is written in C++. To avoid linking
> > against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
> > the C++ code with the libLLVM dependency will be built into a
> > libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
> > would extend their C API to avoid this.
> >
> > The libbfd BPF disassembly supported source lines, this wasn't ported
> > to the capstone and LLVM disassembly.
>
> Doing the build tests I noticed, so far:
>
>   29    58.92 opensuse:15.4                 : FAIL gcc version 7.5.0 (SUS=
E Linux)
> <SNIP>
> + make NO_LIBTRACEEVENT=3D1 ARCH=3D CROSS_COMPILE=3D EXTRA_CFLAGS=3D NO_L=
IBBPF=3D1 -C tools/perf O=3D/tmp/build/perf
> make: Entering directory '/git/perf-6.15.0-rc2/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
> Warning: Skipped check-headers due to missing ../../include
> Makefile.config:560: No elfutils/debuginfod.h found, no debuginfo server =
support, please install libdebuginfod-dev/elfutils-debuginfod-client-devel =
or equivalent
> Makefile.config:687: Warning: Disabled BPF skeletons as libbpf is require=
d
> Makefile.config:1039: No libbabeltrace found, disables 'perf data' CTF fo=
rmat support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> update-alternatives: error: no alternatives for java
> update-alternatives: error: no alternatives for java
> Makefile.config:1100: No openjdk development package found, please instal=
l JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> Makefile.config:1113: libpfm4 not found, disables libpfm4 support. Please=
 install libpfm4-dev
>
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
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
>   PERF_VERSION =3D 6.15.rc2.gfbcac9367d45
>   GEN     /tmp/build/perf/common-cmds.h
>   GEN     /tmp/build/perf/arch/arm64/include/generated/asm/sysreg-defs.h
>   GEN     perf-archive
>   GEN     perf-iostat
>   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
>   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v2.o
>   CC      /tmp/build/perf/dlfilters/dlfilter-show-cycles.o
>   INSTALL /tmp/build/perf/libapi/include/api/cpu.h
>   INSTALL /tmp/build/perf/libapi/include/api/debug.h
>   INSTALL /tmp/build/perf/libapi/include/api/io.h
>   MKDIR   /tmp/build/perf/libapi/fd/
>   INSTALL /tmp/build/perf/libapi/include/api/io_dir.h
>   CC      /tmp/build/perf/libapi/cpu.o
>   MKDIR   /tmp/build/perf/libapi/fs/
>   INSTALL /tmp/build/perf/libapi/include/api/fd/array.h
>   CC      /tmp/build/perf/libapi/debug.o
>   MKDIR   /tmp/build/perf/libapi/fs/
>   MKDIR   /tmp/build/perf/libapi/fs/
>   CC      /tmp/build/perf/libapi/fd/array.o
>   INSTALL /tmp/build/perf/libapi/include/api/fs/tracing_path.h
>   CC      /tmp/build/perf/libapi/str_error_r.o
>   INSTALL /tmp/build/perf/libapi/include/api/fs/fs.h
>   CC      /tmp/build/perf/libapi/fs/tracing_path.o
>   CC      /tmp/build/perf/libapi/fs/fs.o
>   CC      /tmp/build/perf/libapi/fs/cgroup.o
>   INSTALL libapi_headers
>   INSTALL /tmp/build/perf/libperf/include/perf/bpf_perf.h
>   INSTALL /tmp/build/perf/libperf/include/perf/core.h
>   INSTALL /tmp/build/perf/libperf/include/perf/cpumap.h
>   INSTALL /tmp/build/perf/libperf/include/perf/threadmap.h
>   CC      /tmp/build/perf/libperf/core.o
>   CC      /tmp/build/perf/libperf/cpumap.o
>   CC      /tmp/build/perf/libperf/threadmap.o
>   INSTALL /tmp/build/perf/libperf/include/perf/evlist.h
>   CC      /tmp/build/perf/libperf/evlist.o
>   CC      /tmp/build/perf/libperf/evsel.o
>   CC      /tmp/build/perf/libperf/mmap.o
>   CC      /tmp/build/perf/libperf/zalloc.o
>   INSTALL /tmp/build/perf/libsubcmd/include/subcmd/exec-cmd.h
>   INSTALL /tmp/build/perf/libperf/include/perf/evsel.h
>   CC      /tmp/build/perf/libperf/xyarray.o
>   CC      /tmp/build/perf/libperf/lib.o
>   INSTALL /tmp/build/perf/libsubcmd/include/subcmd/help.h
>   INSTALL /tmp/build/perf/libsubcmd/include/subcmd/pager.h
>   LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v0.so
>   INSTALL /tmp/build/perf/libsubcmd/include/subcmd/parse-options.h
>   LD      /tmp/build/perf/libapi/fd/libapi-in.o
>   INSTALL /tmp/build/perf/libsubcmd/include/subcmd/run-command.h
>   INSTALL libsubcmd_headers
>   LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v2.so
>   INSTALL /tmp/build/perf/libperf/include/perf/event.h
>   INSTALL /tmp/build/perf/libsymbol/include/symbol/kallsyms.h
>   CC      /tmp/build/perf/libsymbol/kallsyms.o
>   INSTALL /tmp/build/perf/libperf/include/perf/mmap.h
>   INSTALL /tmp/build/perf/libperf/include/internal/cpumap.h
>   INSTALL /tmp/build/perf/libperf/include/internal/evlist.h
>   INSTALL /tmp/build/perf/libperf/include/internal/evsel.h
>   INSTALL /tmp/build/perf/libperf/include/internal/rc_check.h
>   INSTALL /tmp/build/perf/libperf/include/internal/mmap.h
>   INSTALL /tmp/build/perf/libperf/include/internal/threadmap.h
>   INSTALL /tmp/build/perf/libperf/include/internal/lib.h
>   INSTALL /tmp/build/perf/libperf/include/internal/xyarray.h
>   LINK    /tmp/build/perf/dlfilters/dlfilter-show-cycles.so
>   LD      /tmp/build/perf/libapi/fs/libapi-in.o
> evlist.c:28:6: error: no previous prototype for 'perf_evlist__init' [-Wer=
ror=3Dmissing-prototypes]
>  void perf_evlist__init(struct perf_evlist *evlist)
>       ^~~~~~~~~~~~~~~~~

Hmm.. but on line 8 of tools/lib/perf/evlist.c is:
#include <internal/evlist.h>
is there a libperf installed somewhere? I thought we were just
statically linking currently. I'm not sure what I can do to resolve
this, it seems like a set up issue.

Thanks,
Ian

> evlist.c: In function 'perf_evlist__init':
> evlist.c:30:24: error: dereferencing pointer to incomplete type 'struct p=
erf_evlist'
>   INIT_LIST_HEAD(&evlist->entries);
>                         ^~
> evlist.c:33:2: error: implicit declaration of function 'perf_evlist__rese=
t_id_hash'; did you mean 'perf_evlist__set_maps'? [-Werror=3Dimplicit-funct=
ion-declaration]
>   perf_evlist__reset_id_hash(evlist);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   perf_evlist__set_maps
> evlist.c:33:2: error: nested extern declaration of 'perf_evlist__reset_id=
_hash' [-Werror=3Dnested-externs]
> evlist.c: In function 'perf_evlist__purge':
> evlist.c:157:2: error: implicit declaration of function 'perf_evlist__for=
_each_entry_safe'; did you mean 'hlist_for_each_entry_safe'? [-Werror=3Dimp=
licit-function-declaration]
>   perf_evlist__for_each_entry_safe(evlist, n, pos) {
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hlist_for_each_entry_safe
> evlist.c:157:2: error: nested extern declaration of 'perf_evlist__for_eac=
h_entry_safe' [-Werror=3Dnested-externs]
> evlist.c:157:51: error: expected ';' before '{' token
>   perf_evlist__for_each_entry_safe(evlist, n, pos) {
>                                                    ^
> evlist.c: At top level:
> evlist.c:165:6: error: no previous prototype for 'perf_evlist__exit' [-We=
rror=3Dmissing-prototypes]
>  void perf_evlist__exit(struct perf_evlist *evlist)
>       ^~~~~~~~~~~~~~~~~
> evlist.c: In function 'perf_evlist__open':
> evlist.c:217:2: error: implicit declaration of function 'perf_evlist__for=
_each_entry'; did you mean 'perf_evlist__for_each_evsel'? [-Werror=3Dimplic=
it-function-declaration]
>   perf_evlist__for_each_entry(evlist, evsel) {
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   perf_evlist__for_each_evsel
> evlist.c:217:2: error: nested extern declaration of 'perf_evlist__for_eac=
h_entry' [-Werror=3Dnested-externs]
> evlist.c:217:45: error: expected ';' before '{' token
>   perf_evlist__for_each_entry(evlist, evsel) {
>                                              ^
> evlist.c:225:1: error: label 'out_err' defined but not used [-Werror=3Dun=
used-label]
>  out_err:
>  ^~~~~~~
>   INSTALL libperf_headers
> evlist.c: In function 'perf_evlist__close':
> evlist.c:234:2: error: implicit declaration of function 'perf_evlist__for=
_each_entry_reverse'; did you mean 'list_for_each_entry_reverse'? [-Werror=
=3Dimplicit-function-declaration]
>   perf_evlist__for_each_entry_reverse(evlist, evsel)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   list_for_each_entry_reverse
> evlist.c:234:2: error: nested extern declaration of 'perf_evlist__for_eac=
h_entry_reverse' [-Werror=3Dnested-externs]
> evlist.c:235:3: error: expected ';' before 'perf_evsel__close'
>    perf_evsel__close(evsel);
>    ^~~~~~~~~~~~~~~~~
> evlist.c: In function 'perf_evlist__enable':
> evlist.c:243:3: error: expected ';' before 'perf_evsel__enable'
>    perf_evsel__enable(evsel);
>    ^~~~~~~~~~~~~~~~~~
> evlist.c: In function 'perf_evlist__disable':
> evlist.c:251:3: error: expected ';' before 'perf_evsel__disable'
>    perf_evsel__disable(evsel);
>    ^~~~~~~~~~~~~~~~~~~
> evlist.c: At top level:
> evlist.c:254:5: error: no previous prototype for 'perf_evlist__read_forma=
t' [-Werror=3Dmissing-prototypes]
>  u64 perf_evlist__read_format(struct perf_evlist *evlist)
>      ^~~~~~~~~~~~~~~~~~~~~~~~
> evlist.c: In function 'perf_evlist__read_format':
> evlist.c:256:29: error: implicit declaration of function 'perf_evlist__fi=
rst'; did you mean 'perf_evlist__init'? [-Werror=3Dimplicit-function-declar=
ation]
>   struct perf_evsel *first =3D perf_evlist__first(evlist);
>                              ^~~~~~~~~~~~~~~~~~
>                              perf_evlist__init
> evlist.c:256:29: error: nested extern declaration of 'perf_evlist__first'=
 [-Werror=3Dnested-externs]
> evlist.c:256:29: error: initialization makes pointer from integer without=
 a cast [-Werror=3Dint-conversion]
>   INSTALL libsymbol_headers
> evlist.c: In function 'perf_evlist__id_hash':
> evlist.c:272:26: error: 'PERF_EVLIST__HLIST_BITS' undeclared (first use i=
n this function); did you mean 'PERF_SAMPLE_ID__HLIST_BITS'?
>   hash =3D hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
>                           ^~~~~~~~~~~~~~~~~~~~~~~
>                           PERF_SAMPLE_ID__HLIST_BITS
> evlist.c:272:26: note: each undeclared identifier is reported only once f=
or each function it appears in
> evlist.c:267:6: error: variable 'hash' set but not used [-Werror=3Dunused=
-but-set-variable]
>   int hash;
>       ^~~~
> evlist.c: At top level:
> evlist.c:276:6: error: no previous prototype for 'perf_evlist__reset_id_h=
ash' [-Werror=3Dmissing-prototypes]
>  void perf_evlist__reset_id_hash(struct perf_evlist *evlist)
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> evlist.c:276:6: error: conflicting types for 'perf_evlist__reset_id_hash'=
 [-Werror]
> evlist.c:33:2: note: previous implicit declaration of 'perf_evlist__reset=
_id_hash' was here
>   perf_evlist__reset_id_hash(evlist);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   LD      /tmp/build/perf/libapi/libapi-in.o
> evlist.c: In function 'perf_evlist__reset_id_hash':
> evlist.c:280:18: error: 'PERF_EVLIST__HLIST_SIZE' undeclared (first use i=
n this function); did you mean 'PERF_SAMPLE_ID__HLIST_SIZE'?
>   for (i =3D 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
>                   ^~~~~~~~~~~~~~~~~~~~~~~
>                   PERF_SAMPLE_ID__HLIST_SIZE
> evlist.c: At top level:
> evlist.c:284:6: error: no previous prototype for 'perf_evlist__id_add' [-=
Werror=3Dmissing-prototypes]
>  void perf_evlist__id_add(struct perf_evlist *evlist,
>       ^~~~~~~~~~~~~~~~~~~
> evlist.c:295:5: error: no previous prototype for 'perf_evlist__id_add_fd'=
 [-Werror=3Dmissing-prototypes]
>  int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>      ^~~~~~~~~~~~~~~~~~~~~~
> evlist.c:339:5: error: no previous prototype for 'perf_evlist__alloc_poll=
fd' [-Werror=3Dmissing-prototypes]
>  int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
>      ^~~~~~~~~~~~~~~~~~~~~~~~~
> evlist.c: In function 'perf_evlist__alloc_pollfd':
> evlist.c:346:45: error: expected ';' before '{' token
>   perf_evlist__for_each_entry(evlist, evsel) {
>                                              ^
> evlist.c:343:6: error: unused variable 'nfds' [-Werror=3Dunused-variable]
>   int nfds =3D 0;
>       ^~~~
> evlist.c:342:6: error: unused variable 'nr_threads' [-Werror=3Dunused-var=
iable]
>   int nr_threads =3D perf_thread_map__nr(evlist->threads);
>       ^~~~~~~~~~
> evlist.c:341:6: error: unused variable 'nr_cpus' [-Werror=3Dunused-variab=
le]
>   int nr_cpus =3D perf_cpu_map__nr(evlist->all_cpus);
>       ^~~~~~~
> evlist.c: At top level:
> evlist.c:360:5: error: no previous prototype for 'perf_evlist__add_pollfd=
' [-Werror=3Dmissing-prototypes]
>  int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
>      ^~~~~~~~~~~~~~~~~~~~~~~
> evlist.c:469:51: error: 'struct perf_evlist_mmap_ops' declared inside par=
ameter list will not be visible outside of this definition or declaration [=
-Werror]
>  mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *=
ops,
>                                                    ^~~~~~~~~~~~~~~~~~~~
> evlist.c: In function 'mmap_per_evsel':
> evlist.c:477:45: error: expected ';' before '{' token
>   perf_evlist__for_each_entry(evlist, evsel) {
>                                              ^
> evlist.c:475:6: error: unused variable 'revent' [-Werror=3Dunused-variabl=
e]
>   int revent;
>       ^~~~~~
> evlist.c:473:18: error: unused variable 'evlist_cpu' [-Werror=3Dunused-va=
riable]
>   struct perf_cpu evlist_cpu =3D perf_cpu_map__cpu(evlist->all_cpus, cpu_=
idx);
>                   ^~~~~~~~~~
> evlist.c:560:1: error: no return statement in function returning non-void=
 [-Werror=3Dreturn-type]
>  }
>  ^
> evlist.c:469:73: error: unused parameter 'ops' [-Werror=3Dunused-paramete=
r]
>  mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *=
ops,
>                                                                          =
^~~
> evlist.c:470:13: error: unused parameter 'idx' [-Werror=3Dunused-paramete=
r]
>          int idx, struct perf_mmap_param *mp, int cpu_idx,
>              ^~~
> evlist.c:470:42: error: unused parameter 'mp' [-Werror=3Dunused-parameter=
]
>          int idx, struct perf_mmap_param *mp, int cpu_idx,
>                                           ^~
> evlist.c:471:13: error: unused parameter 'thread' [-Werror=3Dunused-param=
eter]
>          int thread, int *_output, int *_output_overwrite, int *nr_mmaps)
>              ^~~~~~
> evlist.c:471:26: error: unused parameter '_output' [-Werror=3Dunused-para=
meter]
>          int thread, int *_output, int *_output_overwrite, int *nr_mmaps)
>                           ^~~~~~~
> evlist.c:471:40: error: unused parameter '_output_overwrite' [-Werror=3Du=
nused-parameter]
>          int thread, int *_output, int *_output_overwrite, int *nr_mmaps)
>                                         ^~~~~~~~~~~~~~~~~
> evlist.c:471:64: error: unused parameter 'nr_mmaps' [-Werror=3Dunused-par=
ameter]
>          int thread, int *_output, int *_output_overwrite, int *nr_mmaps)
>                                                                 ^~~~~~~~
> evlist.c: At top level:
> evlist.c:563:52: error: 'struct perf_evlist_mmap_ops' declared inside par=
ameter list will not be visible outside of this definition or declaration [=
-Werror]
>  mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops =
*ops,
>                                                     ^~~~~~~~~~~~~~~~~~~~
> evlist.c: In function 'mmap_per_thread':
> evlist.c:579:30: error: passing argument 2 of 'mmap_per_evsel' from incom=
patible pointer type [-Werror=3Dincompatible-pointer-types]
>    if (mmap_per_evsel(evlist, ops, idx, mp, 0, thread, &output,
>                               ^~~
> evlist.c:469:1: note: expected 'struct perf_evlist_mmap_ops *' but argume=
nt is of type 'struct perf_evlist_mmap_ops *'
>  mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *=
ops,
>  ^~~~~~~~~~~~~~
> evlist.c:589:30: error: passing argument 2 of 'mmap_per_evsel' from incom=
patible pointer type [-Werror=3Dincompatible-pointer-types]
>    if (mmap_per_evsel(evlist, ops, idx, mp, cpu, 0, &output,
>                               ^~~
> evlist.c:469:1: note: expected 'struct perf_evlist_mmap_ops *' but argume=
nt is of type 'struct perf_evlist_mmap_ops *'
>  mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *=
ops,
>  ^~~~~~~~~~~~~~
> evlist.c: At top level:
> evlist.c:605:49: error: 'struct perf_evlist_mmap_ops' declared inside par=
ameter list will not be visible outside of this definition or declaration [=
-Werror]
>  mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *op=
s,
>                                                  ^~~~~~~~~~~~~~~~~~~~
> evlist.c: In function 'mmap_per_cpu':
> evlist.c:620:31: error: passing argument 2 of 'mmap_per_evsel' from incom=
patible pointer type [-Werror=3Dincompatible-pointer-types]
>     if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
>                                ^~~
> evlist.c:469:1: note: expected 'struct perf_evlist_mmap_ops *' but argume=
nt is of type 'struct perf_evlist_mmap_ops *'
>  mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *=
ops,
>  ^~~~~~~~~~~~~~
> evlist.c: At top level:
> evlist.c:653:13: error: 'struct perf_evlist_mmap_ops' declared inside par=
ameter list will not be visible outside of this definition or declaration [=
-Werror]
>       struct perf_evlist_mmap_ops *ops,
>              ^~~~~~~~~~~~~~~~~~~~
> evlist.c:652:5: error: no previous prototype for 'perf_evlist__mmap_ops' =
[-Werror=3Dmissing-prototypes]
>  int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>      ^~~~~~~~~~~~~~~~~~~~~
> evlist.c: In function 'perf_evlist__mmap_ops':
> evlist.c:659:18: error: dereferencing pointer to incomplete type 'struct =
perf_evlist_mmap_ops'
>   if (!ops || !ops->get || !ops->mmap)
>                   ^~
> evlist.c:666:45: error: expected ';' before '{' token
>   perf_evlist__for_each_entry(evlist, evsel) {
>                                              ^
> evlist.c:677:34: error: passing argument 2 of 'mmap_per_thread' from inco=
mpatible pointer type [-Werror=3Dincompatible-pointer-types]
>    return mmap_per_thread(evlist, ops, mp);
>                                   ^~~
> evlist.c:563:1: note: expected 'struct perf_evlist_mmap_ops *' but argume=
nt is of type 'struct perf_evlist_mmap_ops *'
>  mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops =
*ops,
>  ^~~~~~~~~~~~~~~
> evlist.c:679:30: error: passing argument 2 of 'mmap_per_cpu' from incompa=
tible pointer type [-Werror=3Dincompatible-pointer-types]
>   return mmap_per_cpu(evlist, ops, mp);
>                               ^~~
> evlist.c:605:1: note: expected 'struct perf_evlist_mmap_ops *' but argume=
nt is of type 'struct perf_evlist_mmap_ops *'
>  mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *op=
s,
>  ^~~~~~~~~~~~
> evlist.c: In function 'perf_evlist__mmap':
> evlist.c:685:9: error: variable 'ops' has initializer but incomplete type
>   struct perf_evlist_mmap_ops ops =3D {
>          ^~~~~~~~~~~~~~~~~~~~
> evlist.c:686:4: error: 'struct perf_evlist_mmap_ops' has no member named =
'get'
>    .get  =3D perf_evlist__mmap_cb_get,
>     ^~~
> evlist.c:686:11: error: excess elements in struct initializer [-Werror]
>    .get  =3D perf_evlist__mmap_cb_get,
>            ^~~~~~~~~~~~~~~~~~~~~~~~
> evlist.c:686:11: note: (near initialization for 'ops')
> evlist.c:687:4: error: 'struct perf_evlist_mmap_ops' has no member named =
'mmap'
>    .mmap =3D perf_evlist__mmap_cb_mmap,
>     ^~~~
> evlist.c:687:11: error: excess elements in struct initializer [-Werror]
>    .mmap =3D perf_evlist__mmap_cb_mmap,
>            ^~~~~~~~~~~~~~~~~~~~~~~~~
> evlist.c:687:11: note: (near initialization for 'ops')
> evlist.c:685:30: error: storage size of 'ops' isn't known
>   struct perf_evlist_mmap_ops ops =3D {
>                               ^~~
> evlist.c:685:30: error: unused variable 'ops' [-Werror=3Dunused-variable]
> evlist.c: At top level:
> evlist.c:723:6: error: no previous prototype for '__perf_evlist__set_lead=
er' [-Werror=3Dmissing-prototypes]
>  void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel=
 *leader)
>       ^~~~~~~~~~~~~~~~~~~~~~~~~
> evlist.c: In function '__perf_evlist__set_leader':
> evlist.c:728:2: error: implicit declaration of function '__perf_evlist__f=
or_each_entry'; did you mean 'perf_evlist__for_each_evsel'? [-Werror=3Dimpl=
icit-function-declaration]
>   __perf_evlist__for_each_entry(list, evsel) {
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   perf_evlist__for_each_evsel
> evlist.c:728:2: error: nested extern declaration of '__perf_evlist__for_e=
ach_entry' [-Werror=3Dnested-externs]
> evlist.c:728:45: error: expected ';' before '{' token
>   __perf_evlist__for_each_entry(list, evsel) {
>                                              ^
> evlist.c:726:6: error: unused variable 'n' [-Werror=3Dunused-variable]
>   int n =3D 0;
>       ^
> evlist.c:723:75: error: unused parameter 'leader' [-Werror=3Dunused-param=
eter]
>  void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel=
 *leader)
>                                                                          =
  ^~~~~~
> evlist.c: At top level:
> evlist.c:762:6: error: no previous prototype for 'perf_evlist__go_system_=
wide' [-Werror=3Dmissing-prototypes]
>  void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf=
_evsel *evsel)
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> evlist.c: In function 'perf_evlist__filter_pollfd':
> evlist.c:386:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>  }
>  ^
> evlist.c: In function 'perf_evlist__poll':
> evlist.c:391:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>  }
>  ^
> evlist.c: In function 'perf_evlist__mmap':
> evlist.c:693:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>  }
>  ^
> evlist.c: In function 'perf_evlist__next_mmap':
> evlist.c:721:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>  }
>  ^
> At top level:
> evlist.c:459:13: error: 'perf_evlist__set_mmap_first' defined but not use=
d [-Werror=3Dunused-function]
>  static void perf_evlist__set_mmap_first(struct perf_evlist *evlist, stru=
ct perf_mmap *map,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> evlist.c:420:13: error: 'perf_evsel__set_sid_idx' defined but not used [-=
Werror=3Dunused-function]
>  static void perf_evsel__set_sid_idx(struct perf_evsel *evsel, int idx, i=
nt cpu, int thread)
>              ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/git/perf-6.15.0-rc2/tools/build/Makefile.build:85: /tmp/bu=
ild/perf/libperf/evlist.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   AR      /tmp/build/perf/libapi/libapi.a
>   CC      /tmp/build/perf/libsubcmd/exec-cmd.o
>   CC      /tmp/build/perf/libsubcmd/help.o
>   CC      /tmp/build/perf/libsubcmd/pager.o
>   CC      /tmp/build/perf/libsubcmd/run-command.o
>   CC      /tmp/build/perf/libsubcmd/parse-options.o
>   CC      /tmp/build/perf/libsubcmd/sigchain.o
>   CC      /tmp/build/perf/libsubcmd/subcmd-config.o
>   LD      /tmp/build/perf/libsymbol/libsymbol-in.o
>   AR      /tmp/build/perf/libsymbol/libsymbol.a
> make[3]: *** [Makefile:103: /tmp/build/perf/libperf/libperf-in.o] Error 2
> make[2]: *** [Makefile.perf:976: /tmp/build/perf/libperf/libperf.a] Error=
 2
> make[2]: *** Waiting for unfinished jobs....
>   LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
>   AR      /tmp/build/perf/libsubcmd/libsubcmd.a
> make[1]: *** [Makefile.perf:287: sub-make] Error 2
> make: *** [Makefile:76: all] Error 2
> make: Leaving directory '/git/perf-6.15.0-rc2/tools/perf'
> + exit 1
> toolsbuilder@number:~/git/linux-tools-container-builds$
>
>
>   23    18.51 fedora:38                     : FAIL gcc version 13.2.1 202=
40316 (Red Hat 13.2.1-7) (GCC)
> <SNIP>
> evsel.c:23:6: error: no previous prototype for 'perf_evsel__init' [-Werro=
r=3Dmissing-prototypes]
>    23 | void perf_evsel__init(struct perf_evsel *evsel, struct perf_event=
_attr *attr,
>       |      ^~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__init':
> evsel.c:26:30: error: invalid use of undefined type 'struct perf_evsel'
>    26 |         INIT_LIST_HEAD(&evsel->node);
>       |                              ^~
> evsel.c:27:30: error: invalid use of undefined type 'struct perf_evsel'
>    27 |         INIT_LIST_HEAD(&evsel->per_stream_periods);
>       |                              ^~
> evsel.c:28:14: error: invalid use of undefined type 'struct perf_evsel'
>    28 |         evsel->attr =3D *attr;
>       |              ^~
> evsel.c:28:23: error: invalid use of undefined type 'struct perf_event_at=
tr'
>    28 |         evsel->attr =3D *attr;
>       |                       ^
> evsel.c:29:14: error: invalid use of undefined type 'struct perf_evsel'
>    29 |         evsel->idx  =3D idx;
>       |              ^~
> evsel.c:30:14: error: invalid use of undefined type 'struct perf_evsel'
>    30 |         evsel->leader =3D evsel;
>       |              ^~
> evsel.c: In function 'perf_evsel__new':
> evsel.c:35:49: error: invalid application of 'sizeof' to incomplete type =
'struct perf_evsel'
>    35 |         struct perf_evsel *evsel =3D zalloc(sizeof(*evsel));
>       |                                                 ^
> evsel.c: At top level:
> evsel.c:54:5: error: no previous prototype for 'perf_evsel__alloc_fd' [-W=
error=3Dmissing-prototypes]
>    54 | int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int=
 nthreads)
>       |     ^~~~~~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__alloc_fd':
> evsel.c:56:14: error: invalid use of undefined type 'struct perf_evsel'
>    56 |         evsel->fd =3D xyarray__new(ncpus, nthreads, sizeof(int));
>       |              ^~
> evsel.c:58:18: error: invalid use of undefined type 'struct perf_evsel'
>    58 |         if (evsel->fd) {
>       |                  ^~
> evsel.c:49:38: error: invalid use of undefined type 'struct perf_evsel'
>    49 |         ((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread)=
)
>       |                                      ^~
> evsel.c:63:43: note: in expansion of macro 'FD'
>    63 |                                 int *fd =3D FD(evsel, idx, thread=
);
>       |                                           ^~
> evsel.c:71:21: error: invalid use of undefined type 'struct perf_evsel'
>    71 |         return evsel->fd !=3D NULL ? 0 : -ENOMEM;
>       |                     ^~
> evsel.c: In function 'perf_evsel__alloc_mmap':
> evsel.c:76:14: error: invalid use of undefined type 'struct perf_evsel'
>    76 |         evsel->mmap =3D xyarray__new(ncpus, nthreads, sizeof(stru=
ct perf_mmap));
>       |              ^~
> evsel.c:78:21: error: invalid use of undefined type 'struct perf_evsel'
>    78 |         return evsel->mmap !=3D NULL ? 0 : -ENOMEM;
>       |                     ^~
> evsel.c: In function 'get_group_fd':
> evsel.c:91:42: error: invalid use of undefined type 'struct perf_evsel'
>    91 |         struct perf_evsel *leader =3D evsel->leader;
>       |                                          ^~
> evsel.c:103:20: error: invalid use of undefined type 'struct perf_evsel'
>   103 |         if (!leader->fd)
>       |                    ^~
> evsel.c:49:38: error: invalid use of undefined type 'struct perf_evsel'
>    49 |         ((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread)=
)
>       |                                      ^~
> evsel.c:106:14: note: in expansion of macro 'FD'
>   106 |         fd =3D FD(leader, cpu_map_idx, thread);
>       |              ^~
> evsel.c: In function 'perf_evsel__open':
> evsel.c:145:18: error: invalid use of undefined type 'struct perf_evsel'
>   145 |         if (evsel->fd =3D=3D NULL &&
>       |                  ^~
> evsel.c:49:38: error: invalid use of undefined type 'struct perf_evsel'
>    49 |         ((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread)=
)
>       |                                      ^~
> evsel.c:153:36: note: in expansion of macro 'FD'
>   153 |                         evsel_fd =3D FD(evsel, idx, thread);
>       |                                    ^~
> evsel.c:163:56: error: invalid use of undefined type 'struct perf_evsel'
>   163 |                         fd =3D sys_perf_event_open(&evsel->attr,
>       |                                                        ^~
> evsel.c: In function 'perf_evsel__close_fd_cpu':
> evsel.c:186:55: error: invalid use of undefined type 'struct perf_evsel'
>   186 |         for (thread =3D 0; thread < xyarray__max_y(evsel->fd); ++=
thread) {
>       |                                                       ^~
> evsel.c:49:38: error: invalid use of undefined type 'struct perf_evsel'
>    49 |         ((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread)=
)
>       |                                      ^~
> evsel.c:187:27: note: in expansion of macro 'FD'
>   187 |                 int *fd =3D FD(evsel, cpu_map_idx, thread);
>       |                           ^~
> evsel.c: At top level:
> evsel.c:196:6: error: no previous prototype for 'perf_evsel__close_fd' [-=
Werror=3Dmissing-prototypes]
>   196 | void perf_evsel__close_fd(struct perf_evsel *evsel)
>       |      ^~~~~~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__close_fd':
> evsel.c:198:53: error: invalid use of undefined type 'struct perf_evsel'
>   198 |         for (int idx =3D 0; idx < xyarray__max_x(evsel->fd); idx+=
+)
>       |                                                     ^~
> evsel.c: At top level:
> evsel.c:202:6: error: no previous prototype for 'perf_evsel__free_fd' [-W=
error=3Dmissing-prototypes]
>   202 | void perf_evsel__free_fd(struct perf_evsel *evsel)
>       |      ^~~~~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__free_fd':
> evsel.c:204:30: error: invalid use of undefined type 'struct perf_evsel'
>   204 |         xyarray__delete(evsel->fd);
>       |                              ^~
> evsel.c:205:14: error: invalid use of undefined type 'struct perf_evsel'
>   205 |         evsel->fd =3D NULL;
>       |              ^~
> evsel.c: In function 'perf_evsel__close':
> evsel.c:210:18: error: invalid use of undefined type 'struct perf_evsel'
>   210 |         if (evsel->fd =3D=3D NULL)
>       |                  ^~
> evsel.c: In function 'perf_evsel__close_cpu':
> evsel.c:219:18: error: invalid use of undefined type 'struct perf_evsel'
>   219 |         if (evsel->fd =3D=3D NULL)
>       |                  ^~
> evsel.c: In function 'perf_evsel__munmap':
> evsel.c:229:18: error: invalid use of undefined type 'struct perf_evsel'
>   229 |         if (evsel->fd =3D=3D NULL || evsel->mmap =3D=3D NULL)
>       |                  ^~
> evsel.c:229:39: error: invalid use of undefined type 'struct perf_evsel'
>   229 |         if (evsel->fd =3D=3D NULL || evsel->mmap =3D=3D NULL)
>       |                                       ^~
> evsel.c:232:49: error: invalid use of undefined type 'struct perf_evsel'
>   232 |         for (idx =3D 0; idx < xyarray__max_x(evsel->fd); idx++) {
>       |                                                 ^~
> evsel.c:233:63: error: invalid use of undefined type 'struct perf_evsel'
>   233 |                 for (thread =3D 0; thread < xyarray__max_y(evsel-=
>fd); thread++) {
>       |                                                               ^~
> evsel.c:49:38: error: invalid use of undefined type 'struct perf_evsel'
>    49 |         ((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread)=
)
>       |                                      ^~
> evsel.c:234:35: note: in expansion of macro 'FD'
>   234 |                         int *fd =3D FD(evsel, idx, thread);
>       |                                   ^~
> evsel.c:51:16: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                ^~
> evsel.c:239:43: note: in expansion of macro 'MMAP'
>   239 |                         perf_mmap__munmap(MMAP(evsel, idx, thread=
));
>       |                                           ^~~~
> evsel.c:51:68: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                                                                  =
  ^~
> evsel.c:239:43: note: in expansion of macro 'MMAP'
>   239 |                         perf_mmap__munmap(MMAP(evsel, idx, thread=
));
>       |                                           ^~~~
> evsel.c:243:30: error: invalid use of undefined type 'struct perf_evsel'
>   243 |         xyarray__delete(evsel->mmap);
>       |                              ^~
> evsel.c:244:14: error: invalid use of undefined type 'struct perf_evsel'
>   244 |         evsel->mmap =3D NULL;
>       |              ^~
> evsel.c: In function 'perf_evsel__mmap':
> evsel.c:255:18: error: invalid use of undefined type 'struct perf_evsel'
>   255 |         if (evsel->fd =3D=3D NULL || evsel->mmap)
>       |                  ^~
> evsel.c:255:39: error: invalid use of undefined type 'struct perf_evsel'
>   255 |         if (evsel->fd =3D=3D NULL || evsel->mmap)
>       |                                       ^~
> evsel.c:258:63: error: invalid use of undefined type 'struct perf_evsel'
>   258 |         if (perf_evsel__alloc_mmap(evsel, xyarray__max_x(evsel->f=
d), xyarray__max_y(evsel->fd)) < 0)
>       |                                                               ^~
> evsel.c:258:90: error: invalid use of undefined type 'struct perf_evsel'
>   258 |         if (perf_evsel__alloc_mmap(evsel, xyarray__max_x(evsel->f=
d), xyarray__max_y(evsel->fd)) < 0)
>       |                                                                  =
                        ^~
> evsel.c:261:49: error: invalid use of undefined type 'struct perf_evsel'
>   261 |         for (idx =3D 0; idx < xyarray__max_x(evsel->fd); idx++) {
>       |                                                 ^~
> evsel.c:262:63: error: invalid use of undefined type 'struct perf_evsel'
>   262 |                 for (thread =3D 0; thread < xyarray__max_y(evsel-=
>fd); thread++) {
>       |                                                               ^~
> evsel.c:49:38: error: invalid use of undefined type 'struct perf_evsel'
>    49 |         ((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread)=
)
>       |                                      ^~
> evsel.c:263:35: note: in expansion of macro 'FD'
>   263 |                         int *fd =3D FD(evsel, idx, thread);
>       |                                   ^~
> evsel.c:265:70: error: invalid use of undefined type 'struct perf_evsel'
>   265 |                         struct perf_cpu cpu =3D perf_cpu_map__cpu=
(evsel->cpus, idx);
>       |                                                                  =
    ^~
> evsel.c:51:16: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                ^~
> evsel.c:270:31: note: in expansion of macro 'MMAP'
>   270 |                         map =3D MMAP(evsel, idx, thread);
>       |                               ^~~~
> evsel.c:51:68: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                                                                  =
  ^~
> evsel.c:270:31: note: in expansion of macro 'MMAP'
>   270 |                         map =3D MMAP(evsel, idx, thread);
>       |                               ^~~~
> evsel.c: In function 'perf_evsel__mmap_base':
> evsel.c:49:38: error: invalid use of undefined type 'struct perf_evsel'
>    49 |         ((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread)=
)
>       |                                      ^~
> evsel.c:286:19: note: in expansion of macro 'FD'
>   286 |         int *fd =3D FD(evsel, cpu_map_idx, thread);
>       |                   ^~
> evsel.c:51:16: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                ^~
> evsel.c:288:38: note: in expansion of macro 'MMAP'
>   288 |         if (fd =3D=3D NULL || *fd < 0 || MMAP(evsel, cpu_map_idx,=
 thread) =3D=3D NULL)
>       |                                      ^~~~
> evsel.c:51:68: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                                                                  =
  ^~
> evsel.c:288:38: note: in expansion of macro 'MMAP'
>   288 |         if (fd =3D=3D NULL || *fd < 0 || MMAP(evsel, cpu_map_idx,=
 thread) =3D=3D NULL)
>       |                                      ^~~~
> evsel.c:51:16: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                ^~
> evsel.c:291:16: note: in expansion of macro 'MMAP'
>   291 |         return MMAP(evsel, cpu_map_idx, thread)->base;
>       |                ^~~~
> evsel.c:51:68: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                                                                  =
  ^~
> evsel.c:291:16: note: in expansion of macro 'MMAP'
>   291 |         return MMAP(evsel, cpu_map_idx, thread)->base;
>       |                ^~~~
> evsel.c: At top level:
> evsel.c:294:5: error: no previous prototype for 'perf_evsel__read_size' [=
-Werror=3Dmissing-prototypes]
>   294 | int perf_evsel__read_size(struct perf_evsel *evsel)
>       |     ^~~~~~~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__read_size':
> evsel.c:296:32: error: invalid use of undefined type 'struct perf_evsel'
>   296 |         u64 read_format =3D evsel->attr.read_format;
>       |                                ^~
> evsel.c:301:27: error: 'PERF_FORMAT_TOTAL_TIME_ENABLED' undeclared (first=
 use in this function)
>   301 |         if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> evsel.c:301:27: note: each undeclared identifier is reported only once fo=
r each function it appears in
> evsel.c:304:27: error: 'PERF_FORMAT_TOTAL_TIME_RUNNING' undeclared (first=
 use in this function)
>   304 |         if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> evsel.c:307:27: error: 'PERF_FORMAT_ID' undeclared (first use in this fun=
ction)
>   307 |         if (read_format & PERF_FORMAT_ID)
>       |                           ^~~~~~~~~~~~~~
> evsel.c:310:27: error: 'PERF_FORMAT_LOST' undeclared (first use in this f=
unction)
>   310 |         if (read_format & PERF_FORMAT_LOST)
>       |                           ^~~~~~~~~~~~~~~~
> evsel.c:313:27: error: 'PERF_FORMAT_GROUP' undeclared (first use in this =
function)
>   313 |         if (read_format & PERF_FORMAT_GROUP) {
>       |                           ^~~~~~~~~~~~~~~~~
> evsel.c:314:27: error: invalid use of undefined type 'struct perf_evsel'
>   314 |                 nr =3D evsel->nr_members;
>       |                           ^~
> evsel.c: In function 'perf_evsel__read_group':
> evsel.c:49:38: error: invalid use of undefined type 'struct perf_evsel'
>    49 |         ((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread)=
)
>       |                                      ^~
> evsel.c:327:19: note: in expansion of macro 'FD'
>   327 |         int *fd =3D FD(evsel, cpu_map_idx, thread);
>       |                   ^~
> evsel.c:328:32: error: invalid use of undefined type 'struct perf_evsel'
>   328 |         u64 read_format =3D evsel->attr.read_format;
>       |                                ^~
> evsel.c:348:27: error: 'PERF_FORMAT_TOTAL_TIME_ENABLED' undeclared (first=
 use in this function)
>   348 |         if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> evsel.c:350:27: error: 'PERF_FORMAT_TOTAL_TIME_RUNNING' undeclared (first=
 use in this function)
>   350 |         if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> evsel.c:355:27: error: 'PERF_FORMAT_ID' undeclared (first use in this fun=
ction)
>   355 |         if (read_format & PERF_FORMAT_ID)
>       |                           ^~~~~~~~~~~~~~
> evsel.c:357:27: error: 'PERF_FORMAT_LOST' undeclared (first use in this f=
unction)
>   357 |         if (read_format & PERF_FORMAT_LOST)
>       |                           ^~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__adjust_values':
> evsel.c:371:32: error: invalid use of undefined type 'struct perf_evsel'
>   371 |         u64 read_format =3D evsel->attr.read_format;
>       |                                ^~
> evsel.c:376:27: error: 'PERF_FORMAT_TOTAL_TIME_ENABLED' undeclared (first=
 use in this function)
>   376 |         if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   CC      /tmp/build/perf/libsubcmd/subcmd-config.o
> evsel.c:379:27: error: 'PERF_FORMAT_TOTAL_TIME_RUNNING' undeclared (first=
 use in this function)
>   379 |         if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   CC      /tmp/build/perf/libbpf/staticobjs/libbpf.o
> evsel.c:382:27: error: 'PERF_FORMAT_ID' undeclared (first use in this fun=
ction)
>   382 |         if (read_format & PERF_FORMAT_ID)
>       |                           ^~~~~~~~~~~~~~
> evsel.c:385:27: error: 'PERF_FORMAT_LOST' undeclared (first use in this f=
unction)
>   385 |         if (read_format & PERF_FORMAT_LOST)
>       |                           ^~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__read':
> evsel.c:49:38: error: invalid use of undefined type 'struct perf_evsel'
>    49 |         ((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread)=
)
>       |                                      ^~
> evsel.c:393:19: note: in expansion of macro 'FD'
>   393 |         int *fd =3D FD(evsel, cpu_map_idx, thread);
>       |                   ^~
> evsel.c:394:32: error: invalid use of undefined type 'struct perf_evsel'
>   394 |         u64 read_format =3D evsel->attr.read_format;
>       |                                ^~
> evsel.c:402:27: error: 'PERF_FORMAT_GROUP' undeclared (first use in this =
function)
>   402 |         if (read_format & PERF_FORMAT_GROUP)
>       |                           ^~~~~~~~~~~~~~~~~
> evsel.c:51:16: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                ^~
> evsel.c:405:13: note: in expansion of macro 'MMAP'
>   405 |         if (MMAP(evsel, cpu_map_idx, thread) &&
>       |             ^~~~
> evsel.c:51:68: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                                                                  =
  ^~
> evsel.c:405:13: note: in expansion of macro 'MMAP'
>   405 |         if (MMAP(evsel, cpu_map_idx, thread) &&
>       |             ^~~~
> evsel.c:406:30: error: 'PERF_FORMAT_ID' undeclared (first use in this fun=
ction)
>   406 |             !(read_format & (PERF_FORMAT_ID | PERF_FORMAT_LOST)) =
&&
>       |                              ^~~~~~~~~~~~~~
> evsel.c:406:47: error: 'PERF_FORMAT_LOST' undeclared (first use in this f=
unction)
>   406 |             !(read_format & (PERF_FORMAT_ID | PERF_FORMAT_LOST)) =
&&
>       |                                               ^~~~~~~~~~~~~~~~
> evsel.c:51:16: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                ^~
> evsel.c:407:35: note: in expansion of macro 'MMAP'
>   407 |             !perf_mmap__read_self(MMAP(evsel, cpu_map_idx, thread=
), count))
>       |                                   ^~~~
> evsel.c:51:68: error: invalid use of undefined type 'struct perf_evsel'
>    51 |         (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evs=
el->mmap, _cpu_map_idx, _thread)) \
>       |                                                                  =
  ^~
> evsel.c:407:35: note: in expansion of macro 'MMAP'
>   407 |             !perf_mmap__read_self(MMAP(evsel, cpu_map_idx, thread=
), count))
>       |                                   ^~~~
> evsel.c: In function 'perf_evsel__ioctl':
> evsel.c:49:38: error: invalid use of undefined type 'struct perf_evsel'
>    49 |         ((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread)=
)
>       |                                      ^~
> evsel.c:420:19: note: in expansion of macro 'FD'
>   420 |         int *fd =3D FD(evsel, cpu_map_idx, thread);
>       |                   ^~
> evsel.c: In function 'perf_evsel__run_ioctl':
> evsel.c:434:55: error: invalid use of undefined type 'struct perf_evsel'
>   434 |         for (thread =3D 0; thread < xyarray__max_y(evsel->fd); th=
read++) {
>       |                                                       ^~
>   INSTALL /tmp/build/perf/libperf/include/internal/xyarray.h
> evsel.c: In function 'perf_evsel__enable_cpu':
> evsel.c:446:45: error: 'PERF_EVENT_IOC_ENABLE' undeclared (first use in t=
his function)
>   446 |         return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE=
, NULL, cpu_map_idx);
>       |                                             ^~~~~~~~~~~~~~~~~~~~~
> In file included from evsel.c:6:
> evsel.c: In function 'perf_evsel__enable_thread':
> evsel.c:455:51: error: invalid use of undefined type 'struct perf_evsel'
>   455 |         perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
>       |                                                   ^~
> /tmp/build/perf/libperf/include/perf/cpumap.h:89:51: note: in definition =
of macro 'perf_cpu_map__for_each_cpu'
>    89 |         for ((idx) =3D 0, (cpu) =3D perf_cpu_map__cpu(cpus, idx);=
   \
>       |                                                   ^~~~
> evsel.c:455:51: error: invalid use of undefined type 'struct perf_evsel'
>   455 |         perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
>       |                                                   ^~
> /tmp/build/perf/libperf/include/perf/cpumap.h:90:39: note: in definition =
of macro 'perf_cpu_map__for_each_cpu'
>    90 |              (idx) < perf_cpu_map__nr(cpus);                    \
>       |                                       ^~~~
> evsel.c:455:51: error: invalid use of undefined type 'struct perf_evsel'
>   455 |         perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
>       |                                                   ^~
> /tmp/build/perf/libperf/include/perf/cpumap.h:91:49: note: in definition =
of macro 'perf_cpu_map__for_each_cpu'
>    91 |              (idx)++, (cpu) =3D perf_cpu_map__cpu(cpus, idx))
>       |                                                 ^~~~
> evsel.c:456:48: error: 'PERF_EVENT_IOC_ENABLE' undeclared (first use in t=
his function)
>   456 |                 err =3D perf_evsel__ioctl(evsel, PERF_EVENT_IOC_E=
NABLE, NULL, idx, thread);
>       |                                                ^~~~~~~~~~~~~~~~~~=
~~~
> evsel.c: In function 'perf_evsel__enable':
> evsel.c:469:45: error: invalid use of undefined type 'struct perf_evsel'
>   469 |         for (i =3D 0; i < xyarray__max_x(evsel->fd) && !err; i++)
>       |                                             ^~
> evsel.c:470:52: error: 'PERF_EVENT_IOC_ENABLE' undeclared (first use in t=
his function)
>   470 |                 err =3D perf_evsel__run_ioctl(evsel, PERF_EVENT_I=
OC_ENABLE, NULL, i);
>       |                                                    ^~~~~~~~~~~~~~=
~~~~~~~
> evsel.c: In function 'perf_evsel__disable_cpu':
> evsel.c:476:45: error: 'PERF_EVENT_IOC_DISABLE' undeclared (first use in =
this function)
>   476 |         return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABL=
E, NULL, cpu_map_idx);
>       |                                             ^~~~~~~~~~~~~~~~~~~~~=
~
> evsel.c: In function 'perf_evsel__disable':
> evsel.c:484:45: error: invalid use of undefined type 'struct perf_evsel'
>   484 |         for (i =3D 0; i < xyarray__max_x(evsel->fd) && !err; i++)
>       |                                             ^~
> evsel.c:485:52: error: 'PERF_EVENT_IOC_DISABLE' undeclared (first use in =
this function)
>   485 |                 err =3D perf_evsel__run_ioctl(evsel, PERF_EVENT_I=
OC_DISABLE, NULL, i);
>       |                                                    ^~~~~~~~~~~~~~=
~~~~~~~~
> evsel.c: At top level:
> evsel.c:489:5: error: no previous prototype for 'perf_evsel__apply_filter=
' [-Werror=3Dmissing-prototypes]
>   489 | int perf_evsel__apply_filter(struct perf_evsel *evsel, const char=
 *filter)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__apply_filter':
> evsel.c:493:47: error: invalid use of undefined type 'struct perf_evsel'
>   493 |         for (i =3D 0; i < perf_cpu_map__nr(evsel->cpus) && !err; =
i++)
>       |                                               ^~
> evsel.c:495:38: error: 'PERF_EVENT_IOC_SET_FILTER' undeclared (first use =
in this function)
>   495 |                                      PERF_EVENT_IOC_SET_FILTER,
>       |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__cpus':
> evsel.c:502:21: error: invalid use of undefined type 'struct perf_evsel'
>   502 |         return evsel->cpus;
>       |                     ^~
> evsel.c: In function 'perf_evsel__threads':
> evsel.c:507:21: error: invalid use of undefined type 'struct perf_evsel'
>   507 |         return evsel->threads;
>       |                     ^~
> evsel.c: In function 'perf_evsel__attr':
> evsel.c:512:22: error: invalid use of undefined type 'struct perf_evsel'
>   512 |         return &evsel->attr;
>       |                      ^~
> evsel.c: At top level:
> evsel.c:515:5: error: no previous prototype for 'perf_evsel__alloc_id' [-=
Werror=3Dmissing-prototypes]
>   515 | int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int=
 nthreads)
>       |     ^~~~~~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__alloc_id':
> evsel.c:520:14: error: invalid use of undefined type 'struct perf_evsel'
>   520 |         evsel->sample_id =3D xyarray__new(ncpus, nthreads, sizeof=
(struct perf_sample_id));
>       |              ^~
> evsel.c:520:65: error: invalid application of 'sizeof' to incomplete type=
 'struct perf_sample_id'
>   520 |         evsel->sample_id =3D xyarray__new(ncpus, nthreads, sizeof=
(struct perf_sample_id));
>       |                                                                 ^=
~~~~~
> evsel.c:521:18: error: invalid use of undefined type 'struct perf_evsel'
>   521 |         if (evsel->sample_id =3D=3D NULL)
>       |                  ^~
> evsel.c:524:14: error: invalid use of undefined type 'struct perf_evsel'
>   524 |         evsel->id =3D zalloc(ncpus * nthreads * sizeof(u64));
>       |              ^~
> evsel.c:525:18: error: invalid use of undefined type 'struct perf_evsel'
>   525 |         if (evsel->id =3D=3D NULL) {
>       |                  ^~
> evsel.c:526:38: error: invalid use of undefined type 'struct perf_evsel'
>   526 |                 xyarray__delete(evsel->sample_id);
>       |                                      ^~
> evsel.c:527:22: error: invalid use of undefined type 'struct perf_evsel'
>   527 |                 evsel->sample_id =3D NULL;
>       |                      ^~
> evsel.c: At top level:
> evsel.c:534:6: error: no previous prototype for 'perf_evsel__free_id' [-W=
error=3Dmissing-prototypes]
>   534 | void perf_evsel__free_id(struct perf_evsel *evsel)
>       |      ^~~~~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__free_id':
> evsel.c:538:30: error: invalid use of undefined type 'struct perf_evsel'
>   538 |         xyarray__delete(evsel->sample_id);
>       |                              ^~
> evsel.c:539:14: error: invalid use of undefined type 'struct perf_evsel'
>   539 |         evsel->sample_id =3D NULL;
>       |              ^~
> In file included from evsel.c:11:
> evsel.c:540:21: error: invalid use of undefined type 'struct perf_evsel'
>   540 |         zfree(&evsel->id);
>       |                     ^~
> /git/perf-6.15.0-rc2/tools/include/linux/zalloc.h:10:38: note: in definit=
ion of macro 'zfree'
>    10 | #define zfree(ptr) __zfree((void **)(ptr))
>       |                                      ^~~
> evsel.c:541:14: error: invalid use of undefined type 'struct perf_evsel'
>   541 |         evsel->ids =3D 0;
>       |              ^~
> evsel.c:543:9: error: implicit declaration of function 'perf_evsel_for_ea=
ch_per_thread_period_safe' [-Werror=3Dimplicit-function-declaration]
>   543 |         perf_evsel_for_each_per_thread_period_safe(evsel, n, pos)=
 {
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> evsel.c:543:9: error: nested extern declaration of 'perf_evsel_for_each_p=
er_thread_period_safe' [-Werror=3Dnested-externs]
> evsel.c:543:66: error: expected ';' before '{' token
>   543 |         perf_evsel_for_each_per_thread_period_safe(evsel, n, pos)=
 {
>       |                                                                  =
^~
>       |                                                                  =
;
> evsel.c: At top level:
> evsel.c:549:6: error: no previous prototype for 'perf_evsel__attr_has_per=
_thread_sample_period' [-Werror=3Dmissing-prototypes]
>   549 | bool perf_evsel__attr_has_per_thread_sample_period(struct perf_ev=
sel *evsel)
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_evsel__attr_has_per_thread_sample_period':
> evsel.c:551:22: error: invalid use of undefined type 'struct perf_evsel'
>   551 |         return (evsel->attr.sample_type & PERF_SAMPLE_READ) &&
>       |                      ^~
> evsel.c:551:43: error: 'PERF_SAMPLE_READ' undeclared (first use in this f=
unction)
>   551 |         return (evsel->attr.sample_type & PERF_SAMPLE_READ) &&
>       |                                           ^~~~~~~~~~~~~~~~
> evsel.c:552:23: error: invalid use of undefined type 'struct perf_evsel'
>   552 |                 (evsel->attr.sample_type & PERF_SAMPLE_TID) &&
>       |                       ^~
> evsel.c:552:44: error: 'PERF_SAMPLE_TID' undeclared (first use in this fu=
nction); did you mean 'PERF_SAMPLE_MAX_SIZE'?
>   552 |                 (evsel->attr.sample_type & PERF_SAMPLE_TID) &&
>       |                                            ^~~~~~~~~~~~~~~
>       |                                            PERF_SAMPLE_MAX_SIZE
> evsel.c:553:22: error: invalid use of undefined type 'struct perf_evsel'
>   553 |                 evsel->attr.inherit;
>       |                      ^~
> evsel.c: At top level:
> evsel.c:556:48: error: 'struct perf_sample_id' declared inside parameter =
list will not be visible outside of this definition or declaration [-Werror=
]
>   556 | u64 *perf_sample_id__get_period_storage(struct perf_sample_id *si=
d, u32 tid, bool per_thread)
>       |                                                ^~~~~~~~~~~~~~
> evsel.c:556:6: error: no previous prototype for 'perf_sample_id__get_peri=
od_storage' [-Werror=3Dmissing-prototypes]
>   556 | u64 *perf_sample_id__get_period_storage(struct perf_sample_id *si=
d, u32 tid, bool per_thread)
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> evsel.c: In function 'perf_sample_id__get_period_storage':
> evsel.c:563:28: error: invalid use of undefined type 'struct perf_sample_=
id'
>   563 |                 return &sid->period;
>       |                            ^~
> evsel.c:565:29: error: 'PERF_SAMPLE_ID__HLIST_BITS' undeclared (first use=
 in this function)
>   565 |         hash =3D hash_32(tid, PERF_SAMPLE_ID__HLIST_BITS);
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> evsel.c:566:20: error: invalid use of undefined type 'struct perf_sample_=
id'
>   566 |         head =3D &sid->periods[hash];
>       |                    ^~
> In file included from /git/perf-6.15.0-rc2/tools/include/linux/kernel.h:1=
4,
>                  from /git/perf-6.15.0-rc2/tools/include/linux/list.h:7,
>                  from evsel.c:9:
> /git/perf-6.15.0-rc2/tools/include/linux/container_of.h:14:33: error: inv=
alid use of undefined type 'struct perf_sample_id_period'
>    14 |         const typeof(((type *)0)->member) * __mptr =3D (ptr);    =
 \
>       |                                 ^~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:705:40: note: in expansio=
n of macro 'container_of'
>   705 | #define hlist_entry(ptr, type, member) container_of(ptr,type,memb=
er)
>       |                                        ^~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:716:22: note: in expansio=
n of macro 'hlist_entry'
>   716 |            ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
>       |                      ^~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:726:20: note: in expansio=
n of macro 'hlist_entry_safe'
>   726 |         for (pos =3D hlist_entry_safe((head)->first, typeof(*(pos=
)), member);\
>       |                    ^~~~~~~~~~~~~~~~
> evsel.c:568:9: note: in expansion of macro 'hlist_for_each_entry'
>   568 |         hlist_for_each_entry(res, head, hnode)
>       |         ^~~~~~~~~~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/container_of.h:14:54: error: ini=
tialization of 'const int *' from incompatible pointer type 'struct hlist_n=
ode *' [-Werror=3Dincompatible-pointer-types]
>    14 |         const typeof(((type *)0)->member) * __mptr =3D (ptr);    =
 \
>       |                                                      ^
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:705:40: note: in expansio=
n of macro 'container_of'
>   705 | #define hlist_entry(ptr, type, member) container_of(ptr,type,memb=
er)
>       |                                        ^~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:716:22: note: in expansio=
n of macro 'hlist_entry'
>   716 |            ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
>       |                      ^~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:726:20: note: in expansio=
n of macro 'hlist_entry_safe'
>   726 |         for (pos =3D hlist_entry_safe((head)->first, typeof(*(pos=
)), member);\
>       |                    ^~~~~~~~~~~~~~~~
> evsel.c:568:9: note: in expansion of macro 'hlist_for_each_entry'
>   568 |         hlist_for_each_entry(res, head, hnode)
>       |         ^~~~~~~~~~~~~~~~~~~~
> In file included from /usr/include/sys/mman.h:25,
>                  from evsel.c:20:
> /git/perf-6.15.0-rc2/tools/include/linux/container_of.h:15:35: error: inv=
alid use of undefined type 'struct perf_sample_id_period'
>    15 |         (type *)((char *)__mptr - offsetof(type, member)); })
>       |                                   ^~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:705:40: note: in expansio=
n of macro 'container_of'
>   705 | #define hlist_entry(ptr, type, member) container_of(ptr,type,memb=
er)
>       |                                        ^~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:716:22: note: in expansio=
n of macro 'hlist_entry'
>   716 |            ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
>       |                      ^~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:726:20: note: in expansio=
n of macro 'hlist_entry_safe'
>   726 |         for (pos =3D hlist_entry_safe((head)->first, typeof(*(pos=
)), member);\
>       |                    ^~~~~~~~~~~~~~~~
> evsel.c:568:9: note: in expansion of macro 'hlist_for_each_entry'
>   568 |         hlist_for_each_entry(res, head, hnode)
>       |         ^~~~~~~~~~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:728:42: error: invalid us=
e of undefined type 'struct perf_sample_id_period'
>   728 |              pos =3D hlist_entry_safe((pos)->member.next, typeof(=
*(pos)), member))
>       |                                          ^~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:715:19: note: in definiti=
on of macro 'hlist_entry_safe'
>   715 |         ({ typeof(ptr) ____ptr =3D (ptr); \
>       |                   ^~~
> evsel.c:568:9: note: in expansion of macro 'hlist_for_each_entry'
>   568 |         hlist_for_each_entry(res, head, hnode)
>       |         ^~~~~~~~~~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:728:42: error: invalid us=
e of undefined type 'struct perf_sample_id_period'
>   728 |              pos =3D hlist_entry_safe((pos)->member.next, typeof(=
*(pos)), member))
>       |                                          ^~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:715:35: note: in definiti=
on of macro 'hlist_entry_safe'
>   715 |         ({ typeof(ptr) ____ptr =3D (ptr); \
>       |                                   ^~~
> evsel.c:568:9: note: in expansion of macro 'hlist_for_each_entry'
>   568 |         hlist_for_each_entry(res, head, hnode)
>       |         ^~~~~~~~~~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/container_of.h:14:33: error: inv=
alid use of undefined type 'struct perf_sample_id_period'
>    14 |         const typeof(((type *)0)->member) * __mptr =3D (ptr);    =
 \
>       |                                 ^~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:705:40: note: in expansio=
n of macro 'container_of'
>   705 | #define hlist_entry(ptr, type, member) container_of(ptr,type,memb=
er)
>       |                                        ^~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:716:22: note: in expansio=
n of macro 'hlist_entry'
>   716 |            ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
>       |                      ^~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:728:20: note: in expansio=
n of macro 'hlist_entry_safe'
>   728 |              pos =3D hlist_entry_safe((pos)->member.next, typeof(=
*(pos)), member))
>       |                    ^~~~~~~~~~~~~~~~
> evsel.c:568:9: note: in expansion of macro 'hlist_for_each_entry'
>   568 |         hlist_for_each_entry(res, head, hnode)
>       |         ^~~~~~~~~~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/container_of.h:14:54: error: ini=
tialization of 'const int *' from 'int' makes pointer from integer without =
a cast [-Werror=3Dint-conversion]
>    14 |         const typeof(((type *)0)->member) * __mptr =3D (ptr);    =
 \
>       |                                                      ^
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:705:40: note: in expansio=
n of macro 'container_of'
>   705 | #define hlist_entry(ptr, type, member) container_of(ptr,type,memb=
er)
>       |                                        ^~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:716:22: note: in expansio=
n of macro 'hlist_entry'
>   716 |            ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
>       |                      ^~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:728:20: note: in expansio=
n of macro 'hlist_entry_safe'
>   728 |              pos =3D hlist_entry_safe((pos)->member.next, typeof(=
*(pos)), member))
>       |                    ^~~~~~~~~~~~~~~~
> evsel.c:568:9: note: in expansion of macro 'hlist_for_each_entry'
>   568 |         hlist_for_each_entry(res, head, hnode)
>       |         ^~~~~~~~~~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/container_of.h:15:35: error: inv=
alid use of undefined type 'struct perf_sample_id_period'
>    15 |         (type *)((char *)__mptr - offsetof(type, member)); })
>       |                                   ^~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:705:40: note: in expansio=
n of macro 'container_of'
>   705 | #define hlist_entry(ptr, type, member) container_of(ptr,type,memb=
er)
>       |                                        ^~~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:716:22: note: in expansio=
n of macro 'hlist_entry'
>   716 |            ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
>       |                      ^~~~~~~~~~~
> /git/perf-6.15.0-rc2/tools/include/linux/list.h:728:20: note: in expansio=
n of macro 'hlist_entry_safe'
>   728 |              pos =3D hlist_entry_safe((pos)->member.next, typeof(=
*(pos)), member))
>       |                    ^~~~~~~~~~~~~~~~
> evsel.c:568:9: note: in expansion of macro 'hlist_for_each_entry'
>   568 |         hlist_for_each_entry(res, head, hnode)
>       |         ^~~~~~~~~~~~~~~~~~~~
> evsel.c:569:24: error: invalid use of undefined type 'struct perf_sample_=
id_period'
>   569 |                 if (res->tid =3D=3D tid)
>       |                        ^~
> evsel.c:570:36: error: invalid use of undefined type 'struct perf_sample_=
id_period'
>   570 |                         return &res->period;
>       |                                    ^~
> evsel.c:572:16: error: invalid use of undefined type 'struct perf_sample_=
id'
>   572 |         if (sid->evsel =3D=3D NULL)
>       |                ^~
> evsel.c:575:29: error: invalid application of 'sizeof' to incomplete type=
 'struct perf_sample_id_period'
>   575 |         res =3D zalloc(sizeof(struct perf_sample_id_period));
>       |                             ^~~~~~
> evsel.c:579:28: error: invalid use of undefined type 'struct perf_sample_=
id_period'
>   579 |         INIT_LIST_HEAD(&res->node);
>       |                            ^~
> evsel.c:580:12: error: invalid use of undefined type 'struct perf_sample_=
id_period'
>   580 |         res->tid =3D tid;
>       |            ^~
> evsel.c:582:27: error: invalid use of undefined type 'struct perf_sample_=
id_period'
>   582 |         list_add_tail(&res->node, &sid->evsel->per_stream_periods=
);
>       |                           ^~
> evsel.c:582:39: error: invalid use of undefined type 'struct perf_sample_=
id'
>   582 |         list_add_tail(&res->node, &sid->evsel->per_stream_periods=
);
>       |                                       ^~
> evsel.c:583:28: error: invalid use of undefined type 'struct perf_sample_=
id_period'
>   583 |         hlist_add_head(&res->hnode, &sid->periods[hash]);
>       |                            ^~
> evsel.c:583:41: error: invalid use of undefined type 'struct perf_sample_=
id'
>   583 |         hlist_add_head(&res->hnode, &sid->periods[hash]);
>       |                                         ^~
> evsel.c:585:20: error: invalid use of undefined type 'struct perf_sample_=
id_period'
>   585 |         return &res->period;
>       |                    ^~
> evsel.c:560:13: error: variable 'hash' set but not used [-Werror=3Dunused=
-but-set-variable]
>   560 |         int hash;
>       |             ^~~~
> evsel.c: In function 'perf_evsel__alloc_fd':
> evsel.c:72:1: error: control reaches end of non-void function [-Werror=3D=
return-type]
>    72 | }
>       | ^
> evsel.c: In function 'perf_evsel__mmap_base':
> evsel.c:292:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>   292 | }
>       | ^
> evsel.c: In function 'perf_evsel__enable_cpu':
> evsel.c:447:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>   447 | }
>       | ^
> evsel.c: In function 'perf_evsel__disable_cpu':
> evsel.c:477:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>   477 | }
>       | ^
> evsel.c: In function 'perf_evsel__cpus':
> evsel.c:503:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>   503 | }
>       | ^
> evsel.c: In function 'perf_evsel__threads':
> evsel.c:508:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>   508 | }
>       | ^
> evsel.c: In function 'perf_evsel__attr':
> evsel.c:513:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>   513 | }
>       | ^
> evsel.c: In function 'perf_evsel__attr_has_per_thread_sample_period':
> evsel.c:554:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>   554 | }
>       | ^
> evsel.c: In function 'perf_sample_id__get_period_storage':
> evsel.c:586:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
>   586 | }
>       | ^
> cc1: all warnings being treated as errors
> make[4]: *** [/git/perf-6.15.0-rc2/tools/build/Makefile.build:85: /tmp/bu=
ild/perf/libperf/evsel.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   LD      /tmp/build/perf/jvmti/jvmti-in.o
>   CC      /tmp/build/perf/libbpf/staticobjs/bpf.o
>   INSTALL libperf_headers
>   CC      /tmp/build/perf/libbpf/staticobjs/nlattr.o
>   LD      /tmp/build/perf/libapi/libapi-in.o
>   AR      /tmp/build/perf/libapi/libapi.a
>   CC      /tmp/build/perf/libbpf/staticobjs/libbpf_errno.o
>   CC      /tmp/build/perf/libbpf/staticobjs/btf.o
>   CC      /tmp/build/perf/libbpf/staticobjs/str_error.o
>   CC      /tmp/build/perf/libbpf/staticobjs/netlink.o
>   CC      /tmp/build/perf/libbpf/staticobjs/bpf_prog_linfo.o
>   CC      /tmp/build/perf/libbpf/staticobjs/libbpf_probes.o
>   CC      /tmp/build/perf/libbpf/staticobjs/btf_dump.o
>   CC      /tmp/build/perf/libbpf/staticobjs/ringbuf.o
>   CC      /tmp/build/perf/libbpf/staticobjs/hashmap.o
>   CC      /tmp/build/perf/libbpf/staticobjs/strset.o
>   CC      /tmp/build/perf/libbpf/staticobjs/linker.o
>   CC      /tmp/build/perf/libbpf/staticobjs/gen_loader.o
>   CC      /tmp/build/perf/libbpf/staticobjs/usdt.o
>   CC      /tmp/build/perf/libbpf/staticobjs/relo_core.o
>   CC      /tmp/build/perf/libbpf/staticobjs/zip.o
>   CC      /tmp/build/perf/libbpf/staticobjs/elf.o
>   CC      /tmp/build/perf/libbpf/staticobjs/btf_iter.o
>   CC      /tmp/build/perf/libbpf/staticobjs/features.o
>   CC      /tmp/build/perf/libbpf/staticobjs/btf_relocate.o
> make[3]: *** [Makefile:103: /tmp/build/perf/libperf/libperf-in.o] Error 2
> make[2]: *** [Makefile.perf:976: /tmp/build/perf/libperf/libperf.a] Error=
 2
> make[2]: *** Waiting for unfinished jobs....
>   LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
>   AR      /tmp/build/perf/libsubcmd/libsubcmd.a
>   LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
>   LINK    /tmp/build/perf/libbpf/libbpf.a
>
> Auto-detecting system features:
> ...                         clang-bpf-co-re: [ on  ]
> ...                                    llvm: [ on  ]
> ...                                  libcap: [ on  ]
> ...                                  libbfd: [ on  ]
>
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/hashmap.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/relo_core.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/libbpf_internal.h
>   GEN     /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/bpf_helper_=
defs.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/bpf.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/libbpf.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/btf.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/libbpf_legacy.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/libbpf_common.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/bpf_helpers.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/bpf_tracing.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/bpf_core_read.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/bpf_endian.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/libbpf_version.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/skel_internal.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/usdt.bpf.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf=
/bpf_helper_defs.h
>   INSTALL libbpf_headers
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
bpf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
libbpf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
nlattr.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
btf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
libbpf_errno.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
str_error.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
netlink.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
bpf_prog_linfo.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
libbpf_probes.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
hashmap.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
btf_dump.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
ringbuf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
strset.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
linker.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
gen_loader.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
zip.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
usdt.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
relo_core.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
btf_relocate.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
elf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
features.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
btf_iter.o
>   LD      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/=
libbpf-in.o
>   LINK    /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/main.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/common.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/json_writer.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/gen.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/btf.o
>   LINK    /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/bpftool
> make[1]: *** [Makefile.perf:287: sub-make] Error 2
> make: *** [Makefile:76: all] Error 2
> make: Leaving directory '/git/perf-6.15.0-rc2/tools/perf'
> + exit 1
> toolsbuilder@number:~/git/linux-tools-container-builds$
>
>

