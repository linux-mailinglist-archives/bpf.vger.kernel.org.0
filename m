Return-Path: <bpf+bounces-55759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E8AA86462
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EEE17BB24
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E964222595;
	Fri, 11 Apr 2025 17:11:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0EA221DB3;
	Fri, 11 Apr 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391492; cv=none; b=OTi12D3HzXxKh5XmSh1E2O4bZ9GkvHLNvkD/PNJzMTvLrwEdWEgTBJvhiSvVLkMm7DfUR59lc44AfcC+FGNINDuzOIra/Oa2P4AwtoiN2O2OSvhwFT1Fog9dQsMg0/DheMIp4mQCbDJigarES4zHJvIDnsv3EST8zMlhi8cL9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391492; c=relaxed/simple;
	bh=BiAve9al5LDiCb8Dy9WpZ7PL+zzjdXGewisDWrORLt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxQ3nyT76X2CE17aAr8dMJo9MTA2rRAWxRTsqlch5zSsZkh+SfDEX8Kmvgyhkkiy/tF9ydNCBCnaa44BaFF8Tmg4kn2jInXShSDUG5dgmYdyqS7lAq5LgPW4djWJPkt11H5R2RsH9w5NzlzJo43yXuzppa2BG2uEaI2mNLKEQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2AFC4CEE2;
	Fri, 11 Apr 2025 17:11:30 +0000 (UTC)
Date: Fri, 11 Apr 2025 13:12:54 -0400
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
Message-ID: <20250411131254.3e6155ea@gandalf.local.home>
In-Reply-To: <2edc0ba8-2f45-40dc-86d9-5ab7cea8938c@sirena.org.uk>
References: <20250227185804.639525399@goodmis.org>
	<20250227185822.810321199@goodmis.org>
	<ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
	<20250410131745.04c126eb@gandalf.local.home>
	<c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
	<20250411124552.36564a07@gandalf.local.home>
	<2edc0ba8-2f45-40dc-86d9-5ab7cea8938c@sirena.org.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 17:58:32 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Apr 11, 2025 at 12:45:52PM -0400, Steven Rostedt wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> > > On Thu, Apr 10, 2025 at 01:17:45PM -0400, Steven Rostedt wrote:  
> 
> > > > Hmm, I wonder if there's junk being added into the trace.    
> 
> > > > Can you add this patch, and show me the output when it fails again?    
> 
> > Can you show the information before this output, to see what it is actually
> > testing?  
> 
> Here's a bit more of the context - this is literally just the ftrace
> selftests so it'll be doing whatever that does, there's a huge amount of
> log splat generated when enumerating all the triggers.  I do note that
> it appears to assume there's a ping binary which might confusing things,
> though I'm surprised that'd be a regression rather than something that
> just never worked:

Thanks, even though I figured it out...

> # # + yield
> # # + ping 127.0.0.1 -c 1
> # # ./ftracetest: 179: /opt/kselftest/ftrace/test.d/ftrace/func-filter-pid.tc: ping: not found

The ping was just a way to add some extra noise, as sometimes, the system
just went totally idle, and nothing else showed up.

> # # + sleep .001
> # # + cat trace
> # # + grep -v ^#
> # # + grep 5190
> # # + wc -l
> # # + count_pid=2
> # # + cat trace
> # # + grep -v ^#
> # # + grep -v 5190
> # # + wc -l
> # # + count_other=3

This is what I was looking for. The "count_other" is the number of lines of
output that wasn't due to a '#' or something with '5190'.

> # # + [ 2 -eq 0 -o 3 -ne 0 ]

And it was expecting zero.

> # # + cat trace
> # # # tracer: function_graph
> # # #
> # # # CPU  TASK/PID         DURATION                  FUNCTION CALLS
> # # # |     |    |           |   |                     |   |   |   |
> # # 0)  ftracet-5190  | ! 537.633 us  |  kernel_clone(); /* ret=0x1470 */
> # # 
> # # 0)  ftracet-5190  | ! 508.253 us  |  kernel_clone(); /* ret=0x1471 */
> # # 
> # # 0)  ftracet-5190  | ! 215.716 us  |  kernel_clone(); /* ret=0x1476 */
> # # 
> # # 0)  ftracet-5190  | ! 493.890 us  |  kernel_clone(); /* ret=0x147b */

But it found 3 blank lines!

> That'll take a bit more arranging, I'm running these tests as batch jobs
> in CI infrastructure.  I'll try to have a look.  The only other test
> that actually failed was:
> 
> # not ok 25 Checking dynamic events limitations
> 
> which isn't flagged as a regression (there's some other UNRESOLVED ones).

Hmm, don't know about that one.

-- Steve


