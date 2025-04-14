Return-Path: <bpf+bounces-55832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79861A875F5
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 05:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22957A6874
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 02:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FA18DF80;
	Mon, 14 Apr 2025 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB0MDPhQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06011AD51;
	Mon, 14 Apr 2025 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744599618; cv=none; b=ZaU9+aP7XBccwZIXlEaE6Ji5jbbFIE2QdYaAHOsZcGdSAiwhFR6N0jV92gIKj5PE5pKRwnPzV0FNfgQ31GmaYx64f5Fyb+r11kJEZCjTek+Tf+71qFv5SOJiiR+ScZDhS54bXj5SvE3kA3B912QKG+TgOfUiVLlnOmbxJefBGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744599618; c=relaxed/simple;
	bh=5jqtjDnwxSBtJOLqJhkrIDIeuZ+V3NY6fYonRrvqp90=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rYU9r+GL4IUe5yrQyPoJzQYJkwtcsyfTlMS9uf39D0CyFB3HVk7YfWLLdicyEHhLCoztSMx+yuWnUgh9XJJml8QYHCakQT3iHFdD4wzeIboHcOS0bm7LiWrHLh6WW79PCegSvLTfKHamc1idFJXbIzJBLnbID5Iroqc73hm9jNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pB0MDPhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672D1C4CEDD;
	Mon, 14 Apr 2025 03:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744599617;
	bh=5jqtjDnwxSBtJOLqJhkrIDIeuZ+V3NY6fYonRrvqp90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pB0MDPhQL7p6oIMgPI1fAmxmJIgBN28j0xDVJprSB5RgElYT2p9L6x+zIucWU6gP+
	 YK3JlSbJ7ftWXyoLTb8l+/NAqAZEVloyHymir9UiCeBdUaoflp7DGUnrQRiyzGlqYP
	 aJy1bgu9tkcY2A5EP9NSPQ3GvhV9Wg8k1qc7mwEIr44ldFg57MiNSZrCh6KjeO8UM1
	 94vfgqBnEMz9gsgEQZTFx9NtG6J2KdwmsHnmQGoJc7+J/onzOrXpvjHKZWBn/Oohck
	 lXnl+X68P+/N/4wt1lJVaua+bPYCzpqhGuu71wYgd4yVAE6FdYBygAtlEwrIDjFapZ
	 fuqojo9xOAjjg==
Date: Mon, 14 Apr 2025 12:00:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Donglin
 Peng <dolinux.peng@gmail.com>, Zheng Yejian <zhengyejian@huaweicloud.com>,
 Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-Id: <20250414120013.895b0cc99e52c41eb8ec3774@kernel.org>
In-Reply-To: <20250411152610.64d555bf@gandalf.local.home>
References: <20250227185804.639525399@goodmis.org>
	<20250227185822.810321199@goodmis.org>
	<ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
	<20250410131745.04c126eb@gandalf.local.home>
	<c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
	<20250411124552.36564a07@gandalf.local.home>
	<2edc0ba8-2f45-40dc-86d9-5ab7cea8938c@sirena.org.uk>
	<20250411131254.3e6155ea@gandalf.local.home>
	<350786cc-9e40-4396-ab95-4f10d69122fb@sirena.org.uk>
	<9dafc156-1272-4039-a9c0-3448a1bd6d1f@sirena.org.uk>
	<20250411142427.3abfb3c3@gandalf.local.home>
	<20250411143132.56096f76@gandalf.local.home>
	<20250411151358.1d4fd8c7@gandalf.local.home>
	<20250411152610.64d555bf@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 15:26:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Replying to my email as it appears gmail blocked it. Probably due to all
> the escape characters my output had. Resending with that cut out.
> 
> Masami, I was sent a message from gmail that it blocked this from you.

Hi, I could find it. Let me reply!

> 
> If you want to see the original email:
> 
>   https://lore.kernel.org/all/20250411151358.1d4fd8c7@gandalf.local.home/
> 
> -- Steve
> 
> On Fri, 11 Apr 2025 15:13:58 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 11 Apr 2025 14:31:32 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > Hmm, I just tested this, and it fails on my box too (I test on a debian VM).
> > > 
> > > It fails with and without setting it to bash. I'll take a look too.  
> > 
> > Hmm, maybe it is a bashism.
> > 
> > The test has this:
> > 
> >   # Max arguments limitation
> >   MAX_ARGS=128
> >   EXCEED_ARGS=$((MAX_ARGS + 1))
> > 
> >   check_max_args() { # event_header
> >     TEST_STRING=$1
> >     # Acceptable
> >     for i in `seq 1 $MAX_ARGS`; do
> >       TEST_STRING="$TEST_STRING \\$i"
> >     done
> >     echo "$TEST_STRING" >> dynamic_events
> >     echo > dynamic_events
> >     # Error
> >     TEST_STRING="$TEST_STRING \\$EXCEED_ARGS"
> >     ! echo "$TEST_STRING" >> dynamic_events
> >     return 0
> >   }
> > 
> >   # Kprobe max args limitation
> >   if grep -q "kprobe_events" README; then
> >     check_max_args "p vfs_read"
> >   fi
> > 
> > So I tried manually executing this in bash:
> > 
> > --------------------------8<--------------------------
> > # TEST_STRING='p vfs_read'
> > # for i in `seq 1 128`; do TEST_STRING="$TEST_STRING \\$i" ; done
> > # echo $TEST_STRING
> > p vfs_read \1 \2
> 
> [ This  is cut out to see if it doesn't trigger gmail blocking it again! ]
> 
> > # echo "$TEST_STRING" >> /sys/kernel/tracing/dynamic_events
> > # echo $?
> > 0
> > # cat /sys/kernel/tracing/dynamic_events
> > p:kprobes/p_vfs_read_0 vfs_read arg1=\1
> 
> [ This  is cut out to see if it doesn't trigger gmail blocking it again! ]
> 
> > -------------------------->8--------------------------  
> > 
> > Doing the same in dash:
> > 
> > --------------------------8<--------------------------
> > # dash
> > # TEST_STRING='p vfs_read'
> > # for i in `seq 1 128`; do TEST_STRING="$TEST_STRING \\$i" ; done
> > # echo $TEST_STRING
> > p vfs_read         \8 \9 	 
> 
> [ This  is cut out to see if it doesn't trigger gmail blocking it again! ]
> 
> > # echo "$TEST_STRING" >> /sys/kernel/tracing/dynamic_events
> > dash: 8: echo: echo: I/O error
> > -------------------------->8--------------------------  
> > 
> > Looks like dash will translate those "\#" into the ASCII equivalent,
> > whereas bash does not.
> > 
> > This patch seems to fix it:
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> > index 6b94b678741a..ebe2a34cbf92 100644
> > --- a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> > @@ -11,7 +11,7 @@ check_max_args() { # event_header
> >    TEST_STRING=$1
> >    # Acceptable
> >    for i in `seq 1 $MAX_ARGS`; do
> > -    TEST_STRING="$TEST_STRING \\$i"
> > +    TEST_STRING="$TEST_STRING \\\\$i"
> >    done
> >    echo "$TEST_STRING" >> dynamic_events
> >    echo > dynamic_events
> > 
> > 
> > Masami, you just recently added this test (it's dated March 27th 2025), did
> > you mean to write in the ASCII characters? Why the backslash?
> > 
> > -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

