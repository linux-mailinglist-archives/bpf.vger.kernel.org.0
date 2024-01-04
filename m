Return-Path: <bpf+bounces-19020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8CB8241BF
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 13:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21941F24A02
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B821373;
	Thu,  4 Jan 2024 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7idbQmp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD8D219EB
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 12:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB4AC433C8;
	Thu,  4 Jan 2024 12:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704371234;
	bh=ufvF9coFthJHCA+mp5GWpZLLO5fHYW4M0gaLklr2YYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7idbQmpUWdbWaDDVK+COVovxLMXfoJpskNPlcs1az6P3vBVstrb2rvC7IexkMMJ7
	 tskd48rTLxgrh6ZXRD9ko/sp6gjOpVIkX2EeDeYV6Vh9T2SIjq6991GcStPG7sQnLW
	 ngmCvuYDAEu7pXrysrdKLm3fGXoyrvVYeESMOwQJIgf1Chdh5Ww8D2JUQsxFa+oUUg
	 P1i+1DBg5xIU+z1fev7LxhYnez51+lQZHpBMswsJjembJrjK6gZewXpmIi0AtUaMjm
	 vpdZgq+Enh6/GaQYTHyveBhPMzfdsFEf+8E6+/bvdjsh1Xr4iCd9RGAcSH0jBKtpFd
	 EAv2Ap1FywQiA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id BD4B5403EF; Thu,  4 Jan 2024 09:27:11 -0300 (-03)
Date: Thu, 4 Jan 2024 09:27:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH] bpftool: Add missing libgen.h for basename()
Message-ID: <ZZakH8LluKodXql-@kernel.org>
References: <ZZYgMYmb_qE94PUB@kernel.org>
 <ZZZ7hgqlYjNJOynA@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZZ7hgqlYjNJOynA@krava>
X-Url: http://acmel.wordpress.com

Em Thu, Jan 04, 2024 at 10:33:58AM +0100, Jiri Olsa escreveu:
> On Thu, Jan 04, 2024 at 12:04:17AM -0300, Arnaldo Carvalho de Melo wrote:
> > The header with the prototype for basename() is missing in the gen.c
> > file, which breaks the build in distros where that header doesn't get
> > include by some of the other includes present in gen.c, by luck, fix it.
> > 
> > Noticed when build perf on the Alpine Linux edge.
> > 
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > ---
> > 
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index ee3ce2b8000d75d2..0e50722588b48fa0 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -7,6 +7,7 @@
> >  #include <ctype.h>
> >  #include <errno.h>
> >  #include <fcntl.h>
> > +#include <libgen.h>
> >  #include <linux/err.h>

> this gives me compile warning on fedora:

Oh well, I looked at perf files and found:

⬢[acme@toolbox perf-tools-next]$ git grep basename tools/perf
tools/perf/builtin-daemon.c:    base = basename(basen);

And on alpine:edge:

/ $ grep '\<basename(' /usr/include/*.h
/usr/include/libgen.h:char *basename(char *);
/ $ cat /usr/include/libgen.h
#ifndef _LIBGEN_H
#define _LIBGEN_H

#ifdef __cplusplus
extern "C" {
#endif

char *dirname(char *);
char *basename(char *);

#ifdef __cplusplus
}
#endif

#endif
/ $

And in tools/perf/builtin-daemon.c we have:

⬢[acme@toolbox perf-tools-next]$ grep libgen tools/perf/builtin-daemon.c
#include <libgen.h>
⬢[acme@toolbox perf-tools-next]$

And the error on alpine:

gen.c: In function 'get_obj_name':
gen.c:60:23: warning: implicit declaration of function 'basename' [-Wimplicit-function-declaration]
   60 |         strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
      |                       ^~~~~~~~

the libgen.h include wasn't there, looks trivial.

Was late at night, thought about leaving for tomorrow for further tests
but seemed so obvious... duh ;-)
 
> 	gen.c: In function ‘get_obj_name’:
> 	gen.c:61:32: warning: passing argument 1 of ‘__xpg_basename’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
> 	   61 |         strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
> 	      |                                ^~~~
> 	In file included from gen.c:10:
> 	/usr/include/libgen.h:34:36: note: expected ‘char *’ but argument is of type ‘const char *’
> 	   34 | extern char *__xpg_basename (char *__path) __THROW;
> 	      |                              ~~~~~~^~~~~~
> 
> 
> looks like there are 2 versions of basename (man 3 basename):
> 
> 	VERSIONS
> 	       There are two different versions of basename() - the POSIX version described above, and the GNU version, which one gets after
> 
> 		       #define _GNU_SOURCE         /* See feature_test_macros(7) */
> 		       #include <string.h>
> 
> 	       The  GNU  version  never  modifies its argument, and returns the empty string when path has a trailing slash, and in particular also when it is "/".
> 	       There is no GNU version of dirname().
> 
> 	       With glibc, one gets the POSIX version of basename() when <libgen.h> is included, and the GNU version otherwise.
> 
> 
> I think we want to keep the GNU version declaration, but not sure how
> to fix the bpftool on Alpine Linux edge, what's the exact build error?

