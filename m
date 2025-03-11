Return-Path: <bpf+bounces-53870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B05A5D368
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 00:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865FD189C80B
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 23:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B362343CF;
	Tue, 11 Mar 2025 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izHoZ4yA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6A225764;
	Tue, 11 Mar 2025 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741737185; cv=none; b=LMfXPNjRyS2AdYUKpkMavDjE/OppIOXSJukMCA6TDeSgw2ax9FyZRieSiU7b0/iLPTF9iCXITVzjojKimKeYXVN5aNiGVg6jl9cB2NAYgOewhG/gAaoL58AscZg51y4zXHwX3Xaxr4/AtuJ/OVs/t1QUrXSNX6CUt7WdwVFSIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741737185; c=relaxed/simple;
	bh=ZDuIKhAOKv7u0D1U/ggHIkVzURa64HpNYfBlBsMwXlQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g5vhMDoQl8I0PGJJx3JOTo8z3Ph1wS+c0uFXXCV5WpRxf2W9jketuMI76ulaVS1vJI6ukHjBXUDfXg8Fget0hiKD34hCiel7xOPLLOpT+339MroVYj+JbkYo/VHzKJfMRuU7ykku9H0nD35ShBbC3qVuglFSHHL3qKu1BzpRpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izHoZ4yA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15ECAC4CEE9;
	Tue, 11 Mar 2025 23:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741737184;
	bh=ZDuIKhAOKv7u0D1U/ggHIkVzURa64HpNYfBlBsMwXlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=izHoZ4yA1A/BhXuUkOOUz5waOFa0sXQLSocZnkYUoDcXctHcRPvB9n5Qkq6FzyLnY
	 nysVn9evKLogtFdTzEa2H9LN3DIa0l+z0bgrsjcCuwv49iEAcwWJ7N4APQim107ku6
	 Lc20pFn5ldtSaDzKcaKMSYkB/+2Zu1pcfZN98dhdEjfEwYZuYCu0GtVsCKLl/dGazd
	 btLFuYa+awHnH+98ZYFLBuyqj/Hq3hbZDuLCjCH0U11ZLakOxGGFR+DlyIMEDVDU3J
	 MgfNZfOQE9ASKA0mbK7SmwLsGIWA6zm4FmOdeb/+Id2gz1lNsSXmYARP2o11fRSR+x
	 WRnwTz9nUGhYw==
Date: Wed, 12 Mar 2025 08:52:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, Martin KaFai Lau <martin.lau@linux.dev>, bpf
 <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Heiko Carstens
 <hca@linux.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 102/207] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20250312085253.99bef5db821c71b1bc4f3614@kernel.org>
In-Reply-To: <2025031155-alabaster-sudoku-61c8@gregkh>
References: <20250310170447.729440535@linuxfoundation.org>
	<20250310170451.816958751@linuxfoundation.org>
	<a66df96f-2280-49c0-875c-7cca4b4a6a71@kernel.org>
	<8ea06b5e-ec85-42e5-a2e9-9ad747fef217@kernel.org>
	<76c5a00f-ae15-43b8-a917-093ca63cc396@kernel.org>
	<2025031155-alabaster-sudoku-61c8@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 15:12:13 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Mar 11, 2025 at 10:56:26AM +0100, Jiri Slaby wrote:
> > On 11. 03. 25, 10:49, Jiri Slaby wrote:
> > > On 11. 03. 25, 10:46, Jiri Slaby wrote:
> > > > On 10. 03. 25, 18:04, Greg Kroah-Hartman wrote:
> > > > > 6.13-stable review patch.  If anyone has any objections, please
> > > > > let me know.
> > > > > 
> > > > > ------------------
> > > > > 
> > > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > 
> > > > > [ Upstream commit 4346ba1604093305a287e08eb465a9c15ba05b80 ]
> > > > ...
> > > > > --- a/kernel/trace/Kconfig
> > > > > +++ b/kernel/trace/Kconfig
> > > > > @@ -302,11 +302,9 @@ config DYNAMIC_FTRACE_WITH_ARGS
> > > > >   config FPROBE
> > > > >       bool "Kernel Function Probe (fprobe)"
> > > > > -    depends on FUNCTION_TRACER
> > > > > -    depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
> > > > > -    depends on HAVE_FTRACE_REGS_HAVING_PT_REGS || !
> > > > > HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > > > > -    depends on HAVE_RETHOOK
> > > > > -    select RETHOOK
> > > > > +    depends on HAVE_FUNCTION_GRAPH_FREGS && HAVE_FTRACE_GRAPH_FUNC
> > > > 
> > > > HAVE_FTRACE_GRAPH_FUNC does not exist on 6.13, so FPROBE is
> > > > effectively disabled by this backport.
> > > > 
> > > > Is this missing (and only this?):
> > > > commit a762e9267dca843ced943ec24f20e110ba7c8431
> > > > Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > Date:   Thu Dec 26 14:13:34 2024 +0900
> > > > 
> > > >      ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
> > > 
> > > With this applied, x86_64 is fixed. But ppc and s390 still loose it.
> > 
> > 
> > HAVE_FTRACE_GRAPH_FUNC is missing in ppc completely in upstream too (a
> > bug?).
> > 
> > s390 has it only through (here omitted):
> > commit 7495e179b478801433cec3cc4a82d2dcea35bf06
> > Author: Sven Schnelle <svens@linux.ibm.com>
> > Date:   Thu Dec 26 14:13:48 2024 +0900
> > 
> >     s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
> 
> Yeah, this isn't right.  I've dropped all of these from the queue now,
> thanks for the review!
> 

Thanks Jiri and Greg! BTW, I wonder why this had been backported?
I think this has no Fixes tag. maybe dependencies?

Thank you,

> greg k-h


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

