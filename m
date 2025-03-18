Return-Path: <bpf+bounces-54351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D694A680E6
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 00:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517E93A9E9F
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 23:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC541209F33;
	Tue, 18 Mar 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7LpHAz8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE901DD0D5;
	Tue, 18 Mar 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341916; cv=none; b=DmZ7ExQyEAl4z0eC5Ks2FkD9mbeSM3fdujjDvHVJ8Qqn80vWi67LsOFo5q/+l5ysbKo3DF8jJK6fKnxBeSxfwTvcyGlwgqfJs71VgrK0cE2/+OzwLM69UvsiMMh7ZeACGby24fCAS/L1cqn6mpTu8vM3MI+xwLF+Zyhc6eR/rk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341916; c=relaxed/simple;
	bh=a+pnqpNwRT4t7w507JF6+EzY3Lq35cSU9gWnIZaeLEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6AdDrJzH6BePZQ+XeDRFvv1QIFLRsBO0/gF3SiVJ3UZkpEpKIIZ5kWBZUjYoJPTEF2DlCCh5SPv3eO7BsEw7HBuW1xd+PXNyoipWQMODyjbimbkKR8bm44M9WaqjoLvDh075Idi9hraGXyUxoap3Cgr9kyb440JyTrLoRxjdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7LpHAz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B27C4CEDD;
	Tue, 18 Mar 2025 23:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742341915;
	bh=a+pnqpNwRT4t7w507JF6+EzY3Lq35cSU9gWnIZaeLEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7LpHAz8vhG703hMFkxfgMcg9JdiQtxci4NP14cPMZXqUaNM/s9rd65q1K2OPlQJv
	 DU0J5k043bF8y62hfal9ftdJN20BUCnFMXEXmmiP24EZd16bd3pOFjiM1lZd8911Ct
	 O9ZLiUypI9zHWKIEvfAJqWZsR55cIJLFusSdsEVu+Dg0PiiCiOYpTnfU/V/BJGaGQ3
	 Bdnh7xtQl8w6ANP3MF7U5zj+kF1UnP0rT1ZwyOhmDSdY8YGfciPdDQ4oAwE8xyeaWz
	 AXh2Z1gl0VbU2CcPeTfHlp78R3z9ugsdP52mmKbXnWG5u2cHlwWOKR+3ZFMFza2D49
	 Viu3oHELJnP6Q==
Date: Tue, 18 Mar 2025 16:51:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/1 next] tools build: Remove the libunwind feature tests
 from the ones detected when test-all.o builds
Message-ID: <Z9oHGfAffX2Bfl7a@google.com>
References: <Z1mzpfAUi8zeiFOp@x1>
 <CAP-5=fWqpcwc021enM8uMChSgCRB+UW_6z7+=pdsQG9msLJsbw@mail.gmail.com>
 <Z9hWqwvNQO0GqH09@google.com>
 <CAP-5=fWCWD5Rq5RR7NSMxrxmc1SUkK=8gg+D-JxGOgaHA7_WBA@mail.gmail.com>
 <c4f4a1d0-aed8-4b09-a3d2-067fdd04bed3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4f4a1d0-aed8-4b09-a3d2-067fdd04bed3@kernel.org>

Hello,

On Mon, Mar 17, 2025 at 09:19:22PM +0000, Quentin Monnet wrote:
> 2025-03-17 10:16 UTC-0700 ~ Ian Rogers <irogers@google.com>
> > On Mon, Mar 17, 2025 at 10:06 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >>
> >> Hello,
> >>
> >> On Mon, Mar 17, 2025 at 09:10:29AM -0700, Ian Rogers wrote:
> >>> On Wed, Dec 11, 2024 at 7:45 AM Arnaldo Carvalho de Melo
> >>> <acme@kernel.org> wrote:
> >>>>
> >>>> We have a tools/build/feature/test-all.c that has the most common set of
> >>>> features that perf uses and are expected to have its development files
> >>>> available when building perf.
> >>>>
> >>>> When we made libwunwind opt-in we forgot to remove them from the list of
> >>>> features that are assumed to be available when test-all.c builds, remove
> >>>> them.
> >>>>
> >>>> Before this patch:
> >>>>
> >>>>   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=/tmp/b feature-dump ; grep feature-libunwind-aarch64= /tmp/b/FEATURE-DUMP
> >>>>   feature-libunwind-aarch64=1
> >>>>   $
> >>>>
> >>>> Even tho this not being test built and those header files being
> >>>> available:
> >>>>
> >>>>   $ head -5 tools/build/feature/test-libunwind-aarch64.c
> >>>>   // SPDX-License-Identifier: GPL-2.0
> >>>>   #include <libunwind-aarch64.h>
> >>>>   #include <stdlib.h>
> >>>>
> >>>>   extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
> >>>>   $
> >>>>
> >>>> After this patch:
> >>>>
> >>>>   $ grep feature-libunwind- /tmp/b/FEATURE-DUMP
> >>>>   $
> >>>>
> >>>> Now an audit on what is being enabled when test-all.c builds will be
> >>>> performed.
> >>>>
> >>>> Fixes: 176c9d1e6a06f2fa ("tools features: Don't check for libunwind devel files by default")
> >>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
> >>>> Cc: Ian Rogers <irogers@google.com>
> >>>> Cc: James Clark <james.clark@linaro.org>
> >>>> Cc: Jiri Olsa <jolsa@kernel.org>
> >>>> Cc: Kan Liang <kan.liang@linux.intel.com>
> >>>> Cc: Namhyung Kim <namhyung@kernel.org>
> >>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>>
> >>> Sorry for the delay on this.
> >>>
> >>> Reviewed-by: Ian Rogers <irogers@google.com>
> >>
> >> Thanks for the review, but I think this part is used by other tools like
> >> BPF and tracing.  It'd be nice to get reviews from them.
> > 
> > Sgtm. The patch hasn't had attention for 3 months. A quick grep for
> > "unwind" and "UNW_" shows only use in perf and the feature tests.
> > 
> > Thanks,
> > Ian
> 
> 
> Indeed, bpftool does not rely on libunwind, and I don't remember other
> BPF components doing so, either.

Right, but my concern was about the feature test itself and the related
changes in the build files.

Can I get your Acked-by then?

Thanks,
Namhyung


