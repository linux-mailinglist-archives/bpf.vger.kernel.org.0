Return-Path: <bpf+bounces-30446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45E18CDD2A
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C2D28569D
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD10128804;
	Thu, 23 May 2024 23:09:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4E126F27;
	Thu, 23 May 2024 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505788; cv=none; b=T8t9JR+uCzcKDooinb26oOYuRXz70jmKQRb88vMousMPp38+N4sRPNziUkOaxbJ2Q355SuQhO1HEgnojJFEmzdd+uSn7TUCvNPItXmh+olffYzWK6aUPOBk1Aa3bbnBlS4Xbq+p8Fd0zBhi+YZ/1pWyGEdr+QNJvf7V5ZKcvpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505788; c=relaxed/simple;
	bh=1ZerqhZiEm0bGWbV+jNKn+Dq0L+J1awgxyJkbjTBq+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRgePn3SU12vAWHevKZ3rBZ0w6wdx4WWSYcfGU//IBiFWfOf0F5QUGxQW/eCJ5wRZwidAACEZHjTy88yEZkgpImL2ymP8fjqvwyHSyYpYfvKfzD8ieBMnPU0a5Ih7czDZvXqEnA7SAD/GsDhdzvuwUOrj94sUexlXiSfqmc3aEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0A8C2BD10;
	Thu, 23 May 2024 23:09:45 +0000 (UTC)
Date: Thu, 23 May 2024 19:10:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v10 01/36] tracing: Add a comment about ftrace_regs
 definition
Message-ID: <20240523191031.7574d944@gandalf.local.home>
In-Reply-To: <171509089214.162236.6201493898649663823.stgit@devnote2>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
	<171509089214.162236.6201493898649663823.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 May 2024 23:08:12 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> To clarify what will be expected on ftrace_regs, add a comment to the
> architecture independent definition of the ftrace_regs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  Changes in v8:
>   - Update that the saved registers depends on the context.
>  Changes in v3:
>   - Add instruction pointer
>  Changes in v2:
>   - newly added.
> ---
>  include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 54d53f345d14..b81f1afa82a1 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -118,6 +118,32 @@ extern int ftrace_enabled;
>  
>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  
> +/**
> + * ftrace_regs - ftrace partial/optimal register set
> + *
> + * ftrace_regs represents a group of registers which is used at the
> + * function entry and exit. There are three types of registers.
> + *
> + * - Registers for passing the parameters to callee, including the stack
> + *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
> + * - Registers for passing the return values to caller.
> + *   (e.g. rax and rdx on x86_64)
> + * - Registers for hooking the function call and return including the
> + *   frame pointer (the frame pointer is architecture/config dependent)
> + *   (e.g. rip, rbp and rsp for x86_64)
> + *
> + * Also, architecture dependent fields can be used for internal process.
> + * (e.g. orig_ax on x86_64)
> + *
> + * On the function entry, those registers will be restored except for
> + * the stack pointer, so that user can change the function parameters
> + * and instruction pointer (e.g. live patching.)
> + * On the function exit, only registers which is used for return values
> + * are restored.

I wonder if we should also add a note about some architectures in some
circumstances may store all pt_regs in ftrace_regs. For example, if an
architecture supports FTRACE_WITH_REGS, it may pass the pt_regs within the
ftrace_regs. If that is the case, then ftrace_get_regs() called on it will
return a pointer to a valid pt_regs, or NULL if it is not supported or the
ftrace_regs does not have a all the registers.

-- Steve


> + *
> + * NOTE: user *must not* access regs directly, only do it via APIs, because
> + * the member can be changed according to the architecture.
> + */
>  struct ftrace_regs {
>  	struct pt_regs		regs;
>  };


