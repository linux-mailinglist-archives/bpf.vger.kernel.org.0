Return-Path: <bpf+bounces-53824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33CFA5C35F
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0265188BDAC
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B554725B688;
	Tue, 11 Mar 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xul0Oswn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4325B685;
	Tue, 11 Mar 2025 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702342; cv=none; b=Viw0EyyyL15Vj4TiRn3vjnKrGPfs7WpuQjC8vtRerlraLsxP8ybMo307trNWEU2fq/8xNTtHx4lDM9LQ8lJPX3ejkfprjP6p1UDbZsFyDm7B37cDl65WnjVtWw9VftkEvyt+d+mJKRKtQvPFl9XVJO2ShHUgETiOIbp7vxZCUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702342; c=relaxed/simple;
	bh=s5tTPf8M/qtOoqE+Z9Xr/jAqha+ckvdOZ+a8jimc0Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFEimG6h3Ju2hYqDrBRTkWdzQnCkVgiD4J8Wh9b1tjBzNZdscQH4T8I1t7JMf4IAGWFQ+ZWAKQZ8AOUDjEmdHDyz9Ei/WpM+bZqRPC34xIKIFa5MVd0I5GSVLVVk6BDyiuFgU5vr+QmI37VPJ3ZiZ6Qsm122L/g/3hQBnpnRZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xul0Oswn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F408C4CEE9;
	Tue, 11 Mar 2025 14:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741702341;
	bh=s5tTPf8M/qtOoqE+Z9Xr/jAqha+ckvdOZ+a8jimc0Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xul0Oswng8OAYUFcawvPSaIWfdo5VVFNJZlHB2L2mgvk5pYP3FsTvU2o32nZVmwb3
	 vBG9PH5p5LAs4UeGQYGm2G+z+9NCb+q+UGVwbsASQV1PE6QR+Qjx9mKKECsHb9rCC5
	 teocnBstL2/me4zfoVEKWm1SSC7+uLw6poyEhb0I=
Date: Tue, 11 Mar 2025 15:12:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Florent Revest <revest@chromium.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 102/207] fprobe: Rewrite fprobe on function-graph
 tracer
Message-ID: <2025031155-alabaster-sudoku-61c8@gregkh>
References: <20250310170447.729440535@linuxfoundation.org>
 <20250310170451.816958751@linuxfoundation.org>
 <a66df96f-2280-49c0-875c-7cca4b4a6a71@kernel.org>
 <8ea06b5e-ec85-42e5-a2e9-9ad747fef217@kernel.org>
 <76c5a00f-ae15-43b8-a917-093ca63cc396@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76c5a00f-ae15-43b8-a917-093ca63cc396@kernel.org>

On Tue, Mar 11, 2025 at 10:56:26AM +0100, Jiri Slaby wrote:
> On 11. 03. 25, 10:49, Jiri Slaby wrote:
> > On 11. 03. 25, 10:46, Jiri Slaby wrote:
> > > On 10. 03. 25, 18:04, Greg Kroah-Hartman wrote:
> > > > 6.13-stable review patch.  If anyone has any objections, please
> > > > let me know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > 
> > > > [ Upstream commit 4346ba1604093305a287e08eb465a9c15ba05b80 ]
> > > ...
> > > > --- a/kernel/trace/Kconfig
> > > > +++ b/kernel/trace/Kconfig
> > > > @@ -302,11 +302,9 @@ config DYNAMIC_FTRACE_WITH_ARGS
> > > >   config FPROBE
> > > >       bool "Kernel Function Probe (fprobe)"
> > > > -    depends on FUNCTION_TRACER
> > > > -    depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
> > > > -    depends on HAVE_FTRACE_REGS_HAVING_PT_REGS || !
> > > > HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > > > -    depends on HAVE_RETHOOK
> > > > -    select RETHOOK
> > > > +    depends on HAVE_FUNCTION_GRAPH_FREGS && HAVE_FTRACE_GRAPH_FUNC
> > > 
> > > HAVE_FTRACE_GRAPH_FUNC does not exist on 6.13, so FPROBE is
> > > effectively disabled by this backport.
> > > 
> > > Is this missing (and only this?):
> > > commit a762e9267dca843ced943ec24f20e110ba7c8431
> > > Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Date:   Thu Dec 26 14:13:34 2024 +0900
> > > 
> > >      ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
> > 
> > With this applied, x86_64 is fixed. But ppc and s390 still loose it.
> 
> 
> HAVE_FTRACE_GRAPH_FUNC is missing in ppc completely in upstream too (a
> bug?).
> 
> s390 has it only through (here omitted):
> commit 7495e179b478801433cec3cc4a82d2dcea35bf06
> Author: Sven Schnelle <svens@linux.ibm.com>
> Date:   Thu Dec 26 14:13:48 2024 +0900
> 
>     s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC

Yeah, this isn't right.  I've dropped all of these from the queue now,
thanks for the review!

greg k-h

