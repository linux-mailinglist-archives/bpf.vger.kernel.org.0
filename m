Return-Path: <bpf+bounces-65381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247EDB2164E
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221FF4641FC
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 20:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3A42D9EE3;
	Mon, 11 Aug 2025 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkOQww5W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2BB205E25;
	Mon, 11 Aug 2025 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943315; cv=none; b=TLDBV0ebytbVQvQiY8zdakfdLFaLhgDKsGXkU2ssOVpVCsxf/g4btW8YX0S+lL4ZzSrsMHLU/I7PxFEGjqUzT0abXHb1vhuqswVKFCfBTV+Qfwh40HKjZnM8tmJwD+Ey8EalrAS9EeIsos2LeMHTkn2k4ccQsBFdUtGt2OX7b6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943315; c=relaxed/simple;
	bh=gZ8lo32or50HycBX+l6zXrHMnUI5M8PsnJpxtgBY1DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWePppcQspuiGLMped/uNpBEGdqjRV7PPN2F9/1uUqQradFFZ9YRbYqt9yrNnUqQHP1W1nDW16W0pjaz3Fl3xZQSej+08FLYyDM0N+f4l2d+HlGClES01Pt9Y0ZxyrrhKNWXrkRy078htLmuE6JdhGVqnmId5MqcdrVRM4sFTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkOQww5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E16C4CEED;
	Mon, 11 Aug 2025 20:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754943314;
	bh=gZ8lo32or50HycBX+l6zXrHMnUI5M8PsnJpxtgBY1DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UkOQww5WuQcXnvgRkZLJ2XhT5ssk7lvZ8U5wym923AU2YWOVaDr/ZVC3QjqFPKqEq
	 WFfUc8pob2rHKmHbHHYttgo2o8V/F5vX6TJb3xOzMlUylbjuLrLOOyzqYYWWPdMdJm
	 3dT7dYbqhwJlqMBqwao6I8hpISjctcmidl2Fk2Ams3LxcnEnOo1bvLe1fvKq81iGZ5
	 MOk+pOiskOqnq4tt4ur9mzDZXtvNqvTI8HQuxKDYi2824RnBp8xJfwRSrf6rbCIeEV
	 Sjw4ajEuMseXaHOFAyD1DU6VaBBODc0nF8zMh+A95l829+5X+FLB0q9fB18TpMvNz2
	 eFhCL4lGBfCVg==
Date: Mon, 11 Aug 2025 13:15:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [RFC PATCH v1] perf trace: Mitigate failures in parallel perf
 trace instances
Message-ID: <aJpPUHUEJ7cLKd8e@google.com>
References: <20250529065537.529937-1-howardchu95@gmail.com>
 <aDpBTLoeOJ3NAw_-@google.com>
 <CAH0uvojGoLX6mpK9wA1cw-EO-y_fUmdndAU8eZ1pa70Lc_rvvw@mail.gmail.com>
 <20250602181743.1c3dabea@gandalf.local.home>
 <aEAfHYLEyc7xGy7E@krava>
 <CAH0uvogvkRoHc6jWYSJHLenaRMru23YaGfA1i_vWZ6eF9LwVzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvogvkRoHc6jWYSJHLenaRMru23YaGfA1i_vWZ6eF9LwVzw@mail.gmail.com>

Hello,

Sorry for the late reply.

On Mon, Jun 09, 2025 at 11:38:00AM -0700, Howard Chu wrote:
> Hi Jiri,
> 
> On Wed, Jun 4, 2025 at 3:25 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Jun 02, 2025 at 06:17:43PM -0400, Steven Rostedt wrote:
> > > On Fri, 30 May 2025 17:00:38 -0700
> > > Howard Chu <howardchu95@gmail.com> wrote:
> > >
> > > > Hello Namhyung,
> > > >
> > > > On Fri, May 30, 2025 at 4:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > On Wed, May 28, 2025 at 11:55:36PM -0700, Howard Chu wrote:
> > > > > > perf trace utilizes the tracepoint utility, the only filter in perf
> > > > > > trace is a filter on syscall type. For example, if perf traces only
> > > > > > openat, then it filters all the other syscalls, such as readlinkat,
> > > > > > readv, etc.
> > > > > >
> > > > > > This filtering is flawed. Consider this case: two perf trace
> > > > > > instances are running at the same time, trace instance A tracing
> > > > > > readlinkat, trace instance B tracing openat. When an openat syscall
> > > > > > enters, it triggers both BPF programs (sys_enter) in both perf trace
> > > > > > instances, these kernel functions will be executed:
> > > > > >
> > > > > > perf_syscall_enter
> > > > > >   perf_call_bpf_enter
> > > > > >     trace_call_bpf
> > > > > >       bpf_prog_run_array
> > > > > >
> > > > > > In bpf_prog_run_array:
> > > > > > ~~~
> > > > > > while ((prog = READ_ONCE(item->prog))) {
> > > > > >       run_ctx.bpf_cookie = item->bpf_cookie;
> > > > > >       ret &= run_prog(prog, ctx);
> > > > > >       item++;
> > > > > > }
> > > > > > ~~~
> > > > > >
> > > > > > I'm not a BPF expert, but by tinkering I found that if one of the BPF
> > > > > > programs returns 0, there will be no tracepoint sample. That is,
> > > > > >
> > > > > > (Is there a sample?) = ProgRetA & ProgRetB & ProgRetC
> > > > > >
> > > > > > Where ProgRetA is the return value of one of the BPF programs in the BPF
> > > > > > program array.
> > > > > >
> > > > > > Go back to the case, when two perf trace instances are tracing two
> > > > > > different syscalls, again, A is tracing readlinkat, B is tracing openat,
> > > > > > when an openat syscall enters, it triggers the sys_enter program in
> > > > > > instance A, call it ProgA, and the sys_enter program in instance B,
> > > > > > ProgB, now ProgA will return 0 because ProgA cares about readlinkat only,
> > > > > > even though ProgB returns 1; (Is there a sample?) = ProgRetA (0) &
> > > > > > ProgRetB (1) = 0. So there won't be a tracepoint sample in B's output,
> > > > > > when there really should be one.
> > > > >
> > > > > Sounds like a bug.  I think it should run bpf programs attached to the
> > > > > current perf_event only.  Isn't it the case for tracepoint + perf + bpf?
> > > >
> > > > I really can't answer that question.
> >
> > bpf programs for tracepoint are executed before the perf event specific
> > check/trigger in perf_trace_run_bpf_submit
> >
> > bpf programs array is part of struct trace_event_call so it's global per
> > tracepoint, not per perf event

Right, I think we need a way to attach a BPF program to perf_event (as
an overflow handler), not to the trace_event_call, when it comes to a
tracepoint event.  So that it can only affect behaviors of the calling
thread.  It would access the trace data as sample raw data from ctx.

Maybe it needs new link_create flags and requires BPF_PROG_TYPE_PERF_EVENT.

Wdyt?

Thanks,
Namhyung


