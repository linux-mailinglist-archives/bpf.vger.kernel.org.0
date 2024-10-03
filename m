Return-Path: <bpf+bounces-40882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E9698F9F3
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52891F2373C
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C9A1CDFD0;
	Thu,  3 Oct 2024 22:37:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631491CC159;
	Thu,  3 Oct 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995059; cv=none; b=VbQn68kSL6aOBgvwjwICrytl5jzs8z7S+9novm0rWPZVTdZcVgARVPb1r3ei2QX3d5p6u+j72hTctk5WXeKQLbfc5i+/mid4fyIlKf2tVcYL0/X4d1cJ/wp3Y/3tAnsK/N1zNHLW4pll2AdEuajBCmqasxVnpMmg8cTo3Rp+D0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995059; c=relaxed/simple;
	bh=aWOWsKOqJcRgMcWIVEktpgqJpsx0OOr0bf48J9P0VDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8YPQ33WhP0uH7XxkfkgEiWm6Yj9CfHQ3XMHHH/3zFCOsttZbyQe6Z6YCDCUG/3vcdzdVm5blwHnls/fLE8FgoeVf/zV+k+n0s4AFnnLZ0NGE50V8GZ8Nx7X4rbCtdz1G4IHRvHTppST4ZMmdaKBl+qZymgwWeur18qtyZu+eno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C2EC4CEC5;
	Thu,  3 Oct 2024 22:37:36 +0000 (UTC)
Date: Thu, 3 Oct 2024 18:38:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>
Subject: Re: [PATCH v1 8/8] tracing/bpf: Add might_fault check to syscall
 probes
Message-ID: <20241003183830.16155ec3@gandalf.local.home>
In-Reply-To: <20241003151638.1608537-9-mathieu.desnoyers@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-9-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 11:16:38 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Add a might_fault() check to validate that the bpf sys_enter/sys_exit
> probe callbacks are indeed called from a context where page faults can
> be handled.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Tested-by: Andrii Nakryiko <andrii@kernel.org> # BPF parts
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  include/trace/bpf_probe.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 211b98d45fc6..099df5c3e38a 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -57,6 +57,7 @@ __bpf_trace_##call(void *__data, proto)					\
>  static notrace void							\
>  __bpf_trace_##call(void *__data, proto)					\
>  {									\
> +	might_fault();							\

And I think this gets called at places that do not allow faults.

-- Steve

>  	guard(preempt_notrace)();					\
>  	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
>  }


