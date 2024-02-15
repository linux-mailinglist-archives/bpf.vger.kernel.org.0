Return-Path: <bpf+bounces-22090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 571CE85688E
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 16:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B154B30000
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3C81350F7;
	Thu, 15 Feb 2024 15:47:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12581350EB;
	Thu, 15 Feb 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012052; cv=none; b=OwHilvhpnfoSWsAokIeE/S81x1pjcLVWVjAYrYosH6ET+D/477WKghNy6ilPtQXCXAR8oHjGE8KTe9VZ1+izfW7nQxMmlNSvOXuyJ23DqKQ+Mv2XG00KwR731iIgxmodW5X23Um8vCKjG8tJ6FlP/syXvkYcb/0uRd95pVQyTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012052; c=relaxed/simple;
	bh=Hf6bxPRQvD+7VIPH9p9o2Rf3WPdCnp1+WDDxFKezXeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8BzV/w8AfJ9om5j8yP3nHjqgvCVhTwVsCfm5hQu6xiM792NS+7hNwzNSnhRdM4vtaww8gLWbL+TuZJ8j5HIvft7JePoUkKpFQFT1xu4ZWTYjgvw8YSSAhliVkmGa1EXWyQjdPBnWy1sL2C6zMcEAosBIPh2SPuDnQfbFLWWx6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D42C433C7;
	Thu, 15 Feb 2024 15:47:30 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:49:03 -0500
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
Message-ID: <20240215104903.09bb3765@gandalf.local.home>
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

> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 61c541c36596..308b3bec01b1 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -34,6 +34,9 @@ config HAVE_FUNCTION_GRAPH_TRACER
>  config HAVE_FUNCTION_GRAPH_RETVAL
>  	bool
>  
> +config HAVE_FUNCTION_GRAPH_FREGS
> +	bool
> +
>  config HAVE_DYNAMIC_FTRACE
>  	bool
>  	help

We're starting to get overloaded with the CONFIG_HAVE_* options.

We need to start consolidating them. I would like to make RETVAL and FREGS
into one option. We can add this now, but before we add anything else, we
need to see what HAVE configs have the same archs, and then just
consolidate them. If an new arch wants to add one of the consolidated
features, it will also need to add all the other features that were
consolidated with it.

-- Steve

