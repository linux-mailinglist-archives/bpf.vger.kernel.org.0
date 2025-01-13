Return-Path: <bpf+bounces-48711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9E9A0C2D2
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 21:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FC4169A89
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 20:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B441D2F42;
	Mon, 13 Jan 2025 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dispTSV/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A21C3038;
	Mon, 13 Jan 2025 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801783; cv=none; b=GjbnqUOyWsVFOTwPShzC8cEKq4txESh2snVBscr20rN1xDhSJdm2eYmfyWZ3iRlYlZXvt7YfoIpjtkpeWjmgDBbhOVbC80wt3PmJI+tAdB+ZH95Fxz5pcgRWASw0Ol+yF9kQkxBnFcKVA9vu9Dqb7EsXUfuvQXJQPsyqmNiF7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801783; c=relaxed/simple;
	bh=Lyl0OAsd7SE+SYZhWQXbxp+zPFHoMm70S7OryQ7l7bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFMXszzH4YdUGeQnis8VzqJ36GbzfUn0CE197WgV+5OUvXTxqL1Im4kejdzor6KkFLvbZD/cVY4xVh3oWYVXAoEfaLgzm5nb1DEfAR8cnri8cdf+/2ZW4HtFzl8LP+gzqBJIM219fF3EuwIH+n13sitlFN3LlIE7OMGIqQtMTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dispTSV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB66C4CEDD;
	Mon, 13 Jan 2025 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736801782;
	bh=Lyl0OAsd7SE+SYZhWQXbxp+zPFHoMm70S7OryQ7l7bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dispTSV/G2FFHmhFBqNYPhW5bJ9XAFAwwzWway4oeAFS3UKlvDyV2aKBJNMubGM69
	 eyqVfxkEkKX40rJkdWjmjPm18hKMxkWkeLo26FnHjAFZ6vnTaK199edmsYKbWFvK2D
	 9uUy6mM3VLLYU0B3zj8vn+DZWoIgXz7UYy4+C9Foy3+HC28jMQ0t5Cj3m6kXqwp7zr
	 Qyo8b4fh0eGGhYkvD7gtwCnYjOgzQHc+OvI1Nu40SAfdkuqQyVQitT0h4K5YkfZal4
	 nxM6IXpBVNO1tmmVOcjei/1bipxkRouIbbipUOLIn6dUcUnFHIKWX5a8hBxv++/Juh
	 Na27M1jW3aSEw==
Date: Mon, 13 Jan 2025 12:56:20 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>,
	Beeman Strong <beeman@rivosinc.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
Message-ID: <Z4V99KbadR7ib4FA@google.com>
References: <20250109222109.567031-1-irogers@google.com>
 <20250109222109.567031-5-irogers@google.com>
 <Z4F3qxFaYnMTtPw7@google.com>
 <CAHBxVyE12g+GFie6gcOPkzm2ckid=sTjZU4ofj6j6EgwPTsDQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHBxVyE12g+GFie6gcOPkzm2ckid=sTjZU4ofj6j6EgwPTsDQw@mail.gmail.com>

Hello,

On Fri, Jan 10, 2025 at 11:52:47AM -0800, Atish Kumar Patra wrote:
> On Fri, Jan 10, 2025 at 11:40 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Jan 09, 2025 at 02:21:09PM -0800, Ian Rogers wrote:
> > > Originally posted and merged from:
> > > https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> > > This reverts commit 4f1b067359ac8364cdb7f9fda41085fa85789d0f although
> > > the patch is now smaller due to related fixes being applied in commit
> > > 22a4db3c3603 ("perf evsel: Add alternate_hw_config and use in
> > > evsel__match").
> > > The original commit message was:
> > >
> > > It was requested that RISC-V be able to add events to the perf tool so
> > > the PMU driver didn't need to map legacy events to config encodings:
> > > https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
> > >
> > > This change makes the priority of events specified without a PMU the
> > > same as those specified with a PMU, namely sysfs and JSON events are
> > > checked first before using the legacy encoding.
> >
> > I'm still not convinced why we need this change despite of these
> > troubles.  If it's because RISC-V cannot define the lagacy hardware
> > events in the kernel driver, why not using a different name in JSON and
> 
> When the discussion happened a year back. we tried to avoid defining
> the legacy hardware events in
> the kernel driver. However, we agreed that we have to define it
> anyways for other reasons (legacy usage + virtualization)
> as described here[1]. I have improved the driver in such a way that it
> can handle both legacy events from the
> driver or json file (via this patch) if available. If this patch is
> available, a platform vendor can choose to encode the legacy events in
> json.
> Otherwise, it has to specify them in the driver. I will try to send
> the series today/tomorrow.

Ok, thanks for the update.

> 
> This patch will help avoid proliferation of usage of legacy events in
> the long run. But it is no longer absolutely necessary for RISC-V.
> If this patch is accepted, there is a hope that we can get rid of the
> specifying encodings in the driver in the distant future. However, we
> have
> to define them in the driver for reasons described in[1].
> 
> [1] https://lore.kernel.org/lkml/20241026121758.143259-1-irogers@google.com/T/#m653a6b98919a365a361a698032502bd26af9f6ba
> > ask users to use the name specifically?  Something like:
> >
> >   $ perf record -e riscv-cycles ...
> >
> 
> That was the first alternative I proposed back in 2022 plumbers :).

I see, sorry for missing the earlier discussion.

Thanks,
Namhyung


> But it was concluded that we don't want users to learn new ways
> of running perf in RISC-V which makes sense to me as well.


