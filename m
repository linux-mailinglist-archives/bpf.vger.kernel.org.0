Return-Path: <bpf+bounces-21407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C54484CC4C
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 15:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFDC28C3E8
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9174E77645;
	Wed,  7 Feb 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci39I2UM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A77993B;
	Wed,  7 Feb 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314578; cv=none; b=TbmXhD5vQWzLdCvdCuOTYp2fJj/9apqXzVMVopeQVb24XMN11S6ydhw81pDwOLYoutdfANw4OpUZmxrNR+i1ZQgNloLgaISEjGJFP+Tc8aqJZ5UDxPd20kI7/cl2SEGD5+QP0Ehwj3D5e0iBYYHH9Rd0kDSWMUUoYz/R1RiFZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314578; c=relaxed/simple;
	bh=lBxlhXxu+GabBGVYKEg2jqp2jWZlucJFL35TxJDn30g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UE2CU/kzVPcWoW7rpZRWTSFGEkFkeCw+iX8WCalTWnLdPkHxORdT4FcW8sNl77VzUo7MIcAUqOdLw+glazONX10xyvmOmC+AzLxx9ekPUAIX1japYkbWSBrJHxfzCBZmAcFflQaXYphpqqHVwm+kabvUCcex4BNIj68IdUJL+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci39I2UM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD24EC433C7;
	Wed,  7 Feb 2024 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314577;
	bh=lBxlhXxu+GabBGVYKEg2jqp2jWZlucJFL35TxJDn30g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ci39I2UM/1UznbgkKvJ+Pq/e4yXTdRC1m1r4sUF1lzDy9WHS0DHGYRF7/KYoCZ7mI
	 aAGXnGZ4KUuLDGgnz7686QIXzdnOWOjfvE6pM68IZpqtgCNJ11OXxoqAZB43Y6+oy3
	 HS+w5xemZauglfzhudqSI3/WUKl9rjo6qd01+efEnia+i7JV3eduxn6mnhqCM9TWKi
	 pjFuRS7sJBdEuUeuqHdCjTiPWseSQj7Eo8+kdX1hDG2uaWBGF7FBlPXj8ZdNTW1/ko
	 sY7WcmqeTZ9lnX0yFMekPHAikKn1SVqMkWWGO1GdHGzPitzbPS1ccz49HPhRSnC+Wi
	 p7yW5KTCcX1wQ==
Date: Wed, 7 Feb 2024 23:02:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v7 13/36] function_graph: Have the instances use their
 own ftrace_ops for filtering
Message-Id: <20240207230251.48db0dd281aa13cbc223ed25@kernel.org>
In-Reply-To: <170723219437.502590.17981699514070908579.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723219437.502590.17981699514070908579.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:09:54 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
> index 73858c9029cc..81d18b911cc1 100644
> --- a/arch/loongarch/kernel/ftrace_dyn.c
> +++ b/arch/loongarch/kernel/ftrace_dyn.c
> @@ -241,10 +241,17 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent)
>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  		       struct ftrace_ops *op, struct ftrace_regs *fregs)
>  {
> +	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
>  	struct pt_regs *regs = &fregs->regs;
>  	unsigned long *parent = (unsigned long *)&regs->regs[1];
>  
> -	prepare_ftrace_return(ip, (unsigned long *)parent);
> +	if (unlikely(atomic_read(&current->tracing_graph_pause)))
> +		return;
> +
> +	old = *parent;

Oops, this caused an error. 

> +
> +	if (!function_graph_enter_ops(old, ip, 0, parent, gops))

So this should be

if (!function_graph_enter_ops(*parent, ip, 0, parent, gops))

Thanks, 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

