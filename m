Return-Path: <bpf+bounces-58629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C50BABE857
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 01:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E758A0C10
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 23:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D848D25EFB5;
	Tue, 20 May 2025 23:55:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498E1AE875;
	Tue, 20 May 2025 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747785312; cv=none; b=S7Le7vBSidyeT0pk4tRWHOq6NFtzB7OyVV80qZjf6T2yDyFz8tpfty9iKJgsZVytmIY6ot6wfBamDECAmIZ0IQIsu2LbxzjKtfGe5RLhANvjtfmDij2Eip+ln2jh9cBZVPU5XINnaktBBmQp6cfePM2I5qhz9kzTzuZKgSty3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747785312; c=relaxed/simple;
	bh=y5/z+HONYclEsJiD6cddpUiOqN6TfL+T6JtwdkdeYIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpEmtbNqahECWwS7k0gH/OaL7t/IDfnBgt0Ws7uH1+abudyubjoBm8LmvVi9xXFtXqfycGGm1N/KABM9fvwx5b90rVI7fqTj1EU3Y2xNIfiPMH8AVWE1BDXBBdRdWdHt9NFcG8fYMclbBjZUgEgi3XIIqEtDJk0UvrF91HdbxB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240F0C4CEE9;
	Tue, 20 May 2025 23:55:10 +0000 (UTC)
Date: Tue, 20 May 2025 19:55:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrii
 Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v9 00/13] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <20250520195549.17f6c2c7@gandalf.local.home>
In-Reply-To: <20250521082605.b4bd632ef1312778ea51dd71@kernel.org>
References: <20250513223435.636200356@goodmis.org>
	<20250514132720.6b16880c@gandalf.local.home>
	<aCfMzJ-zN0JKKTjO@google.com>
	<20250521082605.b4bd632ef1312778ea51dd71@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 08:26:05 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Maybe I asked this before but I don't remember if I got the answer. :)
> > How does it handle task exits as it won't go to userspace?  I guess it'll
> > lose user callstacks for exit syscalls and other termination paths.

I just checked, and the good news is that task_work does indeed get called
when a task exits. The bad news is that it happens after do_exit() cleans
up the task's "mm" structure via exit_mm(). Which means that current->mm is
NULL :-p

There's a proposal to move trace_sched_process_exit() to before exit_mm().
If that happens, we could make that tracepoint a "faultable" tracepoint and
then the unwind infrastructure could attach to it and do the unwinding from
that tracepoint.

> > 
> > Similarly, it will miss user callstacks in the samples at the end of
> > profiling if the target tasks remain in the kernel (or they sleep).
> > It looks like a fundamental limitation of the deferred callchains.  

Yes that is a limitation.

> 
> Can we use a hybrid approach for this case?
> It might be more balanced (from the performance point of view) to save
> the full stack in a classic way only in this case, rather than faulting
> on process exit or doing file access just to load the sframe.

Another approach is that the tool (like perf) could request to take the
user space stack trace every time a task enters the kernel via a system
call.

-- Steve

