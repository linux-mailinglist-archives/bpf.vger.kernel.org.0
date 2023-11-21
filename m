Return-Path: <bpf+bounces-15557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEAF7F3425
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D654B21CF2
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FFF36B11;
	Tue, 21 Nov 2023 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqCUOi35"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29EF8839
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 16:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA5BC433C7;
	Tue, 21 Nov 2023 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700585189;
	bh=LY9xRQ7JdmDXMRG582U6DyHNCMi3KaOSsQGtTke5vAo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IqCUOi35WWq2rNmviBVSnzbjGvfAO+tf3QCsWcTiQp4AZOHunoRJtfT7KvtCp23hI
	 B6DV2bZzzN7+y6OakH7MB/Ih48KO23fGFEJjxbC6A4QsFLPuHYLrQvHJl8AmeCenSZ
	 zUekNkAX3E5wdpEDeTqLCZTFoRkKM/ueCpL1q/zEqjt9UEap7idMRGsCTrGSna12fI
	 E0hQpX2C+DC11lrCzN03OfE3jpqIehwfCJKPug7wgZ8WFd3keNkQBSgbceHu6k4WTb
	 u1bbzMHVpxR3rCcep8tTlCFGLIkFNC8jgGzCWmvztbejvAAn/LQglXKeQ7L9g4J/qO
	 Uv1vwOmAt8ciw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C678BCE04C0; Tue, 21 Nov 2023 08:46:28 -0800 (PST)
Date: Tue, 21 Nov 2023 08:46:28 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Message-ID: <017aff1d-70cc-4c0c-a05c-aad4329068e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <2a41f6cd-971d-4360-aeeb-a9cbf665bb72@paulmck-laptop>
 <20231121160300.GK8262@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121160300.GK8262@noisy.programming.kicks-ass.net>

On Tue, Nov 21, 2023 at 05:03:00PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 21, 2023 at 07:58:40AM -0800, Paul E. McKenney wrote:
> 
> > Tasks Trace RCU allows general blocking in its readers, not just the
> > subject-to-priority-boosting blocking permitted within preemptible RCU
> > readers.  Restrictions on the use of Tasks Trace RCU are in place to allow
> > getting away with this general blocking.  Even systems generously endowed
> > with memory are not going to do well when the RCU grace period is blocked
> > on I/O, especially if that I/O is across a network to a slow file server.
> > 
> > Which means a separate RCU instance is needed.  Which is Tasks Trace RCU.
> 
> Separate instance not a problem, nor really the question.
> 
> What is the basic mechanism of task-tracing? Is it really the existing
> tasks-rcu extended with read-side critical sections and call_rcu ?
> 
> If so, then why not have it be tasks-rcu?
> 
> Or is it a variant of the preemptible/SRCU class of RCUs that are
> counter-array based? I suspect not.
> 
> So once again, what exactly is tasks-tracing ?

I think we covered this elsewhere in the thread, but if there are
lingering questions, you know where to find us.  ;-)

							Thanx, Paul

