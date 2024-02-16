Return-Path: <bpf+bounces-22137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20298577E9
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 09:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3908C1F22950
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143B31CD1E;
	Fri, 16 Feb 2024 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q86fpiox"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858521B960;
	Fri, 16 Feb 2024 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073014; cv=none; b=PelIMti0OIka9Wf2H0ZrFzC996Pk1hm1cax5KsvfgE7D1dzxMVVTsnU3lGNKTI7Gwd5QNdoTQDsn9E6g4pd0CWDnKz4q6K94FdJ9dHgCp4aV4Pbph/DH9q/WWH6xxMAl5ryUpsenk6kr7fOxPzL0+MXrW9FhXTSoQk9FSrDcZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073014; c=relaxed/simple;
	bh=+b8mN7CNmHQFpTKd9L1NSz4eoYyuQaBO8mYACb1HDHM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ii+EQfWeY4/60a3WDr7tWyBziJbXm+8WZzcddOfDbi8dx+l+mEt3KteUVUiB+I8W7+pljEFOsHXMlYxX9MXwTut3Skf/ziK1mFl+ecqPsk6+1Q3SA67mI5HzdO+gGWPCXwlZxtkJ0p0jG1nHLuiLFjw+ugWCSQ4k2tj1CsvtJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q86fpiox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E9DC433C7;
	Fri, 16 Feb 2024 08:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708073014;
	bh=+b8mN7CNmHQFpTKd9L1NSz4eoYyuQaBO8mYACb1HDHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q86fpioxtbr8kZVvxukz+myy6usxSOPpN+k3iITuYeQJPvoptqCj1yHJXJ0yzInJK
	 vfo052HrWVYE2DdSemFiwDexPlBO93QOkKg85dPU28092LMZBb2p/NkGPBgklom7nT
	 1uzzaH0roBolrvZj729xpLU/TxFsM0cJQftnOmjWxZeu0hHdrqeaZBzdkTJQ/tzhNp
	 XhFbETJGTeCC0c9/92RVjeog8ZWvZdMzigAznSZgZd4vA2OBrAtSRT1alU+udSme4L
	 mKgZf+69lYlE2JL639XAX/cnwdMiZSlbrcAhmfVIjwXo5hxua4bzD9fGp5nnNJSUz5
	 BkGhfJDhLF09g==
Date: Fri, 16 Feb 2024 17:43:27 +0900
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
Subject: Re: [PATCH v7 23/36] function_graph: Add a new exit handler with
 parent_ip and ftrace_regs
Message-Id: <20240216174327.092ff38bb6198718e8e5a1c3@kernel.org>
In-Reply-To: <20240215104903.09bb3765@gandalf.local.home>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723230476.502590.16817817024423790038.stgit@devnote2>
	<20240215104903.09bb3765@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 10:49:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  7 Feb 2024 00:11:44 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 61c541c36596..308b3bec01b1 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -34,6 +34,9 @@ config HAVE_FUNCTION_GRAPH_TRACER
> >  config HAVE_FUNCTION_GRAPH_RETVAL
> >  	bool
> >  
> > +config HAVE_FUNCTION_GRAPH_FREGS
> > +	bool
> > +
> >  config HAVE_DYNAMIC_FTRACE
> >  	bool
> >  	help
> 
> We're starting to get overloaded with the CONFIG_HAVE_* options.
> 
> We need to start consolidating them. I would like to make RETVAL and FREGS
> into one option. We can add this now, but before we add anything else, we
> need to see what HAVE configs have the same archs, and then just
> consolidate them. If an new arch wants to add one of the consolidated
> features, it will also need to add all the other features that were
> consolidated with it.

Got it. So RETVAL should be implemented by FREGS or REGS.
Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

