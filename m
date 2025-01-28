Return-Path: <bpf+bounces-49979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3FEA21356
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 21:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3285B7A1DB8
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C771DB34E;
	Tue, 28 Jan 2025 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t10S4Ir6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD381B413D;
	Tue, 28 Jan 2025 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738097785; cv=none; b=AnBxNNnDjERc2bPO67ipM1FlBPZTkctBX82+KAgBlMD0kHdl73i/6zY9H/pQMcroEexrtkoUXD7uP2TFTvh5qaN70C7fOTSX0OyU824vugRj/wMPpuPXIR7vxNTey6RNZbid16LBkESaQ5SjJYnvwwtX69N33u8DFFXK0/Kc1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738097785; c=relaxed/simple;
	bh=VmxxfpxrQ1lkQIBflaPl6Q/VZxmO9YQUzyZeBiIxp9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFE6X66WmQRRClFmU+tjhJHuOZWUiO4hUmNNzamt61byCZqZfrG4v1ol1yp+r0Fi7Qn9q5vrhDvDdICv+bbk14X3j8ZK0Ct7SXfuCWZ+nZz+KiDXlBXibCUNju9wqgE3a2PD+UFTii5sIOJ81p+iLUj5vnQu5RRN0OvOhjfjF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t10S4Ir6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3CBC4CED3;
	Tue, 28 Jan 2025 20:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738097785;
	bh=VmxxfpxrQ1lkQIBflaPl6Q/VZxmO9YQUzyZeBiIxp9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t10S4Ir6CTfVDknapbp1g4H2UYZbNAc6zTZwZH85xu8FXYc1lgmyxa28ZsFjupiU1
	 Mp9z+3guOjM4S7ennIhTJ5xIk3tcg52dlbHjTHbo71P/reOYDf8QR8EcHBLidvoPi+
	 PvOmbnbtzeIKzjupB/e9DMZd+LwIBW19FsyDOlKsTeN085Xn4KZYNfGg2S6Q3xdgaE
	 F1kGVeggU0v/LaaBz2zYnYkfbOViArme0/k7tzfFlppGBUawUugEE829Z4D6yvDBa+
	 Fr+QNJnO+J3pdA31MWSN7iapasLvSj0kFWi0wmwUWxniZsEq6CsD61npByVIZ4/vfF
	 XTxIFI3i5APNQ==
Date: Tue, 28 Jan 2025 12:56:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Changbin Du <changbin.du@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 03/18] perf capstone: Move capstone functionality into
 its own file
Message-ID: <Z5lEdtLVHRZwxuY8@google.com>
References: <20250122174308.350350-1-irogers@google.com>
 <20250122174308.350350-4-irogers@google.com>
 <Z5QM8nHzwuQYczyQ@google.com>
 <CAP-5=fV0w9tLFr7xYHFUH=UUq+tr+o5EYUik0d74rMWa9=Qi+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV0w9tLFr7xYHFUH=UUq+tr+o5EYUik0d74rMWa9=Qi+A@mail.gmail.com>

