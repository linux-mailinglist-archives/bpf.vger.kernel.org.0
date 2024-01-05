Return-Path: <bpf+bounces-19133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF58258E2
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 18:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BF8285193
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A63218C;
	Fri,  5 Jan 2024 17:14:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5FC32182;
	Fri,  5 Jan 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E33EDFEC;
	Fri,  5 Jan 2024 09:14:57 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.85.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF4C93F64C;
	Fri,  5 Jan 2024 09:14:08 -0800 (PST)
Date: Fri, 5 Jan 2024 17:14:06 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 22/34] tracing: Rename ftrace_regs_return_value to
 ftrace_regs_get_return_value
Message-ID: <ZZg43tDXejswYxji@FVFF77S0Q05N>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
 <170290535934.220107.9998902467249003656.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170290535934.220107.9998902467249003656.stgit@devnote2>

On Mon, Dec 18, 2023 at 10:15:59PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Rename ftrace_regs_return_value to ftrace_regs_get_return_value as same as
> other ftrace_regs_get/set_* APIs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Since this is a trivial cleanup, it might make sense to move this to the start
of the series, so that it can be queued even if the later parts need more work.

Mark.

> ---
>  Changes in v3:
>   - Newly added.
> ---
>  arch/loongarch/include/asm/ftrace.h |    2 +-
>  arch/powerpc/include/asm/ftrace.h   |    2 +-
>  arch/s390/include/asm/ftrace.h      |    2 +-
>  arch/x86/include/asm/ftrace.h       |    2 +-
>  include/linux/ftrace.h              |    2 +-
>  kernel/trace/fgraph.c               |    2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> index a11996eb5892..a9c3d0f2f941 100644
> --- a/arch/loongarch/include/asm/ftrace.h
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -70,7 +70,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
>  	regs_get_kernel_argument(&(fregs)->regs, n)
>  #define ftrace_regs_get_stack_pointer(fregs) \
>  	kernel_stack_pointer(&(fregs)->regs)
> -#define ftrace_regs_return_value(fregs) \
> +#define ftrace_regs_get_return_value(fregs) \
>  	regs_return_value(&(fregs)->regs)
>  #define ftrace_regs_set_return_value(fregs, ret) \
>  	regs_set_return_value(&(fregs)->regs, ret)
> diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
> index 9e5a39b6a311..7e138e0e3baf 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -69,7 +69,7 @@ ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
>  	regs_get_kernel_argument(&(fregs)->regs, n)
>  #define ftrace_regs_get_stack_pointer(fregs) \
>  	kernel_stack_pointer(&(fregs)->regs)
> -#define ftrace_regs_return_value(fregs) \
> +#define ftrace_regs_get_return_value(fregs) \
>  	regs_return_value(&(fregs)->regs)
>  #define ftrace_regs_set_return_value(fregs, ret) \
>  	regs_set_return_value(&(fregs)->regs, ret)
> diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
> index 5a82b08f03cd..01e775c98425 100644
> --- a/arch/s390/include/asm/ftrace.h
> +++ b/arch/s390/include/asm/ftrace.h
> @@ -88,7 +88,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
>  	regs_get_kernel_argument(&(fregs)->regs, n)
>  #define ftrace_regs_get_stack_pointer(fregs) \
>  	kernel_stack_pointer(&(fregs)->regs)
> -#define ftrace_regs_return_value(fregs) \
> +#define ftrace_regs_get_return_value(fregs) \
>  	regs_return_value(&(fregs)->regs)
>  #define ftrace_regs_set_return_value(fregs, ret) \
>  	regs_set_return_value(&(fregs)->regs, ret)
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 0b306c82855d..a061f8832b20 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -64,7 +64,7 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
>  	regs_get_kernel_argument(&(fregs)->regs, n)
>  #define ftrace_regs_get_stack_pointer(fregs) \
>  	kernel_stack_pointer(&(fregs)->regs)
> -#define ftrace_regs_return_value(fregs) \
> +#define ftrace_regs_get_return_value(fregs) \
>  	regs_return_value(&(fregs)->regs)
>  #define ftrace_regs_set_return_value(fregs, ret) \
>  	regs_set_return_value(&(fregs)->regs, ret)
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 79875a00c02b..da2a23f5a9ed 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -187,7 +187,7 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
>  	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
>  #define ftrace_regs_get_stack_pointer(fregs) \
>  	kernel_stack_pointer(ftrace_get_regs(fregs))
> -#define ftrace_regs_return_value(fregs) \
> +#define ftrace_regs_get_return_value(fregs) \
>  	regs_return_value(ftrace_get_regs(fregs))
>  #define ftrace_regs_set_return_value(fregs, ret) \
>  	regs_set_return_value(ftrace_get_regs(fregs), ret)
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 088432b695a6..9a60acaacc96 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -783,7 +783,7 @@ static void fgraph_call_retfunc(struct ftrace_regs *fregs,
>  	trace.rettime = trace_clock_local();
>  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>  	if (fregs)
> -		trace.retval = ftrace_regs_return_value(fregs);
> +		trace.retval = ftrace_regs_get_return_value(fregs);
>  	else
>  		trace.retval = fgraph_ret_regs_return_value(ret_regs);
>  #endif
> 

