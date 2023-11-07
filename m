Return-Path: <bpf+bounces-14346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8517E3379
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 04:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D457B20BA1
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 03:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF7420FB;
	Tue,  7 Nov 2023 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40201138A;
	Tue,  7 Nov 2023 03:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50D8C433C8;
	Tue,  7 Nov 2023 03:06:14 +0000 (UTC)
Date: Mon, 6 Nov 2023 22:06:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-ID: <20231106220617.5eb73f2f@gandalf.local.home>
In-Reply-To: <20231107094258.d41a46c202197e92bc6d9656@kernel.org>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920068069.482486.6540417903833579700.stgit@devnote2>
	<20231105172536.GA7124@noisy.programming.kicks-ass.net>
	<20231105141130.6ef7d8bd@rorschach.local.home>
	<20231105231734.GE3818@noisy.programming.kicks-ass.net>
	<20231105183301.38be5598@rorschach.local.home>
	<20231106100549.33f6ce30d968906979ca3954@kernel.org>
	<20231106113710.3bf69211@gandalf.local.home>
	<20231107094258.d41a46c202197e92bc6d9656@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Nov 2023 09:42:58 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Got it. So does ftrace_regs need a placeholder for direct trampoline?
> (Or, can we use a register to pass it?)
> I think we don't need to clear it for return_to_handler() but if
> `ftrace_regs` spec requires it, it is better to do so.

It's per arch defined. I think I wrote somewhere that it just needs to pass
back something that can tell if the handler is to return to a direct
trampoline or not. It could be a unused register, or something else.

It's only needed if an architecture supports direct trampolines.

-- Steve

