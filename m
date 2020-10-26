Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB678298CD7
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 13:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775078AbgJZMZZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 08:25:25 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:4720 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1775077AbgJZMZY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Oct 2020 08:25:24 -0400
X-Greylist: delayed 1202 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 08:25:23 EDT
Subject: Re: [RFC PATCH 0/6] Sleepable tracepoints
To:     Michael Jeanson <mjeanson@efficios.com>,
        <linux-kernel@vger.kernel.org>
CC:     <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, <bpf@vger.kernel.org>
References: <20201023195352.26269-1-mjeanson@efficios.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <083f3ffa-3395-d66b-bb8b-d6a3fd7f6177@sony.com>
Date:   Mon, 26 Oct 2020 13:05:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023195352.26269-1-mjeanson@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=EbK2v8uC c=1 sm=1 tr=0 a=CGteIMthFL3x4Fb36c5kWA==:117 a=IkcTkHD0fZMA:10 a=afefHYAZSVUA:10 a=meVymXHHAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8 a=qqdB56dbAAAA:8 a=3C5PsIaMDjZkp0q5FAMA:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ccaIO3UgQCpleZvgly2v:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/23/20 9:53 PM, Michael Jeanson wrote:
> When invoked from system call enter/exit instrumentation, accessing
> user-space data is a common use-case for tracers. However, tracepoints
> currently disable preemption around iteration on the registered
> tracepoint probes and invocation of the probe callbacks, which prevents
> tracers from handling page faults.
>
> Extend the tracepoint and trace event APIs to allow specific tracer
> probes to take page faults. Adapt ftrace, perf, and ebpf to allow being
> called from sleepable context, and convert the system call enter/exit
> instrumentation to sleepable tracepoints.

Will this not be a problem for analyse of the trace? It get two
relevant times, one it when it is called and one when it returns.

It makes things harder to correlate in what order things happen.

And handling of tracing of contexts that already are not preamptable?

Eg the same tracepoint are used in different places and contexts.


> This series only implements the tracepoint infrastructure required to
> allow tracers to handle page faults. Modifying each tracer to handle
> those page faults would be a next step after we all agree on this piece
> of instrumentation infrastructure.
>
> This patchset is base on v5.9.1.
>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: bpf@vger.kernel.org
>
> Mathieu Desnoyers (1):
>   tracing: use sched-RCU instead of SRCU for rcuidle tracepoints
>
> Michael Jeanson (5):
>   tracing: introduce sleepable tracepoints
>   tracing: ftrace: add support for sleepable tracepoints
>   tracing: bpf-trace: add support for sleepable tracepoints
>   tracing: perf: add support for sleepable tracepoints
>   tracing: convert sys_enter/exit to sleepable tracepoints
>
>  include/linux/tracepoint-defs.h |  11 ++++
>  include/linux/tracepoint.h      | 104 +++++++++++++++++++++-----------
>  include/trace/bpf_probe.h       |  23 ++++++-
>  include/trace/define_trace.h    |   7 +++
>  include/trace/events/syscalls.h |   4 +-
>  include/trace/perf.h            |  26 ++++++--
>  include/trace/trace_events.h    |  79 ++++++++++++++++++++++--
>  init/Kconfig                    |   1 +
>  kernel/trace/bpf_trace.c        |   5 +-
>  kernel/trace/trace_events.c     |  15 ++++-
>  kernel/trace/trace_syscalls.c   |  68 +++++++++++++--------
>  kernel/tracepoint.c             | 104 +++++++++++++++++++++++++-------
>  12 files changed, 351 insertions(+), 96 deletions(-)
>

