Return-Path: <bpf+bounces-48813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEF0A10ECF
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 19:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899EF7A2CCD
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDD8208970;
	Tue, 14 Jan 2025 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQZ2qX79"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F341FBEA0;
	Tue, 14 Jan 2025 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877510; cv=none; b=NiHcC06NIxizpaHKX1PNTqhfsdZZd+3DVICw5xvg3RxcC6c1n15mkzIq67yuZ2ijCFNRWQ5OJElgDQwvYJM5fYHg3xwzdOj8frNa0BLop6CHwdGzvl2U91Bv1MMQHAYi1qNu/RDD8uKtrZAr59feu+NNVrDH7q+hSG5R0g+L5Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877510; c=relaxed/simple;
	bh=7uBK7D+BxpeaL7kysyY/rFTMNpozNYmFCbnN0YYN0S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzV41/80CGAig0Ud6wISj+OhcTk3ZGgdRrxrQHBRsTPw0tU3jiRkAam7x1LyDGVU3IGiFe8GiSiAhCbYj2u01htcXHHBO8+g364JiKAPLlUwb3h2cX6IHBHH4dQrpeex3/CPA2+0hDDDqomv6vUQeYe3gCBwZqIMnQtjd+JFn8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQZ2qX79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584E7C4CEDD;
	Tue, 14 Jan 2025 17:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877509;
	bh=7uBK7D+BxpeaL7kysyY/rFTMNpozNYmFCbnN0YYN0S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQZ2qX79MyKDt29hnV4kTsJ/MRK66wrAiI4RRNEx6QxqdxFuOyRpIfpq+VeiJeDvN
	 +aib+D/hIj7feGPN5W1Fdms1ldvCSIYreuHXvvYYAU4UpHP5JFT0EFn29YCXxFBeht
	 BbvqMSiXFUrhysfoFKTN/h614HAS7vYwLoYlcjYtPIRzGG5AVgrVX5aW3PAfS9ZJ8s
	 EpeAUXCVSVnaN4ZNkgTn141irhhq+ElDLNFwWpQUFk/hLl9nZfadBwr3yuYPynN5ye
	 UQvzPnZLrpqTzphcfHGlcTxiLyYwUyK3LS2PtsUYHMio8pZBnGXzQvIJXKF08TAGUZ
	 1qdfnil3SFh7Q==
Date: Tue, 14 Jan 2025 14:58:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v6 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z4alwvqYithaVLSL@x1>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
 <Z3_ybwWW3QZvJ4V6@x1>
 <Z4AoFA974kauIJ9T@ghost>
 <Z4A2Y269Ffo0ERkS@x1>
 <Z4BEygdXmofWBr0-@x1>
 <Z4BVK3D7sN-XYg2o@ghost>
 <Z4F1dXQLPGZ3JFI5@ghost>
 <Z4UpRqywqYPZSUM_@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4UpRqywqYPZSUM_@x1>

On Mon, Jan 13, 2025 at 11:55:05AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jan 10, 2025 at 11:31:01AM -0800, Charlie Jenkins wrote:
> > On Thu, Jan 09, 2025 at 03:00:59PM -0800, Charlie Jenkins wrote:
> > > Ooh okay I see, the quiet commands were being ignored as-is. We could
> > > add the lines to handle this to Makefile.syscalls, but I think the
> > > better solution is to move the lines from Makefile.build to
> > > Makefile.perf to be more generically available. Here is a patch for
> > > that. I also added the comment from the kernel Makefile describing what
> > > this does.
> 
> > > From 8dcec7f5d937ede3d33c687573dc2f1654ddc59e Mon Sep 17 00:00:00 2001
> > > From: Charlie Jenkins <charlie@rivosinc.com>
> > > Date: Thu, 9 Jan 2025 14:36:40 -0800
> > > Subject: [PATCH] perf tools: Expose quiet/verbose variables in Makefile.perf
> > > 
> > > The variables to make builds silent/verbose live inside
> > > tools/build/Makefile.build. Move those variables to the top-level
> > > Makefile.perf to be generally available.
> 
> <SNIP applied patch>
>  
> > Let me know how you want to handle this, I can send this out as a
> > separate patch if that's better.
> 
> I used the patch you provided above after hand editing the message
> before feeding it to 'git am', added these comments:

Somehow this is causing some trouble:

