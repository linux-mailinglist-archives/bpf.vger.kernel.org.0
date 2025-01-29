Return-Path: <bpf+bounces-50065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D87A22594
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 22:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26C016700A
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0061E376C;
	Wed, 29 Jan 2025 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoRPa/11"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19219CC33;
	Wed, 29 Jan 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738185851; cv=none; b=Fo8nn/rZcfbq/RJJ3XptXQoddmApJX3GV871v8gWBpWr6JDBAbPeUf4JlxufdSMKynzdO3vT2XGw0jHV/8jMvYKKUy6h7fDH4SRpV/aqGyT5GWq0Y8d1ICblYpP7gxeRL7QAnXPes9t93sA8i3woiluZ4C/qOVnIBaoQTwJ94+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738185851; c=relaxed/simple;
	bh=QmMDy4hSKkSGdkNKClNFLZcY0gag8iYZv1FwISiITCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHB2Gj0WxD+OEfvtyERUnJZJQQ8mIx/froByj724nLR22vMfgxjMG0gTb+YS9Yq3W4HdJQob6NWGIPTjTk+L6SVatMXqPGFTJUYmMSVR6BCf6+W0BX4cthNjt6v8UlD4WmesZ+grpOeLMqAd3438Ba79hQ4GkNJPI8ptZbkWoiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoRPa/11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A664C4CED1;
	Wed, 29 Jan 2025 21:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738185850;
	bh=QmMDy4hSKkSGdkNKClNFLZcY0gag8iYZv1FwISiITCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HoRPa/11Ni4HPEGxiGEh6wiztJMtzAUy3Z/81nQktNBVT2tLAOqAdNWR1C1oYpTA+
	 /UN69mZqQoXlvvAfOuyJuB9eslpawixmAD6d+rJgOCJkS7ovPKPDZvRyB/hXasaVy9
	 n1sGTeEWGE6zugv2RZnAg7xOrI8kAmeixpXAfQCB+Dt6EMimdM3bAZo87WCuraruh1
	 +ar1HKKZguzlXoGd3pIlHEUiUlMN2kApLvmthrq+zgU+//OsiOqxXf5+bKhpU9G6X4
	 6xxEIP0/DYuZ/6D02wQ6MSPYb2WS82xeAAOppCa8lgi0DDisJuyK3o3FNipQx9f/Zi
	 vpC1ErAR2GIRQ==
Date: Wed, 29 Jan 2025 13:24:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
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
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v5 3/4] perf record: Skip don't fail for events that
 don't open
Message-ID: <Z5qcd6upvrPOqayY@google.com>
References: <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com>
 <Z4EsUAtOKZUzcw2S@x1>
 <CAP-5=fV2cYjxf6jvYcKkd=2wcQrbR=58qafiSJ-qzE17EmWqGQ@mail.gmail.com>
 <Z4F0bKnCHCaqdvFw@google.com>
 <CAP-5=fVn=0n=gN6ngMmBTry3A+US3z=bX5SzVP6Zs0J0t2HLuA@mail.gmail.com>
 <Z4V8ykyHErC89iYj@google.com>
 <CAP-5=fXSjLWd4j08Um7deqB3dHbk+1DpTpddr7wkYOUJTeScrg@mail.gmail.com>
 <Z4fxAQAHZ9JtdHiL@google.com>
 <CAP-5=fUz6Nkj+iRuAjjTGXib==jYCvqopa4Zg7TK2MAT7Ns+iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUz6Nkj+iRuAjjTGXib==jYCvqopa4Zg7TK2MAT7Ns+iA@mail.gmail.com>

Hi Ian,

Sorry for the delay.

On Wed, Jan 15, 2025 at 09:56:59AM -0800, Ian Rogers wrote:
> On Wed, Jan 15, 2025 at 9:31 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Jan 13, 2025 at 03:04:26PM -0800, Ian Rogers wrote:
> > > On Mon, Jan 13, 2025 at 12:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Fri, Jan 10, 2025 at 01:33:57PM -0800, Ian Rogers wrote:
> > > > > On Fri, Jan 10, 2025 at 11:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Jan 10, 2025 at 08:42:02AM -0800, Ian Rogers wrote:
[...]
> > > > > > > A patch lowering the priority of error messages should be independent
> > > > > > > of the 4 changes here. I'd be happy if someone follows this series
> > > > > > > with a patch doing it.
> > > > > >
> > > > > > I think the error behavior is a part of this change.
> > > > >
> > > > > I disagree with it, so I think you need to address my comments.
> > > >
> > > > You are changing the error behavior by skipping failed events then the
> > > > relevant error messages should be handled properly in this patchset.
> > >
> > > I'm not sure what you are asking and I'm not sure why it matters?
> > > Previously you'd asked for all the output to be moved under verbose.
> > >
> > > If I specify an event that doesn't work with perf record today then it
> > > fails. With this patch it fails too. If that event is a core PMU event
> > > then there will be an error message for each core PMU that doesn't
> > > support the event. So I get 2 error messages on hybrid. This doesn't
> > > feel egregious or warrant a new error message mechanism. I would like
> > > it so that evsels supported 1 or more PMUs, in which case this would
> > > be 1 error message.
> > >
> > > If I specify perf record today on an uncore event then perf record
> > > fails and I get 1 error message for the uncore PMU. The new behavior
> > > will be to get 1 error message per uncore PMU. If I'm on a server with
> > > 10s of uncore PMUs then maybe the message is spammy, but the command
> > > fails today and will continue to fail with this series. I don't see a
> > > motivation to change or optimize for this case and again, evsels that
> > > support >1 PMU would be the most appropriate fix.
> > >
> > > The only case where there is no message today but would be with this
> > > patch series is for cycles on ARM's neoverse. There will be one
> > > warning for the evsel on the SLC PMU. That's one warning and not many.
> > >
> > > As I've said, if you want a more elaborate error reporting system then
> > > take these patches and add it to them. There's a larger refactor to
> > > make evsels support >1 PMU that would clean up the many events on
> > > server uncore PMUs issue, but that shouldn't be part of this series
> > > nor gate it. If you are trying to perf record on uncore PMUs then you
> > > already have problems and optimizing the error messages for your
> > > mistake, I don't get why it matters?
> >
> > What about with multiple events in the command line - one of them
> > failing with >1 PMUs and the command now succeeds?
> 
> So this would be something like:
> ```
> $ perf record -e cycles,instructions,data_read -a sleep 1
> ```
> where data_read is an uncore PMU event. The current behavior is:
> ```
> $ perf record -e cycles,instructions,data_read -a sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> ```
> The new behavior is:
> ```
> $ perf record -e cycles,instructions,data_read -a sleep 1
> Error:
> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0'
> which will be removed.
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> 
> Error:
> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1'
> which will be removed.
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> 
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 3.138 MB perf.data (11670 samples) ]
> ```
> 
> We know nobody does this, as the command currently fails. It succeeds
> with this change, because that's the whole point of the change.

Well, I think it's because it failed before.  New users can come anytime
and do whatever they want (or can).  They might pass 100 failing events
with 1 successful event and it will give a ton of warnings with this.
So it'd be better ratelimit the message and make it optional (with -v).

But more importantly, I think we should agree on the patch 4 first.

Thanks,
Namhyung


> I'm not offended by seeing the event was being opened on >1 PMU. For the
> only currently succeeding situation where this will now warn, the
> cycles case on Neoverse because of the buggy event name in ARM's SLC
> PMU, there will be 1 warning. For my example the appropriate fix is to
> remove the data_read event. For the Neoverse case, specifying the PMU
> resolves the issue until ARM fixes their driver.

