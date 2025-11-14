Return-Path: <bpf+bounces-74549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F382BC5F055
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC287358EBD
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F13F2EFDB5;
	Fri, 14 Nov 2025 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHiP+1Zv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A51ADC83;
	Fri, 14 Nov 2025 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763147720; cv=none; b=NZPLyU30koNjJU+vjimzckqWgvQVe98ujRXPjdROft8mWCjH8fmxMP6VRz2Kw2JZpQdgFwdHQ9pb2m2LfqtTU2d/fPKhvMxoVwWMZNvLQ5xr8LDA+JRjg4SJl1sY5PgbLwBmsm3lIv1+88TaCWIEureaH39pqp5n6Ii3+27JSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763147720; c=relaxed/simple;
	bh=Mzp7/jzbXLl59HdbUyfappzk2W20O5AOWd0s8PcBajg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/RTInnzMpEs/iuWrK3QdJwtY2kznaYXri0PA4V07dQXPSKmYjJNxAx4bWHlQzZ0dI28U+W5s1wItKRUVmhbuOUPDilg2xM8OLU7IlTCaFCXlzyAtISOw9jNOlauZgIZ0fmrX4Ti93aa0kjE/XJpwPpBoJzVyEr+7afvlv8b0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHiP+1Zv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E570C4CEF1;
	Fri, 14 Nov 2025 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763147720;
	bh=Mzp7/jzbXLl59HdbUyfappzk2W20O5AOWd0s8PcBajg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHiP+1Zv1QoY9I2uRBNgR0qV68Hda0P/P1G3qyOcCKbRfFZq90hFDWsbAl+3PB+CD
	 bQOD+alPN3GNGxv9JE1VUzAXiA+jAW3An5KnryqV1Ybl+tD8I+kE1rBzvZrbMUIQB/
	 AB9DZ6IVzPGklZHwrr/Jgm4gFzYStuhNrAhLQT6h2PXdYLtmUwmPRy5Zz6DZ3/mLdG
	 SpmAO1qIWJ1j+UdT9i1cSxRygnSiQX1vdQGwpMAxmyMRzH9lOpALA+HhtleYIlP2uv
	 rrrUcJSoJIy34Xin5zh+HvBQ+ckf8d5D4HZnVrl5/xvP+1fgYyNf/xAwHqmlaUd0fM
	 uqmsFlGWvn3qA==
Date: Fri, 14 Nov 2025 11:15:18 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 3/5] perf record: Enable defer_callchain for user
 callchains
Message-ID: <aRd_xgPPlk9PiKm_@google.com>
References: <20251114070018.160330-1-namhyung@kernel.org>
 <20251114070018.160330-4-namhyung@kernel.org>
 <CAP-5=fVEuYXw+P-+Z7bU7Z-+7dsHPPfABh5pdnPtfvH-23u4Qw@mail.gmail.com>
 <CAP-5=fU33sEARn0tc1hSMahBVCvs0cy+Cu-J6+BG0Cm-nuwKnA@mail.gmail.com>
 <CAP-5=fVptEdzt363LpuZzzm=BJFFkB_xkOLW=x-2-TZa+cvS0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVptEdzt363LpuZzzm=BJFFkB_xkOLW=x-2-TZa+cvS0g@mail.gmail.com>

On Fri, Nov 14, 2025 at 10:12:34AM -0800, Ian Rogers wrote:
> On Fri, Nov 14, 2025 at 10:09 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 9:59 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Thu, Nov 13, 2025 at 11:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > And add the missing feature detection logic to clear the flag on old
> > > > kernels.
> > > >
> > > >   $ perf record -g -vv true
> > > >   ...
> > > >   ------------------------------------------------------------
> > > >   perf_event_attr:
> > > >     type                             0 (PERF_TYPE_HARDWARE)
> > > >     size                             136
> > > >     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > > >     { sample_period, sample_freq }   4000
> > > >     sample_type                      IP|TID|TIME|CALLCHAIN|PERIOD
> > > >     read_format                      ID|LOST
> > > >     disabled                         1
> > > >     inherit                          1
> > > >     mmap                             1
> > > >     comm                             1
> > > >     freq                             1
> > > >     enable_on_exec                   1
> > > >     task                             1
> > > >     sample_id_all                    1
> > > >     mmap2                            1
> > > >     comm_exec                        1
> > > >     ksymbol                          1
> > > >     bpf_event                        1
> > > >     defer_callchain                  1
> > > >     defer_output                     1
> > > >   ------------------------------------------------------------
> > > >   sys_perf_event_open: pid 162755  cpu 0  group_fd -1  flags 0x8
> > > >   sys_perf_event_open failed, error -22
> > > >   switching off deferred callchain support
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
> > > >  tools/perf/util/evsel.h |  1 +
> > > >  2 files changed, 25 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > > index 244b3e44d090d413..f5652d00b457d096 100644
> > > > --- a/tools/perf/util/evsel.c
> > > > +++ b/tools/perf/util/evsel.c
> > > > @@ -1061,6 +1061,14 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
> > > >                 }
> > > >         }
> > > >
> > > > +       if (param->record_mode == CALLCHAIN_FP && !attr->exclude_callchain_user) {
> > > > +               /*
> > > > +                * Enable deferred callchains optimistically.  It'll be switched
> > > > +                * off later if the kernel doesn't support it.
> > > > +                */
> > > > +               attr->defer_callchain = 1;
> > > > +       }
> > >
> > > If a user has requested frame pointer call chains why would they want
> > > deferred call chains? The point of deferral to my understanding is to
> > > allow the paging in of debug data, but frame pointers don't need that
> > > as the stack should be in the page cache.
> > >
> > > Is this being done for code coverage reasons so that deferral is known
> > > to work for later addition of SFrames? In which case this should be an
> > > opt-in not default behavior. When there is a record_mode of
> > > CALLCHAIN_SFRAME then making deferral the default for that mode makes
> > > sense, but not for frame pointers IMO.
> >
> > Just to be clear. I don't think the behavior of using frame pointers
> > should change. Deferral has downsides, for example:
> >
> >   $ perf record -g -a sleep 1
> >
> > Without deferral kernel stack traces will contain both kernel and user
> > traces. With deferral the user stack trace is only generated when the
> > system call returns and so there is a chance for kernel stack traces
> > to be missing their user part. An obvious behavioral change. I think
> > for what you are doing here we can have an option something like:
> >
> >   $ perf record --call-graph fp-deferred -a sleep 1
> >
> > Which would need a man page update, etc. What is happening with the
> > other call-graph modes and deferral? Could the option be something
> > like `--call-graph fp,deferred` so that the option is a common one and
> > say stack snapshots for dwarf be somehow improved?
> 
> Also, making deferral the norm will generate new perf events that
> tools, other than perf, processing perf.data files will fail to
> consume. So this change would break quite a lot of stuff, so it should
> not just be made the default.

Thanks a lot for your input!  Yeah I agree it'd be better to make it
optional.  Having separate `--call-graph fp,defer` sounds good.  I can
add a config option to control deferred callchains as well.

Thanks,
Namhyung