BUILD_TARBALL_HEAD=ec5257d99e6894d65fae772ca43c53b3d6855115
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-alpine-linux-musl/13.2.1/lto-wrapper
Target: x86_64-alpine-linux-musl
Configured with: /home/buildozer/aports/main/gcc/src/gcc-13-20231014/configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --build=x86_64-alpine-linux-musl --host=x86_64-alpine-linux-musl --target=x86_64-alpine-linux-musl --enable-checking=release --disable-cet --disable-fixed-point --disable-libstdcxx-pch --disable-multilib --disable-nls --disable-werror --disable-symvers --enable-__cxa_atexit --enable-default-pie --enable-default-ssp --enable-languages=c,c++,d,objc,go,fortran,ada --enable-link-serialization=2 --enable-linker-build-id --disable-libssp --disable-libsanitizer --enable-shared --enable-threads --enable-tls --with-bugurl=https://gitlab.alpinelinux.org/alpine/aports/-/issues --with-system-zlib --with-linker-hash-style=gnu --with-pkgversion='Alpine 13.2.1_git20231014'
Thread model: posix
Supported LTO compression algorithms: zlib
gcc version 13.2.1 20231014 (Alpine 13.2.1_git20231014)
+ make 'PYTHON=python3' 'ARCH=' 'CROSS_COMPILE=' 'EXTRA_CFLAGS=' -C tools/perf 'O=/tmp/build/perf'
make: Entering directory '/git/perf-6.7.0-rc6/tools/perf'
  BUILD:   Doing 'make -j28' parallel build
  HOSTCC  /tmp/build/perf/fixdep.o
  HOSTLD  /tmp/build/perf/fixdep-in.o
  LINK    /tmp/build/perf/fixdep
