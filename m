Return-Path: <bpf+bounces-15528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463067F315B
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 15:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F1B281E91
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D38655C1A;
	Tue, 21 Nov 2023 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC3456743
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 14:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5174C433C8;
	Tue, 21 Nov 2023 14:44:29 +0000 (UTC)
Date: Tue, 21 Nov 2023 09:44:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org, Joel Fernandes
 <joel@joelfernandes.org>
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Message-ID: <20231121094444.04701bdc@gandalf.local.home>
In-Reply-To: <20231121143647.GI8262@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
	<20231120205418.334172-2-mathieu.desnoyers@efficios.com>
	<20231120214742.GC8262@noisy.programming.kicks-ass.net>
	<62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
	<20231120222311.GE8262@noisy.programming.kicks-ass.net>
	<cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
	<20231121084706.GF8262@noisy.programming.kicks-ass.net>
	<a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
	<20231121143647.GI8262@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 15:36:47 +0100
Peter Zijlstra <peterz@infradead.org> wrote:
> 
> Still utterly confused about what task-tracing rcu is and how it is
> different from preemptible rcu.

Is this similar to synchronize_rcu_tasks()? As I understand that one (grace
period continues until all tasks have voluntarily scheduled or gone into
user space). But I'm a bit confused by synchronize_rcu_tasks_trace()?

Note, that for syncronize_rcu_tasks() the critical sections must not call
schedule (although it is OK to be preempted).

-- Steve

