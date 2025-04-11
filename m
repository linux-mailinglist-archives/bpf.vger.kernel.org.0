Return-Path: <bpf+bounces-55785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50048A8663E
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 21:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AF24A53A3
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A3327C16F;
	Fri, 11 Apr 2025 19:24:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A553B233153;
	Fri, 11 Apr 2025 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399488; cv=none; b=ozFnIfUdeh11sW6LWT3Ot+G3xdykwmDHeW2K8OL3NVpFqXFonY9YKDosllJ+2fimetFJ2n9Liz8RnaYBUw5P5oWc7RL2XdQNJBSjbuZbDETI7VfRVZEZUGODL6ja5XqG+KgEqwWS0NXwdjhi80nOqgSIAPcD3+aZXJsTNFtjzaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399488; c=relaxed/simple;
	bh=JedUTcfeYTCorFNspiCeOPahUYA07g0aSU7WDXE6Qac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwq5khn5rZsi9Qj1L0+aCzc/737qWZ5uSZhPfocP7+NeAB10Y4ByIV1Sami8yw9YcBpZ7ldrYDP7NKe2Mlji/axkA4RNdFHm7rmE8M4AQijlDZPetza3Vrk/ayXp5KCb8eQC0Q2qWf+Tl/VIq8VrPAERJBaPnqrhlkMVVvkZx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602E3C4CEE2;
	Fri, 11 Apr 2025 19:24:46 +0000 (UTC)
Date: Fri, 11 Apr 2025 15:26:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sven Schnelle
 <svens@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, Donglin Peng <dolinux.peng@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <20250411152610.64d555bf@gandalf.local.home>
In-Reply-To: <20250411151358.1d4fd8c7@gandalf.local.home>
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
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Replying to my email as it appears gmail blocked it. Probably due to all
the escape characters my output had. Resending with that cut out.

Masami, I was sent a message from gmail that it blocked this from you.

If you want to see the original email:

  https://lore.kernel.org/all/20250411151358.1d4fd8c7@gandalf.local.home/

-- Steve

On Fri, 11 Apr 2025 15:13:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 11 Apr 2025 14:31:32 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hmm, I just tested this, and it fails on my box too (I test on a debian VM).
> > 
> > It fails with and without setting it to bash. I'll take a look too.  
> 
> Hmm, maybe it is a bashism.
> 
> The test has this:
> 
>   # Max arguments limitation
>   MAX_ARGS=128
>   EXCEED_ARGS=$((MAX_ARGS + 1))
> 
>   check_max_args() { # event_header
>     TEST_STRING=$1
>     # Acceptable
>     for i in `seq 1 $MAX_ARGS`; do
>       TEST_STRING="$TEST_STRING \\$i"
>     done
>     echo "$TEST_STRING" >> dynamic_events
>     echo > dynamic_events
>     # Error
>     TEST_STRING="$TEST_STRING \\$EXCEED_ARGS"
>     ! echo "$TEST_STRING" >> dynamic_events
>     return 0
>   }
> 
>   # Kprobe max args limitation
>   if grep -q "kprobe_events" README; then
>     check_max_args "p vfs_read"
>   fi
> 
> So I tried manually executing this in bash:
> 
> --------------------------8<--------------------------
> # TEST_STRING='p vfs_read'
> # for i in `seq 1 128`; do TEST_STRING="$TEST_STRING \\$i" ; done
> # echo $TEST_STRING
> p vfs_read \1 \2

[ This  is cut out to see if it doesn't trigger gmail blocking it again! ]

> # echo "$TEST_STRING" >> /sys/kernel/tracing/dynamic_events
> # echo $?
> 0
> # cat /sys/kernel/tracing/dynamic_events
> p:kprobes/p_vfs_read_0 vfs_read arg1=\1

[ This  is cut out to see if it doesn't trigger gmail blocking it again! ]

> -------------------------->8--------------------------  
> 
> Doing the same in dash:
> 
> --------------------------8<--------------------------
> # dash
> # TEST_STRING='p vfs_read'
> # for i in `seq 1 128`; do TEST_STRING="$TEST_STRING \\$i" ; done
> # echo $TEST_STRING
> p vfs_read         \8 \9 	 

[ This  is cut out to see if it doesn't trigger gmail blocking it again! ]

> # echo "$TEST_STRING" >> /sys/kernel/tracing/dynamic_events
> dash: 8: echo: echo: I/O error
> -------------------------->8--------------------------  
> 
> Looks like dash will translate those "\#" into the ASCII equivalent,
> whereas bash does not.
> 
> This patch seems to fix it:
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> index 6b94b678741a..ebe2a34cbf92 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> @@ -11,7 +11,7 @@ check_max_args() { # event_header
>    TEST_STRING=$1
>    # Acceptable
>    for i in `seq 1 $MAX_ARGS`; do
> -    TEST_STRING="$TEST_STRING \\$i"
> +    TEST_STRING="$TEST_STRING \\\\$i"
>    done
>    echo "$TEST_STRING" >> dynamic_events
>    echo > dynamic_events
> 
> 
> Masami, you just recently added this test (it's dated March 27th 2025), did
> you mean to write in the ASCII characters? Why the backslash?
> 
> -- Steve


