Return-Path: <bpf+bounces-11288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D637B7B6FD9
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 19:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 7CAB1B208B7
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432683B2AC;
	Tue,  3 Oct 2023 17:33:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E42942C
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 17:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5A6C433C7;
	Tue,  3 Oct 2023 17:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696354414;
	bh=rzlml4twXPG1yYnrvCDoBzosHm5mKs/NlXodh5FZlzE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mZ7tRiqHLm4DAf/mBnMc9s1/fADt+ai33WM5iWk8D0gFiyHfAwx+x8yjJkFHfCQRo
	 SKj4h5P5fZ9Hl2iYplfWNA/QvZYUuJow6xe+XW1xi9vCjo0nP2sP8AZGFhzJgZ/AAX
	 twidMdGNTwP8HwZHDx5gpkmQrrbiARndi5uIJZiOJIzZg8i/L58vVLcTtmb9xVAbE/
	 KQwm837497ZXJtiz3mJZkwXww00yJvztrel+Lbc210+0VlKKN0fY9fIJuj14XXcFHr
	 N1viKd7SQ2bLIDmqhhF77onBmFoajPywZRSFInsXg07Gp0eiXyZKWRX2ezbO844UfF
	 86LtoYbkcpN4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CEA1ACE1104; Tue,  3 Oct 2023 10:33:33 -0700 (PDT)
Date: Tue, 3 Oct 2023 10:33:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH v3 1/5] tracing: Introduce faultable tracepoints (v3)
Message-ID: <99ec6025-c170-459c-8b43-58cf1a85f832@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
 <20231002202531.3160-2-mathieu.desnoyers@efficios.com>
 <20231002191023.6175294d@gandalf.local.home>
 <97c559c9-51cf-415c-8b0b-39eba47b8898@paulmck-laptop>
 <20231002211936.5948253e@gandalf.local.home>
 <5d0771e9-332c-42cd-acf3-53d46bb691f3@paulmck-laptop>
 <20231003100854.7285d2a9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003100854.7285d2a9@gandalf.local.home>

On Tue, Oct 03, 2023 at 10:08:54AM -0400, Steven Rostedt wrote:
> On Tue, 3 Oct 2023 06:44:50 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > That way it is clear what uses what, as I read the original paragraph a
> > > couple of times and could have sworn that rcu_read_lock_trace() required
> > > tasks to not block.  
> > 
> > That would work for me.  Would you like to send a patch, or would you
> > rather we made the adjustments?
> 
> Which ever.

OK, how about like this?

							Thanx, Paul

------------------------------------------------------------------------

commit 973eb79ec46c16f13bb5b47ad14d44a1f1c79dc9
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Oct 3 10:30:01 2023 -0700

    doc: Clarify RCU Tasks reader/updater checklist
    
    Currently, the reader/updater compatibility rules for the three RCU
    Tasks flavors are squished together in a single paragraph, which can
    result in confusion.  This commit therefore splits them out into a list,
    clearly showing the distinction between these flavors.
    
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index bd3c58c44bef..c432899aff22 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -241,15 +241,22 @@ over a rather long period of time, but improvements are always welcome!
 	srcu_struct.  The rules for the expedited RCU grace-period-wait
 	primitives are the same as for their non-expedited counterparts.
 
-	If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
-	then the readers must refrain from executing voluntary
-	context switches, that is, from blocking.  If the updater uses
-	call_rcu_tasks_trace() or synchronize_rcu_tasks_trace(), then
-	the corresponding readers must use rcu_read_lock_trace() and
-	rcu_read_unlock_trace().  If an updater uses call_rcu_tasks_rude()
-	or synchronize_rcu_tasks_rude(), then the corresponding readers
-	must use anything that disables preemption, for example,
-	preempt_disable() and preempt_enable().
+	Similarly, it is necssary to correctly use the RCU Tasks flavors:
+
+	a.	If the updater uses synchronize_rcu_tasks() or
+		call_rcu_tasks(), then the readers must refrain from
+		executing voluntary context switches, that is, from
+		blocking.
+
+	b.	If the updater uses call_rcu_tasks_trace()
+		or synchronize_rcu_tasks_trace(), then the
+		corresponding readers must use rcu_read_lock_trace()
+		and rcu_read_unlock_trace().
+
+	c.	If an updater uses call_rcu_tasks_rude() or
+		synchronize_rcu_tasks_rude(), then the corresponding
+		readers must use anything that disables preemption,
+		for example, preempt_disable() and preempt_enable().
 
 	Mixing things up will result in confusion and broken kernels, and
 	has even resulted in an exploitable security issue.  Therefore,

