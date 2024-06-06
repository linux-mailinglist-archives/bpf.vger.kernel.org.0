Return-Path: <bpf+bounces-31470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B974A8FDB2A
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 02:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B2628455F
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 00:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891151361;
	Thu,  6 Jun 2024 00:08:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5110E9;
	Thu,  6 Jun 2024 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717632536; cv=none; b=B3AE6GmenXaiRq8Wzqlirq224M+XQJzgRmneJ0W8FfUilj+ZSh//uXZX9cmnZ+VAopxxo2imX+U8xfy5f1lBU9j8GB7Mut/FoSAbtSaxHVe+qqGk2ePW7i87rVSXI76SlHK05gwW/SucLHWj/vhroXO8cfjn6WwkxHYeQGZi4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717632536; c=relaxed/simple;
	bh=7tzdPhbTiZCM9DYzG68K1j3cQKF5iq8T0TwTCJ3A8Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPP8XR2VbuSNf5T4DMAe5sVn7DdgcOE4/hB5pQRgo0wiBaVnC3RsUjSXVAaW+oBzB5fkXy2ebQr6BhO7i0FGhWAOxj1hIg4vgL65hrz4uVX06weVh/VuuRScaDHD7sK2pQQifX7HAU4SQn+z3cY9sEVr4qWmnzaRMqadqjTk5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD10C2BD11;
	Thu,  6 Jun 2024 00:08:53 +0000 (UTC)
Date: Wed, 5 Jun 2024 20:08:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 13/27] function_graph: Add pid tracing back to
 function graph tracer
Message-ID: <20240605200856.04f3ebe5@gandalf.local.home>
In-Reply-To: <20240603190822.991720703@goodmis.org>
References: <20240603190704.663840775@goodmis.org>
	<20240603190822.991720703@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Jun 2024 15:07:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +++ b/kernel/trace/ftrace.c
> @@ -100,7 +100,7 @@ struct ftrace_ops *function_trace_op __read_mostly = &ftrace_list_end;
>  /* What to set function_trace_op to */
>  static struct ftrace_ops *set_function_trace_op;
>  
> -static bool ftrace_pids_enabled(struct ftrace_ops *ops)
> +bool ftrace_pids_enabled(struct ftrace_ops *ops)
>  {
>  	struct trace_array *tr;
>  
> @@ -402,10 +402,11 @@ static void ftrace_update_pid_func(void)
>  		if (op->flags & FTRACE_OPS_FL_PID) {
>  			op->func = ftrace_pids_enabled(op) ?
>  				ftrace_pid_func : op->saved_func;
> -			ftrace_update_trampoline(op);

Bah, this patch accidentally removed the above function and broke pid
tracing. Hmm, not sure why this still passed the tests. Will investigate.

-- Steve

>  		}
>  	} while_for_each_ftrace_op(op);
>  
> +	fgraph_update_pid_func();
> +
>  	update_ftrace_function();
>  }
>  

