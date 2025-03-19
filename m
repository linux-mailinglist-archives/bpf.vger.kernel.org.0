Return-Path: <bpf+bounces-54417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9471A69BDA
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 23:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565DC7A35AA
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EA121A438;
	Wed, 19 Mar 2025 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQHr/Zgr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BEE20899C;
	Wed, 19 Mar 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422431; cv=none; b=r1IbMokzk1gSruwE7a4ufD0V3vxBC4EsT5NfynZ1lYMg1yMpNry5mAOg8kXH9MVBreyXGWLH8wB9zn6CDyVWuhak6tE7a6bA4+NV+vDun06Zspt31Bwo8jF5/UwM43pvLwHwMg67/gC6UxPybs9X23d6Caui9g45bzA0KAKtnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422431; c=relaxed/simple;
	bh=qrPQan7aw5N3MeZWa6aIxkoax/iYMIYBSO2gVX6y+FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHu4H1BgLPLU7C14CfbHw2aEIY5bmX7iDRIBI+drQgMcNiR8IG4k69iOwJojlWSyX2aYmeIxi6g/k7g4ZQKDJ6KuOYCiYsVCJAt5sEL6d555aOlSnNpZGevfhws3JBxqijk5eDppzDj1lVY7yV5fsui+rT/n9Rzd30DHvvz/bfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQHr/Zgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E915DC4CEE4;
	Wed, 19 Mar 2025 22:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742422430;
	bh=qrPQan7aw5N3MeZWa6aIxkoax/iYMIYBSO2gVX6y+FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQHr/ZgrTZyl8SSHK2iM2RLCn70VdrqlXrGV2fuE1r5nPo3TKKSYv6Bf9ZTb0KBk4
	 bcgalLfR6bvPJMtJOj4vUYj72nBtHFwO5TUnjhgNfPERWWJuXzWdxSXEsvQ/uxDHul
	 jWHccVtaDoV4iv5UBAkwuMGJNcmF5FxdzABAL/L2FKGh7xm15ZWF0CFsLSbTnMZoYb
	 N2igCn/nybMU1OlSeb3I2Wvhbn1JOubU3qD5gZxHlQKy4zJw+9rEEhMRN+h7JsolHC
	 kZ3Sk0RqvE61v4+Wd7ROzn7NyD47EmxVnZY8j5igLyOBaU+foQpl6ipIrv7cEw22s1
	 YaTwCXc2KqR8w==
Date: Wed, 19 Mar 2025 15:13:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/1 next] tools build: Remove the libunwind feature tests
 from the ones detected when test-all.o builds
Message-ID: <Z9tBnDYy0slX2xh7@google.com>
References: <Z1mzpfAUi8zeiFOp@x1>
 <CAP-5=fWqpcwc021enM8uMChSgCRB+UW_6z7+=pdsQG9msLJsbw@mail.gmail.com>
 <Z9hWqwvNQO0GqH09@google.com>
 <CAP-5=fWCWD5Rq5RR7NSMxrxmc1SUkK=8gg+D-JxGOgaHA7_WBA@mail.gmail.com>
 <c4f4a1d0-aed8-4b09-a3d2-067fdd04bed3@kernel.org>
 <Z9oHGfAffX2Bfl7a@google.com>
 <Z9qSvGTlMCzktlZJ@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9qSvGTlMCzktlZJ@krava>

Hi Jiri,

On Wed, Mar 19, 2025 at 10:47:40AM +0100, Jiri Olsa wrote:
> On Tue, Mar 18, 2025 at 04:51:53PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Mar 17, 2025 at 09:19:22PM +0000, Quentin Monnet wrote:
> > > 2025-03-17 10:16 UTC-0700 ~ Ian Rogers <irogers@google.com>
> > > > On Mon, Mar 17, 2025 at 10:06 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >>
> > > >> Hello,
> > > >>
> > > >> On Mon, Mar 17, 2025 at 09:10:29AM -0700, Ian Rogers wrote:
> > > >>> On Wed, Dec 11, 2024 at 7:45 AM Arnaldo Carvalho de Melo
> > > >>> <acme@kernel.org> wrote:
> > > >>>>
> > > >>>> We have a tools/build/feature/test-all.c that has the most common set of
> > > >>>> features that perf uses and are expected to have its development files
> > > >>>> available when building perf.
> > > >>>>
> > > >>>> When we made libwunwind opt-in we forgot to remove them from the list of
> > > >>>> features that are assumed to be available when test-all.c builds, remove
> > > >>>> them.
> > > >>>>
> > > >>>> Before this patch:
> > > >>>>
> > > >>>>   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=/tmp/b feature-dump ; grep feature-libunwind-aarch64= /tmp/b/FEATURE-DUMP
> > > >>>>   feature-libunwind-aarch64=1
> > > >>>>   $
> > > >>>>
> > > >>>> Even tho this not being test built and those header files being
> > > >>>> available:
> > > >>>>
> > > >>>>   $ head -5 tools/build/feature/test-libunwind-aarch64.c
> > > >>>>   // SPDX-License-Identifier: GPL-2.0
> > > >>>>   #include <libunwind-aarch64.h>
> > > >>>>   #include <stdlib.h>
> > > >>>>
> > > >>>>   extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
> > > >>>>   $
> > > >>>>
> > > >>>> After this patch:
> > > >>>>
> > > >>>>   $ grep feature-libunwind- /tmp/b/FEATURE-DUMP
> > > >>>>   $
> > > >>>>
> > > >>>> Now an audit on what is being enabled when test-all.c builds will be
> > > >>>> performed.
> > > >>>>
> > > >>>> Fixes: 176c9d1e6a06f2fa ("tools features: Don't check for libunwind devel files by default")
> > > >>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > >>>> Cc: Ian Rogers <irogers@google.com>
> > > >>>> Cc: James Clark <james.clark@linaro.org>
> > > >>>> Cc: Jiri Olsa <jolsa@kernel.org>
> > > >>>> Cc: Kan Liang <kan.liang@linux.intel.com>
> > > >>>> Cc: Namhyung Kim <namhyung@kernel.org>
> > > >>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > >>>
> > > >>> Sorry for the delay on this.
> > > >>>
> > > >>> Reviewed-by: Ian Rogers <irogers@google.com>
> > > >>
> > > >> Thanks for the review, but I think this part is used by other tools like
> > > >> BPF and tracing.  It'd be nice to get reviews from them.
> > > > 
> > > > Sgtm. The patch hasn't had attention for 3 months. A quick grep for
> > > > "unwind" and "UNW_" shows only use in perf and the feature tests.
> > > > 
> > > > Thanks,
> > > > Ian
> > > 
> > > 
> > > Indeed, bpftool does not rely on libunwind, and I don't remember other
> > > BPF components doing so, either.
> > 
> > Right, but my concern was about the feature test itself and the related
> > changes in the build files.
> > 
> > Can I get your Acked-by then?
> 
> hi,
> I might be missing something, but I see following commit in git already:
>   b40fbeb0b1cd tools build: Remove the libunwind feature tests from the ones detected when test-all.o builds

Oops, thanks for checking this.

I was confused by Ian's late reply and thought it belongs to this
cycle. :)  Yep, it's already merged in the previous cycle.

Sorry for the noise.
Namhyung


