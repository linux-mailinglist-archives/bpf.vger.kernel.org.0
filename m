Return-Path: <bpf+bounces-59017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C75AC5B8B
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 22:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51276189E948
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4216207A20;
	Tue, 27 May 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M17i4zQX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6331DE8B2
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748378736; cv=none; b=rPcMFHU1K0+TJsZ8RHBxD6vNI411g9pBQB/FuiO0HY5jVSUZyoBSHuhGrykM+6mJYnKze0asP1CXDvNk/9f0U4h2gStkLL309B/Rn4s1lppscrLBRuxaCu3BW6VzdcNeTu+JhnvJ49RNAJ0qTvT8MtqZcZI0qNkCw35RJEqhqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748378736; c=relaxed/simple;
	bh=ojQuWHvF8rZEVY+sEWY4ziynivY/y9i+cK6pzvUTgW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsskURkFhbxsikNrZEUdJePQbHOBu8RB2mbbzjm5ekhLKnDN1IGybweBcAT1obQtBJQAYbfiln11/R9NqZgxCGKUku2l02L6otEVms4QmPFNr1GE+M/xjTecKeCYPmwVoWG2L/3bpLyY7wtQ0KGVdddFnB0Dt26/dtSKlr7nURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M17i4zQX; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3dd745f8839so41085ab.0
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748378734; x=1748983534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1lZ4BzKKyegj1CKtUN+j6GoUwIXKlqYC5bRVEDeUlo=;
        b=M17i4zQX18pB0OkjM7gq8T24vODM00juNvf/mX868k9KhoTx9B7Ptg1ffOnHmNGxlI
         2vfVysQyttps27+aMexQ/lTWG8hvxr0cs3oW0V6IyPeoHNLPyUnj/+kQziUTdkpGkpPb
         M1e3jrWicHvJCscIFd8rj6IZ5uHpvP+5djFMT+LIbvkmkS20jMwX8GYRiFJ/tU74I1kP
         PHNqwsWcCBGmPLrOX4a8E4pp2I1uKPKo2iNuctHBNFzub18Npm6b2hZHkzJuIzQKcBQV
         Adw47RKieC//RtOi1qa3yCp0rQ4qEYZiACDv5J6uzXTQ/CdpWf/7c5GSYcFcd6t9x8Tx
         shbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748378734; x=1748983534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1lZ4BzKKyegj1CKtUN+j6GoUwIXKlqYC5bRVEDeUlo=;
        b=YOoNd9XiL+TJHRdTaAvigeCI861/TdCd3cfurHqG58BUk7HcFxli98EAHJTWGZaGg2
         spgkz9Aa//VbjJ1koT7NUrcAi/8p/+jzIWdTXmEW4KepVasZohan2D4uU9DZKju2GsMP
         qlqWZHV2Un1PpvpwZ3/PzvnYeHMDAuP6MzwiD8/gk3HwTvvynsvpZ37oDX8rShMRGci9
         xYTw8cDKuSK5TGha1NL9LQ+klWzU0me3Atu20lBQOVk8+3s1IsGGP6BgYCpm3bVbIMMF
         dZgxaOd0kQThuYOn/Bft+9aK7Lpmh0POTjk7Sir+AE0Z4KC+TA1gp644K/o6wFPjWSdB
         Y9xg==
X-Forwarded-Encrypted: i=1; AJvYcCVY5oh+qAsJ91Llcfo6MqMfWFEM/XqTjvyEC103g+FpW+DglgEKtvIMyaF7ZLwi7fxArRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXsOYSf028ThJpZwkUynhPB4Gk579byUTAAI+EpzbQ4p7tuIbb
	KiBZZ6GfcN+pWqzBYkdmyQ8gfJ13iIja9qp3nYmgHBBXdiFHUS4i7lo1OonYqfZyh0nE8vZ0u7w
	nxXsvErqVy2880Ls13Nu2hhXAkMcjRtlo8GidsGJU
