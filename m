Return-Path: <bpf+bounces-22088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C9856807
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F4E1C23383
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 15:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EF213343E;
	Thu, 15 Feb 2024 15:36:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883B1132481;
	Thu, 15 Feb 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011416; cv=none; b=gWM1VSsX5fnW+LUHuyPEI4UClnkR+9fPtbNWH3uBlYaMlgoAaVDH/clKxgdy5KhT73ak5Cr0b7qiJ/uEWxGLr7ADlpKvKwyDYY7bndwvYjroQqhdtlMZnsIyjchXYVP5PbsrkmtxO2GOs6dy2xjdewo5otnZ5103G2mBV7EgyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011416; c=relaxed/simple;
	bh=RRjgbqQNeV1LQqQ3WnLweLVY4UkjS1hhaS8MNsvQOJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgwxtWELGTVUvaasL6mVwQgm9+JqE3vIHMc2mMkMsETF8ukaDs7oz9khSgkKmt/qSEClCUwVu2KnjxOFu+jcvsUiDIG+KayaZ2h5bIZ8xJrkt3AsBbemWG72mF4HorudmOR036eAS0qzO3TGHSF4hIjDbHRjX4sQIOunLZB1+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C5DC433C7;
	Thu, 15 Feb 2024 15:36:54 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:38:27 -0500
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
Subject: Re: [PATCH v7 22/36] function_graph: Add a new entry handler with
 parent_ip and ftrace_regs
Message-ID: <20240215103827.2c7bd2bf@gandalf.local.home>
In-Reply-To: <170723229401.502590.8644663781359457778.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723229401.502590.8644663781359457778.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:11:34 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a new entry handler to fgraph_ops as 'entryregfunc'  which takes
> parent_ip and ftrace_regs. Note that the 'entryfunc' and 'entryregfunc'
> are mutual exclusive. You can set only one of them.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> @@ -1070,6 +1075,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
>  struct fgraph_ops {
>  	trace_func_graph_ent_t		entryfunc;
>  	trace_func_graph_ret_t		retfunc;
> +	trace_func_graph_regs_ent_t	entryregfunc;

if entryfunc and entryregfunc are mutually exclusive, then why not make them
into a union?

struct fgraph_ops {
	union {
		trace_func_graph_ent_t		entryfunc;
		trace_func_graph_regs_ent_t	entryregfunc;
	};
	trace_func_graph_ret_t		retfunc;

-- Steve

	

>  	struct ftrace_ops		ops; /* for the hash lists */
>  	void				*private;
>  	int				idx;

