Return-Path: <bpf+bounces-41307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C63995B84
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C777F281FA5
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD31218588;
	Tue,  8 Oct 2024 23:19:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F8217307;
	Tue,  8 Oct 2024 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429596; cv=none; b=ka7cNG9KaPkJsDRyzkUQFLk+/68/8lKfgBojmv4RucSjQhx7tP5k7FJeO5U1RSadlAhtvQgmXxvdV/Wk3uzMRuh64Y0OTt7VB7i2t/Yn/FQoB4SXlOY+DxIkRzbLnOP24JhDp5GPPXaUukxlW1BhRIgasb5+gBP/zQYIJq6alEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429596; c=relaxed/simple;
	bh=WRv08dJtA37NsDtB1lsRF4b5PbrnbFUD+L/laTvP314=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evpBX2YdpxfH/VTcYkPzHouhrEIKfV86jK1329wCrS/HfrUuwoXYmjY/HWj7fU8pMzdr+9YN1S5xlAFEqD+3vmaZVcWqbIxj4/11Wb5PjN0dmIrgxvwGGRqw/576ndPpY3J0wrjebjbb0r0x5aXdXHMnmzeEhm4uARaHKTMJ+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533E4C4CEC7;
	Tue,  8 Oct 2024 23:19:54 +0000 (UTC)
Date: Tue, 8 Oct 2024 19:19:57 -0400
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
Subject: Re: [PATCH v3 2/8] tracing/ftrace: guard syscall probe with
 preempt_notrace
Message-ID: <20241008191957.6cb66fa2@gandalf.local.home>
In-Reply-To: <20241004145818.1726671-3-mathieu.desnoyers@efficios.com>
References: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
	<20241004145818.1726671-3-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 10:58:12 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> +		      PARAMS(assign), PARAMS(print))			\
> +static notrace void							\
> +trace_event_raw_event_##call(void *__data, proto)			\
> +{									\
> +	guard(preempt_notrace)();					\
> +	do_trace_event_raw_event_##call(__data, args);			\
> +}
> +

Do we really need to use "guard()" for a single line function? Why make the
compiler do more work?

static notrace void							\
trace_event_raw_event_##call(void *__data, proto)			\
{									\
	preempt_disable_notrace();					\
	do_trace_event_raw_event_##call(__data, args);			\
	preempt_enable_notrace();					\
}

Is more readable.

-- Steve

