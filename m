Return-Path: <bpf+bounces-48310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3012A06878
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 23:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDB11888341
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 22:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934732046B9;
	Wed,  8 Jan 2025 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/mZSHn5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C451A0706;
	Wed,  8 Jan 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375995; cv=none; b=LPIUyTwt805/TjWiRZY0btDY0d4SpdsfCZinIOUmC9qqvToosICJZomFBsQ4w3z7EU4p/cHeP9pjD54ARrvKiht8QpbA15x/mV7qEuV//yKCkpDaLqKEJ+5GUVUvIYvZdjasymwkrVG+6mww9w/FOqaLJwtDAqv892xhTRx2eVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375995; c=relaxed/simple;
	bh=aBBMJt3YnEOGFN+NC1GBIijIU/2oGQEkFVJlezEYi8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKPsmnEwYtf6vMF8wf7UcmJ9DGA0cSZFy229ouvMmADNV7nrWh9NiRbmeMJsVOpzILSb6gk14IFNhuVpZqwhx2P47Gqt6nxdrrCG4le9sWw9qK7td4LElcw61xmk7y/3cSZHLN2SbklxhMB5iHuO8caz8laDq8Wue0UuXj12d3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/mZSHn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518F2C4CEE1;
	Wed,  8 Jan 2025 22:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736375994;
	bh=aBBMJt3YnEOGFN+NC1GBIijIU/2oGQEkFVJlezEYi8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/mZSHn5KPJvphh3IbFUFXaOK+YsJHIj11RQFS6EltlqcN2L4/AU8P8QQBxtmvEHw
	 xyWJ2Et4X/wp9bDq9bOc9SM5v3m/vjqOleZWnfW7VYyfAMZxWd7Ud4XolcB5RWX/8n
	 vTY5kVet5gsG0aLzqTDd0NvEDVhCGRwL9Ci1gUNZPeNUiRfcPPS6YvsOtYfKAqXP9v
	 fnRyN1RuNrcyOulTxuMWG5FdOk7ZdbI17eiY2KSnw/i5unp57PblOwd/+7uNlD3suD
	 nNvDeZsB6ZuQVr5PiYVjks8VpN2vIC07ztEHFvwvcRYqlUA9kHsBFWSHJRYSv3BCE6
	 Ufbqh7CgKXE+A==
Date: Wed, 8 Jan 2025 19:39:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z37-t9fhnmSghIPe@x1>
References: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
 <Z368mNynBTDWPM6R@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z368mNynBTDWPM6R@google.com>

On Wed, Jan 08, 2025 at 09:57:44AM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Jan 07, 2025 at 06:07:48PM -0800, Charlie Jenkins wrote:
> > Standardize the generation of syscall headers around syscall tables.
> > Previously each architecture independently selected how syscall headers
> > would be generated, or would not define a way and fallback onto
> > libaudit. Convert all architectures to use a standard syscall header
> > generation script and allow each architecture to override the syscall
> > table to use if they do not use the generic table.
> > 
> > As a result of these changes, no architecture will require libaudit, and
> > so the fallback case of using libaudit is removed by this series.
> > 
> > Testing:
> > 
> > I have tested that the syscall mappings of id to name generation works
> > as expected for every architecture, but I have only validated that perf
> > trace compiles and runs as expected on riscv, arm64, and x86_64.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Tested-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

So, somehow the first patch of this series didn't reach my inbox, b4
found it, and in it perf now does;

tools/perf/scripts/Makefile.syscalls

  include $(srctree)/scripts/Kbuild.include

I.e. it uses a file that is outside tools/ so normal devel in the kernel
community may end up breaking tools/ living code, something we decided
not to have.

I noticed this while doing a: "make -C tools/perf build-test", the first
test creates a perf tarball and then tries to build it after
uncompressing it somewhere out of the checked out kernel source tree:

⬢ [acme@toolbox perf-tools-next]$ make help | grep perf
  perf-tar-src-pkg    - Build the perf source tarball with no compression
  perf-targz-src-pkg  - Build the perf source tarball with gzip compression
  perf-tarbz2-src-pkg - Build the perf source tarball with bz2 compression
  perf-tarxz-src-pkg  - Build the perf source tarball with xz compression
  perf-tarzst-src-pkg - Build the perf source tarball with zst compression
⬢ [acme@toolbox perf-tools-next]$ make perf-tarxz-src-pkg
  UPD     .tmp_HEAD
  COPY    .tmp_perf/HEAD
  GEN     .tmp_perf/PERF-VERSION-FILE
  PERF_VERSION = 6.13.rc2.g48d3eefaa683
  ARCHIVE perf-6.13.0-rc2.tar.xz