X-Gm-Gg: ASbGncuGEo+30RgK2/4evUao7RkhvPs27zFg07GTgvJPCejIfg0t5wb2z9gUrEpmtfo
	oy1I27N5CBaYwb5agYb9f/sCUB9su1e7U4MHOoceuQlFJ9PPyKX6H2XN4DBpoyxSA6SocJ4ypic
	TEoSJl7x0A8RtzwbKB7qmDzFF7UMLfWyXfzqIf5Fdz6mj/iDhGED3Pd+uSDFHOWXI1cA7bGZFk
X-Google-Smtp-Source: AGHT+IFSL3ZJyOANkTfPxEJgTNnLrNpIdtJ2QMzX6+Wau8QZq/ah6u3mzrUVj58Gw+dM1WJPIpKoo+5FqJUpCU90q78=
X-Received: by 2002:a05:6e02:3cc9:b0:3dc:7ffe:33e4 with SMTP id
 e9e14a558f8ab-3dd89c00b72mr185645ab.5.1748378733286; Tue, 27 May 2025
 13:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com> <aALEI7glqsWmUygQ@x1>
 <CAP-5=fVk7=XFeRRSmYLqHHvExe1fFoQCGd+Q66ocx2qgBCKQQA@mail.gmail.com> <CA+JHD93NCu5VeP9b+DzMm0f0YHwJLRFJeHNtWogx6wKFrHi8Yw@mail.gmail.com>
In-Reply-To: <CA+JHD93NCu5VeP9b+DzMm0f0YHwJLRFJeHNtWogx6wKFrHi8Yw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 13:45:22 -0700
X-Gm-Features: AX0GCFsWkue9inLpSDMgM9Vnozkj8_2G75sGaHwPk9aryEiNHgPATyoUNyr4DSg
Message-ID: <CAP-5=fW-irofVnuops6+6va9Y5_mA7fXT665TTw8Yjic+boAwA@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
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
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 3:31=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Sat, Apr 19, 2025, 1:23=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>>
>> On Fri, Apr 18, 2025 at 2:29=E2=80=AFPM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>> >
>> > On Thu, Apr 17, 2025 at 04:07:21PM -0700, Ian Rogers wrote:
>> > > Linking against libcapstone and libLLVM can be a significant increas=
e
>> > > in dependencies and file size if building statically. For something
>> > > like `perf record` the disassembler and addr2line functionality won'=
t
>> > > be used. Support dynamically loading these libraries using dlopen an=
d
>> > > then calling the appropriate functions found using dlsym.
>> > >
>> > > BUILD_NONDISTRO is used to build perf against the license incompatib=
le
>> > > libbfd and libiberty libraries. As this has been opt-in for nearly 2
>> > > years, commit dd317df07207 ("perf build: Make binutil libraries opt
>> > > in"), remove the code to simplify the code base.
>> > >
>> > > The patch series:
>> > > 1) does some initial clean up;
>> > > 2) moves the capstone and LLVM code to their own C files,
>> > > 3) simplifies a little the capstone code;
>> > > 4) adds perf_ variants of the functions that will either directly ca=
ll
>> > >    the function or use dlsym to discover it;
>> > > 5) adds BPF JIT disassembly support to LLVM and capstone disassembly=
;
>> > > 6) removes the BUILD_NONDISTRO code, reduces scope and removes what'=
s possible;
>> > > 7) adds fallback to srcline's addr2line so that llvm_addr2line is
>> > >    tried first and then the forked command tried next, moving the co=
de
>> > >    for forking out of the main srcline.c file in the process.
>> > >
>> > > The addr2line LLVM functionality is written in C++. To avoid linking
>> > > against libLLVM for this, a new LIBLLVM_DYNAMIC option is added wher=
e
>> > > the C++ code with the libLLVM dependency will be built into a
>> > > libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
>> > > would extend their C API to avoid this.
>> > >
>> > > The libbfd BPF disassembly supported source lines, this wasn't porte=
d
>> > > to the capstone and LLVM disassembly.
>> >
>> > Doing the build tests I noticed, so far:
>> >
>> >   29    58.92 opensuse:15.4                 : FAIL gcc version 7.5.0 (=
SUSE Linux)
>> > <SNIP>
>> > + make NO_LIBTRACEEVENT=3D1 ARCH=3D CROSS_COMPILE=3D EXTRA_CFLAGS=3D N=
O_LIBBPF=3D1 -C tools/perf O=3D/tmp/build/perf
>> > make: Entering directory '/git/perf-6.15.0-rc2/tools/perf'
>> >   BUILD:   Doing 'make -j32' parallel build
>> > Warning: Skipped check-headers due to missing ../../include
>> > Makefile.config:560: No elfutils/debuginfod.h found, no debuginfo serv=
er support, please install libdebuginfod-dev/elfutils-debuginfod-client-dev=
el or equivalent
>> > Makefile.config:687: Warning: Disabled BPF skeletons as libbpf is requ=
ired
>> > Makefile.config:1039: No libbabeltrace found, disables 'perf data' CTF=
 format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
