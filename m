Return-Path: <bpf+bounces-3093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C3C7393F1
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 02:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206BE1C20F97
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 00:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7B15CC;
	Thu, 22 Jun 2023 00:39:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413763E
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 00:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F92C433C0;
	Thu, 22 Jun 2023 00:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687394349;
	bh=ADfuTglLpoDdSOwtLMSK5Y7dt3qf8/05EDWHsVK5rSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DX0CNIqmY5CYNtGeRLD0YVHIQlVVdUPWbV2YAu1buysLIy0ZSxLKDP0YbQMMYQYGi
	 YElyvlmv8fG2fKKcCCu5A+qnEM3/uNCSeEA1yMLzXfRh2kSoIWMzymWeUYXn649z82
	 nRc+ijBZ/RPD3qGQO0oISxQr83E854IAhlpOYZoy330foH33q7LIW2xkt2LLIJEoyR
	 w65wzkdKVOYrEW7NdHj0xeWj0MEqdHF/Tfh2aE5Izc5YaLYa/hSF9hm21DjkMqWPrp
	 ATiITRvlfzIFZe0EuR1mL+ZREKWBqZR7PnCt4Q2jUPZNuu4YHR+QUnpgykKGQWeM40
	 gELQPDUzPTWIw==
Date: Thu, 22 Jun 2023 09:39:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>, Mark
 Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf@vger.kernel.org, Bagas Sanjaya
 <bagasdotme@gmail.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tracing/probes: Fix tracepoint event with $arg* to
 fetch correct argument
Message-Id: <20230622093905.e0619ea5e1fa3db9772d26eb@kernel.org>
In-Reply-To: <12b0c61d-1270-ab34-63bf-a5c389fd45bc@gmail.com>
References: <168657113778.3038017.12245893750241701312.stgit@mhiramat.roam.corp.google.com>
	<12b0c61d-1270-ab34-63bf-a5c389fd45bc@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jun 2023 12:50:34 -0700
Kui-Feng Lee <sinquersw@gmail.com> wrote:

> 
> 
> On 6/12/23 04:58, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > To hide the first dummy 'data' argument on the tracepoint probe events,
> > the BTF argument array was modified (skip the first argument for tracepoint),
> > but the '$arg*' meta argument parser missed that.
> > 
> > Fix to increment the argument index if it is tracepoint probe. And decrement
> > the index when searching the type of the argument.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   kernel/trace/trace_probe.c |   10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 473e1c43bc57..643aa3a51d5a 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -456,7 +456,10 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
> >   
> >   		if (name && !strcmp(name, varname)) {
> >   			code->op = FETCH_OP_ARG;
> > -			code->param = i;
> > +			if (ctx->flags & TPARG_FL_TPOINT)
> > +				code->param = i + 1;
> > +			else
> > +				code->param = i;
> >   			return 0;
> >   		}
> >   	}
> > @@ -470,8 +473,11 @@ static const struct fetch_type *parse_btf_arg_type(int arg_idx,
> >   	struct btf *btf = traceprobe_get_btf();
> >   	const char *typestr = NULL;
> >   
> > -	if (btf && ctx->params)
> > +	if (btf && ctx->params) {
> > +		if (ctx->flags & TPARG_FL_TPOINT)
> > +			arg_idx--;
> >   		typestr = type_from_btf_id(btf, ctx->params[arg_idx].type);
> > +	}
> >   
> >   	return find_fetch_type(typestr, ctx->flags);
> >   }
> > 
> > 
> 
> I failed to apply this patch.
> Would you mind to rebase this patch?

Ah, this is against for the probes/for-next branch on
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

Thanks,

> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

