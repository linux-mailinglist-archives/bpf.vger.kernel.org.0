Return-Path: <bpf+bounces-3096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A65739428
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 02:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A485E1C20F4F
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 00:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D28815DA;
	Thu, 22 Jun 2023 00:56:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE561816
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 00:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A06BC433C8;
	Thu, 22 Jun 2023 00:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687395383;
	bh=wv/ccikv6JtB50wcnc91LNHFaXUxXG+y7SLjpMce8Wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MLtuv5NgFvsMK3jKukhwekdJ2QpVGz32URilHaErz72s9gQ5M0NAG+ztRwzb1RwAP
	 Ch1i54PH9SzkwrqvZO6pPF5j6Habgu2y4YpuYjIo9dWqnwB1EhsnmRqQi86dWx/h2s
	 mb7iS1AFHGDn7bPuqSLAmmL8jrpo2Sp1XFouUcQ7Kooco3zWgKfQ9brZyNGjD/pxbC
	 QJ1RoltNJCQhfXWsUwYEUep7JBRtSrBSd4IDKgZ5AklcO9FLTP0l4Zzrb4BS/pNBRb
	 CUkQyj8Wc1hjxWSiXbOBSwanfyx2nAXyPQrZE+VQ9yWW7HXJquY0MDmLoO/W9d4z5G
	 jLZdnl3ZM6E+w==
Date: Thu, 22 Jun 2023 09:56:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH] tracing/probes: Fix tracepoint event with $arg* to
 fetch correct argument
Message-Id: <20230622095619.2fd219543719d20806707a7e@kernel.org>
In-Reply-To: <20230621190337.4635ead7@gandalf.local.home>
References: <168657113778.3038017.12245893750241701312.stgit@mhiramat.roam.corp.google.com>
	<20230621190337.4635ead7@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 19:03:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 12 Jun 2023 20:58:57 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > To hide the first dummy 'data' argument on the tracepoint probe events,
> > the BTF argument array was modified (skip the first argument for tracepoint),
> > but the '$arg*' meta argument parser missed that.
> > 
> > Fix to increment the argument index if it is tracepoint probe. And decrement
> > the index when searching the type of the argument.
> 
> I'm curious. What if we want a variable that points to that data argument? ;-)

That is a dummy parameter which is passed when registering the callback, so
it is passed from trace_fprobe.c. Currently trace_fprobe.c passed NULL to
the data argument.

> 
> Probably just add a new type I guess.

Yeah, if we get any idea to use it, it will be accessed by a new $-variable.

> 
> Anyway,
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you!

> 
> -- Steve
> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_probe.c |   10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 473e1c43bc57..643aa3a51d5a 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -456,7 +456,10 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
> >  
> >  		if (name && !strcmp(name, varname)) {
> >  			code->op = FETCH_OP_ARG;
> > -			code->param = i;
> > +			if (ctx->flags & TPARG_FL_TPOINT)
> > +				code->param = i + 1;
> > +			else
> > +				code->param = i;
> >  			return 0;
> >  		}
> >  	}
> > @@ -470,8 +473,11 @@ static const struct fetch_type *parse_btf_arg_type(int arg_idx,
> >  	struct btf *btf = traceprobe_get_btf();
> >  	const char *typestr = NULL;
> >  
> > -	if (btf && ctx->params)
> > +	if (btf && ctx->params) {
> > +		if (ctx->flags & TPARG_FL_TPOINT)
> > +			arg_idx--;
> >  		typestr = type_from_btf_id(btf, ctx->params[arg_idx].type);
> > +	}
> >  
> >  	return find_fetch_type(typestr, ctx->flags);
> >  }
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