⬢ [acme@toolbox perf-tools-next]$ make -C tools/perf build-test
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
/bin/sh: line 1: @make: command not found
make[4]: *** [Makefile:27: clean-asm_pure_loop] Error 127
make[3]: *** [Makefile.perf:764: tests-coresight-targets-clean] Error 2
make[2]: *** [Makefile:96: clean] Error 2
make[1]: *** [tests/make:330: make_static] Error 2
make: *** [Makefile:109: build-test] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbox perf-tools-next]$

Can you please try fixing it as I'm busy now (I'll be on vacation from
tomorrow till early February)? This is what I extracted:

commit c199fd785d18121ffd0ba5758e23a42ba2984e11
Author: Charlie Jenkins <charlie@rivosinc.com>
Date:   Mon Jan 13 11:50:55 2025 -0300

    perf tools: Expose quiet/verbose variables in Makefile.perf
    
    The variables to make builds silent/verbose live inside
    tools/build/Makefile.build. Move those variables to the top-level
    Makefile.perf to be generally available.
    
    Committer testing:
    
    See the SYSCALL lines, now they are consistent with the other
    operations in other lines:
    
      SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_32.h
      SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_64.h
      GEN     /tmp/build/perf-tools-next/common-cmds.h
      GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
      PERF_VERSION = 6.13.rc2.g3d94bb6ed1d0
      GEN     perf-archive
      MKDIR   /tmp/build/perf-tools-next/jvmti/
      MKDIR   /tmp/build/perf-tools-next/jvmti/
      MKDIR   /tmp/build/perf-tools-next/jvmti/
      MKDIR   /tmp/build/perf-tools-next/jvmti/
      GEN     perf-iostat
      CC      /tmp/build/perf-tools-next/jvmti/libjvmti.o
      CC      /tmp/build/perf-tools-next/jvmti/jvmti_agent.o
    
    Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Christian Brauner <brauner@kernel.org>
    Cc: Guo Ren <guoren@kernel.org>
    Cc: Günther Noack <gnoack@google.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: James Clark <james.clark@linaro.org>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: John Garry <john.g.garry@oracle.com>
    Cc: Jonathan Corbet <corbet@lwn.net>
    Cc: Leo Yan <leo.yan@linux.dev>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Mickaël Salaün <mic@digikod.net>
    Cc: Mike Leach <mike.leach@linaro.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Palmer Dabbelt <palmer@dabbelt.com>
    Cc: Paul Walmsley <paul.walmsley@sifive.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Will Deacon <will@kernel.org>
    Link: http://lore.kernel.org/lkml/None
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 5fb3fb3d97e0fd11..e710ed67a1b49d9f 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -12,26 +12,6 @@
 PHONY := __build
 __build:
 
-ifeq ($(V),1)
-  quiet =
-  Q =
-else
-  quiet=quiet_
-  Q=@
-endif
-
-# If the user is running make -s (silent mode), suppress echoing of commands
-# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
-ifeq ($(filter 3.%,$(MAKE_VERSION)),)
-short-opts := $(firstword -$(MAKEFLAGS))
-else
-short-opts := $(filter-out --%,$(MAKEFLAGS))
-endif
-
-ifneq ($(findstring s,$(short-opts)),)
-  quiet=silent_
-endif
-
 build-dir := $(srctree)/tools/build
 
 # Define $(fixdep) for dep-cmd function
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a449d00155364422..55d6ce9ea52fb2a5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -161,12 +161,47 @@ export VPATH
 SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
 endif
 
+# Beautify output
+# ---------------------------------------------------------------------------
+#
+# Most of build commands in Kbuild start with "cmd_". You can optionally define
+# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
+# that command is printed by default.
+#
+# e.g.)
+#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
+#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
+#
+# A simple variant is to prefix commands with $(Q) - that's useful
+# for commands that shall be hidden in non-verbose mode.
+#
+#    $(Q)$(MAKE) $(build)=scripts/basic
+#
+# To put more focus on warnings, be less verbose as default
+# Use 'make V=1' to see the full commands
+
 ifeq ($(V),1)
+  quiet =
   Q =
 else
-  Q = @
+  quiet=quiet_
+  Q=@
 endif
 
+# If the user is running make -s (silent mode), suppress echoing of commands
+# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
+ifeq ($(filter 3.%,$(MAKE_VERSION)),)
+short-opts := $(firstword -$(MAKEFLAGS))
+else
+short-opts := $(filter-out --%,$(MAKEFLAGS))
+endif
+
+ifneq ($(findstring s,$(short-opts)),)
+  quiet=silent_
+endif
+
+export quiet Q
+
 # Do not use make's built-in rules
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r

