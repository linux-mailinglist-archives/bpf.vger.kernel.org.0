Return-Path: <bpf+bounces-14692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A837E77DF
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 04:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F49B20EAE
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CFE15B3;
	Fri, 10 Nov 2023 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgyhaT0q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6F1374;
	Fri, 10 Nov 2023 03:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E6FC433C7;
	Fri, 10 Nov 2023 03:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699585791;
	bh=T5JFCl6pmHxnPp19gCV70nzGUuLkfaMSJI9G9sJJ8RE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kgyhaT0qs0lzlsqe+KNr9Xx965v8ny0bpvbcDRvKzPFEjJUVERxIVB61e4tlKnM3p
	 on+ySaG2yFlyBK5VLpRc0fBzFjL7Zpe7+STCn5W9fJyK/7R6TKmr2n2YqysqxjpERE
	 tHsDk9EyelY6zp7gWmRHO2iNczkUGAuxHAXTrxguie3RJP6U1EaemZRyjcsu/y0oTP
	 AQnM5qWOyfmxmOB/jVFvd0MBO63uLHoOtqlYJ4BQ3t2kMEsJJHVTSaAVpTYEz7XFzw
	 Am96XC45QSCv0Ors/JcPlr8Eo7MuYBX/a13MmP98xiZDpvvB7IX54ubTr9gqrjcWwo
	 xIEi07Gh3nabw==
Date: Fri, 10 Nov 2023 12:09:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20231110120945.749393c36bdee5fe9bd2d257@kernel.org>
In-Reply-To: <20231109211848.10a5e224@gandalf.local.home>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
	<169945360154.55307.2938894711228282149.stgit@devnote2>
	<20231110105154.df937bf9f200a0c16806c522@kernel.org>
	<20231109211848.10a5e224@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Nov 2023 21:18:48 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 10 Nov 2023 10:51:54 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > So this patch registers ftrace_ops for each fgraph_ops to ftrace.
> > This means that the ftrace_graph_func() will be called twice or more
> > on the same function.
> > Thus should I call ftrace_startup() once when the first fgraph_ops
> > is registered? 
> > No, it's not enough. Actually each fgraph_ops can have different filters.
> > We need to define a shared filter and combine new filters to one and
> > use it. We also need to do it when a fgraph is unregistered.
> > 
> > Is there any function which makes a new filter from two (or more) filters?
> 
> So I'm guessing that we need to have a fgraph_set_filter*() operations?
> 
> When one gets added, it needs to update the ftrace_ops to include the added
> functions. Or we need to have a way to create a new hash from all the
> registered fgraph_ops, and have that for the ftrace_ops. Then when it gets
> called, if it has more than one registered function, it needs to iterate
> over the list?

Yes, that is one option, update a global common hash and introduce a new
common ftrace function to run function_graph_enter().

Or, I think keep the current one but iterate ftrace_ops to callback the
function_graph_enter() with ftrace_ops. Then we can get appropriate
fgraph_ops. Ftrace push return trace can skip pushing if ret == return_to_handler.
(maybe this is better to reuse ftrace)

Thank you,

> 
> -- Steve
> 
> 
> > 
> > Or, maybe we can make the common callback to find the previous ret entry on
> > the ret_stack and reuse it. (In this case we don't need loop on each
> > fgraph_array entry)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