On Fri, Jan 24, 2025 at 04:59:21PM -0800, Ian Rogers wrote:
> On Fri, Jan 24, 2025 at 1:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Jan 22, 2025 at 09:42:53AM -0800, Ian Rogers wrote:
> > > Capstone disassembly support was split between disasm.c and
> > > print_insn.c. Move support out of these files into capstone.[ch] and
> > > remove include capstone/capstone.h from those files. As disassembly
> > > routines can fail, make failure the only option without
> > > HAVE_LIBCAPSTONE_SUPPORT. For simplicity's sake, duplicate the
> > > read_symbol utility function.
> > >
> > > The intent with moving capstone support into a single file is that
> > > dynamic support, using dlopen for libcapstone, can be added in later
> > > patches. This can potentially always succeed or fail, so relying on
> > > ifdefs isn't sufficient. Using dlopen is a useful option to minimize
> > > the perf tools dependencies and potentially size.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-script.c  |   2 -
> > >  tools/perf/util/Build        |   1 +
> > >  tools/perf/util/capstone.c   | 536 +++++++++++++++++++++++++++++++++++
> > >  tools/perf/util/capstone.h   |  24 ++
> > >  tools/perf/util/disasm.c     | 358 +----------------------
> > >  tools/perf/util/print_insn.c | 117 +-------
> > >  6 files changed, 569 insertions(+), 469 deletions(-)
> > >  create mode 100644 tools/perf/util/capstone.c
> > >  create mode 100644 tools/perf/util/capstone.h
> > >
> > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > index 33667b534634..f05b2b70d5a7 100644
> > > --- a/tools/perf/builtin-script.c
> > > +++ b/tools/perf/builtin-script.c
> > > @@ -1200,7 +1200,6 @@ static int any_dump_insn(struct evsel *evsel __maybe_unused,
> > >                        u8 *inbuf, int inlen, int *lenp,
> > >                        FILE *fp)
> > >  {
> > > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > >       if (PRINT_FIELD(BRSTACKDISASM)) {
> > >               int printed = fprintf_insn_asm(x->machine, x->thread, x->cpumode, x->is64bit,
> > >                                              (uint8_t *)inbuf, inlen, ip, lenp,
> > > @@ -1209,7 +1208,6 @@ static int any_dump_insn(struct evsel *evsel __maybe_unused,
> > >               if (printed > 0)
> > >                       return printed;
> > >       }
> > > -#endif
> > >       return fprintf(fp, "%s", dump_insn(x, ip, inbuf, inlen, lenp));
> > >  }
> > >
> > > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > > index 5ec97e8d6b6d..9542decf9625 100644
> > > --- a/tools/perf/util/Build
> > > +++ b/tools/perf/util/Build
> > > @@ -8,6 +8,7 @@ perf-util-y += block-info.o
> > >  perf-util-y += block-range.o
> > >  perf-util-y += build-id.o
> > >  perf-util-y += cacheline.o
> > > +perf-util-y += capstone.o
> > >  perf-util-y += config.o
> > >  perf-util-y += copyfile.o
> > >  perf-util-y += ctype.o
> > > diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> > > new file mode 100644
> > > index 000000000000..c0a6d94ebc18
> > > --- /dev/null
> > > +++ b/tools/perf/util/capstone.c
> > > @@ -0,0 +1,536 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include "capstone.h"
> > > +#include "annotate.h"
> > > +#include "addr_location.h"
> > > +#include "debug.h"
> > > +#include "disasm.h"
> > > +#include "dso.h"
> > > +#include "machine.h"
> > > +#include "map.h"
> > > +#include "namespaces.h"
> > > +#include "print_insn.h"
> > > +#include "symbol.h"
> > > +#include "thread.h"
> > > +#include <fcntl.h>
> > > +#include <string.h>
> > > +
> > > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > > +#include <capstone/capstone.h>
> > > +#endif
> >
> > I think you can use a big #ifdef throughout the file to minimize the
> > #ifdef dances.  Usually it goes to the header to provide dummy static
> > inlines and make the .c file depends on config.  But I know you will
> > add dlopen code for the #else case later.
> 
> So I think big ifdefs like:
> 
> #if HAVE_xyz
> // 100s of lines
> #else
> // 100s of lines
> #endif
> 
> are best avoided. It is also the point of the shim-ing that we do
> 
> ... perf_foobar(...)
> {
> #if NO_SHIM
>   ... foobar(...);
> #else
>   //dlsym code
> #endif
> }
> 
> Having the shimming and not shimming as two separate functions buried
> in a 100 #ifdef loses that the code is common except for the shimming.

Right, can we split the common part and move it out of #ifdef?

> 
> For example, in the current code we have find_file_offset:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/disasm.c?h=perf-tools-next&id=91b7747dc70d64b5ec56ffe493310f207e7ffc99#n1371
> 
> It is only possible to understand the use of this seemingly common
> code by trying to interpret what's going on with the #ifdefs.
> 
> I think it stylistically it is okay to have multiple stubbed out
> functions inside a #if or #else, such as:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/include/linux/perf_event.h?h=perf-tools-next&id=91b7747dc70d64b5ec56ffe493310f207e7ffc99#n1797

I think the convention in the kernel community is that it's better to
remove #ifdef's in .c files and add a dummy functions under !condition
in .h files.  If that's not possible, I think we should make the code
less conditional by minimizing the #ifdef's.

> 
> But when the logic is shared and all in one file it becomes next to
> impossible to determine what's in use and what's not. Other than by
> tweaking things and trying to get build errors.
> 
> So for the shims I've placed the #if inside the function to make it
> clear the function is a shim. For the other functions that are over
> 100s of lines, for clarity the individual functions have #if
> HAVE_LIBLLVM_SUPPORT around them to make it clear that the function
> only has a meaning in that context - ie the source code doesn't make
> you go on a #ifdef finding expedition to try to understand when the
> code is in use.

I think the both approaches have their own pros and cons.  Some people
prefer one and others may have different opinions.  I think the big
conditional block is better and easy to follow.  Maybe we cannot agree
on this.  Then I believe it'd be better to follow the convention, no?

Thanks,
Namhyung


