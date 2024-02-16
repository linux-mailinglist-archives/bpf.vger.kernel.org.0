Return-Path: <bpf+bounces-22136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D968577E6
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 09:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223611C21095
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518941B80C;
	Fri, 16 Feb 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNY7Iitu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C01CA82;
	Fri, 16 Feb 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072984; cv=none; b=tiL8mrlylDDeF8SusNHda49NSebnbEy5tu0hZwqsOAocKkVedS6xiMtrKWbHJdnahJC/krssyXEYDh2akimXbJn8/e0esifnGStNLldhNYN7jYp6tuWdR4tlNxDV7kLB5apLB//6K8JBSbEIP0esnnUVS2jtkwviyVwVYclcG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072984; c=relaxed/simple;
	bh=dUyFnkE/QREvSXvoA/9ltiM5n+QJkG7a2KgN3eMQWrM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TlyUy8R5DgpaR++cndd9fpRZg54qwQxNd6EnsOHOoYgTr/YMWmO76C/zcSI23ZVu38JvI8i9Ukkw3q+rPdeMagCCruo+RI11YjkQ+a7V+dkBl8xZXMGZtGszhhkLTWXyZQv3HEDni+Y8FCPxTGH9D++Vc2ROXcfzgyLG+IujbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNY7Iitu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C59CC433F1;
	Fri, 16 Feb 2024 08:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708072984;
	bh=dUyFnkE/QREvSXvoA/9ltiM5n+QJkG7a2KgN3eMQWrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZNY7IitueSf4Jo40A5T3r2tLfB4Crt2LsbWM7e552jBU8xqCeYRmdwzrbl4Uw8Wmy
	 Rm/cNBZigbKHjxIdJrP0/HiXKbsrKJPtW6tlWy5Q4apD/vV3HG3giX329DLsjxhVbS
	 VHbyJn1C2EzkaO+lz7OwhbSytyuQ2jS230IUtsy0eJPUPNoYzFLbowlGgPndSLCukO
	 zK2W0X4K5ibVH5XR01QuvMgb6RLrKhqHjBBvUiORaFopJ0S65E+hkuV53n2BrUxedD
	 uYTBwVh79HUW0hYHm6gzF/DWLdXrkf+7NLInT7wtXYNksAYbYukhGx/Kt38Oa7X8WO
	 HbxoD0XCPkYNQ==
Date: Fri, 16 Feb 2024 17:42:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v7 23/36] function_graph: Add a new exit handler with
 parent_ip and ftrace_regs
Message-Id: <20240216174226.455472a436b40bbf2fd4ee4b@kernel.org>
In-Reply-To: <20240215103943.7bf1a30f@gandalf.local.home>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723230476.502590.16817817024423790038.stgit@devnote2>
	<20240215103943.7bf1a30f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 10:39:43 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  7 Feb 2024 00:11:44 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add a new return handler to fgraph_ops as 'retregfunc'  which takes
> > parent_ip and ftrace_regs instead of ftrace_graph_ret. This handler
> > is available only if the arch support CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> > Note that the 'retfunc' and 'reregfunc' are mutual exclusive.
> > You can set only one of them.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> 
> > @@ -1076,6 +1083,7 @@ struct fgraph_ops {
> >  	trace_func_graph_ent_t		entryfunc;
> >  	trace_func_graph_ret_t		retfunc;
> >  	trace_func_graph_regs_ent_t	entryregfunc;
> > +	trace_func_graph_regs_ret_t	retregfunc;
> 
> Same for this:
> 
> struct fgraph_ops {
> 	union {
> 		trace_func_graph_ent_t		entryfunc;
> 		trace_func_graph_regs_ent_t	entryregfunc;
> 	};
> 	union {
> 		trace_func_graph_ret_t		retfunc;
> 		trace_func_graph_regs_ret_t	retregfunc;
> 	}

OK, and we need to introduce a flag for fgraph_ops that it is using
`regfunc` or not.

Thank you,

> 
> -- Steve
> 
> 
> >  	struct ftrace_ops		ops; /* for the hash lists */
> >  	void				*private;
> >  	int				idx;


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

