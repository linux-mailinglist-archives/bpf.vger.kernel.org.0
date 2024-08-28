Return-Path: <bpf+bounces-38274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F23D96294B
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421B21C23166
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB86F18756D;
	Wed, 28 Aug 2024 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aCaCq6OP"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AE16CD06;
	Wed, 28 Aug 2024 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853205; cv=none; b=F0xtjxysP0lJ1xTWQqWrWQ07/cFbNGiuIkaUS5RVsZHsQw15DzzNAzfOsVJ4LEmI6WfBfkQcaicDoGpNAlnGBRptyPq72YJsa58vfCqPCCeti+0mAU6s+jk+1Bc+D03iVJp+YyQqVIAy0GPQ3OQ6Sdlf37JxDIXOXicEjU6jcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853205; c=relaxed/simple;
	bh=hqxyw8l9U76d0ugy8OuKsZ3mvhcpdqvX8AWYEPYW1fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQwIi6myCTe9XNN9jNYK6UwB4kD6w+T+w3lfhXfUZUE5aUMlpEYHZYuRV6mM0gbwa9lyBuSCpSP39eJ2BDbrQeDgS1jkQOxxymZd9TvYJOx/ArXdRUtHraDQQ8OUBzu8HXMLOLg/9YVemKbxgd8bI/CrtN13krzbobIM/KWIO/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=aCaCq6OP; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724853195;
	bh=hqxyw8l9U76d0ugy8OuKsZ3mvhcpdqvX8AWYEPYW1fM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aCaCq6OPdUQb+cCM6A7UyjdXA4Cu/nAgwMPe/lNm8t+PkWZM7d0on20GTW+3ClW44
	 w/VrjN8ibNg/dANdJVJKkWWRnb24f7mxHdp9+3u27qFl4aGnruxHdRB4WnuTbL3LQ9
	 JigZyOhICriFFbkW/0BPsX7ayEfWkP61iFrvxT5me31q107fNoHrln58+sOfawKlNz
	 dsdUiIEioXdy6SXBntWXOCXhrockeZ46IKcWuPLnXogvy3kGNKHVsay1S7ZjvX/6mD
	 LebtwphowF5fC+2yKigT+Z6xQ9qzrfrGnHZwRTb29hEjsvfZENzx5l6Ro8+ggTJoDE
	 LF6rL8daL8Zsg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wv5Tk5Fyvz1JGb;
	Wed, 28 Aug 2024 09:53:14 -0400 (EDT)
Message-ID: <16d0d924-f39b-4e0a-a488-74513f1214a6@efficios.com>
Date: Wed, 28 Aug 2024 09:52:49 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Faultable Tracepoints
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
References: <20240626185941.68420-1-mathieu.desnoyers@efficios.com>
 <20240626212543.7565162d@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240626212543.7565162d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-27 03:25, Steven Rostedt wrote:
> On Wed, 26 Jun 2024 14:59:33 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Wire up the system call tracepoints with Tasks Trace RCU to allow
>> the ftrace, perf, and eBPF tracers to handle page faults.
>>
>> This series does the initial wire-up allowing tracers to handle page
>> faults, but leaves out the actual handling of said page faults as future
>> work.
>>
>> I have tested this against a feature branch of lttng-modules which
>> implements handling of page faults for the filename argument of the
>> openat(2) system call.
>>
>> This v5 addresses comments from the previous round of review [1].
> 
> Hi Mathieu,
> 
> Can you resend this and Cc linux-trace-kernel@vger.kernel.org?

Sure, will do for v6. Thanks!

Mathieu

> 
> That would put it into our patchwork and makes it work with our workflow.
> 
>   https://patchwork.kernel.org/project/linux-trace-kernel/list/
> 
> Thanks,
> 
> -- Steve
> 
> 
>>
>> Steven Rostedt suggested separating tracepoints into two separate
>> sections. It is unclear how that approach would prove to be an
>> improvement over the currently proposed approach, so those changes were
>> not incorporated. See [2] for my detailed reply.
>>
>> In the previous round, Peter Zijlstra suggested use of SRCU rather than
>> Tasks Trace RCU. See my reply about the distinction between SRCU and
>> Tasks Trace RCU [3] and this explanation from Paul E. McKenney about the
>> purpose of Tasks Trace RCU [4].
>>
>> The macros DEFINE_INACTIVE_GUARD and activate_guard are added to
>> cleanup.h for use in the __DO_TRACE() macro. Those appear to be more
>> flexible than the guard_if() proposed by Peter Zijlstra in the previous
>> round of review [5].
>>
>> This series is based on kernel v6.9.6.

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


