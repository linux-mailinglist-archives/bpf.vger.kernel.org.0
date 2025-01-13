Return-Path: <bpf+bounces-48699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 691D6A0BADA
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 16:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE017A37CA
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B7F22A4E7;
	Mon, 13 Jan 2025 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljKxA0aF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D88229808;
	Mon, 13 Jan 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780105; cv=none; b=C0hOxr8sKPc2fpBjFwWsGxhoAaupK4JTV2+EFQxjjEJfb2QhvDYIL7RrkmmrPu/nRR2psZZ+Y1kif1N+YtkeRr+BgDtL4HNaxiCyzDT9ag6F9wH1/UOizyAWoFYB+oExRJP6dfy8EcOrYZop8hWuZ8JIP6s17+CcKWAew6Supgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780105; c=relaxed/simple;
	bh=rMXm59SPTsrymD3C2yxFqEbLQ1YAvMyEOn3UiB05slc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFyompBHsOUSwU1TUrXceIB8Rs65E5ZOi/vwU7ovAGIZ3O1IN1lmt6Dgm2R3AW9KP3YRsg5eSxfQq2XY/zxaFVG+jWdst7fo6bcAKBSP4h0MWeuqfOQ4Vc+NGpyMT7zdFGNK7pLrTd+f5v7cY0Ac6HYSrDoBHsCw5e5D+iCttfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljKxA0aF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB7AC4CEE2;
	Mon, 13 Jan 2025 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736780105;
	bh=rMXm59SPTsrymD3C2yxFqEbLQ1YAvMyEOn3UiB05slc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljKxA0aFAxh2ONCcjbhbD784GF9s1PYXJEEhRvReBgZEd6mDOgNWpdwwkyWfeJtFD
	 ms5xEGQtINBAIYgUytnrPynqhAUDRqfv74ujLH6UCshPh2cTPoJ8hPIZXvR3svIiA7
	 o7F2SGfoA9kSXA0z25eLW/4YvTTMEneP+GangqZLdQgRreaEQhitpVt0fc/v6k9WRZ
	 cHiPMwk4/ZkoSkgvizHC3Z1Z7DkSrh/HkjwDNIqWHODpNSrreAduK5Y/WeqkUAORaC
	 kmspZTxOCvVnKX0NexSwAos/8QKdXhniXRbJetXIy518kJYNu8Z9wNyrPdc2P/rmCr
	 sNZbLt631SwvQ==
Date: Mon, 13 Jan 2025 11:55:02 -0300
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
Message-ID: <Z4UpRqywqYPZSUM_@x1>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
 <Z3_ybwWW3QZvJ4V6@x1>
 <Z4AoFA974kauIJ9T@ghost>
 <Z4A2Y269Ffo0ERkS@x1>
 <Z4BEygdXmofWBr0-@x1>
 <Z4BVK3D7sN-XYg2o@ghost>
 <Z4F1dXQLPGZ3JFI5@ghost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4F1dXQLPGZ3JFI5@ghost>

On Fri, Jan 10, 2025 at 11:31:01AM -0800, Charlie Jenkins wrote:
> On Thu, Jan 09, 2025 at 03:00:59PM -0800, Charlie Jenkins wrote:
> > Ooh okay I see, the quiet commands were being ignored as-is. We could
> > add the lines to handle this to Makefile.syscalls, but I think the
> > better solution is to move the lines from Makefile.build to
> > Makefile.perf to be more generically available. Here is a patch for
> > that. I also added the comment from the kernel Makefile describing what
> > this does.

> > From 8dcec7f5d937ede3d33c687573dc2f1654ddc59e Mon Sep 17 00:00:00 2001
> > From: Charlie Jenkins <charlie@rivosinc.com>
> > Date: Thu, 9 Jan 2025 14:36:40 -0800
> > Subject: [PATCH] perf tools: Expose quiet/verbose variables in Makefile.perf
> > 
> > The variables to make builds silent/verbose live inside
> > tools/build/Makefile.build. Move those variables to the top-level
> > Makefile.perf to be generally available.

<SNIP applied patch>
 
> Let me know how you want to handle this, I can send this out as a
> separate patch if that's better.

I used the patch you provided above after hand editing the message
before feeding it to 'git am', added these comments:

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

Thanks,

- Arnaldo

