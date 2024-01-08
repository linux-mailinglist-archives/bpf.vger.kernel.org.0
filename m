Return-Path: <bpf+bounces-19192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388E3827110
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 15:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86301F2339A
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E45447787;
	Mon,  8 Jan 2024 14:21:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00EF47776;
	Mon,  8 Jan 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 383B3C15;
	Mon,  8 Jan 2024 06:21:57 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1A833F64C;
	Mon,  8 Jan 2024 06:21:08 -0800 (PST)
Date: Mon, 8 Jan 2024 14:21:03 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
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
Subject: Re: [PATCH v5 11/34] function_graph: Have the instances use their
 own ftrace_ops for filtering
Message-ID: <ZZwEz8HsTa2IZE3L@FVFF77S0Q05N>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
 <170290522555.220107.1435543481968270637.stgit@devnote2>
 <ZZg3tlOynx7YVLGQ@FVFF77S0Q05N>
 <20240108101436.07509def635fbecf80a59ae6@kernel.org>
 <ZZvp08OFIFbP3rnk@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZvp08OFIFbP3rnk@FVFF77S0Q05N>

On Mon, Jan 08, 2024 at 12:25:55PM +0000, Mark Rutland wrote:
> We also have HAVE_FUNCTION_GRAPH_RET_ADDR_PTR, but since the return address is
> not on the stack at the point function-entry is intercepted we use the FP as
> the retp value -- in the absence of tail calls this will be different between a
> caller and callee.

Ah; I just spotted that this patch changed that in ftrace_graph_func(), which
is the source of the bug. 

As of this patch, we use the address of fregs->lr as the retp value, but the
unwinder still uses the FP value, and so when unwind_recover_return_address()
calls ftrace_graph_ret_addr(), the retp value won't match the expected entry on
the fgraph ret_stack, resulting in failing to find the expected entry.

Since the ftrace_regs only exist transiently during function entry/exit, it's
possible for a stackframe to reuse that same address on the stack, which would
result in finding a different entry by mistake.

The diff below restores the existing behaviour and fixes the issue for me.
Could you please fold that into this patch?

On a separate note, looking at how this patch changed arm64's
ftrace_graph_func(), do we need similar changes to arm64's
prepare_ftrace_return() for the old-style mcount based ftrace?

Mark.

---->8----
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 205937e04ece..329092ce06ba 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -495,7 +495,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
        if (bit < 0)
                return;
 
-       if (!function_graph_enter_ops(*parent, ip, fregs->fp, parent, gops))
+       if (!function_graph_enter_ops(*parent, ip, fregs->fp, (void *)fregs->fp, gops))
                *parent = (unsigned long)&return_to_handler;
 
        ftrace_test_recursion_unlock(bit);

