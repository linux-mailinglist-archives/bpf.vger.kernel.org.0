Return-Path: <bpf+bounces-40943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 564269905DB
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862001C21D59
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514262178F3;
	Fri,  4 Oct 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AcM0vt7T"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB61216A3F;
	Fri,  4 Oct 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051669; cv=none; b=KuFe0c7giAvPb3NMsbd2iLygfm0l31pwShntjgHGWBpMaDc2dFMfWCXykABQ+IAU4LzSNvZcm5C60UHUAb7XzJbkTRgxoUBXpcL7XL71dU0C9LLrRgio66Mp9T4DOw9ku/j5FzjoR1JYPJlYPfYai8OQ3Lrx8722MwIIIGujUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051669; c=relaxed/simple;
	bh=xGZVsNftekr8WT4WvGI2SOfuewhewH/sye43N5K4ri8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfKgpBDvriFCRyw/vuwVwtXImToj9KnGtsr/QGCBcMO/QpQh0eg8OehlJxfHu7hk6sI8ptgo1QtPS/XVuN9v8ycgCm695P5uZctrjIqX6z52XnDuJ5f8XMlX/sLxiqEANUr5vrGfxeMwvtcJF35bIQj5a034qLfTjKr8cwPdbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AcM0vt7T; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728051660;
	bh=xGZVsNftekr8WT4WvGI2SOfuewhewH/sye43N5K4ri8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AcM0vt7TQlGl3UU5KbIG3MnQA3xFuF+AgWZipNjvjNi6ZNzclsgohCdzD9K+wNpgx
	 Y0Qa7Q2K3FEpu79MZ2GSxyiLp6oiDWshkW1aqj8iXagrfJHBnv0Vp0p1Vm3F5XaaAG
	 L+bHEBxEKaTiByL4vabMl6sobp4+Tpm6YZuWYhqYfRdLHPQ8ArHLmBGWiGl/rOrkzs
	 OwnzsmAPkCkO4hCtimLdvFPKjyTRXlLFPO0g4vwCCEl5h5pIxSrAl4IJalGNdjjeu5
	 V3LnfsTid1/O3sJxnoWEHdll5HdiwdDYyPHOqj3pDmnFVe8AS13acA7ctXsRvMELdy
	 vHsJcipyVUL7A==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKrLh0NN2zLDZ;
	Fri,  4 Oct 2024 10:21:00 -0400 (EDT)
Message-ID: <db35f840-1c90-406a-906f-c26aca29be84@efficios.com>
Date: Fri, 4 Oct 2024 10:18:59 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] tracing/ftrace: guard syscall probe with
 preempt_notrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
 <20241003151638.1608537-3-mathieu.desnoyers@efficios.com>
 <20241003182304.2b04b74a@gandalf.local.home>
 <6dc21f67-52e1-4ed5-af7f-f047c3c22c11@efficios.com>
 <20241003210403.71d4aa67@gandalf.local.home>
 <90ca2fee-cdfb-4d48-ab9e-57d8d2b8b8d8@efficios.com>
 <20241004092619.0be53f90@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241004092619.0be53f90@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 15:26, Steven Rostedt wrote:
> On Thu, 3 Oct 2024 21:33:16 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2024-10-04 03:04, Steven Rostedt wrote:
>>> On Thu, 3 Oct 2024 20:26:29 -0400
>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>
>>>    
>>>> static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>>>> {
>>>>            struct trace_array *tr = data;
>>>>            struct trace_event_file *trace_file;
>>>>            struct syscall_trace_enter *entry;
>>>>            struct syscall_metadata *sys_data;
>>>>            struct trace_event_buffer fbuffer;
>>>>            unsigned long args[6];
>>>>            int syscall_nr;
>>>>            int size;
>>>>
>>>>            syscall_nr = trace_get_syscall_nr(current, regs);
>>>>            if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
>>>>                    return;
>>>>
>>>>            /* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
>>>>            trace_file = rcu_dereference_sched(tr->enter_syscall_files[syscall_nr]);
>>>>
>>>> ^^^^ this function explicitly states that preempt needs to be disabled by
>>>> tracepoints.
>>>
>>> Ah, I should have known it was the syscall portion. I don't care for this
>>> hidden dependency. I rather add a preempt disable here and not expect it to
>>> be disabled when called.
>>
>> Which is exactly what this patch is doing.
> 
> I was thinking of putting the protection in the function and not the macro.

I'm confused by your comment. The protection is added to the function here:

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 67ac5366f724..ab4db8c23f36 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -299,6 +299,12 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
         int syscall_nr;
         int size;
  
+       /*
+        * Syscall probe called with preemption enabled, but the ring
+        * buffer and per-cpu data require preemption to be disabled.
+        */
+       guard(preempt_notrace)();
+
         syscall_nr = trace_get_syscall_nr(current, regs);
         if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
                 return;
@@ -338,6 +344,12 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
         struct trace_event_buffer fbuffer;
         int syscall_nr;
  
+       /*
+        * Syscall probe called with preemption enabled, but the ring
+        * buffer and per-cpu data require preemption to be disabled.
+        */
+       guard(preempt_notrace)();
+
         syscall_nr = trace_get_syscall_nr(current, regs);
         if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
                 return;

(I'll answer to the rest of your message in a separate email)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


