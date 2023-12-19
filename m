Return-Path: <bpf+bounces-18321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B0C818E13
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B241C24CE4
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CB031A68;
	Tue, 19 Dec 2023 17:27:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56312D7A7
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 17:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78948C433C7;
	Tue, 19 Dec 2023 17:27:52 +0000 (UTC)
Date: Tue, 19 Dec 2023 12:28:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Philo Lu
 <lulie@linux.alibaba.com>, bpf@vger.kernel.org, song@kernel.org,
 andrii@kernel.org, ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 guwen@linux.alibaba.com, alibuda@linux.alibaba.com,
 hengqi@linux.alibaba.com, Nathan Slingerland <slinger@meta.com>,
 "rihams@meta.com" <rihams@meta.com>, Alan Maguire
 <alan.maguire@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with
 overwriting
Message-ID: <20231219122850.433be151@gandalf.local.home>
In-Reply-To: <20231219083851.0ec83349@gandalf.local.home>
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
	<c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com>
	<CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
	<23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com>
	<CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
	<qdiw6a7acgvepckv6uts5iusp74m7ud4i4lpniu3mgq6jdrs6s@mnttkagth64k>
	<20231219083851.0ec83349@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


BTW, if anyone's interested, there's a "benchmark" trace event when you
enable:

  CONFIG_TRACEPOINT_BENCHMARK=y

You can see the code in: kernel/trace/trace_benchmark.c:

Which does a loop of:

	local_irq_disable();
	start = trace_clock_local();
	trace_benchmark_event(bm_str, bm_last);
	stop = trace_clock_local();
	local_irq_enable();

Where it writes the result of the previous timings into the current trace
event via the bm_str:


	delta = stop - start;

	[..]

	bm_last = delta;

	[..]

	scnprintf(bm_str, BENCHMARK_EVENT_STRLEN,
		  "last=%llu first=%llu max=%llu min=%llu avg=%u std=%d std^2=%lld",
		  bm_last, bm_first, bm_max, bm_min, avg, std, stddev);




I ran: perf record -a -e benchmark:benchmark_event sleep 20

and perf script produces (I scrolled down to get to hot cache):

 event_benchmark    2289 [001]   672.581425: benchmark:benchmark_event: last=247 first=5693 max=8969 min=204 avg=240 std=234 std^2=55157 delta=247
 event_benchmark    2289 [001]   672.581426: benchmark:benchmark_event: last=222 first=5693 max=8969 min=204 avg=240 std=234 std^2=55151 delta=222
 event_benchmark    2289 [001]   672.581427: benchmark:benchmark_event: last=229 first=5693 max=8969 min=204 avg=240 std=234 std^2=55144 delta=229
 event_benchmark    2289 [001]   672.581427: benchmark:benchmark_event: last=221 first=5693 max=8969 min=204 avg=240 std=234 std^2=55138 delta=221
 event_benchmark    2289 [001]   672.581428: benchmark:benchmark_event: last=223 first=5693 max=8969 min=204 avg=240 std=234 std^2=55131 delta=223
 event_benchmark    2289 [001]   672.581428: benchmark:benchmark_event: last=220 first=5693 max=8969 min=204 avg=240 std=234 std^2=55125 delta=220
 event_benchmark    2289 [001]   672.581429: benchmark:benchmark_event: last=215 first=5693 max=8969 min=204 avg=240 std=234 std^2=55118 delta=215
 event_benchmark    2289 [001]   672.581430: benchmark:benchmark_event: last=221 first=5693 max=8969 min=204 avg=240 std=234 std^2=55112 delta=221
 event_benchmark    2289 [001]   672.581430: benchmark:benchmark_event: last=240 first=5693 max=8969 min=204 avg=240 std=234 std^2=55105 delta=240
 event_benchmark    2289 [001]   672.581431: benchmark:benchmark_event: last=225 first=5693 max=8969 min=204 avg=240 std=234 std^2=55099 delta=225
 event_benchmark    2289 [001]   672.581432: benchmark:benchmark_event: last=235 first=5693 max=8969 min=204 avg=240 std=234 std^2=55092 delta=235
 event_benchmark    2289 [001]   672.581432: benchmark:benchmark_event: last=220 first=5693 max=8969 min=204 avg=240 std=234 std^2=55086 delta=220
 event_benchmark    2289 [001]   672.581433: benchmark:benchmark_event: last=245 first=5693 max=8969 min=204 avg=240 std=234 std^2=55079 delta=245
 event_benchmark    2289 [001]   672.581433: benchmark:benchmark_event: last=215 first=5693 max=8969 min=204 avg=240 std=234 std^2=55073 delta=215
 event_benchmark    2289 [001]   672.581434: benchmark:benchmark_event: last=216 first=5693 max=8969 min=204 avg=240 std=234 std^2=55066 delta=216


