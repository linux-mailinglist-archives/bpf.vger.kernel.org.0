Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD97D3CA4F6
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 20:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhGOSMf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 14:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231970AbhGOSMf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 14:12:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1CF261289;
        Thu, 15 Jul 2021 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626372581;
        bh=irYZePOTsExTG/YVIdVkIAar0SBLVHgC4JlvhEGcTYM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KfQvT4hXs224Ib9VRB9q9scjEWH9IsguwjBLktw+UVs7tAP147CHJSHqEBakacb0c
         YeqCzwuUpgrWccEAE+0qT7VKNk6lFQfobuDZXrtrWVKJPdVhY5i5FHRcyRhSy9po8Z
         CtdX2A9oVkGhdINpS0xUftPv96dO+Cj0yG0vjNl0mBoulg48PTsRLqtr6YXPv8mCky
         s7iYlkORJM0Lfv8/NEh84970FleRBbn0nk2Y+VA8uROC31a4GJfgAZL2/yDUBPi+fA
         nyPR8ujtLUrGKhZqPfHpDj67Og5CXbPABy1c3Zg9CI/5m0fJFVJHzc3IU67hYgh3Pl
         OULrUwiG3gJ8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7FDD95C0373; Thu, 15 Jul 2021 11:09:41 -0700 (PDT)
Date:   Thu, 15 Jul 2021 11:09:41 -0700
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
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
Message-ID: <20210715180941.GK4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210713005645.8565-1-zhouzhouyi@gmail.com>
 <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <520385500.15226.1626181744332.JavaMail.zimbra@efficios.com>
 <20210713131812.GV4397@paulmck-ThinkPad-P17-Gen-1>
 <20210713151908.GW4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zO6WpaYW33V_Di5naxr1TRm0tokCmTZahDuXmRupxd=A@mail.gmail.com>
 <20210715035149.GI4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2xDNtjZew=Rr7QvEDX7jnVCcE+JFpSDxiQ4yNPUE6kj-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2xDNtjZew=Rr7QvEDX7jnVCcE+JFpSDxiQ4yNPUE6kj-g@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 15, 2021 at 04:45:04PM +0800, Zhouyi Zhou wrote:
> On Thu, Jul 15, 2021 at 11:51 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Jul 14, 2021 at 12:44:36PM +0800, Zhouyi Zhou wrote:
> > > On Tue, Jul 13, 2021 at 11:19 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Tue, Jul 13, 2021 at 06:18:12AM -0700, Paul E. McKenney wrote:
> > > > > On Tue, Jul 13, 2021 at 09:09:04AM -0400, Mathieu Desnoyers wrote:
> > > > > > ----- On Jul 13, 2021, at 12:16 AM, paulmck paulmck@kernel.org wrote:
> > > > > >
> > > > > > > On Tue, Jul 13, 2021 at 08:56:45AM +0800, zhouzhouyi@gmail.com wrote:
> > > > > > >> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > > >>
> > > > > > >> Hi Paul,
> > > > > > >>
> > > > > > >> During my studying of RCU, I did a grep in the kernel source tree.
> > > > > > >> I found there are 3 places where the macro name CONFIG_TASKS_RCU_TRACE
> > > > > > >> should be CONFIG_TASKS_TRACE_RCU instead.
> > > > > > >>
> > > > > > >> Without memory fencing, the idle/userspace task inspection may not
> > > > > > >> be so accurate.
> > > > > > >>
> > > > > > >> Thanks for your constant encouragement for my studying.
> > > > > > >>
> > > > > > >> Best Wishes
> > > > > > >> Zhouyi
> > > > > > >>
> > > > > > >> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > > >
> > > > > > > Good eyes, and those could cause real bugs, so thank you!
> > > > > >
> > > > > > Hi Paul,
> > > > > >
> > > > > > This makes me wonder: what is missing testing-wise in rcutorture to
> > > > > > catch those issues with testing before they reach mainline ?
> > > > >
> > > > > My guess:  Running on weakly ordered architectures.  ;-)
> > > >
> > > > And another guess:  A tool that identifies use of Kconfig options
> > > > that are not defined in any Kconfig* file.
> > > Based on Paul's second guess ;-),  I did a small research, and I think
> > > the best answer is to modify scripts/checkpatch.pl. We modify checkpatch.pl
> > > to identify use of Kconfig options that are not defined in any Kconfig* file.
> > >
> > > As I am a C/C++ programmer, I would be glad to take some time to learn
> > > perl (checkpatch is implented in perl) first if no other volunteer is
> > > about to do it ;-)
> >
> > I haven't heard anyone else volunteer.  ;-)
> >
> > Others might have opinions on where best to implement these checks,
> > but I must confess that I have not given it much thought.
> I recklessly cc the maintainers of checkpatch.pl without your
> permission to see others' opion,
> and I begin to study perl at the same time, after all, learning
> something is always good ;-)

Works for me!

							Thanx, Paul
