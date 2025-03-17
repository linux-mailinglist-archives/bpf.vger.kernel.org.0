Return-Path: <bpf+bounces-54215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C688DA659F7
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC8318895B1
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1678C1A2C0B;
	Mon, 17 Mar 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeQeEYjU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEFB19A2A3;
	Mon, 17 Mar 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231213; cv=none; b=JNsiq3WRl21D/NTYPDbiDrPboeeh6jLRAnD9skpSVqrj4o3Ats884UY7Ed6a1BOwyvhalvXt6w08QlS42pCYCjRE0Pdag0F+dxBX7Gsy95QOkBv0HA+FU40gvbn2BHX0X28h+MLnQ0jryIQFdQ44qF8tUdxfb5rk1WrZgS59gZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231213; c=relaxed/simple;
	bh=hMLbXmDlQKj0+NBk+ugWNVg03U+ubuJqFbYx5KUWp0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt0e/JzIyBnsSO006NBnwOanhjSwcnFKb6awRXAGEzJ9vWakxKH7PJauZlAwEVY0LETflgVDfMc3ep9EBU/7XPo4WQdPsgwaUhP5mlHoEVpXdER3xQvanb1shuGaItdJI/S8UAkCV3o504WyGNui8b54n7/9ol6Q4J4KUaMTVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeQeEYjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5F5C4CEE3;
	Mon, 17 Mar 2025 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231212;
	bh=hMLbXmDlQKj0+NBk+ugWNVg03U+ubuJqFbYx5KUWp0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jeQeEYjUqmDO/zl5DPCCHoROo2HQ8wvy3t+ngOZvlib2VcqUJmgr3Q0GLEQN01414
	 Ne1b9r+jMT4eDXEu6YpZXvQxvCqAVrFEgdYvZsBgAvD/brAxjYpMAJ5APy82AYlA/w
	 1pevp5pLgI99IBCm6oQCdg5d5ZCRi9Hu17nOCtbeMaBUb+FOphMs9ADKMsKvhrHnq2
	 kVwNWQheTkwRumi6TYoJUHBk5KndX+/f9Emtclg4fwlS8xI4KRTOWRuXjJ+vF7LxTE
	 yMIQJiLO8esycLGt5PmxLgG/miMCVfnK6oQnhoz7Kg4sVQ2shFrWq9NEb5fxbNpeQb
	 Dq0aLGhGkRKZw==
Date: Mon, 17 Mar 2025 10:06:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH 1/1 next] tools build: Remove the libunwind feature tests
 from the ones detected when test-all.o builds
Message-ID: <Z9hWqwvNQO0GqH09@google.com>
References: <Z1mzpfAUi8zeiFOp@x1>
 <CAP-5=fWqpcwc021enM8uMChSgCRB+UW_6z7+=pdsQG9msLJsbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWqpcwc021enM8uMChSgCRB+UW_6z7+=pdsQG9msLJsbw@mail.gmail.com>

Hello,

On Mon, Mar 17, 2025 at 09:10:29AM -0700, Ian Rogers wrote:
> On Wed, Dec 11, 2024 at 7:45 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > We have a tools/build/feature/test-all.c that has the most common set of
> > features that perf uses and are expected to have its development files
> > available when building perf.
> >
> > When we made libwunwind opt-in we forgot to remove them from the list of
> > features that are assumed to be available when test-all.c builds, remove
> > them.
> >
> > Before this patch:
> >
> >   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=/tmp/b feature-dump ; grep feature-libunwind-aarch64= /tmp/b/FEATURE-DUMP
> >   feature-libunwind-aarch64=1
> >   $
> >
> > Even tho this not being test built and those header files being
> > available:
> >
> >   $ head -5 tools/build/feature/test-libunwind-aarch64.c
> >   // SPDX-License-Identifier: GPL-2.0
> >   #include <libunwind-aarch64.h>
> >   #include <stdlib.h>
> >
> >   extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
> >   $
> >
> > After this patch:
> >
> >   $ grep feature-libunwind- /tmp/b/FEATURE-DUMP
> >   $
> >
> > Now an audit on what is being enabled when test-all.c builds will be
> > performed.
> >
> > Fixes: 176c9d1e6a06f2fa ("tools features: Don't check for libunwind devel files by default")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Sorry for the delay on this.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the review, but I think this part is used by other tools like
BPF and tracing.  It'd be nice to get reviews from them.

Thanks,
Namhyung

> 
> > ---
> >  tools/build/Makefile.feature | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> > index b2884bc23775e986..9cde51104c2d70ec 100644
> > --- a/tools/build/Makefile.feature
> > +++ b/tools/build/Makefile.feature
> > @@ -90,13 +90,6 @@ FEATURE_TESTS_EXTRA :=                  \
> >           libbfd-liberty                 \
> >           libbfd-liberty-z               \
> >           libopencsd                     \
> > -         libunwind-x86                  \
> > -         libunwind-x86_64               \
> > -         libunwind-arm                  \
> > -         libunwind-aarch64              \
> > -         libunwind-debug-frame          \
> > -         libunwind-debug-frame-arm      \
> > -         libunwind-debug-frame-aarch64  \
> >           cxx                            \
> >           llvm                           \
> >           clang                          \
> > --
> > 2.47.0
> >