For ftrace: trace-cmd record -e benchmark_event sleep 20

trace-cmd report:

 event_benchmark-2253  [000]   549.747068: benchmark_event:      last=78 first=2674 max=1185 min=71 avg=84 std=30 std^2=935 delta=78
 event_benchmark-2253  [000]   549.747069: benchmark_event:      last=79 first=2674 max=1185 min=71 avg=84 std=30 std^2=935 delta=79
 event_benchmark-2253  [000]   549.747069: benchmark_event:      last=72 first=2674 max=1185 min=71 avg=84 std=30 std^2=935 delta=72
 event_benchmark-2253  [000]   549.747069: benchmark_event:      last=79 first=2674 max=1185 min=71 avg=84 std=30 std^2=935 delta=79
 event_benchmark-2253  [000]   549.747070: benchmark_event:      last=78 first=2674 max=1185 min=71 avg=84 std=30 std^2=935 delta=78
 event_benchmark-2253  [000]   549.747070: benchmark_event:      last=78 first=2674 max=1185 min=71 avg=84 std=30 std^2=934 delta=78
 event_benchmark-2253  [000]   549.747071: benchmark_event:      last=79 first=2674 max=1185 min=71 avg=84 std=30 std^2=934 delta=79
 event_benchmark-2253  [000]   549.747071: benchmark_event:      last=78 first=2674 max=1185 min=71 avg=84 std=30 std^2=934 delta=78
 event_benchmark-2253  [000]   549.747072: benchmark_event:      last=80 first=2674 max=1185 min=71 avg=84 std=30 std^2=934 delta=80
 event_benchmark-2253  [000]   549.747072: benchmark_event:      last=79 first=2674 max=1185 min=71 avg=84 std=30 std^2=934 delta=79
 event_benchmark-2253  [000]   549.747073: benchmark_event:      last=78 first=2674 max=1185 min=71 avg=84 std=30 std^2=933 delta=78
 event_benchmark-2253  [000]   549.747073: benchmark_event:      last=165 first=2674 max=1185 min=71 avg=84 std=30 std^2=935 delta=165
 event_benchmark-2253  [000]   549.747074: benchmark_event:      last=79 first=2674 max=1185 min=71 avg=84 std=30 std^2=934 delta=79
 event_benchmark-2253  [000]   549.747074: benchmark_event:      last=153 first=2674 max=1185 min=71 avg=84 std=30 std^2=935 delta=153
 event_benchmark-2253  [000]   549.747075: benchmark_event:      last=78 first=2674 max=1185 min=71 avg=84 std=30 std^2=935 delta=78
 event_benchmark-2253  [000]   549.747075: benchmark_event:      last=78 first=2674 max=1185 min=71 avg=84 std=30 std^2=935 delta=78
 event_benchmark-2253  [000]   549.747076: benchmark_event:      last=78 first=2674 max=1185 min=71 avg=84 std=30 std^2=935 delta=78
 event_benchmark-2253  [000]   549.747076: benchmark_event:      last=73 first=2674 max=1185 min=71 avg=84 std=30 std^2=934 delta=73
 event_benchmark-2253  [000]   549.747077: benchmark_event:      last=79 first=2674 max=1185 min=71 avg=84 std=30 std^2=934 delta=79
 event_benchmark-2253  [000]   549.747077: benchmark_event:      last=78 first=2674 max=1185 min=71 avg=84 std=30 std^2=934 delta=78


For normal tracing, the average perf event takes 204ns per event, and the
average ftrace event takes 84ns per event. The "first" in the output above
is how long the first event took (which was cold cache).

I added filtering to trace-cmd with:

 trace-cmd record -o trace-filter.dat -e benchmark_event -f 'delta & 1' sleep 20