>> > update-alternatives: error: no alternatives for java
>> > update-alternatives: error: no alternatives for java
>> > Makefile.config:1100: No openjdk development package found, please ins=
tall JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
>> > Makefile.config:1113: libpfm4 not found, disables libpfm4 support. Ple=
ase install libpfm4-dev
>> >
>> > Auto-detecting system features:
>> > ...                                   libdw: [ on  ]
>> > ...                                   glibc: [ on  ]
>> > ...                                  libelf: [ on  ]
>> > ...                                 libnuma: [ on  ]
>> > ...                  numa_num_possible_cpus: [ on  ]
>> > ...                                 libperl: [ on  ]
>> > ...                               libpython: [ on  ]
>> > ...                               libcrypto: [ on  ]
>> > ...                             libcapstone: [ on  ]
>> > ...                               llvm-perf: [ on  ]
>> > ...                                    zlib: [ on  ]
>> > ...                                    lzma: [ on  ]
>> > ...                               get_cpuid: [ on  ]
>> > ...                                     bpf: [ on  ]
>> > ...                                  libaio: [ on  ]
>> > ...                                 libzstd: [ on  ]
>> >
>> >   PERF_VERSION =3D 6.15.rc2.gfbcac9367d45
>> >   GEN     /tmp/build/perf/common-cmds.h
>> >   GEN     /tmp/build/perf/arch/arm64/include/generated/asm/sysreg-defs=
.h
>> >   GEN     perf-archive
>> >   GEN     perf-iostat
>> >   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
>> >   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v2.o
>> >   CC      /tmp/build/perf/dlfilters/dlfilter-show-cycles.o
>> >   INSTALL /tmp/build/perf/libapi/include/api/cpu.h
>> >   INSTALL /tmp/build/perf/libapi/include/api/debug.h
>> >   INSTALL /tmp/build/perf/libapi/include/api/io.h
>> >   MKDIR   /tmp/build/perf/libapi/fd/
>> >   INSTALL /tmp/build/perf/libapi/include/api/io_dir.h
>> >   CC      /tmp/build/perf/libapi/cpu.o
>> >   MKDIR   /tmp/build/perf/libapi/fs/
>> >   INSTALL /tmp/build/perf/libapi/include/api/fd/array.h
>> >   CC      /tmp/build/perf/libapi/debug.o
>> >   MKDIR   /tmp/build/perf/libapi/fs/
>> >   MKDIR   /tmp/build/perf/libapi/fs/
>> >   CC      /tmp/build/perf/libapi/fd/array.o
>> >   INSTALL /tmp/build/perf/libapi/include/api/fs/tracing_path.h
>> >   CC      /tmp/build/perf/libapi/str_error_r.o
>> >   INSTALL /tmp/build/perf/libapi/include/api/fs/fs.h
>> >   CC      /tmp/build/perf/libapi/fs/tracing_path.o
>> >   CC      /tmp/build/perf/libapi/fs/fs.o
>> >   CC      /tmp/build/perf/libapi/fs/cgroup.o
>> >   INSTALL libapi_headers
>> >   INSTALL /tmp/build/perf/libperf/include/perf/bpf_perf.h
>> >   INSTALL /tmp/build/perf/libperf/include/perf/core.h
>> >   INSTALL /tmp/build/perf/libperf/include/perf/cpumap.h
>> >   INSTALL /tmp/build/perf/libperf/include/perf/threadmap.h
>> >   CC      /tmp/build/perf/libperf/core.o
>> >   CC      /tmp/build/perf/libperf/cpumap.o
>> >   CC      /tmp/build/perf/libperf/threadmap.o
>> >   INSTALL /tmp/build/perf/libperf/include/perf/evlist.h
>> >   CC      /tmp/build/perf/libperf/evlist.o
>> >   CC      /tmp/build/perf/libperf/evsel.o
>> >   CC      /tmp/build/perf/libperf/mmap.o
>> >   CC      /tmp/build/perf/libperf/zalloc.o
>> >   INSTALL /tmp/build/perf/libsubcmd/include/subcmd/exec-cmd.h
>> >   INSTALL /tmp/build/perf/libperf/include/perf/evsel.h
>> >   CC      /tmp/build/perf/libperf/xyarray.o
>> >   CC      /tmp/build/perf/libperf/lib.o
>> >   INSTALL /tmp/build/perf/libsubcmd/include/subcmd/help.h
>> >   INSTALL /tmp/build/perf/libsubcmd/include/subcmd/pager.h
>> >   LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v0.so
>> >   INSTALL /tmp/build/perf/libsubcmd/include/subcmd/parse-options.h
>> >   LD      /tmp/build/perf/libapi/fd/libapi-in.o
>> >   INSTALL /tmp/build/perf/libsubcmd/include/subcmd/run-command.h
>> >   INSTALL libsubcmd_headers
>> >   LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v2.so
>> >   INSTALL /tmp/build/perf/libperf/include/perf/event.h
>> >   INSTALL /tmp/build/perf/libsymbol/include/symbol/kallsyms.h
>> >   CC      /tmp/build/perf/libsymbol/kallsyms.o
>> >   INSTALL /tmp/build/perf/libperf/include/perf/mmap.h
>> >   INSTALL /tmp/build/perf/libperf/include/internal/cpumap.h
>> >   INSTALL /tmp/build/perf/libperf/include/internal/evlist.h
>> >   INSTALL /tmp/build/perf/libperf/include/internal/evsel.h
>> >   INSTALL /tmp/build/perf/libperf/include/internal/rc_check.h
>> >   INSTALL /tmp/build/perf/libperf/include/internal/mmap.h
>> >   INSTALL /tmp/build/perf/libperf/include/internal/threadmap.h
>> >   INSTALL /tmp/build/perf/libperf/include/internal/lib.h
>> >   INSTALL /tmp/build/perf/libperf/include/internal/xyarray.h
>> >   LINK    /tmp/build/perf/dlfilters/dlfilter-show-cycles.so
>> >   LD      /tmp/build/perf/libapi/fs/libapi-in.o
>> > evlist.c:28:6: error: no previous prototype for 'perf_evlist__init' [-=
Werror=3Dmissing-prototypes]
>> >  void perf_evlist__init(struct perf_evlist *evlist)
>> >       ^~~~~~~~~~~~~~~~~
>>
>> Hmm.. but on line 8 of tools/lib/perf/evlist.c is:
>> #include <internal/evlist.h>
>> is there a libperf installed somewhere? I thought we were just
>> statically linking currently. I'm not sure what I can do to resolve
>> this, it seems like a set up issue.
>
>
> I'll investigate and report back.

Ping. Thanks,
Ian

> - Arnaldo
>
>>

