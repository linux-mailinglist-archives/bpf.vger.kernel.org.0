Return-Path: <bpf+bounces-42994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F199AD98C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8281F225B0
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E5A136E3F;
	Thu, 24 Oct 2024 02:05:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B7EEA6;
	Thu, 24 Oct 2024 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729735558; cv=none; b=k8cwKWYnbjJIFcHdBTrZ5WIE/cv3Gw9IyO0awQo2cPHs1j+qReCAedsCKM5NzlH/dwZdvkrTbt3x1WD0FeD4GnaEt1e2A5/G6qzKtE1jfCddAl7zYyDPJ/mi8ys1HQUC5VL200Oo1HUU12fZScMPaRl5k2NhzM4N5KRDJ4WdARE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729735558; c=relaxed/simple;
	bh=zojUPKo/a2Phs/uz9NZlQQm+PJPQVy1ZnEjHsf0HTb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsNpO9mWkMVxOSGKxyFu8veeq9xlE3SwxC8zhTL854+5V/bMX3P177TKU4nJY7s972YsI143lbKHs8p14gMySPSzDI+esvybTPQqP5M0bNo8G6sXDL9h10dWhjUIk3PzDr9pgEYrYU4oIjDlIONm0fNdDvVwF6FBywFyrA5Zj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9805DC4CEC6;
	Thu, 24 Oct 2024 02:05:55 +0000 (UTC)
Date: Wed, 23 Oct 2024 22:05:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jordan Rife
 <jrife@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf
 <bpf@vger.kernel.org>, Joel Fernandes <joel@joelfernandes.org>, LKML
 <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Michael
 Jeanson <mjeanson@efficios.com>, Namhyung Kim <namhyung@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, Yonghong Song
 <yhs@fb.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
Message-ID: <20241023220552.74ca0c3e@rorschach.local.home>
In-Reply-To: <7bcea009-b58c-4a00-b7cd-f2fc06b90a02@efficios.com>
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
	<20241023145640.1499722-1-jrife@google.com>
	<CAADnVQJupBceq2DAeChBvdjSG4zOpYsMP7_o7gREVmVCA0PUYQ@mail.gmail.com>
	<7bcea009-b58c-4a00-b7cd-f2fc06b90a02@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 11:19:40 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > Looks like Mathieu patch broke bpf program contract somewhere.  
> 
> My patch series introduced this in the probe:
> 
> #define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args)                  \
> static notrace void                                                     \
> __bpf_trace_##call(void *__data, proto)                                 \
> {                                                                       \
>          might_fault();                                                  \
>          preempt_disable_notrace();                                      \

Is the problem that we can call this function *after* the prog has been
freed? That is, the preempt_disable_notrace() here is meaningless.

Is there a way to add something here to make sure the program is still
valid? Like set a flag in the link structure?

(I don't know how BPF works well enough to know what is involved here,
so excuse me if this is totally off)

-- Steve


>          CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));        \
>          preempt_enable_notrace();                                       \
> }
> 

