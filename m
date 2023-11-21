Return-Path: <bpf+bounces-15540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0C37F3336
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE78C1C21CB1
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8C59174;
	Tue, 21 Nov 2023 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D74779F
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 16:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED2BC433C7;
	Tue, 21 Nov 2023 16:07:38 +0000 (UTC)
Date: Tue, 21 Nov 2023 11:07:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org, Joel Fernandes
 <joel@joelfernandes.org>
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Message-ID: <20231121110753.41dc5603@gandalf.local.home>
In-Reply-To: <dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>
References: <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
	<20231120214742.GC8262@noisy.programming.kicks-ass.net>
	<62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
	<20231120222311.GE8262@noisy.programming.kicks-ass.net>
	<cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
	<20231121084706.GF8262@noisy.programming.kicks-ass.net>
	<a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
	<20231121143647.GI8262@noisy.programming.kicks-ass.net>
	<6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
	<20231121144643.GJ8262@noisy.programming.kicks-ass.net>
	<20231121155256.GN4779@noisy.programming.kicks-ass.net>
	<dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 11:00:13 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > tasks-tracing-rcu:
> >    extention of tasks to have critical-sections ? Should this simply be
> >    tasks?  
> 
> tasks-trace-rcu is meant to allow tasks to block/take a page fault 
> within the read-side. It is specialized for tracing and has a single 
> domain. It does not need the smp_mb on the read-side, which makes it 
> lower-overhead than SRCU.

IOW, task-trace-rcu allows the call to schedule in its critical section,
whereas task-rcu does not?

-- Steve