⬢ [acme@toolbox perf-tools-next]$ mv perf-6.13.0-rc2.tar.xz ~
⬢ [acme@toolbox perf-tools-next]$ cd ~
⬢ [acme@toolbox ~]$ tar xvf perf-6.13.0-rc2.tar.xz | tail -5
perf-6.13.0-rc2/tools/scripts/Makefile.include
perf-6.13.0-rc2/tools/scripts/syscall.tbl
perf-6.13.0-rc2/tools/scripts/utilities.mak
perf-6.13.0-rc2/HEAD
perf-6.13.0-rc2/PERF-VERSION-FILE
⬢ [acme@toolbox ~]$ cd perf-6.13.0-rc2/
⬢ [acme@toolbox perf-6.13.0-rc2]$ make -C tools/perf
make: Entering directory '/home/acme/perf-6.13.0-rc2/tools/perf'
  BUILD:   Doing 'make -j28' parallel build
Warning: Skipped check-headers due to missing ../../include

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

/home/acme/perf-6.13.0-rc2/tools/perf/scripts/Makefile.syscalls:18: /home/acme/perf-6.13.0-rc2/scripts/Kbuild.include: No such file or directory
make[2]: *** No rule to make target '/home/acme/perf-6.13.0-rc2/scripts/Kbuild.include'.  Stop.
make[1]: *** [Makefile.perf:286: sub-make] Error 2
make: *** [Makefile:76: all] Error 2
make: Leaving directory '/home/acme/perf-6.13.0-rc2/tools/perf'
⬢ [acme@toolbox perf-6.13.0-rc2]$ 

This would probably (it does, just tested, but read on) make it work:

⬢ [acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index dc42de1785cee715..83ef5d1365880929 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -22,6 +22,7 @@ tools/lib/str_error_r.c
 tools/lib/vsprintf.c
 tools/lib/zalloc.c
 scripts/bpf_doc.py
+scripts/Kbuild.include
 tools/bpf/bpftool
 kernel/bpf/disasm.c
 kernel/bpf/disasm.h
⬢ [acme@toolbox perf-tools-next]$

As now we would find it, but then it references some other part of the
kernel's Kbuild system:

⬢ [acme@toolbox perf-tools-next]$ grep -w srctree scripts/Kbuild.include
build := -f $(srctree)/scripts/Makefile.build obj
clean := -f $(srctree)/scripts/Makefile.clean obj
⬢ [acme@toolbox perf-tools-next]$

And perf has:

⬢ [acme@toolbox perf-tools-next]$ find tools/ -name Makefile.build
tools/build/Makefile.build
⬢ [acme@toolbox perf-tools-next]$

And we also have:

⬢ [acme@toolbox perf-tools-next]$ ls -la tools/scripts/
total 40
drwxr-xr-x. 1 acme acme   106 Jan  8 19:13 .
drwxr-xr-x. 1 acme acme   514 Jan  8 11:39 ..
-rw-r--r--. 1 acme acme  1224 Jan  8 11:41 Makefile.arch
-rw-r--r--. 1 acme acme  6205 Dec 20 21:48 Makefile.include
-rw-r--r--. 1 acme acme 17401 Jan  8 19:13 syscall.tbl
-rw-r--r--. 1 acme acme  6186 Dec 20 21:48 utilities.mak
⬢ [acme@toolbox perf-tools-next]$

And:

⬢ [acme@toolbox perf-tools-next]$ grep -w build tools/build/Makefile.include 
build := -f $(srctree)/tools/build/Makefile.build dir=. obj
	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
	$(Q)$(MAKE) -C $(srctree)/tools/build clean
⬢ [acme@toolbox perf-tools-next]$

That is also in:

⬢ [acme@toolbox perf-tools-next]$ grep -w build scripts/Kbuild.include 
# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
# $(Q)$(MAKE) $(build)=dir
build := -f $(srctree)/scripts/Makefile.build obj
# the interrupted recipe. So, you can safely stop the build by Ctrl-C (Make
# (1) PHONY targets are always build
# (2) No target, so we better build it
⬢ [acme@toolbox perf-tools-next]$

So it seems we need to look at what we're using from the kernel's
scripts/Makefile.build to have it in a tools/build/ file.

Its late here and I'll have to stop at this point, please take a look to
see if this can be easily resolved so that we can merge your series, I
very much like to say goodbye to one more tools/perf library dependency
:-)

Best regards,

- Arnaldo

