Return-Path: <bpf+bounces-15419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183C57F2012
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78411B218F6
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00F39861;
	Mon, 20 Nov 2023 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXHw+2jf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D3F39856
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 22:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001D1C433C8;
	Mon, 20 Nov 2023 22:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700518710;
	bh=v2fsGHVEGuyqEdKhN4nMdFZDEWOtc3k1ozVbwEQWDag=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FXHw+2jf2R1fAf8voab217Rs0FGaYJj5HJ7K8DPo3f8+VyEt2cCONWErgAW9tQRka
	 01ccqAvjrCvjJtvPgYCAOsjoV8Fp/JJBAzA7nVE6XnG7ZVKwLc1+vQmg5Z+Mi9GQ1a
	 hmBrzVzp/gHL1cuOHUg/MtInbqHDXBdaI8dqzREErwqSs/62KiefWliLTbTsDOH8nC
	 SS7/F/188D7bnjj/IXhPzQXORuIUBD1SH/VUYlhhFQzmjBGA6oXPWdMx9GD+j2Aqmv
	 Sv555YamQ7o9wef+VMT3WyuuOQJ/KZjpGsRirw2dh+5JN/NeHq75BKnJPTvwcVGQ5T
	 2hSmucLiMNBig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 71A8BCE1ABD; Mon, 20 Nov 2023 14:18:29 -0800 (PST)
Date: Mon, 20 Nov 2023 14:18:29 -0800
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
Message-ID: <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120214742.GC8262@noisy.programming.kicks-ass.net>

On Mon, Nov 20, 2023 at 10:47:42PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 20, 2023 at 03:54:14PM -0500, Mathieu Desnoyers wrote:
> > When invoked from system call enter/exit instrumentation, accessing
> > user-space data is a common use-case for tracers. However, tracepoints
> > currently disable preemption around iteration on the registered
> > tracepoint probes and invocation of the probe callbacks, which prevents
> > tracers from handling page faults.
> > 
> > Extend the tracepoint and trace event APIs to allow defining a faultable
> > tracepoint which invokes its callback with preemption enabled.
> > 
> > Also extend the tracepoint API to allow tracers to request specific
> > probes to be connected to those faultable tracepoints. When the
> > TRACEPOINT_MAY_FAULT flag is provided on registration, the probe
> > callback will be called with preemption enabled, and is allowed to take
> > page faults. Faultable probes can only be registered on faultable
> > tracepoints and non-faultable probes on non-faultable tracepoints.
> > 
> > The tasks trace rcu mechanism is used to synchronize read-side
> > marshalling of the registered probes with respect to faultable probes
> > unregistration and teardown.
> 
> What is trace-trace rcu and why is it needed here? What's wrong with
> SRCU ?

Tasks Trace RCU avoids SRCU's full barriers and the array accesses in the
read-side primitives.  This can be important when tracing low-overhead
components of fast paths.

							Thanx, Paul

