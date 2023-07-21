Return-Path: <bpf+bounces-5568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC3A75BBE5
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 03:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267F51C21593
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 01:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59671391;
	Fri, 21 Jul 2023 01:42:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AF8363
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 01:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458C4C433C9;
	Fri, 21 Jul 2023 01:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689903725;
	bh=dw1xMty5sUx55lKWIHCKf4qU6fRTTDgNxFDurgYRD1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LTGUIWNwZCt1pvkrukTY07XnEQ3xswAAwgdRew4atcUyeBGtLAvFf5Umec9wZj+AI
	 JdPeGtUCroBGjn0H/wVOegulnEJOYmNBACd1LCKdDO3sf8z+Ag/79dQhp2bt194Qvk
	 g2G2A+JNUE6yNltck6xY/Dj2RORG584hKY3IghbWUoThzBjUtzjLGR00BCLycUD42Z
	 jm4lqjPX5e3D+SiQMc5RQTWLhvt/3gDo2q8LbHYqgFt6nOkEdESWgRV7AFga1HufWR
	 6vhlgA/YSc959/OcEykI0a6cgsJ4/rKmb68/tS+knEIwFuRXjH56we7ZwINrbxJdNS
	 ++IxAlVxujtGQ==
Date: Fri, 21 Jul 2023 10:42:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 8/9] selftests/ftrace: Add BTF fields access
 testcases
Message-Id: <20230721104200.92655ae661532475134cf004@kernel.org>
In-Reply-To: <18605821-d4f1-c8e2-74eb-a91fc06d53b7@oracle.com>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
	<168960747750.34107.6104527579648222887.stgit@devnote2>
	<18605821-d4f1-c8e2-74eb-a91fc06d53b7@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 00:00:32 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> 
> On 17/07/2023 16:24, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add test cases for accessing the data structure fields using BTF info.
> > This includes the field access from parameters and retval, and accessing
> > string information.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> One suggestion below, but
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks

> 
> > ---
> > Changes in v2:
> >  - Use '$retval' instead of 'retval'.
> >  - Add a test that use both '$retval' and '$arg1' for fprobe.
> > ---
> >  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +++++++++++
> >  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 ++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
> > index b89de1771655..93b94468967b 100644
> > --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
> > @@ -21,6 +21,8 @@ echo 0 > events/enable
> >  echo > dynamic_events
> >  
> >  TP=kfree
> > +TP2=kmem_cache_alloc
> > +TP3=getname_flags
> >  
> >  if [ "$FPROBES" ] ; then
> >  echo "f:fpevent $TP object" >> dynamic_events
> > @@ -33,6 +35,7 @@ echo > dynamic_events
> >  
> >  echo "f:fpevent $TP "'$arg1' >> dynamic_events
> >  grep -q "fpevent.*object=object" dynamic_events
> > +
> >  echo > dynamic_events
> >  
> >  echo "f:fpevent $TP "'$arg*' >> dynamic_events
> > @@ -45,6 +48,14 @@ fi
> >  
> >  echo > dynamic_events
> >  
> > +echo "t:tpevent $TP2 name=s->name:string" >> dynamic_events
> > +echo "f:fpevent ${TP3}%return path=\$retval->name:string" >> dynamic_events
> > +
> 
> could we test a numeric value like kmem_cache_alloc object size?
> also if combos of -> and . are allowed, would be good to test one of
> those too.

OK, that's a good point! I'll add it.

> 
> > +grep -q "tpevent.*name=s->name:string" dynamic_events
> > +grep -q "fpevent.*path=\$retval->name:string" dynamic_events
> > +
> > +echo > dynamic_events
> > +
> >  if [ "$KPROBES" ] ; then
> >  echo "p:kpevent $TP object" >> dynamic_events
> >  grep -q "kpevent.*object=object" dynamic_events
> > diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
> > index 72563b2e0812..49758f77c923 100644
> > --- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
> > @@ -103,6 +103,10 @@ check_error 'f vfs_read%return ^$arg*'		# NOFENTRY_ARGS
> >  check_error 'f vfs_read ^hoge'			# NO_BTFARG
> >  check_error 'f kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
> >  check_error 'f kfree%return ^$retval'		# NO_RETVAL
> > +check_error 'f vfs_read%return $retval->^foo'	# NO_PTR_STRCT
> > +check_error 'f vfs_read file->^foo'		# NO_BTF_FIELD
> > +check_error 'f vfs_read file^-.foo'		# BAD_HYPHEN
> > +check_error 'f vfs_read ^file:string'		# BAD_TYPE4STR
> >  else
> >  check_error 'f vfs_read ^$arg*'			# NOSUP_BTFARG
> >  check_error 't kfree ^$arg*'			# NOSUP_BTFARG
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

