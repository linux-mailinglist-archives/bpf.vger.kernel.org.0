Return-Path: <bpf+bounces-40004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9833D97A7F0
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 21:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 342C5B2A9DA
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA115C13C;
	Mon, 16 Sep 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKyZzvZZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061611DFE4;
	Mon, 16 Sep 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516165; cv=none; b=kx6CVoXpCzCsjBk3nhsWNiYRGgx4/yMcqILPTupaKodChUK1ZE2YVMQc+O6ufHlLhBXD3QAoVqvrVStWhd9EBrOEnehab6HySM+MEzJ+AvwBd4Wwk7D/gpK8YugLchviq6C9C5jrRWHk9xZ8d76DnMBhsZ2bl56HL65rLEXveCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516165; c=relaxed/simple;
	bh=McvvxzRP1A7708isAh7bwsxm3tBEaTW9AN2krh/AmvA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AZ2K5IESiuCfxdkfMszAei4eG7fbt0Qw3qXHbGIvicyLj1L346sn1AML9OluHDVGbCrDVYm9IoliKU3qTmsAa/KETSLicuKpALgdxnuODFixGKLR8Y/59uUbu/K9bfdKjCuWZis382WNdLKjNJXLFpdVO+vWB1fv0/gsEbvGDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKyZzvZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB40C4CEC4;
	Mon, 16 Sep 2024 19:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726516164;
	bh=McvvxzRP1A7708isAh7bwsxm3tBEaTW9AN2krh/AmvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uKyZzvZZ1Jd4KscVOwGwGJiJPydODCJg5MhxYf+DNQKbGYXXz6Up4b4VBbX7B89XW
	 7IQbPHvszOFAuebbQM1iZugwsGLh2DbKPd8nnoxiRidb/8ayT4PuDKF7CApgI3kxGU
	 1xI9NKkar7tProD5gHbWKCz5P7NoM7Ip96FkNXacWzCMbDo8Z02gx85N/yUNT2VOSG
	 rsWfMBrQZfaW+RFSfaKTCd70Bpq44yZ6eWAIT9iltZtPQ/4GmSegRRD6F0tGJWs/9w
	 jIqtrxqd1TtOHBkSq67HLChfJE/UZthB2WO2oQY0yMIWf+wSIdlYSt6KHa2imeMcUp
	 P8BFHdZY4sOYA==
Date: Tue, 17 Sep 2024 04:49:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tracing: Allow system call tracepoints to handle
 page faults
Message-Id: <20240917044916.c615d25eb4fecc9818d3d376@kernel.org>
In-Reply-To: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 16:16:44 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Wire up the system call tracepoints with Tasks Trace RCU to allow
> the ftrace, perf, and eBPF tracers to handle page faults.
> 
> This series does the initial wire-up allowing tracers to handle page
> faults, but leaves out the actual handling of said page faults as future
> work.
> 
> This series was compile and runtime tested with ftrace and perf syscall
> tracing and raw syscall tracing, adding a WARN_ON_ONCE() in the
> generated code to validate that the intended probes are used for raw
> syscall tracing. The might_fault() added within those probes validate
> that they are called from a context where handling a page fault is OK.

I think this series itself is valuable.
However, I'm still not sure that why ftrace needs to handle page faults.
This allows syscall trace-event itself to handle page faults, but the
raw-syscall/syscall events only accesses registers, right?

I think that the page faults happen only when dereference those registers
as a pointer to the data structure, and currently that is done by probes
like eprobe and fprobe. In order to handle faults in those probes, we
need to change how those writes data in per-cpu ring buffer.

Currently, those probes reserves an entry on ring buffer and writes the
dereferenced data on the entry, and commits it. So during this reserve-
write-commit operation, this still disables preemption. So we need a
another buffer for dereference on the stack and copy it.

Thank you,


> 
> For ebpf, this series is compile-tested only.
> 
> This series replaces the "Faultable Tracepoints v6" series found at [1].
> 
> Thanks,
> 
> Mathieu
> 
> Link: https://lore.kernel.org/lkml/20240828144153.829582-1-mathieu.desnoyers@efficios.com/ # [1]
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: linux-trace-kernel@vger.kernel.org
> 
> Mathieu Desnoyers (8):
>   tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL
>   tracing/ftrace: guard syscall probe with preempt_notrace
>   tracing/perf: guard syscall probe with preempt_notrace
>   tracing/bpf: guard syscall probe with preempt_notrace
>   tracing: Allow system call tracepoints to handle page faults
>   tracing/ftrace: Add might_fault check to syscall probes
>   tracing/perf: Add might_fault check to syscall probes
>   tracing/bpf: Add might_fault check to syscall probes
> 
>  include/linux/tracepoint.h      | 87 +++++++++++++++++++++++++--------
>  include/trace/bpf_probe.h       | 13 +++++
>  include/trace/define_trace.h    |  5 ++
>  include/trace/events/syscalls.h |  4 +-
>  include/trace/perf.h            | 43 ++++++++++++++--
>  include/trace/trace_events.h    | 61 +++++++++++++++++++++--
>  init/Kconfig                    |  1 +
>  kernel/entry/common.c           |  4 +-
>  kernel/trace/trace_syscalls.c   | 36 ++++++++++++--
>  9 files changed, 218 insertions(+), 36 deletions(-)
> 
> -- 
> 2.39.2


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

