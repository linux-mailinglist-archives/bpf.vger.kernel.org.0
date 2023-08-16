Return-Path: <bpf+bounces-7903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FE77E487
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 17:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF03F281B37
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41605156C3;
	Wed, 16 Aug 2023 15:02:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF610957;
	Wed, 16 Aug 2023 15:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8FCC433C7;
	Wed, 16 Aug 2023 15:02:03 +0000 (UTC)
Date: Wed, 16 Aug 2023 11:02:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Manjusaka <me@manjusaka.me>
Cc: Joe Perches <joe@perches.com>, edumazet@google.com, bpf@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, ncardwell@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230816110206.13980573@gandalf.local.home>
In-Reply-To: <8b0f2d2b-c5a0-4654-9cc0-78873260a881@manjusaka.me>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
	<20230812201249.62237-1-me@manjusaka.me>
	<20230812205905.016106c0@rorschach.local.home>
	<20230812210140.117da558@rorschach.local.home>
	<20230812210450.53464a78@rorschach.local.home>
	<6bfa88099fe13b3fd4077bb3a3e55e3ae04c3b5d.camel@perches.com>
	<20230812215327.1dbd30f3@rorschach.local.home>
	<a587dac9e02cfde669743fd54ab41a3c6014c5e9.camel@perches.com>
	<8b0f2d2b-c5a0-4654-9cc0-78873260a881@manjusaka.me>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Aug 2023 14:09:06 +0800
Manjusaka <me@manjusaka.me> wrote:

> > +# trace include files use a completely different grammar
> > +		next if ($realfile =~ m{(?:include/trace/events/|/trace\.h$/)});
> > +
> >  # check multi-line statement indentation matches previous line
> >  		if ($perl_version_ok &&
> >  		    $prevline =~ /^\+([ \t]*)((?:$c90_Keywords(?:\s+if)\s*)|(?:$Declare\s*)?(?:$Ident|\(\s*\*\s*$Ident\s*\))\s*|(?:\*\s*)*$Lval\s*=\s*$Ident\s*)\(.*(\&\&|\|\||,)\s*$/) {
> > 
> > 
> >   
> 
> Actually, I'm not sure this is the checkpatch style issue or my code style issue.
> 
> Seems wired.

The TRACE_EVENT() macro has its own style. I need to document it, and
perhaps one day get checkpatch to understand it as well.

The TRACE_EVENT() typically looks like:


TRACE_EVENT(name,

	TP_PROTO(int arg1, struct foo *arg2, struct bar *arg3),

	TP_ARGS(arg1, arg2, arg3),

	TP_STRUCT__entry(
		__field(	int,		field1				)
		__array(	char,		mystring,	MYSTRLEN	)
		__string(	filename,	arg3->name			)
	),

	TP_fast_assign(
		__entry->field1 = arg1;
		memcpy(__entry->mystring, arg2->string);
		__assign_str(filename, arg3->name);
	),

	TP_printk("field1=%d mystring=%s filename=%s",
		__entry->field1, __entry->mystring, __get_str(filename))
);

The TP_STRUCT__entry() should be considered more of a "struct" layout than
a macro layout, and that's where checkpatch gets confused. The spacing
makes it much easier to see the fields and their types.

-- Steve