Warning: Skipped check-headers due to missing ../../include
Makefile.config:612: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:1093: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1127: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
Makefile.config:1158: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ OFF ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                      libdw-dwarf-unwind: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  GEN     /tmp/build/perf/common-cmds.h
  PERF_VERSION = 6.7.rc6.gec5257d99e68
  GEN     perf-archive
  GEN     perf-iostat
  CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v2.o
  CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
  CC      /tmp/build/perf/dlfilters/dlfilter-show-cycles.o
  GEN     /tmp/build/perf/arch/arm64/include/generated/asm/sysreg-defs.h
  INSTALL /tmp/build/perf/libsubcmd/include/subcmd/exec-cmd.h
  INSTALL /tmp/build/perf/libsubcmd/include/subcmd/help.h
  INSTALL /tmp/build/perf/libsubcmd/include/subcmd/pager.h
  INSTALL /tmp/build/perf/libsubcmd/include/subcmd/parse-options.h
  INSTALL /tmp/build/perf/libsubcmd/include/subcmd/run-command.h
  CC      /tmp/build/perf/libsubcmd/exec-cmd.o
  INSTALL libsubcmd_headers
  CC      /tmp/build/perf/libsubcmd/help.o
  CC      /tmp/build/perf/libsubcmd/pager.o
  CC      /tmp/build/perf/libsubcmd/parse-options.o
  CC      /tmp/build/perf/libsubcmd/run-command.o
  CC      /tmp/build/perf/libsubcmd/sigchain.o
  CC      /tmp/build/perf/libsubcmd/subcmd-config.o
  INSTALL /tmp/build/perf/libsymbol/include/symbol/kallsyms.h
  CC      /tmp/build/perf/libsymbol/kallsyms.o
  INSTALL libsymbol_headers
  INSTALL /tmp/build/perf/libperf/include/perf/bpf_perf.h
  INSTALL /tmp/build/perf/libperf/include/perf/core.h
  INSTALL /tmp/build/perf/libperf/include/perf/cpumap.h
  GEN     /tmp/build/perf/libbpf/bpf_helper_defs.h
  INSTALL /tmp/build/perf/libperf/include/perf/threadmap.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf.h
  INSTALL /tmp/build/perf/libperf/include/perf/evlist.h
  INSTALL /tmp/build/perf/libperf/include/perf/evsel.h
  CC      /tmp/build/perf/libperf/core.o
  INSTALL /tmp/build/perf/libperf/include/perf/event.h
  INSTALL /tmp/build/perf/libperf/include/perf/mmap.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf.h
  INSTALL /tmp/build/perf/libapi/include/api/cpu.h
  CC      /tmp/build/perf/libperf/cpumap.o
  INSTALL /tmp/build/perf/libapi/include/api/debug.h
  INSTALL /tmp/build/perf/libapi/include/api/io.h
  CC      /tmp/build/perf/libperf/threadmap.o
  INSTALL /tmp/build/perf/libapi/include/api/fd/array.h
  MKDIR   /tmp/build/perf/libapi/fd/
  CC      /tmp/build/perf/libperf/evsel.o
  LINK    /tmp/build/perf/dlfilters/dlfilter-show-cycles.so
  CC      /tmp/build/perf/libapi/fd/array.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/btf.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_common.h
  MKDIR   /tmp/build/perf/libapi/fs/
  CC      /tmp/build/perf/libapi/fs/fs.o
  INSTALL /tmp/build/perf/libperf/include/internal/cpumap.h
  INSTALL /tmp/build/perf/libperf/include/internal/evlist.h
  CC      /tmp/build/perf/libperf/evlist.o
  INSTALL /tmp/build/perf/libapi/include/api/fs/fs.h
  INSTALL /tmp/build/perf/libperf/include/internal/evsel.h
  CC      /tmp/build/perf/libperf/mmap.o
  INSTALL /tmp/build/perf/libapi/include/api/fs/tracing_path.h
  CC      /tmp/build/perf/libperf/zalloc.o
  INSTALL libapi_headers
  MKDIR   /tmp/build/perf/libapi/fs/
  INSTALL /tmp/build/perf/libperf/include/internal/lib.h
  CC      /tmp/build/perf/libapi/fs/tracing_path.o
  CC      /tmp/build/perf/libapi/fs/cgroup.o
  INSTALL /tmp/build/perf/libperf/include/internal/mmap.h
  INSTALL /tmp/build/perf/libperf/include/internal/rc_check.h
  INSTALL /tmp/build/perf/libperf/include/internal/threadmap.h
  INSTALL /tmp/build/perf/libperf/include/internal/xyarray.h
  INSTALL libperf_headers
  LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v0.so
  CC      /tmp/build/perf/libperf/xyarray.o
  LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v2.so
  CC      /tmp/build/perf/libperf/lib.o
  CC      /tmp/build/perf/libapi/cpu.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_legacy.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helpers.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_tracing.h
  CC      /tmp/build/perf/libapi/debug.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_endian.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_core_read.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/skel_internal.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_version.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/usdt.bpf.h
  CC      /tmp/build/perf/libapi/str_error_r.o
  LD      /tmp/build/perf/libapi/fd/libapi-in.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h
  INSTALL libbpf_headers
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf.o
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  CC      /tmp/build/perf/libbpf/staticobjs/bpf.o
  CC      /tmp/build/perf/libbpf/staticobjs/nlattr.o
  CC      /tmp/build/perf/libbpf/staticobjs/btf.o
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf_errno.o
  CC      /tmp/build/perf/libbpf/staticobjs/str_error.o
  CC      /tmp/build/perf/libbpf/staticobjs/netlink.o
  CC      /tmp/build/perf/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf_probes.o
  CC      /tmp/build/perf/libbpf/staticobjs/hashmap.o
  CC      /tmp/build/perf/libbpf/staticobjs/btf_dump.o
  CC      /tmp/build/perf/libbpf/staticobjs/ringbuf.o
  CC      /tmp/build/perf/libbpf/staticobjs/strset.o
  CC      /tmp/build/perf/libbpf/staticobjs/linker.o
  LD      /tmp/build/perf/libsymbol/libsymbol-in.o
  AR      /tmp/build/perf/libsymbol/libsymbol.a
  CC      /tmp/build/perf/libbpf/staticobjs/gen_loader.o
  CC      /tmp/build/perf/libbpf/staticobjs/relo_core.o
  CC      /tmp/build/perf/libbpf/staticobjs/usdt.o
  CC      /tmp/build/perf/libbpf/staticobjs/zip.o
  CC      /tmp/build/perf/libbpf/staticobjs/elf.o
  LD      /tmp/build/perf/libapi/fs/libapi-in.o
  LD      /tmp/build/perf/libapi/libapi-in.o
  LD      /tmp/build/perf/libperf/libperf-in.o
  AR      /tmp/build/perf/libapi/libapi.a
  AR      /tmp/build/perf/libperf/libperf.a
  LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
  AR      /tmp/build/perf/libsubcmd/libsubcmd.a
  GEN     /tmp/build/perf/python/perf.cpython-311-x86_64-linux-musl.so

