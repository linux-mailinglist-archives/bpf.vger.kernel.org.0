Return-Path: <bpf+bounces-48863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91269A11394
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7E03A4AAF
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 22:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2992135B7;
	Tue, 14 Jan 2025 22:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CfnWOFU8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ABB20CCDD
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736892041; cv=none; b=YGic8R/58/ArCjGysOxb5zOba+SCiSOkAz9gcbBPSRXrMvcsX/MohyCI7K3GGQpwy64RwFE6vm8L2rXAgYY3DkGCjeRgRNWvHCEehB6J+KLcfUZA3UX9h1FFpESRZJlaQFTioGBYAYFQpkYJF/x1HMeT+kh1xad28ppW6xUvYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736892041; c=relaxed/simple;
	bh=9ICZ0W3Bkxk6NScIrYrvoP5/k3RPtl89AAbJs5WhK/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjObiYa8AkjZRt8G49qwEIBN++E26H+Fz0VM1+FOGwJzn0SYRwSimDJaX0iNKmpP5gQnIBFRM/09/4uM/ORgVB+bNC+nx+kr88ypW2iqpU9dwEBO/NYsegJY7DyZaKq+LTSdY88VYb1NlIsliB0jWaqz6kSPhE+lPKWz6yKECgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CfnWOFU8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so369805a91.0
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 14:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736892038; x=1737496838; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LAi/vDeugCHa71Ma0EXTvLeZpuJSJHZJbQffJrAlCfU=;
        b=CfnWOFU8YcufNRB29bZ04MvHjbHryKeuMsose1caY8Z7sJKY8ieR3Slnks+dLgmZm8
         dFiPZiHzfJLqTWAst6zXJ9h5b5vJe809XU/bsUfEviki8ef5FYho17FfrlFXUu7csoQW
         9yPYUvQTNCoOyZxdnAvwuc/kPqcLaF8p8uRUQuSUz0qEYyltCUwPAS/xqpiJEv6m3quW
         Ai70RI+NsC+GGHZoPfWOHCca8dyzB+bO1rYO2LmmPsIgkfQQxiJz4YK2WyelHM191eSq
         6hbJ0cL3RKSd2ewRyKziHqHjBKPq1SsfRM2NnaX7ISECobBOmYjn8kBOi+RY+FDGLFUo
         WLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736892038; x=1737496838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAi/vDeugCHa71Ma0EXTvLeZpuJSJHZJbQffJrAlCfU=;
        b=hi1JfP6DnaUIprDrzft2uDiMSRUCzJQFs6nUofVkXPCd0LBKNr46GNE4yG9417pyLi
         YXHdT/sJSMWqjH95jM4i73pj+ujYUrKdEmz10LhqcCWdhj3+xOFaFrHpcdD/qMo/pEjF
         9/Mqo0Mk89lBMF/TKGgpIBg3H1LRS2SGRA8sMpT53lJBDulC1Efqj4s7o4bl9HYWH/wn
         FHhsLWX62Y5rfDTFgRxa1LcyRi/a61OeKXe9GTuCmfw12R0fsW6o/oUEqBW9aSgdn1C3
         F0/xLZkbRvGDTjp2eDdTCpiyA9Ud/1E3uWq6vG2OIbbZ8cuOtQm0Jh3RCxeBhwUz25UT
         fmyA==
X-Forwarded-Encrypted: i=1; AJvYcCXyuoxOaq8tzN1YawiSDsCLW33b4ZKF22tvWBthu1kHt5GdXjlFt6PlgccJ7S10wscZKP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHJTAwff3trVPcWQW0nSFSzIX8HcAPPMBKtu+fNPiSyHb92zBU
	fXDjblLYLIBefJQFTqx5dIqMtr2MI4zV/Uz8C8pIIQ9XOEi5o04DnjBhZrTHkPA=
X-Gm-Gg: ASbGnctrXqinQ3DokzUVGis2zepzF4W5KLdq8+cP61XKrSfmsi1K5vxi5+9aedElDbn
	B3KxnhjPesSrwdP0Qu8gs+Y0QHZ4GVutQXXcdE0k1uNYZfA3H6k6CSXx3Z2OxhhZZ141DA3nA8U
	qJsrzjibkz58h0fBaz9f8V1MxeCK3N0QGtKWJyv4qbjH2dNyvRKAjb/p176NK3qF0AatX6NEZlU
	taFEgbZlTGgQrMr9ABwwYxaREYwm1YjTuQZ/r2sbXvyaIU=
