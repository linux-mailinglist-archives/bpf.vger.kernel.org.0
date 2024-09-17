Return-Path: <bpf+bounces-40039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ABF97AE4E
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AABC1F237BB
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08115C14F;
	Tue, 17 Sep 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="j4QveIfx"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95537B;
	Tue, 17 Sep 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566904; cv=none; b=GB9/QszH3Z8z3LEfZK5RaqvQeqjy74lqJyB9VpJB93+ZMPzXiiCLIA90w8jpHmDtj03d1JUsLC79CY3nofo5EA+VE0JM0b9+E2XZtT/B7WJYx9crpFInbZMAtridGvefbHlgXPXYgyT2gj7vL8cQgvbiLEpCQ6Y3JOACqdkVlLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566904; c=relaxed/simple;
	bh=C77244BaFWtlO4nvGxXTmzlBGsuRhHCxPtNfcZGy8zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAEYhbnWDOz0twNbBGGhEyUxVIqGNNwta9BQwZn4EhBso4Jzu5Z0N57GusL4B4XSjPisiAcLE0gNY9DJU1+i6H1mbI+9q6nwogOSPCt3Vsrj2RkCmDNahzYT2dgavIviY4k2PYm+oBDXkmyiS4/KnU+1a2lEG6hpguQ3EMXpGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=j4QveIfx; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1726566900;
	bh=C77244BaFWtlO4nvGxXTmzlBGsuRhHCxPtNfcZGy8zE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j4QveIfx0t86au5RR8lb64DwiRUtb2Dt/v4CaBAW63QlOlszYeDmd/mKtSrJen6En
	 ep7MYUqBuyBORrrlCJokcf5coSSiO79zUc42P3Q6+4z83wUgHOlBsb74+1jNDtvcbS
	 yxNNqq/WtGrY4Wi3zVZDy++E8fBmZ/jQQqXcdFuCCoIsGjO127FmfML8Nx0cs0QyGF
	 2Q5smsFVxZu2WqbrtlVOfMz1OB82Qur8fQEYNS9OAEaUV96yioROG95bEulG893FFr
	 iFTISXq93iNzO+tB/12Dlcl/yeUlxPe74eBcO4p9QqvF2t8tfQre+uEFQHvvKAsO29
	 2jKB86TsOU5SA==
Received: from [IPV6:2001:4bc9:a46:d7de:edc9:fc73:b785:1ddd] (unknown [IPv6:2001:4bc9:a46:d7de:edc9:fc73:b785:1ddd])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X7HFX3v0qz1LcP;
	Tue, 17 Sep 2024 05:54:55 -0400 (EDT)
Message-ID: <c2a2db4b-4409-4f3c-9959-53622fd8dfa7@efficios.com>
Date: Tue, 17 Sep 2024 11:54:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] tracing: Allow system call tracepoints to handle page
 faults
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
 <20240917044916.c615d25eb4fecc9818d3d376@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240917044916.c615d25eb4fecc9818d3d376@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-16 21:49, Masami Hiramatsu (Google) wrote:
> On Mon,  9 Sep 2024 16:16:44 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Wire up the system call tracepoints with Tasks Trace RCU to allow
>> the ftrace, perf, and eBPF tracers to handle page faults.
>>
>> This series does the initial wire-up allowing tracers to handle page
>> faults, but leaves out the actual handling of said page faults as future
>> work.
>>
>> This series was compile and runtime tested with ftrace and perf syscall
>> tracing and raw syscall tracing, adding a WARN_ON_ONCE() in the
>> generated code to validate that the intended probes are used for raw
>> syscall tracing. The might_fault() added within those probes validate
>> that they are called from a context where handling a page fault is OK.
> 
> I think this series itself is valuable.
> However, I'm still not sure that why ftrace needs to handle page faults.
> This allows syscall trace-event itself to handle page faults, but the
> raw-syscall/syscall events only accesses registers, right?

You are correct that ftrace currently only accesses registers as of
today. And maybe it will stay the focus for ftrace, as the ftrace
focus appears to be more about what happens inside the kernel than
the causality from user-space. But different tracers have different
focus and use-cases.

It's a different story for eBPF and LTTng though: LTTng grabs filename strings from user-space for the openat system call for instance, so
we can reconstruct which system calls were done on which files at
post-processing. This is convenient if the end user wishes to focus
on the activity for given file/set of files.

eBPF also allows grabbing userspace data AFAIR, but none of those
tracers can handle page faults because tracepoints disables preemption,
which leads to missing data in specific cases, e.g. immediately after an
execve syscall when pages are not faulted in yet.

Also having syscall entry called from a context that can handle
preemption would allow LTTng (or eBPF) to do an immediate stackwalk
(see the sframe work from Josh) directly at system call entry. This
can be useful for filtering based on the user callstack before writing
to a ring buffer.

> 
> I think that the page faults happen only when dereference those registers
> as a pointer to the data structure, and currently that is done by probes
> like eprobe and fprobe. In order to handle faults in those probes, we
> need to change how those writes data in per-cpu ring buffer.
> 
> Currently, those probes reserves an entry on ring buffer and writes the
> dereferenced data on the entry, and commits it. So during this reserve-
> write-commit operation, this still disables preemption. So we need a
> another buffer for dereference on the stack and copy it.

There are quite a few approaches we can take there, with different
tradeoffs.

A) Issue dummy loads of user-space data just to trigger page faults
before disabling preemption. Unless the system has extreme memory
pressure, it should be enough to page in the data and it should stay
available for copy into the ring buffer immediately after with preemption
disabled. This should be fine for practical purposes. This is simple to
implement and is the route I intend to take initially for LTTng.

B) Do a copy in a local buffer and take page faults at that point. This
bring the question of where to allocate the buffer. This also requires an
extra copy from userspace, to the local buffer, then to the per-cpu ring
buffer, so it may come with a certain overhead. One advantage of that
approach is that it opens the door to fix TOCTOU races that syscall audit
systems (e.g. seccomp) have if we change the system call implementation
to use data from this argument copy rather than re-read them from
userspace within the system call. But this is a much larger endeavor that
should be done in collaboration between the tracing & seccomp developers.

C) Modify the ring buffer to make it usable without disabling preemption.
It's straightforward in LTTng because its ring buffer has been designed
to be usable in preemptible userspace context as well (LTTng-UST).
This may not be as easy for ftrace since disabling preemption is
rooted deep in its ring buffer design.

Besides those basic tradeoffs, we should of course consider the overhead
associated with each approach.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


