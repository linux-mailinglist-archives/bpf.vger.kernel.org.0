Return-Path: <bpf+bounces-30547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C028CEC77
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 00:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B700B21CA7
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DDA128808;
	Fri, 24 May 2024 22:41:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5038562E;
	Fri, 24 May 2024 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716590473; cv=none; b=OX1bAPvEcV1j989YLE0nSD7qk5aFip9b7I8rWI4IWWuVe5NwtlguQ1Pk+9pObGvsaGp/YDo8XDMucEPq1Vkg0XZe2DMMLDcNo8bpuLgsL9M6DkjeBZEx3xNguOu33l2XYxJr2UINvUY+Gp055Jnp+qgOlrdrwlbWrwUnFKOKGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716590473; c=relaxed/simple;
	bh=+M+H9EDpt9M62BF9//BYA/DAxOwyZ70sO84XieW/I5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVdf8CgfYSeSAV/7Y0E0K7RSPbhYy9GPHX1jI71649YPDmhJ1Xxakmq14Jc6oPDVX0RiuVeaypXYcP2io0el7QTPdc41O7gigsROxAU5eE08l1k/GkhE87uea9KukMfYycPZnu0ep2LWuqcPRiVYw4a9z77GU/PaDZhZTyY9990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261E8C2BBFC;
	Fri, 24 May 2024 22:41:11 +0000 (UTC)
Date: Fri, 24 May 2024 18:41:56 -0400
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
Subject: Re: [PATCH v10 00/36] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-ID: <20240524184156.2d9704c2@gandalf.local.home>
In-Reply-To: <171509088006.162236.7227326999861366050.stgit@devnote2>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 May 2024 23:08:00 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Steven Rostedt (VMware) (15):
>       function_graph: Convert ret_stack to a series of longs
>       fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
>       function_graph: Add an array structure that will allow multiple callbacks
>       function_graph: Allow multiple users to attach to function graph
>       function_graph: Remove logic around ftrace_graph_entry and return
>       ftrace/function_graph: Pass fgraph_ops to function graph callbacks
>       ftrace: Allow function_graph tracer to be enabled in instances
>       ftrace: Allow ftrace startup flags exist without dynamic ftrace
>       function_graph: Have the instances use their own ftrace_ops for filtering
>       function_graph: Add "task variables" per task for fgraph_ops
>       function_graph: Move set_graph_function tests to shadow stack global var
>       function_graph: Move graph depth stored data to shadow stack global var
>       function_graph: Move graph notrace bit to shadow stack global var
>       function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
>       function_graph: Add selftest for passing local variables

Hi Masami,

While reviewing these patches, I realized there's several things I dislike
about the patches I wrote. So I took these patches and started cleaning
them up a little. Mostly renaming functions and adding comments.

As this is a major change to the function graph tracer, and I feel nervous
about building something on top of this, how about I take over these
patches and push them out for the next merge window. I'm hoping to get them
into linux-next by v6.10-rc2 (I spent the day working on them, and it's
mostly minor tweaks).

Then I can push it out to 6.11 and get some good testing against it. Then
we can add your stuff on top and get that merged in 6.12.

If all goes well, I'm hoping to get a series on just these patches (and
your selftest addition) by tonight.

Thoughts?

-- Steve