X-Google-Smtp-Source: AGHT+IHUmOu5Z8yV9askuOExmMIbEPTgLHypbNQwlNxLYlNE9sF/DEJ2VQ1UKljmu+ix+BNJ1HS+qw==
X-Received: by 2002:a17:90b:3a08:b0:2ee:edae:775 with SMTP id 98e67ed59e1d1-2f728dd351amr804769a91.3.1736892037932;
        Tue, 14 Jan 2025 14:00:37 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c20abc4sm27371a91.34.2025.01.14.14.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:00:36 -0800 (PST)
Date: Tue, 14 Jan 2025 14:00:33 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <Z4bega1SChsGKqe6@ghost>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
 <Z3_ybwWW3QZvJ4V6@x1>
 <Z4AoFA974kauIJ9T@ghost>
 <Z4A2Y269Ffo0ERkS@x1>
 <Z4BEygdXmofWBr0-@x1>
 <Z4BVK3D7sN-XYg2o@ghost>
 <Z4F1dXQLPGZ3JFI5@ghost>
 <Z4UpRqywqYPZSUM_@x1>
 <Z4alwvqYithaVLSL@x1>
 <Z4a6oivg7f74N12Q@ghost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4a6oivg7f74N12Q@ghost>

On Tue, Jan 14, 2025 at 11:27:30AM -0800, Charlie Jenkins wrote:
> On Tue, Jan 14, 2025 at 02:58:26PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Jan 13, 2025 at 11:55:05AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Fri, Jan 10, 2025 at 11:31:01AM -0800, Charlie Jenkins wrote:
> > > > On Thu, Jan 09, 2025 at 03:00:59PM -0800, Charlie Jenkins wrote:
> > > > > Ooh okay I see, the quiet commands were being ignored as-is. We could
> > > > > add the lines to handle this to Makefile.syscalls, but I think the
> > > > > better solution is to move the lines from Makefile.build to
> > > > > Makefile.perf to be more generically available. Here is a patch for
> > > > > that. I also added the comment from the kernel Makefile describing what
> > > > > this does.
> > > 
> > > > > From 8dcec7f5d937ede3d33c687573dc2f1654ddc59e Mon Sep 17 00:00:00 2001
> > > > > From: Charlie Jenkins <charlie@rivosinc.com>
> > > > > Date: Thu, 9 Jan 2025 14:36:40 -0800
> > > > > Subject: [PATCH] perf tools: Expose quiet/verbose variables in Makefile.perf
> > > > > 
> > > > > The variables to make builds silent/verbose live inside
> > > > > tools/build/Makefile.build. Move those variables to the top-level
> > > > > Makefile.perf to be generally available.
> > > 
> > > <SNIP applied patch>
> > >  
> > > > Let me know how you want to handle this, I can send this out as a
> > > > separate patch if that's better.
> > > 
> > > I used the patch you provided above after hand editing the message
> > > before feeding it to 'git am', added these comments:
> > 
> > Somehow this is causing some trouble:
> > 
> > ⬢ [acme@toolbox perf-tools-next]$ make -C tools/perf build-test
> > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> > - tarpkg: ./tests/perf-targz-src-pkg .
> > /bin/sh: line 1: @make: command not found
> > make[4]: *** [Makefile:27: clean-asm_pure_loop] Error 127
> > make[3]: *** [Makefile.perf:764: tests-coresight-targets-clean] Error 2
> > make[2]: *** [Makefile:96: clean] Error 2
> > make[1]: *** [tests/make:330: make_static] Error 2
> > make: *** [Makefile:109: build-test] Error 2
> > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> > ⬢ [acme@toolbox perf-tools-next]$
> > 
> > Can you please try fixing it as I'm busy now (I'll be on vacation from
> > tomorrow till early February)? This is what I extracted:
> 
> There was an erroneous $(Q) in
> tools/perf/tests/shell/coresight/Makefile. Previously it would expand to
> the empty string so wouldn't cause any problems, but now it's in the
> middle of an expression so hence the error. I'll send an updated patch.

Let me know if this works as expected! I sent it as [1].

[1] https://lore.kernel.org/all/20250114-perf_make_test-v1-1-decc1c517b11@rivosinc.com/

