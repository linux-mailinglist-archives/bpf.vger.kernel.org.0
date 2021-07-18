Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699133CCABF
	for <lists+bpf@lfdr.de>; Sun, 18 Jul 2021 23:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhGRVLy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Jul 2021 17:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhGRVLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Jul 2021 17:11:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C7A9610CB;
        Sun, 18 Jul 2021 21:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626642535;
        bh=2sHTaDK96b6V6ONxl3aw1qEZdCfTdIeKBe/6MM8KSuI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uI4sv2/w79v3tu3tVziodOgwV8ERHs1GROHR8SO7VE0rhQyN3WewyZEjrUrAwH/u8
         qIqBN0H7ofrev5MM/N2FXxByI21stckhln9KdpiLbE33PS+BEfZHWjRWjtObaph5n9
         1Skeydwu5/598J9Uf0VPmKxfKBZphdms0nskUBuFTcbtXxhniTciiqvIJM3r2Zi6TQ
         uhyXajJZUr/PdYICAbUSd5Svu9npLfOp48poIz3ifq0RpthJ1ZZfaiG0X/lAGl7TyJ
         ytVJjBsX7Mi36Na5NlRkgdcRxiuFtdWrUs+++CBSKvfGHW/Wp3mCDXP9GB2WiuADoZ
         kwHg0mpWQ1o9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 00FEC5C03DD; Sun, 18 Jul 2021 14:08:54 -0700 (PDT)
Date:   Sun, 18 Jul 2021 14:08:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, apw@canonical.com,
        joe@perches.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        mingo@kernel.org
Subject: Re: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
Message-ID: <20210718210854.GP4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210713005645.8565-1-zhouzhouyi@gmail.com>
 <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <520385500.15226.1626181744332.JavaMail.zimbra@efficios.com>
 <20210713131812.GV4397@paulmck-ThinkPad-P17-Gen-1>
 <20210713151908.GW4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zO6WpaYW33V_Di5naxr1TRm0tokCmTZahDuXmRupxd=A@mail.gmail.com>
 <20210715035149.GI4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2xDNtjZew=Rr7QvEDX7jnVCcE+JFpSDxiQ4yNPUE6kj-g@mail.gmail.com>
 <20210715180941.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2wuWtGAGRqWJb3Gewm5VLZdZ_C=LRZsFbaG3jcQabO3qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2wuWtGAGRqWJb3Gewm5VLZdZ_C=LRZsFbaG3jcQabO3qA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 18, 2021 at 06:03:34AM +0800, Zhouyi Zhou wrote:
> Hi Paul
> During the research, I found a already existing tool to detect
> undefined Kconfig macro:
> scripts/checkkconfigsymbols.py. It is marvellous!

Nice!  Maybe I should add this to torture.sh.

> By invoking ./scripts/checkkconfigsymbols.py > /tmp/log, I found
> following possibly undefined Kconfig macros
> which may need our attention:
> 
> PREEMPT_LOCK
> Referencing files: include/linux/lockdep_types.h

Not sure about this one.  It might be in anticipation of -rt functionality.
Or another typo.

> PREEMT_DYNAMIC
> Referencing files: kernel/entry/common.c

This needs to be PREEMPT_DYNAMIC.  Please CC Frederic Weisbecker and
myself if you send a patch.

> TREE_PREEMPT_RCU
> Referencing files: arch/sh/configs/sdk7786_defconfig

This would have been correct back in the day.  It should now be
CONFIG_PREEMPT_RCU.  Except that the CONFIG_PREEMPT=y in that same
file implies CONFIG_PREEMPT_RCU=y, so best to simply delete the
CONFIG_TREE_PREEMPT_RCU=y line.

> RCU_CPU_STALL_INFO
> Referencing files: arch/xtensa/configs/nommu_kc705_defconfig

You now get RCU_CPU_STALL_INFO whether you want it or not, so this
line should be deleted.

> RCU_NOCB_CPU_ALL
> Referencing files:
> Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst

