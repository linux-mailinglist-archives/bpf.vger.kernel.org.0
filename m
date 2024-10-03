Return-Path: <bpf+bounces-40872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E1998F8F5
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 23:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056EC1F21F35
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 21:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFBB1B85FF;
	Thu,  3 Oct 2024 21:31:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44D748D;
	Thu,  3 Oct 2024 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991093; cv=none; b=cVKCz+G/nYuL34aWG5S+CCEMWS1zK2WBikBXou2XhrI8ElKRbCBDQVMHfPpzZKCvV/UY4Ko+TYiA9I+eCEHoyYKjMMtA3OVxPirL1qFR5LQYxDPRaejzGCsDQGnXk1WYckuh1CzeLe3D3+r0vu+4td883UsIrJhwdg+4bmT8IpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991093; c=relaxed/simple;
	bh=QfpYuP1+lNzEdLBBAmnAhuQBWTzGY0NwNEYJZmZtG90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snUlXV0GiBqC2mvlw8O4RW9uocbAKzNtljVfq6+iaRuzsIY4JQZXykLpEKl428TqKqF1PHvzRMvLzJqn8L5pe3OFNN/+YC0UiCXxreBiECQID/bkqVCgjym6JL23T7Meq7xdLgNrlkDsN69kiFqDJWG4IOl5RHXTDZCPXUQtfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F10EC4CEC5;
	Thu,  3 Oct 2024 21:31:30 +0000 (UTC)
Date: Thu, 3 Oct 2024 17:32:25 -0400
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
 Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH v1 1/8] tracing: Declare system call tracepoints with
 TRACE_EVENT_SYSCALL
Message-ID: <20241003173225.7670a4f0@gandalf.local.home>
In-Reply-To: <20241003151638.1608537-2-mathieu.desnoyers@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-2-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 11:16:31 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> @@ -283,8 +290,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  				  "RCU not watching for tracepoint");	\
>  		}							\
>  	}								\
> -	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
> -			    PARAMS(cond))				\
> +	static inline void trace_##name##_rcuidle(proto)		\
> +	{								\
> +		if (static_key_false(&__tracepoint_##name.key))		\
> +			__DO_TRACE(name,				\
> +				TP_ARGS(args),				\
> +				TP_CONDITION(cond), 1);			\
> +	}								\
>  	static inline int						\
>  	register_trace_##name(void (*probe)(data_proto), void *data)	\
>  	{								\

Looking at this part of your change, I realized it's time to nuke the
rcuidle() variant.

Feel free to rebase on top of this patch:

  https://lore.kernel.org/all/20241003173051.6b178bb3@gandalf.local.home/

-- Steve