I should modify the event to have a counter so that I can filter every
other event with that, but for now I just print out anything that has an
odd delta.

 event_benchmark-2548  [000]  1558.776493: benchmark_event:       str=last=199 first=1964 max=2215 min=40 avg=78 std=44 std^2=2022 delta=199
 event_benchmark-2548  [000]  1558.776498: benchmark_event:       str=last=43 first=1964 max=2215 min=40 avg=78 std=44 std^2=2021 delta=43
 event_benchmark-2548  [000]  1558.776498: benchmark_event:       str=last=191 first=1964 max=2215 min=40 avg=78 std=44 std^2=2022 delta=191
 event_benchmark-2548  [000]  1558.776500: benchmark_event:       str=last=41 first=1964 max=2215 min=40 avg=78 std=44 std^2=2022 delta=41
 event_benchmark-2548  [000]  1558.776500: benchmark_event:       str=last=119 first=1964 max=2215 min=40 avg=78 std=44 std^2=2022 delta=119
 event_benchmark-2548  [000]  1558.776501: benchmark_event:       str=last=41 first=1964 max=2215 min=40 avg=78 std=44 std^2=2022 delta=41
 event_benchmark-2548  [000]  1558.776502: benchmark_event:       str=last=105 first=1964 max=2215 min=40 avg=78 std=44 std^2=2022 delta=105
 event_benchmark-2548  [000]  1558.776503: benchmark_event:       str=last=41 first=1964 max=2215 min=40 avg=78 std=44 std^2=2022 delta=41
 event_benchmark-2548  [000]  1558.776505: benchmark_event:       str=last=41 first=1964 max=2215 min=40 avg=78 std=44 std^2=2021 delta=41
 event_benchmark-2548  [000]  1558.776505: benchmark_event:       str=last=111 first=1964 max=2215 min=40 avg=78 std=44 std^2=2021 delta=111
 event_benchmark-2548  [000]  1558.776506: benchmark_event:       str=last=109 first=1964 max=2215 min=40 avg=78 std=44 std^2=2021 delta=109
 event_benchmark-2548  [000]  1558.776506: benchmark_event:       str=last=109 first=1964 max=2215 min=40 avg=78 std=44 std^2=2021 delta=109
 event_benchmark-2548  [000]  1558.776508: benchmark_event:       str=last=41 first=1964 max=2215 min=40 avg=78 std=44 std^2=2021 delta=41
 event_benchmark-2548  [000]  1558.776508: benchmark_event:       str=last=109 first=1964 max=2215 min=40 avg=78 std=44 std^2=2021 delta=109
 event_benchmark-2548  [000]  1558.776509: benchmark_event:       str=last=117 first=1964 max=2215 min=40 avg=78 std=44 std^2=2021 delta=117
 event_benchmark-2548  [000]  1558.776510: benchmark_event:       str=last=51 first=1964 max=2215 min=40 avg=78 std=44 std^2=2020 delta=51
 event_benchmark-2548  [000]  1558.776510: benchmark_event:       str=last=103 first=1964 max=2215 min=40 avg=78 std=44 std^2=2020 delta=103
 event_benchmark-2548  [000]  1558.776511: benchmark_event:       str=last=109 first=1964 max=2215 min=40 avg=78 std=44 std^2=2020 delta=109
 event_benchmark-2548  [000]  1558.776512: benchmark_event:       str=last=51 first=1964 max=2215 min=40 avg=78 std=44 std^2=2020 delta=51
 event_benchmark-2548  [000]  1558.776512: benchmark_event:       str=last=103 first=1964 max=2215 min=40 avg=78 std=44 std^2=2020 delta=103
 event_benchmark-2548  [000]  1558.776513: benchmark_event:       str=last=95 first=1964 max=2215 min=40 avg=78 std=44 std^2=2020 delta=95
 event_benchmark-2548  [000]  1558.776513: benchmark_event:       str=last=101 first=1964 max=2215 min=40 avg=78 std=44 std^2=2020 delta=101
 event_benchmark-2548  [000]  1558.776514: benchmark_event:       str=last=109 first=1964 max=2215 min=40 avg=78 std=44 std^2=2019 delta=109

It looks like throwing away an event is around 40-50ns, where as now the
copying of the event into a temp buffer before writing it into the ring
buffer increased the time from 84ns to around 100-110ns. Still half the
time it takes for the perf event.

The above trace event benchmark has been part of the Linux kernel since
3.16, so everyone should have it if you want to run your own tests.

-- Steve


