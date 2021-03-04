Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E948C32D6C9
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 16:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhCDPgU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 10:36:20 -0500
Received: from netrider.rowland.org ([192.131.102.5]:58445 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234692AbhCDPgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 10:36:05 -0500
Received: (qmail 1613083 invoked by uid 1000); 4 Mar 2021 10:35:24 -0500
Date:   Thu, 4 Mar 2021 10:35:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
Message-ID: <20210304153524.GA1612307@rowland.harvard.edu>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
 <20210303220348.GL2696@paulmck-ThinkPad-P72>
 <20210304032101.GB1594980@rowland.harvard.edu>
 <20210304050407.GN2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304050407.GN2696@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 09:04:07PM -0800, Paul E. McKenney wrote:
> On Wed, Mar 03, 2021 at 10:21:01PM -0500, Alan Stern wrote:
> > On Wed, Mar 03, 2021 at 02:03:48PM -0800, Paul E. McKenney wrote:
> > > On Wed, Mar 03, 2021 at 03:22:46PM -0500, Alan Stern wrote:

> > > > >  And I cannot immediately think of a situation where
> > > > > this approach would break that would not result in a data race being
> > > > > flagged.  Or is this yet another failure of my imagination?
> > > > 
> > > > By definition, an access to a local variable cannot participate in a 
> > > > data race because all such accesses are confined to a single thread.
> > > 
> > > True, but its value might have come from a load from a shared variable.
> > 
> > Then that load could have participated in a data race.  But the store to 
> > the local variable cannot.
> 
> Agreed.  My thought was that if the ordering from the initial (non-local)
> load mattered, then that initial load must have participated in a
> data race.  Is that true, or am I failing to perceive some corner case?

Ordering can matter even when no data race is involved.  Just think
about how much of the memory model is concerned with ordering of
marked accesses, which don't participate in data races unless there is
a conflicting plain access somewhere.

Alan
