Return-Path: <bpf+bounces-35692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8251693CC85
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 03:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194351F21FBD
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 01:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CDCB673;
	Fri, 26 Jul 2024 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuuqupEO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F636D;
	Fri, 26 Jul 2024 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721958069; cv=none; b=fXewiY/bNU3L1LaQ69/sx3k2v5neg2r5Tnyc6j/syU43D84lKf6zPi2DPSg3Kz/J7TBIlybchF8WaIfRwPmlOigYhdBa477aNMRFxWLacwfB00qv2LRRtPaSUusbAwUC26GE/feQMMdXQoAWqksml8fuAyY+JkGkjTZtOtY+16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721958069; c=relaxed/simple;
	bh=CSv3N6SE2riangAyu/ePy8t9sKbzcoTU6COThAA8Li8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTzJREO4vn6hym80fuev5hQld2WGOfDEvgR5h6QKKE7dSLoBfotnEP27sA9mQTc4qScuMYgb5Nows9/RDSvPufsfjPTcwTvSzXI9qnDvGksDbEE+z4eWaVVGrea7fN/K4sIcJmhD38L9AeVXKKdTFZz3ErbUsG5ErEut14YTO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuuqupEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED54EC116B1;
	Fri, 26 Jul 2024 01:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721958068;
	bh=CSv3N6SE2riangAyu/ePy8t9sKbzcoTU6COThAA8Li8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuuqupEOYHVHEA2SVR+s0dMeL89WEnRGbGAe2FmwFEd9uO6U+i9rd3fRUxLrD2LCx
	 gS4XnzCColJPZH4vf0iuIMCoJOS0BcwMpo+LXzrHLxSllJumwbdkFK9sxbmikKRv78
	 Kk1EvDN/ujCNzQ9GmUeUSWvxG9LGKuJF2IGbj5t0elgkYbYgpEPSvsiqexJzaRuodt
	 hNoI2fV9cEriY118h+9wvzmUCI2hiORcU6vU12sbmAqqvwCpO0qMzal1UVVnf56seG
	 y/o6CUAjaUqpuGYAXV3ny/fgdoBRJAIDFfTlRj/QGvll9UDwMtdSJUGzjDVgHed7yo
	 lMF/eof4KnRoQ==
Date: Thu, 25 Jul 2024 18:41:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 1/8] perf bpf-filter: Make filters map a single entry
 hashmap
Message-ID: <ZqL-sv_CSTqNnu-N@google.com>
References: <20240703223035.2024586-1-namhyung@kernel.org>
 <20240703223035.2024586-2-namhyung@kernel.org>
 <ZqFWwGTvzzLPhtxs@x1>
 <ZqFiC4z_EZtsB4Su@google.com>
 <ZqF0llbjINuvMcwP@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqF0llbjINuvMcwP@x1>

On Wed, Jul 24, 2024 at 06:39:34PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 24, 2024 at 01:20:27PM -0700, Namhyung Kim wrote:
> > On Wed, Jul 24, 2024 at 04:32:16PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Jul 03, 2024 at 03:30:28PM -0700, Namhyung Kim wrote:
> > > > And the value is now an array.  This is to support multiple filter
> > > > entries in the map later.
> > > > 
> > > > No functional changes intended.
> > > 
> > > Hey how can we test this feature these days?
> > 
> > There's a 'perf record sample filtering (by BPF) tests'.
> > 
> >   $ ./perf test -vv filtering
> >    95: perf record sample filtering (by BPF) tests:
> >   --- start ---
> >   test child forked, pid 1042594
> >   Checking BPF-filter privilege
> >   try 'sudo perf record --setup-filter pin' first.
> >   bpf-filter test [Skipped permission]
> >   ---- end(-2) ----
> >    95: perf record sample filtering (by BPF) tests                     : Skip
> > 
> > > 
> > > With this first patch applied:
> > > 
> > > root@number:~# perf record -a -W -e cycles:p --filter 'period > 100 || weight > 0' sleep 1
> > > Error: cpu_atom/cycles/p event does not have PERF_SAMPLE_WEIGHT
> > >  Hint: please add -W option to perf record
> > > failed to set filter "BPF" on event cpu_atom/cycles/p with 95 (Operation not supported)
> > > root@number:~# perf record -a -W -e cpu_core/cycles/p --filter 'period > 100 || weight > 0' sleep 1
> > > Error: cpu_core/cycles/p event does not have PERF_SAMPLE_WEIGHT
> > >  Hint: please add -W option to perf record
> > > failed to set filter "BPF" on event cpu_core/cycles/p with 95 (Operation not supported)
> > > root@number:~# perf record -a -W -e cpu_atom/cycles/p --filter 'period > 100 || weight > 0' sleep 1
> > > Error: cpu_atom/cycles/p event does not have PERF_SAMPLE_WEIGHT
> > >  Hint: please add -W option to perf record
> > > failed to set filter "BPF" on event cpu_atom/cycles/p with 95 (Operation not supported)
> > > root@number:~#
> > 
> > Do you say it's failing after the first patch?  It looks like the atom
> 
> yes
> 
> > CPU doesn't support PERF_SAMPLE_WEIGHT and should fail already.
> 
> I tried with 'cycles:p', 'cpu_atom/cycles/p' and with
> 'cpu_core/cycles/p', with and without -W (to use the warning advice)
> will try again tomorrow.

Let me know if you find anything.  Maybe it didn't set the flag in the
attr.  Can you run `perf record -W true && perf evlist -v` ?

Thanks,
Namhyung

