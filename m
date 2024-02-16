Return-Path: <bpf+bounces-22135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC8C8577DB
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 09:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B181C20C73
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 08:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2C11B963;
	Fri, 16 Feb 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIyKWQZy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A11C68C;
	Fri, 16 Feb 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072868; cv=none; b=D2PUcUjp6vwg8HPikGyjiiht+WFAUULdc3z6QhvwOesbrx3RaJCP7jSMe/BXVngFJJK2eB9uaIIhnYy67Ox9PvewBbnb18D+xkDarjZGHhF4r34S6BjmhsD9Zb7YQxeHVJ0nR+5VeNTeYbqX/M9JD1LBG+hHSddBxFh+b2Wmlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072868; c=relaxed/simple;
	bh=wZvqkkB1tvM0qT7Zjonl08Zz23unYjSrGtBfMOx3z84=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I4HXX4EgAuUKumU8dTd3+ctadyklikxxdsqCjUu89H8KDK/0dq/2JKH/IMU4H5GNGKBItN+ukC3xpaWBrl1o7UZfUeu3C8aC6GJMZf3+PofipXYW2L90meHvzRcEwWYBFjC1hsn7oiMxSvP8899FO50NAt30LfGx0tNgTRFTCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIyKWQZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA29C433F1;
	Fri, 16 Feb 2024 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708072867;
	bh=wZvqkkB1tvM0qT7Zjonl08Zz23unYjSrGtBfMOx3z84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QIyKWQZy97QNoYLS2HFfBQL3l9noxnfyWzsod9pJNgjZW4LcYOhLsWdHTeyw4TWfv
	 Lrfae77Vhn8tQO2Q8w6uk7jiCRO1xbiwVf9k9DFXKwGCyBqBqgpDd1b/Ya03l6Th3E
	 PzIpSbPg1pD1+jFEubNfnXoX3h57WrjhvXBTJTFv1pl7y5+O9rF3y42HoEj+cCn4GV
	 pHYpX3ygmCjtyVaIKnqUq1wSekoverdcEVq2St8b0SfJ0OjpVl88DftniBy4jwSBIM
	 a3H7CucAu/R3IBk29M18Cd6AB7cJCLX5SuFrGVr/YuhBOnvozin/fP6jH2bjIjeHek
	 a9d/tYlN+1VRA==
Date: Fri, 16 Feb 2024 17:41:01 +0900
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
Subject: Re: [PATCH v7 21/36] function_graph: Add selftest for passing local
 variables
Message-Id: <20240216174101.57c4e61a0d6b4ed21c2a22bd@kernel.org>
In-Reply-To: <20240215100254.2891c5da@gandalf.local.home>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723228217.502590.6615001674278328094.stgit@devnote2>
	<20240215100254.2891c5da@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 10:02:54 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  7 Feb 2024 00:11:22 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Add boot up selftest that passes variables from a function entry to a
> > function exit, and make sure that they do get passed around.
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - Add reserved size test.
> >   - Use pr_*() instead of printk(KERN_*).
> > ---
> >  kernel/trace/trace_selftest.c |  169 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 169 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> > index f0758afa2f7d..4d86cd4c8c8c 100644
> > --- a/kernel/trace/trace_selftest.c
> > +++ b/kernel/trace/trace_selftest.c
> > @@ -756,6 +756,173 @@ trace_selftest_startup_function(struct tracer *trace, struct trace_array *tr)
> >  
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >  
> > +#ifdef CONFIG_DYNAMIC_FTRACE
> > +
> > +#define BYTE_NUMBER 123
> > +#define SHORT_NUMBER 12345
> > +#define WORD_NUMBER 1234567890
> > +#define LONG_NUMBER 1234567890123456789LL
> > +
> > +static int fgraph_store_size __initdata;
> > +static const char *fgraph_store_type_name __initdata;
> > +static char *fgraph_error_str __initdata;
> > +static char fgraph_error_str_buf[128] __initdata;
> > +
> > +static __init int store_entry(struct ftrace_graph_ent *trace,
> > +			      struct fgraph_ops *gops)
> > +{
> > +	const char *type = fgraph_store_type_name;
> > +	int size = fgraph_store_size;
> > +	void *p;
> > +
> > +	p = fgraph_reserve_data(gops->idx, size);
> > +	if (!p) {
> > +		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
> > +			 "Failed to reserve %s\n", type);
> > +		fgraph_error_str = fgraph_error_str_buf;
> > +		return 0;
> > +	}
> > +
> > +	switch (fgraph_store_size) {
> > +	case 1:
> > +		*(char *)p = BYTE_NUMBER;
> > +		break;
> > +	case 2:
> > +		*(short *)p = SHORT_NUMBER;
> > +		break;
> > +	case 4:
> > +		*(int *)p = WORD_NUMBER;
> > +		break;
> > +	case 8:
> > +		*(long long *)p = LONG_NUMBER;
> > +		break;
> > +	}
> > +
> 
> What would be an interesting test is to run all versions together. That is,
> to attach a callback that stores a byte, a callback that stores a short, a
> callback that stores a word and a callback that stores a long, and attach
> them all to the same function.
> 
> I guess we can add that as a separate patch.

Would you mean we should have different callbacks which stores the different
size of data instead of using switch()?

Thank you,

> 
> -- Steve
> 
> 
> > +	return 1;
> > +}
> > +


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