Auto-detecting system features:
...                         clang-bpf-co-re: [ on  ]
...                                    llvm: [ on  ]
...                                  libcap: [ on  ]
...                                  libbfd: [ on  ]

  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/hashmap.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/relo_core.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_internal.h
  GEN     /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/bpf_helper_defs.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/btf.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_common.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_legacy.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helpers.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_tracing.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_endian.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_core_read.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/skel_internal.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_version.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/usdt.bpf.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helper_defs.h
  INSTALL libbpf_headers
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/nlattr.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_errno.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/str_error.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/netlink.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_probes.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/hashmap.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_dump.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ringbuf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/strset.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/linker.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/gen_loader.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/relo_core.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/usdt.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/zip.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/elf.o
  LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
  LINK    /tmp/build/perf/libbpf/libbpf.a
  LD      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf-in.o
  LINK    /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/main.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/common.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/json_writer.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/gen.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/btf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/xlated_dumper.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/btf_dumper.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/disasm.o
gen.c: In function 'get_obj_name':
gen.c:60:23: warning: implicit declaration of function 'basename' [-Wimplicit-function-declaration]
   60 |         strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
      |                       ^~~~~~~~
gen.c:60:23: warning: passing argument 2 of 'strncpy' makes pointer from integer without a cast [-Wint-conversion]
   60 |         strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
      |                       ^~~~~~~~~~~~~~
      |                       |
      |                       int
In file included from gen.c:13:
/usr/include/fortify/string.h:139:48: note: expected 'const char *' but argument is of type 'int'
  139 |                                    const char *__s, size_t __n)
      |                                    ~~~~~~~~~~~~^~~
  LINK    /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/bpftool
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/func_latency.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/off_cpu.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/lock_contention.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/kwork_trace.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/sample_filter.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/kwork_top.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bench_uprobe.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
  GENSKEL /tmp/build/perf/util/bpf_skel/bench_uprobe.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/func_latency.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/augmented_raw_syscalls.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/kwork_top.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/lock_contention.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/off_cpu.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_cgroup.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/kwork_trace.skel.h


