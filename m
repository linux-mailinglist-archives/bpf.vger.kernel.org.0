Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93860299827
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 21:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389152AbgJZUpD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 16:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389145AbgJZUpD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 16:45:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 406002070E;
        Mon, 26 Oct 2020 20:45:01 +0000 (UTC)
Date:   Mon, 26 Oct 2020 16:44:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Michael Jeanson <mjeanson@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 6/6] tracing: use sched-RCU instead of SRCU for
 rcuidle tracepoints
Message-ID: <20201026164459.1d514d0a@gandalf.local.home>
In-Reply-To: <73192641.37901.1603722487627.JavaMail.zimbra@efficios.com>
References: <20201023195352.26269-1-mjeanson@efficios.com>
        <20201023195352.26269-7-mjeanson@efficios.com>
        <20201023211359.GC3563800@google.com>
        <20201026082010.GC2628@hirez.programming.kicks-ass.net>
        <73192641.37901.1603722487627.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 26 Oct 2020 10:28:07 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I agree with Peter. Removing the trace_.*_rcuidle weirdness from the tracepoint
> API and fixing all callers to ensure they trace from a context where RCU is
> watching would simplify instrumentation of the Linux kernel, thus making it harder
> for subtle bugs to hide and be unearthed only when tracing is enabled. This is

Note, the lockdep RCU checking of a tracepoint is outside of it being
enabled or disable. So if a non rcuidle() tracepoint is in a location that
RCU is not watching, it will complain loudly, even if you don't enable that
tracepoint.

> AFAIU the general approach Thomas Gleixner has been aiming for recently, and I
> think it is a good thing.
> 
> So if we consider this our target, and that the current state of things is that
> we need to have RCU watching around callback invocation, then removing the
> dependency on SRCU seems like an overall simplification which does not regress
> feature-wise nor speed-wise compared with what we have upstream today. The next
> steps would then be to audit all rcuidle tracepoints and make sure the context
> where they are placed has RCU watching already, so we can remove the tracepoint

Just remove the _rcuidle() from them, and lockdep will complain if they are
being called without RCU watching.

-- Steve


> rcuidle API. That would effectively remove the calls to rcu_irq_{enter,exit}_irqson
> from the tracepoint code.
> 
> This is however beyond the scope of the proposed patch set.
> 
> Thanks,
> 
> Mathieu
> 

