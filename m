Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2059D264DD2
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 20:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgIJSxS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 14:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgIJSvy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 14:51:54 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8F4F2087C;
        Thu, 10 Sep 2020 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599763909;
        bh=IyzcyPWtwQfIQTuMPX0yDlWdJqSVJdZSD67744Pcuv4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VTYJEoq5Y5hxjg1PGTRraBkrmAiMfRRY+tiZbCvjK2716Y/t56Hsby52Fnun8gUxm
         Cj035KYEOvrd584owoOY7R8bHxV2FwAq3vnIfIvekPNvadAMYaCYHokKOa5v11ChZU
         kon1ldgjTpK87OuhT5Z3nU9w/n6kN01Dybpge2mg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 68BEE3523080; Thu, 10 Sep 2020 11:51:49 -0700 (PDT)
Date:   Thu, 10 Sep 2020 11:51:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: slow sync rcu_tasks_trace
Message-ID: <20200910185149.GR29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200909113858.GF29330@paulmck-ThinkPad-P72>
 <20200909171228.dw7ra5mkmvqrvptp@ast-mbp.dhcp.thefacebook.com>
 <20200909173512.GI29330@paulmck-ThinkPad-P72>
 <20200909180418.hlivoaekhkchlidw@ast-mbp.dhcp.thefacebook.com>
 <20200909193900.GK29330@paulmck-ThinkPad-P72>
 <20200909194828.urz6islrqajifukj@ast-mbp.dhcp.thefacebook.com>
 <20200909210447.GL29330@paulmck-ThinkPad-P72>
 <20200909212212.GA21795@paulmck-ThinkPad-P72>
 <20200910052727.GA4351@paulmck-ThinkPad-P72>
 <619554b2-4746-635e-22f3-7f0f09d97760@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <619554b2-4746-635e-22f3-7f0f09d97760@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 11:33:58AM -0700, Alexei Starovoitov wrote:
> On 9/9/20 10:27 PM, Paul E. McKenney wrote:
> > On Wed, Sep 09, 2020 at 02:22:12PM -0700, Paul E. McKenney wrote:
> > > On Wed, Sep 09, 2020 at 02:04:47PM -0700, Paul E. McKenney wrote:
> > > > On Wed, Sep 09, 2020 at 12:48:28PM -0700, Alexei Starovoitov wrote:
> > > > > On Wed, Sep 09, 2020 at 12:39:00PM -0700, Paul E. McKenney wrote:
> > 
> > [ . . . ]
> > 
> > > > > > My plan is to try the following:
> > > > > > 
> > > > > > 1.	Parameterize the backoff sequence so that RCU Tasks Trace
> > > > > > 	uses faster rechecking than does RCU Tasks.  Experiment as
> > > > > > 	needed to arrive at a good backoff value.
> > > > > > 
> > > > > > 2.	If the tasks-list scan turns out to be a tighter bottleneck
> > > > > > 	than the backoff waits, look into parallelizing this scan.
> > > > > > 	(This seems unlikely, but the fact remains that RCU Tasks
> > > > > > 	Trace must do a bit more work per task than RCU Tasks.)
> > > > > > 
> > > > > > 3.	If these two approaches, still don't get the update-side
> > > > > > 	latency where it needs to be, improvise.
> > > > > > 
> > > > > > The exact path into mainline will of course depend on how far down this
> > > > > > list I must go, but first to get a solution.
> > > > > 
> > > > > I think there is a case of 4. Nothing is inside rcu_trace critical section.
> > > > > I would expect single ipi would confirm that.
> > > > 
> > > > Unless the task moves, yes.  So a single IPI should suffice in the
> > > > common case.
> > > 
> > > And what I am doing now is checking code paths.
> > 
> > And the following diff from a set of three patches gets my average
> > RCU Tasks Trace grace-period latencies down to about 20 milliseconds,
> > almost a 50x improvement from earlier today.
> > 
> > These are still quite rough and not yet suited for production use, but
> > I will be testing.  If that goes well, I hope to send a more polished
> > set of patches by end of day tomorrow, Pacific Time.  But if you get a
> > chance to test them, I would value any feedback that you might have.
> > 
> > These patches do not require hand-tuning, they instead adjust the
> > behavior according to CONFIG_TASKS_TRACE_RCU_READ_MB, which in turn
> > adjusts according to CONFIG_PREEMPT_RT.  So you should get the desired
> > latency reductions "out of the box", again, without tuning.
> 
> Great. Confirming improvement :)
> 
> time ./test_progs -t trampoline_count
> #101 trampoline_count:OK
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> real	0m2.897s
> user	0m0.128s
> sys	0m1.527s
> 
> This is without CONFIG_TASKS_TRACE_RCU_READ_MB, of course.

Good to hear, thank you!

or is more required?  I can tweak to get more.  There is never a free
lunch, though, and in this case the downside of further tweaking would
be greater CPU overhead.  Alternatively, I could just as easily tweak
it to be slower, thereby reducing the CPU overhead.

If I don't hear otherwise, I will assume that the current settings
work fine.

Of course, if people start removing thousands of BPF programs at one go,
I suspect that it will be necessary to provide a bulk-removal operation,
similar to some of the bulk-configuration-change operations provided by
networking.  The idea is to have a single RCU Tasks Trace grace period
cover all of the thousands of BPF removal operations.

							Thanx, Paul
