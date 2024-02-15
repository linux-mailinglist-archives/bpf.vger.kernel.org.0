Return-Path: <bpf+bounces-22089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE78856812
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 16:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6121C23966
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7D91350C8;
	Thu, 15 Feb 2024 15:38:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D3133986;
	Thu, 15 Feb 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011492; cv=none; b=KaXoYzD/rXT8ca4R/T55INAUy16XB5Q5YXS11PqwzgFTjVMKFV7pc9PW+hJrNkk7mSPJAsvXoaNw/HRExpbvpm37ajZsBeugRl3wAzYlomBgMuI5NpK8Q0epU2qygtUVpAlnHSPWk4CfquTwyUieExO7ZEG5tdKf8lzaS2Jyj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011492; c=relaxed/simple;
	bh=TumCFW1aFpP3pgtyEWBPJcmutNYn4tcHjopz/llMrqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMcnyxwqTWGyioD5toaEfbhRHDHjUORWrjA21FTed7Xb2xj9XzIuVr+tgEGa7QSm/2Z+qUhvlbqyStZlF8ettuNIPCyco/2MRj3USMT1/JyexXDQE4PUK5PiL3re4HqPs/s4ohRnHfON0VNK/+6nH6ScajBiNN/NRVf+FPjjV2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A01C43390;
	Thu, 15 Feb 2024 15:38:10 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:39:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Message-ID: <20240215103943.7bf1a30f@gandalf.local.home>
In-Reply-To: <170723230476.502590.16817817024423790038.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723230476.502590.16817817024423790038.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:11:44 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a new return handler to fgraph_ops as 'retregfunc'  which takes
> parent_ip and ftrace_regs instead of ftrace_graph_ret. This handler
> is available only if the arch support CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> Note that the 'retfunc' and 'reregfunc' are mutual exclusive.
> You can set only one of them.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

> @@ -1076,6 +1083,7 @@ struct fgraph_ops {
>  	trace_func_graph_ent_t		entryfunc;
>  	trace_func_graph_ret_t		retfunc;
>  	trace_func_graph_regs_ent_t	entryregfunc;
> +	trace_func_graph_regs_ret_t	retregfunc;

Same for this:

struct fgraph_ops {
	union {
		trace_func_graph_ent_t		entryfunc;
		trace_func_graph_regs_ent_t	entryregfunc;
	};
	union {
		trace_func_graph_ret_t		retfunc;
		trace_func_graph_regs_ret_t	retregfunc;
	}

-- Steve


>  	struct ftrace_ops		ops; /* for the hash lists */
>  	void				*private;
>  	int				idx;

