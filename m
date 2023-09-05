Return-Path: <bpf+bounces-9265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968737926A9
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 18:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E99281392
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37AD524;
	Tue,  5 Sep 2023 16:30:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE7378
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 16:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A140C433C8;
	Tue,  5 Sep 2023 16:30:40 +0000 (UTC)
Date: Tue, 5 Sep 2023 12:30:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 4/9] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
Message-ID: <20230905123058.706b12de@gandalf.local.home>
In-Reply-To: <20230905223633.23cd4e6e8407c45b934be477@kernel.org>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
	<169280377434.282662.7610009313268953247.stgit@devnote2>
	<20230904224038.4420a76ea15931aa40179697@kernel.org>
	<yt9d5y4pozrl.fsf@linux.ibm.com>
	<20230905223633.23cd4e6e8407c45b934be477@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Sep 2023 22:36:33 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Yes, arch_rethook_trampoline() is good. It needs to save all registers.
> 
> In this series, I'm trying to change the pt_regs with ftrace_regs which will
> reduce trampoline overhead if DYNAMIC_FTRACE_WITH_ARGS=y.
> 
> kprobe -> (pt_regs) -> rethook_try_hook()
> fprobe -> (ftrace_regs) -> rethook_try_hook_ftrace() # new function
> 
> Thus, we need to ensure that the ftrace_regs which is saved in the ftrace
> *without* FTRACE_WITH_REGS flags, can be used for hooking the function
> return. I saw;
> 
> void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
> {
>         rh->ret_addr = regs->gprs[14];
>         rh->frame = regs->gprs[15];
> 
>         /* Replace the return addr with trampoline addr */
>         regs->gprs[14] = (unsigned long)&arch_rethook_trampoline;
> }
> 
> gprs[15] is a stack pointer, so it is saved in ftrace_regs too, but what about
> gprs[14]? (I guess it is a link register)
> We need to read the gprs[14] and ensure that is restored to gpr14 when the
> ftrace is exit even without FTRACE_WITH_REGS flag.
> 
> IOW, it is ftrace save regs/restore regs code issue. I need to check how the
> function_graph implements it.

I would argue that the link register should also be saved in ftrace_regs.

The thing that ftrace_regs is not suppose to save is the general purpose
registers.

-- Steve

