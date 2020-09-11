Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE90265867
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 06:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgIKEhS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 00:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgIKEhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 00:37:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E00B221E7;
        Fri, 11 Sep 2020 04:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599799030;
        bh=JoKwh3qJRTbkpXb29zLQsepECW/mXTdadxrZ5Cy/rWU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sMmGkDvVrjiz4rR868arhRuUIpkNr7QfTtdszWewk1mHMDVPYU0SvtkVrIi0YzRMU
         eupPSaIYpZbxuBOIr8PKtAnDb30LSbuf09BaiTdSAt76tMNRNpjtohPHTJ5B7Fd42D
         hUmTHqi4ojct/WE85x3D9UBqtLZ8gzYnPsVgQ6nE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F09BB3522DD2; Thu, 10 Sep 2020 21:37:09 -0700 (PDT)
Date:   Thu, 10 Sep 2020 21:37:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, dipankar@in.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC tip/core/rcu 4/4] rcu-tasks: Shorten per-grace-period
 sleep for RCU Tasks Trace
Message-ID: <20200911043709.GV29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200910201956.GA24190@paulmck-ThinkPad-P72>
 <20200910202052.5073-4-paulmck@kernel.org>
 <CAADnVQK4Rgrzq+cUKCMkr5anZF+UbHmAc7-FH4BjA23aMM03rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK4Rgrzq+cUKCMkr5anZF+UbHmAc7-FH4BjA23aMM03rQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 08:18:01PM -0700, Alexei Starovoitov wrote:
> On Thu, Sep 10, 2020 at 1:20 PM <paulmck@kernel.org> wrote:
> >
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > The various RCU tasks flavors currently wait 100 milliseconds between each
> > grace period in order to prevent CPU-bound loops and to favor efficiency
> > over latency.  However, RCU Tasks Trace needs to have a grace-period
> > latency of roughly 25 milliseconds, which is completely infeasible given
> > the 100-millisecond per-grace-period sleep.  This commit therefore reduces
> > this sleep duration to 5 milliseconds (or one jiffy, whichever is longer)
> > in kernels built with CONFIG_TASKS_TRACE_RCU_READ_MB=y.
> 
> The commit log is either misleading or wrong?
> If I read the code correctly in CONFIG_TASKS_TRACE_RCU_READ_MB=y
> case the existing HZ/10 "paranoid sleep" is preserved.

Yes, for CONFIG_TASKS_TRACE_RCU_READ_MB=y, the previous 100-millisecond
"paranoid sleep" is preserved.  Preserving previous behavior is of course
especially important for rcupdate.rcu_task_ipi_delay, given that real-time
applications are degraded by IPIs.  And given that we are avoiding IPIs
in this case, speeding up the polling is not all that helpful.

> It's for the MB=n case it is reduced to HZ/200.

Yes, that is, to roughly 5 milliseconds for large HZ or to one jiffy
for HZ<200.  Here, we send IPIs much more aggressively, so polling
more frequently does help a lot.

> Also I don't understand why you're talking about milliseconds but
> all numbers are HZ based. HZ/10 gives different number of
> milliseconds depending on HZ.

As long as HZ is 10 or greater, HZ/10 jiffies is roughly 100 milliseconds.
In the unlikely event that HZ is less than 10, the code clamps to one
jiffy.  Since schedule_timeout_idle() sleep time is specified in jiffies,
it all works out.

							Thanx, Paul
