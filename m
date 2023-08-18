Return-Path: <bpf+bounces-8060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EA8780A99
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 12:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA052822A0
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 10:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6864B182A7;
	Fri, 18 Aug 2023 10:59:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3277A14F61
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 10:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C15C433C8;
	Fri, 18 Aug 2023 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692356381;
	bh=SE01vkZvNrOCsRm/er4z+F222drSCyqwBYJhfrWSbPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mWE8gEwT+A3q3KwmI1jlPKqm/1u4mg+AE4cnwOdbL41KQYAFd4eo3oxfb3ntyLNhq
	 6TwThv3Vs4evhwQl5naZnp1KIbx+bwl+bdQ/OMuiF4z9Vgdw8kwjtgcvRSUktdLUCc
	 N+AdpuWaIuO9kTG9dWt+QYlRCEK3zLTWCho1MimVcCg7XE688k307n53F7NH+SwXg/
	 C46Hz5hj3wtNNi1rxEZYk2w7X4FjTUZ3COJk8VYso+8MOpDz0N5bUw/KVoycRl9qAz
	 hwQ5LqDBWctw4NyCpx7IHyJrV+gji0/41fP1S4gJT2aDX2qtjVbZKPZbLLLO1a1SKG
	 UjQ+KBvAqoPsw==
Date: Fri, 18 Aug 2023 19:59:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Florent Revest <revest@chromium.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 3/8] tracing: Expose ftrace_regs regardless of
 CONFIG_FUNCTION_TRACER
Message-Id: <20230818195935.b03b191c9d453e483eb72269@kernel.org>
In-Reply-To: <CABRcYm+i1PqVNUC_Hf2wsUdw8Gz-kap9YQ1zFwKKXjb7hp11bg@mail.gmail.com>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
	<169181863118.505132.13233554057378608176.stgit@devnote2>
	<CABRcYm+i1PqVNUC_Hf2wsUdw8Gz-kap9YQ1zFwKKXjb7hp11bg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 17 Aug 2023 10:57:34 +0200
Florent Revest <revest@chromium.org> wrote:

> On Sat, Aug 12, 2023 at 7:37 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > In order to be able to use ftrace_regs even from features unrelated to
> > function tracer (e.g. kretprobe), expose ftrace_regs structures and
> > APIs even if the CONFIG_FUNCTION_TRACER=n.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Acked-by: Florent Revest <revest@chromium.org>

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

