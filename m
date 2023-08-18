Return-Path: <bpf+bounces-8058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41488780A91
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 12:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0051C215F3
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 10:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C2C182A5;
	Fri, 18 Aug 2023 10:56:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7CA18031
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 10:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBC1C433C8;
	Fri, 18 Aug 2023 10:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692356212;
	bh=9oY74fYSA4+vLUvp/0gaPD0ITuj0lxnMOmvhMy0eQTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pq1x3SchFdbhb6fHMNxkIPyR/qmmjI6fy/vPCEtLdNWFF6y9nWXDfGk8CU5qr8IHt
	 1xjuYuop2pci3ZzZvr3EjHBEr4iMpJTnkdx0mehDqJgjViacLDv8/6oYuQA7WseGsJ
	 ezjRTDFhNFOvv4JMqTnUMmzuCUFQxJw5XngQ5OZMwXaMFlgIbWE0zm6oUuxbUQzmSx
	 wyW19yIoibgZT2jMCuNYkLLfA8zOKNfXHV8wsdovf8UBwZMgmsPf+7jH/XN11XHHBs
	 N0TqxUbafMBonQtt/VYxh/ut0OQj7iQYFY3TD0maCw1QZ2DyFulN8gqvmNCg9gnWZY
	 CyIAjYMgsTdCA==
Date: Fri, 18 Aug 2023 19:56:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Florent Revest <revest@chromium.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/8] fprobe: Use fprobe_regs in fprobe entry handler
Message-Id: <20230818195645.6d5b71f339b71c4f217c9a8c@kernel.org>
In-Reply-To: <CABRcYmLhVxRwMYWjTE855WMg5fV+O1tLz8HJmy_6G6LK5ZEtVA@mail.gmail.com>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
	<169181861911.505132.8322840504168319403.stgit@devnote2>
	<CABRcYmLhVxRwMYWjTE855WMg5fV+O1tLz8HJmy_6G6LK5ZEtVA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 17 Aug 2023 10:57:26 +0200
Florent Revest <revest@chromium.org> wrote:

> On Sat, Aug 12, 2023 at 7:37 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2467,7 +2467,7 @@ static int __init bpf_event_init(void)
> >  fs_initcall(bpf_event_init);
> >  #endif /* CONFIG_MODULES */
> >
> > -#ifdef CONFIG_FPROBE
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> 
> Shouldn't this be #if defined(CONFIG_FPROBE) &&
> defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) ?

Oops, that's right!

> 
> I believe one could build a kernel with FTRACE_WITH_REGS and without
> FPROBE and then this code would have undefined references to fprobe
> functions, wouldn't it ?

Yeah, ftrace with regs doesn't mean fprobe is enabled.

> 
> And then patch 7 should be "Enable kprobe_multi feature even if
> FTRACE_WITH_REGS is disabled"

OK.

Thank you!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

