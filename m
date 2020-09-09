Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327422634BA
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgIIRfR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgIIRfN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:35:13 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB82206D4;
        Wed,  9 Sep 2020 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599672912;
        bh=HKmgrgnGwLFMWPSLql0BhC5KjrH9Wszf7SZEhwcXmNE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Fo4xy3GEQrcwnQAISSYZvx3ofK0z8i524PyN9EzfXFCnFHzOq3c+VAu5YF052ZJ6G
         NbhoZKgTloTgmNb+6z7Db/qRsoy3DWjXx0k2yQjQCiQUHixbneyvXfIa63jtKj74BL
         7yEnqRhQN5g35+X+SVKfWbVmnePkduobFBEUdVKw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 977FF35215BB; Wed,  9 Sep 2020 10:35:12 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:35:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: slow sync rcu_tasks_trace
Message-ID: <20200909173512.GI29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com>
 <20200909113858.GF29330@paulmck-ThinkPad-P72>
 <20200909171228.dw7ra5mkmvqrvptp@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909171228.dw7ra5mkmvqrvptp@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 10:12:28AM -0700, Alexei Starovoitov wrote:
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
> > > so it's really something going on with sync rcu_tasks_trace.
> > > Could you please take a look?
> > 
> > I am guessing that your .config has CONFIG_TASKS_TRACE_RCU_READ_MB=n.
> > If I am wrong, please try CONFIG_TASKS_TRACE_RCU_READ_MB=y.
> 
> I've added
> CONFIG_RCU_EXPERT=y
> CONFIG_TASKS_TRACE_RCU_READ_MB=y
> 
> and it helped:
> 
> time ./test_progs -t trampoline_count
> #101 trampoline_count:OK
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> real	0m8.924s
> user	0m0.138s
> sys	0m1.408s
> 
> But this is still bad. It's 4 times slower vs rcu_tasks
> and isn't really usable for bpf, since it adds memory barriers exactly
> where we need them removed.
> 
> In the default configuration rcu_tasks_trace is 40! times slower than rcu_tasks.
> This huge difference in sync times concerns me a lot.
> If bpf has to use memory barriers in rcu_read_lock_trace
> and still be 4 times slower than rcu_tasks in the best case
> then there is no much point in rcu_tasks_trace.
> Converting everything to srcu would be better, but I really hope
> you can find a solution to this tasks_trace issue.
> 
> > Otherwise (or alternatively), could you please try booting with
> > rcupdate.rcu_task_ipi_delay=50?  The default value is 500, or half a
> > second on a HZ=1000 system, which on a busy system could easily result
> > in the grace-period delays that you are seeing.  The value of this
> > kernel boot parameter does interact with the tasklist-scan backoffs,
> > so its effect will not likely be linear.
> 
> The tests were run on freshly booted VM with 4 cpus. The VM is idle.
> The host is idle too.
> 
> Adding rcupdate.rcu_task_ipi_delay=50 boot param sort-of helped:
> time ./test_progs -t trampoline_count
> #101 trampoline_count:OK
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> real	0m25.890s
> user	0m0.124s
> sys	0m1.507s
> It is still awful.
> 
> >From "perf report" there is little time spend in the kernel. The kernel is
> waiting on something. I thought in theory the rcu_tasks_trace should have been
> faster on update side vs rcu_tasks ? Could it be a bug somewhere and some
> missing wakeup? It doesn't feel that it works as intended. Whatever it is
> please try to reproduce it to remove me as a middle man.

On it.

To be fair, I was designing for a nominal one-second grace period,
which was also the rough goal for rcu_tasks.

When do you need this by?

Left to myself, I will aim for the merge window after the upcoming one,
and then backport to the prior -stable versions having RCU tasks trace.

							Thanx, Paul
