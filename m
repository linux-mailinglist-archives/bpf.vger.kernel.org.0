Return-Path: <bpf+bounces-14536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE13B7E60E7
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEAA1C20AC9
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11C4374DC;
	Wed,  8 Nov 2023 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyHigs05"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C1437155;
	Wed,  8 Nov 2023 23:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF50C433C8;
	Wed,  8 Nov 2023 23:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699485298;
	bh=xVGspZHqa7ebm1mR2Tje10arpm85obbIl39AN2mQJ3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JyHigs05zwlZLjVYeubaXm76pgBss7x0rTEEg8qQq5pvGqxmVPH8K+1b/U5iPjLMF
	 eq80OH7wQ7WcCeUGl9LwR2wNjaK2n+kvxggmWu2utzB12SevBs2Qrjl2CzX7uSgGCX
	 gEVvso4TBccpElYNkwz71aghzlGy6GtS5zKIErjkCNdcH4OUas2lT7WB2DYdOhucqB
	 c4pG7oF1s7g6FW3EsFteIUDJhSQCSDk0qK8/GoXOf+ayLcO5szMUeW+3MERQqYvsT4
	 F/PACmNXnItGac+sb/EhotsiimmtwlysRckjNgFkSx9grT2nodbj0UJ6A0dl9e0BA3
	 PcbkbI58gTazA==
Date: Thu, 9 Nov 2023 08:14:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH v2 01/31] tracing: Add a comment about ftrace_regs
 definition
Message-Id: <20231109081452.fd6e091df9df1bc7c5ced38b@kernel.org>
In-Reply-To: <169945347160.55307.1488323435914144870.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
	<169945347160.55307.1488323435914144870.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Nov 2023 23:24:32 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> To clarify what will be expected on ftrace_regs, add a comment to the
> architecture independent definition of the ftrace_regs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - newly added.
> ---
>  include/linux/ftrace.h |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index e8921871ef9a..b174af91d8be 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -118,6 +118,31 @@ extern int ftrace_enabled;
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
> + * - Registers for hooking the function return including the frame pointer
> + *   (the frame pointer is architecture/config dependent)
> + *   (e.g. rbp and rsp for x86_64)

Oops, I found the program counter/instruction pointer must be saved too.
This is used for live patching. One question is that if the IP is modified
at the return handler, what should we do? Return to the specified address?

Thanks,

> + *
> + * Also, architecture dependent fields can be used for internal process.
> + * (e.g. orig_ax on x86_64)
> + *
> + * On the function entry, those registers will be restored except for
> + * the stack pointer, so that user can change the function parameters.
> + * On the function exit, onlu registers which is used for return values
> + * are restored.
> + *
> + * NOTE: user *must not* access regs directly, only do it via APIs, because
> + * the member can be changed according to the architecture.
> + */
>  struct ftrace_regs {
>  	struct pt_regs		regs;
>  };
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

