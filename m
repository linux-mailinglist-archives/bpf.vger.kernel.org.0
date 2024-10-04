Return-Path: <bpf+bounces-40949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D924F9906DF
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA391C203F7
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C7221BAF9;
	Fri,  4 Oct 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aqZJiDkc"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE32178EE;
	Fri,  4 Oct 2024 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053500; cv=none; b=WnhtqDtxIGYjS6enATDybywzKdkJsGJRua/z2ELImxg11qeTUGH8ivsRqx87YHq9L4YwS1xYV8Xg7P5WRmhk0bhbmlTEONntZ76mubl5MNR63ayeNtumRU9MPAYgla9QKlfSHmdstKjniNe3VF2fNYB/3voyp4oHAiE9T4l4zlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053500; c=relaxed/simple;
	bh=AR81zM7tcgdPrGoH+VnVwMEtO6dO/auPSDmcI/0T2as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+gaD6TLsWwoHBaJmO5w9iSOmV3yx9pvlGDEVp8FGzkZAtLSF35c3LIN7E7HJde6ebjIK6Ww/+U1VWD+ljwEf7LeAegocFMnRO3l9gWxgUXL0IN3wuPcHR1R7zgOLGjOxBNM9pJ3XGBELOi0EDItUt9kl6v4klKil/Z3Bk1aBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=aqZJiDkc; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728053497;
	bh=AR81zM7tcgdPrGoH+VnVwMEtO6dO/auPSDmcI/0T2as=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aqZJiDkcFNbybvOWnSH1YTzAZ3uM5/cerAacIkwqm7Lc3cPTmNVHb2YLKv/c5xS8T
	 mf1JNd4Lb0yZQvRElFWOgE1sRkiHrTIEwXxpXFj/DgKcwGYaY59Qm0ZfTIBo6HMqrq
	 SnqTnoHFHD7zxNEL31vKleGoeHsH4JU3kIbE8BN2q5/dLekoHC/Bw4Hh/pTOBiLAq3
	 jTIvouslB+GU7+x+ruAd6KDu5e174r8AnvwmiSCrDRZlYnQofKF6bMfiqMYZwbBOB5
	 2jP+8Rl5p/OA9LMVlV0mND/nS6t6oofgwuyWUaK+L7ECjLYobPdfO+7xKz43utBB3q
	 dEYJeAKnimt6A==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKs2119qszL30;
	Fri,  4 Oct 2024 10:51:37 -0400 (EDT)
Message-ID: <1aff8385-083e-4d8d-9c81-ce8d54b688ed@efficios.com>
Date: Fri, 4 Oct 2024 10:49:36 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] tracing: Allow system call tracepoints to handle
 page faults
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org
References: <20241004011201.1681962-1-mathieu.desnoyers@efficios.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241004011201.1681962-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 03:11, Mathieu Desnoyers wrote:
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
> 
> This series replaces the "Faultable Tracepoints v6" series found at [1].
> 
> This has been rebased on v6.12-rc1 on top of two patches from Steven:
> 
> tracing: Remove definition of trace_*_rcuidle()
> tracepoint: Remove SRCU protection

I'll send an updated series which includes
"tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL"
(missing here), and which rework that patch to remove the mapping from
trace_sys_enter/exit to trace_syscall_sys_enter/exit which requires
modifying architecture code. A lot of churn for little value add.

Thanks,

Mathieu

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
> Mathieu Desnoyers (7):
>    tracing/ftrace: guard syscall probe with preempt_notrace
>    tracing/perf: guard syscall probe with preempt_notrace
>    tracing/bpf: guard syscall probe with preempt_notrace
>    tracing: Allow system call tracepoints to handle page faults
>    tracing/ftrace: Add might_fault check to syscall probes
>    tracing/perf: Add might_fault check to syscall probes
>    tracing/bpf: Add might_fault check to syscall probes
> 
>   include/linux/tracepoint.h    | 18 ++++++++++-----
>   include/trace/bpf_probe.h     | 12 +++++++++-
>   include/trace/perf.h          | 42 +++++++++++++++++++++++++++++++----
>   include/trace/trace_events.h  | 39 ++++++++++++++++++++++++++------
>   init/Kconfig                  |  1 +
>   kernel/trace/trace_syscalls.c | 28 +++++++++++++++++++++++
>   6 files changed, 123 insertions(+), 17 deletions(-)
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


