Return-Path: <bpf+bounces-31352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF08FB8FD
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 18:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479D32824C4
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F6414830B;
	Tue,  4 Jun 2024 16:31:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C0A8F6C;
	Tue,  4 Jun 2024 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518687; cv=none; b=C5Nm26iSdyrt5+VgvIpZ6Qpr9miSS66C9lKihbXpwBuVBMob0lwQeXQeJhLcvvtNIdyP9jMX2DpLHfbnExOm97D1uFJeeql7GEw7XtHYtSXi/DVAkrF8wHuqRWBYbPq2VHL9qV09z1+VaeQ6jLAOgSmxAVkp5xHgHp5M4ZMlASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518687; c=relaxed/simple;
	bh=goD58epB5eWbLQiw9SXNOQ0RYoZ4dDRcRSIUQ2Ndgu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxaW0tHPoXAFEDFEyN2fdpFEoUjs3YsapR9A3N+ikI/MSodb0LSDH7P9aWSht1CLdlisrXNUrKxHnXgF634FLvODXiasplyrM6+D3BvW1Cvodzcc2HVRiiiofIxZ5JKgHtlOcdw1JYxBGjVpjNkpfQN6YTHqS/+1D63rpDdXU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE72C2BBFC;
	Tue,  4 Jun 2024 16:31:24 +0000 (UTC)
Date: Tue, 4 Jun 2024 12:31:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 00/27] function_graph: Allow multiple users for
 function graph tracing
Message-ID: <20240604123124.456d19cf@gandalf.local.home>
In-Reply-To: <Zl8oWNhkEPleJ3B_@J2N7QTR9R3>
References: <20240603190704.663840775@goodmis.org>
	<20240604081850.59267aa9@rorschach.local.home>
	<Zl8oWNhkEPleJ3B_@J2N7QTR9R3>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 15:44:40 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Steve, Masami,
> 
> On Tue, Jun 04, 2024 at 08:18:50AM -0400, Steven Rostedt wrote:
> > 
> > Masami,
> > 
> > This series passed all my tests, are you comfortable with me pushing
> > them to linux-next?  
> 
> As a heads-up (and not to block pushing this into next), I just gave
> this a spin on arm64 atop v6.10-rc2, and running the selftests I see:
> 
> 	ftrace - function pid filters
> 	(instance)  ftrace - function pid filters
> 
> ... both go from [PASS] to [FAIL].
> 
> Everything else looks good -- I'll go dig into why that's happening.
> 
> It's possible that's just something odd with the filesystem I'm using
> (e.g. the wnership test failed because this lacks 'stat').

Thanks for the update. I could be something I missed in patch 13 that had
to put back the pid code.

There may have been something arch specific that I'm unaware about. I'll
look at that deeper.

-- Steve

