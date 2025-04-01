Return-Path: <bpf+bounces-55107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B5DA7840A
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 23:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDBB1887C02
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 21:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A62A2144BB;
	Tue,  1 Apr 2025 21:31:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278DB1E5B6F;
	Tue,  1 Apr 2025 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543111; cv=none; b=oua9tMyjb7M0YnwqcMiKTaSh1kfPgBkFnCksqU9XztBQ9AQNL1VY5eisCftLthJhr8iGLZqyhdUb3mwQZxxs0hha8cy1ADpkn5AzNTUxUU/FXasIXpGKjE+QzFdVLPEzQmHxXhQCJZH27QVaMIZcdguG+h/M5O0zjldq9obJ9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543111; c=relaxed/simple;
	bh=gbzqa/BWC/1QUxuoIaKmY1Q1EBe91+FFGbU08j/9iNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXw8sehW+stFdzKyu9wQGs9JJPswrOrzKJ56+o5gItmc+zngIRxwUBLFAbLNXRMX+pCJa1ICGoWc9cQt+aPGiohAQr+DRuqQU14aWwLeBogYh/GCYBXLDj43yZe3nZjRViKLDrxQDyVyMWVDWUS7MMnMh4c17qfCPt0CBiFuggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119F0C4CEE4;
	Tue,  1 Apr 2025 21:31:48 +0000 (UTC)
Date: Tue, 1 Apr 2025 17:32:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
 mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, mhocko@kernel.org, oleg@redhat.com,
 brauner@kernel.org, glider@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before
 current->mm is reset
Message-ID: <20250401173249.42d43a28@gandalf.local.home>
In-Reply-To: <20250401184021.2591443-1-andrii@kernel.org>
References: <20250401184021.2591443-1-andrii@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Apr 2025 11:40:21 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

Hi Andrii,

> It is useful to be able to access current->mm to, say, record a bunch of
> VMA information right before the task exits (e.g., for stack
> symbolization reasons when dealing with short-lived processes that exit
> in the middle of profiling session). We currently do have
> trace_sched_process_exit() in the exit path, but it is called a bit too
> late, after exit_mm() resets current->mm to NULL, which makes it
> unsuitable for inspecting and recording task's mm_struct-related data
> when tracing process lifetimes.

My fear of adding another task exit trace event is that it will get a
bit confusing as that we now have trace_sched_process_exit() and also
trace_task_exit() with slightly different semantics.

How about adding a trace_exit_mm()? Add that to the exit_mm() code?

static void exit_mm(void)
{
	struct mm_struct *mm = current->mm;

	exit_mm_release(current, mm);
	trace_exit_mm(mm);

??

> 
> There is a particularly suitable place, though, right after
> taskstats_exit() is called, but before we do exit_mm(). taskstats
> performs a similar kind of accounting that some applications do with
> BPF, and so co-locating them seems like a good fit.
> 
> Moving trace_sched_process_exit() a bit earlier would solve this problem
> as well, and I'm open to that. But this might potentially change its
> semantics a little, and so instead of risking that, I went for adding
> a new trace_task_exit() tracepoint instead. Tracepoints have zero
> overhead at runtime, unless actively traced, so this seems acceptable.
> 
> Also, existing trace_sched_process_exit() tracepoint is notoriously
> missing `group_dead` flag that is certainly useful in practice and some
> of our production applications have to work around this. So plumb
> `group_dead` through while at it, to have a richer and more complete
> tracepoint.

There should be no problem adding group_dead to the
trace_sched_process_exit() trace event. Adding fields should never cause
any user API breakage.

-- Steve


