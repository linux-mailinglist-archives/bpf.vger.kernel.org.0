Return-Path: <bpf+bounces-31203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E691D8D859E
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 16:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A065E280E0D
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C0F12FF9C;
	Mon,  3 Jun 2024 14:59:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255EE82D8E;
	Mon,  3 Jun 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426755; cv=none; b=IMSHv0ik0ILYQi8OmthABXVW3gyLzFwEOUFFIF9A3PVzbPo/kU4ClL7szOXsMOmGSVQudw9d2nOUwypPdGnEQ357ffcUrRmt0qbJSkKcWDr56xg+UTgV77OPjlOZAFHQeR5pFPasJKYd9iyxyEbabQHS39GesvM74rq3QEQZRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426755; c=relaxed/simple;
	bh=DBDHC1nWAFD49PJim5SC6PnxIBcdo9JUB9EaWjVgVdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALfkmID1jDe50mKnHzT/1EreJiADrMzocU/MKs7Un7ASXS7HXTcvCquOmSGmThy/GfzZf4Am8Z0dKS+c+US2df3xxebT6p0aD6qtQPMp1CNNacB5UU3WkXww3Bq48gIpqtMEL1ElOsewPtoo57kSNMvEQ+4TxOckZmy1pxVi66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDD1C2BD10;
	Mon,  3 Jun 2024 14:59:09 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:00:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v2 24/27] function_graph: Use static_call and branch to
 optimize entry function
Message-ID: <20240603110018.1cdd6746@gandalf.local.home>
In-Reply-To: <20240603121107.42f98858ebb790805f75c9b1@kernel.org>
References: <20240602033744.563858532@goodmis.org>
	<20240602033834.997761817@goodmis.org>
	<20240603121107.42f98858ebb790805f75c9b1@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 12:11:07 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > In most cases function graph is used by a single user. Instead of calling
> > a loop to call function graph callbacks in this case, call the function
> > entry callback directly.
> > 
> > Add a static_key that will be used to set the function graph logic to
> > either do the loop (when more than one callback is registered) or to call
> > the callback directly if there is only one registered callback.  
> 
> I understand this works, but my concern is that, if we use fprobe
> and function_graph at the same time, does it always loop on both gops?
> 
> I mean if those are the subops of one ftrace_ops, ftrace_trampoline
> will always call the same function_graph_enter() for both gops, and loop
> on the gops list.
> 
> For example, if there are 2 fgraph_ops, one has "vfs_*" filter and
> another has "sched_*" filter, those does not cover each other.
> 
> Are there any way to solve this issue? I think my previous series
> calls function_graph_enter_ops() directly from trampoline (If it works
> correctly...)

Yes, but that gets a bit complex, and requires the changing of all archs.
If it starts to become a problem, I rather add that as a feature. That is,
we can always go back to it. But for now, lets keep the complexity down.

-- Steve

