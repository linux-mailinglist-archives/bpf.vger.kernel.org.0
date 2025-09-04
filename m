Return-Path: <bpf+bounces-67472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7201BB442F9
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5510483A67
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DAC260580;
	Thu,  4 Sep 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6UxRI+f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491492F3C38;
	Thu,  4 Sep 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003887; cv=none; b=uMrvdn674Lp9YGEU7AkZu1D088puqH+PDWRw1UppHHFiBHRBavRZ4P9i39CZZk84ipE05jR0e6YfKKp9ek9W4wld8F5aEH58RKomM72X61YpLW+d5Da3AiwG0s9Cnutu79bQtjl6xE9fNukArwHq0dPmo880FufvQb0OFNTTMww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003887; c=relaxed/simple;
	bh=GM8BVc/lCUz3JRvFBhTmIBDA+zKVOyBTKFKiYcWAtQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEGconv1KCcejJKsLKpiFD6bmugX6BD/2rSFxLGOcVikYQVnL0KJXyB2HeuDOgRa5Bx5UnmqBgCuPFsb1NAoiaroGIXaAojiRNC9eao+0z0iDeLochpelTvtBDxiiL3V8J7dXEq/R8htmCmUDSCEfoIjarA9WyudzUxX92AW+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6UxRI+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1EEC4CEF0;
	Thu,  4 Sep 2025 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003886;
	bh=GM8BVc/lCUz3JRvFBhTmIBDA+zKVOyBTKFKiYcWAtQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6UxRI+fgNAd2wy+m9iIzJ7lycQIEDH0R6sDvZmDJNttg0I8+hO4a6T/GWHExgqvZ
	 HmwvPTeyO+K0OY8heQ7LC+LdBM+4tNQ4fOOYLbZUzgEN3eVT3w0h/FHlDsWHfJMS+v
	 hbsMQIsEhPgdoAaZwcyGpwLBJJ1Xvb2RreyirE36/rHrReRVmov0Jm5J8WGIoszPLD
	 bgonwrTevIDpAtvv18gwnztq3XE6JqNESmzaRjL2D9Rj4IRogNJkRNID/+LYrnIl2S
	 q5Z5R+QV0iEBCN2W7ukqilJvJ5SQqiQYkd1KOgDe1cMALW2HLblTVnrWajNfVd0Wem
	 h2MtuzzWIHdew==
Date: Thu, 4 Sep 2025 13:38:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Tomas Glozar <tglozar@redhat.com>, KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] perf auxtrace: Support AUX pause and resume with
 BPF
Message-ID: <aLnAazxkczTFSMcL@x1>
References: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
 <fd7c39d2-64b4-480e-8a29-abefcdc7d10a@intel.com>
 <20250730182623.GE143191@e132581.arm.com>
 <0a0ed9d4-6511-4f0b-868f-22a3f95697f8@intel.com>
 <20250808114734.GB3420125@e132581.arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808114734.GB3420125@e132581.arm.com>

On Fri, Aug 08, 2025 at 12:47:34PM +0100, Leo Yan wrote:
> On Tue, Aug 05, 2025 at 10:16:29PM +0300, Adrian Hunter wrote:
> > On 30/07/2025 21:26, Leo Yan wrote:
> > > On Mon, Jul 28, 2025 at 08:02:51PM +0300, Adrian Hunter wrote:
> > >> On 25/07/2025 12:59, Leo Yan wrote:
> > >>> This series extends Perf for fine-grained tracing by using BPF program
> > >>> to pause and resume AUX tracing. The BPF program can be attached to
> > >>> tracepoints (including ftrace tracepoints and dynamic tracepoints, like
> > >>> kprobe, kretprobe, uprobe and uretprobe).

> > >> Using eBPF to pause/resume AUX tracing seems like a great idea.

> > >> AFAICT with this patch set, there is just support for pause/resume
> > >> much like what could be done directly without eBPF, so I wonder if you
> > >> could share a bit more on how you see this evolving, and what your
> > >> future plans are?

> > > IIUC, here you mean the tool can use `perf probe` to firstly create
> > > probes, then enable tracepoints as PMU event for AUX pause and resume.

> > Yes, like:

> > $ sudo perf probe 'do_sys_openat2 how->flags how->mode'
> > Added new event:
> >   probe:do_sys_openat2 (on do_sys_openat2 with flags=how->flags mode=how->mode)

> > You can now use it in all perf tools, such as:

> >         perf record -e probe:do_sys_openat2 -aR sleep 1

> > $ sudo perf probe do_sys_openat2%return
> > Added new event:
> >   probe:do_sys_openat2__return (on do_sys_openat2%return)

> > You can now use it in all perf tools, such as:

> >         perf record -e probe:do_sys_openat2__return -aR sleep 1

> > $ sudo perf record --kcore -e intel_pt/aux-action=start-paused/k -e probe:do_sys_openat2/aux-action=resume/ --filter='flags==0x98800' -e probe:do_sys_openat2__return/aux-action=pause/ -- ls

> Thanks a lot for sharing the commands. I was able to replicate them
> using CoreSight.

> Given that we can achieve the same result without using BPF, I am not
> sure how useful this series is. It may give us a base for exploring
> profiling that combines AUX trace and BPF, but I am fine with holding
> on until we have clear requirements for it.

> I would get suggestion from you and maintainers before proceeding
> further.

Maybe retrofit this for starting stopping profiling non HW tracing
sections?

We have now:

⬢ [acme@toolbx perf-tools-next]$ perf record -h switch

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

        --switch-events   Record context switch events
        --switch-max-files <n>
                          Limit number of switch output generated files
        --switch-output[=<signal or size[BKMG] or time[smhd]>]
                          Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold
        --switch-output-event <switch output event>
                          switch output event selector. use 'perf list' to list available events

⬢ [acme@toolbx perf-tools-next]$

That will dump a snapshot when some event takes place, but that is done
with a sideband thread, from 'man perf-record':

--switch-output-event::
Events that will cause the switch of the perf.data file, auto-selecting
--switch-output=signal, the results are similar as internally the side band
thread will also send a SIGUSR2 to the main one.

Uses the same syntax as --event, it will just not be recorded, serving only to
switch the perf.data file as soon as the --switch-output event is processed by
a separate sideband thread.

This sideband thread is also used to other purposes, like processing the
PERF_RECORD_BPF_EVENT records as they happen, asking the kernel for extra BPF
information, etc.

----------------------

And in perf-report we have:

----

--switch-on EVENT_NAME::
        Only consider events after this event is found.

        This may be interesting to measure a workload only after some initialization
        phase is over, i.e. insert a perf probe at that point and then using this
        option with that probe.

--switch-off EVENT_NAME::
        Stop considering events after this event is found.

--show-on-off-events::
        Show the --switch-on/off events too. This has no effect in 'perf report' now
        but probably we'll make the default not to show the switch-on/off events
        on the --group mode and if there is only one event besides the off/on ones,
        go straight to the histogram browser, just like 'perf report' with no events
        explicitly specified does.

----

If we had it in 'perf record' then we would have reduced perf.data
files.

I.e. we would have something like '-e {cycles,instructions}/action=start-paused/k' -e probe:do_sys_openat2/action=resume/ --filter='flags==0x98800' -e probe:do_sys_openat2__return/action=pause/

- Arnaldo

