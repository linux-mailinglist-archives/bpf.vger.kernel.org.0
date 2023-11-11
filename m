Return-Path: <bpf+bounces-14857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2B97E88BD
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 04:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A0F2812CC
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056125399;
	Sat, 11 Nov 2023 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWAMWOx4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1D25258;
	Sat, 11 Nov 2023 03:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607F4C433C7;
	Sat, 11 Nov 2023 03:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699671665;
	bh=2LhQYw/i4O/j2ctPROiuf3u6PzGIF0+bsBDBydGMZnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tWAMWOx4vhvFMzdCZw6QmWxI/wokCMAA5N6nkHSFK3FCHvTa950ut+pR4uCTztS4M
	 groOXHFxJtReonezDIWs77kjY534etk4wnryxh7YD5hfiG5GEQgj/tYFXsHtgr+Uej
	 dgzm4euuJqb46sr/ZEDFz8XekUc0FhUQQaog+FGt+p9/g9Y2A94DrNJNvenDUl/PTv
	 TNfueI8VSr+gMjn4reVKUZkcGHV8n4OyihM0OGEqyb57TTZ5CoqK0fQRKXBkherQPA
	 fG5OjsKU7ZlxkQEB43zEQL465PC/eZC3C2N8uxn14zV18VZMNfyhG6dn1MdVnuY/Ny
	 WOZz1Tay24Z0A==
Date: Sat, 11 Nov 2023 12:01:00 +0900
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
Subject: Re: [RFC PATCH v2 26/31] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20231111120100.a3cb8ffadd274bbe6f79bac9@kernel.org>
In-Reply-To: <20231110204422.05ac4581@gandalf.local.home>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
	<169945376173.55307.5892275268096520409.stgit@devnote2>
	<20231110161739.f0ff9c50f20ebcfb57be6459@kernel.org>
	<20231110204422.05ac4581@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 20:44:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 10 Nov 2023 16:17:39 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > +	used = 0;
> > > +	hlist_for_each_entry_from_rcu(node, hlist) {
> > > +		if (node->addr != func)
> > > +			break;
> > > +		fp = READ_ONCE(node->fp);
> > > +		if (!fp || fprobe_disabled(fp))
> > > +			continue;
> > > +
> > > +		if (fprobe_shared_with_kprobes(fp))
> > > +			ret = __fprobe_kprobe_handler(func, ret_ip,
> > > +					fp, fregs, fgraph_data + used);
> > > +		else
> > > +			ret = __fprobe_handler(func, ret_ip, fp,
> > > +					fregs, fgraph_data + used);  
> > 
> > 
> > Since the fgraph callback is under rcu-locked but not preempt-disabled,
> 
> rcu-locked? The only rcu-locked is task rcu.

Hmm, it might be my misread. But I don't get any warning from
find_first_fprobe_node(), which uses hlist_for_each_entry_rcu()
so isn't it rcu locked?

> 
> > fprobe unittest fails. I need to add preempt_disable_notrace() and
> > preempt_enable_notrace() around this. Note that kprobe_busy_begin()/end()
> > also access to per-cpu variable, so it requires to disable preemption.
> 
> 
> Just around the __fprobe_*handler()? Or the loop?

Just around the __fprobe*handler().

Thank you,


> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

