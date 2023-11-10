Return-Path: <bpf+bounces-14682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5A17E7750
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E06B2112C
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA631374;
	Fri, 10 Nov 2023 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251210F2;
	Fri, 10 Nov 2023 02:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F436C433C8;
	Fri, 10 Nov 2023 02:18:43 +0000 (UTC)
Date: Thu, 9 Nov 2023 21:18:48 -0500
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
Subject: Re: [RFC PATCH v2 12/31] function_graph: Have the instances use
 their own ftrace_ops for filtering
Message-ID: <20231109211848.10a5e224@gandalf.local.home>
In-Reply-To: <20231110105154.df937bf9f200a0c16806c522@kernel.org>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
	<169945360154.55307.2938894711228282149.stgit@devnote2>
	<20231110105154.df937bf9f200a0c16806c522@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 10:51:54 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> So this patch registers ftrace_ops for each fgraph_ops to ftrace.
> This means that the ftrace_graph_func() will be called twice or more
> on the same function.
> Thus should I call ftrace_startup() once when the first fgraph_ops
> is registered? 
> No, it's not enough. Actually each fgraph_ops can have different filters.
> We need to define a shared filter and combine new filters to one and
> use it. We also need to do it when a fgraph is unregistered.
> 
> Is there any function which makes a new filter from two (or more) filters?

So I'm guessing that we need to have a fgraph_set_filter*() operations?

When one gets added, it needs to update the ftrace_ops to include the added
functions. Or we need to have a way to create a new hash from all the
registered fgraph_ops, and have that for the ftrace_ops. Then when it gets
called, if it has more than one registered function, it needs to iterate
over the list?

-- Steve


> 
> Or, maybe we can make the common callback to find the previous ret entry on
> the ret_stack and reuse it. (In this case we don't need loop on each
> fgraph_array entry)