> 
> > 
> > commit c199fd785d18121ffd0ba5758e23a42ba2984e11
> > Author: Charlie Jenkins <charlie@rivosinc.com>
> > Date:   Mon Jan 13 11:50:55 2025 -0300
> > 
> >     perf tools: Expose quiet/verbose variables in Makefile.perf
> >     
> >     The variables to make builds silent/verbose live inside
> >     tools/build/Makefile.build. Move those variables to the top-level
> >     Makefile.perf to be generally available.
> >     
> >     Committer testing:
> >     
> >     See the SYSCALL lines, now they are consistent with the other
> >     operations in other lines:
> >     
> >       SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_32.h
> >       SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_64.h
> >       GEN     /tmp/build/perf-tools-next/common-cmds.h
> >       GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
> >       PERF_VERSION = 6.13.rc2.g3d94bb6ed1d0
> >       GEN     perf-archive
> >       MKDIR   /tmp/build/perf-tools-next/jvmti/
> >       MKDIR   /tmp/build/perf-tools-next/jvmti/
> >       MKDIR   /tmp/build/perf-tools-next/jvmti/
> >       MKDIR   /tmp/build/perf-tools-next/jvmti/
> >       GEN     perf-iostat
> >       CC      /tmp/build/perf-tools-next/jvmti/libjvmti.o
> >       CC      /tmp/build/perf-tools-next/jvmti/jvmti_agent.o
> >     
> >     Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >     Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >     Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> >     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >     Cc: Arnd Bergmann <arnd@arndb.de>
> >     Cc: Christian Brauner <brauner@kernel.org>
> >     Cc: Guo Ren <guoren@kernel.org>
> >     Cc: Günther Noack <gnoack@google.com>
> >     Cc: Ian Rogers <irogers@google.com>
> >     Cc: Ingo Molnar <mingo@redhat.com>
> >     Cc: James Clark <james.clark@linaro.org>
> >     Cc: Jiri Olsa <jolsa@kernel.org>
> >     Cc: John Garry <john.g.garry@oracle.com>
> >     Cc: Jonathan Corbet <corbet@lwn.net>
> >     Cc: Leo Yan <leo.yan@linux.dev>
> >     Cc: Mark Rutland <mark.rutland@arm.com>
> >     Cc: Mickaël Salaün <mic@digikod.net>
> >     Cc: Mike Leach <mike.leach@linaro.org>
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >     Cc: Paul Walmsley <paul.walmsley@sifive.com>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: Will Deacon <will@kernel.org>
> >     Link: http://lore.kernel.org/lkml/None
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> > index 5fb3fb3d97e0fd11..e710ed67a1b49d9f 100644
> > --- a/tools/build/Makefile.build
> > +++ b/tools/build/Makefile.build
> > @@ -12,26 +12,6 @@
> >  PHONY := __build
> >  __build:
> >  
> > -ifeq ($(V),1)
> > -  quiet =
> > -  Q =
> > -else
> > -  quiet=quiet_
> > -  Q=@
> > -endif
> > -
> > -# If the user is running make -s (silent mode), suppress echoing of commands
> > -# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> > -ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> > -short-opts := $(firstword -$(MAKEFLAGS))
> > -else
> > -short-opts := $(filter-out --%,$(MAKEFLAGS))
> > -endif
> > -
> > -ifneq ($(findstring s,$(short-opts)),)
> > -  quiet=silent_
> > -endif
> > -
> >  build-dir := $(srctree)/tools/build
> >  
> >  # Define $(fixdep) for dep-cmd function
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index a449d00155364422..55d6ce9ea52fb2a5 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -161,12 +161,47 @@ export VPATH
> >  SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
> >  endif
> >  
> > +# Beautify output
> > +# ---------------------------------------------------------------------------
> > +#
> > +# Most of build commands in Kbuild start with "cmd_". You can optionally define
> > +# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
> > +# that command is printed by default.
> > +#
> > +# e.g.)
> > +#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
> > +#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
> > +#
> > +# A simple variant is to prefix commands with $(Q) - that's useful
> > +# for commands that shall be hidden in non-verbose mode.
> > +#
> > +#    $(Q)$(MAKE) $(build)=scripts/basic
> > +#
> > +# To put more focus on warnings, be less verbose as default
> > +# Use 'make V=1' to see the full commands
> > +
> >  ifeq ($(V),1)
> > +  quiet =
> >    Q =
> >  else
> > -  Q = @
> > +  quiet=quiet_
> > +  Q=@
> >  endif
> >  
> > +# If the user is running make -s (silent mode), suppress echoing of commands
> > +# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> > +ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> > +short-opts := $(firstword -$(MAKEFLAGS))
> > +else
> > +short-opts := $(filter-out --%,$(MAKEFLAGS))
> > +endif
> > +
> > +ifneq ($(findstring s,$(short-opts)),)
> > +  quiet=silent_
> > +endif
> > +
> > +export quiet Q
> > +
> >  # Do not use make's built-in rules
> >  # (this improves performance and avoids hard-to-debug behaviour);
> >  MAKEFLAGS += -r