This is an old snapshot of the code.  One approach would be to
update this from the real rcu_prepare_for_idle() function in
kernel/rcu/tree_plugin.h.  The line numbers in the following paragraph
would need to be updated, but the figure is unaffected.

> RCU_TORTURE_TESTS
> Referencing files: kernel/rcu/rcutorture.c

The final "S" needs to be dropped.

> and finally the macro which drive me to do this research
> 
> TASKS_RCU_TRACE
> Referencing files: include/linux/rcupdate.h, kernel/rcu/tree_plugin.h

The fix for this one is of course already queued.

Please CC me if you decide to create patches.  Otherwise, let me know,
and I can produce fixes.

							Thanx, Paul

> On Fri, Jul 16, 2021 at 2:09 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Jul 15, 2021 at 04:45:04PM +0800, Zhouyi Zhou wrote:
> > > On Thu, Jul 15, 2021 at 11:51 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Wed, Jul 14, 2021 at 12:44:36PM +0800, Zhouyi Zhou wrote:
> > > > > On Tue, Jul 13, 2021 at 11:19 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Jul 13, 2021 at 06:18:12AM -0700, Paul E. McKenney wrote:
> > > > > > > On Tue, Jul 13, 2021 at 09:09:04AM -0400, Mathieu Desnoyers wrote:
> > > > > > > > ----- On Jul 13, 2021, at 12:16 AM, paulmck paulmck@kernel.org wrote:
> > > > > > > >
> > > > > > > > > On Tue, Jul 13, 2021 at 08:56:45AM +0800, zhouzhouyi@gmail.com wrote:
> > > > > > > > >> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > > > > >>
> > > > > > > > >> Hi Paul,
> > > > > > > > >>
> > > > > > > > >> During my studying of RCU, I did a grep in the kernel source tree.
> > > > > > > > >> I found there are 3 places where the macro name CONFIG_TASKS_RCU_TRACE
> > > > > > > > >> should be CONFIG_TASKS_TRACE_RCU instead.
> > > > > > > > >>
> > > > > > > > >> Without memory fencing, the idle/userspace task inspection may not
> > > > > > > > >> be so accurate.
> > > > > > > > >>
> > > > > > > > >> Thanks for your constant encouragement for my studying.
> > > > > > > > >>
> > > > > > > > >> Best Wishes
> > > > > > > > >> Zhouyi
> > > > > > > > >>
> > > > > > > > >> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > > > > >
> > > > > > > > > Good eyes, and those could cause real bugs, so thank you!
> > > > > > > >
> > > > > > > > Hi Paul,
> > > > > > > >
> > > > > > > > This makes me wonder: what is missing testing-wise in rcutorture to
> > > > > > > > catch those issues with testing before they reach mainline ?
> > > > > > >
> > > > > > > My guess:  Running on weakly ordered architectures.  ;-)
> > > > > >
> > > > > > And another guess:  A tool that identifies use of Kconfig options
> > > > > > that are not defined in any Kconfig* file.
> > > > > Based on Paul's second guess ;-),  I did a small research, and I think
> > > > > the best answer is to modify scripts/checkpatch.pl. We modify checkpatch.pl
> > > > > to identify use of Kconfig options that are not defined in any Kconfig* file.
> > > > >
> > > > > As I am a C/C++ programmer, I would be glad to take some time to learn
> > > > > perl (checkpatch is implented in perl) first if no other volunteer is
> > > > > about to do it ;-)
> > > >
> > > > I haven't heard anyone else volunteer.  ;-)
> > > >
> > > > Others might have opinions on where best to implement these checks,
> > > > but I must confess that I have not given it much thought.
> > > I recklessly cc the maintainers of checkpatch.pl without your
> > > permission to see others' opion,
> > > and I begin to study perl at the same time, after all, learning
> > > something is always good ;-)
> >
> > Works for me!
> >
> >                                                         Thanx, Paul
> Best Wishes
> Zhouyi
