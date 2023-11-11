Return-Path: <bpf+bounces-14817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 037397E87DC
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87DEEB20B42
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 01:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067D233C8;
	Sat, 11 Nov 2023 01:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F37F3C0B;
	Sat, 11 Nov 2023 01:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1ADC433C7;
	Sat, 11 Nov 2023 01:44:16 +0000 (UTC)
Date: Fri, 10 Nov 2023 20:44:22 -0500
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
Subject: Re: [RFC PATCH v2 26/31] fprobe: Rewrite fprobe on function-graph
 tracer
Message-ID: <20231110204422.05ac4581@gandalf.local.home>
In-Reply-To: <20231110161739.f0ff9c50f20ebcfb57be6459@kernel.org>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
	<169945376173.55307.5892275268096520409.stgit@devnote2>
	<20231110161739.f0ff9c50f20ebcfb57be6459@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 16:17:39 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +	used = 0;
> > +	hlist_for_each_entry_from_rcu(node, hlist) {
> > +		if (node->addr != func)
> > +			break;
> > +		fp = READ_ONCE(node->fp);
> > +		if (!fp || fprobe_disabled(fp))
> > +			continue;
> > +
> > +		if (fprobe_shared_with_kprobes(fp))
> > +			ret = __fprobe_kprobe_handler(func, ret_ip,
> > +					fp, fregs, fgraph_data + used);
> > +		else
> > +			ret = __fprobe_handler(func, ret_ip, fp,
> > +					fregs, fgraph_data + used);  
> 
> 
> Since the fgraph callback is under rcu-locked but not preempt-disabled,

rcu-locked? The only rcu-locked is task rcu.

> fprobe unittest fails. I need to add preempt_disable_notrace() and
> preempt_enable_notrace() around this. Note that kprobe_busy_begin()/end()
> also access to per-cpu variable, so it requires to disable preemption.


Just around the __fprobe_*handler()? Or the loop?

-- Steve

