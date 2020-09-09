Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E8D263364
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgIIRDR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731221AbgIIRCi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:02:38 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF3F42087C;
        Wed,  9 Sep 2020 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599670957;
        bh=eRbjhZKvbh33MAMmJXvQcD1C4x8vzGNx/yx2NgHAAQg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rDdZxDTdKFJvMSkXxXAOzG8MSUJJXt0T4cV+tXrxIu1kEjfiEspj0HNTvmN8IeEQv
         vJcUP8H/G+SzbImfBr+3AwHHNQMt3IBEmebY3ifMrpgctiPUJMxrrzRx7kUNBZAtXn
         eOncpS3aTP58HIRygtsIWy3tN8uDmFKcxCMCK+M4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6B7E535215BB; Wed,  9 Sep 2020 10:02:37 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:02:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: slow sync rcu_tasks_trace
Message-ID: <20200909170237.GH29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com>
 <20200909113858.GF29330@paulmck-ThinkPad-P72>
 <20200909151053.GF1498025@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909151053.GF1498025@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 05:10:53PM +0200, Jiri Olsa wrote:
> On Wed, Sep 09, 2020 at 04:38:58AM -0700, Paul E. McKenney wrote:
> > On Tue, Sep 08, 2020 at 07:34:20PM -0700, Alexei Starovoitov wrote:
> > > Hi Paul,
> > > 
> > > Looks like sync rcu_tasks_trace got slower or we simply didn't notice
> > > it earlier.
> > > 
> > > In selftests/bpf try:
> > > time ./test_progs -t trampoline_count
> > > #101 trampoline_count:OK
> > > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > > 
> > > real    1m17.082s
> > > user    0m0.145s
> > > sys    0m1.369s
> > > 
> > > But with the following hack:
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index 7dd523a7e32d..c417b817ec5d 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -217,7 +217,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
> > >          * programs finish executing.
> > >          * Wait for these two grace periods together.
> > >          */
> > > -       synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
> > > +//     synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
> > > 
> > > I see:
> > > time ./test_progs -t trampoline_count
> > > #101 trampoline_count:OK
> > > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > > 
> > > real    0m1.588s
> > > user    0m0.131s
> > > sys    0m1.342s
> > > 
> > > It takes an extra minute to do 40 sync rcu_tasks_trace calls.
> > > It means that every sync takes more than a second.
> > > That feels excessive.
> > > 
> > > Doing:
> > > -       synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
> > > +       synchronize_rcu();
> > > is also fast:
> > > time ./test_progs -t trampoline_count
> > > #101 trampoline_count:OK
> > > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > > 
> > > real    0m2.089s
> > > user    0m0.139s
> > > sys    0m1.282s
> > > 
> > > sync rcu_tasks() is fast too:
> > > -       synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
> > > +       synchronize_rcu_tasks();
> > > time ./test_progs -t trampoline_count
> > > #101 trampoline_count:OK
> > > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > > 
> > > real    0m2.209s
> > > user    0m0.117s
> > > sys    0m1.344s
> > > 
> > > so it's really something going on with sync rcu_tasks_trace.
> > > Could you please take a look?
> > 
> > I am guessing that your .config has CONFIG_TASKS_TRACE_RCU_READ_MB=n.
> > If I am wrong, please try CONFIG_TASKS_TRACE_RCU_READ_MB=y.
> 
> hi,
> I noticed the slowdown as well, and adding CONFIG_TASKS_TRACE_RCU_READ_MB=y
> speeds it up for me

Thank you for testing this!  This will most likley also degrade read-side
performance beyond what is reasonable.  So could you please also try
the kernel boot parameter called out below?

Nevertheless, the fact that this fixes things does mean that a solution
exists.  Now to close in on it.  ;-)

(For example, it might be necessary to provide per-flavor tasklist
scan backoffs and/or it might be necessary to adjust the default for
rcupdate.rcu_task_ipi_delay=50.)

							Thanx, Paul

> thanks,
> jirka
> 
> > 
> > Otherwise (or alternatively), could you please try booting with
> > rcupdate.rcu_task_ipi_delay=50?  The default value is 500, or half a
> > second on a HZ=1000 system, which on a busy system could easily result
> > in the grace-period delays that you are seeing.  The value of this
> > kernel boot parameter does interact with the tasklist-scan backoffs,
> > so its effect will not likely be linear.
> > 
> > Do either of those approaches help?
> > 
> > 							Thanx, Paul
> > 
> 
