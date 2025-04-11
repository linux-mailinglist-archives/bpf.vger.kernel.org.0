Return-Path: <bpf+bounces-55751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010BDA863A9
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A199C007E
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7EC23315B;
	Fri, 11 Apr 2025 16:44:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A215233148;
	Fri, 11 Apr 2025 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389872; cv=none; b=XZdS3A+p2GuWCHqiVJlD3lhocReqZsLgQjUm6FZm3X+NYUw1ljj7DzM/8VOQu0iHJViXV7a+6OD2CH4TYFTi8QhN+nfpjt4ArI8mxS6hji8f+/Qst0MZdB1CDwb82jCwwt/C0qdcFCUgtyQyhGAxmQ6ZHPqRA/TFefx3lYYw0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389872; c=relaxed/simple;
	bh=L/mb+QQWwTatT5L5Nejifp0o/+LSgqAg5l4QjS3xCZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piROzL/mhdaIcJ2oeFz1SgzZjMIzKt28Eq43rP4CqHa3Ez+kTpIxPi++AOo1C5IGWtW/aJ4mOTE7z0etQeTFE35239d9/dXeUazjy8mdGIMQAaI5+8l33s88ceeh5U9hA1PEx+gmRFEb0bxx2oKYtMW2E3ST+wa8lDDqj1p8KW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38296C4CEED;
	Fri, 11 Apr 2025 16:44:30 +0000 (UTC)
Date: Fri, 11 Apr 2025 12:45:52 -0400
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
Message-ID: <20250411124552.36564a07@gandalf.local.home>
In-Reply-To: <c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
References: <20250227185804.639525399@goodmis.org>
	<20250227185822.810321199@goodmis.org>
	<ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
	<20250410131745.04c126eb@gandalf.local.home>
	<c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 14:00:40 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Apr 10, 2025 at 01:17:45PM -0400, Steven Rostedt wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> 
> > > We've been seeing the PID filters selftest failing for a while on
> > > several arm64 systems, a bisect I managed to run without running into
> > > any confounding issues pointed to this patch which is in mainline as
> > > ff5c9c576e75.  It's in the ftrace code, but I'm not immediately seeing
> > > the relevance.  Output from a failing run:  
> 
> > Hmm, I wonder if there's junk being added into the trace.  
> 
> > Can you add this patch, and show me the output when it fails again?  
> 

Can you show the information before this output, to see what it is actually
testing?

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
> # # 
> # # + fail PID filtering not working?
> 
> ...
> 
> # # + cat trace
> # # # tracer: function_graph
> # # #
> # # # CPU  TASK/PID         DURATION                  FUNCTION CALLS
> # # # |     |    |           |   |                     |   |   |   |
> # # 0) ftracet-12279  | ! 598.118 us  |  kernel_clone(); /* ret=0x301f */
> # # 
> # # 0) ftracet-12279  | ! 492.539 us  |  kernel_clone(); /* ret=0x3020 */
> # # 
> # # 0) ftracet-12279  | ! 231.104 us  |  kernel_clone(); /* ret=0x3025 */
> # # 
> # # 0) ftracet-12279  | ! 555.566 us  |  kernel_clone(); /* ret=0x302a */
> # # 
> # # + fail PID filtering not working?

Also, is it possible to just enable function_graph tarcing and see if it
adds these blank lines between events?

-- Steve

