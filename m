Return-Path: <bpf+bounces-15556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB307F3420
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5003282352
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E119A2747B;
	Tue, 21 Nov 2023 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHQiSuLn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8B46A5
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 16:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DE9C433C7;
	Tue, 21 Nov 2023 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700585123;
	bh=CVDzwk2jOwJs7kMN49WDpMFr6C+98fD/I20HgAUdANs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MHQiSuLnKg9dTv0kiPb8jRhdzMqGsLGn3guLJLdm2tSBpfm93sCH8VqvrzQJRBzVR
	 no2JwCfSyiYFXRUFOdfm0+OHmlTUXDMuel2hck2JDHNy+aa5Dzh1Oq47Ec8D5qK+oC
	 OruacyS4lcIIRMsaGXknxlAy1em6O5O+yvpiYFiuAYc2yYCER2Rx8XnUECA2m8Wgvd
	 H1rzrSHtpf05heCPTxZiLMsMTsggP76kJmw5Lpc0Cn6eLRFOAnTHuhT9U9HrtPs9eU
	 ZCqhX6IdLdfhkp6Xd5JNNTMJMAXHizavjBzYvOpbvUYKOUdB7on0EjlgwJs7rn4uTn
	 ocFzgh5Px9Duw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BDC4FCE04C0; Tue, 21 Nov 2023 08:45:22 -0800 (PST)
Date: Tue, 21 Nov 2023 08:45:22 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Message-ID: <fc50b15e-8ad1-4ed5-b833-fd3b72c0aa0e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <20231121094444.04701bdc@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121094444.04701bdc@gandalf.local.home>

On Tue, Nov 21, 2023 at 09:44:44AM -0500, Steven Rostedt wrote:
> On Tue, 21 Nov 2023 15:36:47 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > Still utterly confused about what task-tracing rcu is and how it is
> > different from preemptible rcu.
> 
> Is this similar to synchronize_rcu_tasks()? As I understand that one (grace
> period continues until all tasks have voluntarily scheduled or gone into
> user space). But I'm a bit confused by synchronize_rcu_tasks_trace()?
> 
> Note, that for syncronize_rcu_tasks() the critical sections must not call
> schedule (although it is OK to be preempted).

The synchronize_rcu_tasks() and synchronize_rcu_tasks_trace() functions
are quite different, as noted elsewhere in this thread.

							Thanx, Paul

